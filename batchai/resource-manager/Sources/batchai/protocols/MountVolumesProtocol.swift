// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// MountVolumesProtocol is details of volumes to mount on the cluster.
public protocol MountVolumesProtocol : Codable {
     var azureFileShares: [AzureFileShareReferenceProtocol?]? { get set }
     var azureBlobFileSystems: [AzureBlobFileSystemReferenceProtocol?]? { get set }
     var fileServers: [FileServerReferenceProtocol?]? { get set }
     var unmanagedFileSystems: [UnmanagedFileSystemReferenceProtocol?]? { get set }
}
