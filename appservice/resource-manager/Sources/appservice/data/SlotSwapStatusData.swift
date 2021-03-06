// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SlotSwapStatusData : SlotSwapStatusProtocol {
    public var timestampUtc: Date?
    public var sourceSlotName: String?
    public var destinationSlotName: String?

        enum CodingKeys: String, CodingKey {case timestampUtc = "timestampUtc"
        case sourceSlotName = "sourceSlotName"
        case destinationSlotName = "destinationSlotName"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.timestampUtc) {
        self.timestampUtc = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .timestampUtc)), format: .dateTime)
    }
    if container.contains(.sourceSlotName) {
        self.sourceSlotName = try container.decode(String?.self, forKey: .sourceSlotName)
    }
    if container.contains(.destinationSlotName) {
        self.destinationSlotName = try container.decode(String?.self, forKey: .destinationSlotName)
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
    if self.timestampUtc != nil {
        try container.encode(DateConverter.toString(date: self.timestampUtc!, format: .dateTime), forKey: .timestampUtc)
    }
    if self.sourceSlotName != nil {try container.encode(self.sourceSlotName, forKey: .sourceSlotName)}
    if self.destinationSlotName != nil {try container.encode(self.destinationSlotName, forKey: .destinationSlotName)}
  }
}

extension DataFactory {
  public static func createSlotSwapStatusProtocol() -> SlotSwapStatusProtocol {
    return SlotSwapStatusData()
  }
}
