import Foundation
// ResourceTypeProtocol is describes a storage resource.
public protocol ResourceTypeProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var type: String? { get set }
     var location: String? { get set }
     var tags: [String:String?]? { get set }
}
