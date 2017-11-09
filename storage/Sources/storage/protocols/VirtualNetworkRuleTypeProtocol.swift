import Foundation
// VirtualNetworkRuleTypeProtocol is virtual Network rule.
public protocol VirtualNetworkRuleTypeProtocol : Codable {
     var id: String? { get set }
     var action: ActionEnum? { get set }
     var state: StateEnum? { get set }
}
