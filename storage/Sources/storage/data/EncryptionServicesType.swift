import Foundation
public struct EncryptionServicesType : EncryptionServicesTypeProtocol {
    public var blob: EncryptionServiceTypeProtocol?
    public var file: EncryptionServiceTypeProtocol?
    public var table: EncryptionServiceTypeProtocol?
    public var queue: EncryptionServiceTypeProtocol?

    enum CodingKeys: String, CodingKey {
        case blob = "blob"
        case file = "file"
        case table = "table"
        case queue = "queue"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.blob) {
        blob = try container.decode(EncryptionServiceType?.self, forKey: .blob)
    }
    if container.contains(.file) {
        file = try container.decode(EncryptionServiceType?.self, forKey: .file)
    }
    if container.contains(.table) {
        table = try container.decode(EncryptionServiceType?.self, forKey: .table)
    }
    if container.contains(.queue) {
        queue = try container.decode(EncryptionServiceType?.self, forKey: .queue)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.blob != nil {try container.encode(blob as! EncryptionServiceType?, forKey: .blob)}
    if self.file != nil {try container.encode(file as! EncryptionServiceType?, forKey: .file)}
    if self.table != nil {try container.encode(table as! EncryptionServiceType?, forKey: .table)}
    if self.queue != nil {try container.encode(queue as! EncryptionServiceType?, forKey: .queue)}
  }
}
