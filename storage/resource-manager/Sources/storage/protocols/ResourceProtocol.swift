// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
// ResourceProtocol is describes a storage resource.
public protocol ResourceProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var type: String? { get set }
     var location: String? { get set }
     var tags: [String:String]? { get set }
}