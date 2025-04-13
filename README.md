# PowerShell-User_Management
A PowerShell script to automate Windows local user account creation, management, and reporting.

# PowerShell User Management Scripts  

## Overview  
This repository contains PowerShell scripts for managing local user accounts on Windows systems. These scripts demonstrate automation capabilities for common IT administrative tasks.  

## Scripts  

### Create-LocalUser.ps1  
Creates a new local user account and adds it to specified groups.  

#### Parameters:  
- `Username`: The name for the new user account (required)  
- `Password`: The password for the new account (required)  
- `FullName`: The user's full name (optional)  
- `Groups`: Array of groups to add the user to (defaults to "Users")  

#### Example Usage:  
```powershell  
$password = ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force  
.\Create-LocalUser.ps1 -Username "testuser" -Password $password -FullName "Test User" -Groups @("Users", "Remote Desktop Users")
```

### Get-LocalUserReport.ps1  
Retrieves information about local user accounts and exports the data to a CSV file.  

#### Parameters:  
- `OutputPath`: The path where the CSV report will be saved (defaults to ".\user_report.csv")  

#### Example Usage:  
```powershell  
.\Get-LocalUserReport.ps1  
# Uses default output path (.\user_report.csv)i  

.\Get-LocalUserReport.ps1 -OutputPath "C:\Reports\users_export.csv"  
# Specifies a custom output path
```

## Requirements
- Windows operating system
- PowerShell 5.1 or higher
- Administrative privileges (for creating users and accessing user information)

## Features
- User creation with secure password handling
- Group membership management
- CSV export of user account information
- Comprehensive error handling
- Activity logging to track operations

## Installation  
1. Clone this repository or download the scripts  
2. Ensure PowerShell execution policy allows running these scripts  
3. Run the scripts from a PowerShell console with admin privileges  

## Security Considerations  
- Always use strong passwords  
- Consider using credential objects instead of plain text passwords  
- Audit user creation activities  

## Troubleshooting  
- **Error: Access Denied**: Ensure you're running PowerShell as Administrator  
- **Error: User Already Exists**: Use a different username or remove the existing account  

## License  
This project is licensed under the MIT License - see the LICENSE file for details.  

## Contributing  
Contributions are welcome! Please feel free to submit a Pull Request.
