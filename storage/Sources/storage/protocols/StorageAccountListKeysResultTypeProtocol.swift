import Foundation
// StorageAccountListKeysResultTypeProtocol is the response from the ListKeys operation.
public protocol StorageAccountListKeysResultTypeProtocol : Codable {
     var keys: [StorageAccountKeyTypeProtocol?]? { get set }
}
