// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct UpdateKeyVaultMetaInfoData : UpdateKeyVaultMetaInfoProtocol {
    public var encryptionKeyVersion: String?

        enum CodingKeys: String, CodingKey {case encryptionKeyVersion = "encryptionKeyVersion"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.encryptionKeyVersion) {
        self.encryptionKeyVersion = try container.decode(String?.self, forKey: .encryptionKeyVersion)
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
    if self.encryptionKeyVersion != nil {try container.encode(self.encryptionKeyVersion, forKey: .encryptionKeyVersion)}
  }
}

extension DataFactory {
  public static func createUpdateKeyVaultMetaInfoProtocol() -> UpdateKeyVaultMetaInfoProtocol {
    return UpdateKeyVaultMetaInfoData()
  }
}
