import Foundation
// DimensionTypeProtocol is dimension of blobs, possiblly be blob type or access tier.
public protocol DimensionTypeProtocol : Codable {
     var name: String? { get set }
     var displayName: String? { get set }
}
