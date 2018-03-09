// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct CheckNameAvailabilityParametersData : CheckNameAvailabilityParametersProtocol {
    public var name: String?
    public var type: String?

        enum CodingKeys: String, CodingKey {case name = "name"
        case type = "type"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.type) {
        self.type = try container.decode(String?.self, forKey: .type)
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
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.type != nil {try container.encode(self.type, forKey: .type)}
  }
}

extension DataFactory {
  public static func createCheckNameAvailabilityParametersProtocol() -> CheckNameAvailabilityParametersProtocol {
    return CheckNameAvailabilityParametersData()
  }
}
