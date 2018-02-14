import Foundation
import azureSwiftRuntime
public protocol OperationsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var locationName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Operations {
// Get get operation.
internal class GetCommand : BaseCommand, OperationsGet {
    public var subscriptionId : String
    public var locationName : String
    public var name : String
    public var apiVersion = "2016-05-15"

    public init(subscriptionId: String, locationName: String, name: String) {
        self.subscriptionId = subscriptionId
        self.locationName = locationName
        self.name = name
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DevTestLab/locations/{locationName}/operations/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{locationName}"] = String(describing: self.locationName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OperationResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OperationResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
