import Foundation
// StorageAccountPropertiesCreateParametersTypeProtocol is the parameters used to create the storage account.
public protocol StorageAccountPropertiesCreateParametersTypeProtocol : Codable {
     var customDomain: CustomDomainTypeProtocol? { get set }
     var encryption: EncryptionTypeProtocol? { get set }
     var networkAcls: NetworkRuleSetTypeProtocol? { get set }
     var accessTier: AccessTierEnum? { get set }
     var supportsHttpsTrafficOnly: Bool? { get set }
}
