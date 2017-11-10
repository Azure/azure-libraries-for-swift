import Foundation
public struct StorageAccountListKeysResultType : StorageAccountListKeysResultTypeProtocol {
    public var keys: [StorageAccountKeyTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case keys = "keys"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.keys) {
        keys = try container.decode([StorageAccountKeyType?]?.self, forKey: .keys)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.keys != nil {try container.encode(keys as! [StorageAccountKeyType?]?, forKey: .keys)}
  }
}
