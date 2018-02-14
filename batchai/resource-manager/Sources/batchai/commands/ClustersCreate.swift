import Foundation
import azureSwiftRuntime
public protocol ClustersCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var clusterName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ClusterCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ClusterProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Clusters {
// Create adds a cluster. A cluster is a collection of compute nodes. Multiple jobs can be run on the same cluster.
// This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel
// will be used to cancel polling and any outstanding HTTP requests.
internal class CreateCommand : BaseCommand, ClustersCreate {
    public var resourceGroupName : String
    public var clusterName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01-preview"
    public var parameters :  ClusterCreateParametersProtocol?

    public init(resourceGroupName: String, clusterName: String, subscriptionId: String, parameters: ClusterCreateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.clusterName = clusterName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/clusters/{clusterName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{clusterName}"] = String(describing: self.clusterName)
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
            let result = try decoder.decode(ClusterData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ClusterProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ClusterData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
