Add-Type -AssemblyName System.Drawing

function Optimize-Image {
    param (
        [string]$InputFile,
        [string]$OutputFile,
        [int]$Quality = 75,
        [int]$MaxWidth = 1920
    )

    if (-not (Test-Path $InputFile)) {
        Write-Host "Error: File $InputFile not found."
        return
    }

    $image = [System.Drawing.Image]::FromFile($InputFile)
    
    # Resize if needed
    if ($image.Width -gt $MaxWidth) {
        $newHeight = [int]($image.Height * ($MaxWidth / $image.Width))
        $resized = new-object System.Drawing.Bitmap $MaxWidth, $newHeight
        $graph = [System.Drawing.Graphics]::FromImage($resized)
        $graph.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
        $graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graph.DrawImage($image, 0, 0, $MaxWidth, $newHeight)
        $image.Dispose()
        $image = $resized
    }

    # Encoder parameters for JPEG quality
    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $Quality)

    # Save
    $image.Save($OutputFile, $codec, $encoderParams)
    $image.Dispose()
    
    $origSize = (Get-Item $InputFile).Length / 1MB
    $newSize = (Get-Item $OutputFile).Length / 1MB
    Write-Host "Converted $InputFile ($("{0:N2}" -f $origSize) MB) to $OutputFile ($("{0:N2}" -f $newSize) MB)"
}

Optimize-Image -InputFile "First Factory.png" -OutputFile "First Factory.jpg"
Optimize-Image -InputFile "slide7.png" -OutputFile "slide7.jpg"
