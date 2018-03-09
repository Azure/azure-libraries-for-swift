import Foundation
import azureSwiftRuntime
public protocol PowerShellInvokeCommand  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var nodeName : String { get set }
    var session : String { get set }
    var pssession : String { get set }
    var apiVersion : String { get set }
    var powerShellCommandParameters :  PowerShellCommandParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PowerShellCommandResultsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PowerShell {
// InvokeCommand creates a PowerShell script and invokes it. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class InvokeCommandCommand : BaseCommand, PowerShellInvokeCommand {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var nodeName : String
        public var session : String
        public var pssession : String
        public var apiVersion = "2016-07-01-preview"
    public var powerShellCommandParameters :  PowerShellCommandParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, nodeName: String, session: String, pssession: String, powerShellCommandParameters: PowerShellCommandParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.nodeName = nodeName
            self.session = session
            self.pssession = pssession
            self.powerShellCommandParameters = powerShellCommandParameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/nodes/{nodeName}/sessions/{session}/features/powerShellConsole/pssessions/{pssession}/invokeCommand"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{nodeName}"] = String(describing: self.nodeName)
            self.pathParameters["{session}"] = String(describing: self.session)
            self.pathParameters["{pssession}"] = String(describing: self.pssession)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = powerShellCommandParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(powerShellCommandParameters as? PowerShellCommandParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PowerShellCommandResultsData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PowerShellCommandResultsProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: PowerShellCommandResultsData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
