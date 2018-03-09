// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RecommendedElasticPoolPropertiesData : RecommendedElasticPoolPropertiesProtocol {
    public var databaseEdition: ElasticPoolEditionEnum?
    public var dtu: Double?
    public var databaseDtuMin: Double?
    public var databaseDtuMax: Double?
    public var storageMB: Double?
    public var observationPeriodStart: Date?
    public var observationPeriodEnd: Date?
    public var maxObservedDtu: Double?
    public var maxObservedStorageMB: Double?
    public var databases: [DatabaseProtocol?]?
    public var metrics: [RecommendedElasticPoolMetricProtocol?]?

        enum CodingKeys: String, CodingKey {case databaseEdition = "databaseEdition"
        case dtu = "dtu"
        case databaseDtuMin = "databaseDtuMin"
        case databaseDtuMax = "databaseDtuMax"
        case storageMB = "storageMB"
        case observationPeriodStart = "observationPeriodStart"
        case observationPeriodEnd = "observationPeriodEnd"
        case maxObservedDtu = "maxObservedDtu"
        case maxObservedStorageMB = "maxObservedStorageMB"
        case databases = "databases"
        case metrics = "metrics"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.databaseEdition) {
        self.databaseEdition = try container.decode(ElasticPoolEditionEnum?.self, forKey: .databaseEdition)
    }
    if container.contains(.dtu) {
        self.dtu = try container.decode(Double?.self, forKey: .dtu)
    }
    if container.contains(.databaseDtuMin) {
        self.databaseDtuMin = try container.decode(Double?.self, forKey: .databaseDtuMin)
    }
    if container.contains(.databaseDtuMax) {
        self.databaseDtuMax = try container.decode(Double?.self, forKey: .databaseDtuMax)
    }
    if container.contains(.storageMB) {
        self.storageMB = try container.decode(Double?.self, forKey: .storageMB)
    }
    if container.contains(.observationPeriodStart) {
        self.observationPeriodStart = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .observationPeriodStart)), format: .dateTime)
    }
    if container.contains(.observationPeriodEnd) {
        self.observationPeriodEnd = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .observationPeriodEnd)), format: .dateTime)
    }
    if container.contains(.maxObservedDtu) {
        self.maxObservedDtu = try container.decode(Double?.self, forKey: .maxObservedDtu)
    }
    if container.contains(.maxObservedStorageMB) {
        self.maxObservedStorageMB = try container.decode(Double?.self, forKey: .maxObservedStorageMB)
    }
    if container.contains(.databases) {
        self.databases = try container.decode([DatabaseData?]?.self, forKey: .databases)
    }
    if container.contains(.metrics) {
        self.metrics = try container.decode([RecommendedElasticPoolMetricData?]?.self, forKey: .metrics)
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
    if self.databaseEdition != nil {try container.encode(self.databaseEdition, forKey: .databaseEdition)}
    if self.dtu != nil {try container.encode(self.dtu, forKey: .dtu)}
    if self.databaseDtuMin != nil {try container.encode(self.databaseDtuMin, forKey: .databaseDtuMin)}
    if self.databaseDtuMax != nil {try container.encode(self.databaseDtuMax, forKey: .databaseDtuMax)}
    if self.storageMB != nil {try container.encode(self.storageMB, forKey: .storageMB)}
    if self.observationPeriodStart != nil {
        try container.encode(DateConverter.toString(date: self.observationPeriodStart!, format: .dateTime), forKey: .observationPeriodStart)
    }
    if self.observationPeriodEnd != nil {
        try container.encode(DateConverter.toString(date: self.observationPeriodEnd!, format: .dateTime), forKey: .observationPeriodEnd)
    }
    if self.maxObservedDtu != nil {try container.encode(self.maxObservedDtu, forKey: .maxObservedDtu)}
    if self.maxObservedStorageMB != nil {try container.encode(self.maxObservedStorageMB, forKey: .maxObservedStorageMB)}
    if self.databases != nil {try container.encode(self.databases as! [DatabaseData?]?, forKey: .databases)}
    if self.metrics != nil {try container.encode(self.metrics as! [RecommendedElasticPoolMetricData?]?, forKey: .metrics)}
  }
}

extension DataFactory {
  public static func createRecommendedElasticPoolPropertiesProtocol() -> RecommendedElasticPoolPropertiesProtocol {
    return RecommendedElasticPoolPropertiesData()
  }
}