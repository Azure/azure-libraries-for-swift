import Foundation
import azureSwiftRuntime
public protocol TrustedIdProvidersGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var trustedIdProviderName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (TrustedIdProviderProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TrustedIdProviders {
// Get gets the specified Data Lake Store trusted identity provider.
    internal class GetCommand : BaseCommand, TrustedIdProvidersGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var accountName : String
        public var trustedIdProviderName : String
        public var apiVersion = "2016-11-01"

        public init(subscriptionId: String, resourceGroupName: String, accountName: String, trustedIdProviderName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.trustedIdProviderName = trustedIdProviderName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeStore/accounts/{accountName}/trustedIdProviders/{trustedIdProviderName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.pathParameters["{trustedIdProviderName}"] = String(describing: self.trustedIdProviderName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(TrustedIdProviderData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (TrustedIdProviderProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: TrustedIdProviderData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
