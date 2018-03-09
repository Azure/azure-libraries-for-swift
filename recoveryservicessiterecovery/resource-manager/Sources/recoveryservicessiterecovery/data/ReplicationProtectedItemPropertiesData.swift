// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ReplicationProtectedItemPropertiesData : ReplicationProtectedItemPropertiesProtocol {
    public var friendlyName: String?
    public var protectedItemType: String?
    public var protectableItemId: String?
    public var recoveryServicesProviderId: String?
    public var primaryFabricFriendlyName: String?
    public var primaryFabricProvider: String?
    public var recoveryFabricFriendlyName: String?
    public var recoveryFabricId: String?
    public var primaryProtectionContainerFriendlyName: String?
    public var recoveryProtectionContainerFriendlyName: String?
    public var protectionState: String?
    public var protectionStateDescription: String?
    public var activeLocation: String?
    public var testFailoverState: String?
    public var testFailoverStateDescription: String?
    public var allowedOperations: [String]?
    public var replicationHealth: String?
    public var failoverHealth: String?
    public var healthErrors: [HealthErrorProtocol?]?
    public var policyId: String?
    public var policyFriendlyName: String?
    public var lastSuccessfulFailoverTime: Date?
    public var lastSuccessfulTestFailoverTime: Date?
    public var currentScenario: CurrentScenarioDetailsProtocol?
    public var failoverRecoveryPointId: String?
    public var providerSpecificDetails: ReplicationProviderSpecificSettingsProtocol?
    public var recoveryContainerId: String?

        enum CodingKeys: String, CodingKey {case friendlyName = "friendlyName"
        case protectedItemType = "protectedItemType"
        case protectableItemId = "protectableItemId"
        case recoveryServicesProviderId = "recoveryServicesProviderId"
        case primaryFabricFriendlyName = "primaryFabricFriendlyName"
        case primaryFabricProvider = "primaryFabricProvider"
        case recoveryFabricFriendlyName = "recoveryFabricFriendlyName"
        case recoveryFabricId = "recoveryFabricId"
        case primaryProtectionContainerFriendlyName = "primaryProtectionContainerFriendlyName"
        case recoveryProtectionContainerFriendlyName = "recoveryProtectionContainerFriendlyName"
        case protectionState = "protectionState"
        case protectionStateDescription = "protectionStateDescription"
        case activeLocation = "activeLocation"
        case testFailoverState = "testFailoverState"
        case testFailoverStateDescription = "testFailoverStateDescription"
        case allowedOperations = "allowedOperations"
        case replicationHealth = "replicationHealth"
        case failoverHealth = "failoverHealth"
        case healthErrors = "healthErrors"
        case policyId = "policyId"
        case policyFriendlyName = "policyFriendlyName"
        case lastSuccessfulFailoverTime = "lastSuccessfulFailoverTime"
        case lastSuccessfulTestFailoverTime = "lastSuccessfulTestFailoverTime"
        case currentScenario = "currentScenario"
        case failoverRecoveryPointId = "failoverRecoveryPointId"
        case providerSpecificDetails = "providerSpecificDetails"
        case recoveryContainerId = "recoveryContainerId"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.friendlyName) {
        self.friendlyName = try container.decode(String?.self, forKey: .friendlyName)
    }
    if container.contains(.protectedItemType) {
        self.protectedItemType = try container.decode(String?.self, forKey: .protectedItemType)
    }
    if container.contains(.protectableItemId) {
        self.protectableItemId = try container.decode(String?.self, forKey: .protectableItemId)
    }
    if container.contains(.recoveryServicesProviderId) {
        self.recoveryServicesProviderId = try container.decode(String?.self, forKey: .recoveryServicesProviderId)
    }
    if container.contains(.primaryFabricFriendlyName) {
        self.primaryFabricFriendlyName = try container.decode(String?.self, forKey: .primaryFabricFriendlyName)
    }
    if container.contains(.primaryFabricProvider) {
        self.primaryFabricProvider = try container.decode(String?.self, forKey: .primaryFabricProvider)
    }
    if container.contains(.recoveryFabricFriendlyName) {
        self.recoveryFabricFriendlyName = try container.decode(String?.self, forKey: .recoveryFabricFriendlyName)
    }
    if container.contains(.recoveryFabricId) {
        self.recoveryFabricId = try container.decode(String?.self, forKey: .recoveryFabricId)
    }
    if container.contains(.primaryProtectionContainerFriendlyName) {
        self.primaryProtectionContainerFriendlyName = try container.decode(String?.self, forKey: .primaryProtectionContainerFriendlyName)
    }
    if container.contains(.recoveryProtectionContainerFriendlyName) {
        self.recoveryProtectionContainerFriendlyName = try container.decode(String?.self, forKey: .recoveryProtectionContainerFriendlyName)
    }
    if container.contains(.protectionState) {
        self.protectionState = try container.decode(String?.self, forKey: .protectionState)
    }
    if container.contains(.protectionStateDescription) {
        self.protectionStateDescription = try container.decode(String?.self, forKey: .protectionStateDescription)
    }
    if container.contains(.activeLocation) {
        self.activeLocation = try container.decode(String?.self, forKey: .activeLocation)
    }
    if container.contains(.testFailoverState) {
        self.testFailoverState = try container.decode(String?.self, forKey: .testFailoverState)
    }
    if container.contains(.testFailoverStateDescription) {
        self.testFailoverStateDescription = try container.decode(String?.self, forKey: .testFailoverStateDescription)
    }
    if container.contains(.allowedOperations) {
        self.allowedOperations = try container.decode([String]?.self, forKey: .allowedOperations)
    }
    if container.contains(.replicationHealth) {
        self.replicationHealth = try container.decode(String?.self, forKey: .replicationHealth)
    }
    if container.contains(.failoverHealth) {
        self.failoverHealth = try container.decode(String?.self, forKey: .failoverHealth)
    }
    if container.contains(.healthErrors) {
        self.healthErrors = try container.decode([HealthErrorData?]?.self, forKey: .healthErrors)
    }
    if container.contains(.policyId) {
        self.policyId = try container.decode(String?.self, forKey: .policyId)
    }
    if container.contains(.policyFriendlyName) {
        self.policyFriendlyName = try container.decode(String?.self, forKey: .policyFriendlyName)
    }
    if container.contains(.lastSuccessfulFailoverTime) {
        self.lastSuccessfulFailoverTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastSuccessfulFailoverTime)), format: .dateTime)
    }
    if container.contains(.lastSuccessfulTestFailoverTime) {
        self.lastSuccessfulTestFailoverTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastSuccessfulTestFailoverTime)), format: .dateTime)
    }
    if container.contains(.currentScenario) {
        self.currentScenario = try container.decode(CurrentScenarioDetailsData?.self, forKey: .currentScenario)
    }
    if container.contains(.failoverRecoveryPointId) {
        self.failoverRecoveryPointId = try container.decode(String?.self, forKey: .failoverRecoveryPointId)
    }
    if container.contains(.providerSpecificDetails) {
        self.providerSpecificDetails = try container.decode(ReplicationProviderSpecificSettingsData?.self, forKey: .providerSpecificDetails)
    }
    if container.contains(.recoveryContainerId) {
        self.recoveryContainerId = try container.decode(String?.self, forKey: .recoveryContainerId)
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
    if self.friendlyName != nil {try container.encode(self.friendlyName, forKey: .friendlyName)}
    if self.protectedItemType != nil {try container.encode(self.protectedItemType, forKey: .protectedItemType)}
    if self.protectableItemId != nil {try container.encode(self.protectableItemId, forKey: .protectableItemId)}
    if self.recoveryServicesProviderId != nil {try container.encode(self.recoveryServicesProviderId, forKey: .recoveryServicesProviderId)}
    if self.primaryFabricFriendlyName != nil {try container.encode(self.primaryFabricFriendlyName, forKey: .primaryFabricFriendlyName)}
    if self.primaryFabricProvider != nil {try container.encode(self.primaryFabricProvider, forKey: .primaryFabricProvider)}
    if self.recoveryFabricFriendlyName != nil {try container.encode(self.recoveryFabricFriendlyName, forKey: .recoveryFabricFriendlyName)}
    if self.recoveryFabricId != nil {try container.encode(self.recoveryFabricId, forKey: .recoveryFabricId)}
    if self.primaryProtectionContainerFriendlyName != nil {try container.encode(self.primaryProtectionContainerFriendlyName, forKey: .primaryProtectionContainerFriendlyName)}
    if self.recoveryProtectionContainerFriendlyName != nil {try container.encode(self.recoveryProtectionContainerFriendlyName, forKey: .recoveryProtectionContainerFriendlyName)}
    if self.protectionState != nil {try container.encode(self.protectionState, forKey: .protectionState)}
    if self.protectionStateDescription != nil {try container.encode(self.protectionStateDescription, forKey: .protectionStateDescription)}
    if self.activeLocation != nil {try container.encode(self.activeLocation, forKey: .activeLocation)}
    if self.testFailoverState != nil {try container.encode(self.testFailoverState, forKey: .testFailoverState)}
    if self.testFailoverStateDescription != nil {try container.encode(self.testFailoverStateDescription, forKey: .testFailoverStateDescription)}
    if self.allowedOperations != nil {try container.encode(self.allowedOperations as! [String]?, forKey: .allowedOperations)}
    if self.replicationHealth != nil {try container.encode(self.replicationHealth, forKey: .replicationHealth)}
    if self.failoverHealth != nil {try container.encode(self.failoverHealth, forKey: .failoverHealth)}
    if self.healthErrors != nil {try container.encode(self.healthErrors as! [HealthErrorData?]?, forKey: .healthErrors)}
    if self.policyId != nil {try container.encode(self.policyId, forKey: .policyId)}
    if self.policyFriendlyName != nil {try container.encode(self.policyFriendlyName, forKey: .policyFriendlyName)}
    if self.lastSuccessfulFailoverTime != nil {
        try container.encode(DateConverter.toString(date: self.lastSuccessfulFailoverTime!, format: .dateTime), forKey: .lastSuccessfulFailoverTime)
    }
    if self.lastSuccessfulTestFailoverTime != nil {
        try container.encode(DateConverter.toString(date: self.lastSuccessfulTestFailoverTime!, format: .dateTime), forKey: .lastSuccessfulTestFailoverTime)
    }
    if self.currentScenario != nil {try container.encode(self.currentScenario as! CurrentScenarioDetailsData?, forKey: .currentScenario)}
    if self.failoverRecoveryPointId != nil {try container.encode(self.failoverRecoveryPointId, forKey: .failoverRecoveryPointId)}
    if self.providerSpecificDetails != nil {try container.encode(self.providerSpecificDetails as! ReplicationProviderSpecificSettingsData?, forKey: .providerSpecificDetails)}
    if self.recoveryContainerId != nil {try container.encode(self.recoveryContainerId, forKey: .recoveryContainerId)}
  }
}

extension DataFactory {
  public static func createReplicationProtectedItemPropertiesProtocol() -> ReplicationProtectedItemPropertiesProtocol {
    return ReplicationProtectedItemPropertiesData()
  }
}
