// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// HybridRunbookWorkerGroupProtocol is definition of hybrid runbook worker group.
public protocol HybridRunbookWorkerGroupProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var hybridRunbookWorkers: [HybridRunbookWorkerProtocol?]? { get set }
     var credential: RunAsCredentialAssociationPropertyProtocol? { get set }
}