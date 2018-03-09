import Foundation
import azureSwiftRuntime
public protocol LabsGenerateUploadUri  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var generateUploadUriParameter :  GenerateUploadUriParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (GenerateUploadUriResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Labs {
// GenerateUploadUri generate a URI for uploading custom disk images to a Lab.
    internal class GenerateUploadUriCommand : BaseCommand, LabsGenerateUploadUri {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var generateUploadUriParameter :  GenerateUploadUriParameterProtocol?

        public init(subscriptionId: String, resourceGroupName: String, name: String, generateUploadUriParameter: GenerateUploadUriParameterProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.generateUploadUriParameter = generateUploadUriParameter
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{name}/generateUploadUri"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = generateUploadUriParameter

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(generateUploadUriParameter as? GenerateUploadUriParameterData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(GenerateUploadUriResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (GenerateUploadUriResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: GenerateUploadUriResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
