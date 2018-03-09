import Foundation
import azureSwiftRuntime
public protocol IotHubResourceListKeys  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SharedAccessSignatureAuthorizationRuleListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// ListKeys get the security metadata for an IoT hub. For more information, see:
// https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-security.
    internal class ListKeysCommand : BaseCommand, IotHubResourceListKeys {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var apiVersion = "2017-07-01"

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/listkeys"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
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
                let result = try decoder.decode(SharedAccessSignatureAuthorizationRuleListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SharedAccessSignatureAuthorizationRuleListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: SharedAccessSignatureAuthorizationRuleListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
