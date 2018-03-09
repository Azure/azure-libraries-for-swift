// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// DatabaseOperations is the the Azure SQL Database management API provides a RESTful set of web services that interact
// with Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update, and
// delete databases.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct DatabaseOperations {
    public static func Cancel(resourceGroupName: String, serverName: String, databaseName: String, operationId: String, subscriptionId: String) -> DatabaseOperationsCancel {
        return CancelCommand(resourceGroupName: resourceGroupName, serverName: serverName, databaseName: databaseName, operationId: operationId, subscriptionId: subscriptionId)
    }
    public static func ListByDatabase(resourceGroupName: String, serverName: String, databaseName: String, subscriptionId: String) -> DatabaseOperationsListByDatabase {
        return ListByDatabaseCommand(resourceGroupName: resourceGroupName, serverName: serverName, databaseName: databaseName, subscriptionId: subscriptionId)
    }
}
}