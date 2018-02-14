import Foundation
import azureSwiftRuntime
public protocol ActivityGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var moduleName : String { get set }
    var activityName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ActivityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Activity {
// Get retrieve the activity in the module identified by module name and activity name.
internal class GetCommand : BaseCommand, ActivityGet {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var moduleName : String
    public var activityName : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, moduleName: String, activityName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.moduleName = moduleName
        self.activityName = activityName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}/activities/{activityName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{moduleName}"] = String(describing: self.moduleName)
        self.pathParameters["{activityName}"] = String(describing: self.activityName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ActivityData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ActivityProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ActivityData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
