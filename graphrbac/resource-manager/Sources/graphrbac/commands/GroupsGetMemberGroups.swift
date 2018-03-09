import Foundation
import azureSwiftRuntime
public protocol GroupsGetMemberGroups  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var objectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  GroupGetMemberGroupsParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (GroupGetMemberGroupsResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Groups {
// GetMemberGroups gets a collection of object IDs of groups of which the specified group is a member.
    internal class GetMemberGroupsCommand : BaseCommand, GroupsGetMemberGroups {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var objectId : String
        public var tenantID : String
        public var apiVersion = "1.6"
    public var parameters :  GroupGetMemberGroupsParametersProtocol?

        public init(objectId: String, tenantID: String, parameters: GroupGetMemberGroupsParametersProtocol) {
            self.objectId = objectId
            self.tenantID = tenantID
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/groups/{objectId}/getMemberGroups"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{objectId}"] = String(describing: self.objectId)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GroupGetMemberGroupsParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "nil"
                }
                let result = try decoder.decode(GroupGetMemberGroupsResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (GroupGetMemberGroupsResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: GroupGetMemberGroupsResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
