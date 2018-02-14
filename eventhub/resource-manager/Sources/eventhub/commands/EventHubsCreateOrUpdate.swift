import Foundation
import azureSwiftRuntime
public protocol EventHubsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var eventHubName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  EventhubProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (EventhubProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.EventHubs {
// CreateOrUpdate creates or updates a new Event Hub as a nested resource within a Namespace.
internal class CreateOrUpdateCommand : BaseCommand, EventHubsCreateOrUpdate {
    public var resourceGroupName : String
    public var namespaceName : String
    public var eventHubName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  EventhubProtocol?

    public init(resourceGroupName: String, namespaceName: String, eventHubName: String, subscriptionId: String, parameters: EventhubProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.eventHubName = eventHubName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
        self.pathParameters["{eventHubName}"] = String(describing: self.eventHubName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(EventhubData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (EventhubProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: EventhubData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
