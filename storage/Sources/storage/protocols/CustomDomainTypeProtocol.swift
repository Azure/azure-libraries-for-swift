import Foundation
// CustomDomainTypeProtocol is the custom domain assigned to this storage account. This can be set via Update.
public protocol CustomDomainTypeProtocol : Codable {
     var name: String? { get set }
     var useSubDomain: Bool? { get set }
}
