Add-Type -AssemblyName System.Drawing

$InputFile = "First Factory.NEF"
$OutputFile = "First Factory.jpg"

try {
    if (-not (Test-Path $InputFile)) {
        Write-Host "Error: $InputFile not found."
        exit
    }

    # Attempt to load NEF. This depends on installed codecs.
    $image = [System.Drawing.Image]::FromFile($InputFile)
    
    # Resize logic
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

    $image.Save($OutputFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $image.Dispose()
    
    Write-Host "Success: Converted $InputFile to $OutputFile"
}
catch {
    Write-Host "Error converting NEF: $_"
}
