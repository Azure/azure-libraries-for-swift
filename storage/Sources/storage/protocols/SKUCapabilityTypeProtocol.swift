import Foundation
// SKUCapabilityTypeProtocol is the capability information in the specified sku, including file encryption, network
// acls, change notification, etc.
public protocol SKUCapabilityTypeProtocol : Codable {
     var name: String? { get set }
     var value: String? { get set }
}
