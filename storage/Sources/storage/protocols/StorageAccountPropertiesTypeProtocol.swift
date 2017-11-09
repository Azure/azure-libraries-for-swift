import Foundation
// StorageAccountPropertiesTypeProtocol is properties of the storage account.
public protocol StorageAccountPropertiesTypeProtocol : Codable {
     var provisioningState: ProvisioningStateEnum? { get set }
     var primaryEndpoints: EndpointsTypeProtocol? { get set }
     var primaryLocation: String? { get set }
     var statusOfPrimary: AccountStatusEnum? { get set }
     var lastGeoFailoverTime: String? { get set }
     var secondaryLocation: String? { get set }
     var statusOfSecondary: AccountStatusEnum? { get set }
     var creationTime: String? { get set }
     var customDomain: CustomDomainTypeProtocol? { get set }
     var secondaryEndpoints: EndpointsTypeProtocol? { get set }
     var encryption: EncryptionTypeProtocol? { get set }
     var accessTier: AccessTierEnum? { get set }
     var supportsHttpsTrafficOnly: Bool? { get set }
     var networkAcls: NetworkRuleSetTypeProtocol? { get set }
}
