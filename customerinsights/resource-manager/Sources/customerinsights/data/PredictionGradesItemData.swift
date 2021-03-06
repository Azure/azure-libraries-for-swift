// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct PredictionGradesItemData : PredictionGradesItemProtocol {
    public var gradeName: String?
    public var minScoreThreshold: Int32?
    public var maxScoreThreshold: Int32?

        enum CodingKeys: String, CodingKey {case gradeName = "gradeName"
        case minScoreThreshold = "minScoreThreshold"
        case maxScoreThreshold = "maxScoreThreshold"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.gradeName) {
        self.gradeName = try container.decode(String?.self, forKey: .gradeName)
    }
    if container.contains(.minScoreThreshold) {
        self.minScoreThreshold = try container.decode(Int32?.self, forKey: .minScoreThreshold)
    }
    if container.contains(.maxScoreThreshold) {
        self.maxScoreThreshold = try container.decode(Int32?.self, forKey: .maxScoreThreshold)
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
    if self.gradeName != nil {try container.encode(self.gradeName, forKey: .gradeName)}
    if self.minScoreThreshold != nil {try container.encode(self.minScoreThreshold, forKey: .minScoreThreshold)}
    if self.maxScoreThreshold != nil {try container.encode(self.maxScoreThreshold, forKey: .maxScoreThreshold)}
  }
}

extension DataFactory {
  public static func createPredictionGradesItemProtocol() -> PredictionGradesItemProtocol {
    return PredictionGradesItemData()
  }
}
