// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DpmErrorInfoData : DpmErrorInfoProtocol {
    public var errorString: String?
    public var recommendations: [String]?

        enum CodingKeys: String, CodingKey {case errorString = "errorString"
        case recommendations = "recommendations"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.errorString) {
        self.errorString = try container.decode(String?.self, forKey: .errorString)
    }
    if container.contains(.recommendations) {
        self.recommendations = try container.decode([String]?.self, forKey: .recommendations)
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
    if self.errorString != nil {try container.encode(self.errorString, forKey: .errorString)}
    if self.recommendations != nil {try container.encode(self.recommendations as! [String]?, forKey: .recommendations)}
  }
}

extension DataFactory {
  public static func createDpmErrorInfoProtocol() -> DpmErrorInfoProtocol {
    return DpmErrorInfoData()
  }
}