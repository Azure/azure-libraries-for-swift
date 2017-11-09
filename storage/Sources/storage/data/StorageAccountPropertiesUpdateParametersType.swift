import Foundation
public struct StorageAccountPropertiesUpdateParametersType : StorageAccountPropertiesUpdateParametersTypeProtocol {
    public var customDomain: CustomDomainTypeProtocol?
    public var encryption: EncryptionTypeProtocol?
    public var accessTier: AccessTierEnum?
    public var supportsHttpsTrafficOnly: Bool?
    public var networkAcls: NetworkRuleSetTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case customDomain = "customDomain"
        case encryption = "encryption"
        case accessTier = "accessTier"
        case supportsHttpsTrafficOnly = "supportsHttpsTrafficOnly"
        case networkAcls = "networkAcls"
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
    if container.contains(.accessTier) {
        accessTier = try container.decode(AccessTierEnum?.self, forKey: .accessTier)
    }
    if container.contains(.supportsHttpsTrafficOnly) {
        supportsHttpsTrafficOnly = try container.decode(Bool?.self, forKey: .supportsHttpsTrafficOnly)
    }
    if container.contains(.networkAcls) {
        networkAcls = try container.decode(NetworkRuleSetType?.self, forKey: .networkAcls)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(customDomain as! CustomDomainType?, forKey: .customDomain)
    try container.encode(encryption as! EncryptionType?, forKey: .encryption)
    try container.encode(accessTier as! AccessTierEnum?, forKey: .accessTier)
    try container.encode(supportsHttpsTrafficOnly, forKey: .supportsHttpsTrafficOnly)
    try container.encode(networkAcls as! NetworkRuleSetType?, forKey: .networkAcls)
  }
}
