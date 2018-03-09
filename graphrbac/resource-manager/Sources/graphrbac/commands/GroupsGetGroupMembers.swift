import Foundation
import azureSwiftRuntime
public protocol GroupsGetGroupMembers  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var objectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (GetObjectsResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Groups {
// GetGroupMembers gets the members of a group.
    internal class GetGroupMembersCommand : BaseCommand, GroupsGetGroupMembers {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var objectId : String
        public var tenantID : String
        public var apiVersion = "1.6"

        public init(objectId: String, tenantID: String) {
            self.objectId = objectId
            self.tenantID = tenantID
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/groups/{objectId}/members"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{objectId}"] = String(describing: self.objectId)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "OdatanextLink"
                }
                let result = try decoder.decode(GetObjectsResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (GetObjectsResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: GetObjectsResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
