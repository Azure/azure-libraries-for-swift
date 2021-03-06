import Foundation
import azureSwiftRuntime
public protocol UsersGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var name : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (UserProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Users {
// Get get user profile.
    internal class GetCommand : BaseCommand, UsersGet {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var name : String
        public var expand : String?
        public var apiVersion = "2016-05-15"

        public init(subscriptionId: String, resourceGroupName: String, labName: String, name: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.name = name
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{name}"] = String(describing: self.name)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(UserData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (UserProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: UserData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
