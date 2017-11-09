import Foundation
public struct ListAccountSasResponseType : ListAccountSasResponseTypeProtocol {
    public var accountSasToken: String?

    enum CodingKeys: String, CodingKey {
        case accountSasToken = "accountSasToken"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.accountSasToken) {
        accountSasToken = try container.decode(String?.self, forKey: .accountSasToken)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(accountSasToken, forKey: .accountSasToken)
  }
}
