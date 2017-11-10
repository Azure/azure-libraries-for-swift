import Foundation
public struct EndpointsType : EndpointsTypeProtocol {
    public var blob: String?
    public var queue: String?
    public var table: String?
    public var file: String?

    enum CodingKeys: String, CodingKey {
        case blob = "blob"
        case queue = "queue"
        case table = "table"
        case file = "file"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.blob) {
        blob = try container.decode(String?.self, forKey: .blob)
    }
    if container.contains(.queue) {
        queue = try container.decode(String?.self, forKey: .queue)
    }
    if container.contains(.table) {
        table = try container.decode(String?.self, forKey: .table)
    }
    if container.contains(.file) {
        file = try container.decode(String?.self, forKey: .file)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.blob != nil {try container.encode(blob, forKey: .blob)}
    if self.queue != nil {try container.encode(queue, forKey: .queue)}
    if self.table != nil {try container.encode(table, forKey: .table)}
    if self.file != nil {try container.encode(file, forKey: .file)}
  }
}
