// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct GcmCredentialPropertiesData : GcmCredentialPropertiesProtocol {
    public var gcmEndpoint: String?
    public var googleApiKey: String?

        enum CodingKeys: String, CodingKey {case gcmEndpoint = "gcmEndpoint"
        case googleApiKey = "googleApiKey"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.gcmEndpoint) {
        self.gcmEndpoint = try container.decode(String?.self, forKey: .gcmEndpoint)
    }
    if container.contains(.googleApiKey) {
        self.googleApiKey = try container.decode(String?.self, forKey: .googleApiKey)
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
    if self.gcmEndpoint != nil {try container.encode(self.gcmEndpoint, forKey: .gcmEndpoint)}
    if self.googleApiKey != nil {try container.encode(self.googleApiKey, forKey: .googleApiKey)}
  }
}

extension DataFactory {
  public static func createGcmCredentialPropertiesProtocol() -> GcmCredentialPropertiesProtocol {
    return GcmCredentialPropertiesData()
  }
}