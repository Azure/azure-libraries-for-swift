import Foundation
import azureSwiftRuntime
public protocol AvailabilitySetsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var availabilitySetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AvailabilitySets {
// Delete delete an availability set.
internal class DeleteCommand : BaseCommand, AvailabilitySetsDelete {
    public var resourceGroupName : String
    public var availabilitySetName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"

    public init(resourceGroupName: String, availabilitySetName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.availabilitySetName = availabilitySetName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/availabilitySets/{availabilitySetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{availabilitySetName}"] = String(describing: self.availabilitySetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OperationStatusResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OperationStatusResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
