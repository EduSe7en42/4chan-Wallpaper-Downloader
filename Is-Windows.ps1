function Is-Windows {
    $env = [Environment]::OSVersion.VersionString
    Return $env.Contains("Windows")
}