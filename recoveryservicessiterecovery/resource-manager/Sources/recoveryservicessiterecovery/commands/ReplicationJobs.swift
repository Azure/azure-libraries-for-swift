// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// ReplicationJobs is the client for the ReplicationJobs methods of the SiteRecoveryManagementClient service.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct ReplicationJobs {
    public static func Cancel(resourceName: String, resourceGroupName: String, subscriptionId: String, jobName: String) -> ReplicationJobsCancel {
        return CancelCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, jobName: jobName)
    }
    public static func Export(resourceName: String, resourceGroupName: String, subscriptionId: String, jobQueryParameter: JobQueryParameterProtocol) -> ReplicationJobsExport {
        return ExportCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, jobQueryParameter: jobQueryParameter)
    }
    public static func Get(resourceName: String, resourceGroupName: String, subscriptionId: String, jobName: String) -> ReplicationJobsGet {
        return GetCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, jobName: jobName)
    }
    public static func List(resourceName: String, resourceGroupName: String, subscriptionId: String) -> ReplicationJobsList {
        return ListCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId)
    }
    public static func Restart(resourceName: String, resourceGroupName: String, subscriptionId: String, jobName: String) -> ReplicationJobsRestart {
        return RestartCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, jobName: jobName)
    }
    public static func Resume(resourceName: String, resourceGroupName: String, subscriptionId: String, jobName: String, resumeJobParams: ResumeJobParamsProtocol) -> ReplicationJobsResume {
        return ResumeCommand(resourceName: resourceName, resourceGroupName: resourceGroupName, subscriptionId: subscriptionId, jobName: jobName, resumeJobParams: resumeJobParams)
    }
}
}
