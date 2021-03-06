// ProvisioningState enumerates the values for provisioning state.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum ProvisioningStateEnum: String, Codable
{
// ProvisioningStateCreating specifies the provisioning state creating state for provisioning state.
    case ProvisioningStateCreating = "creating"
// ProvisioningStateDeleting specifies the provisioning state deleting state for provisioning state.
    case ProvisioningStateDeleting = "deleting"
// ProvisioningStateFailed specifies the provisioning state failed state for provisioning state.
    case ProvisioningStateFailed = "failed"
// ProvisioningStateSucceeded specifies the provisioning state succeeded state for provisioning state.
    case ProvisioningStateSucceeded = "succeeded"
}
