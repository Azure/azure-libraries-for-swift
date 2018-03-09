import Foundation
import azureSwiftRuntime
public protocol VersionGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var clusterName : String { get set }
    var applicationTypeName : String { get set }
    var version : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VersionResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Version {
// Get returns an application type version resource.
    internal class GetCommand : BaseCommand, VersionGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var clusterName : String
        public var applicationTypeName : String
        public var version : String
        public var apiVersion = "2017-07-01-preview"

        public init(subscriptionId: String, resourceGroupName: String, clusterName: String, applicationTypeName: String, version: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.clusterName = clusterName
            self.applicationTypeName = applicationTypeName
            self.version = version
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/clusters/{clusterName}/applicationTypes/{applicationTypeName}/versions/{version}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{clusterName}"] = String(describing: self.clusterName)
            self.pathParameters["{applicationTypeName}"] = String(describing: self.applicationTypeName)
            self.pathParameters["{version}"] = String(describing: self.version)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VersionResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VersionResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VersionResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
