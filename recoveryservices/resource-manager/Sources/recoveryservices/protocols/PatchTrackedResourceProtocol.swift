// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PatchTrackedResourceProtocol is tracked resource with location.
public protocol PatchTrackedResourceProtocol : ResourceProtocol {
     var location: String? { get set }
     var tags: [String:String]? { get set }
}
