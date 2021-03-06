// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct CreateDataLakeStoreAccountPropertiesData : CreateDataLakeStoreAccountPropertiesProtocol {
    public var defaultGroup: String?
    public var encryptionConfig: EncryptionConfigProtocol?
    public var encryptionState: EncryptionStateEnum?
    public var firewallRules: [CreateFirewallRuleWithAccountParametersProtocol?]?
    public var firewallState: FirewallStateEnum?
    public var firewallAllowAzureIps: FirewallAllowAzureIpsStateEnum?
    public var trustedIdProviders: [CreateTrustedIdProviderWithAccountParametersProtocol?]?
    public var trustedIdProviderState: TrustedIdProviderStateEnum?
    public var newTier: TierTypeEnum?

        enum CodingKeys: String, CodingKey {case defaultGroup = "defaultGroup"
        case encryptionConfig = "encryptionConfig"
        case encryptionState = "encryptionState"
        case firewallRules = "firewallRules"
        case firewallState = "firewallState"
        case firewallAllowAzureIps = "firewallAllowAzureIps"
        case trustedIdProviders = "trustedIdProviders"
        case trustedIdProviderState = "trustedIdProviderState"
        case newTier = "newTier"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.defaultGroup) {
        self.defaultGroup = try container.decode(String?.self, forKey: .defaultGroup)
    }
    if container.contains(.encryptionConfig) {
        self.encryptionConfig = try container.decode(EncryptionConfigData?.self, forKey: .encryptionConfig)
    }
    if container.contains(.encryptionState) {
        self.encryptionState = try container.decode(EncryptionStateEnum?.self, forKey: .encryptionState)
    }
    if container.contains(.firewallRules) {
        self.firewallRules = try container.decode([CreateFirewallRuleWithAccountParametersData?]?.self, forKey: .firewallRules)
    }
    if container.contains(.firewallState) {
        self.firewallState = try container.decode(FirewallStateEnum?.self, forKey: .firewallState)
    }
    if container.contains(.firewallAllowAzureIps) {
        self.firewallAllowAzureIps = try container.decode(FirewallAllowAzureIpsStateEnum?.self, forKey: .firewallAllowAzureIps)
    }
    if container.contains(.trustedIdProviders) {
        self.trustedIdProviders = try container.decode([CreateTrustedIdProviderWithAccountParametersData?]?.self, forKey: .trustedIdProviders)
    }
    if container.contains(.trustedIdProviderState) {
        self.trustedIdProviderState = try container.decode(TrustedIdProviderStateEnum?.self, forKey: .trustedIdProviderState)
    }
    if container.contains(.newTier) {
        self.newTier = try container.decode(TierTypeEnum?.self, forKey: .newTier)
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
    if self.defaultGroup != nil {try container.encode(self.defaultGroup, forKey: .defaultGroup)}
    if self.encryptionConfig != nil {try container.encode(self.encryptionConfig as! EncryptionConfigData?, forKey: .encryptionConfig)}
    if self.encryptionState != nil {try container.encode(self.encryptionState, forKey: .encryptionState)}
    if self.firewallRules != nil {try container.encode(self.firewallRules as! [CreateFirewallRuleWithAccountParametersData?]?, forKey: .firewallRules)}
    if self.firewallState != nil {try container.encode(self.firewallState, forKey: .firewallState)}
    if self.firewallAllowAzureIps != nil {try container.encode(self.firewallAllowAzureIps, forKey: .firewallAllowAzureIps)}
    if self.trustedIdProviders != nil {try container.encode(self.trustedIdProviders as! [CreateTrustedIdProviderWithAccountParametersData?]?, forKey: .trustedIdProviders)}
    if self.trustedIdProviderState != nil {try container.encode(self.trustedIdProviderState, forKey: .trustedIdProviderState)}
    if self.newTier != nil {try container.encode(self.newTier, forKey: .newTier)}
  }
}

extension DataFactory {
  public static func createCreateDataLakeStoreAccountPropertiesProtocol() -> CreateDataLakeStoreAccountPropertiesProtocol {
    return CreateDataLakeStoreAccountPropertiesData()
  }
}
