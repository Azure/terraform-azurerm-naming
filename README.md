

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | It is not recommended that you use prefix by azure you should be using a suffix for your resources. | `list(string)` | `[]` | no |
| suffix | It is recommended that you specify a suffix for consistency. please use only lowercase charactes when possible | `list(string)` | `[]` | no |
| unique-include-numbers | n/a | `bool` | `true` | no |
| unique-length | n/a | `number` | `4` | no |
| unique-seed | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aks\_cluster | n/a |
| analysis\_services\_server | n/a |
| api\_management | n/a |
| app\_service\_environment | n/a |
| app\_service\_plan | n/a |
| application\_gateway | n/a |
| application\_insights | n/a |
| application\_security\_group | n/a |
| automation\_account | n/a |
| availability\_set | n/a |
| azure\_arc\_connected\_machine | n/a |
| blueprint | n/a |
| cloud\_service | n/a |
| cognitive\_search | n/a |
| cognitive\_services | n/a |
| container\_instance | n/a |
| cosmos\_db | n/a |
| data\_factory | n/a |
| data\_lake\_analytics\_account | n/a |
| data\_lake\_file\_system | n/a |
| data\_lake\_store\_account | n/a |
| data\_warehouse | n/a |
| database\_migration\_service\_instance | n/a |
| databricks\_workspace | n/a |
| event\_hub | n/a |
| event\_hub\_authorization\_rule | n/a |
| event\_hub\_namespace | n/a |
| event\_hub\_namespace\_authorization\_rule | n/a |
| firewall | n/a |
| firewall\_ip\_configuration | n/a |
| function\_app | n/a |
| hdinsights\_hadoop\_cluster | n/a |
| hdinsights\_hbase\_cluster | n/a |
| hdinsights\_kafka\_cluster | n/a |
| hdinsights\_ml\_services\_cluster | n/a |
| hdinsights\_spark\_cluster | n/a |
| hdinsights\_storm\_cluster | n/a |
| iot\_hub | n/a |
| key\_vault | n/a |
| key\_vault\_key | n/a |
| load\_balancer\_external | n/a |
| load\_balancer\_internal | n/a |
| local\_network\_gateway | n/a |
| log\_analytics\_workspace | n/a |
| logic\_apps | n/a |
| machine\_learning\_workspace | n/a |
| migrate\_project | n/a |
| mysql | n/a |
| network\_interface | n/a |
| network\_security\_group | n/a |
| notification\_hubs | n/a |
| notification\_hubs\_namespace | n/a |
| policy | n/a |
| postgre | n/a |
| private\_endpoint | n/a |
| private\_service\_connection | n/a |
| public\_ip | n/a |
| recovery\_services\_vault | n/a |
| redis\_cache | n/a |
| resource\_group | n/a |
| service\_bus | n/a |
| service\_bus\_queue | n/a |
| service\_bus\_topic | n/a |
| service\_fabric | n/a |
| sql\_database | n/a |
| sql\_server | n/a |
| sql\_server\_strech\_database | n/a |
| storage\_account | n/a |
| storage\_managed\_encryption\_key | n/a |
| storagesimple | n/a |
| stream\_analytics | n/a |
| subnet | n/a |
| synapse | n/a |
| traffic\_manager\_profile | n/a |
| unique-seed | n/a |
| virtual\_machine | n/a |
| virtual\_machine\_linux | n/a |
| virtual\_machine\_scale\_set | n/a |
| virtual\_machine\_scale\_set\_linux | n/a |
| virtual\_network | n/a |
| virtual\_network\_gateway | n/a |
| vm\_storage\_account | n/a |
| vpn\_connection | n/a |
| web\_app | n/a |

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
