// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// JobStream is the automation Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct JobStream {
    public static func Get(subscriptionId: String, resourceGroupName: String, automationAccountName: String, jobName: String, jobStreamId: String) -> JobStreamGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, jobName: jobName, jobStreamId: jobStreamId)
    }
    public static func ListByJob(resourceGroupName: String, automationAccountName: String, jobName: String, subscriptionId: String) -> JobStreamListByJob {
        return ListByJobCommand(resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, jobName: jobName, subscriptionId: subscriptionId)
    }
}
}
