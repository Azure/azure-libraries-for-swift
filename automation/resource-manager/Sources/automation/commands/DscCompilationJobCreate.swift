import Foundation
import azureSwiftRuntime
public protocol DscCompilationJobCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var compilationJobId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  DscCompilationJobCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DscCompilationJobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DscCompilationJob {
// Create creates the Dsc compilation job of the configuration.
    internal class CreateCommand : BaseCommand, DscCompilationJobCreate {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var compilationJobId : String
        public var subscriptionId : String
        public var apiVersion = "2015-10-31"
    public var parameters :  DscCompilationJobCreateParametersProtocol?

        public init(resourceGroupName: String, automationAccountName: String, compilationJobId: String, subscriptionId: String, parameters: DscCompilationJobCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.compilationJobId = compilationJobId
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{compilationJobId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{compilationJobId}"] = String(describing: self.compilationJobId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? DscCompilationJobCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DscCompilationJobData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DscCompilationJobProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DscCompilationJobData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
