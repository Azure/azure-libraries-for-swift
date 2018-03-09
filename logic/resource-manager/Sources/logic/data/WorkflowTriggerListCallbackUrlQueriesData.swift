// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct WorkflowTriggerListCallbackUrlQueriesData : WorkflowTriggerListCallbackUrlQueriesProtocol {
    public var apiVersion: String?
    public var sp: String?
    public var sv: String?
    public var sig: String?

        enum CodingKeys: String, CodingKey {case apiVersion = "api-version"
        case sp = "sp"
        case sv = "sv"
        case sig = "sig"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.apiVersion) {
        self.apiVersion = try container.decode(String?.self, forKey: .apiVersion)
    }
    if container.contains(.sp) {
        self.sp = try container.decode(String?.self, forKey: .sp)
    }
    if container.contains(.sv) {
        self.sv = try container.decode(String?.self, forKey: .sv)
    }
    if container.contains(.sig) {
        self.sig = try container.decode(String?.self, forKey: .sig)
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
    if self.apiVersion != nil {try container.encode(self.apiVersion, forKey: .apiVersion)}
    if self.sp != nil {try container.encode(self.sp, forKey: .sp)}
    if self.sv != nil {try container.encode(self.sv, forKey: .sv)}
    if self.sig != nil {try container.encode(self.sig, forKey: .sig)}
  }
}

extension DataFactory {
  public static func createWorkflowTriggerListCallbackUrlQueriesProtocol() -> WorkflowTriggerListCallbackUrlQueriesProtocol {
    return WorkflowTriggerListCallbackUrlQueriesData()
  }
}