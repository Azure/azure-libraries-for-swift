import Foundation
import azureSwiftRuntime
public protocol IotHubResourceExportDevices  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var apiVersion : String { get set }
    var exportDevicesParameters :  ExportDevicesRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (JobResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.IotHubResource {
// ExportDevices exports all the device identities in the IoT hub identity registry to an Azure Storage blob container.
// For more information, see:
// https://docs.microsoft.com/azure/iot-hub/iot-hub-devguide-identity-registry#import-and-export-device-identities.
internal class ExportDevicesCommand : BaseCommand, IotHubResourceExportDevices {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var resourceName : String
    public var apiVersion = "2017-07-01"
    public var exportDevicesParameters :  ExportDevicesRequestProtocol?

    public init(subscriptionId: String, resourceGroupName: String, resourceName: String, exportDevicesParameters: ExportDevicesRequestProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.resourceName = resourceName
        self.exportDevicesParameters = exportDevicesParameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/exportDevices"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = exportDevicesParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(exportDevicesParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(JobResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (JobResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: JobResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
