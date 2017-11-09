import Foundation
// StorageSkuListResultTypeProtocol is the response from the List Storage SKUs operation.
public protocol StorageSkuListResultTypeProtocol : Codable {
     var value: [SkuTypeProtocol?]? { get set }
}
