import Foundation
// EncryptionTypeProtocol is the encryption settings on the storage account.
public protocol EncryptionTypeProtocol : Codable {
     var services: EncryptionServicesTypeProtocol? { get set }
     var keySource: KeySourceEnum? { get set }
     var keyvaultproperties: KeyVaultPropertiesTypeProtocol? { get set }
}
