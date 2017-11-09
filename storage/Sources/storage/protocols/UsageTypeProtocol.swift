import Foundation
// UsageTypeProtocol is describes Storage Resource Usage.
public protocol UsageTypeProtocol : Codable {
     var unit: UsageUnitEnum? { get set }
     var currentValue: Int32? { get set }
     var limit: Int32? { get set }
     var name: UsageNameTypeProtocol? { get set }
}
