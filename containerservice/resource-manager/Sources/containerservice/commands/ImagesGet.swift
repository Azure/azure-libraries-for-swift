import Foundation
import azureSwiftRuntime
public protocol ImagesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var imageName : String { get set }
    var subscriptionId : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ImageProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Images {
// Get gets an image.
internal class GetCommand : BaseCommand, ImagesGet {
    public var resourceGroupName : String
    public var imageName : String
    public var subscriptionId : String
    public var expand : String?
    public var apiVersion = "2017-12-01"

    public init(resourceGroupName: String, imageName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.imageName = imageName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/images/{imageName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{imageName}"] = String(describing: self.imageName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ImageData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ImageProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ImageData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
