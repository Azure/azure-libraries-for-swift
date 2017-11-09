import Foundation
// NetworkRuleSetTypeProtocol is network rule set
public protocol NetworkRuleSetTypeProtocol : Codable {
     var bypass: BypassEnum? { get set }
     var virtualNetworkRules: [VirtualNetworkRuleTypeProtocol?]? { get set }
     var ipRules: [IPRuleTypeProtocol?]? { get set }
     var defaultAction: DefaultActionEnum? { get set }
}
