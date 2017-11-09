import Foundation
public struct EncryptionServiceType : EncryptionServiceTypeProtocol {
    public var enabled: Bool?
    public var lastEnabledTime: String?

    enum CodingKeys: String, CodingKey {
        case enabled = "enabled"
        case lastEnabledTime = "lastEnabledTime"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.enabled) {
        enabled = try container.decode(Bool?.self, forKey: .enabled)
    }
    if container.contains(.lastEnabledTime) {
        lastEnabledTime = try container.decode(String?.self, forKey: .lastEnabledTime)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(enabled, forKey: .enabled)
    try container.encode(lastEnabledTime, forKey: .lastEnabledTime)
  }
}
