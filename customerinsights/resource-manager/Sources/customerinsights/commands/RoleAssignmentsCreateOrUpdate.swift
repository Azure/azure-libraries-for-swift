import Foundation
import azureSwiftRuntime
public protocol RoleAssignmentsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var assignmentName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RoleAssignmentResourceFormatProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RoleAssignmentResourceFormatProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RoleAssignments {
// CreateOrUpdate creates or updates a role assignment in the hub. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CreateOrUpdateCommand : BaseCommand, RoleAssignmentsCreateOrUpdate {
        public var resourceGroupName : String
        public var hubName : String
        public var assignmentName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-26"
    public var parameters :  RoleAssignmentResourceFormatProtocol?

        public init(resourceGroupName: String, hubName: String, assignmentName: String, subscriptionId: String, parameters: RoleAssignmentResourceFormatProtocol) {
            self.resourceGroupName = resourceGroupName
            self.hubName = hubName
            self.assignmentName = assignmentName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/roleAssignments/{assignmentName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{hubName}"] = String(describing: self.hubName)
            self.pathParameters["{assignmentName}"] = String(describing: self.assignmentName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RoleAssignmentResourceFormatData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RoleAssignmentResourceFormatData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RoleAssignmentResourceFormatProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: RoleAssignmentResourceFormatData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
