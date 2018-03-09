import Foundation
import azureSwiftRuntime
public protocol FunctionsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var functionName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var function :  FunctionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (FunctionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Functions {
// Update updates an existing function under an existing streaming job. This can be used to partially update (ie.
// update one or two properties) a function without affecting the rest the job or function definition.
    internal class UpdateCommand : BaseCommand, FunctionsUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var jobName : String
        public var functionName : String
        public var apiVersion = "2016-03-01"
        public var ifMatch : String?
    public var function :  FunctionProtocol?

        public init(subscriptionId: String, resourceGroupName: String, jobName: String, functionName: String, function: FunctionProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.jobName = jobName
            self.functionName = functionName
            self.function = function
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}/functions/{functionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{functionName}"] = String(describing: self.functionName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
            self.body = function

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(function as? FunctionData)
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
