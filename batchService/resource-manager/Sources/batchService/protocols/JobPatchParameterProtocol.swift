// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// JobPatchParameterProtocol is
public protocol JobPatchParameterProtocol : Codable {
     var priority: Int32? { get set }
     var onAllTasksComplete: OnAllTasksCompleteEnum? { get set }
     var constraints: JobConstraintsProtocol? { get set }
     var poolInfo: PoolInformationProtocol? { get set }
     var metadata: [MetadataItemProtocol?]? { get set }
}
