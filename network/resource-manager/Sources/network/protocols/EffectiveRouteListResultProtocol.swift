// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// EffectiveRouteListResultProtocol is response for list effective route API service call.
public protocol EffectiveRouteListResultProtocol : Codable {
     var value: [EffectiveRouteProtocol?]? { get set }
     var _nextLink: String? { get set }
}
