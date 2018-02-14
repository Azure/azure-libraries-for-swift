import Foundation
import azureSwiftRuntime
public protocol LocationsGetCapability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var location : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CapabilityInformationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Locations {
// GetCapability gets subscription-level properties and limits for Data Lake Analytics specified by resource location.
internal class GetCapabilityCommand : BaseCommand, LocationsGetCapability {
    public var subscriptionId : String
    public var location : String
    public var apiVersion = "2016-11-01"

    public init(subscriptionId: String, location: String) {
        self.subscriptionId = subscriptionId
        self.location = location
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeAnalytics/locations/{location}/capability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{location}"] = String(describing: self.location)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CapabilityInformationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CapabilityInformationProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CapabilityInformationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
