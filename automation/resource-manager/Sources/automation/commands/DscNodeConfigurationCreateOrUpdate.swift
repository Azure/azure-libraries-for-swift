import Foundation
import azureSwiftRuntime
public protocol DscNodeConfigurationCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var nodeConfigurationName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  DscNodeConfigurationCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DscNodeConfigurationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DscNodeConfiguration {
// CreateOrUpdate create the node configuration identified by node configuration name.
internal class CreateOrUpdateCommand : BaseCommand, DscNodeConfigurationCreateOrUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var nodeConfigurationName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  DscNodeConfigurationCreateOrUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, nodeConfigurationName: String, subscriptionId: String, parameters: DscNodeConfigurationCreateOrUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.nodeConfigurationName = nodeConfigurationName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodeConfigurations/{nodeConfigurationName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{nodeConfigurationName}"] = String(describing: self.nodeConfigurationName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
            let result = try decoder.decode(DscNodeConfigurationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DscNodeConfigurationProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DscNodeConfigurationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
