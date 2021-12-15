function Get-Images-Url 
{
    param ($siteUrl)

    $html = Invoke-WebRequest -Uri $siteUrl
    
    $imagesLink = 
        $html.ParsedHtml.getElementsByTagName('a') |
        Where-Object { $_.className -eq 'fileThumb' } |
        Select-Object -Expand href

    return $imagesLink
}