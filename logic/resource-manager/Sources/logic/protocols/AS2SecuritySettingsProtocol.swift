// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AS2SecuritySettingsProtocol is the AS2 agreement security settings.
public protocol AS2SecuritySettingsProtocol : Codable {
     var overrideGroupSigningCertificate: Bool { get set }
     var signingCertificateName: String? { get set }
     var encryptionCertificateName: String? { get set }
     var enableNrrForInboundEncodedMessages: Bool { get set }
     var enableNrrForInboundDecodedMessages: Bool { get set }
     var enableNrrForOutboundMdn: Bool { get set }
     var enableNrrForOutboundEncodedMessages: Bool { get set }
     var enableNrrForOutboundDecodedMessages: Bool { get set }
     var enableNrrForInboundMdn: Bool { get set }
     var sha2AlgorithmFormat: String? { get set }
}
