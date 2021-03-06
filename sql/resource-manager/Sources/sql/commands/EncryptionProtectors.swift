// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// EncryptionProtectors is the the Azure SQL Database management API provides a RESTful set of web services that
// interact with Azure SQL Database services to manage your databases. The API enables you to create, retrieve, update,
// and delete databases.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct EncryptionProtectors {
    public static func CreateOrUpdate(resourceGroupName: String, serverName: String, encryptionProtectorName: String, subscriptionId: String, parameters: EncryptionProtectorProtocol) -> EncryptionProtectorsCreateOrUpdate {
        return CreateOrUpdateCommand(resourceGroupName: resourceGroupName, serverName: serverName, encryptionProtectorName: encryptionProtectorName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func Get(resourceGroupName: String, serverName: String, encryptionProtectorName: String, subscriptionId: String) -> EncryptionProtectorsGet {
        return GetCommand(resourceGroupName: resourceGroupName, serverName: serverName, encryptionProtectorName: encryptionProtectorName, subscriptionId: subscriptionId)
    }
    public static func ListByServer(resourceGroupName: String, serverName: String, subscriptionId: String) -> EncryptionProtectorsListByServer {
        return ListByServerCommand(resourceGroupName: resourceGroupName, serverName: serverName, subscriptionId: subscriptionId)
    }
}
}
