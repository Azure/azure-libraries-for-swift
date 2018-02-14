import Foundation
import azureSwiftRuntime
public protocol ServiceCheckDnsNameAvailability  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var subscriptionId : String { get set }
    var domainNameLabel : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DnsNameAvailabilityResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// CheckDnsNameAvailability checks whether a domain name in the cloudapp.azure.com zone is available for use.
internal class CheckDnsNameAvailabilityCommand : BaseCommand, ServiceCheckDnsNameAvailability {
    public var location : String
    public var subscriptionId : String
    public var domainNameLabel : String
    public var apiVersion = "2018-01-01"

    public init(location: String, subscriptionId: String, domainNameLabel: String) {
        self.location = location
        self.subscriptionId = subscriptionId
        self.domainNameLabel = domainNameLabel
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/CheckDnsNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["domainNameLabel"] = String(describing: self.domainNameLabel)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DnsNameAvailabilityResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DnsNameAvailabilityResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DnsNameAvailabilityResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
