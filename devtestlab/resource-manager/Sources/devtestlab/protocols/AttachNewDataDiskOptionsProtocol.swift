// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AttachNewDataDiskOptionsProtocol is properties to attach new disk to the Virtual Machine.
public protocol AttachNewDataDiskOptionsProtocol : Codable {
     var diskSizeGiB: Int32? { get set }
     var diskName: String? { get set }
     var diskType: StorageTypeEnum? { get set }
}