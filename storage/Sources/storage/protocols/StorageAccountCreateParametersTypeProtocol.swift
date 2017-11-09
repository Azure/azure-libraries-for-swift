import Foundation
// StorageAccountCreateParametersTypeProtocol is the parameters used when creating a storage account.
public protocol StorageAccountCreateParametersTypeProtocol : Codable {
     var sku: SkuTypeProtocol? { get set }
     var kind: KindEnum? { get set }
     var location: String? { get set }
     var tags: [String:String?]? { get set }
     var identity: IdentityTypeProtocol? { get set }
     var properties: StorageAccountPropertiesCreateParametersTypeProtocol? { get set }
}
