import Foundation
import azureSwiftRuntime
public protocol GroupsCreate  {
    var headerParameters: [String: String] { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  GroupCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ADGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Groups {
// Create create a group in the directory.
    internal class CreateCommand : BaseCommand, GroupsCreate {
        public var tenantID : String
        public var apiVersion = "1.6"
    public var parameters :  GroupCreateParametersProtocol?

        public init(tenantID: String, parameters: GroupCreateParametersProtocol) {
            self.tenantID = tenantID
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/groups"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GroupCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ADGroupData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ADGroupProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ADGroupData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
