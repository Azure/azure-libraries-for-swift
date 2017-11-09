import Foundation
public struct StorageAccountCheckNameAvailabilityParametersType : StorageAccountCheckNameAvailabilityParametersTypeProtocol {
    public var name: String?
    public var type: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(type, forKey: .type)
  }
}
