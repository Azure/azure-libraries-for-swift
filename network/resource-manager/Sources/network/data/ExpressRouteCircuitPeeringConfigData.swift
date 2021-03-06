// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ExpressRouteCircuitPeeringConfigData : ExpressRouteCircuitPeeringConfigProtocol {
    public var advertisedPublicPrefixes: [String]?
    public var advertisedCommunities: [String]?
    public var advertisedPublicPrefixesState: ExpressRouteCircuitPeeringAdvertisedPublicPrefixStateEnum?
    public var legacyMode: Int32?
    public var customerASN: Int32?
    public var routingRegistryName: String?

        enum CodingKeys: String, CodingKey {case advertisedPublicPrefixes = "advertisedPublicPrefixes"
        case advertisedCommunities = "advertisedCommunities"
        case advertisedPublicPrefixesState = "advertisedPublicPrefixesState"
        case legacyMode = "legacyMode"
        case customerASN = "customerASN"
        case routingRegistryName = "routingRegistryName"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.advertisedPublicPrefixes) {
        self.advertisedPublicPrefixes = try container.decode([String]?.self, forKey: .advertisedPublicPrefixes)
    }
    if container.contains(.advertisedCommunities) {
        self.advertisedCommunities = try container.decode([String]?.self, forKey: .advertisedCommunities)
    }
    if container.contains(.advertisedPublicPrefixesState) {
        self.advertisedPublicPrefixesState = try container.decode(ExpressRouteCircuitPeeringAdvertisedPublicPrefixStateEnum?.self, forKey: .advertisedPublicPrefixesState)
    }
    if container.contains(.legacyMode) {
        self.legacyMode = try container.decode(Int32?.self, forKey: .legacyMode)
    }
    if container.contains(.customerASN) {
        self.customerASN = try container.decode(Int32?.self, forKey: .customerASN)
    }
    if container.contains(.routingRegistryName) {
        self.routingRegistryName = try container.decode(String?.self, forKey: .routingRegistryName)
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
    if self.advertisedPublicPrefixes != nil {try container.encode(self.advertisedPublicPrefixes as! [String]?, forKey: .advertisedPublicPrefixes)}
    if self.advertisedCommunities != nil {try container.encode(self.advertisedCommunities as! [String]?, forKey: .advertisedCommunities)}
    if self.advertisedPublicPrefixesState != nil {try container.encode(self.advertisedPublicPrefixesState, forKey: .advertisedPublicPrefixesState)}
    if self.legacyMode != nil {try container.encode(self.legacyMode, forKey: .legacyMode)}
    if self.customerASN != nil {try container.encode(self.customerASN, forKey: .customerASN)}
    if self.routingRegistryName != nil {try container.encode(self.routingRegistryName, forKey: .routingRegistryName)}
  }
}

extension DataFactory {
  public static func createExpressRouteCircuitPeeringConfigProtocol() -> ExpressRouteCircuitPeeringConfigProtocol {
    return ExpressRouteCircuitPeeringConfigData()
  }
}
