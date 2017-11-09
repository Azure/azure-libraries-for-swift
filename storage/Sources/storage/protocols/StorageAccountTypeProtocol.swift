import Foundation
// StorageAccountTypeProtocol is the storage account.
public protocol StorageAccountTypeProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var type: String? { get set }
     var location: String? { get set }
     var tags: [String:String?]? { get set }
     var sku: SkuTypeProtocol? { get set }
     var kind: KindEnum? { get set }
     var identity: IdentityTypeProtocol? { get set }
     var properties: StorageAccountPropertiesTypeProtocol? { get set }
}
