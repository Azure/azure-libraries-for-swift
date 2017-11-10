import Foundation
public struct KeyVaultPropertiesType : KeyVaultPropertiesTypeProtocol {
    public var keyname: String?
    public var keyversion: String?
    public var keyvaulturi: String?

    enum CodingKeys: String, CodingKey {
        case keyname = "keyname"
        case keyversion = "keyversion"
        case keyvaulturi = "keyvaulturi"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.keyname) {
        keyname = try container.decode(String?.self, forKey: .keyname)
    }
    if container.contains(.keyversion) {
        keyversion = try container.decode(String?.self, forKey: .keyversion)
    }
    if container.contains(.keyvaulturi) {
        keyvaulturi = try container.decode(String?.self, forKey: .keyvaulturi)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.keyname != nil {try container.encode(keyname, forKey: .keyname)}
    if self.keyversion != nil {try container.encode(keyversion, forKey: .keyversion)}
    if self.keyvaulturi != nil {try container.encode(keyvaulturi, forKey: .keyvaulturi)}
  }
}
