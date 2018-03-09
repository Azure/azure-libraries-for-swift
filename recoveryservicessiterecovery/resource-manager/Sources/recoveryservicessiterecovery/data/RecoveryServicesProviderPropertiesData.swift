// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RecoveryServicesProviderPropertiesData : RecoveryServicesProviderPropertiesProtocol {
    public var fabricType: String?
    public var friendlyName: String?
    public var providerVersion: String?
    public var serverVersion: String?
    public var providerVersionState: String?
    public var providerVersionExpiryDate: Date?
    public var fabricFriendlyName: String?
    public var lastHeartBeat: Date?
    public var connectionStatus: String?
    public var protectedItemCount: Int32?
    public var allowedScenarios: [String]?
    public var healthErrorDetails: [HealthErrorProtocol?]?
    public var draIdentifier: String?
    public var identityDetails: IdentityInformationProtocol?
    public var providerVersionDetails: VersionDetailsProtocol?

        enum CodingKeys: String, CodingKey {case fabricType = "fabricType"
        case friendlyName = "friendlyName"
        case providerVersion = "providerVersion"
        case serverVersion = "serverVersion"
        case providerVersionState = "providerVersionState"
        case providerVersionExpiryDate = "providerVersionExpiryDate"
        case fabricFriendlyName = "fabricFriendlyName"
        case lastHeartBeat = "lastHeartBeat"
        case connectionStatus = "connectionStatus"
        case protectedItemCount = "protectedItemCount"
        case allowedScenarios = "allowedScenarios"
        case healthErrorDetails = "healthErrorDetails"
        case draIdentifier = "draIdentifier"
        case identityDetails = "identityDetails"
        case providerVersionDetails = "providerVersionDetails"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.fabricType) {
        self.fabricType = try container.decode(String?.self, forKey: .fabricType)
    }
    if container.contains(.friendlyName) {
        self.friendlyName = try container.decode(String?.self, forKey: .friendlyName)
    }
    if container.contains(.providerVersion) {
        self.providerVersion = try container.decode(String?.self, forKey: .providerVersion)
    }
    if container.contains(.serverVersion) {
        self.serverVersion = try container.decode(String?.self, forKey: .serverVersion)
    }
    if container.contains(.providerVersionState) {
        self.providerVersionState = try container.decode(String?.self, forKey: .providerVersionState)
    }
    if container.contains(.providerVersionExpiryDate) {
        self.providerVersionExpiryDate = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .providerVersionExpiryDate)), format: .dateTime)
    }
    if container.contains(.fabricFriendlyName) {
        self.fabricFriendlyName = try container.decode(String?.self, forKey: .fabricFriendlyName)
    }
    if container.contains(.lastHeartBeat) {
        self.lastHeartBeat = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastHeartBeat)), format: .dateTime)
    }
    if container.contains(.connectionStatus) {
        self.connectionStatus = try container.decode(String?.self, forKey: .connectionStatus)
    }
    if container.contains(.protectedItemCount) {
        self.protectedItemCount = try container.decode(Int32?.self, forKey: .protectedItemCount)
    }
    if container.contains(.allowedScenarios) {
        self.allowedScenarios = try container.decode([String]?.self, forKey: .allowedScenarios)
    }
    if container.contains(.healthErrorDetails) {
        self.healthErrorDetails = try container.decode([HealthErrorData?]?.self, forKey: .healthErrorDetails)
    }
    if container.contains(.draIdentifier) {
        self.draIdentifier = try container.decode(String?.self, forKey: .draIdentifier)
    }
    if container.contains(.identityDetails) {
        self.identityDetails = try container.decode(IdentityInformationData?.self, forKey: .identityDetails)
    }
    if container.contains(.providerVersionDetails) {
        self.providerVersionDetails = try container.decode(VersionDetailsData?.self, forKey: .providerVersionDetails)
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
    if self.fabricType != nil {try container.encode(self.fabricType, forKey: .fabricType)}
    if self.friendlyName != nil {try container.encode(self.friendlyName, forKey: .friendlyName)}
    if self.providerVersion != nil {try container.encode(self.providerVersion, forKey: .providerVersion)}
    if self.serverVersion != nil {try container.encode(self.serverVersion, forKey: .serverVersion)}
    if self.providerVersionState != nil {try container.encode(self.providerVersionState, forKey: .providerVersionState)}
    if self.providerVersionExpiryDate != nil {
        try container.encode(DateConverter.toString(date: self.providerVersionExpiryDate!, format: .dateTime), forKey: .providerVersionExpiryDate)
    }
    if self.fabricFriendlyName != nil {try container.encode(self.fabricFriendlyName, forKey: .fabricFriendlyName)}
    if self.lastHeartBeat != nil {
        try container.encode(DateConverter.toString(date: self.lastHeartBeat!, format: .dateTime), forKey: .lastHeartBeat)
    }
    if self.connectionStatus != nil {try container.encode(self.connectionStatus, forKey: .connectionStatus)}
    if self.protectedItemCount != nil {try container.encode(self.protectedItemCount, forKey: .protectedItemCount)}
    if self.allowedScenarios != nil {try container.encode(self.allowedScenarios as! [String]?, forKey: .allowedScenarios)}
    if self.healthErrorDetails != nil {try container.encode(self.healthErrorDetails as! [HealthErrorData?]?, forKey: .healthErrorDetails)}
    if self.draIdentifier != nil {try container.encode(self.draIdentifier, forKey: .draIdentifier)}
    if self.identityDetails != nil {try container.encode(self.identityDetails as! IdentityInformationData?, forKey: .identityDetails)}
    if self.providerVersionDetails != nil {try container.encode(self.providerVersionDetails as! VersionDetailsData?, forKey: .providerVersionDetails)}
  }
}

extension DataFactory {
  public static func createRecoveryServicesProviderPropertiesProtocol() -> RecoveryServicesProviderPropertiesProtocol {
    return RecoveryServicesProviderPropertiesData()
  }
}
