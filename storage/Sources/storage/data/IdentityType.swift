import Foundation
public struct IdentityType : IdentityTypeProtocol {
    public var principalId: String?
    public var tenantId: String?
    public var type: String?

    enum CodingKeys: String, CodingKey {
        case principalId = "principalId"
        case tenantId = "tenantId"
        case type = "type"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.principalId) {
        principalId = try container.decode(String?.self, forKey: .principalId)
    }
    if container.contains(.tenantId) {
        tenantId = try container.decode(String?.self, forKey: .tenantId)
    }
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(principalId, forKey: .principalId)
    try container.encode(tenantId, forKey: .tenantId)
    try container.encode(type, forKey: .type)
  }
}
