import Foundation
import azureSwiftRuntime
public protocol ContainerServicesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var containerServiceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerServiceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerServices {
// Get gets the properties of the specified container service in the specified subscription and resource group. The
// operation returns the properties including state, orchestrator, number of masters and agents, and FQDNs of masters
// and agents.
internal class GetCommand : BaseCommand, ContainerServicesGet {
    public var resourceGroupName : String
    public var containerServiceName : String
    public var subscriptionId : String
    public var apiVersion = "2017-01-31"

    public init(resourceGroupName: String, containerServiceName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.containerServiceName = containerServiceName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/containerServices/{containerServiceName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{containerServiceName}"] = String(describing: self.containerServiceName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
        client.executeAsync(command: self) {
            (result: ContainerServiceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
