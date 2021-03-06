// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SBTopicListResultProtocol is the response to the List Topics operation.
public protocol SBTopicListResultProtocol : Codable {
     var value: [SBTopicProtocol?]? { get set }
     var _nextLink: String? { get set }
}
