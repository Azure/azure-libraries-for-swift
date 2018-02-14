import Foundation
import azureSwiftRuntime
public protocol ApplicationsGet  {
    var headerParameters: [String: String] { get set }
    var applicationObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Applications {
// Get get an application by object ID.
internal class GetCommand : BaseCommand, ApplicationsGet {
    public var applicationObjectId : String
    public var tenantID : String
    public var apiVersion = "1.6"

    public init(applicationObjectId: String, tenantID: String) {
        self.applicationObjectId = applicationObjectId
        self.tenantID = tenantID
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{tenantID}/applications/{applicationObjectId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{applicationObjectId}"] = String(describing: self.applicationObjectId)
        self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ApplicationData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ApplicationProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ApplicationData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
