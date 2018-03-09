// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WeeklyRetentionScheduleProtocol is weekly retention schedule.
public protocol WeeklyRetentionScheduleProtocol : Codable {
     var daysOfTheWeek: [DayOfWeekEnum?]? { get set }
     var retentionTimes: [Date]? { get set }
     var retentionDuration: RetentionDurationProtocol? { get set }
}