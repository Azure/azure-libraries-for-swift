// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CertificatePropertiesWithNonceProtocol is the description of an X509 CA Certificate including the challenge nonce
// issued for the Proof-Of-Possession flow.
public protocol CertificatePropertiesWithNonceProtocol : Codable {
     var subject: String? { get set }
     var expiry: Date? { get set }
     var thumbprint: String? { get set }
     var isVerified: Bool? { get set }
     var created: Date? { get set }
     var updated: Date? { get set }
     var verificationCode: String? { get set }
}
