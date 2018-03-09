import Foundation
import azureSwiftRuntime
public protocol ProviderListOperations  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CsmOperationCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Provider {
// ListOperations gets all available operations for the Microsoft.Web resource provider. Also exposes resource metric
// definitions
    internal class ListOperationsCommand : BaseCommand, ProviderListOperations {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var apiVersion = "2016-03-01"

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/operations"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
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
                let result = try decoder.decode(CsmOperationCollectionData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CsmOperationCollectionProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: CsmOperationCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
