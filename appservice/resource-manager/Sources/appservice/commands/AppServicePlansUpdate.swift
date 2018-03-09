import Foundation
import azureSwiftRuntime
public protocol AppServicePlansUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var appServicePlan :  AppServicePlanPatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AppServicePlanProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// Update creates or updates an App Service Plan.
    internal class UpdateCommand : BaseCommand, AppServicePlansUpdate {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"
    public var appServicePlan :  AppServicePlanPatchResourceProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, appServicePlan: AppServicePlanPatchResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.appServicePlan = appServicePlan
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = appServicePlan

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(appServicePlan as? AppServicePlanPatchResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AppServicePlanData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AppServicePlanProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AppServicePlanData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
