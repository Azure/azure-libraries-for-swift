import Foundation
import azureSwiftRuntime
public protocol AppServicePlansGetServerFarmSkus  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// GetServerFarmSkus gets all selectable sku's for a given App Service Plan
internal class GetServerFarmSkusCommand : BaseCommand, AppServicePlansGetServerFarmSkus {
    public var resourceGroupName : String
    public var name : String
    public var subscriptionId : String
    public var apiVersion = "2016-09-01"

    public init(resourceGroupName: String, name: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/skus"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode([String: String?]?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: [String: String?]?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
