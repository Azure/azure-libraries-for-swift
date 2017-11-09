import Foundation
public struct UsageType : UsageTypeProtocol {
    public var unit: UsageUnitEnum?
    public var currentValue: Int32?
    public var limit: Int32?
    public var name: UsageNameTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case unit = "unit"
        case currentValue = "currentValue"
        case limit = "limit"
        case name = "name"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.unit) {
        unit = try container.decode(UsageUnitEnum?.self, forKey: .unit)
    }
    if container.contains(.currentValue) {
        currentValue = try container.decode(Int32?.self, forKey: .currentValue)
    }
    if container.contains(.limit) {
        limit = try container.decode(Int32?.self, forKey: .limit)
    }
    if container.contains(.name) {
        name = try container.decode(UsageNameType?.self, forKey: .name)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(unit as! UsageUnitEnum?, forKey: .unit)
    try container.encode(currentValue, forKey: .currentValue)
    try container.encode(limit, forKey: .limit)
    try container.encode(name as! UsageNameType?, forKey: .name)
  }
}
