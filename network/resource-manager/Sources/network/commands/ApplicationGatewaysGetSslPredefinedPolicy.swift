import Foundation
import azureSwiftRuntime
public protocol ApplicationGatewaysGetSslPredefinedPolicy  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var predefinedPolicyName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationGatewaySslPredefinedPolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationGateways {
// GetSslPredefinedPolicy gets Ssl predefined policy with the specified policy name.
internal class GetSslPredefinedPolicyCommand : BaseCommand, ApplicationGatewaysGetSslPredefinedPolicy {
    public var subscriptionId : String
    public var predefinedPolicyName : String
    public var apiVersion = "2018-01-01"

    public init(subscriptionId: String, predefinedPolicyName: String) {
        self.subscriptionId = subscriptionId
        self.predefinedPolicyName = predefinedPolicyName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Network/applicationGatewayAvailableSslOptions/default/predefinedPolicies/{predefinedPolicyName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{predefinedPolicyName}"] = String(describing: self.predefinedPolicyName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ApplicationGatewaySslPredefinedPolicyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationGatewaySslPredefinedPolicyProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ApplicationGatewaySslPredefinedPolicyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
