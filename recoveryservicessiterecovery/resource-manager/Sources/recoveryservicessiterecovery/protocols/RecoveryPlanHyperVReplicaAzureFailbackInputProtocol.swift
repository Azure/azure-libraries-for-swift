// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// RecoveryPlanHyperVReplicaAzureFailbackInputProtocol is recovery plan HVR Azure failback input.
public protocol RecoveryPlanHyperVReplicaAzureFailbackInputProtocol : RecoveryPlanProviderSpecificFailoverInputProtocol {
     var dataSyncOption: DataSyncStatusEnum { get set }
     var recoveryVmCreationOption: AlternateLocationRecoveryOptionEnum { get set }
}