import Foundation
import azureSwiftRuntime
public protocol ServicePrincipalsUpdatePasswordCredentials  {
    var headerParameters: [String: String] { get set }
    var objectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  PasswordCredentialsUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ServicePrincipals {
// UpdatePasswordCredentials updates the passwordCredentials associated with a service principal.
    internal class UpdatePasswordCredentialsCommand : BaseCommand, ServicePrincipalsUpdatePasswordCredentials {
        public var objectId : String
        public var tenantID : String
        public var apiVersion = "1.6"
    public var parameters :  PasswordCredentialsUpdateParametersProtocol?

        public init(objectId: String, tenantID: String, parameters: PasswordCredentialsUpdateParametersProtocol) {
            self.objectId = objectId
            self.tenantID = tenantID
            self.parameters = parameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/servicePrincipals/{objectId}/passwordCredentials"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{objectId}"] = String(describing: self.objectId)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? PasswordCredentialsUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
