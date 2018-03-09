import Foundation
import azureSwiftRuntime
public protocol SessionGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var nodeName : String { get set }
    var session : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SessionResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Session {
// Get gets a session for a node.
    internal class GetCommand : BaseCommand, SessionGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var nodeName : String
        public var session : String
        public var apiVersion = "2016-07-01-preview"

        public init(subscriptionId: String, resourceGroupName: String, nodeName: String, session: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.nodeName = nodeName
            self.session = session
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/nodes/{nodeName}/sessions/{session}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{nodeName}"] = String(describing: self.nodeName)
            self.pathParameters["{session}"] = String(describing: self.session)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SessionResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SessionResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SessionResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
