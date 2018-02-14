import Foundation
import azureSwiftRuntime
public protocol ReservationsDetailsListByReservationOrderAndReservation  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var reservationOrderId : String { get set }
    var reservationId : String { get set }
    var filter : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ReservationDetailsListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReservationsDetails {
// ListByReservationOrderAndReservation lists the reservations details for provided date range.
internal class ListByReservationOrderAndReservationCommand : BaseCommand, ReservationsDetailsListByReservationOrderAndReservation {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var reservationOrderId : String
    public var reservationId : String
    public var filter : String
    public var apiVersion = "2018-01-31"

    public init(reservationOrderId: String, reservationId: String, filter: String) {
        self.reservationOrderId = reservationOrderId
        self.reservationId = reservationId
        self.filter = filter
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Capacity/reservationorders/{reservationOrderId}/reservations/{reservationId}/providers/Microsoft.Consumption/reservationDetails"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{reservationOrderId}"] = String(describing: self.reservationOrderId)
        self.pathParameters["{reservationId}"] = String(describing: self.reservationId)
        self.queryParameters["$filter"] = String(describing: self.filter)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(ReservationDetailsListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ReservationDetailsListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: ReservationDetailsListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
