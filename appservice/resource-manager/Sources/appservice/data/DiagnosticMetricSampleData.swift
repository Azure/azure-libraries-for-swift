// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DiagnosticMetricSampleData : DiagnosticMetricSampleProtocol {
    public var timestamp: Date?
    public var roleInstance: String?
    public var total: Double?
    public var maximum: Double?
    public var minimum: Double?
    public var isAggregated: Bool?

        enum CodingKeys: String, CodingKey {case timestamp = "timestamp"
        case roleInstance = "roleInstance"
        case total = "total"
        case maximum = "maximum"
        case minimum = "minimum"
        case isAggregated = "isAggregated"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.timestamp) {
        self.timestamp = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .timestamp)), format: .dateTime)
    }
    if container.contains(.roleInstance) {
        self.roleInstance = try container.decode(String?.self, forKey: .roleInstance)
    }
    if container.contains(.total) {
        self.total = try container.decode(Double?.self, forKey: .total)
    }
    if container.contains(.maximum) {
        self.maximum = try container.decode(Double?.self, forKey: .maximum)
    }
    if container.contains(.minimum) {
        self.minimum = try container.decode(Double?.self, forKey: .minimum)
    }
    if container.contains(.isAggregated) {
        self.isAggregated = try container.decode(Bool?.self, forKey: .isAggregated)
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
    if self.timestamp != nil {
        try container.encode(DateConverter.toString(date: self.timestamp!, format: .dateTime), forKey: .timestamp)
    }
    if self.roleInstance != nil {try container.encode(self.roleInstance, forKey: .roleInstance)}
    if self.total != nil {try container.encode(self.total, forKey: .total)}
    if self.maximum != nil {try container.encode(self.maximum, forKey: .maximum)}
    if self.minimum != nil {try container.encode(self.minimum, forKey: .minimum)}
    if self.isAggregated != nil {try container.encode(self.isAggregated, forKey: .isAggregated)}
  }
}

extension DataFactory {
  public static func createDiagnosticMetricSampleProtocol() -> DiagnosticMetricSampleProtocol {
    return DiagnosticMetricSampleData()
  }
}
