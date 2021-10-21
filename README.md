# Azure Naming

This module helps you to keep consistency on your resources names for Terraform The goal of this module it is that for each resource that requires a name in Terraform you would be easily able to compose this name using this module and this will keep the consistency in your repositories.

# Usage

For every resource in `terraform_azurerm` just remove the `azurerm` part of the module and use the `name` property of this output.

example for `azurerm_resource_group` you can use :

```tf
module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "test" ]
}
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = "West Europe"
}
```

if you want this to be unique for this module and not shared with other instances of this module you can use `name_unique`

```tf
module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "test" ]
}
resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name_unique
  location = "West Europe"
}
```
Other advanced usages will be explained in the [Advanced usage](#advanced-usage) part of this docs.

# Internals

## Prerequisites and setup

- Install [tflint](https://github.com/terraform-linters/tflint) as suitable for your OS.

- Run `make install` in the root directory of the repo.

## Modifying resources

The resources are automatically generated using `go` to change the generation please change the file on the `templates` folder. To add a new resource, including its definition in the file `resourceDefinition.json`, and it will be automatically generated when `main.go` is run.

# Current implementation

You can find a list bellow of all the resources that are currently implemented. To get a list of the ones that are missing implementation you can check at [Missing resources](docs/missing_resources.md) the resources that have no documentation about their limitation on naming currently on Microsoft docs are on the [Not defined](docs/not_defined.md) list.


# Advanced usage


## Output

Each one of the resources emits the name of the resource and other properties:

| Property | Type | Description |
| ----- |----- | ---- |
| name | string | name of the resource including respective suffixes and prefixes applied |
| name_unique | string | same as the name but with random chars added for uniqueness |
| dashes | bool | if these resources support dashes |
| slug | string | letters to identify this resource among others |
| min_length | integer | Minimum length required for this resource name |
| max_length | integer | Maximum length allowed for this resource name |
| scope | string | scope which this name needs to be unique, such as `resourcegroup` or `global`  |
| regex | string | Terraform compatible version of the regex |

### Example Output

Every resource will have an output with the following format:

```go
postgresql_server = {
      name        = "pre-fix-psql-su-fix"
      name_unique = "pre-fix-psql-su-fix-asdfg"
      dashes      = true
      slug        = "psql"
      min_length  = 3
      max_length  = 63
      scope       = "global"
      regex       = "^[a-z0-9][a-zA-Z0-9-]+[a-z0-9]$"
    }
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| random | ~> 2.2 |

## Providers

| Name | Version |
|------|---------|
| random | ~> 2.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | It is not recommended that you use prefix by azure you should be using a suffix for your resources. | `list(string)` | `[]` | no |
| suffix | It is recommended that you specify a suffix for consistency. please use only lowercase characters when possible | `list(string)` | `[]` | no |
| unique-include-numbers | If you want to include numbers in the unique generation | `bool` | `true` | no |
| unique-length | Max length of the uniqueness suffix to be added | `number` | `4` | no |
| unique-seed | Custom value for the random characters to be used | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| analysis\_services\_server | n/a |
| api\_management | n/a |
| app\_configuration | n/a |
| app\_service | n/a |
| app\_service\_plan | n/a |
| application\_insights | n/a |
| application\_gateway | n/a |
| application\_security\_group | n/a |
| automation\_account | n/a |
| automation\_certificate | n/a |
| automation\_credential | n/a |
| automation\_runbook | n/a |
| automation\_schedule | n/a |
| automation\_variable | n/a |
| availability\_set | n/a |
| bastion\_host | n/a |
| batch\_account | n/a |
| batch\_application | n/a |
| batch\_certificate | n/a |
| batch\_pool | n/a |
| bot\_channel\_email | n/a |
| bot\_channel\_directline | n/a |
| bot\_channel\_ms\_teams | n/a |
| bot\_channel\_slack | n/a |
| bot\_channels\_registration | n/a |
| bot\_connection | n/a |
| bot\_web\_app | n/a |
| cdn\_endpoint | n/a |
| cdn\_profile | n/a |
| cognitive\_account | n/a |
| container\_group | n/a |
| container\_registry | n/a |
| container\_registry\_webhook | n/a |
| cosmosdb\_account | n/a |
| custom\_provider | n/a |
| dashboard | n/a |
| data\_factory | n/a |
| data\_factory\_dataset\_mysql | n/a |
| data\_factory\_dataset\_postgresql | n/a |
| data\_factory\_dataset\_sql\_server\_table | n/a |
| data\_factory\_integration\_runtime\_managed | n/a |
| data\_factory\_linked\_service\_data\_lake\_storage\_gen2 | n/a |
| data\_factory\_linked\_service\_key\_vault | n/a |
| data\_factory\_linked\_service\_mysql | n/a |
| data\_factory\_linked\_service\_postgresql | n/a |
| data\_factory\_linked\_service\_sql\_server | n/a |
| data\_factory\_pipeline | n/a |
| data\_factory\_trigger\_schedule | n/a |
| data\_lake\_analytics\_account | n/a |
| data\_lake\_analytics\_firewall\_rule | n/a |
| data\_lake\_store | n/a |
| data\_lake\_store\_firewall\_rule | n/a |
| database\_migration\_project | n/a |
| database\_migration\_service | n/a |
| databricks\_cluster | n/a |
| databricks\_high\_concurrency\_cluster | n/a |
| databricks\_standard\_cluster | n/a |
| databricks\_workspace | n/a |
| dev\_test\_lab | n/a |
| dev\_test\_linux\_virtual\_machine | n/a |
| dev\_test\_windows\_virtual\_machine | n/a |
| disk\_encryption\_set | n/a |
| dns\_a\_record | n/a |
| dns\_aaaa\_record | n/a |
| dns\_caa\_record | n/a |
| dns\_cname\_record | n/a |
| dns\_mx\_record | n/a |
| dns\_ns\_record | n/a |
| dns\_ptr\_record | n/a |
| dns\_txt\_record | n/a |
| dns\_zone | n/a |
| eventgrid\_domain | n/a |
| eventgrid\_domain\_topic | n/a |
| eventgrid\_event\_subscription | n/a |
| eventgrid\_topic | n/a |
| eventhub | n/a |
| eventhub\_authorization\_rule | n/a |
| eventhub\_consumer\_group | n/a |
| eventhub\_namespace | n/a |
| eventhub\_namespace\_authorization\_rule | n/a |
| eventhub\_namespace\_disaster\_recovery\_config | n/a |
| express\_route\_circuit | n/a |
| express\_route\_gateway | n/a |
| firewall | n/a |
| firewall\_application\_rule\_collection | n/a |
| firewall\_ip\_configuration | n/a |
| firewall\_nat\_rule\_collection | n/a |
| firewall\_network\_rule\_collection | n/a |
| frontdoor | n/a |
| frontdoor\_firewall\_policy | n/a |
| function\_app | n/a |
| hdinsight\_hadoop\_cluster | n/a |
| hdinsight\_hbase\_cluster | n/a |
| hdinsight\_interactive\_query\_cluster | n/a |
| hdinsight\_kafka\_cluster | n/a |
| hdinsight\_ml\_services\_cluster | n/a |
| hdinsight\_rserver\_cluster | n/a |
| hdinsight\_spark\_cluster | n/a |
| hdinsight\_storm\_cluster | n/a |
| image | n/a |
| iotcentral\_application | n/a |
| iothub | n/a |
| iothub\_consumer\_group | n/a |
| iothub\_dps | n/a |
| iothub\_dps\_certificate | n/a |
| key\_vault | n/a |
| key\_vault\_certificate | n/a |
| key\_vault\_key | n/a |
| key\_vault\_secret | n/a |
| kubernetes\_cluster | n/a |
| kusto\_cluster | n/a |
| kusto\_database | n/a |
| kusto\_eventhub\_data\_connection | n/a |
| lb | n/a |
| lb\_nat\_rule | n/a |
| linux\_virtual\_machine | n/a |
| linux\_virtual\_machine\_scale\_set | n/a |
| local\_network\_gateway | n/a |
| log\_analytics\_workspace | n/a |
| machine\_learning\_workspace | n/a |
| managed\_disk | n/a |
| maps\_account | n/a |
| mariadb\_database | n/a |
| mariadb\_firewall\_rule | n/a |
| mariadb\_server | n/a |
| mariadb\_virtual\_network\_rule | n/a |
| mssql\_database | n/a |
| mssql\_elasticpool | n/a |
| mssql\_server | n/a |
| mysql\_database | n/a |
| mysql\_firewall\_rule | n/a |
| mysql\_server | n/a |
| mysql\_virtual\_network\_rule | n/a |
| network\_ddos\_protection\_plan | n/a |
| network\_interface | n/a |
| network\_security\_group | n/a |
| network\_security\_group\_rule | n/a |
| network\_security\_rule | n/a |
| network\_watcher | n/a |
| notification\_hub | n/a |
| notification\_hub\_authorization\_rule | n/a |
| notification\_hub\_namespace | n/a |
| point\_to\_site\_vpn\_gateway | n/a |
| postgresql\_database | n/a |
| postgresql\_firewall\_rule | n/a |
| postgresql\_server | n/a |
| postgresql\_virtual\_network\_rule | n/a |
| powerbi\_embedded | n/a |
| private\_dns\_a\_record | n/a |
| private\_dns\_aaaa\_record | n/a |
| private\_dns\_cname\_record | n/a |
| private\_dns\_mx\_record | n/a |
| private\_dns\_ptr\_record | n/a |
| private\_dns\_srv\_record | n/a |
| private\_dns\_txt\_record | n/a |
| private\_dns\_zone | n/a |
| private\_dns\_zone\_group | n/a |
| private\_endpoint | n/a |
| private\_link\_service | n/a |
| private\_service\_connection | n/a |
| proximity\_placement\_group | n/a |
| public\_ip | n/a |
| public\_ip\_prefix | n/a |
| redis\_cache | n/a |
| redis\_firewall\_rule | n/a |
| relay\_hybrid\_connection | n/a |
| relay\_namespace | n/a |
| resource\_group | n/a |
| role\_assignment | n/a |
| role\_definition | n/a |
| route | n/a |
| route\_table | n/a |
| service\_fabric\_cluster | n/a |
| servicebus\_namespace | n/a |
| servicebus\_namespace\_authorization\_rule | n/a |
| servicebus\_queue | n/a |
| servicebus\_queue\_authorization\_rule | n/a |
| servicebus\_subscription | n/a |
| servicebus\_subscription\_rule | n/a |
| servicebus\_topic | n/a |
| servicebus\_topic\_authorization\_rule | n/a |
| shared\_image | n/a |
| shared\_image\_gallery | n/a |
| signalr\_service | n/a |
| snapshots | n/a |
| sql\_elasticpool | n/a |
| sql\_failover\_group | n/a |
| sql\_firewall\_rule | n/a |
| sql\_server | n/a |
| storage\_account | n/a |
| storage\_blob | n/a |
| storage\_container | n/a |
| storage\_data\_lake\_gen2\_filesystem | n/a |
| storage\_queue | n/a |
| storage\_share | n/a |
| storage\_share\_directory | n/a |
| storage\_table | n/a |
| stream\_analytics\_function\_javascript\_udf | n/a |
| stream\_analytics\_job | n/a |
| stream\_analytics\_output\_blob | n/a |
| stream\_analytics\_output\_eventhub | n/a |
| stream\_analytics\_output\_mssql | n/a |
| stream\_analytics\_output\_servicebus\_queue | n/a |
| stream\_analytics\_output\_servicebus\_topic | n/a |
| stream\_analytics\_reference\_input\_blob | n/a |
| stream\_analytics\_stream\_input\_blob | n/a |
| stream\_analytics\_stream\_input\_eventhub | n/a |
| stream\_analytics\_stream\_input\_iothub | n/a |
| subnet | n/a |
| template\_deployment | n/a |
| traffic\_manager\_profile | n/a |
| unique-seed | n/a |
| user\_assigned\_identity | n/a |
| validation | n/a |
| virtual\_machine | n/a |
| virtual\_machine\_extension | n/a |
| virtual\_machine\_scale\_set | n/a |
| virtual\_machine\_scale\_set\_extension | n/a |
| virtual\_network | n/a |
| virtual\_network\_gateway | n/a |
| virtual\_network\_peering | n/a |
| virtual\_wan | n/a |
| windows\_virtual\_machine | n/a |
| windows\_virtual\_machine\_scale\_set | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
