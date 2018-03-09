// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ApplicationGatewayBackendHealthServerData : ApplicationGatewayBackendHealthServerProtocol {
    public var address: String?
    public var ipConfiguration: NetworkInterfaceIPConfigurationProtocol?
    public var health: ApplicationGatewayBackendHealthServerHealthEnum?

        enum CodingKeys: String, CodingKey {case address = "address"
        case ipConfiguration = "ipConfiguration"
        case health = "health"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.address) {
        self.address = try container.decode(String?.self, forKey: .address)
    }
    if container.contains(.ipConfiguration) {
        self.ipConfiguration = try container.decode(NetworkInterfaceIPConfigurationData?.self, forKey: .ipConfiguration)
    }
    if container.contains(.health) {
        self.health = try container.decode(ApplicationGatewayBackendHealthServerHealthEnum?.self, forKey: .health)
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
    if self.address != nil {try container.encode(self.address, forKey: .address)}
    if self.ipConfiguration != nil {try container.encode(self.ipConfiguration as! NetworkInterfaceIPConfigurationData?, forKey: .ipConfiguration)}
    if self.health != nil {try container.encode(self.health, forKey: .health)}
  }
}

extension DataFactory {
  public static func createApplicationGatewayBackendHealthServerProtocol() -> ApplicationGatewayBackendHealthServerProtocol {
    return ApplicationGatewayBackendHealthServerData()
  }
}