import Foundation
import azureSwiftRuntime
public protocol ViewsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var viewName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ViewResourceFormatProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ViewResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Views {
// CreateOrUpdate creates a view or updates an exisiting view in the hub.
    internal class CreateOrUpdateCommand : BaseCommand, ViewsCreateOrUpdate {
        public var resourceGroupName : String
        public var hubName : String
        public var viewName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
    public var parameters :  ViewResourceFormatProtocol?

        public init(resourceGroupName: String, hubName: String, viewName: String, subscriptionId: String, parameters: ViewResourceFormatProtocol) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.viewName = viewName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/views/{viewName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{viewName}"] = String(describing: self.viewName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ViewResourceFormatData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ViewResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ViewResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ViewResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
