import Foundation
// IPRuleTypeProtocol is IP rule with specific IP or IP range in CIDR format.
public protocol IPRuleTypeProtocol : Codable {
     var value: String? { get set }
     var action: ActionEnum? { get set }
}
