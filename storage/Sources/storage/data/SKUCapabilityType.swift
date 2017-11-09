import Foundation
public struct SKUCapabilityType : SKUCapabilityTypeProtocol {
    public var name: String?
    public var value: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.value) {
        value = try container.decode(String?.self, forKey: .value)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(value, forKey: .value)
  }
}
