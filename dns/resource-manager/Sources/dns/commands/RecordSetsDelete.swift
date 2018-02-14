import Foundation
import azureSwiftRuntime
public protocol RecordSetsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var zoneName : String { get set }
    var relativeRecordSetName : String { get set }
    var recordType : RecordTypeEnum { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.RecordSets {
// Delete deletes a record set from a DNS zone. This operation cannot be undone.
internal class DeleteCommand : BaseCommand, RecordSetsDelete {
    public var resourceGroupName : String
    public var zoneName : String
    public var relativeRecordSetName : String
    public var recordType : RecordTypeEnum
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"
    public var ifMatch : String?

    public init(resourceGroupName: String, zoneName: String, relativeRecordSetName: String, recordType: RecordTypeEnum, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.zoneName = zoneName
        self.relativeRecordSetName = relativeRecordSetName
        self.recordType = recordType
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsZones/{zoneName}/{recordType}/{relativeRecordSetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{zoneName}"] = String(describing: self.zoneName)
        self.pathParameters["{relativeRecordSetName}"] = String(describing: self.relativeRecordSetName)
        self.pathParameters["{recordType}"] = String(describing: self.recordType)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
}


    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
