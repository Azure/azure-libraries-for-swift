import Foundation
import azureSwiftRuntime
public protocol TransformationsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var transformationName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (TransformationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Transformations {
// Get gets details about the specified transformation.
internal class GetCommand : BaseCommand, TransformationsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var jobName : String
    public var transformationName : String
    public var apiVersion = "2016-03-01"

    public init(subscriptionId: String, resourceGroupName: String, jobName: String, transformationName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.jobName = jobName
        self.transformationName = transformationName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/Microsoft.StreamAnalytics/streamingjobs/{jobName}/transformations/{transformationName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{jobName}"] = String(describing: self.jobName)
        self.pathParameters["{transformationName}"] = String(describing: self.transformationName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(TransformationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (TransformationProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: TransformationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
