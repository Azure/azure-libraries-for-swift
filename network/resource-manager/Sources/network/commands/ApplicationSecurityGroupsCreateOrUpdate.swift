import Foundation
import azureSwiftRuntime
public protocol ApplicationSecurityGroupsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var applicationSecurityGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ApplicationSecurityGroupProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ApplicationSecurityGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationSecurityGroups {
// CreateOrUpdate creates or updates an application security group. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CreateOrUpdateCommand : BaseCommand, ApplicationSecurityGroupsCreateOrUpdate {
        public var resourceGroupName : String
        public var applicationSecurityGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  ApplicationSecurityGroupProtocol?

        public init(resourceGroupName: String, applicationSecurityGroupName: String, subscriptionId: String, parameters: ApplicationSecurityGroupProtocol) {
            self.resourceGroupName = resourceGroupName
            self.applicationSecurityGroupName = applicationSecurityGroupName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{applicationSecurityGroupName}"] = String(describing: self.applicationSecurityGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ApplicationSecurityGroupData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ApplicationSecurityGroupData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ApplicationSecurityGroupProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ApplicationSecurityGroupData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
