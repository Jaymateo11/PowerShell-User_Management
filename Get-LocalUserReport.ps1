# User Reporting Script  
# Created by: [Jatniel]  
# Date: [April 13, 2025]  
# Purpose: Retrieves local user information and exports it to a CSV file  

param(  
    [string]$OutputPath = ".\user_report.csv"  
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
Write-Log "Starting user report generation"  

try {  
    # Get all local users  
    Write-Log "Retrieving local user information"  
    $users = Get-LocalUser  
    
    # Extract relevant information  
    $userReport = $users | Select-Object Name, FullName, Enabled, LastLogon, Description  
    
    # Export to CSV  
    Write-Log "Exporting user information to $OutputPath"  
    $userReport | Export-Csv -Path $OutputPath -NoTypeInformation  
    
    Write-Log "User report generated successfully with $($userReport.Count) users"   
    
    # Display success message  
    Write-Host "User report was successfully generated at $OutputPath" -ForegroundColor Green  
}  
catch {  
    Write-Log "Error generating user report: $($_.Exception.Message)" -Level "ERROR"  
    Write-Host "Failed to generate user report. See log for details." -ForegroundColor Red  
}