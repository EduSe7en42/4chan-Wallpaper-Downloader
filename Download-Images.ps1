function Download-Images 
{
    param([string[]] $urlImages)

    $counter = 0

    if (-not (Test-Path -Path "./images/"))
    {
        New-Item -ItemType Directory -Force -Path "./4chan_images/"
    }

    foreach ($url in $urlImages) 
    {
        $counter++
        
        $newUrl = $url.replace("about://", "http://")
        $filePath = "./4chan_images/image_" + $counter.ToString() + ".jpg"
        Invoke-WebRequest $newUrl -OutFile $filePath
    }
}