import Foundation
import azureSwiftRuntime
public protocol AdminKeysRegenerate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var searchServiceName : String { get set }
    var keyKind : AdminKeyKindEnum { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AdminKeyResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AdminKeys {
// Regenerate regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.
internal class RegenerateCommand : BaseCommand, AdminKeysRegenerate {
    public var resourceGroupName : String
    public var searchServiceName : String
    public var keyKind : AdminKeyKindEnum
    public var subscriptionId : String
    public var apiVersion = "2015-08-19"
    public var clientRequestId : String?

    public init(resourceGroupName: String, searchServiceName: String, keyKind: AdminKeyKindEnum, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.searchServiceName = searchServiceName
        self.keyKind = keyKind
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/regenerateAdminKey/{keyKind}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{searchServiceName}"] = String(describing: self.searchServiceName)
        self.pathParameters["{keyKind}"] = String(describing: self.keyKind)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["x-ms-client-request-id"] = String(describing: self.clientRequestId!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AdminKeyResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AdminKeyResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AdminKeyResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
