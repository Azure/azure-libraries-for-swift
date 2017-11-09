import Foundation
public struct CustomDomainType : CustomDomainTypeProtocol {
    public var name: String?
    public var useSubDomain: Bool?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case useSubDomain = "useSubDomain"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.useSubDomain) {
        useSubDomain = try container.decode(Bool?.self, forKey: .useSubDomain)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(useSubDomain, forKey: .useSubDomain)
  }
}
