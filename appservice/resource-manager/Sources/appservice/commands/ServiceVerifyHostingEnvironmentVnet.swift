import Foundation
import azureSwiftRuntime
public protocol ServiceVerifyHostingEnvironmentVnet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VnetParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VnetValidationFailureDetailsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// VerifyHostingEnvironmentVnet verifies if this VNET is compatible with an App Service Environment by analyzing the
// Network Security Group rules.
    internal class VerifyHostingEnvironmentVnetCommand : BaseCommand, ServiceVerifyHostingEnvironmentVnet {
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"
    public var parameters :  VnetParametersProtocol?

        public init(subscriptionId: String, parameters: VnetParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/verifyHostingEnvironmentVnet"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? VnetParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VnetValidationFailureDetailsData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VnetValidationFailureDetailsProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VnetValidationFailureDetailsData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
