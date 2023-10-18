function Download-Images 
{
    param([string[]] $urlImages)
    $env = [Environment]::OSVersion.VersionString

    $counter = 0

    If (-not (Test-Path -Path "./images/"))
    {
        New-Item -ItemType Directory -Force -Path "./4chan_images/"
    }

    ForEach ($url in $urlImages) 
    {
        $counter++

        if ($env -contains "Windows") {
            $newUrl = $url.replace("about://", "https://")
        } else {
            $newUrl = $url.replace("//", "https://")
        }

        $filePath = "./4chan_images/image_" + $counter.ToString() + ".jpg"
        Invoke-WebRequest $newUrl -OutFile $filePath
        Write-Host "File saved with success in " + $filePath 
    }
}