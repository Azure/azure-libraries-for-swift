import Foundation
public struct RestrictionType : RestrictionTypeProtocol {
    public var type: String?
    public var values: [String??]?
    public var reasonCode: ReasonCodeEnum?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case values = "values"
        case reasonCode = "reasonCode"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
    if container.contains(.values) {
        values = try container.decode([String?]?.self, forKey: .values)
    }
    if container.contains(.reasonCode) {
        reasonCode = try container.decode(ReasonCodeEnum?.self, forKey: .reasonCode)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.type != nil {try container.encode(type, forKey: .type)}
    if self.values != nil {try container.encode(values as! [String?]?, forKey: .values)}
    if self.reasonCode != nil {try container.encode(reasonCode, forKey: .reasonCode)}
  }
}
