// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct NetworkMappingPropertiesData : NetworkMappingPropertiesProtocol {
    public var state: String?
    public var primaryNetworkFriendlyName: String?
    public var primaryNetworkId: String?
    public var primaryFabricFriendlyName: String?
    public var recoveryNetworkFriendlyName: String?
    public var recoveryNetworkId: String?
    public var recoveryFabricArmId: String?
    public var recoveryFabricFriendlyName: String?
    public var fabricSpecificSettings: NetworkMappingFabricSpecificSettingsProtocol?

        enum CodingKeys: String, CodingKey {case state = "state"
        case primaryNetworkFriendlyName = "primaryNetworkFriendlyName"
        case primaryNetworkId = "primaryNetworkId"
        case primaryFabricFriendlyName = "primaryFabricFriendlyName"
        case recoveryNetworkFriendlyName = "recoveryNetworkFriendlyName"
        case recoveryNetworkId = "recoveryNetworkId"
        case recoveryFabricArmId = "recoveryFabricArmId"
        case recoveryFabricFriendlyName = "recoveryFabricFriendlyName"
        case fabricSpecificSettings = "fabricSpecificSettings"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.state) {
        self.state = try container.decode(String?.self, forKey: .state)
    }
    if container.contains(.primaryNetworkFriendlyName) {
        self.primaryNetworkFriendlyName = try container.decode(String?.self, forKey: .primaryNetworkFriendlyName)
    }
    if container.contains(.primaryNetworkId) {
        self.primaryNetworkId = try container.decode(String?.self, forKey: .primaryNetworkId)
    }
    if container.contains(.primaryFabricFriendlyName) {
        self.primaryFabricFriendlyName = try container.decode(String?.self, forKey: .primaryFabricFriendlyName)
    }
    if container.contains(.recoveryNetworkFriendlyName) {
        self.recoveryNetworkFriendlyName = try container.decode(String?.self, forKey: .recoveryNetworkFriendlyName)
    }
    if container.contains(.recoveryNetworkId) {
        self.recoveryNetworkId = try container.decode(String?.self, forKey: .recoveryNetworkId)
    }
    if container.contains(.recoveryFabricArmId) {
        self.recoveryFabricArmId = try container.decode(String?.self, forKey: .recoveryFabricArmId)
    }
    if container.contains(.recoveryFabricFriendlyName) {
        self.recoveryFabricFriendlyName = try container.decode(String?.self, forKey: .recoveryFabricFriendlyName)
    }
    if container.contains(.fabricSpecificSettings) {
        self.fabricSpecificSettings = try container.decode(NetworkMappingFabricSpecificSettingsData?.self, forKey: .fabricSpecificSettings)
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
    if self.state != nil {try container.encode(self.state, forKey: .state)}
    if self.primaryNetworkFriendlyName != nil {try container.encode(self.primaryNetworkFriendlyName, forKey: .primaryNetworkFriendlyName)}
    if self.primaryNetworkId != nil {try container.encode(self.primaryNetworkId, forKey: .primaryNetworkId)}
    if self.primaryFabricFriendlyName != nil {try container.encode(self.primaryFabricFriendlyName, forKey: .primaryFabricFriendlyName)}
    if self.recoveryNetworkFriendlyName != nil {try container.encode(self.recoveryNetworkFriendlyName, forKey: .recoveryNetworkFriendlyName)}
    if self.recoveryNetworkId != nil {try container.encode(self.recoveryNetworkId, forKey: .recoveryNetworkId)}
    if self.recoveryFabricArmId != nil {try container.encode(self.recoveryFabricArmId, forKey: .recoveryFabricArmId)}
    if self.recoveryFabricFriendlyName != nil {try container.encode(self.recoveryFabricFriendlyName, forKey: .recoveryFabricFriendlyName)}
    if self.fabricSpecificSettings != nil {try container.encode(self.fabricSpecificSettings as! NetworkMappingFabricSpecificSettingsData?, forKey: .fabricSpecificSettings)}
  }
}

extension DataFactory {
  public static func createNetworkMappingPropertiesProtocol() -> NetworkMappingPropertiesProtocol {
    return NetworkMappingPropertiesData()
  }
}