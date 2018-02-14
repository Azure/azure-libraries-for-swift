import Foundation
import azureSwiftRuntime
public protocol DiagnosticsListSiteDetectors  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var diagnosticCategory : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DiagnosticDetectorCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Diagnostics {
// ListSiteDetectors get Detectors
internal class ListSiteDetectorsCommand : BaseCommand, DiagnosticsListSiteDetectors {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var resourceGroupName : String
    public var siteName : String
    public var diagnosticCategory : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"

    public init(resourceGroupName: String, siteName: String, diagnosticCategory: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.siteName = siteName
        self.diagnosticCategory = diagnosticCategory
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/diagnostics/{diagnosticCategory}/detectors"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{siteName}"] = String(describing: self.siteName)
        self.pathParameters["{diagnosticCategory}"] = String(describing: self.diagnosticCategory)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
            let result = try decoder.decode(DiagnosticDetectorCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DiagnosticDetectorCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: DiagnosticDetectorCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
