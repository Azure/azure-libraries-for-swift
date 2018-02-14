import Foundation
import azureSwiftRuntime
public protocol ProviderGetAvailableStacks  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void ;
}

extension Commands.Provider {
// GetAvailableStacks get available application frameworks and their versions
internal class GetAvailableStacksCommand : BaseCommand, ProviderGetAvailableStacks {
    public var apiVersion = "2016-03-01"

    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Web/availableStacks"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode([String: String?]?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping ([String: String?]?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: [String: String?]?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
