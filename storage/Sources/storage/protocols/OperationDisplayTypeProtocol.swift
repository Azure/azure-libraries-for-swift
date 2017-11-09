import Foundation
// OperationDisplayTypeProtocol is display metadata associated with the operation.
public protocol OperationDisplayTypeProtocol : Codable {
     var provider: String? { get set }
     var resource: String? { get set }
     var operation: String? { get set }
}
