import Foundation
import azureSwiftRuntime
public protocol ApplicationTypeList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var clusterName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationTypeResourceListProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationType {
// List returns all application type names in the specified cluster.
internal class ListCommand : BaseCommand, ApplicationTypeList {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var clusterName : String
    public var apiVersion = "2017-07-01-preview"

    public init(subscriptionId: String, resourceGroupName: String, clusterName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.clusterName = clusterName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{clusterName}"] = String(describing: self.clusterName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ApplicationTypeResourceListData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationTypeResourceListProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ApplicationTypeResourceListData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
