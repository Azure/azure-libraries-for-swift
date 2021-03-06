// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ExpressRouteCircuitServiceProviderPropertiesData : ExpressRouteCircuitServiceProviderPropertiesProtocol {
    public var serviceProviderName: String?
    public var peeringLocation: String?
    public var bandwidthInMbps: Int32?

        enum CodingKeys: String, CodingKey {case serviceProviderName = "serviceProviderName"
        case peeringLocation = "peeringLocation"
        case bandwidthInMbps = "bandwidthInMbps"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.serviceProviderName) {
        self.serviceProviderName = try container.decode(String?.self, forKey: .serviceProviderName)
    }
    if container.contains(.peeringLocation) {
        self.peeringLocation = try container.decode(String?.self, forKey: .peeringLocation)
    }
    if container.contains(.bandwidthInMbps) {
        self.bandwidthInMbps = try container.decode(Int32?.self, forKey: .bandwidthInMbps)
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
    if self.serviceProviderName != nil {try container.encode(self.serviceProviderName, forKey: .serviceProviderName)}
    if self.peeringLocation != nil {try container.encode(self.peeringLocation, forKey: .peeringLocation)}
    if self.bandwidthInMbps != nil {try container.encode(self.bandwidthInMbps, forKey: .bandwidthInMbps)}
  }
}

extension DataFactory {
  public static func createExpressRouteCircuitServiceProviderPropertiesProtocol() -> ExpressRouteCircuitServiceProviderPropertiesProtocol {
    return ExpressRouteCircuitServiceProviderPropertiesData()
  }
}
