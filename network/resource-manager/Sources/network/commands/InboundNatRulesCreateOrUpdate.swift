import Foundation
import azureSwiftRuntime
public protocol InboundNatRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var loadBalancerName : String { get set }
    var inboundNatRuleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var inboundNatRuleParameters :  InboundNatRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (InboundNatRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.InboundNatRules {
// CreateOrUpdate creates or updates a load balancer inbound nat rule. This method may poll for completion. Polling can
// be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding
// HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, InboundNatRulesCreateOrUpdate {
    public var resourceGroupName : String
    public var loadBalancerName : String
    public var inboundNatRuleName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var inboundNatRuleParameters :  InboundNatRuleProtocol?

    public init(resourceGroupName: String, loadBalancerName: String, inboundNatRuleName: String, subscriptionId: String, inboundNatRuleParameters: InboundNatRuleProtocol) {
        self.resourceGroupName = resourceGroupName
        self.loadBalancerName = loadBalancerName
        self.inboundNatRuleName = inboundNatRuleName
        self.subscriptionId = subscriptionId
        self.inboundNatRuleParameters = inboundNatRuleParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{loadBalancerName}"] = String(describing: self.loadBalancerName)
        self.pathParameters["{inboundNatRuleName}"] = String(describing: self.inboundNatRuleName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = inboundNatRuleParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(inboundNatRuleParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(InboundNatRuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (InboundNatRuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: InboundNatRuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
