import Foundation
// MetricSpecificationTypeProtocol is metric specification of operation.
public protocol MetricSpecificationTypeProtocol : Codable {
     var name: String? { get set }
     var displayName: String? { get set }
     var displayDescription: String? { get set }
     var unit: String? { get set }
     var dimensions: [DimensionTypeProtocol?]? { get set }
     var aggregationType: String? { get set }
     var fillGapWithZero: Bool? { get set }
     var category: String? { get set }
     var resourceIdDimensionNameOverride: String? { get set }
}
