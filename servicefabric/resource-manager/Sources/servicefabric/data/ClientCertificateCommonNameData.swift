// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ClientCertificateCommonNameData : ClientCertificateCommonNameProtocol {
    public var isAdmin: Bool
    public var certificateCommonName: String
    public var certificateIssuerThumbprint: String

        enum CodingKeys: String, CodingKey {case isAdmin = "isAdmin"
        case certificateCommonName = "certificateCommonName"
        case certificateIssuerThumbprint = "certificateIssuerThumbprint"
        }

  public init(isAdmin: Bool, certificateCommonName: String, certificateIssuerThumbprint: String)  {
    self.isAdmin = isAdmin
    self.certificateCommonName = certificateCommonName
    self.certificateIssuerThumbprint = certificateIssuerThumbprint
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.isAdmin = try container.decode(Bool.self, forKey: .isAdmin)
    self.certificateCommonName = try container.decode(String.self, forKey: .certificateCommonName)
    self.certificateIssuerThumbprint = try container.decode(String.self, forKey: .certificateIssuerThumbprint)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.isAdmin, forKey: .isAdmin)
    try container.encode(self.certificateCommonName, forKey: .certificateCommonName)
    try container.encode(self.certificateIssuerThumbprint, forKey: .certificateIssuerThumbprint)
  }
}

extension DataFactory {
  public static func createClientCertificateCommonNameProtocol(isAdmin: Bool, certificateCommonName: String, certificateIssuerThumbprint: String) -> ClientCertificateCommonNameProtocol {
    return ClientCertificateCommonNameData(isAdmin: isAdmin, certificateCommonName: certificateCommonName, certificateIssuerThumbprint: certificateIssuerThumbprint)
  }
}
