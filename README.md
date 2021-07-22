# OCI Cloud Bricks: Oracle Container (Kubernetes) Engine (OKE) - Node Pool

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_terraform-oci-cloudbricks-oke-nodepool)](https://sonarcloud.io/dashboard?id=oracle-devrel_terraform-oci-cloudbricks-oke-nodepool)

## Introduction
The following cloud brick enables you to create a decoupled Oracle Kubernetes Engine Nodepool associated to a particular OKE Cluster

## Reference Architecure
The following is the reference architecture associated to this brick.

In this case you can take advantage of the decoupled nature of this module and provision as many nodepools as required. You later on can use node affinity to have different types of workload based nodepools (such as GPU enabled ones)

### Prerequisites
- Pre existent OKE Cluster

---

## Sample tfvar file
```shell
########## SAMPLE TFVAR FILE ##########
########## PROVIDER SPECIFIC VARIABLES ##########
region           = "foo-region-1"
tenancy_ocid     = "ocid1.tenancy.oc1..abcdefg"
user_ocid        = "ocid1.user.oc1..aaaaaaabcdefg"
fingerprint      = "fo:oo:ba:ar:ba:ar"
private_key_path = "/absolute/path/to/api/key/your_api_key.pem"
########## PROVIDER SPECIFIC VARIABLES ##########

########## ARTIFACT SPECIFIC VARIABLES ##########
ssh_public_key                   = "/path/to/public/ssh/key/pub_key"
ssh_private_key                  = "/path/to/public/ssh/key/priv_key"
ssh_public_is_path               = true
ssh_private_is_path              = true
oke_cluster_compartment_name     = "MY_ARTIFACT_COMPARTMENT"
oke_network_compartment_name     = "MY_NETWORK_COMPARTMENT"
oke_availability_domain_map      = { "ad1" : "aBCD:foo-REGION-1-AD-1", "ad2" : "aBCD:foo-REGION-1-AD-2" , "ad2" : "aBCD:foo-REGION-1-AD-3" }
oke_cluster_name                 = "my_k8_cluster"
oke_nodepool_network_subnet_name = "node_pool_subnet"
k8s_version                      = "K8_Version"
node_pool_name                   = "my_node_pool"
node_pool_shape                  = "VM.Standard2.1"
number_of_nodes                  = 10
k8s_label_map                    = { "SampleLabel1" : "SomeText", "SampleLabel1" : "AnotherText" }
########## ARTIFACT SPECIFIC VARIABLES ##########

########## SAMPLE TFVAR FILE ##########
```

### Variable specific considerations
- You can couple as many nodepools as required
- Variables `ssh_public_is_path` and `ssh_private_is_path` should always be set to `true` if the keys are using a full or relative path. If you hard code this as variable, then turn them to `false`
- Variable `oke_cluster_name` should be the display name of corresponding cluster. If using a modular coupled approach, this name can be obtained from OKE module output
- Variable `oke_nodepool_network_subnet_name` should be the subnet where the nodepool will be created. If the nodepool is required to be kept private, then subnet must be private too
- Variable `k8s_version` should be passed on following standard `v1.xx.yy`. For currently supported versions, please refer to the [following link](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm)

---

## Variable documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.35.0 |
| <a name="provider_oci.home"></a> [oci.home](#provider\_oci.home) | 4.35.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_containerengine_cluster.oke_cluster](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/containerengine_cluster) | resource |
| [oci_identity_tag.release](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_tag) | resource |
| [oci_identity_tag_namespace.devrel](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_tag_namespace) | resource |
| [random_id.tag](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [oci_core_subnets.ENDPOINTSUBNET](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_subnets) | data source |
| [oci_core_subnets.LBAASSUBNET](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_subnets) | data source |
| [oci_core_vcns.VCN](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_vcns) | data source |
| [oci_identity_compartments.COMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |
| [oci_identity_compartments.NWCOMPARTMENTS](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_compartments) | data source |
| [oci_identity_region_subscriptions.home_region_subscriptions](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_region_subscriptions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Defines the K8 Cluster Name | `any` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | API Key Fingerprint for user\_ocid derived from public API Key imported in OCI User config | `any` | n/a | yes |
| <a name="input_k8s_dashboard_enabled"></a> [k8s\_dashboard\_enabled](#input\_k8s\_dashboard\_enabled) | Defines if Kubernetes Dashboard is enabled for cluster | `bool` | `false` | no |
| <a name="input_k8s_tiller_enabled"></a> [k8s\_tiller\_enabled](#input\_k8s\_tiller\_enabled) | Defines if Helm (Tiller) is enabled in cluster | `bool` | `false` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Declares K8 Version | `any` | n/a | yes |
| <a name="input_oke_availability_domain_map"></a> [oke\_availability\_domain\_map](#input\_oke\_availability\_domain\_map) | The name of the availability domain in which this node is placed | `map(any)` | n/a | yes |
| <a name="input_oke_endpoint_is_public_ip_enabled"></a> [oke\_endpoint\_is\_public\_ip\_enabled](#input\_oke\_endpoint\_is\_public\_ip\_enabled) | Determines if OKE Control Plane is located on public or private subnet | `any` | n/a | yes |
| <a name="input_oke_endpoint_subnet_name"></a> [oke\_endpoint\_subnet\_name](#input\_oke\_endpoint\_subnet\_name) | Determines the subnet where the control plane API will be located at | `string` | `""` | no |
| <a name="input_oke_instance_compartment_id"></a> [oke\_instance\_compartment\_id](#input\_oke\_instance\_compartment\_id) | Defines the compartment OCID where the infrastructure will be created | `string` | `""` | no |
| <a name="input_oke_instance_compartment_name"></a> [oke\_instance\_compartment\_name](#input\_oke\_instance\_compartment\_name) | Defines the compartment name where the infrastructure will be created | `string` | `""` | no |
| <a name="input_oke_lbaas_network_subnet_name"></a> [oke\_lbaas\_network\_subnet\_name](#input\_oke\_lbaas\_network\_subnet\_name) | Describes the display name of the subnet where LBaaS Components will be alocated by resource orchestrator | `any` | n/a | yes |
| <a name="input_oke_network_compartment_name"></a> [oke\_network\_compartment\_name](#input\_oke\_network\_compartment\_name) | Defines the compartment where the Network is currently located | `any` | n/a | yes |
| <a name="input_oke_vcn_display_name"></a> [oke\_vcn\_display\_name](#input\_oke\_vcn\_display\_name) | Defines the display name of the VCN where cluster will allocate LBaaS Ingress Controller components | `any` | n/a | yes |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Private Key Absolute path location where terraform is executed | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Target region where artifacts are going to be created | `any` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | OCID of tenancy | `any` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | User OCID in tenancy | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | OKE Cluster details |
| <a name="output_oke_instance"></a> [oke\_instance](#output\_oke\_instance) | OKE Cluster Object for integration purposes |

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.
