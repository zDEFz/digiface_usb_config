$folder = "C:\Users\blu\Documents\digiface-usb-config"
$filter = "*.*"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.Filter = $filter
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Watch for these events
$watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite, LastAccess, Size'

# Define your action here
$action = {
    cd /d "C:\Users\blu\Documents\digiface-usb-config"
    git commit -am "auto commit"
    git push
}

# Register for events
Register-ObjectEvent $watcher Created -Action $action | Out-Null
Register-ObjectEvent $watcher Changed -Action $action | Out-Null
Register-ObjectEvent $watcher Deleted -Action $action | Out-Null
Register-ObjectEvent $watcher Renamed -Action $action | Out-Null

# Keep it running
while ($true) {
    Start-Sleep -Seconds 5
}
