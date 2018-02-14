import Foundation
import azureSwiftRuntime
public protocol AppServicePlansGetHybridConnectionPlanLimit  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionLimitsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// GetHybridConnectionPlanLimit get the maximum number of Hybrid Connections allowed in an App Service plan.
internal class GetHybridConnectionPlanLimitCommand : BaseCommand, AppServicePlansGetHybridConnectionPlanLimit {
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
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/hybridConnectionPlanLimits/limit"
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
            let result = try decoder.decode(HybridConnectionLimitsData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (HybridConnectionLimitsProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: HybridConnectionLimitsData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
