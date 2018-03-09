import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateFunction  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var functionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var functionEnvelope :  FunctionEnvelopeProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (FunctionEnvelopeProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateFunction create function for web site, or a deployment slot. This method may poll for completion. Polling can
// be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding
// HTTP requests.
    internal class CreateFunctionCommand : BaseCommand, WebAppsCreateFunction {
        public var resourceGroupName : String
        public var name : String
        public var functionName : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var functionEnvelope :  FunctionEnvelopeProtocol?

        public init(resourceGroupName: String, name: String, functionName: String, subscriptionId: String, functionEnvelope: FunctionEnvelopeProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.functionName = functionName
            self.subscriptionId = subscriptionId
            self.functionEnvelope = functionEnvelope
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/functions/{functionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{functionName}"] = String(describing: self.functionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = functionEnvelope

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(functionEnvelope as? FunctionEnvelopeData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(FunctionEnvelopeData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (FunctionEnvelopeProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: FunctionEnvelopeData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
