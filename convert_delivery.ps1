Add-Type -AssemblyName System.Drawing

function Convert-NefToJpg ($InputFile, $OutputFile) {
    try {
        if (-not (Test-Path $InputFile)) {
            Write-Host "Error: $InputFile not found."
            return
        }

        # Attempt to load NEF. This depends on installed codecs.
        $image = [System.Drawing.Image]::FromFile($InputFile)
        
        # Resize logic (Simple optimization)
        $MaxWidth = 1920
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

        $image.RotateFlip([System.Drawing.RotateFlipType]::Rotate270FlipNone)
        $image.Save($OutputFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        $image.Dispose()
        
        Write-Host "Success: Converted $InputFile to $OutputFile"
    }
    catch {
        Write-Host "Error converting NEF: $_"
    }
}

Convert-NefToJpg -InputFile "delivery.NEF" -OutputFile "delivery.jpg"
