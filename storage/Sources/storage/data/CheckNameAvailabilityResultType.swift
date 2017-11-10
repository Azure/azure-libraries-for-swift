import Foundation
public struct CheckNameAvailabilityResultType : CheckNameAvailabilityResultTypeProtocol {
    public var nameAvailable: Bool?
    public var reason: ReasonEnum?
    public var message: String?

    enum CodingKeys: String, CodingKey {
        case nameAvailable = "nameAvailable"
        case reason = "reason"
        case message = "message"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.nameAvailable) {
        nameAvailable = try container.decode(Bool?.self, forKey: .nameAvailable)
    }
    if container.contains(.reason) {
        reason = try container.decode(ReasonEnum?.self, forKey: .reason)
    }
    if container.contains(.message) {
        message = try container.decode(String?.self, forKey: .message)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.nameAvailable != nil {try container.encode(nameAvailable, forKey: .nameAvailable)}
    if self.reason != nil {try container.encode(reason, forKey: .reason)}
    if self.message != nil {try container.encode(message, forKey: .message)}
  }
}
