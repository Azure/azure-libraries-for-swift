// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// JobPropertiesExecutionInfoProtocol is contains information about the execution of a job in the Azure Batch service.
public protocol JobPropertiesExecutionInfoProtocol : Codable {
     var startTime: Date? { get set }
     var endTime: Date? { get set }
     var exitCode: Int32? { get set }
     var errors: [BatchAIErrorProtocol?]? { get set }
}