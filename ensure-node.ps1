$ErrorActionPreference = 'Stop'

# Chỉ dùng Node.js đã được cài bởi người dùng từ bộ cài chính thức.
# Launcher tuyệt đối không tải hoặc chạy node.exe từ Internet.
$systemNode = Get-Command node.exe -ErrorAction SilentlyContinue
if (-not $systemNode -or -not $systemNode.Source) {
    Write-Host ''
    Write-Host '[LOI] May chua cai Node.js hoac PATH chua duoc cap nhat.' -ForegroundColor Red
    Write-Host 'Dang mo trang tai Node.js chinh thuc. Hay tai ban LTS Windows Installer (.msi).' -ForegroundColor Yellow
    try { Start-Process 'https://nodejs.org/en/download/' } catch { }
    Write-Host 'Cai dat xong: dong tat ca cua so CMD, mo lai project va chay start.bat.' -ForegroundColor Yellow
    exit 1
}

try {
    $versionText = (& $systemNode.Source --version 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or $versionText -notmatch '^v?(\d+)\.') {
        throw 'Khong doc duoc phien ban Node.js.'
    }
    $major = [int]$Matches[1]
    if ($major -lt 18) {
        Write-Host "[LOI] Node.js $versionText qua cu; can Node.js 18 tro len." -ForegroundColor Red
        Write-Host 'Hay cai ban LTS moi tu https://nodejs.org/en/download/.' -ForegroundColor Yellow
        try { Start-Process 'https://nodejs.org/en/download/' } catch { }
        exit 1
    }
    Write-Host "[OK] Node.js da cai: $versionText" -ForegroundColor Green
    Write-Host "[INFO] Duong dan: $($systemNode.Source)"
    exit 0
}
catch {
    Write-Host "[LOI] Khong the kiem tra Node.js: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
