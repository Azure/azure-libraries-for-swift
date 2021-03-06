// HealthStatus enumerates the values for health status.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum HealthStatusEnum: String, Codable
{
// HealthStatusActionRequired specifies the health status action required state for health status.
    case HealthStatusActionRequired = "ActionRequired"
// HealthStatusActionSuggested specifies the health status action suggested state for health status.
    case HealthStatusActionSuggested = "ActionSuggested"
// HealthStatusInvalid specifies the health status invalid state for health status.
    case HealthStatusInvalid = "Invalid"
// HealthStatusPassed specifies the health status passed state for health status.
    case HealthStatusPassed = "Passed"
}
