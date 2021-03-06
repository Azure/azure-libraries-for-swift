// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct UpdateRecoveryPlanInputPropertiesData : UpdateRecoveryPlanInputPropertiesProtocol {
    public var groups: [RecoveryPlanGroupProtocol?]?

        enum CodingKeys: String, CodingKey {case groups = "groups"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.groups) {
        self.groups = try container.decode([RecoveryPlanGroupData?]?.self, forKey: .groups)
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
    if self.groups != nil {try container.encode(self.groups as! [RecoveryPlanGroupData?]?, forKey: .groups)}
  }
}

extension DataFactory {
  public static func createUpdateRecoveryPlanInputPropertiesProtocol() -> UpdateRecoveryPlanInputPropertiesProtocol {
    return UpdateRecoveryPlanInputPropertiesData()
  }
}
