// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// ElasticPools is the the Azure SQL Database management API provides a RESTful set of web services that interact with
// Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update, and delete
// databases.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct ElasticPools {
    public static func CreateOrUpdate(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String, parameters: ElasticPoolProtocol) -> ElasticPoolsCreateOrUpdate {
        return CreateOrUpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName, parameters: parameters)
    }
    public static func Delete(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String) -> ElasticPoolsDelete {
        return DeleteCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String) -> ElasticPoolsGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName)
    }
    public static func ListByServer(subscriptionId: String, resourceGroupName: String, serverName: String) -> ElasticPoolsListByServer {
        return ListByServerCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName)
    }
    public static func ListMetricDefinitions(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String) -> ElasticPoolsListMetricDefinitions {
        return ListMetricDefinitionsCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName)
    }
    public static func ListMetrics(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String, filter: String) -> ElasticPoolsListMetrics {
        return ListMetricsCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName, filter: filter)
    }
    public static func Update(subscriptionId: String, resourceGroupName: String, serverName: String, elasticPoolName: String, parameters: ElasticPoolUpdateProtocol) -> ElasticPoolsUpdate {
        return UpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, serverName: serverName, elasticPoolName: elasticPoolName, parameters: parameters)
    }
}
}
