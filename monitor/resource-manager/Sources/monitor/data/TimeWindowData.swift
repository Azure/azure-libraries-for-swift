// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct TimeWindowData : TimeWindowProtocol {
    public var timeZone: String?
    public var start: Date
    public var end: Date

        enum CodingKeys: String, CodingKey {case timeZone = "timeZone"
        case start = "start"
        case end = "end"
        }

  public init(start: Date, end: Date)  {
    self.start = start
    self.end = end
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.timeZone) {
        self.timeZone = try container.decode(String?.self, forKey: .timeZone)
    }
        self.start = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .start)), format: .dateTime)!
        self.end = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .end)), format: .dateTime)!
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.timeZone != nil {try container.encode(self.timeZone, forKey: .timeZone)}
    try container.encode(DateConverter.toString(date: self.start, format: .dateTime), forKey: .start)
    try container.encode(DateConverter.toString(date: self.end, format: .dateTime), forKey: .end)
  }
}

extension DataFactory {
  public static func createTimeWindowProtocol(start: Date, end: Date) -> TimeWindowProtocol {
    return TimeWindowData(start: start, end: end)
  }
}