import Foundation
import azureSwiftRuntime
public protocol DisksGrantAccess  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var diskName : String { get set }
    var apiVersion : String { get set }
    var grantAccessData :  GrantAccessDataProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AccessUriProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Disks {
// GrantAccess grants access to a disk. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class GrantAccessCommand : BaseCommand, DisksGrantAccess {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var diskName : String
        public var apiVersion = "2017-03-30"
    public var grantAccessData :  GrantAccessDataProtocol?

        public init(subscriptionId: String, resourceGroupName: String, diskName: String, grantAccessData: GrantAccessDataProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.diskName = diskName
            self.grantAccessData = grantAccessData
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}/beginGetAccess"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{diskName}"] = String(describing: self.diskName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = grantAccessData

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(grantAccessData as? GrantAccessDataData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AccessUriData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AccessUriProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: AccessUriData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
