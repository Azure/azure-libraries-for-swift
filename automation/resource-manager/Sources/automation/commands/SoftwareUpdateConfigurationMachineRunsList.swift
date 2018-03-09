import Foundation
import azureSwiftRuntime
public protocol SoftwareUpdateConfigurationMachineRunsList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var skip : String? { get set }
    var top : String? { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SoftwareUpdateConfigurationMachineRunListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.SoftwareUpdateConfigurationMachineRuns {
// List return list of software update configuration machine runs
    internal class ListCommand : BaseCommand, SoftwareUpdateConfigurationMachineRunsList {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var automationAccountName : String
        public var apiVersion = "2017-05-15-preview"
        public var filter : String?
        public var skip : String?
        public var top : String?
        public var clientRequestId : String?

        public init(subscriptionId: String, resourceGroupName: String, automationAccountName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.skip != nil { queryParameters["$skip"] = String(describing: self.skip!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
            if self.clientRequestId != nil { headerParameters["clientRequestId"] = String(describing: self.clientRequestId!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SoftwareUpdateConfigurationMachineRunListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SoftwareUpdateConfigurationMachineRunListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SoftwareUpdateConfigurationMachineRunListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
