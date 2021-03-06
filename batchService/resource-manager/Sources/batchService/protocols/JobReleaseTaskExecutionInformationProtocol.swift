// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// JobReleaseTaskExecutionInformationProtocol is
public protocol JobReleaseTaskExecutionInformationProtocol : Codable {
     var startTime: Date { get set }
     var endTime: Date? { get set }
     var state: JobReleaseTaskStateEnum { get set }
     var taskRootDirectory: String? { get set }
     var taskRootDirectoryUrl: String? { get set }
     var exitCode: Int32? { get set }
     var containerInfo: TaskContainerExecutionInformationProtocol? { get set }
     var failureInfo: TaskFailureInformationProtocol? { get set }
     var result: TaskExecutionResultEnum? { get set }
}
