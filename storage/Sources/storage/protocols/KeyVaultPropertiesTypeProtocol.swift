import Foundation
// KeyVaultPropertiesTypeProtocol is properties of key vault.
public protocol KeyVaultPropertiesTypeProtocol : Codable {
     var keyname: String? { get set }
     var keyversion: String? { get set }
     var keyvaulturi: String? { get set }
}
