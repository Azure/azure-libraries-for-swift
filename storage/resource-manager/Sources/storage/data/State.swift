// State enumerates the values for state.

public enum State: String, Codable
{
// StateDeprovisioning specifies the state deprovisioning state for state.
    case StateDeprovisioning = "deprovisioning"
// StateFailed specifies the state failed state for state.
    case StateFailed = "failed"
// StateNetworkSourceDeleted specifies the state network source deleted state for state.
    case StateNetworkSourceDeleted = "networkSourceDeleted"
// StateProvisioning specifies the state provisioning state for state.
    case StateProvisioning = "provisioning"
// StateSucceeded specifies the state succeeded state for state.
    case StateSucceeded = "succeeded"
}
