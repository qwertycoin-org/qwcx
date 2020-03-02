choco upgrade -y chocolatey

choco install -y --no-progress cmake
choco install -y --no-progress git
choco install -y visualstudio2019buildtools
choco install -y visualstudio2019-workload-vctools --package-parameters "--includeRecommended"
choco install -y --execution-timeout=0 visualstudio2019-workload-manageddesktop

Import-Module PowerShellGet
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module -Name Pscx -MinimumVersion 3.2.2 -AllowClobber

Import-Module Pscx
Invoke-BatchFile "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars32.bat"
$env:Path = "C:\\Program Files\\CMake\\bin;$env:Path"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::Machine)
