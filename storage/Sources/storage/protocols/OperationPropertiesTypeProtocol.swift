import Foundation
// OperationPropertiesTypeProtocol is properties of operation, include metric specifications.
public protocol OperationPropertiesTypeProtocol : Codable {
     var serviceSpecification: ServiceSpecificationTypeProtocol? { get set }
}
