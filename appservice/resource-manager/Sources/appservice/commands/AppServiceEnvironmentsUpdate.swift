import Foundation
import azureSwiftRuntime
public protocol AppServiceEnvironmentsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var hostingEnvironmentEnvelope :  AppServiceEnvironmentPatchResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AppServiceEnvironmentResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceEnvironments {
// Update create or update an App Service Environment.
    internal class UpdateCommand : BaseCommand, AppServiceEnvironmentsUpdate {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"
    public var hostingEnvironmentEnvelope :  AppServiceEnvironmentPatchResourceProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, hostingEnvironmentEnvelope: AppServiceEnvironmentPatchResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.hostingEnvironmentEnvelope = hostingEnvironmentEnvelope
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = hostingEnvironmentEnvelope

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(hostingEnvironmentEnvelope as? AppServiceEnvironmentPatchResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AppServiceEnvironmentResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AppServiceEnvironmentResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: AppServiceEnvironmentResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
