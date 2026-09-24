# terraform-aws-vpc-peering-connection-accepter

Terraform module for the accepter side of a cross-account or cross-region
VPC peering connection.

## Cost

No cost impact of its own — see
[`terraform-aws-vpc-peering-connection`](https://github.com/kn47ytv9mv/terraform-aws-vpc-peering-connection)
for the data transfer rate this peering incurs.

## Design

Pairs with
[`terraform-aws-vpc-peering-connection`](https://github.com/kn47ytv9mv/terraform-aws-vpc-peering-connection),
which creates the requester side of the connection. This module runs
under a provider configured for the peer account or region, and accepts
the connection by its ID. Not needed for the simple same-account,
same-region case — there, the requester module's own `auto_accept`
handles acceptance in one apply.

## Usage

```hcl
module "peering_accepter" {
  source = "kn47ytv9mv/vpc-peering-connection-accepter/aws"

  providers = { aws = aws.eu_west_1 }

  vpc_peering_connection_id = module.peering.id
}
```

Or directly from this repository:

```hcl
module "peering_accepter" {
  source = "github.com/kn47ytv9mv/terraform-aws-vpc-peering-connection-accepter"

  providers = { aws = aws.eu_west_1 }

  vpc_peering_connection_id       = module.peering.id
  allow_remote_vpc_dns_resolution = true
}
```

See
[`terraform-aws-vpc-peering-connection`](https://github.com/kn47ytv9mv/terraform-aws-vpc-peering-connection)'s
README for the full cross-region composition.

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| vpc_peering_connection_id | The ID of the peering connection to accept — the `id` output of `terraform-aws-vpc-peering-connection`, from the requester account or region. | `null` | no |
| auto_accept | Whether this resource accepts the peering connection. Defaults to true here (AWS's own raw default is false), since accepting is this module's whole purpose — set false only to manage this side's DNS resolution options without changing acceptance. | `true` | no |
| allow_remote_vpc_dns_resolution | Whether this VPC resolves public DNS hostnames of instances in the peer VPC to their private IP addresses. Requires `enable_dns_hostnames` on this VPC. If null, AWS's own default (`false`) applies. | `null` | no |
| tags | A map of tags to assign to the accepted peering connection. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the accepted peering connection. Identical to the requester side's `id`. |
| vpc_id | The ID of this side's VPC. |
| peer_vpc_id | The ID of the peer (requester) VPC. |
| peer_owner_id | AWS account ID of the peer (requester) VPC. |
| peer_region | Region of the peer (requester) VPC. |
| accept_status | Status of the peering connection. |

## License

MIT — see [LICENSE.md](LICENSE.md).
