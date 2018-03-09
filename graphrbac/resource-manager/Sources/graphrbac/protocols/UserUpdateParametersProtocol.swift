// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// UserUpdateParametersProtocol is request parameters for updating an existing work or school account user.
public protocol UserUpdateParametersProtocol : UserBaseProtocol {
     var accountEnabled: Bool? { get set }
     var displayName: String? { get set }
     var passwordProfile: PasswordProfileProtocol? { get set }
     var userPrincipalName: String? { get set }
     var mailNickname: String? { get set }
}