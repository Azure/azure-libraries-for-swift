import Foundation
import azureSwiftRuntime
public protocol LabsListVhds  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResponseWithContinuationLabVhdProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Labs {
// ListVhds list disk images available for custom image creation.
    internal class ListVhdsCommand : BaseCommand, LabsListVhds {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var resourceGroupName : String
        public var name : String
        public var apiVersion = "2016-05-15"

        public init(subscriptionId: String, resourceGroupName: String, name: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.name = name
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{name}/listVhds"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
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
                let result = try decoder.decode(ResponseWithContinuationLabVhdData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResponseWithContinuationLabVhdProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ResponseWithContinuationLabVhdData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
