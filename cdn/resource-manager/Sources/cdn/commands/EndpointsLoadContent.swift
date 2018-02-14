import Foundation
import azureSwiftRuntime
public protocol EndpointsLoadContent  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var endpointName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var contentFilePaths :  LoadParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Endpoints {
// LoadContent pre-loads a content to CDN. Available for Verizon Profiles. This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
internal class LoadContentCommand : BaseCommand, EndpointsLoadContent {
    public var resourceGroupName : String
    public var profileName : String
    public var endpointName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-02"
    public var contentFilePaths :  LoadParametersProtocol?

    public init(resourceGroupName: String, profileName: String, endpointName: String, subscriptionId: String, contentFilePaths: LoadParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.profileName = profileName
        self.endpointName = endpointName
        self.subscriptionId = subscriptionId
        self.contentFilePaths = contentFilePaths
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/endpoints/{endpointName}/load"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{endpointName}"] = String(describing: self.endpointName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = contentFilePaths
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(contentFilePaths)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
