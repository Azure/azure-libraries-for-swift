import Foundation
public struct StorageAccountType : StorageAccountTypeProtocol, ResourceTypeProtocol {
    public var id: String?
    public var name: String?
    public var type: String?
    public var location: String?
    public var tags: [String:String?]?
    public var sku: SkuTypeProtocol?
    public var kind: KindEnum?
    public var identity: IdentityTypeProtocol?
    public var properties: StorageAccountPropertiesTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case location = "location"
        case tags = "tags"
        case sku = "sku"
        case kind = "kind"
        case identity = "identity"
        case properties = "properties"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.id) {
        id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.name) {
        name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.type) {
        type = try container.decode(String?.self, forKey: .type)
    }
    if container.contains(.location) {
        location = try container.decode(String?.self, forKey: .location)
    }
    if container.contains(.tags) {
        tags = try container.decode([String:String?]?.self, forKey: .tags)
    }
    if container.contains(.sku) {
        sku = try container.decode(SkuType?.self, forKey: .sku)
    }
    if container.contains(.kind) {
        kind = try container.decode(KindEnum?.self, forKey: .kind)
    }
    if container.contains(.identity) {
        identity = try container.decode(IdentityType?.self, forKey: .identity)
    }
    if container.contains(.properties) {
        properties = try container.decode(StorageAccountPropertiesType?.self, forKey: .properties)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(id, forKey: .id)}
    if self.name != nil {try container.encode(name, forKey: .name)}
    if self.type != nil {try container.encode(type, forKey: .type)}
    if self.location != nil {try container.encode(location, forKey: .location)}
    if self.tags != nil {try container.encode(tags, forKey: .tags)}
    if self.sku != nil {try container.encode(sku as! SkuType?, forKey: .sku)}
    if self.kind != nil {try container.encode(kind, forKey: .kind)}
    if self.identity != nil {try container.encode(identity as! IdentityType?, forKey: .identity)}
    if self.properties != nil {try container.encode(properties as! StorageAccountPropertiesType?, forKey: .properties)}
  }
}
