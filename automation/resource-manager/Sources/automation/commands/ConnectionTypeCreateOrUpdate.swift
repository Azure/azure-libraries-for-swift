import Foundation
import azureSwiftRuntime
public protocol ConnectionTypeCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var connectionTypeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ConnectionTypeCreateOrUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionTypeProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ConnectionType {
// CreateOrUpdate create a connectiontype.
internal class CreateOrUpdateCommand : BaseCommand, ConnectionTypeCreateOrUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var connectionTypeName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  ConnectionTypeCreateOrUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, connectionTypeName: String, subscriptionId: String, parameters: ConnectionTypeCreateOrUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.connectionTypeName = connectionTypeName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/connectionTypes/{connectionTypeName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{connectionTypeName}"] = String(describing: self.connectionTypeName)
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
            let result = try decoder.decode(ConnectionTypeData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ConnectionTypeProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ConnectionTypeData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
