import Foundation
import azureSwiftRuntime
public protocol SessionCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var nodeName : String { get set }
    var session : String { get set }
    var apiVersion : String { get set }
    var sessionParameters :  SessionParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SessionResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Session {
// Create creates a session for a node. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class CreateCommand : BaseCommand, SessionCreate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var nodeName : String
    public var session : String
    public var apiVersion = "2016-07-01-preview"
    public var sessionParameters :  SessionParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, nodeName: String, session: String, sessionParameters: SessionParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.nodeName = nodeName
        self.session = session
        self.sessionParameters = sessionParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServerManagement/nodes/{nodeName}/sessions/{session}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{nodeName}"] = String(describing: self.nodeName)
        self.pathParameters["{session}"] = String(describing: self.session)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = sessionParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(sessionParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SessionResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SessionResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: SessionResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
