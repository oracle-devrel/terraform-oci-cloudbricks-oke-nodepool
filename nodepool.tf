# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# nodepool.tf
#
# Purpose: The following script defines the creation of an Oracle Kubernetes Engine Cluster
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "oke_node_pool" {
  #Required
  cluster_id         = local.oke_id
  compartment_id     = local.compartment_id
  kubernetes_version = var.k8s_version
  name               = var.node_pool_name
  node_shape         = var.node_pool_shape
  ssh_public_key     = var.ssh_public_is_path ? file(var.ssh_public_key) : var.ssh_public_key
  node_metadata      = var.node_metadata

  node_config_details {
    dynamic "placement_configs" {
      for_each = var.oke_availability_domain_map
      content {
        availability_domain = placement_configs.value
        subnet_id           = local.nodepool_subnet_id
      }
    }
    size = var.number_of_nodes
  }

  node_source_details {
    image_id    = local.node_image_id
    source_type = var.source_type
  }

  timeouts {
    create = "30m"
    delete = "30m"
  }

  dynamic "initial_node_labels" {
    for_each = var.k8s_label_map
    content {
      key   = initial_node_labels.key
      value = initial_node_labels.value
    }
  }

  dynamic "node_shape_config" {
    for_each = var.is_flex_shape ? [1] : []
    content {
      memory_in_gbs = var.nodepool_shape_config_memory_in_gbs
      ocpus         = var.nodepool_shape_config_ocpus
    }
  }
}

