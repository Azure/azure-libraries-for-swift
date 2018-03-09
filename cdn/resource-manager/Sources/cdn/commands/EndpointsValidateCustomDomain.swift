import Foundation
import azureSwiftRuntime
public protocol EndpointsValidateCustomDomain  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var customDomainProperties :  ValidateCustomDomainInputProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ValidateCustomDomainOutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Endpoints {
// ValidateCustomDomain validates the custom domain mapping to ensure it maps to the correct CDN endpoint in DNS.
    internal class ValidateCustomDomainCommand : BaseCommand, EndpointsValidateCustomDomain {
        public var resourceGroupName : String
        public var profileName : String
        public var endpointName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-02"
    public var customDomainProperties :  ValidateCustomDomainInputProtocol?

        public init(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, customDomainProperties: ValidateCustomDomainInputProtocol) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.endpointName = endpointName
            self.subscriptionId = subscriptionId
            self.customDomainProperties = customDomainProperties
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/endpoints/{endpointName}/validateCustomDomain"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
            self.pathParameters["{endpointName}"] = String(describing: self.endpointName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = customDomainProperties

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(customDomainProperties as? ValidateCustomDomainInputData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ValidateCustomDomainOutputData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ValidateCustomDomainOutputProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ValidateCustomDomainOutputData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
