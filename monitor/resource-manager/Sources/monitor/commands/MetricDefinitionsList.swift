import Foundation
import azureSwiftRuntime
public protocol MetricDefinitionsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (MetricDefinitionCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.MetricDefinitions {
// List lists the metric definitions for the resource.
internal class ListCommand : BaseCommand, MetricDefinitionsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var resourceUri : String
    public var apiVersion = "2017-05-01-preview"

    public init(resourceUri: String) {
        self.resourceUri = resourceUri
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{resourceUri}/providers/microsoft.insights/metricDefinitions"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "nil"
            }
            let result = try decoder.decode(MetricDefinitionCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (MetricDefinitionCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: MetricDefinitionCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
