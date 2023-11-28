$imagesLink = New-Object Collections.Generic.List[String]
$html = Invoke-WebRequest -Uri "https://boards.4chan.org/wg/catalog"

If (-not (Get-Module -ErrorAction Ignore -ListAvailable PowerHTML)) {
    Write-Verbose "Installing PowerHTML module for the current user..."
    Install-Module PowerHTML -ErrorAction Stop
}

Import-Module -ErrorAction Stop PowerHTML

If (Test-Path -Path "index.html" -PathType leaf) {
    Remove-Item -Path "./index.html"
}

New-Item .\index.html -ItemType "file" | out-null
Set-Content .\index.html -Value $html

$htmlParsed = ConvertFrom-Html -Path $pwd/index.html
$aLink = $htmlParsed.SelectNodes("//script")

# ForEach ($hn In $aLink) {
#     $hrefValue = $hn.InnerText
#     $split = $hrefValue.Split(";")
# }    

$positionSlashA = $aLink[4].InnerText.IndexOf("var catalog = {")
$result1 = $aLink[4].InnerText.Substring($positionSlashA+14)
$positionfirstspace = $result1.IndexOf("};")
$test = $result1.Substring(0, $positionfirstspace) + "}" 

Write-Host $test
