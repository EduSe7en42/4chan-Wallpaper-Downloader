. ./Is-Windows.ps1

$verifyEnv = Is-Windows

function Download-Images 
{
    Param([string[]] $urlImages)
    

    $counter = 0

    If (-not ($verifyEnv))
    {
        New-Item -ItemType Directory -Force -Path "./4chan_images/"
    }

    ForEach ($url in $urlImages) 
    {
        $counter++

        If ($verifyEnv) {
            $newUrl = $url.replace("about://", "https://")
        } Else {
            $newUrl = $url.replace("//", "https://")
        }

        $filePath = "./4chan_images/image_" + $counter.ToString() + ".jpg"
        Invoke-WebRequest $newUrl -OutFile $filePath
        Write-Host "File saved with success in " + $filePath 
    }
}