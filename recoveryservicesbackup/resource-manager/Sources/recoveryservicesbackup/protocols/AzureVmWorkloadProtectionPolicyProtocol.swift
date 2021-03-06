// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AzureVmWorkloadProtectionPolicyProtocol is azure VM (Mercury) workload-specific backup policy.
public protocol AzureVmWorkloadProtectionPolicyProtocol : ProtectionPolicyProtocol {
     var workLoadType: String? { get set }
     var settings: SettingsProtocol? { get set }
     var subProtectionPolicy: [SubProtectionPolicyProtocol?]? { get set }
}
