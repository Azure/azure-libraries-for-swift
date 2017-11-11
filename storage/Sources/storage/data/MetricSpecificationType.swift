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
    if self.name != nil {try container.encode(name, forKey: .name)}
    if self.displayName != nil {try container.encode(displayName, forKey: .displayName)}
    if self.displayDescription != nil {try container.encode(displayDescription, forKey: .displayDescription)}
    if self.unit != nil {try container.encode(unit, forKey: .unit)}
    if self.dimensions != nil {try container.encode(dimensions as! [DimensionType?]?, forKey: .dimensions)}
    if self.aggregationType != nil {try container.encode(aggregationType, forKey: .aggregationType)}
    if self.fillGapWithZero != nil {try container.encode(fillGapWithZero, forKey: .fillGapWithZero)}
    if self.category != nil {try container.encode(category, forKey: .category)}
    if self.resourceIdDimensionNameOverride != nil {try container.encode(resourceIdDimensionNameOverride, forKey: .resourceIdDimensionNameOverride)}
  }
}
