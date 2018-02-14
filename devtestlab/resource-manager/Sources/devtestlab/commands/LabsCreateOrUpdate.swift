import Foundation
import azureSwiftRuntime
public protocol LabsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var lab :  LabProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LabProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Labs {
// CreateOrUpdate create or replace an existing lab. This operation can take a while to complete. This method may poll
// for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, LabsCreateOrUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var name : String
    public var apiVersion = "2016-05-15"
    public var lab :  LabProtocol?

    public init(subscriptionId: String, resourceGroupName: String, name: String, lab: LabProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.lab = lab
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = lab
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(lab)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LabData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LabProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: LabData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
