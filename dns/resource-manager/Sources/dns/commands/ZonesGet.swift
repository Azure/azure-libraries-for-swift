import Foundation
import azureSwiftRuntime
public protocol ZonesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var zoneName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ZoneProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Zones {
// Get gets a DNS zone. Retrieves the zone properties, but not the record sets within the zone.
    internal class GetCommand : BaseCommand, ZonesGet {
        public var resourceGroupName : String
        public var zoneName : String
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"

        public init(resourceGroupName: String, zoneName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.zoneName = zoneName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{zoneName}"] = String(describing: self.zoneName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
