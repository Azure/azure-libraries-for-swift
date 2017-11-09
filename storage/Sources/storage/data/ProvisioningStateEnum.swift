// ProvisioningStateEnum enumerates the values for provisioning state enum.

public enum ProvisioningStateEnum: String, Codable
{
// Creating specifies the creating state for provisioning state enum.
    case Creating = "Creating"
// ResolvingDNS specifies the resolving dns state for provisioning state enum.
    case ResolvingDNS = "ResolvingDNS"
// Succeeded specifies the succeeded state for provisioning state enum.
    case Succeeded = "Succeeded"
}
