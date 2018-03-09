// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// MSDeployCoreProtocol is mSDeploy ARM PUT core information
public protocol MSDeployCoreProtocol : Codable {
     var packageUri: String? { get set }
     var connectionString: String? { get set }
     var dbType: String? { get set }
     var setParametersXmlFileUri: String? { get set }
     var setParameters: [String:String]? { get set }
     var skipAppData: Bool? { get set }
     var appOffline: Bool? { get set }
}