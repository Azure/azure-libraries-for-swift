import Foundation
// IdentityTypeProtocol is identity for the resource.
public protocol IdentityTypeProtocol : Codable {
     var principalId: String? { get set }
     var tenantId: String? { get set }
     var type: String? { get set }
}
