import Foundation
import azureSwiftRuntime
public protocol IotHubResourceCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String? { get set }
    var iotHubDescription :  IotHubDescriptionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (IotHubDescriptionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// CreateOrUpdate create or update the metadata of an Iot hub. The usual pattern to modify a property is to retrieve
// the IoT hub metadata and security metadata, and then combine them with the modified values in a new body to update
// the IoT hub. This method may poll for completion. Polling can be canceled by passing the cancel channel argument.
// The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, IotHubResourceCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var apiVersion = "2017-07-01"
        public var ifMatch : String?
    public var iotHubDescription :  IotHubDescriptionProtocol?

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, iotHubDescription: IotHubDescriptionProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.iotHubDescription = iotHubDescription
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.ifMatch != nil { headerParameters["If-Match"] = String(describing: self.ifMatch!) }
            self.body = iotHubDescription

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(iotHubDescription as? IotHubDescriptionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(IotHubDescriptionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (IotHubDescriptionProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: IotHubDescriptionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
