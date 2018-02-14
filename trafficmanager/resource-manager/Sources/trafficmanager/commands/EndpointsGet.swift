import Foundation
import azureSwiftRuntime
public protocol EndpointsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointType : String { get set }
    var endpointName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (EndpointProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Endpoints {
// Get gets a Traffic Manager endpoint.
internal class GetCommand : BaseCommand, EndpointsGet {
    public var resourceGroupName : String
    public var profileName : String
    public var endpointType : String
    public var endpointName : String
    public var subscriptionId : String
    public var apiVersion = "2017-05-01"

    public init(resourceGroupName: String, profileName: String, endpointType: String, endpointName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.profileName = profileName
        self.endpointType = endpointType
        self.endpointName = endpointName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}/{endpointType}/{endpointName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{endpointType}"] = String(describing: self.endpointType)
        self.pathParameters["{endpointName}"] = String(describing: self.endpointName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(EndpointData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (EndpointProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: EndpointData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
