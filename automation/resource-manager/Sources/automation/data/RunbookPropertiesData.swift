// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RunbookPropertiesData : RunbookPropertiesProtocol {
    public var runbookType: RunbookTypeEnumEnum?
    public var publishContentLink: ContentLinkProtocol?
    public var state: RunbookStateEnum?
    public var logVerbose: Bool?
    public var logProgress: Bool?
    public var logActivityTrace: Int32?
    public var jobCount: Int32?
    public var parameters: [String:RunbookParameterProtocol?]?
    public var outputTypes: [String]?
    public var draft: RunbookDraftProtocol?
    public var provisioningState: RunbookProvisioningStateEnum?
    public var lastModifiedBy: String?
    public var creationTime: Date?
    public var lastModifiedTime: Date?
    public var description: String?

        enum CodingKeys: String, CodingKey {case runbookType = "runbookType"
        case publishContentLink = "publishContentLink"
        case state = "state"
        case logVerbose = "logVerbose"
        case logProgress = "logProgress"
        case logActivityTrace = "logActivityTrace"
        case jobCount = "jobCount"
        case parameters = "parameters"
        case outputTypes = "outputTypes"
        case draft = "draft"
        case provisioningState = "provisioningState"
        case lastModifiedBy = "lastModifiedBy"
        case creationTime = "creationTime"
        case lastModifiedTime = "lastModifiedTime"
        case description = "description"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.runbookType) {
        self.runbookType = try container.decode(RunbookTypeEnumEnum?.self, forKey: .runbookType)
    }
    if container.contains(.publishContentLink) {
        self.publishContentLink = try container.decode(ContentLinkData?.self, forKey: .publishContentLink)
    }
    if container.contains(.state) {
        self.state = try container.decode(RunbookStateEnum?.self, forKey: .state)
    }
    if container.contains(.logVerbose) {
        self.logVerbose = try container.decode(Bool?.self, forKey: .logVerbose)
    }
    if container.contains(.logProgress) {
        self.logProgress = try container.decode(Bool?.self, forKey: .logProgress)
    }
    if container.contains(.logActivityTrace) {
        self.logActivityTrace = try container.decode(Int32?.self, forKey: .logActivityTrace)
    }
    if container.contains(.jobCount) {
        self.jobCount = try container.decode(Int32?.self, forKey: .jobCount)
    }
    if container.contains(.parameters) {
        self.parameters = try container.decode([String:RunbookParameterData?]?.self, forKey: .parameters)
    }
    if container.contains(.outputTypes) {
        self.outputTypes = try container.decode([String]?.self, forKey: .outputTypes)
    }
    if container.contains(.draft) {
        self.draft = try container.decode(RunbookDraftData?.self, forKey: .draft)
    }
    if container.contains(.provisioningState) {
        self.provisioningState = try container.decode(RunbookProvisioningStateEnum?.self, forKey: .provisioningState)
    }
    if container.contains(.lastModifiedBy) {
        self.lastModifiedBy = try container.decode(String?.self, forKey: .lastModifiedBy)
    }
    if container.contains(.creationTime) {
        self.creationTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .creationTime)), format: .dateTime)
    }
    if container.contains(.lastModifiedTime) {
        self.lastModifiedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastModifiedTime)), format: .dateTime)
    }
    if container.contains(.description) {
        self.description = try container.decode(String?.self, forKey: .description)
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
    if self.runbookType != nil {try container.encode(self.runbookType, forKey: .runbookType)}
    if self.publishContentLink != nil {try container.encode(self.publishContentLink as! ContentLinkData?, forKey: .publishContentLink)}
    if self.state != nil {try container.encode(self.state, forKey: .state)}
    if self.logVerbose != nil {try container.encode(self.logVerbose, forKey: .logVerbose)}
    if self.logProgress != nil {try container.encode(self.logProgress, forKey: .logProgress)}
    if self.logActivityTrace != nil {try container.encode(self.logActivityTrace, forKey: .logActivityTrace)}
    if self.jobCount != nil {try container.encode(self.jobCount, forKey: .jobCount)}
    if self.parameters != nil {try container.encode(self.parameters, forKey: .parameters)}
    if self.outputTypes != nil {try container.encode(self.outputTypes as! [String]?, forKey: .outputTypes)}
    if self.draft != nil {try container.encode(self.draft as! RunbookDraftData?, forKey: .draft)}
    if self.provisioningState != nil {try container.encode(self.provisioningState, forKey: .provisioningState)}
    if self.lastModifiedBy != nil {try container.encode(self.lastModifiedBy, forKey: .lastModifiedBy)}
    if self.creationTime != nil {
        try container.encode(DateConverter.toString(date: self.creationTime!, format: .dateTime), forKey: .creationTime)
    }
    if self.lastModifiedTime != nil {
        try container.encode(DateConverter.toString(date: self.lastModifiedTime!, format: .dateTime), forKey: .lastModifiedTime)
    }
    if self.description != nil {try container.encode(self.description, forKey: .description)}
  }
}

extension DataFactory {
  public static func createRunbookPropertiesProtocol() -> RunbookPropertiesProtocol {
    return RunbookPropertiesData()
  }
}
