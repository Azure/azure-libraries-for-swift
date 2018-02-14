import Foundation
import azureSwiftRuntime
public protocol LabsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LabProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Labs {
// Get get lab.
internal class GetCommand : BaseCommand, LabsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var name : String
    public var expand : String?
    public var apiVersion = "2016-05-15"

    public init(subscriptionId: String, resourceGroupName: String, name: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.name = name
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LabData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LabProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: LabData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
