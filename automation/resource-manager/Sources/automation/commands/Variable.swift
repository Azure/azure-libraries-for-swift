// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Variable is the automation Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Variable {
    public static func CreateOrUpdate(resourceGroupName: String, automationAccountName: String, variableName: String, subscriptionId: String, parameters: VariableCreateOrUpdateParametersProtocol) -> VariableCreateOrUpdate {
        return CreateOrUpdateCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, variableName: variableName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func Delete(resourceGroupName: String, automationAccountName: String, variableName: String, subscriptionId: String) -> VariableDelete {
        return DeleteCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, variableName: variableName, subscriptionId: subscriptionId)
    }
    public static func Get(resourceGroupName: String, automationAccountName: String, variableName: String, subscriptionId: String) -> VariableGet {
        return GetCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, variableName: variableName, subscriptionId: subscriptionId)
    }
    public static func ListByAutomationAccount(resourceGroupName: String, automationAccountName: String, subscriptionId: String) -> VariableListByAutomationAccount {
        return ListByAutomationAccountCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, subscriptionId: subscriptionId)
    }
    public static func Update(resourceGroupName: String, automationAccountName: String, variableName: String, subscriptionId: String, parameters: VariableUpdateParametersProtocol) -> VariableUpdate {
        return UpdateCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, variableName: variableName, subscriptionId: subscriptionId, parameters: parameters)
    }
}
}
