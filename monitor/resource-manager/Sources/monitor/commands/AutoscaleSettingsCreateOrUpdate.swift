import Foundation
import azureSwiftRuntime
public protocol AutoscaleSettingsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var autoscaleSettingName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  AutoscaleSettingResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AutoscaleSettingResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AutoscaleSettings {
// CreateOrUpdate creates or updates an autoscale setting.
    internal class CreateOrUpdateCommand : BaseCommand, AutoscaleSettingsCreateOrUpdate {
        public var resourceGroupName : String
        public var autoscaleSettingName : String
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"
    public var parameters :  AutoscaleSettingResourceProtocol?

        public init(resourceGroupName: String, autoscaleSettingName: String, subscriptionId: String, parameters: AutoscaleSettingResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.autoscaleSettingName = autoscaleSettingName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/autoscalesettings/{autoscaleSettingName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{autoscaleSettingName}"] = String(describing: self.autoscaleSettingName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? AutoscaleSettingResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AutoscaleSettingResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AutoscaleSettingResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AutoscaleSettingResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
