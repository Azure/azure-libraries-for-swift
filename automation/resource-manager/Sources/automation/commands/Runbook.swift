// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Runbook is the automation Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Runbook {
    public static func CreateOrUpdate(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String, parameters: RunbookCreateOrUpdateParametersProtocol) -> RunbookCreateOrUpdate {
        return CreateOrUpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName, parameters: parameters)
    }
    public static func Delete(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> RunbookDelete {
        return DeleteCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> RunbookGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func GetContent(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> RunbookGetContent {
        return GetContentCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func ListByAutomationAccount(subscriptionId: String, resourceGroupName: String, automationAccountName: String) -> RunbookListByAutomationAccount {
        return ListByAutomationAccountCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName)
    }
    public static func Update(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String, parameters: RunbookUpdateParametersProtocol) -> RunbookUpdate {
        return UpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName, parameters: parameters)
    }
}
}
