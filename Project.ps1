PS C:\Users\Hakim> $targetDir = "F:\PSDocManager"
if (!(Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir }

# 1. Create files with multiple attributes
$sampleData = @(
    @{ Name = "public.txt"; Content = "Standard file"; Hidden = $false; ReadOnly = $false },
    @{ Name = "secret.txt"; Content = "Confidential data"; Hidden = $true; ReadOnly = $false },
    @{ Name = "locked.txt"; Content = "Protected data"; Hidden = $false; ReadOnly = $true },
    @{ Name = "secure_vault.txt"; Content = "Top secret locked"; Hidden = $true; ReadOnly = $true }
)

foreach ($item in $sampleData) {
    $filePath = Join-Path $targetDir $item.Name
    Set-Content -Path $filePath -Value $item.Content
    $fileObj = Get-Item -Path $filePath -Force
    
    if ($item.Hidden) { $fileObj.Attributes += [System.IO.FileAttributes]::Hidden }
    if ($item.ReadOnly) { $fileObj.Attributes += [System.IO.FileAttributes]::ReadOnly }
}

# 2. Search and filter function using switch conditions and bitwise attribute checks
function Find-FilesByAttribute {
    param (
        [string]$Directory,
        [Parameter(Mandatory)]
        [ValidateSet("Hidden", "ReadOnly", "Both", "Normal")]
        [string]$FilterMode
    )

    $allFiles = Get-ChildItem -Path $Directory -File -Force

    switch ($FilterMode) {
        "Hidden" {
            $allFiles | Where-Object { $_.Attributes -band [System.IO.FileAttributes]::Hidden -and -not ($_.Attributes -band [System.IO.FileAttributes]::ReadOnly) }
        }
        "ReadOnly" {
            $allFiles | Where-Object { $_.Attributes -band [System.IO.FileAttributes]::ReadOnly -and -not ($_.Attributes -band [System.IO.FileAttributes]::Hidden) }
        }
        "Both" {
            $allFiles | Where-Object { ($_.Attributes -band [System.IO.FileAttributes]::Hidden) -and ($_.Attributes -band [System.IO.FileAttributes]::ReadOnly) }
        }
        "Normal" {
            $allFiles | Where-Object { $_.Attributes -eq "Normal" -or $_.Attributes -eq "Archive" }
        }
    }
}

# Example Executions
Write-Host "=== Hidden Files ===" -ForegroundColor Cyan
Find-FilesByAttribute -Directory $targetDir -FilterMode "Hidden" | Select-Object Name, Attributes

Write-Host "=== Files with Both Attributes ===" -ForegroundColor Cyan
Find-FilesByAttribute -Directory $targetDir -FilterMode "Both" | Select-Object Name, Attributes
=== Hidden Files ===

=== Files with Both Attributes ===
Name                            Attributes
----                            ----------
secret.txt                 Hidden, Archive
secure_vault.txt ReadOnly, Hidden, Archive



PS C:\Users\Hakim> 
