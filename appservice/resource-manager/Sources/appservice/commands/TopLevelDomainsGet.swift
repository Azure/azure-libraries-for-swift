import Foundation
import azureSwiftRuntime
public protocol TopLevelDomainsGet  {
    var headerParameters: [String: String] { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (TopLevelDomainProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TopLevelDomains {
// Get get details of a top-level domain.
    internal class GetCommand : BaseCommand, TopLevelDomainsGet {
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"

        public init(name: String, subscriptionId: String) {
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/topLevelDomains/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(TopLevelDomainData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (TopLevelDomainProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: TopLevelDomainData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
