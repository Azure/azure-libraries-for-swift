import Foundation
public struct OperationPropertiesType : OperationPropertiesTypeProtocol {
    public var serviceSpecification: ServiceSpecificationTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case serviceSpecification = "serviceSpecification"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.serviceSpecification) {
        serviceSpecification = try container.decode(ServiceSpecificationType?.self, forKey: .serviceSpecification)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(serviceSpecification as! ServiceSpecificationType?, forKey: .serviceSpecification)
  }
}
