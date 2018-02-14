import Foundation
import azureSwiftRuntime
public protocol WebAppsGetHostNameBinding  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var hostName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (HostNameBindingProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetHostNameBinding get the named hostname binding for an app (or deployment slot, if specified).
internal class GetHostNameBindingCommand : BaseCommand, WebAppsGetHostNameBinding {
    public var resourceGroupName : String
    public var name : String
    public var hostName : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"

    public init(resourceGroupName: String, name: String, hostName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.hostName = hostName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/hostNameBindings/{hostName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{hostName}"] = String(describing: self.hostName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(HostNameBindingData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (HostNameBindingProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: HostNameBindingData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
