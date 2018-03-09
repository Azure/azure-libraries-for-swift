import Foundation
import azureSwiftRuntime
public protocol ServiceGetSourceControl  {
    var headerParameters: [String: String] { get set }
    var sourceControlType : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SourceControlProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// GetSourceControl gets source control token
    internal class GetSourceControlCommand : BaseCommand, ServiceGetSourceControl {
        public var sourceControlType : String
        public var apiVersion = "2016-03-01"

        public init(sourceControlType: String) {
            self.sourceControlType = sourceControlType
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/sourcecontrols/{sourceControlType}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{sourceControlType}"] = String(describing: self.sourceControlType)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
