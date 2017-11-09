import Foundation
// RestrictionTypeProtocol is the restriction because of which SKU cannot be used.
public protocol RestrictionTypeProtocol : Codable {
     var type: String? { get set }
     var values: [String??]? { get set }
     var reasonCode: ReasonCodeEnum? { get set }
}
