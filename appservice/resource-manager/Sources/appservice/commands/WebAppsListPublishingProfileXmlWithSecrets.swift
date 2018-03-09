import Foundation
import azureSwiftRuntime
public protocol WebAppsListPublishingProfileXmlWithSecrets  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var publishingProfileOptions :  CsmPublishingProfileOptionsProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// ListPublishingProfileXmlWithSecrets gets the publishing profile for an app (or deployment slot, if specified).
    internal class ListPublishingProfileXmlWithSecretsCommand : BaseCommand, WebAppsListPublishingProfileXmlWithSecrets {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var publishingProfileOptions :  CsmPublishingProfileOptionsProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, publishingProfileOptions: CsmPublishingProfileOptionsProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.publishingProfileOptions = publishingProfileOptions
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/publishxml"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = publishingProfileOptions

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/octet-stream"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(publishingProfileOptions as? CsmPublishingProfileOptionsData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            return DataWrapper(data: data);
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DataWrapper?, error: Error?) in
                let data = result?.data as Data?
                completionHandler(data!, error)
            }
        }
    }
}
