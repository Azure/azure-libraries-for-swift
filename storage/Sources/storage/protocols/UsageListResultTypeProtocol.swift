import Foundation
// UsageListResultTypeProtocol is the response from the List Usages operation.
public protocol UsageListResultTypeProtocol : Codable {
     var value: [UsageTypeProtocol?]? { get set }
}
