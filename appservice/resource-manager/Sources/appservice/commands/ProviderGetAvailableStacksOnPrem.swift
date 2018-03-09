import Foundation
import azureSwiftRuntime
public protocol ProviderGetAvailableStacksOnPrem  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var osTypeSelected : GetAvailableStacksOnPremOsTypeSelectedEnum? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ApplicationStackCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Provider {
// GetAvailableStacksOnPrem get available application frameworks and their versions
    internal class GetAvailableStacksOnPremCommand : BaseCommand, ProviderGetAvailableStacksOnPrem {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var osTypeSelected : GetAvailableStacksOnPremOsTypeSelectedEnum?
        public var apiVersion = "2016-03-01"

        public init(subscriptionId: String) {
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/availableStacks"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
