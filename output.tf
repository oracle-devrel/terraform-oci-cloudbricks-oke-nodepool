# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following script defines the output of kubernetes creation


output "node_pool" {
  description = "Node pool details"
  value = {
    id                 = oci_containerengine_node_pool.oke_node_pool.id
    kubernetes_version = oci_containerengine_node_pool.oke_node_pool.kubernetes_version
    name               = oci_containerengine_node_pool.oke_node_pool.name
    subnet_ids         = oci_containerengine_node_pool.oke_node_pool.subnet_ids
  }
}

output "node_details" {
  description = "Node Pool Member Details"
  value       = oci_containerengine_node_pool.oke_node_pool.nodes.*.private_ip
}

output "oke_nodepools" {
  description = "Node Pools configured inside OKE"
  value       = oci_containerengine_node_pool.oke_node_pool
}
