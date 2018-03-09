// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct BatchLocationQuotaData : BatchLocationQuotaProtocol {
    public var accountQuota: Int32?

        enum CodingKeys: String, CodingKey {case accountQuota = "accountQuota"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.accountQuota) {
        self.accountQuota = try container.decode(Int32?.self, forKey: .accountQuota)
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
    if self.accountQuota != nil {try container.encode(self.accountQuota, forKey: .accountQuota)}
  }
}

extension DataFactory {
  public static func createBatchLocationQuotaProtocol() -> BatchLocationQuotaProtocol {
    return BatchLocationQuotaData()
  }
}