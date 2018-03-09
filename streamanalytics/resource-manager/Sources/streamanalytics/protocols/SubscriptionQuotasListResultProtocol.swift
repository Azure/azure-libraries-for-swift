// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SubscriptionQuotasListResultProtocol is result of the GetQuotas operation. It contains a list of quotas for the
// subscription in a particular region.
public protocol SubscriptionQuotasListResultProtocol : Codable {
     var value: [SubscriptionQuotaProtocol?]? { get set }
}