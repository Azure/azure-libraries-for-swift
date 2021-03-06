// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ResourceSkuCostsData : ResourceSkuCostsProtocol {
    public var meterID: String?
    public var quantity: Int64?
    public var extendedUnit: String?

        enum CodingKeys: String, CodingKey {case meterID = "meterID"
        case quantity = "quantity"
        case extendedUnit = "extendedUnit"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.meterID) {
        self.meterID = try container.decode(String?.self, forKey: .meterID)
    }
    if container.contains(.quantity) {
        self.quantity = try container.decode(Int64?.self, forKey: .quantity)
    }
    if container.contains(.extendedUnit) {
        self.extendedUnit = try container.decode(String?.self, forKey: .extendedUnit)
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
    if self.meterID != nil {try container.encode(self.meterID, forKey: .meterID)}
    if self.quantity != nil {try container.encode(self.quantity, forKey: .quantity)}
    if self.extendedUnit != nil {try container.encode(self.extendedUnit, forKey: .extendedUnit)}
  }
}

extension DataFactory {
  public static func createResourceSkuCostsProtocol() -> ResourceSkuCostsProtocol {
    return ResourceSkuCostsData()
  }
}
