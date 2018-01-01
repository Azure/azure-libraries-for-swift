// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
internal struct StorageSkuListResultData : StorageSkuListResultProtocol {
    public var value: [SkuProtocol?]?

    enum CodingKeys: String, CodingKey {
        case value = "value"
    }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.value) {
        value = try container.decode([SkuData?]?.self, forKey: .value)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.value != nil {try container.encode(value as! [SkuData?]?, forKey: .value)}
  }
}

extension DataFactory {
  public static func createStorageSkuListResultProtocol() -> StorageSkuListResultProtocol {
    return StorageSkuListResultData()
  }
}