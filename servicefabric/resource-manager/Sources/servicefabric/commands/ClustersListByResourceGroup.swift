import Foundation
import azureSwiftRuntime
public protocol ClustersListByResourceGroup  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ClusterListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Clusters {
// ListByResourceGroup list cluster resource by resource group
    internal class ListByResourceGroupCommand : BaseCommand, ClustersListByResourceGroup {
        public var resourceGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2017-07-01-preview"

        public init(resourceGroupName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ClusterListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ClusterListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ClusterListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
