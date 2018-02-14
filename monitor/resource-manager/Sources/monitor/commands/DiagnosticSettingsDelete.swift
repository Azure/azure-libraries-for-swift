import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsDelete  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.DiagnosticSettings {
// Delete deletes existing diagnostic settings for the specified resource.
internal class DeleteCommand : BaseCommand, DiagnosticSettingsDelete {
    public var resourceUri : String
    public var name : String
    public var apiVersion = "2017-05-01-preview"

    public init(resourceUri: String, name: String) {
        self.resourceUri = resourceUri
        self.name = name
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettings/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
