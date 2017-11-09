import Foundation
public struct IPRuleType : IPRuleTypeProtocol {
    public var value: String?
    public var action: ActionEnum?

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case action = "action"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.value) {
        value = try container.decode(String?.self, forKey: .value)
    }
    if container.contains(.action) {
        action = try container.decode(ActionEnum?.self, forKey: .action)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
    try container.encode(action as! ActionEnum?, forKey: .action)
  }
}
