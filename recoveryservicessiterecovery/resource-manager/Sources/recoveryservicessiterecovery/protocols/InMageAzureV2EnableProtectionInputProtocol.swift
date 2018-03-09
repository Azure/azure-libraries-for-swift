// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// InMageAzureV2EnableProtectionInputProtocol is vMware Azure specific enable protection input.
public protocol InMageAzureV2EnableProtectionInputProtocol : EnableProtectionProviderSpecificInputProtocol {
     var masterTargetId: String? { get set }
     var processServerId: String? { get set }
     var storageAccountId: String { get set }
     var runAsAccountId: String? { get set }
     var multiVmGroupId: String? { get set }
     var multiVmGroupName: String? { get set }
     var disksToInclude: [String]? { get set }
     var targetAzureNetworkId: String? { get set }
     var targetAzureSubnetId: String? { get set }
     var enableRdpOnTargetOption: String? { get set }
     var targetAzureVmName: String? { get set }
     var logStorageAccountId: String? { get set }
     var targetAzureV1ResourceGroupId: String? { get set }
     var targetAzureV2ResourceGroupId: String? { get set }
     var useManagedDisks: String? { get set }
}