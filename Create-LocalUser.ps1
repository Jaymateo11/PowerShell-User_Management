# User Management Script  
# Created by: [Jatniel]  
# Date: [April 13, 2025]  
# Purpose: Creates a new local user and adds them to specified groups  

# Parameters  
param(  
    [Parameter(Mandatory=$true)]  
    [string]$Username,  
    
    [Parameter(Mandatory=$true)]  
    [SecureString]$Password,  
    
    [string]$FullName = "",  
    
    [string[]]$Groups = @("Users")  
)  

# Function to log actions  
function Write-Log {  
    param(  
        [string]$Message,  
        [string]$Level = "INFO"  
    )  
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"  
    $logMessage = "[$timestamp] [$Level] $Message"  
    Write-Host $logMessage  
    
    # Also append to log file  
    $logMessage | Out-File -FilePath ".\user_management.log" -Append  
}  

# Start script  
Write-Log "Starting user creation process for $Username"  

try {  
    # Check if user already exists  
    $userExists = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue  
    
    if ($userExists) {  
        Write-Log "User $Username already exists" -Level "WARNING"  
        return  
    }  
    
    # Create new user  
    $userParams = @{  
        Name = $Username  
        Password = $Password  
        FullName = $FullName  
        Description = "Created by PowerShell script on $(Get-Date -Format 'yyyy-MM-dd')"  
        AccountNeverExpires = $true  
        PasswordNeverExpires = $false  
    }  
    
    New-LocalUser @userParams  
    Write-Log "Successfully created user $Username"  
    
    # Add user to groups  
    foreach ($group in $Groups) {  
        try {  
            Add-LocalGroupMember -Group $group -Member $Username  
            Write-Log "Added $Username to group $group"  
        }  
        catch {  
            Write-Log "Failed to add $Username to group - $_ " -Level "ERROR"  
        }  
    }  
    
    Write-Log "User creation process completed successfully"  
}  
catch {  
    Write-Log "Error creating user: $_" -Level "ERROR"  
}