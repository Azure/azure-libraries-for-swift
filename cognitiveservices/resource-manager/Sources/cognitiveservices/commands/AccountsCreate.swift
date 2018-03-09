import Foundation
import azureSwiftRuntime
public protocol AccountsCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CognitiveServicesAccountCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CognitiveServicesAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// Create create Cognitive Services Account. Accounts is a resource group wide resource type. It holds the keys for
// developer to access intelligent APIs. It's also the resource type for billing.
    internal class CreateCommand : BaseCommand, AccountsCreate {
        public var resourceGroupName : String
        public var accountName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-18"
    public var parameters :  CognitiveServicesAccountCreateParametersProtocol?

        public init(resourceGroupName: String, accountName: String, subscriptionId: String, parameters: CognitiveServicesAccountCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.accountName = accountName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{accountName}"] = String(describing: self.accountName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? CognitiveServicesAccountCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CognitiveServicesAccountData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CognitiveServicesAccountProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CognitiveServicesAccountData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
