import Foundation
import azureSwiftRuntime
public protocol LogProfilesUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var logProfileName : String { get set }
    var apiVersion : String { get set }
    var logProfilesResource :  LogProfileResourcePatchProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LogProfileResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LogProfiles {
// Update updates an existing LogProfilesResource. To update other fields use the CreateOrUpdate method.
internal class UpdateCommand : BaseCommand, LogProfilesUpdate {
    public var subscriptionId : String
    public var logProfileName : String
    public var apiVersion = "2016-03-01"
    public var logProfilesResource :  LogProfileResourcePatchProtocol?

    public init(subscriptionId: String, logProfileName: String, logProfilesResource: LogProfileResourcePatchProtocol) {
        self.subscriptionId = subscriptionId
        self.logProfileName = logProfileName
        self.logProfilesResource = logProfilesResource
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{logProfileName}"] = String(describing: self.logProfileName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = logProfilesResource
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(logProfilesResource)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LogProfileResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LogProfileResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: LogProfileResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
