import Foundation
import azureSwiftRuntime
public protocol ApplicationSecurityGroupsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var applicationSecurityGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationSecurityGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ApplicationSecurityGroups {
// Get gets information about the specified application security group.
internal class GetCommand : BaseCommand, ApplicationSecurityGroupsGet {
    public var resourceGroupName : String
    public var applicationSecurityGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, applicationSecurityGroupName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.applicationSecurityGroupName = applicationSecurityGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{applicationSecurityGroupName}"] = String(describing: self.applicationSecurityGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ApplicationSecurityGroupData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationSecurityGroupProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ApplicationSecurityGroupData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
