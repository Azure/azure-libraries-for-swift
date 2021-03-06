// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SubscriptionQuotaPropertiesData : SubscriptionQuotaPropertiesProtocol {
    public var maxCount: Int32?
    public var currentCount: Int32?

        enum CodingKeys: String, CodingKey {case maxCount = "maxCount"
        case currentCount = "currentCount"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.maxCount) {
        self.maxCount = try container.decode(Int32?.self, forKey: .maxCount)
    }
    if container.contains(.currentCount) {
        self.currentCount = try container.decode(Int32?.self, forKey: .currentCount)
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
    if self.maxCount != nil {try container.encode(self.maxCount, forKey: .maxCount)}
    if self.currentCount != nil {try container.encode(self.currentCount, forKey: .currentCount)}
  }
}

extension DataFactory {
  public static func createSubscriptionQuotaPropertiesProtocol() -> SubscriptionQuotaPropertiesProtocol {
    return SubscriptionQuotaPropertiesData()
  }
}
