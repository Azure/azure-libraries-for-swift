// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// MpnsCredentialPropertiesProtocol is description of a NotificationHub MpnsCredential.
public protocol MpnsCredentialPropertiesProtocol : Codable {
     var mpnsCertificate: String? { get set }
     var certificateKey: String? { get set }
     var thumbprint: String? { get set }
}