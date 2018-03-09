// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct OperationsMonitoringPropertiesData : OperationsMonitoringPropertiesProtocol {
    public var events: [String:OperationMonitoringLevelEnum?]?

        enum CodingKeys: String, CodingKey {case events = "events"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.events) {
        self.events = try container.decode([String:OperationMonitoringLevelEnum?]?.self, forKey: .events)
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
    if self.events != nil {try container.encode(self.events, forKey: .events)}
  }
}

extension DataFactory {
  public static func createOperationsMonitoringPropertiesProtocol() -> OperationsMonitoringPropertiesProtocol {
    return OperationsMonitoringPropertiesData()
  }
}