import Foundation
import azureSwiftRuntime
public protocol GeographicHierarchiesGetDefault  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerGeographicHierarchyProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.GeographicHierarchies {
// GetDefault gets the default Geographic Hierarchy used by the Geographic traffic routing method.
internal class GetDefaultCommand : BaseCommand, GeographicHierarchiesGetDefault {
    public var apiVersion = "2017-05-01"

    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Network/trafficManagerGeographicHierarchies/default"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(TrafficManagerGeographicHierarchyData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (TrafficManagerGeographicHierarchyProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: TrafficManagerGeographicHierarchyData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
