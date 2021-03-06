// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ArmDisasterRecoveryPropertiesData : ArmDisasterRecoveryPropertiesProtocol {
    public var provisioningState: ProvisioningStateDREnum?
    public var partnerNamespace: String?
    public var alternateName: String?
    public var role: RoleDisasterRecoveryEnum?

        enum CodingKeys: String, CodingKey {case provisioningState = "provisioningState"
        case partnerNamespace = "partnerNamespace"
        case alternateName = "alternateName"
        case role = "role"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.provisioningState) {
        self.provisioningState = try container.decode(ProvisioningStateDREnum?.self, forKey: .provisioningState)
    }
    if container.contains(.partnerNamespace) {
        self.partnerNamespace = try container.decode(String?.self, forKey: .partnerNamespace)
    }
    if container.contains(.alternateName) {
        self.alternateName = try container.decode(String?.self, forKey: .alternateName)
    }
    if container.contains(.role) {
        self.role = try container.decode(RoleDisasterRecoveryEnum?.self, forKey: .role)
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
    if self.partnerNamespace != nil {try container.encode(self.partnerNamespace, forKey: .partnerNamespace)}
    if self.alternateName != nil {try container.encode(self.alternateName, forKey: .alternateName)}
    if self.role != nil {try container.encode(self.role, forKey: .role)}
  }
}

extension DataFactory {
  public static func createArmDisasterRecoveryPropertiesProtocol() -> ArmDisasterRecoveryPropertiesProtocol {
    return ArmDisasterRecoveryPropertiesData()
  }
}
