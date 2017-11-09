import Foundation
// StorageAccountPropertiesUpdateParametersTypeProtocol is the parameters used when updating a storage account.
public protocol StorageAccountPropertiesUpdateParametersTypeProtocol : Codable {
     var customDomain: CustomDomainTypeProtocol? { get set }
     var encryption: EncryptionTypeProtocol? { get set }
     var accessTier: AccessTierEnum? { get set }
     var supportsHttpsTrafficOnly: Bool? { get set }
     var networkAcls: NetworkRuleSetTypeProtocol? { get set }
}
