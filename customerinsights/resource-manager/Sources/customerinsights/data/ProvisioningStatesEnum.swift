// ProvisioningStates enumerates the values for provisioning states.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum ProvisioningStatesEnum: String, Codable
{
// ProvisioningStatesDeleting specifies the provisioning states deleting state for provisioning states.
    case ProvisioningStatesDeleting = "Deleting"
// ProvisioningStatesExpiring specifies the provisioning states expiring state for provisioning states.
    case ProvisioningStatesExpiring = "Expiring"
// ProvisioningStatesFailed specifies the provisioning states failed state for provisioning states.
    case ProvisioningStatesFailed = "Failed"
// ProvisioningStatesHumanIntervention specifies the provisioning states human intervention state for provisioning
// states.
    case ProvisioningStatesHumanIntervention = "HumanIntervention"
// ProvisioningStatesProvisioning specifies the provisioning states provisioning state for provisioning states.
    case ProvisioningStatesProvisioning = "Provisioning"
// ProvisioningStatesSucceeded specifies the provisioning states succeeded state for provisioning states.
    case ProvisioningStatesSucceeded = "Succeeded"
}
