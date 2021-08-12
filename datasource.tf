# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# datasource.tf
#
# Purpose: The following script defines the lookup logic used in code to obtain pre-created or JIT-created resources in tenancy.

/********** Compartment and CF Accessors **********/
data "oci_identity_compartments" "COMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.oke_cluster_compartment_name]
  }
}


data "oci_identity_compartments" "NWCOMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.oke_network_compartment_name]
  }
}

data "oci_core_vcns" "VCN" {
  compartment_id = data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0].id
}

/********** Subnet Accessors **********/
data "oci_core_subnets" "NODEPOOLSUBNET" {
  compartment_id = local.nw_compartment_id
  vcn_id         = local.vcn_id
  filter {
    name   = "display_name"
    values = [var.oke_nodepool_network_subnet_name]
  }
}

/********** OKE Cluster Accessors **********/
data "oci_containerengine_clusters" "OKECLUSTERS" {
  compartment_id = local.compartment_id
  filter {
    name   = "name"
    values = [var.oke_cluster_name]
  }
}

data "oci_core_images" "OL79" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
  filter {
    name   = "display_name"
    values = ["^([a-zA-z]+)-([a-zA-z]+)-([\\.0-9]+)-([\\.0-9-]+)$"]
    regex  = true
  }
}

/********** OKE Cluster Accessors **********/

locals {
  # Subnet OCID local accessors
  nodepool_subnet_id = length(data.oci_core_subnets.NODEPOOLSUBNET.subnets) > 0 ? data.oci_core_subnets.NODEPOOLSUBNET.subnets[0].id : null

  # Compartment OCID Local Accessor 
  compartment_id    = lookup(data.oci_identity_compartments.COMPARTMENTS.compartments[0], "id")
  nw_compartment_id = lookup(data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0], "id")
  # VCN OCID Local Accessor
  vcn_id        = data.oci_core_vcns.VCN.virtual_networks[0].id
  node_image_id = data.oci_core_images.OL79.images[0].id

  # OKE Cluster OCID Local Accessor
  oke_id = lookup(data.oci_containerengine_clusters.OKECLUSTERS.clusters[length(data.oci_containerengine_clusters.OKECLUSTERS.clusters) - 1], "id") #This is obtained as follows because the OCID of OKE Cluster will maitain all OCIDS including the ones you deleted. This assures the last one will always be collected

}
