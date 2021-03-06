// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct TriggeredWebJobPropertiesData : TriggeredWebJobPropertiesProtocol {
    public var latestRun: TriggeredJobRunProtocol?
    public var historyUrl: String?
    public var schedulerLogsUrl: String?
    public var name: String?
    public var runCommand: String?
    public var url: String?
    public var extraInfoUrl: String?
    public var jobType: WebJobTypeEnum?
    public var error: String?
    public var usingSdk: Bool?
    public var settings: [String:[String: String?]]?

        enum CodingKeys: String, CodingKey {case latestRun = "latestRun"
        case historyUrl = "historyUrl"
        case schedulerLogsUrl = "schedulerLogsUrl"
        case name = "name"
        case runCommand = "runCommand"
        case url = "url"
        case extraInfoUrl = "extraInfoUrl"
        case jobType = "jobType"
        case error = "error"
        case usingSdk = "usingSdk"
        case settings = "settings"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.latestRun) {
        self.latestRun = try container.decode(TriggeredJobRunData?.self, forKey: .latestRun)
    }
    if container.contains(.historyUrl) {
        self.historyUrl = try container.decode(String?.self, forKey: .historyUrl)
    }
    if container.contains(.schedulerLogsUrl) {
        self.schedulerLogsUrl = try container.decode(String?.self, forKey: .schedulerLogsUrl)
    }
    if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.runCommand) {
        self.runCommand = try container.decode(String?.self, forKey: .runCommand)
    }
    if container.contains(.url) {
        self.url = try container.decode(String?.self, forKey: .url)
    }
    if container.contains(.extraInfoUrl) {
        self.extraInfoUrl = try container.decode(String?.self, forKey: .extraInfoUrl)
    }
    if container.contains(.jobType) {
        self.jobType = try container.decode(WebJobTypeEnum?.self, forKey: .jobType)
    }
    if container.contains(.error) {
        self.error = try container.decode(String?.self, forKey: .error)
    }
    if container.contains(.usingSdk) {
        self.usingSdk = try container.decode(Bool?.self, forKey: .usingSdk)
    }
    if container.contains(.settings) {
        self.settings = try container.decode([String:[String: String?]]?.self, forKey: .settings)
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
    if self.latestRun != nil {try container.encode(self.latestRun as! TriggeredJobRunData?, forKey: .latestRun)}
    if self.historyUrl != nil {try container.encode(self.historyUrl, forKey: .historyUrl)}
    if self.schedulerLogsUrl != nil {try container.encode(self.schedulerLogsUrl, forKey: .schedulerLogsUrl)}
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.runCommand != nil {try container.encode(self.runCommand, forKey: .runCommand)}
    if self.url != nil {try container.encode(self.url, forKey: .url)}
    if self.extraInfoUrl != nil {try container.encode(self.extraInfoUrl, forKey: .extraInfoUrl)}
    if self.jobType != nil {try container.encode(self.jobType, forKey: .jobType)}
    if self.error != nil {try container.encode(self.error, forKey: .error)}
    if self.usingSdk != nil {try container.encode(self.usingSdk, forKey: .usingSdk)}
    if self.settings != nil {try container.encode(self.settings, forKey: .settings)}
  }
}

extension DataFactory {
  public static func createTriggeredWebJobPropertiesProtocol() -> TriggeredWebJobPropertiesProtocol {
    return TriggeredWebJobPropertiesData()
  }
}
