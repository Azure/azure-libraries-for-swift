// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ImageReferenceProtocol is specifies information about the image to use. You can specify information about platform
// images, marketplace images, or virtual machine images. This element is required when you want to use a platform
// image, marketplace image, or virtual machine image, but is not used in other creation operations.
public protocol ImageReferenceProtocol : SubResourceProtocol {
     var publisher: String? { get set }
     var offer: String? { get set }
     var sku: String? { get set }
     var version: String? { get set }
}
