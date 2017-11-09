import Foundation
// StorageAccountListResultTypeProtocol is the response from the List Storage Accounts operation.
public protocol StorageAccountListResultTypeProtocol : Codable {
     var value: [StorageAccountTypeProtocol?]? { get set }
}
