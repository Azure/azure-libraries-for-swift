import Foundation
import azureSwiftRuntime
public protocol ServiceUpdateSourceControl  {
    var headerParameters: [String: String] { get set }
    var sourceControlType : String { get set }
    var apiVersion : String { get set }
    var requestMessage :  SourceControlProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SourceControlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// UpdateSourceControl updates source control token
    internal class UpdateSourceControlCommand : BaseCommand, ServiceUpdateSourceControl {
        public var sourceControlType : String
        public var apiVersion = "2016-03-01"
    public var requestMessage :  SourceControlProtocol?

        public init(sourceControlType: String, requestMessage: SourceControlProtocol) {
            self.sourceControlType = sourceControlType
            self.requestMessage = requestMessage
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/sourcecontrols/{sourceControlType}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{sourceControlType}"] = String(describing: self.sourceControlType)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = requestMessage

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(requestMessage as? SourceControlData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SourceControlData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SourceControlProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SourceControlData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
