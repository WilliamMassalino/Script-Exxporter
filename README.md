# Step-by-Step Guide to Running the GitHub Repository Export Scripts

## Prerequisites:

Before running the script, ensure that you have the following:

- **Bash shell**: Available by default on Linux and macOS. Windows users can use WSL (Windows Subsystem for Linux) or Git Bash.
- **Required tools**: `find` and `base64` commands must be installed on your system. These are typically available by default on Unix-like operating systems.

## Steps:

1. **Download the Script.**
   
2. **Obtain the script from its source.** This could be via direct download, using git clone, or by copying and pasting the script into a new file on your local machine.

3. **Save the Script** (by default, the extensions available to export are: `.js`, `.ts`, `.py`, `.ipynb`, `.html` and `.sol`). If you want to add a new extension, in the local extensions variable, add `(-o -name "*.extension")`.

4. **Save the script** in a file named `export.sh`. You can choose any name, but ensure it ends with `.sh`.

5. **Make the Script Executable:** Open your terminal, Navigate to the directory where `export.sh` is saved. Run the following command to make the script executable:
   ```bash
   chmod +x export.sh
   ```
6. **Prepare Your GitHub Repository:** Ensure that the script is located at the root of the GitHub repository you wish to export files from. This means you should have the .git directory in the same place as your script or ensure the script is executable from the repository root.
   
7. **Run the Script:** In the terminal, still at the root of your repository, run the script by specifying an output file as its argument. This file will store the base64-encoded contents of the specified file types. For example:
```bash
./export.sh output.txt
```
8. Replace output.txt with whatever file name you prefer for the output. After running the script, check the specified output file (output.txt in the example). It should contain the base64-encoded contents of the files found in the repository that match the specified extensions.


## Troubleshooting:

* If you receive errors related to missing commands (find or base64), you will need to install these tools. On most Linux distributions, you can use your package manager (like apt for Ubuntu, yum for CentOS) to install any missing tools.
* If the script indicates that no files were processed, ensure that there are files within the repository with the extensions specified in the script (e.g., .js, .ts, .py, .ipynb, .html, .sol and others...).
