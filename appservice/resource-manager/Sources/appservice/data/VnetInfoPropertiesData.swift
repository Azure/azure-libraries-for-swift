// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VnetInfoPropertiesData : VnetInfoPropertiesProtocol {
    public var vnetResourceId: String?
    public var certThumbprint: String?
    public var certBlob: [UInt8]?
    public var routes: [VnetRouteProtocol?]?
    public var resyncRequired: Bool?
    public var dnsServers: String?

        enum CodingKeys: String, CodingKey {case vnetResourceId = "vnetResourceId"
        case certThumbprint = "certThumbprint"
        case certBlob = "certBlob"
        case routes = "routes"
        case resyncRequired = "resyncRequired"
        case dnsServers = "dnsServers"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.vnetResourceId) {
        self.vnetResourceId = try container.decode(String?.self, forKey: .vnetResourceId)
    }
    if container.contains(.certThumbprint) {
        self.certThumbprint = try container.decode(String?.self, forKey: .certThumbprint)
    }
    if container.contains(.certBlob) {
        self.certBlob = try container.decode([UInt8]?.self, forKey: .certBlob)
    }
    if container.contains(.routes) {
        self.routes = try container.decode([VnetRouteData?]?.self, forKey: .routes)
    }
    if container.contains(.resyncRequired) {
        self.resyncRequired = try container.decode(Bool?.self, forKey: .resyncRequired)
    }
    if container.contains(.dnsServers) {
        self.dnsServers = try container.decode(String?.self, forKey: .dnsServers)
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
    if self.vnetResourceId != nil {try container.encode(self.vnetResourceId, forKey: .vnetResourceId)}
    if self.certThumbprint != nil {try container.encode(self.certThumbprint, forKey: .certThumbprint)}
    if self.certBlob != nil {try container.encode(self.certBlob, forKey: .certBlob)}
    if self.routes != nil {try container.encode(self.routes as! [VnetRouteData?]?, forKey: .routes)}
    if self.resyncRequired != nil {try container.encode(self.resyncRequired, forKey: .resyncRequired)}
    if self.dnsServers != nil {try container.encode(self.dnsServers, forKey: .dnsServers)}
  }
}

extension DataFactory {
  public static func createVnetInfoPropertiesProtocol() -> VnetInfoPropertiesProtocol {
    return VnetInfoPropertiesData()
  }
}