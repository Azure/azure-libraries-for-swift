// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct Ipv6ExpressRouteCircuitPeeringConfigData : Ipv6ExpressRouteCircuitPeeringConfigProtocol {
    public var primaryPeerAddressPrefix: String?
    public var secondaryPeerAddressPrefix: String?
    public var microsoftPeeringConfig: ExpressRouteCircuitPeeringConfigProtocol?
    public var routeFilter: RouteFilterProtocol?
    public var state: ExpressRouteCircuitPeeringStateEnum?

        enum CodingKeys: String, CodingKey {case primaryPeerAddressPrefix = "primaryPeerAddressPrefix"
        case secondaryPeerAddressPrefix = "secondaryPeerAddressPrefix"
        case microsoftPeeringConfig = "microsoftPeeringConfig"
        case routeFilter = "routeFilter"
        case state = "state"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.primaryPeerAddressPrefix) {
        self.primaryPeerAddressPrefix = try container.decode(String?.self, forKey: .primaryPeerAddressPrefix)
    }
    if container.contains(.secondaryPeerAddressPrefix) {
        self.secondaryPeerAddressPrefix = try container.decode(String?.self, forKey: .secondaryPeerAddressPrefix)
    }
    if container.contains(.microsoftPeeringConfig) {
        self.microsoftPeeringConfig = try container.decode(ExpressRouteCircuitPeeringConfigData?.self, forKey: .microsoftPeeringConfig)
    }
    if container.contains(.routeFilter) {
        self.routeFilter = try container.decode(RouteFilterData?.self, forKey: .routeFilter)
    }
    if container.contains(.state) {
        self.state = try container.decode(ExpressRouteCircuitPeeringStateEnum?.self, forKey: .state)
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
    if self.primaryPeerAddressPrefix != nil {try container.encode(self.primaryPeerAddressPrefix, forKey: .primaryPeerAddressPrefix)}
    if self.secondaryPeerAddressPrefix != nil {try container.encode(self.secondaryPeerAddressPrefix, forKey: .secondaryPeerAddressPrefix)}
    if self.microsoftPeeringConfig != nil {try container.encode(self.microsoftPeeringConfig as! ExpressRouteCircuitPeeringConfigData?, forKey: .microsoftPeeringConfig)}
    if self.routeFilter != nil {try container.encode(self.routeFilter as! RouteFilterData?, forKey: .routeFilter)}
    if self.state != nil {try container.encode(self.state, forKey: .state)}
  }
}

extension DataFactory {
  public static func createIpv6ExpressRouteCircuitPeeringConfigProtocol() -> Ipv6ExpressRouteCircuitPeeringConfigProtocol {
    return Ipv6ExpressRouteCircuitPeeringConfigData()
  }
}