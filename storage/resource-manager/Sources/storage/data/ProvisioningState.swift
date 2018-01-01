// ProvisioningState enumerates the values for provisioning state.

public enum ProvisioningState: String, Codable
{
// Creating specifies the creating state for provisioning state.
    case Creating = "Creating"
// ResolvingDNS specifies the resolving dns state for provisioning state.
    case ResolvingDNS = "ResolvingDNS"
// Succeeded specifies the succeeded state for provisioning state.
    case Succeeded = "Succeeded"
}
