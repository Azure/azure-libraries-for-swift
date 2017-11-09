import Foundation
// StorageAccountCheckNameAvailabilityParametersTypeProtocol is the parameters used to check the availabity of the
// storage account name.
public protocol StorageAccountCheckNameAvailabilityParametersTypeProtocol : Codable {
     var name: String? { get set }
     var type: String? { get set }
}
