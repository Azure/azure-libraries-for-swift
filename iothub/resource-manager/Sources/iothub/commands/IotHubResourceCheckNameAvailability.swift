import Foundation
import azureSwiftRuntime
public protocol IotHubResourceCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var operationInputs :  OperationInputsProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IotHubNameAvailabilityInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// CheckNameAvailability check if an IoT hub name is available.
internal class CheckNameAvailabilityCommand : BaseCommand, IotHubResourceCheckNameAvailability {
    public var subscriptionId : String
    public var apiVersion = "2017-07-01"
    public var operationInputs :  OperationInputsProtocol?

    public init(subscriptionId: String, operationInputs: OperationInputsProtocol) {
        self.subscriptionId = subscriptionId
        self.operationInputs = operationInputs
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Devices/checkNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = operationInputs
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(operationInputs)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(IotHubNameAvailabilityInfoData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IotHubNameAvailabilityInfoProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: IotHubNameAvailabilityInfoData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
