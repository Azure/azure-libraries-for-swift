// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// NotificationListResponseProtocol is the response of listUpgradeNotifications.
public protocol NotificationListResponseProtocol : Codable {
     var value: [UpgradeNotificationProtocol?]? { get set }
     var _nextLink: String? { get set }
}
