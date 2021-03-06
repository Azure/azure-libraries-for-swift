// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct CidrIpAddressData : CidrIpAddressProtocol {
    public var baseIpAddress: String?
    public var prefixLength: Int32?

        enum CodingKeys: String, CodingKey {case baseIpAddress = "baseIpAddress"
        case prefixLength = "prefixLength"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.baseIpAddress) {
        self.baseIpAddress = try container.decode(String?.self, forKey: .baseIpAddress)
    }
    if container.contains(.prefixLength) {
        self.prefixLength = try container.decode(Int32?.self, forKey: .prefixLength)
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
    if self.baseIpAddress != nil {try container.encode(self.baseIpAddress, forKey: .baseIpAddress)}
    if self.prefixLength != nil {try container.encode(self.prefixLength, forKey: .prefixLength)}
  }
}

extension DataFactory {
  public static func createCidrIpAddressProtocol() -> CidrIpAddressProtocol {
    return CidrIpAddressData()
  }
}
