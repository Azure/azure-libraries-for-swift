// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
internal struct StorageServicePropertiesData : StorageServicePropertiesProtocol {
    public var logging: LoggingProtocol?
    public var hourMetrics: MetricsProtocol?
    public var minuteMetrics: MetricsProtocol?
    public var cors: [CorsRuleProtocol?]?
    public var defaultServiceVersion: String?

    enum CodingKeys: String, CodingKey {
        case logging = "Logging"
        case hourMetrics = "HourMetrics"
        case minuteMetrics = "MinuteMetrics"
        case cors = "Cors"
        case defaultServiceVersion = "DefaultServiceVersion"
    }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.logging) {
        logging = try container.decode(LoggingData?.self, forKey: .logging)
    }
    if container.contains(.hourMetrics) {
        hourMetrics = try container.decode(MetricsData?.self, forKey: .hourMetrics)
    }
    if container.contains(.minuteMetrics) {
        minuteMetrics = try container.decode(MetricsData?.self, forKey: .minuteMetrics)
    }
    if container.contains(.cors) {
        cors = try container.decode([CorsRuleData?]?.self, forKey: .cors)
    }
    if container.contains(.defaultServiceVersion) {
        defaultServiceVersion = try container.decode(String.self, forKey: .defaultServiceVersion)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.logging != nil {try container.encode(logging as! LoggingData?, forKey: .logging)}
    if self.hourMetrics != nil {try container.encode(hourMetrics as! MetricsData?, forKey: .hourMetrics)}
    if self.minuteMetrics != nil {try container.encode(minuteMetrics as! MetricsData?, forKey: .minuteMetrics)}
    if self.cors != nil {try container.encode(cors as! [CorsRuleData?]?, forKey: .cors)}
    if self.defaultServiceVersion != nil {try container.encode(defaultServiceVersion, forKey: .defaultServiceVersion)}
  }
}

extension DataFactory {
  public static func createStorageServicePropertiesProtocol() -> StorageServicePropertiesProtocol {
    return StorageServicePropertiesData()
  }
}
