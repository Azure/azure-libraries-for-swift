import Foundation
import azureSwiftRuntime
public protocol DscNodeUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var nodeId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  DscNodeUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DscNodeProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DscNode {
// Update update the dsc node.
internal class UpdateCommand : BaseCommand, DscNodeUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var nodeId : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  DscNodeUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, nodeId: String, subscriptionId: String, parameters: DscNodeUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.nodeId = nodeId
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{nodeId}"] = String(describing: self.nodeId)
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
            let result = try decoder.decode(DscNodeData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DscNodeProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DscNodeData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
