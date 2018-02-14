import Foundation
import azureSwiftRuntime
public protocol NotificationHubsCheckAvailability  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var namespaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckAvailabilityResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NotificationHubs {
// CheckAvailability checks the availability of the given notificationHub in a namespace.
internal class CheckAvailabilityCommand : BaseCommand, NotificationHubsCheckAvailability {
    public var resourceGroupName : String
    public var namespaceName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  CheckAvailabilityParametersProtocol?

    public init(resourceGroupName: String, namespaceName: String, subscriptionId: String, parameters: CheckAvailabilityParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.namespaceName = namespaceName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/checkNotificationHubAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{namespaceName}"] = String(describing: self.namespaceName)
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
            let result = try decoder.decode(CheckAvailabilityResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckAvailabilityResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckAvailabilityResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
