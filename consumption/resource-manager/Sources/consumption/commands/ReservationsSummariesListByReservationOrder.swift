import Foundation
import azureSwiftRuntime
public protocol ReservationsSummariesListByReservationOrder  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var reservationOrderId : String { get set }
    var grain : DatagrainEnum { get set }
    var filter : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ReservationSummariesListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ReservationsSummaries {
// ListByReservationOrder lists the reservations summaries for daily or monthly grain.
    internal class ListByReservationOrderCommand : BaseCommand, ReservationsSummariesListByReservationOrder {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var reservationOrderId : String
        public var grain : DatagrainEnum
        public var filter : String?
        public var apiVersion = "2018-01-31"

        public init(reservationOrderId: String, grain: DatagrainEnum) {
            self.reservationOrderId = reservationOrderId
            self.grain = grain
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Capacity/reservationorders/{reservationOrderId}/providers/Microsoft.Consumption/reservationSummaries"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{reservationOrderId}"] = String(describing: self.reservationOrderId)
            self.queryParameters["grain"] = String(describing: self.grain)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
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
                let result = try decoder.decode(ReservationSummariesListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ReservationSummariesListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ReservationSummariesListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
