import Foundation
import azureSwiftRuntime
public protocol TopicsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var topicName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  SBTopicProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SBTopicProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Topics {
// CreateOrUpdate creates a topic in the specified namespace.
    internal class CreateOrUpdateCommand : BaseCommand, TopicsCreateOrUpdate {
        public var resourceGroupName : String
        public var namespaceName : String
        public var topicName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-01"
    public var parameters :  SBTopicProtocol?

        public init(resourceGroupName: String, namespaceName: String, topicName: String, subscriptionId: String, parameters: SBTopicProtocol) {
            self.resourceGroupName = resourceGroupName
            self.namespaceName = namespaceName
            self.topicName = topicName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
            self.pathParameters["{topicName}"] = String(describing: self.topicName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? SBTopicData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SBTopicData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SBTopicProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SBTopicData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
