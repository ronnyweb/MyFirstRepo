function Install-GITModules {
    # Install Chocolatey
    if ((Test-Path "C:\ProgramData\chocolatey") -eq $false) {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }


    # Install Git
    if ((Test-Path "C:\Program Files\Git") -eq $false) {
        choco install git -y
        $env:path += 'C:\Program Files\Git\cmd'
    }

    # Install NuGet & posh-git module
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module posh-git -force
 }


function Initialize-GitRepo {
    # Configure Git User & Email
    git config --global user.name "your name here"
    git config --global user.email "your email here"

    # Create Git Repo directory
    New-Item -ItemType directory -path "C:\PShell\Repos"
    Set-Location "C:\PShell\Repos"

    # Initialize Git repo
    git init MyFirstRepo
    Set-Location C:\PShell\Repos\MyFirstRepo

    # Create Git Files
    for ($i = 1; $i -le 3; $i++) {
        Add-Content -Value "This is some text" -path "C:\PShell\Repos\MyFirstRepo\File$i.txt"
    }

    # Add & Commit files
    git add .
    git commit -m "My first commit"
}