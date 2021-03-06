// WorkflowStatus enumerates the values for workflow status.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum WorkflowStatusEnum: String, Codable
{
// WorkflowStatusAborted specifies the workflow status aborted state for workflow status.
    case WorkflowStatusAborted = "Aborted"
// WorkflowStatusCancelled specifies the workflow status cancelled state for workflow status.
    case WorkflowStatusCancelled = "Cancelled"
// WorkflowStatusFailed specifies the workflow status failed state for workflow status.
    case WorkflowStatusFailed = "Failed"
// WorkflowStatusFaulted specifies the workflow status faulted state for workflow status.
    case WorkflowStatusFaulted = "Faulted"
// WorkflowStatusIgnored specifies the workflow status ignored state for workflow status.
    case WorkflowStatusIgnored = "Ignored"
// WorkflowStatusNotSpecified specifies the workflow status not specified state for workflow status.
    case WorkflowStatusNotSpecified = "NotSpecified"
// WorkflowStatusPaused specifies the workflow status paused state for workflow status.
    case WorkflowStatusPaused = "Paused"
// WorkflowStatusRunning specifies the workflow status running state for workflow status.
    case WorkflowStatusRunning = "Running"
// WorkflowStatusSkipped specifies the workflow status skipped state for workflow status.
    case WorkflowStatusSkipped = "Skipped"
// WorkflowStatusSucceeded specifies the workflow status succeeded state for workflow status.
    case WorkflowStatusSucceeded = "Succeeded"
// WorkflowStatusSuspended specifies the workflow status suspended state for workflow status.
    case WorkflowStatusSuspended = "Suspended"
// WorkflowStatusTimedOut specifies the workflow status timed out state for workflow status.
    case WorkflowStatusTimedOut = "TimedOut"
// WorkflowStatusWaiting specifies the workflow status waiting state for workflow status.
    case WorkflowStatusWaiting = "Waiting"
}
