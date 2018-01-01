// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
internal struct ListServiceSasResponseData : ListServiceSasResponseProtocol {
    public var serviceSasToken: String?

    enum CodingKeys: String, CodingKey {
        case serviceSasToken = "serviceSasToken"
    }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.serviceSasToken) {
        serviceSasToken = try container.decode(String.self, forKey: .serviceSasToken)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.serviceSasToken != nil {try container.encode(serviceSasToken, forKey: .serviceSasToken)}
  }
}

extension DataFactory {
  public static func createListServiceSasResponseProtocol() -> ListServiceSasResponseProtocol {
    return ListServiceSasResponseData()
  }
}