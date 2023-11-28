. ./Is-Windows.ps1

function Get-Images-Url 
{
    Param ($siteUrl)
    $imagesLink = New-Object Collections.Generic.List[String]

    $html = Invoke-WebRequest -Uri $siteUrl

    # If ($verifyEnv) {
    #     $imagesLink = 
    #         $html.ParsedHtml.getElementsByTagName('a') |
    #         Where-Object { $_.className -eq 'fileThumb' } |
    #         Select-Object -Expand href

    #     Return $imagesLink
    # }

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
    $aLink = $htmlParsed.SelectNodes("//a[contains(@class, 'fileThumb')]")
    
    ForEach ($hn In $aLink) {
        $hrefValue = $hn.GetAttributeValue("href", "");
        $imagesLink.Add($hrefValue)
    }    

    return $imagesLink
}