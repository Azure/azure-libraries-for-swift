// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct PredictionDistributionDefinitionData : PredictionDistributionDefinitionProtocol {
    public var totalPositives: Int64?
    public var totalNegatives: Int64?
    public var distributions: [PredictionDistributionDefinitionDistributionsItemProtocol?]?

        enum CodingKeys: String, CodingKey {case totalPositives = "totalPositives"
        case totalNegatives = "totalNegatives"
        case distributions = "distributions"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.totalPositives) {
        self.totalPositives = try container.decode(Int64?.self, forKey: .totalPositives)
    }
    if container.contains(.totalNegatives) {
        self.totalNegatives = try container.decode(Int64?.self, forKey: .totalNegatives)
    }
    if container.contains(.distributions) {
        self.distributions = try container.decode([PredictionDistributionDefinitionDistributionsItemData?]?.self, forKey: .distributions)
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
    if self.totalPositives != nil {try container.encode(self.totalPositives, forKey: .totalPositives)}
    if self.totalNegatives != nil {try container.encode(self.totalNegatives, forKey: .totalNegatives)}
    if self.distributions != nil {try container.encode(self.distributions as! [PredictionDistributionDefinitionDistributionsItemData?]?, forKey: .distributions)}
  }
}

extension DataFactory {
  public static func createPredictionDistributionDefinitionProtocol() -> PredictionDistributionDefinitionProtocol {
    return PredictionDistributionDefinitionData()
  }
}