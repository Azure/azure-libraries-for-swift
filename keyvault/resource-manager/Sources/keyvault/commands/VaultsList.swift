import Foundation
import azureSwiftRuntime
public protocol VaultsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var filter : String { get set }
    var top : Int32? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResourceListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// List the List operation gets information about the vaults associated with the subscription.
    internal class ListCommand : BaseCommand, VaultsList {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var filter : String
        public var top : Int32?
        public var apiVersion = "2015-11-01"

        public init(subscriptionId: String, filter: String) {
            self.subscriptionId = subscriptionId
            self.filter = filter
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resources"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["$filter"] = String(describing: self.filter)
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(ResourceListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResourceListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ResourceListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
