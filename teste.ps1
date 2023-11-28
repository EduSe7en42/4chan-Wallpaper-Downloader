. ./Get-Images.ps1

$verifyEnv = Is-Windows

If ($verifyEnv) {
    $supra = "about://"
} Else {
    $supra = "//"
}

$html = Invoke-WebRequest -Uri "https://boards.4chan.org/wg/catalog"

New-Item .\index.html -ItemType "file" | out-null
Set-Content .\index.html -Value $html

$htmlParsed = ConvertFrom-Html -Path $pwd/index.html
$aLink = $htmlParsed.SelectNodes("//script")   

$positionSlashA = $aLink[4].InnerText.IndexOf("var catalog = {")
$result1 = $aLink[4].InnerText.Substring($positionSlashA + 14)
$positionfirstspace = $result1.IndexOf("};")
$text = $result1.Substring(0, $positionfirstspace) + "}"
$json = ConvertFrom-Json $text

$val = $json.threads -replace "[^0-9\s]"
$val2 = $val.Split(" ")

ForEach ($siteItem in $val2) {
    $newSiteUrl = "https://boards.4chan.org/wg/thread/" + $siteItem
    $arrayImageUrl = Get-Images-Url $newSiteUrl

    ForEach ($url in $arrayImageUrl) 
    {
        $counter++

        $newUrl = $url.replace($supra, "https://")
        $dataAtual = Get-Date -Format "yyyy/MM/dd"
        $folderName = "./4chan_images/"+ $dataAtual +"/"+ $siteItem

        If (-Not(Test-Path $folderName)) {
            New-Item $folderName -ItemType Directory
        }

        $filePath = $folderName + "/image_" + $counter.ToString() + ".jpg"
        Invoke-WebRequest $newUrl -OutFile $filePath
        Write-Host "File saved with success in " $filePath 
    }

    $counter = 0
}


