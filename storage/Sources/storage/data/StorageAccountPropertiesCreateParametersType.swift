import Foundation
public struct StorageAccountPropertiesCreateParametersType : StorageAccountPropertiesCreateParametersTypeProtocol {
    public var customDomain: CustomDomainTypeProtocol?
    public var encryption: EncryptionTypeProtocol?
    public var networkAcls: NetworkRuleSetTypeProtocol?
    public var accessTier: AccessTierEnum?
    public var supportsHttpsTrafficOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case customDomain = "customDomain"
        case encryption = "encryption"
        case networkAcls = "networkAcls"
        case accessTier = "accessTier"
        case supportsHttpsTrafficOnly = "supportsHttpsTrafficOnly"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.customDomain) {
        customDomain = try container.decode(CustomDomainType?.self, forKey: .customDomain)
    }
    if container.contains(.encryption) {
        encryption = try container.decode(EncryptionType?.self, forKey: .encryption)
    }
    if container.contains(.networkAcls) {
        networkAcls = try container.decode(NetworkRuleSetType?.self, forKey: .networkAcls)
    }
    if container.contains(.accessTier) {
        accessTier = try container.decode(AccessTierEnum?.self, forKey: .accessTier)
    }
    if container.contains(.supportsHttpsTrafficOnly) {
        supportsHttpsTrafficOnly = try container.decode(Bool?.self, forKey: .supportsHttpsTrafficOnly)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.customDomain != nil {try container.encode(customDomain as! CustomDomainType?, forKey: .customDomain)}
    if self.encryption != nil {try container.encode(encryption as! EncryptionType?, forKey: .encryption)}
    if self.networkAcls != nil {try container.encode(networkAcls as! NetworkRuleSetType?, forKey: .networkAcls)}
    if self.accessTier != nil {try container.encode(accessTier as! AccessTierEnum?, forKey: .accessTier)}
    if self.supportsHttpsTrafficOnly != nil {try container.encode(supportsHttpsTrafficOnly, forKey: .supportsHttpsTrafficOnly)}
  }
}

