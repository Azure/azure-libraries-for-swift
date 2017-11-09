import Foundation
// UsageNameTypeProtocol is the usage names that can be used; currently limited to StorageAccount.
public protocol UsageNameTypeProtocol : Codable {
     var value: String? { get set }
     var localizedValue: String? { get set }
}
