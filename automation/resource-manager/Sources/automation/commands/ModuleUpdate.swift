import Foundation
import azureSwiftRuntime
public protocol ModuleUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var moduleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ModuleUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ModuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Module {
// Update update the module identified by module name.
internal class UpdateCommand : BaseCommand, ModuleUpdate {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var moduleName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"
    public var parameters :  ModuleUpdateParametersProtocol?

    public init(resourceGroupName: String, automationAccountName: String, moduleName: String, subscriptionId: String, parameters: ModuleUpdateParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.moduleName = moduleName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{moduleName}"] = String(describing: self.moduleName)
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
            let result = try decoder.decode(ModuleData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ModuleProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ModuleData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
