import Foundation
public struct EncryptionType : EncryptionTypeProtocol {
    public var services: EncryptionServicesTypeProtocol?
    public var keySource: KeySourceEnum?
    public var keyvaultproperties: KeyVaultPropertiesTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case services = "services"
        case keySource = "keySource"
        case keyvaultproperties = "keyvaultproperties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.services) {
        services = try container.decode(EncryptionServicesType?.self, forKey: .services)
    }
    if container.contains(.keySource) {
        keySource = try container.decode(KeySourceEnum?.self, forKey: .keySource)
    }
    if container.contains(.keyvaultproperties) {
        keyvaultproperties = try container.decode(KeyVaultPropertiesType?.self, forKey: .keyvaultproperties)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.services != nil {try container.encode(services as! EncryptionServicesType?, forKey: .services)}
    if self.keySource != nil {try container.encode(keySource, forKey: .keySource)}
    if self.keyvaultproperties != nil {try container.encode(keyvaultproperties as! KeyVaultPropertiesType?, forKey: .keyvaultproperties)}
  }
}
