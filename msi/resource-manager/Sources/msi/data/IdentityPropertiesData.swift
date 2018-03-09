// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct IdentityPropertiesData : IdentityPropertiesProtocol {
    public var tenantId: String?
    public var principalId: String?
    public var clientId: String?
    public var clientSecretUrl: String?

        enum CodingKeys: String, CodingKey {case tenantId = "tenantId"
        case principalId = "principalId"
        case clientId = "clientId"
        case clientSecretUrl = "clientSecretUrl"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.tenantId) {
        self.tenantId = try container.decode(String?.self, forKey: .tenantId)
    }
    if container.contains(.principalId) {
        self.principalId = try container.decode(String?.self, forKey: .principalId)
    }
    if container.contains(.clientId) {
        self.clientId = try container.decode(String?.self, forKey: .clientId)
    }
    if container.contains(.clientSecretUrl) {
        self.clientSecretUrl = try container.decode(String?.self, forKey: .clientSecretUrl)
    }
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.tenantId != nil {try container.encode(self.tenantId, forKey: .tenantId)}
    if self.principalId != nil {try container.encode(self.principalId, forKey: .principalId)}
    if self.clientId != nil {try container.encode(self.clientId, forKey: .clientId)}
    if self.clientSecretUrl != nil {try container.encode(self.clientSecretUrl, forKey: .clientSecretUrl)}
  }
}

extension DataFactory {
  public static func createIdentityPropertiesProtocol() -> IdentityPropertiesProtocol {
    return IdentityPropertiesData()
  }
}