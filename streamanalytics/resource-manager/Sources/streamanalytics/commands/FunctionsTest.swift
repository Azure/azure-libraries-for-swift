import Foundation
import azureSwiftRuntime
public protocol FunctionsTest  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var functionName : String { get set }
    var apiVersion : String { get set }
    var function :  FunctionProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ResourceTestStatusProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Functions {
// Test tests if the information provided for a function is valid. This can range from testing the connection to the
// underlying web service behind the function or making sure the function code provided is syntactically correct. This
// method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be
// used to cancel polling and any outstanding HTTP requests.
internal class TestCommand : BaseCommand, FunctionsTest {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobName : String
    public var functionName : String
    public var apiVersion = "2016-03-01"
    public var function :  FunctionProtocol?

    public init(subscriptionId: String, resourceGroupName: String, jobName: String, functionName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.functionName = functionName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}/functions/{functionName}/test"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.pathParameters["{functionName}"] = String(describing: self.functionName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = function
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(function)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ResourceTestStatusData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ResourceTestStatusProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: ResourceTestStatusData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
