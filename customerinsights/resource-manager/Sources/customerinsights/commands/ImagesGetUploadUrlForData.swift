import Foundation
import azureSwiftRuntime
public protocol ImagesGetUploadUrlForData  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  GetImageUploadUrlInputProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ImageDefinitionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Images {
// GetUploadUrlForData gets data image upload URL.
    internal class GetUploadUrlForDataCommand : BaseCommand, ImagesGetUploadUrlForData {
        public var resourceGroupName : String
        public var hubName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
    public var parameters :  GetImageUploadUrlInputProtocol?

        public init(resourceGroupName: String, hubName: String, subscriptionId: String, parameters: GetImageUploadUrlInputProtocol) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/images/getDataImageUploadUrl"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GetImageUploadUrlInputData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ImageDefinitionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ImageDefinitionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ImageDefinitionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
