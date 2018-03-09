// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DatabaseAccountPropertiesData : DatabaseAccountPropertiesProtocol {
    public var provisioningState: String?
    public var documentEndpoint: String?
    public var databaseAccountOfferType: DatabaseAccountOfferTypeEnum?
    public var ipRangeFilter: String?
    public var enableAutomaticFailover: Bool?
    public var consistencyPolicy: ConsistencyPolicyProtocol?
    public var capabilities: [CapabilityProtocol?]?
    public var writeLocations: [LocationProtocol?]?
    public var readLocations: [LocationProtocol?]?
    public var failoverPolicies: [FailoverPolicyProtocol?]?

        enum CodingKeys: String, CodingKey {case provisioningState = "provisioningState"
        case documentEndpoint = "documentEndpoint"
        case databaseAccountOfferType = "databaseAccountOfferType"
        case ipRangeFilter = "ipRangeFilter"
        case enableAutomaticFailover = "enableAutomaticFailover"
        case consistencyPolicy = "consistencyPolicy"
        case capabilities = "capabilities"
        case writeLocations = "writeLocations"
        case readLocations = "readLocations"
        case failoverPolicies = "failoverPolicies"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.provisioningState) {
        self.provisioningState = try container.decode(String?.self, forKey: .provisioningState)
    }
    if container.contains(.documentEndpoint) {
        self.documentEndpoint = try container.decode(String?.self, forKey: .documentEndpoint)
    }
    if container.contains(.databaseAccountOfferType) {
        self.databaseAccountOfferType = try container.decode(DatabaseAccountOfferTypeEnum?.self, forKey: .databaseAccountOfferType)
    }
    if container.contains(.ipRangeFilter) {
        self.ipRangeFilter = try container.decode(String?.self, forKey: .ipRangeFilter)
    }
    if container.contains(.enableAutomaticFailover) {
        self.enableAutomaticFailover = try container.decode(Bool?.self, forKey: .enableAutomaticFailover)
    }
    if container.contains(.consistencyPolicy) {
        self.consistencyPolicy = try container.decode(ConsistencyPolicyData?.self, forKey: .consistencyPolicy)
    }
    if container.contains(.capabilities) {
        self.capabilities = try container.decode([CapabilityData?]?.self, forKey: .capabilities)
    }
    if container.contains(.writeLocations) {
        self.writeLocations = try container.decode([LocationData?]?.self, forKey: .writeLocations)
    }
    if container.contains(.readLocations) {
        self.readLocations = try container.decode([LocationData?]?.self, forKey: .readLocations)
    }
    if container.contains(.failoverPolicies) {
        self.failoverPolicies = try container.decode([FailoverPolicyData?]?.self, forKey: .failoverPolicies)
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
    if self.provisioningState != nil {try container.encode(self.provisioningState, forKey: .provisioningState)}
    if self.documentEndpoint != nil {try container.encode(self.documentEndpoint, forKey: .documentEndpoint)}
    if self.databaseAccountOfferType != nil {try container.encode(self.databaseAccountOfferType, forKey: .databaseAccountOfferType)}
    if self.ipRangeFilter != nil {try container.encode(self.ipRangeFilter, forKey: .ipRangeFilter)}
    if self.enableAutomaticFailover != nil {try container.encode(self.enableAutomaticFailover, forKey: .enableAutomaticFailover)}
    if self.consistencyPolicy != nil {try container.encode(self.consistencyPolicy as! ConsistencyPolicyData?, forKey: .consistencyPolicy)}
    if self.capabilities != nil {try container.encode(self.capabilities as! [CapabilityData?]?, forKey: .capabilities)}
    if self.writeLocations != nil {try container.encode(self.writeLocations as! [LocationData?]?, forKey: .writeLocations)}
    if self.readLocations != nil {try container.encode(self.readLocations as! [LocationData?]?, forKey: .readLocations)}
    if self.failoverPolicies != nil {try container.encode(self.failoverPolicies as! [FailoverPolicyData?]?, forKey: .failoverPolicies)}
  }
}

extension DataFactory {
  public static func createDatabaseAccountPropertiesProtocol() -> DatabaseAccountPropertiesProtocol {
    return DatabaseAccountPropertiesData()
  }
}