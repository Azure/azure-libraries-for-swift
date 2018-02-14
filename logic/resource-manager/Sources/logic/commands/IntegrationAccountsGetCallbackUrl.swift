import Foundation
import azureSwiftRuntime
public protocol IntegrationAccountsGetCallbackUrl  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var integrationAccountName : String { get set }
    var apiVersion : String { get set }
    var parameters :  GetCallbackUrlParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CallbackUrlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IntegrationAccounts {
// GetCallbackUrl gets the integration account callback URL.
internal class GetCallbackUrlCommand : BaseCommand, IntegrationAccountsGetCallbackUrl {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var integrationAccountName : String
    public var apiVersion = "2016-06-01"
    public var parameters :  GetCallbackUrlParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, parameters: GetCallbackUrlParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.integrationAccountName = integrationAccountName
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Logic/integrationAccounts/{integrationAccountName}/listCallbackUrl"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{integrationAccountName}"] = String(describing: self.integrationAccountName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CallbackUrlData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CallbackUrlProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CallbackUrlData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
