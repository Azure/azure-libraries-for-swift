import Foundation
import azureSwiftRuntime
public protocol LogProfilesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var logProfileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  LogProfileResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LogProfileResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LogProfiles {
// CreateOrUpdate create or update a log profile in Azure Monitoring REST API.
internal class CreateOrUpdateCommand : BaseCommand, LogProfilesCreateOrUpdate {
    public var logProfileName : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"
    public var parameters :  LogProfileResourceProtocol?

    public init(logProfileName: String, subscriptionId: String, parameters: LogProfileResourceProtocol) {
        self.logProfileName = logProfileName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{logProfileName}"] = String(describing: self.logProfileName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
