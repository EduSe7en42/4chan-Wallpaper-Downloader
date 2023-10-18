<#
.NAME
    4chan Wallpapers Downloader
.SYNOPSIS
    A simples wallpaper downloader from 4chan image board. /wg/ tested.
#>

. ./Get-Images.ps1
. ./Download-Images.ps1
. ./Is-Windows.ps1

$verifyEnv = Is-Windows

function mainFunction 
{
    param($4chanBoard)

    Clear-Host

    $urlValues = Get-Images-Url $4chanBoard
    Download-Images $urlValues

    $done = "Result: All downloads done."

    If ($verifyEnv) {
        $ResultLabel.Text = $done
    } Else {
        Write-Host $done

    }
}

If (-not($verifyEnv)) {
    mainFunction $args[0]
} Else {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $WallpaperDownloader             = New-Object system.Windows.Forms.Form
    $WallpaperDownloader.ClientSize  = New-Object System.Drawing.Point(492,131)
    $WallpaperDownloader.text        = "4chan Wallpaper Downloader"
    $WallpaperDownloader.TopMost     = $false

    $UrlTextBox                      = New-Object system.Windows.Forms.TextBox
    $UrlTextBox.multiline            = $false
    $UrlTextBox.width                = 369
    $UrlTextBox.height               = 20
    $UrlTextBox.location             = New-Object System.Drawing.Point(101,27)
    $UrlTextBox.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $UrlLabel                       = New-Object system.Windows.Forms.Label
    $UrlLabel.text                  = "Board URL:"
    $UrlLabel.AutoSize              = $true
    $UrlLabel.width                 = 25
    $UrlLabel.height                = 10
    $UrlLabel.location              = New-Object System.Drawing.Point(21,32)
    $UrlLabel.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $GetImagesButton                 = New-Object system.Windows.Forms.Button
    $GetImagesButton.text            = "Download"
    $GetImagesButton.width           = 102
    $GetImagesButton.height          = 30
    $GetImagesButton.location        = New-Object System.Drawing.Point(267,70)
    $GetImagesButton.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $ResultLabel                     = New-Object system.Windows.Forms.Label
    $ResultLabel.text                = "Result: Not downloaded yet"
    $ResultLabel.AutoSize            = $true
    $ResultLabel.width               = 25
    $ResultLabel.height              = 10
    $ResultLabel.location            = New-Object System.Drawing.Point(27,74)
    $ResultLabel.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $CloseButton                     = New-Object system.Windows.Forms.Button
    $CloseButton.text                = "Close"
    $CloseButton.width               = 101
    $CloseButton.height              = 30
    $CloseButton.location            = New-Object System.Drawing.Point(379,70)
    $CloseButton.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $WallpaperDownloader.controls.AddRange(@($UrlTextBox,$UrlLabel,$GetImagesButton,$ResultLabel,$CloseButton))

    $CloseButton.Add_Click({ closeForm })
    $GetImagesButton.Add_Click({ mainFunction $UrlTextBox.Text })
}

function closeForm 
{ 
    $WallpaperDownloader.close() 
}

If ($verifyEnv) {
    [void]$WallpaperDownloader.ShowDialog()
}

