import Foundation
import azureSwiftRuntime
public protocol SoftwareUpdateConfigurationsCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var softwareUpdateConfigurationName : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var parameters :  SoftwareUpdateConfigurationProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SoftwareUpdateConfigurationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SoftwareUpdateConfigurations {
// Create create a new software update configuration with the name given in the URI.
internal class CreateCommand : BaseCommand, SoftwareUpdateConfigurationsCreate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var automationAccountName : String
    public var softwareUpdateConfigurationName : String
    public var apiVersion = "2017-05-15-preview"
    public var clientRequestId : String?
    public var parameters :  SoftwareUpdateConfigurationProtocol?

    public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String, softwareUpdateConfigurationName: String, parameters: SoftwareUpdateConfigurationProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.softwareUpdateConfigurationName = softwareUpdateConfigurationName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurations/{softwareUpdateConfigurationName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{softwareUpdateConfigurationName}"] = String(describing: self.softwareUpdateConfigurationName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }
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
            let result = try decoder.decode(SoftwareUpdateConfigurationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SoftwareUpdateConfigurationProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SoftwareUpdateConfigurationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
