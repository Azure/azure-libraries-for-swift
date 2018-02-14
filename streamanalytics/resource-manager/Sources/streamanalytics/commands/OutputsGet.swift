import Foundation
import azureSwiftRuntime
public protocol OutputsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var outputName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Outputs {
// Get gets details about the specified output.
internal class GetCommand : BaseCommand, OutputsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobName : String
    public var outputName : String
    public var apiVersion = "2016-03-01"

    public init(subscriptionId: String, resourceGroupName: String, jobName: String, outputName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.outputName = outputName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}/outputs/{outputName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.pathParameters["{outputName}"] = String(describing: self.outputName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OutputData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OutputProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OutputData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
