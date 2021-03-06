// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Endpoints is the use these APIs to manage Azure CDN resources through the Azure Resource Manager. You must make sure
// that requests made to these resources are secure.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Endpoints {
    public static func Create(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, endpoint: EndpointProtocol) -> EndpointsCreate {
        return CreateCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId, endpoint: endpoint)
    }
    public static func Delete(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) -> EndpointsDelete {
        return DeleteCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId)
    }
    public static func Get(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) -> EndpointsGet {
        return GetCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId)
    }
    public static func ListByProfile(resourceGroupName: String, profileName: String, subscriptionId: String) -> EndpointsListByProfile {
        return ListByProfileCommand(resourceGroupName: resourceGroupName, profileName: profileName, subscriptionId: subscriptionId)
    }
    public static func ListResourceUsage(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) -> EndpointsListResourceUsage {
        return ListResourceUsageCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId)
    }
    public static func LoadContent(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, contentFilePaths: LoadParametersProtocol) -> EndpointsLoadContent {
        return LoadContentCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId, contentFilePaths: contentFilePaths)
    }
    public static func PurgeContent(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, contentFilePaths: PurgeParametersProtocol) -> EndpointsPurgeContent {
        return PurgeContentCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId, contentFilePaths: contentFilePaths)
    }
    public static func Start(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) -> EndpointsStart {
        return StartCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId)
    }
    public static func Stop(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) -> EndpointsStop {
        return StopCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId)
    }
    public static func Update(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, endpointUpdateProperties: EndpointUpdateParametersProtocol) -> EndpointsUpdate {
        return UpdateCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId, endpointUpdateProperties: endpointUpdateProperties)
    }
    public static func ValidateCustomDomain(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, customDomainProperties: ValidateCustomDomainInputProtocol) -> EndpointsValidateCustomDomain {
        return ValidateCustomDomainCommand(resourceGroupName: resourceGroupName, profileName: profileName, endpointName: endpointName, subscriptionId: subscriptionId, customDomainProperties: customDomainProperties)
    }
}
}
