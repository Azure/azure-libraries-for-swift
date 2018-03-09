// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct UserData : UserProtocol, DirectoryObjectProtocol {
    public var additionalProperties: [String:[String: String?]]?
    public var objectId: String?
    public var deletionTimestamp: Date?
    public var immutableId: String?
    public var usageLocation: String?
    public var givenName: String?
    public var surname: String?
    public var userType: UserTypeEnum?
    public var accountEnabled: Bool?
    public var displayName: String?
    public var userPrincipalName: String?
    public var mailNickname: String?
    public var mail: String?
    public var signInNames: [SignInNameProtocol?]?

        enum CodingKeys: String, CodingKey {case additionalProperties = ""
        case objectId = "objectId"
        case deletionTimestamp = "deletionTimestamp"
        case immutableId = "immutableId"
        case usageLocation = "usageLocation"
        case givenName = "givenName"
        case surname = "surname"
        case userType = "userType"
        case accountEnabled = "accountEnabled"
        case displayName = "displayName"
        case userPrincipalName = "userPrincipalName"
        case mailNickname = "mailNickname"
        case mail = "mail"
        case signInNames = "signInNames"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.additionalProperties) {
        self.additionalProperties = try container.decode([String:[String: String?]]?.self, forKey: .additionalProperties)
    }
    if container.contains(.objectId) {
        self.objectId = try container.decode(String?.self, forKey: .objectId)
    }
    if container.contains(.deletionTimestamp) {
        self.deletionTimestamp = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .deletionTimestamp)), format: .dateTime)
    }
    if container.contains(.immutableId) {
        self.immutableId = try container.decode(String?.self, forKey: .immutableId)
    }
    if container.contains(.usageLocation) {
        self.usageLocation = try container.decode(String?.self, forKey: .usageLocation)
    }
    if container.contains(.givenName) {
        self.givenName = try container.decode(String?.self, forKey: .givenName)
    }
    if container.contains(.surname) {
        self.surname = try container.decode(String?.self, forKey: .surname)
    }
    if container.contains(.userType) {
        self.userType = try container.decode(UserTypeEnum?.self, forKey: .userType)
    }
    if container.contains(.accountEnabled) {
        self.accountEnabled = try container.decode(Bool?.self, forKey: .accountEnabled)
    }
    if container.contains(.displayName) {
        self.displayName = try container.decode(String?.self, forKey: .displayName)
    }
    if container.contains(.userPrincipalName) {
        self.userPrincipalName = try container.decode(String?.self, forKey: .userPrincipalName)
    }
    if container.contains(.mailNickname) {
        self.mailNickname = try container.decode(String?.self, forKey: .mailNickname)
    }
    if container.contains(.mail) {
        self.mail = try container.decode(String?.self, forKey: .mail)
    }
    if container.contains(.signInNames) {
        self.signInNames = try container.decode([SignInNameData?]?.self, forKey: .signInNames)
    }
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.additionalProperties != nil {try container.encode(self.additionalProperties, forKey: .additionalProperties)}
    if self.objectId != nil {try container.encode(self.objectId, forKey: .objectId)}
    if self.deletionTimestamp != nil {
        try container.encode(DateConverter.toString(date: self.deletionTimestamp!, format: .dateTime), forKey: .deletionTimestamp)
    }
    if self.immutableId != nil {try container.encode(self.immutableId, forKey: .immutableId)}
    if self.usageLocation != nil {try container.encode(self.usageLocation, forKey: .usageLocation)}
    if self.givenName != nil {try container.encode(self.givenName, forKey: .givenName)}
    if self.surname != nil {try container.encode(self.surname, forKey: .surname)}
    if self.userType != nil {try container.encode(self.userType, forKey: .userType)}
    if self.accountEnabled != nil {try container.encode(self.accountEnabled, forKey: .accountEnabled)}
    if self.displayName != nil {try container.encode(self.displayName, forKey: .displayName)}
    if self.userPrincipalName != nil {try container.encode(self.userPrincipalName, forKey: .userPrincipalName)}
    if self.mailNickname != nil {try container.encode(self.mailNickname, forKey: .mailNickname)}
    if self.mail != nil {try container.encode(self.mail, forKey: .mail)}
    if self.signInNames != nil {try container.encode(self.signInNames as! [SignInNameData?]?, forKey: .signInNames)}
  }
}

extension DataFactory {
  public static func createUserProtocol() -> UserProtocol {
    return UserData()
  }
}