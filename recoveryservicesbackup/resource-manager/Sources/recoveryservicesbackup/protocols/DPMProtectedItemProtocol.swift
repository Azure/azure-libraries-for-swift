// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DPMProtectedItemProtocol is additional information on Backup engine specific backup item.
public protocol DPMProtectedItemProtocol : ProtectedItemProtocol {
     var friendlyName: String? { get set }
     var backupEngineName: String? { get set }
     var protectionState: ProtectedItemStateEnum? { get set }
     var isScheduledForDeferredDelete: Bool? { get set }
     var extendedInfo: DPMProtectedItemExtendedInfoProtocol? { get set }
}
