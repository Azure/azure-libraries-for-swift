import Foundation
import azureSwiftRuntime
public protocol QueuesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var queueName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SBQueueProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SBQueueProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Queues {
// CreateOrUpdate creates or updates a Service Bus queue. This operation is idempotent.
    internal class CreateOrUpdateCommand : BaseCommand, QueuesCreateOrUpdate {
        public var resourceGroupName : String
        public var namespaceName : String
        public var queueName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  SBQueueProtocol?

        public init(resourceGroupName: String, namespaceName: String, queueName: String, subscriptionId: String, parameters: SBQueueProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.queueName = queueName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/queues/{queueName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{queueName}"] = String(describing: self.queueName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? SBQueueData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SBQueueData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SBQueueProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SBQueueData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
