import Foundation
import azureSwiftRuntime
public protocol OutputsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var outputName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var output :  OutputProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Outputs {
// Update updates an existing output under an existing streaming job. This can be used to partially update (ie. update
// one or two properties) an output without affecting the rest the job or output definition.
internal class UpdateCommand : BaseCommand, OutputsUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobName : String
    public var outputName : String
    public var apiVersion = "2016-03-01"
    public var ifMatch : String?
    public var output :  OutputProtocol?

    public init(subscriptionId: String, resourceGroupName: String, jobName: String, outputName: String, output: OutputProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.outputName = outputName
        self.output = output
        super.init()
        self.method = "Patch"
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
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
    self.body = output
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(output)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
