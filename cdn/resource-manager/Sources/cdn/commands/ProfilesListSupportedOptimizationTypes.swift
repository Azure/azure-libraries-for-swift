import Foundation
import azureSwiftRuntime
public protocol ProfilesListSupportedOptimizationTypes  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SupportedOptimizationTypesListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// ListSupportedOptimizationTypes gets the supported optimization types for the current profile. A user can create an
// endpoint with an optimization type from the listed values.
internal class ListSupportedOptimizationTypesCommand : BaseCommand, ProfilesListSupportedOptimizationTypes {
    public var resourceGroupName : String
    public var profileName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-02"

    public init(resourceGroupName: String, profileName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.profileName = profileName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/getSupportedOptimizationTypes"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SupportedOptimizationTypesListResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SupportedOptimizationTypesListResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SupportedOptimizationTypesListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
