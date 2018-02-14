import Foundation
import azureSwiftRuntime
public protocol DscCompilationJobGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var compilationJobId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DscCompilationJobProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DscCompilationJob {
// Get retrieve the Dsc configuration compilation job identified by job id.
internal class GetCommand : BaseCommand, DscCompilationJobGet {
    public var resourceGroupName : String
    public var automationAccountName : String
    public var compilationJobId : String
    public var subscriptionId : String
    public var apiVersion = "2015-10-31"

    public init(resourceGroupName: String, automationAccountName: String, compilationJobId: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.automationAccountName = automationAccountName
        self.compilationJobId = compilationJobId
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{compilationJobId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
        self.pathParameters["{compilationJobId}"] = String(describing: self.compilationJobId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DscCompilationJobData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DscCompilationJobProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DscCompilationJobData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
