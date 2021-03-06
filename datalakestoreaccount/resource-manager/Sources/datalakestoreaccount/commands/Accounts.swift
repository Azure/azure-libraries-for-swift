// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Accounts is the creates an Azure Data Lake Store account management client.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Accounts {
    public static func CheckNameAvailability(subscriptionId: String, location: String, parameters: CheckNameAvailabilityParametersProtocol) -> AccountsCheckNameAvailability {
        return CheckNameAvailabilityCommand(subscriptionId: subscriptionId, location: location, parameters: parameters)
    }
    public static func Create(subscriptionId: String, resourceGroupName: String, accountName: String, parameters: CreateDataLakeStoreAccountParametersProtocol) -> AccountsCreate {
        return CreateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, accountName: accountName, parameters: parameters)
    }
    public static func Delete(subscriptionId: String, resourceGroupName: String, accountName: String) -> AccountsDelete {
        return DeleteCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, accountName: accountName)
    }
    public static func EnableKeyVault(subscriptionId: String, resourceGroupName: String, accountName: String) -> AccountsEnableKeyVault {
        return EnableKeyVaultCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, accountName: accountName)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, accountName: String) -> AccountsGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, accountName: accountName)
    }
    public static func List(subscriptionId: String) -> AccountsList {
        return ListCommand(subscriptionId: subscriptionId)
    }
    public static func ListByResourceGroup(subscriptionId: String, resourceGroupName: String) -> AccountsListByResourceGroup {
        return ListByResourceGroupCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName)
    }
    public static func Update(subscriptionId: String, resourceGroupName: String, accountName: String, parameters: UpdateDataLakeStoreAccountParametersProtocol) -> AccountsUpdate {
        return UpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, accountName: accountName, parameters: parameters)
    }
}
}
