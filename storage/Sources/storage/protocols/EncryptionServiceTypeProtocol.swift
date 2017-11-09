import Foundation
// EncryptionServiceTypeProtocol is a service that allows server-side encryption to be used.
public protocol EncryptionServiceTypeProtocol : Codable {
     var enabled: Bool? { get set }
     var lastEnabledTime: String? { get set }
}
