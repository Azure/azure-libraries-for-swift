// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// TestJob is the automation Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct TestJob {
    public static func Create(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String, parameters: TestJobCreateParametersProtocol) -> TestJobCreate {
        return CreateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName, parameters: parameters)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> TestJobGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func Resume(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> TestJobResume {
        return ResumeCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func Stop(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> TestJobStop {
        return StopCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
    public static func Suspend(subscriptionId: String, resourceGroupName: String, automationAccountName: String, runbookName: String) -> TestJobSuspend {
        return SuspendCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, automationAccountName: automationAccountName, runbookName: runbookName)
    }
}
}