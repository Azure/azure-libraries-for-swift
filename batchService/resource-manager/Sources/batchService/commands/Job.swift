// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Job is the a client for issuing REST requests to the Azure Batch service.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Job {
    public static func Add(job: JobAddParameterProtocol) -> JobAdd {
        return AddCommand(job: job)
    }
    public static func Delete(jobId: String) -> JobDelete {
        return DeleteCommand(jobId: jobId)
    }
    public static func Disable(jobId: String, jobDisableParameter: JobDisableParameterProtocol) -> JobDisable {
        return DisableCommand(jobId: jobId, jobDisableParameter: jobDisableParameter)
    }
    public static func Enable(jobId: String) -> JobEnable {
        return EnableCommand(jobId: jobId)
    }
    public static func Get(jobId: String) -> JobGet {
        return GetCommand(jobId: jobId)
    }
    public static func GetAllLifetimeStatistics() -> JobGetAllLifetimeStatistics {
        return GetAllLifetimeStatisticsCommand()
    }
    public static func GetTaskCounts(jobId: String) -> JobGetTaskCounts {
        return GetTaskCountsCommand(jobId: jobId)
    }
    public static func List() -> JobList {
        return ListCommand()
    }
    public static func ListFromJobSchedule(jobScheduleId: String) -> JobListFromJobSchedule {
        return ListFromJobScheduleCommand(jobScheduleId: jobScheduleId)
    }
    public static func ListPreparationAndReleaseTaskStatus(jobId: String) -> JobListPreparationAndReleaseTaskStatus {
        return ListPreparationAndReleaseTaskStatusCommand(jobId: jobId)
    }
    public static func Patch(jobId: String, jobPatchParameter: JobPatchParameterProtocol) -> JobPatch {
        return PatchCommand(jobId: jobId, jobPatchParameter: jobPatchParameter)
    }
    public static func Terminate(jobId: String) -> JobTerminate {
        return TerminateCommand(jobId: jobId)
    }
    public static func Update(jobId: String, jobUpdateParameter: JobUpdateParameterProtocol) -> JobUpdate {
        return UpdateCommand(jobId: jobId, jobUpdateParameter: jobUpdateParameter)
    }
}
}
