import Foundation
import azureSwiftRuntime
public protocol ContainerServicesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var containerServiceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ContainerServiceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerServiceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerServices {
// CreateOrUpdate creates or updates a container service with the specified configuration of orchestrator, masters, and
// agents. This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The
// channel will be used to cancel polling and any outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, ContainerServicesCreateOrUpdate {
    public var resourceGroupName : String
    public var containerServiceName : String
    public var subscriptionId : String
    public var apiVersion = "2017-01-31"
    public var parameters :  ContainerServiceProtocol?

    public init(resourceGroupName: String, containerServiceName: String, subscriptionId: String, parameters: ContainerServiceProtocol) {
        self.resourceGroupName = resourceGroupName
        self.containerServiceName = containerServiceName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/containerServices/{containerServiceName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{containerServiceName}"] = String(describing: self.containerServiceName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
            let result = try decoder.decode(ContainerServiceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerServiceProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ContainerServiceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
