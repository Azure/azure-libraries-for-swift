import Foundation
// SkuTypeProtocol is the SKU of the storage account.
public protocol SkuTypeProtocol : Codable {
     var name: SkuNameEnum? { get set }
     var tier: SkuTierEnum? { get set }
     var resourceType: String? { get set }
     var kind: KindEnum? { get set }
     var locations: [String??]? { get set }
     var capabilities: [SKUCapabilityTypeProtocol?]? { get set }
     var restrictions: [RestrictionTypeProtocol?]? { get set }
}
