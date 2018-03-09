import Foundation
import azureSwiftRuntime
public protocol AppServicePlansCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var appServicePlan :  AppServicePlanProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AppServicePlanProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// CreateOrUpdate creates or updates an App Service Plan. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CreateOrUpdateCommand : BaseCommand, AppServicePlansCreateOrUpdate {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"
    public var appServicePlan :  AppServicePlanProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, appServicePlan: AppServicePlanProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.appServicePlan = appServicePlan
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
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
                let encodedValue = try encoder.encode(appServicePlan as? AppServicePlanData)
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
            client.executeAsyncLRO(command: self) {
                (result: AppServicePlanData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
