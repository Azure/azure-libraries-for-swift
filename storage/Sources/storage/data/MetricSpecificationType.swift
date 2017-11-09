import Foundation
public struct MetricSpecificationType : MetricSpecificationTypeProtocol {
    public var name: String?
    public var displayName: String?
    public var displayDescription: String?
    public var unit: String?
    public var dimensions: [DimensionTypeProtocol?]?
    public var aggregationType: String?
    public var fillGapWithZero: Bool?
    public var category: String?
    public var resourceIdDimensionNameOverride: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case displayName = "displayName"
        case displayDescription = "displayDescription"
        case unit = "unit"
        case dimensions = "dimensions"
        case aggregationType = "aggregationType"
        case fillGapWithZero = "fillGapWithZero"
        case category = "category"
        case resourceIdDimensionNameOverride = "resourceIdDimensionNameOverride"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.displayName) {
        displayName = try container.decode(String?.self, forKey: .displayName)
    }
    if container.contains(.displayDescription) {
        displayDescription = try container.decode(String?.self, forKey: .displayDescription)
    }
    if container.contains(.unit) {
        unit = try container.decode(String?.self, forKey: .unit)
    }
    if container.contains(.dimensions) {
        dimensions = try container.decode([DimensionType?]?.self, forKey: .dimensions)
    }
    if container.contains(.aggregationType) {
        aggregationType = try container.decode(String?.self, forKey: .aggregationType)
    }
    if container.contains(.fillGapWithZero) {
        fillGapWithZero = try container.decode(Bool?.self, forKey: .fillGapWithZero)
    }
    if container.contains(.category) {
        category = try container.decode(String?.self, forKey: .category)
    }
    if container.contains(.resourceIdDimensionNameOverride) {
        resourceIdDimensionNameOverride = try container.decode(String?.self, forKey: .resourceIdDimensionNameOverride)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(displayName, forKey: .displayName)
    try container.encode(displayDescription, forKey: .displayDescription)
    try container.encode(unit, forKey: .unit)
    try container.encode(dimensions as! [DimensionType?]?, forKey: .dimensions)
    try container.encode(aggregationType, forKey: .aggregationType)
    try container.encode(fillGapWithZero, forKey: .fillGapWithZero)
    try container.encode(category, forKey: .category)
    try container.encode(resourceIdDimensionNameOverride, forKey: .resourceIdDimensionNameOverride)
  }
}
