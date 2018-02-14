import Foundation
import azureSwiftRuntime
public protocol CapabilitiesListByLocation  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var locationId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LocationCapabilitiesProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Capabilities {
// ListByLocation gets the capabilities available for the specified location.
internal class ListByLocationCommand : BaseCommand, CapabilitiesListByLocation {
    public var subscriptionId : String
    public var locationId : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, locationId: String) {
        self.subscriptionId = subscriptionId
        self.locationId = locationId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Sql/locations/{locationId}/capabilities"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{locationId}"] = String(describing: self.locationId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LocationCapabilitiesData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LocationCapabilitiesProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: LocationCapabilitiesData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
