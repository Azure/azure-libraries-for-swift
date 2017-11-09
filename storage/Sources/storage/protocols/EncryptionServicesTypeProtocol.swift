import Foundation
// EncryptionServicesTypeProtocol is a list of services that support encryption.
public protocol EncryptionServicesTypeProtocol : Codable {
     var blob: EncryptionServiceTypeProtocol? { get set }
     var file: EncryptionServiceTypeProtocol? { get set }
     var table: EncryptionServiceTypeProtocol? { get set }
     var queue: EncryptionServiceTypeProtocol? { get set }
}
