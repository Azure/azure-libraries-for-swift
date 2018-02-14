import Foundation
import azureSwiftRuntime
public protocol SubscriptionsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var topicName : String { get set }
    var subscriptionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SBSubscriptionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Subscriptions {
// Get returns a subscription description for the specified topic.
internal class GetCommand : BaseCommand, SubscriptionsGet {
    public var resourceGroupName : String
    public var namespaceName : String
    public var topicName : String
    public var subscriptionName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"

    public init(resourceGroupName: String, namespaceName: String, topicName: String, subscriptionName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.topicName = topicName
        self.subscriptionName = subscriptionName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/topics/{topicName}/subscriptions/{subscriptionName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{topicName}"] = String(describing: self.topicName)
        self.pathParameters["{subscriptionName}"] = String(describing: self.subscriptionName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SBSubscriptionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SBSubscriptionProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SBSubscriptionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
