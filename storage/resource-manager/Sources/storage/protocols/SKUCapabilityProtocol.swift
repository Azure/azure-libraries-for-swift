// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
// SKUCapabilityProtocol is the capability information in the specified sku, including file encryption, network acls,
// change notification, etc.
public protocol SKUCapabilityProtocol : Codable {
     var name: String? { get set }
     var value: String? { get set }
}