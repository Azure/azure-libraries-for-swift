import Foundation
import azureSwiftRuntime
public protocol ServiceValidate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var validateRequest :  ValidateRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ValidateResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// Validate validate if a resource can be created.
    internal class ValidateCommand : BaseCommand, ServiceValidate {
        public var resourceGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"
    public var validateRequest :  ValidateRequestProtocol?

        public init(resourceGroupName: String, subscriptionId: String, validateRequest: ValidateRequestProtocol) {
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.validateRequest = validateRequest
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/validate"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = validateRequest

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(validateRequest as? ValidateRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ValidateResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ValidateResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ValidateResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
