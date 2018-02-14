import Foundation
import azureSwiftRuntime
public protocol CheckSkuAvailabilityList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var location : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckSkuAvailabilityParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckSkuAvailabilityResultListProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.CheckSkuAvailability {
// List check available SKUs.
internal class ListCommand : BaseCommand, CheckSkuAvailabilityList {
    public var subscriptionId : String
    public var location : String
    public var apiVersion = "2017-04-18"
    public var parameters :  CheckSkuAvailabilityParameterProtocol?

    public init(subscriptionId: String, location: String, parameters: CheckSkuAvailabilityParameterProtocol) {
        self.subscriptionId = subscriptionId
        self.location = location
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.CognitiveServices/locations/{location}/checkSkuAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{location}"] = String(describing: self.location)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CheckSkuAvailabilityResultListData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckSkuAvailabilityResultListProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckSkuAvailabilityResultListData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
