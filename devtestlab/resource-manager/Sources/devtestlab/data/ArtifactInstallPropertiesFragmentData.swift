// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ArtifactInstallPropertiesFragmentData : ArtifactInstallPropertiesFragmentProtocol {
    public var artifactId: String?
    public var parameters: [ArtifactParameterPropertiesFragmentProtocol?]?
    public var status: String?
    public var deploymentStatusMessage: String?
    public var vmExtensionStatusMessage: String?
    public var installTime: Date?

        enum CodingKeys: String, CodingKey {case artifactId = "artifactId"
        case parameters = "parameters"
        case status = "status"
        case deploymentStatusMessage = "deploymentStatusMessage"
        case vmExtensionStatusMessage = "vmExtensionStatusMessage"
        case installTime = "installTime"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.artifactId) {
        self.artifactId = try container.decode(String?.self, forKey: .artifactId)
    }
    if container.contains(.parameters) {
        self.parameters = try container.decode([ArtifactParameterPropertiesFragmentData?]?.self, forKey: .parameters)
    }
    if container.contains(.status) {
        self.status = try container.decode(String?.self, forKey: .status)
    }
    if container.contains(.deploymentStatusMessage) {
        self.deploymentStatusMessage = try container.decode(String?.self, forKey: .deploymentStatusMessage)
    }
    if container.contains(.vmExtensionStatusMessage) {
        self.vmExtensionStatusMessage = try container.decode(String?.self, forKey: .vmExtensionStatusMessage)
    }
    if container.contains(.installTime) {
        self.installTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .installTime)), format: .dateTime)
    }
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.artifactId != nil {try container.encode(self.artifactId, forKey: .artifactId)}
    if self.parameters != nil {try container.encode(self.parameters as! [ArtifactParameterPropertiesFragmentData?]?, forKey: .parameters)}
    if self.status != nil {try container.encode(self.status, forKey: .status)}
    if self.deploymentStatusMessage != nil {try container.encode(self.deploymentStatusMessage, forKey: .deploymentStatusMessage)}
    if self.vmExtensionStatusMessage != nil {try container.encode(self.vmExtensionStatusMessage, forKey: .vmExtensionStatusMessage)}
    if self.installTime != nil {
        try container.encode(DateConverter.toString(date: self.installTime!, format: .dateTime), forKey: .installTime)
    }
  }
}

extension DataFactory {
  public static func createArtifactInstallPropertiesFragmentProtocol() -> ArtifactInstallPropertiesFragmentProtocol {
    return ArtifactInstallPropertiesFragmentData()
  }
}
