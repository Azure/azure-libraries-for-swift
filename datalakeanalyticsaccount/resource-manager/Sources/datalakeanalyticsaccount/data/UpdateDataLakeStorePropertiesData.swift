// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct UpdateDataLakeStorePropertiesData : UpdateDataLakeStorePropertiesProtocol {
    public var suffix: String?

        enum CodingKeys: String, CodingKey {case suffix = "suffix"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.suffix) {
        self.suffix = try container.decode(String?.self, forKey: .suffix)
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
    if self.suffix != nil {try container.encode(self.suffix, forKey: .suffix)}
  }
}

extension DataFactory {
  public static func createUpdateDataLakeStorePropertiesProtocol() -> UpdateDataLakeStorePropertiesProtocol {
    return UpdateDataLakeStorePropertiesData()
  }
}
