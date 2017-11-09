import Foundation
// StorageAccountUpdateParametersTypeProtocol is the parameters that can be provided when updating the storage account
// properties.
public protocol StorageAccountUpdateParametersTypeProtocol : Codable {
     var sku: SkuTypeProtocol? { get set }
     var tags: [String:String?]? { get set }
     var identity: IdentityTypeProtocol? { get set }
     var properties: StorageAccountPropertiesUpdateParametersTypeProtocol? { get set }
}
