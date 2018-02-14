import Foundation
import azureSwiftRuntime
public protocol RecordSetsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var zoneName : String { get set }
    var relativeRecordSetName : String { get set }
    var recordType : RecordTypeEnum { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var parameters :  RecordSetProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RecordSetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RecordSets {
// Update updates a record set within a DNS zone.
internal class UpdateCommand : BaseCommand, RecordSetsUpdate {
    public var resourceGroupName : String
    public var zoneName : String
    public var relativeRecordSetName : String
    public var recordType : RecordTypeEnum
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"
    public var ifMatch : String?
    public var parameters :  RecordSetProtocol?

    public init(resourceGroupName: String, zoneName: String, relativeRecordSetName: String, recordType: RecordTypeEnum, subscriptionId: String, parameters: RecordSetProtocol) {
        self.resourceGroupName = resourceGroupName
        self.zoneName = zoneName
        self.relativeRecordSetName = relativeRecordSetName
        self.recordType = recordType
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Patch"
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
            let result = try decoder.decode(RecordSetData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RecordSetProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RecordSetData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
