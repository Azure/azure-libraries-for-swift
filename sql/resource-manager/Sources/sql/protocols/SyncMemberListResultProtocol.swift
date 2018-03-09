// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SyncMemberListResultProtocol is a list of Azure SQL Database sync members.
public protocol SyncMemberListResultProtocol : Codable {
     var value: [SyncMemberProtocol?]? { get set }
     var _nextLink: String? { get set }
}