

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| random | ~>2.2 |
| random | ~>2.2 |

## Providers

| Name | Version |
|------|---------|
| random | ~>2.2 ~>2.2 |

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
| api\_managment\_service | n/a |
| app\_configuration | n/a |
| app\_service\_environment | n/a |
| app\_service\_plan | n/a |
| application\_gateway | n/a |
| application\_insights | n/a |
| application\_security\_group | n/a |
| automation\_account | n/a |
| automation\_certificate | n/a |
| automation\_credential | n/a |
| automation\_runbook | n/a |
| automation\_schedule | n/a |
| automation\_variable | n/a |
| availability\_set | n/a |
| azure\_arc\_connected\_machine | n/a |
| bastion\_host | n/a |
| batch\_account | n/a |
| batch\_application | n/a |
| batch\_certificate | n/a |
| batch\_pool | n/a |
| blueprint | n/a |
| bot\_channel\_Email | n/a |
| bot\_channel\_directline | n/a |
| bot\_channel\_ms\_teams | n/a |
| bot\_channel\_slack | n/a |
| bot\_channels\_registration | n/a |
| bot\_connection | n/a |
| bot\_web\_app | n/a |
| cdn\_endpoint | n/a |
| cdn\_profile | n/a |
| cloud\_service | n/a |
| cognitive\_account | n/a |
| cognitive\_search | n/a |
| cognitive\_services | n/a |
| containerGroups | n/a |
| container\_instance | n/a |
| container\_registry | n/a |
| container\_registry\_webhook | n/a |
| cosmos\_db | n/a |
| cosmosdb\_account | n/a |
| custom\_provider | n/a |
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
| data\_lake\_file\_system | n/a |
| data\_lake\_store | n/a |
| data\_lake\_store\_account | n/a |
| data\_lake\_store\_firewall\_rule | n/a |
| data\_warehouse | n/a |
| database\_migration\_project | n/a |
| database\_migration\_service | n/a |
| database\_migration\_service\_instance | n/a |
| databricks\_workspace | n/a |
| dev\_test\_lab | n/a |
| dev\_test\_linux\_virtual\_machine | n/a |
| dev\_test\_windows\_virtual\_machine | n/a |
| disk\_encryption\_set | n/a |
| event\_hub | n/a |
| event\_hub\_authorization\_rule | n/a |
| event\_hub\_namespace | n/a |
| event\_hub\_namespace\_authorization\_rule | n/a |
| eventhub | n/a |
| eventhub\_authorization\_rule | n/a |
| eventhub\_consumer\_group | n/a |
| eventhub\_namespace | n/a |
| eventhub\_namespace\_authorization\_rule | n/a |
| eventhub\_namespace\_disaster\_recovery\_config | n/a |
| express\_route\_circuit | n/a |
| express\_route\_gateway | n/a |
| firewall | n/a |
| firewall\_ip\_configuration | n/a |
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
| hdinsights\_hadoop\_cluster | n/a |
| hdinsights\_hbase\_cluster | n/a |
| hdinsights\_kafka\_cluster | n/a |
| hdinsights\_ml\_services\_cluster | n/a |
| hdinsights\_spark\_cluster | n/a |
| hdinsights\_storm\_cluster | n/a |
| image | n/a |
| iot\_hub | n/a |
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
| load\_balancer\_external | n/a |
| load\_balancer\_internal | n/a |
| local\_network\_gateway | n/a |
| log\_analytics\_workspace | n/a |
| logic\_apps | n/a |
| machine\_learning\_workspace | n/a |
| managed\_disk | n/a |
| maps\_account | n/a |
| mariadb\_database | n/a |
| mariadb\_firewall\_rule | n/a |
| mariadb\_server | n/a |
| mariadb\_virtual\_network\_rule | n/a |
| migrate\_project | n/a |
| mssql\_database | n/a |
| mssql\_elasticpool | n/a |
| mssql\_server | n/a |
| mysql | n/a |
| mysql\_database | n/a |
| mysql\_firewall\_rule | n/a |
| mysql\_server | n/a |
| mysql\_virtual\_network\_rule | n/a |
| network\_interface | n/a |
| network\_security\_group | n/a |
| network\_watcher | n/a |
| notification\_hubs | n/a |
| notification\_hubs\_namespace | n/a |
| point\_to\_site\_vpn\_gateway | n/a |
| policy | n/a |
| postgre | n/a |
| postgresql\_database | n/a |
| postgresql\_firewall\_rule | n/a |
| postgresql\_server | n/a |
| postgresql\_virtual\_network\_rule | n/a |
| private\_endpoint | n/a |
| private\_service\_connection | n/a |
| public\_ip | n/a |
| public\_ip\_prefix | n/a |
| recovery\_services\_vault | n/a |
| redis\_cache | n/a |
| redis\_firewall\_rule | n/a |
| resource\_group | n/a |
| role\_assignment | n/a |
| role\_definition | n/a |
| route | n/a |
| route\_table | n/a |
| service\_bus | n/a |
| service\_bus\_queue | n/a |
| service\_bus\_topic | n/a |
| service\_fabric | n/a |
| service\_fabric\_cluster | n/a |
| shared\_image | n/a |
| shared\_image\_gallery | n/a |
| snapshots | n/a |
| sql\_database | n/a |
| sql\_elasticpool | n/a |
| sql\_failover\_group | n/a |
| sql\_firewall\_rule | n/a |
| sql\_server | n/a |
| sql\_server\_strech\_database | n/a |
| storage\_account | n/a |
| storage\_blob | n/a |
| storage\_container | n/a |
| storage\_data\_lake\_gen2\_filesystem | n/a |
| storage\_managed\_encryption\_key | n/a |
| storage\_queue | n/a |
| storage\_share | n/a |
| storage\_share\_directory | n/a |
| storage\_table | n/a |
| storagesimple | n/a |
| stream\_analytics | n/a |
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
| synapse | n/a |
| template\_deployment | n/a |
| traffic\_manager\_profile | n/a |
| unique-seed | n/a |
| virtual\_machine | n/a |
| virtual\_machine\_linux | n/a |
| virtual\_machine\_scale\_set | n/a |
| virtual\_machine\_scale\_set\_linux | n/a |
| virtual\_network | n/a |
| virtual\_network\_gateway | n/a |
| virtual\_network\_peering | n/a |
| virtual\_wan | n/a |
| vm\_storage\_account | n/a |
| vpn\_connection | n/a |
| web\_app | n/a |
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
