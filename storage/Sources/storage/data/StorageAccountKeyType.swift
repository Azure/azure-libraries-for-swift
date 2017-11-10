import Foundation
public struct StorageAccountKeyType : StorageAccountKeyTypeProtocol {
    public var keyName: String?
    public var value: String?
    public var permissions: KeyPermissionEnum?

    enum CodingKeys: String, CodingKey {
        case keyName = "keyName"
        case value = "value"
        case permissions = "permissions"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.keyName) {
        keyName = try container.decode(String?.self, forKey: .keyName)
    }
    if container.contains(.value) {
        value = try container.decode(String?.self, forKey: .value)
    }
    if container.contains(.permissions) {
        permissions = try container.decode(KeyPermissionEnum?.self, forKey: .permissions)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.keyName != nil {try container.encode(keyName, forKey: .keyName)}
    if self.value != nil {try container.encode(value, forKey: .value)}
    if self.permissions != nil {try container.encode(permissions, forKey: .permissions)}
  }
}
