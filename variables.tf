# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# variables.tf
#
# Purpose: The following script defines the lookup logic used in code to obtain pre-created or JIT-created resources in tenancy.

/********** Provider Variables NOT OVERLOADABLE **********/
variable "region" {
  description = "Target region where artifacts are going to be created"
}

variable "tenancy_ocid" {
  description = "OCID of tenancy"
}

variable "user_ocid" {
  description = "User OCID in tenancy. Currently hardcoded to user denny.alquinta@oracle.com"
}

variable "fingerprint" {
  description = "API Key Fingerprint for user_ocid derived from public API Key imported in OCI User config"
}

variable "private_key_path" {
  description = "Private Key Absolute path location where terraform is executed"

}
/********** Provider Variables NOT OVERLOADABLE **********/


/********** SSH Key Variables **********/
variable "ssh_public_is_path" {
  description = "Describes if SSH Public Key is located on file or inside code"
  default     = false
}

variable "ssh_private_is_path" {
  description = "Describes if SSH Private Key is located on file or inside code"
  default     = false
}

variable "ssh_public_key" {
  description = "Defines SSH Public Key to be used in order to remotely connect to compute instance"
  type        = string

}

variable "ssh_private_key" {
  description = "Private key to log into machine"

}
/********** SSH Key Variables **********/


/********** OKE Nodepool Variables **********/
variable "oke_cluster_name" {
  description = "OKE cluster display name "
}

variable "k8s_version" {
  description = "Declares K8 Version"
}

variable "node_pool_name" {
  description = "Node Pool Name for K8 Cluster"
}

variable "node_pool_shape" {
  description = "Shape to be used in node pool members"
}

variable "number_of_nodes" {
  description = "Number of Nodes inside Node Pool"
}

variable "source_type" {
  description = "The source type of this option. IMAGE means the OCID is of an image"
  default     = "IMAGE"
}

variable "oke_availability_domain_map" {
  type        = map(any)
  description = "The name of the availability domain in which this node is placed"
}

variable "oke_cluster_compartment_name" {
  description = "Defines the compartment name where the OKE cluster was created"
  default     = ""
}

variable "oke_nodepool_compartment_name" {
  description = "Defines the compartment name where the OKE nodepool is created"
  default     = ""
}

variable "oke_cluster_compartment_id" {
  description = "Defines the compartment OCID where the OKE cluster was created"
  default     = ""
}

variable "oke_nodepool_compartment_id" {
  description = "Defines the compartment OCID where the OKE nodepool is created"
  default     = ""
}

variable "oke_network_compartment_name" {
  description = "Defines the compartment where the Network is currently located"
}

variable "oke_nodepool_network_subnet_name" {
  description = "Defines the specific Subnet to be used for this resource"
}

variable "k8s_label_map" {
  type        = map(any)
  description = "Define the list of Kubernetes Labels to apply in nodepool"
}

variable "node_metadata" {
  type        = map(any)
  description = "A list of key/value pairs to add to each underlying Oracle Cloud Infrastructure instance in the node pool on launch."
  default     = {}
}

/********** OKE NodePool Variables **********/

