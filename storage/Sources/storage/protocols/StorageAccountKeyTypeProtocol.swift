import Foundation
// StorageAccountKeyTypeProtocol is an access key for the storage account.
public protocol StorageAccountKeyTypeProtocol : Codable {
     var keyName: String? { get set }
     var value: String? { get set }
     var permissions: KeyPermissionEnum? { get set }
}
