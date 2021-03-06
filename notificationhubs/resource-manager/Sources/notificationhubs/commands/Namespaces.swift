// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Namespaces is the azure NotificationHub client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Namespaces {
    public static func CheckAvailability(subscriptionId: String, parameters: CheckAvailabilityParametersProtocol) -> NamespacesCheckAvailability {
        return CheckAvailabilityCommand(subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func CreateOrUpdate(resourceGroupName: String, namespaceName: String, subscriptionId: String, parameters: NamespaceCreateOrUpdateParametersProtocol) -> NamespacesCreateOrUpdate {
        return CreateOrUpdateCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func CreateOrUpdateAuthorizationRule(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String, parameters: SharedAccessAuthorizationRuleCreateOrUpdateParametersProtocol) -> NamespacesCreateOrUpdateAuthorizationRule {
        return CreateOrUpdateAuthorizationRuleCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, authorizationRuleName: authorizationRuleName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func Delete(resourceGroupName: String, namespaceName: String, subscriptionId: String) -> NamespacesDelete {
        return DeleteCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId)
    }
    public static func DeleteAuthorizationRule(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String) -> NamespacesDeleteAuthorizationRule {
        return DeleteAuthorizationRuleCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, authorizationRuleName: authorizationRuleName, subscriptionId: subscriptionId)
    }
    public static func Get(resourceGroupName: String, namespaceName: String, subscriptionId: String) -> NamespacesGet {
        return GetCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId)
    }
    public static func GetAuthorizationRule(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String) -> NamespacesGetAuthorizationRule {
        return GetAuthorizationRuleCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, authorizationRuleName: authorizationRuleName, subscriptionId: subscriptionId)
    }
    public static func List(resourceGroupName: String, subscriptionId: String) -> NamespacesList {
        return ListCommand(resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
    public static func ListAll(subscriptionId: String) -> NamespacesListAll {
        return ListAllCommand(subscriptionId: subscriptionId)
    }
    public static func ListAuthorizationRules(resourceGroupName: String, namespaceName: String, subscriptionId: String) -> NamespacesListAuthorizationRules {
        return ListAuthorizationRulesCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId)
    }
    public static func ListKeys(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String) -> NamespacesListKeys {
        return ListKeysCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, authorizationRuleName: authorizationRuleName, subscriptionId: subscriptionId)
    }
    public static func Patch(resourceGroupName: String, namespaceName: String, subscriptionId: String, parameters: NamespacePatchParametersProtocol) -> NamespacesPatch {
        return PatchCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, subscriptionId: subscriptionId, parameters: parameters)
    }
    public static func RegenerateKeys(resourceGroupName: String, namespaceName: String, authorizationRuleName: String, subscriptionId: String, parameters: PolicykeyResourceProtocol) -> NamespacesRegenerateKeys {
        return RegenerateKeysCommand(resourceGroupName: resourceGroupName, namespaceName: namespaceName, authorizationRuleName: authorizationRuleName, subscriptionId: subscriptionId, parameters: parameters)
    }
}
}
