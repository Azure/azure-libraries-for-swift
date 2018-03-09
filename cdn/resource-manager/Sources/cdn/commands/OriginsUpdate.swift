import Foundation
import azureSwiftRuntime
public protocol OriginsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointName : String { get set }
    var originName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var originUpdateProperties :  OriginUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (OriginProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Origins {
// Update updates an existing origin within an endpoint. This method may poll for completion. Polling can be canceled
// by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class UpdateCommand : BaseCommand, OriginsUpdate {
        public var resourceGroupName : String
        public var profileName : String
        public var endpointName : String
        public var originName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-02"
    public var originUpdateProperties :  OriginUpdateParametersProtocol?

        public init(resourceGroupName: String, profileName: String, endpointName: String, originName: String, subscriptionId: String, originUpdateProperties: OriginUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.endpointName = endpointName
            self.originName = originName
            self.subscriptionId = subscriptionId
            self.originUpdateProperties = originUpdateProperties
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/endpoints/{endpointName}/origins/{originName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
            self.pathParameters["{endpointName}"] = String(describing: self.endpointName)
            self.pathParameters["{originName}"] = String(describing: self.originName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = originUpdateProperties

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(originUpdateProperties as? OriginUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(OriginData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (OriginProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: OriginData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
