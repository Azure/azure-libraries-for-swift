import Foundation
public struct SkuType : SkuTypeProtocol {
    public var name: SkuNameEnum?
    public var tier: SkuTierEnum?
    public var resourceType: String?
    public var kind: KindEnum?
    public var locations: [String??]?
    public var capabilities: [SKUCapabilityTypeProtocol?]?
    public var restrictions: [RestrictionTypeProtocol?]?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case tier = "tier"
        case resourceType = "resourceType"
        case kind = "kind"
        case locations = "locations"
        case capabilities = "capabilities"
        case restrictions = "restrictions"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.name) {
        name = try container.decode(SkuNameEnum?.self, forKey: .name)
    }
    if container.contains(.tier) {
        tier = try container.decode(SkuTierEnum?.self, forKey: .tier)
    }
    if container.contains(.resourceType) {
        resourceType = try container.decode(String?.self, forKey: .resourceType)
    }
    if container.contains(.kind) {
        kind = try container.decode(KindEnum?.self, forKey: .kind)
    }
    if container.contains(.locations) {
        locations = try container.decode([String?]?.self, forKey: .locations)
    }
    if container.contains(.capabilities) {
        capabilities = try container.decode([SKUCapabilityType?]?.self, forKey: .capabilities)
    }
    if container.contains(.restrictions) {
        restrictions = try container.decode([RestrictionType?]?.self, forKey: .restrictions)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.name != nil {try container.encode(name as! SkuNameEnum?, forKey: .name)}
    if self.tier != nil {try container.encode(tier as! SkuTierEnum?, forKey: .tier)}
    if self.resourceType != nil {try container.encode(resourceType, forKey: .resourceType)}
    if self.kind != nil {try container.encode(kind as! KindEnum?, forKey: .kind)}
    if self.locations != nil {try container.encode(locations as! [String?]?, forKey: .locations)}
    if self.capabilities != nil {try container.encode(capabilities as! [SKUCapabilityType?]?, forKey: .capabilities)}
    if self.restrictions != nil {try container.encode(restrictions as! [RestrictionType?]?, forKey: .restrictions)}
  }
}
