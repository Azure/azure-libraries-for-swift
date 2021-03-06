// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SlowRequestsBasedTriggerData : SlowRequestsBasedTriggerProtocol {
    public var timeTaken: String?
    public var count: Int32?
    public var timeInterval: String?

        enum CodingKeys: String, CodingKey {case timeTaken = "timeTaken"
        case count = "count"
        case timeInterval = "timeInterval"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.timeTaken) {
        self.timeTaken = try container.decode(String?.self, forKey: .timeTaken)
    }
    if container.contains(.count) {
        self.count = try container.decode(Int32?.self, forKey: .count)
    }
    if container.contains(.timeInterval) {
        self.timeInterval = try container.decode(String?.self, forKey: .timeInterval)
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
    if self.timeTaken != nil {try container.encode(self.timeTaken, forKey: .timeTaken)}
    if self.count != nil {try container.encode(self.count, forKey: .count)}
    if self.timeInterval != nil {try container.encode(self.timeInterval, forKey: .timeInterval)}
  }
}

extension DataFactory {
  public static func createSlowRequestsBasedTriggerProtocol() -> SlowRequestsBasedTriggerProtocol {
    return SlowRequestsBasedTriggerData()
  }
}
