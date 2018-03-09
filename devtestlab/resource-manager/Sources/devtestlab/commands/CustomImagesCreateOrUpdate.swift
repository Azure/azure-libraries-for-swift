import Foundation
import azureSwiftRuntime
public protocol CustomImagesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var customImage :  CustomImageProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CustomImageProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.CustomImages {
// CreateOrUpdate create or replace an existing custom image. This operation can take a while to complete. This method
// may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, CustomImagesCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var customImage :  CustomImageProtocol?

        public init(subscriptionId: String, resourceGroupName: String, labName: String, name: String, customImage: CustomImageProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.name = name
            self.customImage = customImage
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/customimages/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = customImage

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(customImage as? CustomImageData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CustomImageData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CustomImageProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: CustomImageData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
