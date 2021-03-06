// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// ManagementClient is the network Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Service {
    public static func CheckDnsNameAvailability(location: String, subscriptionId: String, domainNameLabel: String) -> ServiceCheckDnsNameAvailability {
        return CheckDnsNameAvailabilityCommand(location: location, subscriptionId: subscriptionId, domainNameLabel: domainNameLabel)
    }
}
}
