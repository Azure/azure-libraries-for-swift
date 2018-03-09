import Foundation
import azureSwiftRuntime
public protocol EnvironmentsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var userName : String { get set }
    var expand : String? { get set }
    var filter : String? { get set }
    var top : Int32? { get set }
    var orderby : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResponseWithContinuationDtlEnvironmentProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Environments {
// List list environments in a given user profile.
    internal class ListCommand : BaseCommand, EnvironmentsList {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var userName : String
        public var expand : String?
        public var filter : String?
        public var top : Int32?
        public var orderby : String?
        public var apiVersion = "2016-05-15"

        public init(subscriptionId: String, resourceGroupName: String, labName: String, userName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.userName = userName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/environments"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{userName}"] = String(describing: self.userName)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
            if self.orderby != nil { queryParameters["$orderby"] = String(describing: self.orderby!) }
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
                let result = try decoder.decode(ResponseWithContinuationDtlEnvironmentData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResponseWithContinuationDtlEnvironmentProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ResponseWithContinuationDtlEnvironmentData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}