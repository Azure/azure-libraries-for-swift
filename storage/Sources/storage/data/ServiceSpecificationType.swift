import Foundation
public struct ServiceSpecificationType : ServiceSpecificationTypeProtocol {
    public var metricSpecifications: [MetricSpecificationTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case metricSpecifications = "metricSpecifications"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.metricSpecifications) {
        metricSpecifications = try container.decode([MetricSpecificationType?]?.self, forKey: .metricSpecifications)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(metricSpecifications as! [MetricSpecificationType?]?, forKey: .metricSpecifications)
  }
}
