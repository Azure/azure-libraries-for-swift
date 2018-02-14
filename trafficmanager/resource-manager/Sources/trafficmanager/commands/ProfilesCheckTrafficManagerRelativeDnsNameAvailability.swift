import Foundation
import azureSwiftRuntime
public protocol ProfilesCheckTrafficManagerRelativeDnsNameAvailability  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    var parameters :  CheckTrafficManagerRelativeDnsNameAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerNameAvailabilityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// CheckTrafficManagerRelativeDnsNameAvailability checks the availability of a Traffic Manager Relative DNS name.
internal class CheckTrafficManagerRelativeDnsNameAvailabilityCommand : BaseCommand, ProfilesCheckTrafficManagerRelativeDnsNameAvailability {
    public var apiVersion = "2017-05-01"
    public var parameters :  CheckTrafficManagerRelativeDnsNameAvailabilityParametersProtocol?

    public init(parameters: CheckTrafficManagerRelativeDnsNameAvailabilityParametersProtocol) {
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Network/checkTrafficManagerNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
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
            let result = try decoder.decode(TrafficManagerNameAvailabilityData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerNameAvailabilityProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: TrafficManagerNameAvailabilityData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
