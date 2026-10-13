PSDocManager is a practical system administration and file management tool built entirely in PowerShell. It automates the generation of local mock files, applies strict Windows file attributes (Hidden and ReadOnly), and provides a clean, modular search function to filter files based on complex attribute combinations.

Whether you are testing permission logic, auditing local configuration files, or learning advanced PowerShell scripting, this project demonstrates core concepts like bitwise operations, hashtables, parameter validation, and switch conditional logic.

🛠️ Key Features

⚙️ Automated Directory Setup: Automatically checks for the target path (F:\PSDocManager) and provisions it if missing.

📄 Multi-Attribute File Generation: Programmatically creates sample files with different clearance levels (Public, Confidential, Locked, Secure Vault).

🔐 OS-Level Attribute Binding: Directly modifies Windows FileAttributes using bitwise operators (-bor).

🔍 Advanced Filtering Function (Find-FilesByAttribute):

ValidateSet Enforcement: Restricts user inputs to safe, predefined filter modes (Hidden, ReadOnly, Both, Normal).

Bitwise -band Checking: Accurately isolates exact attribute flags without false positives.
