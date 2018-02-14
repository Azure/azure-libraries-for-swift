import Foundation
import azureSwiftRuntime
public protocol EndpointsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var endpointUpdateProperties :  EndpointUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (EndpointProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Endpoints {
// Update updates an existing CDN endpoint with the specified endpoint name under the specified subscription, resource
// group and profile. Only tags and Origin HostHeader can be updated after creating an endpoint. To update origins, use
// the Update Origin operation. To update custom domains, use the Update Custom Domain operation. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, EndpointsUpdate {
    public var resourceGroupName : String
    public var profileName : String
    public var endpointName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-02"
    public var endpointUpdateProperties :  EndpointUpdateParametersProtocol?

    public init(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, endpointUpdateProperties: EndpointUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.profileName = profileName
        self.endpointName = endpointName
        self.subscriptionId = subscriptionId
        self.endpointUpdateProperties = endpointUpdateProperties
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/endpoints/{endpointName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{endpointName}"] = String(describing: self.endpointName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = endpointUpdateProperties
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(endpointUpdateProperties)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
        client.executeAsyncLRO(command: self) {
            (result: EndpointData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
