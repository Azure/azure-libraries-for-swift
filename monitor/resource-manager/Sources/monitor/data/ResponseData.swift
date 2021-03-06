// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ResponseData : ResponseProtocol {
    public var cost: Double?
    public var timespan: String
    public var interval: String?
    public var namespace: String?
    public var resourceregion: String?
    public var value: [MetricProtocol]

        enum CodingKeys: String, CodingKey {case cost = "cost"
        case timespan = "timespan"
        case interval = "interval"
        case namespace = "namespace"
        case resourceregion = "resourceregion"
        case value = "value"
        }

  public init(timespan: String, value: [MetricProtocol])  {
    self.timespan = timespan
    self.value = value
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.cost) {
        self.cost = try container.decode(Double?.self, forKey: .cost)
    }
    self.timespan = try container.decode(String.self, forKey: .timespan)
    if container.contains(.interval) {
        self.interval = try container.decode(String?.self, forKey: .interval)
    }
    if container.contains(.namespace) {
        self.namespace = try container.decode(String?.self, forKey: .namespace)
    }
    if container.contains(.resourceregion) {
        self.resourceregion = try container.decode(String?.self, forKey: .resourceregion)
    }
    self.value = try container.decode([MetricData].self, forKey: .value)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.cost != nil {try container.encode(self.cost, forKey: .cost)}
    try container.encode(self.timespan, forKey: .timespan)
    if self.interval != nil {try container.encode(self.interval, forKey: .interval)}
    if self.namespace != nil {try container.encode(self.namespace, forKey: .namespace)}
    if self.resourceregion != nil {try container.encode(self.resourceregion, forKey: .resourceregion)}
    try container.encode(self.value as! [MetricData], forKey: .value)
  }
}

extension DataFactory {
  public static func createResponseProtocol(timespan: String, value: [MetricProtocol]) -> ResponseProtocol {
    return ResponseData(timespan: timespan, value: value)
  }
}
