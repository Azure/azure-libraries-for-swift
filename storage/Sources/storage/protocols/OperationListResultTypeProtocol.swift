import Foundation
// OperationListResultTypeProtocol is result of the request to list Storage operations. It contains a list of
// operations and a URL link to get the next set of results.
public protocol OperationListResultTypeProtocol : Codable {
     var value: [OperationTypeProtocol?]? { get set }
}
