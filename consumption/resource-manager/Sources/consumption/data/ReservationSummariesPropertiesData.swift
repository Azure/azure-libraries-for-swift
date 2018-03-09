// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ReservationSummariesPropertiesData : ReservationSummariesPropertiesProtocol {
    public var reservationOrderId: String?
    public var reservationId: String?
    public var skuName: String?
    public var reservedHours: Decimal?
    public var usageDate: Date?
    public var usedHours: Decimal?
    public var minUtilizationPercentage: Decimal?
    public var avgUtilizationPercentage: Decimal?
    public var maxUtilizationPercentage: Decimal?

        enum CodingKeys: String, CodingKey {case reservationOrderId = "reservationOrderId"
        case reservationId = "reservationId"
        case skuName = "skuName"
        case reservedHours = "reservedHours"
        case usageDate = "usageDate"
        case usedHours = "usedHours"
        case minUtilizationPercentage = "minUtilizationPercentage"
        case avgUtilizationPercentage = "avgUtilizationPercentage"
        case maxUtilizationPercentage = "maxUtilizationPercentage"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.reservationOrderId) {
        self.reservationOrderId = try container.decode(String?.self, forKey: .reservationOrderId)
    }
    if container.contains(.reservationId) {
        self.reservationId = try container.decode(String?.self, forKey: .reservationId)
    }
    if container.contains(.skuName) {
        self.skuName = try container.decode(String?.self, forKey: .skuName)
    }
    if container.contains(.reservedHours) {
        self.reservedHours = try container.decode(Decimal?.self, forKey: .reservedHours)
    }
    if container.contains(.usageDate) {
        self.usageDate = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .usageDate)), format: .dateTime)
    }
    if container.contains(.usedHours) {
        self.usedHours = try container.decode(Decimal?.self, forKey: .usedHours)
    }
    if container.contains(.minUtilizationPercentage) {
        self.minUtilizationPercentage = try container.decode(Decimal?.self, forKey: .minUtilizationPercentage)
    }
    if container.contains(.avgUtilizationPercentage) {
        self.avgUtilizationPercentage = try container.decode(Decimal?.self, forKey: .avgUtilizationPercentage)
    }
    if container.contains(.maxUtilizationPercentage) {
        self.maxUtilizationPercentage = try container.decode(Decimal?.self, forKey: .maxUtilizationPercentage)
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
    if self.reservationOrderId != nil {try container.encode(self.reservationOrderId, forKey: .reservationOrderId)}
    if self.reservationId != nil {try container.encode(self.reservationId, forKey: .reservationId)}
    if self.skuName != nil {try container.encode(self.skuName, forKey: .skuName)}
    if self.reservedHours != nil {try container.encode(self.reservedHours, forKey: .reservedHours)}
    if self.usageDate != nil {
        try container.encode(DateConverter.toString(date: self.usageDate!, format: .dateTime), forKey: .usageDate)
    }
    if self.usedHours != nil {try container.encode(self.usedHours, forKey: .usedHours)}
    if self.minUtilizationPercentage != nil {try container.encode(self.minUtilizationPercentage, forKey: .minUtilizationPercentage)}
    if self.avgUtilizationPercentage != nil {try container.encode(self.avgUtilizationPercentage, forKey: .avgUtilizationPercentage)}
    if self.maxUtilizationPercentage != nil {try container.encode(self.maxUtilizationPercentage, forKey: .maxUtilizationPercentage)}
  }
}

extension DataFactory {
  public static func createReservationSummariesPropertiesProtocol() -> ReservationSummariesPropertiesProtocol {
    return ReservationSummariesPropertiesData()
  }
}