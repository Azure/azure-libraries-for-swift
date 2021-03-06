// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct JobSpecificationData : JobSpecificationProtocol {
    public var priority: Int32?
    public var displayName: String?
    public var usesTaskDependencies: Bool?
    public var onAllTasksComplete: OnAllTasksCompleteEnum?
    public var onTaskFailure: OnTaskFailureEnum?
    public var constraints: JobConstraintsProtocol?
    public var jobManagerTask: JobManagerTaskProtocol?
    public var jobPreparationTask: JobPreparationTaskProtocol?
    public var jobReleaseTask: JobReleaseTaskProtocol?
    public var commonEnvironmentSettings: [EnvironmentSettingProtocol?]?
    public var poolInfo: PoolInformationProtocol
    public var metadata: [MetadataItemProtocol?]?

        enum CodingKeys: String, CodingKey {case priority = "priority"
        case displayName = "displayName"
        case usesTaskDependencies = "usesTaskDependencies"
        case onAllTasksComplete = "onAllTasksComplete"
        case onTaskFailure = "onTaskFailure"
        case constraints = "constraints"
        case jobManagerTask = "jobManagerTask"
        case jobPreparationTask = "jobPreparationTask"
        case jobReleaseTask = "jobReleaseTask"
        case commonEnvironmentSettings = "commonEnvironmentSettings"
        case poolInfo = "poolInfo"
        case metadata = "metadata"
        }

  public init(poolInfo: PoolInformationProtocol)  {
    self.poolInfo = poolInfo
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.priority) {
        self.priority = try container.decode(Int32?.self, forKey: .priority)
    }
    if container.contains(.displayName) {
        self.displayName = try container.decode(String?.self, forKey: .displayName)
    }
    if container.contains(.usesTaskDependencies) {
        self.usesTaskDependencies = try container.decode(Bool?.self, forKey: .usesTaskDependencies)
    }
    if container.contains(.onAllTasksComplete) {
        self.onAllTasksComplete = try container.decode(OnAllTasksCompleteEnum?.self, forKey: .onAllTasksComplete)
    }
    if container.contains(.onTaskFailure) {
        self.onTaskFailure = try container.decode(OnTaskFailureEnum?.self, forKey: .onTaskFailure)
    }
    if container.contains(.constraints) {
        self.constraints = try container.decode(JobConstraintsData?.self, forKey: .constraints)
    }
    if container.contains(.jobManagerTask) {
        self.jobManagerTask = try container.decode(JobManagerTaskData?.self, forKey: .jobManagerTask)
    }
    if container.contains(.jobPreparationTask) {
        self.jobPreparationTask = try container.decode(JobPreparationTaskData?.self, forKey: .jobPreparationTask)
    }
    if container.contains(.jobReleaseTask) {
        self.jobReleaseTask = try container.decode(JobReleaseTaskData?.self, forKey: .jobReleaseTask)
    }
    if container.contains(.commonEnvironmentSettings) {
        self.commonEnvironmentSettings = try container.decode([EnvironmentSettingData?]?.self, forKey: .commonEnvironmentSettings)
    }
    self.poolInfo = try container.decode(PoolInformationData.self, forKey: .poolInfo)
    if container.contains(.metadata) {
        self.metadata = try container.decode([MetadataItemData?]?.self, forKey: .metadata)
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
    if self.priority != nil {try container.encode(self.priority, forKey: .priority)}
    if self.displayName != nil {try container.encode(self.displayName, forKey: .displayName)}
    if self.usesTaskDependencies != nil {try container.encode(self.usesTaskDependencies, forKey: .usesTaskDependencies)}
    if self.onAllTasksComplete != nil {try container.encode(self.onAllTasksComplete, forKey: .onAllTasksComplete)}
    if self.onTaskFailure != nil {try container.encode(self.onTaskFailure, forKey: .onTaskFailure)}
    if self.constraints != nil {try container.encode(self.constraints as! JobConstraintsData?, forKey: .constraints)}
    if self.jobManagerTask != nil {try container.encode(self.jobManagerTask as! JobManagerTaskData?, forKey: .jobManagerTask)}
    if self.jobPreparationTask != nil {try container.encode(self.jobPreparationTask as! JobPreparationTaskData?, forKey: .jobPreparationTask)}
    if self.jobReleaseTask != nil {try container.encode(self.jobReleaseTask as! JobReleaseTaskData?, forKey: .jobReleaseTask)}
    if self.commonEnvironmentSettings != nil {try container.encode(self.commonEnvironmentSettings as! [EnvironmentSettingData?]?, forKey: .commonEnvironmentSettings)}
    try container.encode(self.poolInfo as! PoolInformationData, forKey: .poolInfo)
    if self.metadata != nil {try container.encode(self.metadata as! [MetadataItemData?]?, forKey: .metadata)}
  }
}

extension DataFactory {
  public static func createJobSpecificationProtocol(poolInfo: PoolInformationProtocol) -> JobSpecificationProtocol {
    return JobSpecificationData(poolInfo: poolInfo)
  }
}
