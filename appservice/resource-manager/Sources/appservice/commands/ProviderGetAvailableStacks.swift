import Foundation
import azureSwiftRuntime
public protocol ProviderGetAvailableStacks  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var osTypeSelected : GetAvailableStacksOsTypeSelectedEnum? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ApplicationStackCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Provider {
// GetAvailableStacks get available application frameworks and their versions
    internal class GetAvailableStacksCommand : BaseCommand, ProviderGetAvailableStacks {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var osTypeSelected : GetAvailableStacksOsTypeSelectedEnum?
        public var apiVersion = "2016-03-01"

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/availableStacks"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            if self.osTypeSelected != nil { queryParameters["osTypeSelected"] = String(describing: self.osTypeSelected!) }
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
                let result = try decoder.decode(ApplicationStackCollectionData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ApplicationStackCollectionProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ApplicationStackCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
