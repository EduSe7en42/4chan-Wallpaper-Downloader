Function Download-Images 
{
    Param([string[]] $urlImages)

    $folderName = "./4chan_images/"

    If (-Not(Test-Path $folderName)) {
        New-Item $folderName -ItemType Directory
    }

    $urlImages | ForEach-Object -ThrottleLimit 50 -Parallel  {
        $counter = Get-Random

        $newUrl = $_.replace("//", "https://")
        
        $fullFilePath = $using:folderName + "image_" + $counter.ToString() + ".jpg"
        Invoke-WebRequest $newUrl -OutFile $fullFilePath
        Write-Host "File saved with success in " + $fullFilePath
    }
}