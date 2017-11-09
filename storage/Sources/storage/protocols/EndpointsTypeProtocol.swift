import Foundation
// EndpointsTypeProtocol is the URIs that are used to perform a retrieval of a public blob, queue, or table object.
public protocol EndpointsTypeProtocol : Codable {
     var blob: String? { get set }
     var queue: String? { get set }
     var table: String? { get set }
     var file: String? { get set }
}
