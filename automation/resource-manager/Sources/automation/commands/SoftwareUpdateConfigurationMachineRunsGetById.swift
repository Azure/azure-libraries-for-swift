import Foundation
import azureSwiftRuntime
public protocol SoftwareUpdateConfigurationMachineRunsGetById  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var softwareUpdateConfigurationMachineRunId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SoftwareUpdateConfigurationMachineRunProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SoftwareUpdateConfigurationMachineRuns {
// GetById get a single software update configuration machine run by Id.
    internal class GetByIdCommand : BaseCommand, SoftwareUpdateConfigurationMachineRunsGetById {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var automationAccountName : String
        public var softwareUpdateConfigurationMachineRunId : String
        public var apiVersion = "2017-05-15-preview"
        public var clientRequestId : String?

        public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String, softwareUpdateConfigurationMachineRunId: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.softwareUpdateConfigurationMachineRunId = softwareUpdateConfigurationMachineRunId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns/{softwareUpdateConfigurationMachineRunId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{softwareUpdateConfigurationMachineRunId}"] = String(describing: self.softwareUpdateConfigurationMachineRunId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SoftwareUpdateConfigurationMachineRunData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SoftwareUpdateConfigurationMachineRunProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SoftwareUpdateConfigurationMachineRunData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
