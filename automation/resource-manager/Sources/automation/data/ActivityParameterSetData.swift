// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ActivityParameterSetData : ActivityParameterSetProtocol {
    public var name: String?
    public var parameters: [ActivityParameterProtocol?]?

        enum CodingKeys: String, CodingKey {case name = "name"
        case parameters = "parameters"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.parameters) {
        self.parameters = try container.decode([ActivityParameterData?]?.self, forKey: .parameters)
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
    if self.parameters != nil {try container.encode(self.parameters as! [ActivityParameterData?]?, forKey: .parameters)}
  }
}

extension DataFactory {
  public static func createActivityParameterSetProtocol() -> ActivityParameterSetProtocol {
    return ActivityParameterSetData()
  }
}
