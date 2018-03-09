// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// AgentRegistrationInformation is the automation Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct AgentRegistrationInformation {
    public static func Get(resourceGroupName: String, automationAccountName: String, subscriptionId: String) -> AgentRegistrationInformationGet {
        return GetCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, subscriptionId: subscriptionId)
    }
    public static func RegenerateKey(resourceGroupName: String, automationAccountName: String, subscriptionId: String, parameters: AgentRegistrationRegenerateKeyParameterProtocol) -> AgentRegistrationInformationRegenerateKey {
        return RegenerateKeyCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, subscriptionId: subscriptionId, parameters: parameters)
    }
}
}