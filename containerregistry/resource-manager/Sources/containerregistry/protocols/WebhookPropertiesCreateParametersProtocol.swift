// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WebhookPropertiesCreateParametersProtocol is the parameters for creating the properties of a webhook.
public protocol WebhookPropertiesCreateParametersProtocol : Codable {
     var serviceUri: String { get set }
     var customHeaders: [String:String]? { get set }
     var status: WebhookStatusEnum? { get set }
     var scope: String? { get set }
     var actions: [WebhookActionEnum] { get set }
}
