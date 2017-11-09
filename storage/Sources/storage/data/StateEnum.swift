// StateEnum enumerates the values for state enum.

public enum StateEnum: String, Codable
{
// StateEnumDeprovisioning specifies the state enum deprovisioning state for state enum.
    case StateEnumDeprovisioning = "deprovisioning"
// StateEnumFailed specifies the state enum failed state for state enum.
    case StateEnumFailed = "failed"
// StateEnumNetworkSourceDeleted specifies the state enum network source deleted state for state enum.
    case StateEnumNetworkSourceDeleted = "networkSourceDeleted"
// StateEnumProvisioning specifies the state enum provisioning state for state enum.
    case StateEnumProvisioning = "provisioning"
// StateEnumSucceeded specifies the state enum succeeded state for state enum.
    case StateEnumSucceeded = "succeeded"
}
