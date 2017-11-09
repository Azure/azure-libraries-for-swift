import Foundation
// ListAccountSasResponseTypeProtocol is the List SAS credentials operation response.
public protocol ListAccountSasResponseTypeProtocol : Codable {
     var accountSasToken: String? { get set }
}
