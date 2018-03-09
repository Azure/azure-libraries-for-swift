import Foundation
import azureSwiftRuntime
public protocol FunctionsRetrieveDefaultDefinition  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var functionName : String { get set }
    var apiVersion : String { get set }
    var functionRetrieveDefaultDefinitionParameters :  FunctionRetrieveDefaultDefinitionParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (FunctionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Functions {
// RetrieveDefaultDefinition retrieves the default definition of a function based on the parameters specified.
    internal class RetrieveDefaultDefinitionCommand : BaseCommand, FunctionsRetrieveDefaultDefinition {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var jobName : String
        public var functionName : String
        public var apiVersion = "2016-03-01"
    public var functionRetrieveDefaultDefinitionParameters :  FunctionRetrieveDefaultDefinitionParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, jobName: String, functionName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.jobName = jobName
            self.functionName = functionName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}/functions/{functionName}/RetrieveDefaultDefinition"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{functionName}"] = String(describing: self.functionName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = functionRetrieveDefaultDefinitionParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(functionRetrieveDefaultDefinitionParameters as? FunctionRetrieveDefaultDefinitionParametersData?)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(FunctionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (FunctionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: FunctionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
