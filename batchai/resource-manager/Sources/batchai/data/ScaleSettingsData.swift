// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ScaleSettingsData : ScaleSettingsProtocol {
    public var manual: ManualScaleSettingsProtocol?
    public var autoScale: AutoScaleSettingsProtocol?

        enum CodingKeys: String, CodingKey {case manual = "manual"
        case autoScale = "autoScale"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.manual) {
        self.manual = try container.decode(ManualScaleSettingsData?.self, forKey: .manual)
    }
    if container.contains(.autoScale) {
        self.autoScale = try container.decode(AutoScaleSettingsData?.self, forKey: .autoScale)
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
    if self.manual != nil {try container.encode(self.manual as! ManualScaleSettingsData?, forKey: .manual)}
    if self.autoScale != nil {try container.encode(self.autoScale as! AutoScaleSettingsData?, forKey: .autoScale)}
  }
}

extension DataFactory {
  public static func createScaleSettingsProtocol() -> ScaleSettingsProtocol {
    return ScaleSettingsData()
  }
}