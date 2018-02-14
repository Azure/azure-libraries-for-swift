import Foundation
import azureSwiftRuntime
public protocol PoliciesUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var policySetName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var policy :  PolicyFragmentProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PolicyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Policies {
// Update modify properties of policies.
internal class UpdateCommand : BaseCommand, PoliciesUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var labName : String
    public var policySetName : String
    public var name : String
    public var apiVersion = "2016-05-15"
    public var policy :  PolicyFragmentProtocol?

    public init(subscriptionId: String, resourceGroupName: String, labName: String, policySetName: String, name: String, policy: PolicyFragmentProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.labName = labName
        self.policySetName = policySetName
        self.name = name
        self.policy = policy
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/policysets/{policySetName}/policies/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{labName}"] = String(describing: self.labName)
        self.pathParameters["{policySetName}"] = String(describing: self.policySetName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = policy
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(policy)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(PolicyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PolicyProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: PolicyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
