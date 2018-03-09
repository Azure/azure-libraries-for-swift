import Foundation
import azureSwiftRuntime
public protocol EndpointsStart  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (EndpointProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Endpoints {
// Start starts an existing CDN endpoint that is on a stopped state. This method may poll for completion. Polling can
// be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding
// HTTP requests.
    internal class StartCommand : BaseCommand, EndpointsStart {
        public var resourceGroupName : String
        public var profileName : String
        public var endpointName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-02"

        public init(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.endpointName = endpointName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/endpoints/{endpointName}/start"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
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
            client.executeAsyncLRO(command: self) {
                (result: EndpointData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
