// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AssignmentPrincipalData : AssignmentPrincipalProtocol {
    public var principalId: String
    public var principalType: String
    public var principalMetadata: [String:String]?

        enum CodingKeys: String, CodingKey {case principalId = "principalId"
        case principalType = "principalType"
        case principalMetadata = "principalMetadata"
        }

  public init(principalId: String, principalType: String)  {
    self.principalId = principalId
    self.principalType = principalType
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.principalId = try container.decode(String.self, forKey: .principalId)
    self.principalType = try container.decode(String.self, forKey: .principalType)
    if container.contains(.principalMetadata) {
        self.principalMetadata = try container.decode([String:String]?.self, forKey: .principalMetadata)
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
    try container.encode(self.principalId, forKey: .principalId)
    try container.encode(self.principalType, forKey: .principalType)
    if self.principalMetadata != nil {try container.encode(self.principalMetadata, forKey: .principalMetadata)}
  }
}

extension DataFactory {
  public static func createAssignmentPrincipalProtocol(principalId: String, principalType: String) -> AssignmentPrincipalProtocol {
    return AssignmentPrincipalData(principalId: principalId, principalType: principalType)
  }
}
