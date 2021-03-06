// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SourceControlListResultProtocol is the response model for the list source controls operation.
public protocol SourceControlListResultProtocol : Codable {
     var value: [SourceControlProtocol?]? { get set }
     var _nextLink: String? { get set }
}
