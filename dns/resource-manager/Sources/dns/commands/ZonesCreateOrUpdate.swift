import Foundation
import azureSwiftRuntime
public protocol ZonesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var zoneName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var ifNoneMatch : String? { get set }
    var parameters :  ZoneProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ZoneProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Zones {
// CreateOrUpdate creates or updates a DNS zone. Does not modify DNS records within the zone.
internal class CreateOrUpdateCommand : BaseCommand, ZonesCreateOrUpdate {
    public var resourceGroupName : String
    public var zoneName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"
    public var ifMatch : String?
    public var ifNoneMatch : String?
    public var parameters :  ZoneProtocol?

    public init(resourceGroupName: String, zoneName: String, subscriptionId: String, parameters: ZoneProtocol) {
        self.resourceGroupName = resourceGroupName
        self.zoneName = zoneName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{zoneName}"] = String(describing: self.zoneName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
        if self.ifNoneMatch != nil { headerParameters["If-None-Match"] = String(describing: self.ifNoneMatch!) }
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ZoneData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ZoneProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ZoneData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
