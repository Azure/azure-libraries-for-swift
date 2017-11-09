import Foundation
// OperationTypeProtocol is storage REST API operation definition.
public protocol OperationTypeProtocol : Codable {
     var name: String? { get set }
     var display: OperationDisplayTypeProtocol? { get set }
     var origin: String? { get set }
     var properties: OperationPropertiesTypeProtocol? { get set }
}
