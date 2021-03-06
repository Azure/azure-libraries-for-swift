// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VaultExtendedInfoProtocol is vault extended information.
public protocol VaultExtendedInfoProtocol : Codable {
     var integrityKey: String? { get set }
     var encryptionKey: String? { get set }
     var encryptionKeyThumbprint: String? { get set }
     var algorithm: String? { get set }
}
