// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// MabFileFolderProtectedItemExtendedInfoProtocol is additional information on the backed up item.
public protocol MabFileFolderProtectedItemExtendedInfoProtocol : Codable {
     var lastRefreshedAt: Date? { get set }
     var oldestRecoveryPoint: Date? { get set }
     var recoveryPointCount: Int32? { get set }
}