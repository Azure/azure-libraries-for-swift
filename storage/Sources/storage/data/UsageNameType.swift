import Foundation
public struct UsageNameType : UsageNameTypeProtocol {
    public var value: String?
    public var localizedValue: String?

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case localizedValue = "localizedValue"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.value) {
        value = try container.decode(String?.self, forKey: .value)
    }
    if container.contains(.localizedValue) {
        localizedValue = try container.decode(String?.self, forKey: .localizedValue)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.value != nil {try container.encode(value, forKey: .value)}
    if self.localizedValue != nil {try container.encode(localizedValue, forKey: .localizedValue)}
  }
}
