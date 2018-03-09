// RecoveryPointSyncType enumerates the values for recovery point sync type.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum RecoveryPointSyncTypeEnum: String, Codable
{
// MultiVmSyncRecoveryPoint specifies the multi vm sync recovery point state for recovery point sync type.
    case MultiVmSyncRecoveryPoint = "MultiVmSyncRecoveryPoint"
// PerVmRecoveryPoint specifies the per vm recovery point state for recovery point sync type.
    case PerVmRecoveryPoint = "PerVmRecoveryPoint"
}
