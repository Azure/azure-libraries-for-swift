import Foundation
public struct NetworkRuleSetType : NetworkRuleSetTypeProtocol {
    public var bypass: BypassEnum?
    public var virtualNetworkRules: [VirtualNetworkRuleTypeProtocol?]?
    public var ipRules: [IPRuleTypeProtocol?]?
    public var defaultAction: DefaultActionEnum?

    enum CodingKeys: String, CodingKey {
        case bypass = "bypass"
        case virtualNetworkRules = "virtualNetworkRules"
        case ipRules = "ipRules"
        case defaultAction = "defaultAction"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.bypass) {
        bypass = try container.decode(BypassEnum?.self, forKey: .bypass)
    }
    if container.contains(.virtualNetworkRules) {
        virtualNetworkRules = try container.decode([VirtualNetworkRuleType?]?.self, forKey: .virtualNetworkRules)
    }
    if container.contains(.ipRules) {
        ipRules = try container.decode([IPRuleType?]?.self, forKey: .ipRules)
    }
    if container.contains(.defaultAction) {
        defaultAction = try container.decode(DefaultActionEnum?.self, forKey: .defaultAction)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.bypass != nil {try container.encode(bypass, forKey: .bypass)}
    if self.virtualNetworkRules != nil {try container.encode(virtualNetworkRules as! [VirtualNetworkRuleType?]?, forKey: .virtualNetworkRules)}
    if self.ipRules != nil {try container.encode(ipRules as! [IPRuleType?]?, forKey: .ipRules)}
    if self.defaultAction != nil {try container.encode(defaultAction, forKey: .defaultAction)}
  }
}
