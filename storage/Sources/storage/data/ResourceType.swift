import Foundation
public struct ResourceType : ResourceTypeProtocol {
    public var id: String?
    public var name: String?
    public var type: String?
    public var location: String?
    public var tags: [String:String?]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case location = "location"
        case tags = "tags"
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
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(type, forKey: .type)
    try container.encode(location, forKey: .location)
    try container.encode(tags as! [String:String?]?, forKey: .tags)
  }
}
