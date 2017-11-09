import Foundation
public struct StorageAccountCreateParametersType : StorageAccountCreateParametersTypeProtocol {
    public var sku: SkuTypeProtocol?
    public var kind: KindEnum?
    public var location: String?
    public var tags: [String:String?]?
    public var identity: IdentityTypeProtocol?
    public var properties: StorageAccountPropertiesCreateParametersTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case sku = "sku"
        case kind = "kind"
        case location = "location"
        case tags = "tags"
        case identity = "identity"
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.sku) {
        sku = try container.decode(SkuType?.self, forKey: .sku)
    }
    if container.contains(.kind) {
        kind = try container.decode(KindEnum?.self, forKey: .kind)
    }
    if container.contains(.location) {
        location = try container.decode(String?.self, forKey: .location)
    }
    if container.contains(.tags) {
        tags = try container.decode([String:String?]?.self, forKey: .tags)
    }
    if container.contains(.identity) {
        identity = try container.decode(IdentityType?.self, forKey: .identity)
    }
    if container.contains(.properties) {
        properties = try container.decode(StorageAccountPropertiesCreateParametersType?.self, forKey: .properties)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sku as! SkuType?, forKey: .sku)
    try container.encode(kind as! KindEnum?, forKey: .kind)
    try container.encode(location, forKey: .location)
    try container.encode(tags as! [String:String?]?, forKey: .tags)
    try container.encode(identity as! IdentityType?, forKey: .identity)
    try container.encode(properties as! StorageAccountPropertiesCreateParametersType?, forKey: .properties)
  }
}
