import Foundation
public struct ListServiceSasResponseType : ListServiceSasResponseTypeProtocol {
    public var serviceSasToken: String?

    enum CodingKeys: String, CodingKey {
        case serviceSasToken = "serviceSasToken"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.serviceSasToken) {
        serviceSasToken = try container.decode(String?.self, forKey: .serviceSasToken)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.serviceSasToken != nil {try container.encode(serviceSasToken, forKey: .serviceSasToken)}
  }
}
