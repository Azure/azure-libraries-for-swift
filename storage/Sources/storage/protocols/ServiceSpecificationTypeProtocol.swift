import Foundation
// ServiceSpecificationTypeProtocol is one property of operation, include metric specifications.
public protocol ServiceSpecificationTypeProtocol : Codable {
     var metricSpecifications: [MetricSpecificationTypeProtocol?]? { get set }
}
