import Foundation
import azureSwiftRuntime
public protocol DomainsGetControlCenterSsoRequest  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DomainControlCenterSsoRequestProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Domains {
// GetControlCenterSsoRequest generate a single sign-on request for the domain management portal.
internal class GetControlCenterSsoRequestCommand : BaseCommand, DomainsGetControlCenterSsoRequest {
    public var subscriptionId : String
    public var apiVersion = "2015-04-01"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/generateSsoRequest"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DomainControlCenterSsoRequestData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DomainControlCenterSsoRequestProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DomainControlCenterSsoRequestData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
