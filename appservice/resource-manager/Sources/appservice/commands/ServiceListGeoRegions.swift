import Foundation
import azureSwiftRuntime
public protocol ServiceListGeoRegions  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var sku : SkuNameEnum? { get set }
    var linuxWorkersEnabled : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (GeoRegionCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// ListGeoRegions get a list of available geographical regions.
internal class ListGeoRegionsCommand : BaseCommand, ServiceListGeoRegions {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var sku : SkuNameEnum?
    public var linuxWorkersEnabled : Bool?
    public var apiVersion = "2016-03-01"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/geoRegions"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.sku != nil { queryParameters["sku"] = String(describing: self.sku!) }
        if self.linuxWorkersEnabled != nil { queryParameters["linuxWorkersEnabled"] = String(describing: self.linuxWorkersEnabled!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(GeoRegionCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (GeoRegionCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: GeoRegionCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
