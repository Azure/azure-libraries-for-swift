import Foundation
import azureSwiftRuntime
public protocol WidgetTypesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var widgetTypeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WidgetTypeResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WidgetTypes {
// Get gets a widget type in the specified hub.
    internal class GetCommand : BaseCommand, WidgetTypesGet {
        public var resourceGroupName : String
        public var hubName : String
        public var widgetTypeName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"

        public init(resourceGroupName: String, hubName: String, widgetTypeName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.widgetTypeName = widgetTypeName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/widgetTypes/{widgetTypeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{widgetTypeName}"] = String(describing: self.widgetTypeName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WidgetTypeResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WidgetTypeResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WidgetTypeResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
