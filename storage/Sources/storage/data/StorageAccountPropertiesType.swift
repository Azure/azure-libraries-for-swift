import Foundation
public struct StorageAccountPropertiesType : StorageAccountPropertiesTypeProtocol {
    public var provisioningState: ProvisioningStateEnum?
    public var primaryEndpoints: EndpointsTypeProtocol?
    public var primaryLocation: String?
    public var statusOfPrimary: AccountStatusEnum?
    public var lastGeoFailoverTime: String?
    public var secondaryLocation: String?
    public var statusOfSecondary: AccountStatusEnum?
    public var creationTime: String?
    public var customDomain: CustomDomainTypeProtocol?
    public var secondaryEndpoints: EndpointsTypeProtocol?
    public var encryption: EncryptionTypeProtocol?
    public var accessTier: AccessTierEnum?
    public var supportsHttpsTrafficOnly: Bool?
    public var networkAcls: NetworkRuleSetTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case provisioningState = "provisioningState"
        case primaryEndpoints = "primaryEndpoints"
        case primaryLocation = "primaryLocation"
        case statusOfPrimary = "statusOfPrimary"
        case lastGeoFailoverTime = "lastGeoFailoverTime"
        case secondaryLocation = "secondaryLocation"
        case statusOfSecondary = "statusOfSecondary"
        case creationTime = "creationTime"
        case customDomain = "customDomain"
        case secondaryEndpoints = "secondaryEndpoints"
        case encryption = "encryption"
        case accessTier = "accessTier"
        case supportsHttpsTrafficOnly = "supportsHttpsTrafficOnly"
        case networkAcls = "networkAcls"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.provisioningState) {
        provisioningState = try container.decode(ProvisioningStateEnum?.self, forKey: .provisioningState)
    }
    if container.contains(.primaryEndpoints) {
        primaryEndpoints = try container.decode(EndpointsType?.self, forKey: .primaryEndpoints)
    }
    if container.contains(.primaryLocation) {
        primaryLocation = try container.decode(String?.self, forKey: .primaryLocation)
    }
    if container.contains(.statusOfPrimary) {
        statusOfPrimary = try container.decode(AccountStatusEnum?.self, forKey: .statusOfPrimary)
    }
    if container.contains(.lastGeoFailoverTime) {
        lastGeoFailoverTime = try container.decode(String?.self, forKey: .lastGeoFailoverTime)
    }
    if container.contains(.secondaryLocation) {
        secondaryLocation = try container.decode(String?.self, forKey: .secondaryLocation)
    }
    if container.contains(.statusOfSecondary) {
        statusOfSecondary = try container.decode(AccountStatusEnum?.self, forKey: .statusOfSecondary)
    }
    if container.contains(.creationTime) {
        creationTime = try container.decode(String?.self, forKey: .creationTime)
    }
    if container.contains(.customDomain) {
        customDomain = try container.decode(CustomDomainType?.self, forKey: .customDomain)
    }
    if container.contains(.secondaryEndpoints) {
        secondaryEndpoints = try container.decode(EndpointsType?.self, forKey: .secondaryEndpoints)
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
    try container.encode(provisioningState as! ProvisioningStateEnum?, forKey: .provisioningState)
    try container.encode(primaryEndpoints as! EndpointsType?, forKey: .primaryEndpoints)
    try container.encode(primaryLocation, forKey: .primaryLocation)
    try container.encode(statusOfPrimary as! AccountStatusEnum?, forKey: .statusOfPrimary)
    try container.encode(lastGeoFailoverTime, forKey: .lastGeoFailoverTime)
    try container.encode(secondaryLocation, forKey: .secondaryLocation)
    try container.encode(statusOfSecondary as! AccountStatusEnum?, forKey: .statusOfSecondary)
    try container.encode(creationTime, forKey: .creationTime)
    try container.encode(customDomain as! CustomDomainType?, forKey: .customDomain)
    try container.encode(secondaryEndpoints as! EndpointsType?, forKey: .secondaryEndpoints)
    try container.encode(encryption as! EncryptionType?, forKey: .encryption)
    try container.encode(accessTier as! AccessTierEnum?, forKey: .accessTier)
    try container.encode(supportsHttpsTrafficOnly, forKey: .supportsHttpsTrafficOnly)
    try container.encode(networkAcls as! NetworkRuleSetType?, forKey: .networkAcls)
  }
}
