import Foundation
public struct OperationListResultType : OperationListResultTypeProtocol {
    public var value: [OperationTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.value) {
        value = try container.decode([OperationType?]?.self, forKey: .value)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value as! [OperationType?]?, forKey: .value)
  }
}
