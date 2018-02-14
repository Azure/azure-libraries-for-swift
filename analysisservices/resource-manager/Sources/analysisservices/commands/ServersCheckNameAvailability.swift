import Foundation
import azureSwiftRuntime
public protocol ServersCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var serverParameters :  CheckServerNameAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckServerNameAvailabilityResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// CheckNameAvailability check the name availability in the target location.
internal class CheckNameAvailabilityCommand : BaseCommand, ServersCheckNameAvailability {
    public var location : String
    public var subscriptionId : String
    public var apiVersion = "2017-08-01"
    public var serverParameters :  CheckServerNameAvailabilityParametersProtocol?

    public init(location: String, subscriptionId: String, serverParameters: CheckServerNameAvailabilityParametersProtocol) {
        self.location = location
        self.subscriptionId = subscriptionId
        self.serverParameters = serverParameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/checkNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = serverParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(serverParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CheckServerNameAvailabilityResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckServerNameAvailabilityResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckServerNameAvailabilityResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
