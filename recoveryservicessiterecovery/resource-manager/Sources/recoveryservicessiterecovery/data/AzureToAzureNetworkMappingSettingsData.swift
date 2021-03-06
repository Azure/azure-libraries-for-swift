// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AzureToAzureNetworkMappingSettingsData : AzureToAzureNetworkMappingSettingsProtocol, NetworkMappingFabricSpecificSettingsProtocol {
    public var primaryFabricLocation: String?
    public var recoveryFabricLocation: String?

        enum CodingKeys: String, CodingKey {case primaryFabricLocation = "primaryFabricLocation"
        case recoveryFabricLocation = "recoveryFabricLocation"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.primaryFabricLocation) {
        self.primaryFabricLocation = try container.decode(String?.self, forKey: .primaryFabricLocation)
    }
    if container.contains(.recoveryFabricLocation) {
        self.recoveryFabricLocation = try container.decode(String?.self, forKey: .recoveryFabricLocation)
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
    if self.primaryFabricLocation != nil {try container.encode(self.primaryFabricLocation, forKey: .primaryFabricLocation)}
    if self.recoveryFabricLocation != nil {try container.encode(self.recoveryFabricLocation, forKey: .recoveryFabricLocation)}
  }
}

extension DataFactory {
  public static func createAzureToAzureNetworkMappingSettingsProtocol() -> AzureToAzureNetworkMappingSettingsProtocol {
    return AzureToAzureNetworkMappingSettingsData()
  }
}
