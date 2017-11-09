import Foundation
public struct VirtualNetworkRuleType : VirtualNetworkRuleTypeProtocol {
    public var id: String?
    public var action: ActionEnum?
    public var state: StateEnum?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case action = "action"
        case state = "state"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.action) {
        action = try container.decode(ActionEnum?.self, forKey: .action)
    }
    if container.contains(.state) {
        state = try container.decode(StateEnum?.self, forKey: .state)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(action as! ActionEnum?, forKey: .action)
    try container.encode(state as! StateEnum?, forKey: .state)
  }
}
