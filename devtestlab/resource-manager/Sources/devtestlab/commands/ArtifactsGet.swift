import Foundation
import azureSwiftRuntime
public protocol ArtifactsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var artifactSourceName : String { get set }
    var name : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ArtifactProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Artifacts {
// Get get artifact.
    internal class GetCommand : BaseCommand, ArtifactsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var artifactSourceName : String
        public var name : String
        public var expand : String?
        public var apiVersion = "2016-05-15"

        public init(subscriptionId: String, resourceGroupName: String, labName: String, artifactSourceName: String, name: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.artifactSourceName = artifactSourceName
            self.name = name
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/artifactsources/{artifactSourceName}/artifacts/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{artifactSourceName}"] = String(describing: self.artifactSourceName)
            self.pathParameters["{name}"] = String(describing: self.name)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ArtifactData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ArtifactProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ArtifactData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
