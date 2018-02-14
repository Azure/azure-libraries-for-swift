import Foundation
import azureSwiftRuntime
public protocol ReplicationRecoveryPlansFailoverCommit  {
    var headerParameters: [String: String] { get set }
    var resourceName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var recoveryPlanName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryPlanProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReplicationRecoveryPlans {
// FailoverCommit the operation to commit the fail over of a recovery plan. This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
internal class FailoverCommitCommand : BaseCommand, ReplicationRecoveryPlansFailoverCommit {
    public var resourceName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var recoveryPlanName : String
    public var apiVersion = "2016-08-10"

    public init(resourceName: String, resourceGroupName: String, subscriptionId: String, recoveryPlanName: String) {
        self.resourceName = resourceName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        self.recoveryPlanName = recoveryPlanName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{resourceName}/replicationRecoveryPlans/{recoveryPlanName}/failoverCommit"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{recoveryPlanName}"] = String(describing: self.recoveryPlanName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RecoveryPlanData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryPlanProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: RecoveryPlanData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
