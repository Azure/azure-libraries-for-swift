// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct PerfMonSetData : PerfMonSetProtocol {
    public var name: String?
    public var startTime: Date?
    public var endTime: Date?
    public var timeGrain: String?
    public var values: [PerfMonSampleProtocol?]?

        enum CodingKeys: String, CodingKey {case name = "name"
        case startTime = "startTime"
        case endTime = "endTime"
        case timeGrain = "timeGrain"
        case values = "values"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.startTime) {
        self.startTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .startTime)), format: .dateTime)
    }
    if container.contains(.endTime) {
        self.endTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .endTime)), format: .dateTime)
    }
    if container.contains(.timeGrain) {
        self.timeGrain = try container.decode(String?.self, forKey: .timeGrain)
    }
    if container.contains(.values) {
        self.values = try container.decode([PerfMonSampleData?]?.self, forKey: .values)
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
    if self.startTime != nil {
        try container.encode(DateConverter.toString(date: self.startTime!, format: .dateTime), forKey: .startTime)
    }
    if self.endTime != nil {
        try container.encode(DateConverter.toString(date: self.endTime!, format: .dateTime), forKey: .endTime)
    }
    if self.timeGrain != nil {try container.encode(self.timeGrain, forKey: .timeGrain)}
    if self.values != nil {try container.encode(self.values as! [PerfMonSampleData?]?, forKey: .values)}
  }
}

extension DataFactory {
  public static func createPerfMonSetProtocol() -> PerfMonSetProtocol {
    return PerfMonSetData()
  }
}