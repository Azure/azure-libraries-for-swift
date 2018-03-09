import Foundation
import azureSwiftRuntime
public protocol ServiceTierAdvisorsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var databaseName : String { get set }
    var serviceTierAdvisorName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServiceTierAdvisorProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServiceTierAdvisors {
// Get gets a service tier advisor.
    internal class GetCommand : BaseCommand, ServiceTierAdvisorsGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var databaseName : String
        public var serviceTierAdvisorName : String
        public var apiVersion = "2014-04-01"

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, databaseName: String, serviceTierAdvisorName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.databaseName = databaseName
            self.serviceTierAdvisorName = serviceTierAdvisorName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/serviceTierAdvisors/{serviceTierAdvisorName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{databaseName}"] = String(describing: self.databaseName)
            self.pathParameters["{serviceTierAdvisorName}"] = String(describing: self.serviceTierAdvisorName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServiceTierAdvisorData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServiceTierAdvisorProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ServiceTierAdvisorData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
