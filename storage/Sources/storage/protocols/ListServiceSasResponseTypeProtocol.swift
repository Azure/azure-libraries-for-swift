import Foundation
// ListServiceSasResponseTypeProtocol is the List service SAS credentials operation response.
public protocol ListServiceSasResponseTypeProtocol : Codable {
     var serviceSasToken: String? { get set }
}
