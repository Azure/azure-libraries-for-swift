// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ReissueCertificateOrderRequestPropertiesData : ReissueCertificateOrderRequestPropertiesProtocol {
    public var keySize: Int32?
    public var delayExistingRevokeInHours: Int32?
    public var csr: String?
    public var isPrivateKeyExternal: Bool?

        enum CodingKeys: String, CodingKey {case keySize = "keySize"
        case delayExistingRevokeInHours = "delayExistingRevokeInHours"
        case csr = "csr"
        case isPrivateKeyExternal = "isPrivateKeyExternal"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.keySize) {
        self.keySize = try container.decode(Int32?.self, forKey: .keySize)
    }
    if container.contains(.delayExistingRevokeInHours) {
        self.delayExistingRevokeInHours = try container.decode(Int32?.self, forKey: .delayExistingRevokeInHours)
    }
    if container.contains(.csr) {
        self.csr = try container.decode(String?.self, forKey: .csr)
    }
    if container.contains(.isPrivateKeyExternal) {
        self.isPrivateKeyExternal = try container.decode(Bool?.self, forKey: .isPrivateKeyExternal)
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
    if self.keySize != nil {try container.encode(self.keySize, forKey: .keySize)}
    if self.delayExistingRevokeInHours != nil {try container.encode(self.delayExistingRevokeInHours, forKey: .delayExistingRevokeInHours)}
    if self.csr != nil {try container.encode(self.csr, forKey: .csr)}
    if self.isPrivateKeyExternal != nil {try container.encode(self.isPrivateKeyExternal, forKey: .isPrivateKeyExternal)}
  }
}

extension DataFactory {
  public static func createReissueCertificateOrderRequestPropertiesProtocol() -> ReissueCertificateOrderRequestPropertiesProtocol {
    return ReissueCertificateOrderRequestPropertiesData()
  }
}
