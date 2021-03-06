// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct WindowsConfigurationData : WindowsConfigurationProtocol {
    public var provisionVMAgent: Bool?
    public var enableAutomaticUpdates: Bool?
    public var timeZone: String?
    public var additionalUnattendContent: [AdditionalUnattendContentProtocol?]?
    public var winRM: WinRMConfigurationProtocol?

        enum CodingKeys: String, CodingKey {case provisionVMAgent = "provisionVMAgent"
        case enableAutomaticUpdates = "enableAutomaticUpdates"
        case timeZone = "timeZone"
        case additionalUnattendContent = "additionalUnattendContent"
        case winRM = "winRM"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.provisionVMAgent) {
        self.provisionVMAgent = try container.decode(Bool?.self, forKey: .provisionVMAgent)
    }
    if container.contains(.enableAutomaticUpdates) {
        self.enableAutomaticUpdates = try container.decode(Bool?.self, forKey: .enableAutomaticUpdates)
    }
    if container.contains(.timeZone) {
        self.timeZone = try container.decode(String?.self, forKey: .timeZone)
    }
    if container.contains(.additionalUnattendContent) {
        self.additionalUnattendContent = try container.decode([AdditionalUnattendContentData?]?.self, forKey: .additionalUnattendContent)
    }
    if container.contains(.winRM) {
        self.winRM = try container.decode(WinRMConfigurationData?.self, forKey: .winRM)
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
    if self.provisionVMAgent != nil {try container.encode(self.provisionVMAgent, forKey: .provisionVMAgent)}
    if self.enableAutomaticUpdates != nil {try container.encode(self.enableAutomaticUpdates, forKey: .enableAutomaticUpdates)}
    if self.timeZone != nil {try container.encode(self.timeZone, forKey: .timeZone)}
    if self.additionalUnattendContent != nil {try container.encode(self.additionalUnattendContent as! [AdditionalUnattendContentData?]?, forKey: .additionalUnattendContent)}
    if self.winRM != nil {try container.encode(self.winRM as! WinRMConfigurationData?, forKey: .winRM)}
  }
}

extension DataFactory {
  public static func createWindowsConfigurationProtocol() -> WindowsConfigurationProtocol {
    return WindowsConfigurationData()
  }
}
