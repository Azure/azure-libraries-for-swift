import Foundation
import azureSwiftRuntime
public protocol SoftwareUpdateConfigurationsList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SoftwareUpdateConfigurationListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SoftwareUpdateConfigurations {
// List get all software update configurations for the account.
internal class ListCommand : BaseCommand, SoftwareUpdateConfigurationsList {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var automationAccountName : String
    public var apiVersion = "2017-05-15-preview"
    public var filter : String?
    public var clientRequestId : String?

    public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurations"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
        if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SoftwareUpdateConfigurationListResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SoftwareUpdateConfigurationListResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SoftwareUpdateConfigurationListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
