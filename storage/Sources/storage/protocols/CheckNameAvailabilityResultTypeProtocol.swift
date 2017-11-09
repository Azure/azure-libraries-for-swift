import Foundation
// CheckNameAvailabilityResultTypeProtocol is the CheckNameAvailability operation response.
public protocol CheckNameAvailabilityResultTypeProtocol : Codable {
     var nameAvailable: Bool? { get set }
     var reason: ReasonEnum? { get set }
     var message: String? { get set }
}
