// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SubtaskInformationData : SubtaskInformationProtocol {
    public var id: Int32?
    public var nodeInfo: ComputeNodeInformationProtocol?
    public var startTime: Date?
    public var endTime: Date?
    public var exitCode: Int32?
    public var containerInfo: TaskContainerExecutionInformationProtocol?
    public var failureInfo: TaskFailureInformationProtocol?
    public var state: SubtaskStateEnum?
    public var stateTransitionTime: Date?
    public var previousState: SubtaskStateEnum?
    public var previousStateTransitionTime: Date?
    public var result: TaskExecutionResultEnum?

        enum CodingKeys: String, CodingKey {case id = "id"
        case nodeInfo = "nodeInfo"
        case startTime = "startTime"
        case endTime = "endTime"
        case exitCode = "exitCode"
        case containerInfo = "containerInfo"
        case failureInfo = "failureInfo"
        case state = "state"
        case stateTransitionTime = "stateTransitionTime"
        case previousState = "previousState"
        case previousStateTransitionTime = "previousStateTransitionTime"
        case result = "result"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.id) {
        self.id = try container.decode(Int32?.self, forKey: .id)
    }
    if container.contains(.nodeInfo) {
        self.nodeInfo = try container.decode(ComputeNodeInformationData?.self, forKey: .nodeInfo)
    }
    if container.contains(.startTime) {
        self.startTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .startTime)), format: .dateTime)
    }
    if container.contains(.endTime) {
        self.endTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .endTime)), format: .dateTime)
    }
    if container.contains(.exitCode) {
        self.exitCode = try container.decode(Int32?.self, forKey: .exitCode)
    }
    if container.contains(.containerInfo) {
        self.containerInfo = try container.decode(TaskContainerExecutionInformationData?.self, forKey: .containerInfo)
    }
    if container.contains(.failureInfo) {
        self.failureInfo = try container.decode(TaskFailureInformationData?.self, forKey: .failureInfo)
    }
    if container.contains(.state) {
        self.state = try container.decode(SubtaskStateEnum?.self, forKey: .state)
    }
    if container.contains(.stateTransitionTime) {
        self.stateTransitionTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .stateTransitionTime)), format: .dateTime)
    }
    if container.contains(.previousState) {
        self.previousState = try container.decode(SubtaskStateEnum?.self, forKey: .previousState)
    }
    if container.contains(.previousStateTransitionTime) {
        self.previousStateTransitionTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .previousStateTransitionTime)), format: .dateTime)
    }
    if container.contains(.result) {
        self.result = try container.decode(TaskExecutionResultEnum?.self, forKey: .result)
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
    if self.id != nil {try container.encode(self.id, forKey: .id)}
    if self.nodeInfo != nil {try container.encode(self.nodeInfo as! ComputeNodeInformationData?, forKey: .nodeInfo)}
    if self.startTime != nil {
        try container.encode(DateConverter.toString(date: self.startTime!, format: .dateTime), forKey: .startTime)
    }
    if self.endTime != nil {
        try container.encode(DateConverter.toString(date: self.endTime!, format: .dateTime), forKey: .endTime)
    }
    if self.exitCode != nil {try container.encode(self.exitCode, forKey: .exitCode)}
    if self.containerInfo != nil {try container.encode(self.containerInfo as! TaskContainerExecutionInformationData?, forKey: .containerInfo)}
    if self.failureInfo != nil {try container.encode(self.failureInfo as! TaskFailureInformationData?, forKey: .failureInfo)}
    if self.state != nil {try container.encode(self.state, forKey: .state)}
    if self.stateTransitionTime != nil {
        try container.encode(DateConverter.toString(date: self.stateTransitionTime!, format: .dateTime), forKey: .stateTransitionTime)
    }
    if self.previousState != nil {try container.encode(self.previousState, forKey: .previousState)}
    if self.previousStateTransitionTime != nil {
        try container.encode(DateConverter.toString(date: self.previousStateTransitionTime!, format: .dateTime), forKey: .previousStateTransitionTime)
    }
    if self.result != nil {try container.encode(self.result, forKey: .result)}
  }
}

extension DataFactory {
  public static func createSubtaskInformationProtocol() -> SubtaskInformationProtocol {
    return SubtaskInformationData()
  }
}
