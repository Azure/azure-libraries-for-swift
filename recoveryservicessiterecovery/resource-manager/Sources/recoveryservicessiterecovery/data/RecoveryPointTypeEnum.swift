// RecoveryPointType enumerates the values for recovery point type.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum RecoveryPointTypeEnum: String, Codable
{
// Custom specifies the custom state for recovery point type.
    case Custom = "Custom"
// LatestTag specifies the latest tag state for recovery point type.
    case LatestTag = "LatestTag"
// LatestTime specifies the latest time state for recovery point type.
    case LatestTime = "LatestTime"
}
