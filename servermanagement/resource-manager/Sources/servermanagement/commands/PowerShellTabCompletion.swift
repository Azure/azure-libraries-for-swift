import Foundation
import azureSwiftRuntime
public protocol PowerShellTabCompletion  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var nodeName : String { get set }
    var session : String { get set }
    var pssession : String { get set }
    var apiVersion : String { get set }
    var powerShellTabCompletionParamters :  PowerShellTabCompletionParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (PowerShellTabCompletionResultsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PowerShell {
// TabCompletion gets tab completion values for a command.
    internal class TabCompletionCommand : BaseCommand, PowerShellTabCompletion {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var nodeName : String
        public var session : String
        public var pssession : String
        public var apiVersion = "2016-07-01-preview"
    public var powerShellTabCompletionParamters :  PowerShellTabCompletionParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, nodeName: String, session: String, pssession: String, powerShellTabCompletionParamters: PowerShellTabCompletionParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.nodeName = nodeName
            self.session = session
            self.pssession = pssession
            self.powerShellTabCompletionParamters = powerShellTabCompletionParamters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/nodes/{nodeName}/sessions/{session}/features/powerShellConsole/pssessions/{pssession}/tab"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{nodeName}"] = String(describing: self.nodeName)
            self.pathParameters["{session}"] = String(describing: self.session)
            self.pathParameters["{pssession}"] = String(describing: self.pssession)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = powerShellTabCompletionParamters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(powerShellTabCompletionParamters as? PowerShellTabCompletionParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(PowerShellTabCompletionResultsData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (PowerShellTabCompletionResultsProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: PowerShellTabCompletionResultsData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
