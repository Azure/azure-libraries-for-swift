// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SmsReceiverProtocol is an SMS receiver.
public protocol SmsReceiverProtocol : Codable {
     var name: String { get set }
     var countryCode: String { get set }
     var phoneNumber: String { get set }
     var status: ReceiverStatusEnum? { get set }
}