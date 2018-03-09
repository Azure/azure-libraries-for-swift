// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AzureIaaSVMProtectionPolicyData : AzureIaaSVMProtectionPolicyProtocol, ProtectionPolicyProtocol {
    public var protectedItemsCount: Int32?
    public var schedulePolicy: SchedulePolicyProtocol?
    public var retentionPolicy: RetentionPolicyProtocol?
    public var timeZone: String?

        enum CodingKeys: String, CodingKey {case protectedItemsCount = "protectedItemsCount"
        case schedulePolicy = "schedulePolicy"
        case retentionPolicy = "retentionPolicy"
        case timeZone = "timeZone"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.protectedItemsCount) {
        self.protectedItemsCount = try container.decode(Int32?.self, forKey: .protectedItemsCount)
    }
    if container.contains(.schedulePolicy) {
        self.schedulePolicy = try container.decode(SchedulePolicyData?.self, forKey: .schedulePolicy)
    }
    if container.contains(.retentionPolicy) {
        self.retentionPolicy = try container.decode(RetentionPolicyData?.self, forKey: .retentionPolicy)
    }
    if container.contains(.timeZone) {
        self.timeZone = try container.decode(String?.self, forKey: .timeZone)
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
    if self.protectedItemsCount != nil {try container.encode(self.protectedItemsCount, forKey: .protectedItemsCount)}
    if self.schedulePolicy != nil {try container.encode(self.schedulePolicy as! SchedulePolicyData?, forKey: .schedulePolicy)}
    if self.retentionPolicy != nil {try container.encode(self.retentionPolicy as! RetentionPolicyData?, forKey: .retentionPolicy)}
    if self.timeZone != nil {try container.encode(self.timeZone, forKey: .timeZone)}
  }
}

extension DataFactory {
  public static func createAzureIaaSVMProtectionPolicyProtocol() -> AzureIaaSVMProtectionPolicyProtocol {
    return AzureIaaSVMProtectionPolicyData()
  }
}