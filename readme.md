# System Admin Scripts

This repository contains bash scripts designed to streamline common system administration tasks, including a powerful SQL database backup utility that seamlessly integrates with GitHub for robust data protection.

## SQL Database Backup to GitHub (`gitsql.sh`)

This script automates the process of backing up your MySQL database and securely uploading it to your designated GitHub repository. 

**How to Use**

1. **Download:** Copy the `sql_to_git.sh` script to your server.
2. **Provide Credentials:** Update the script with the following information before running:
   * MySQL Username 
   * MySQL Password 
   * Database Name
   * GitHub Username
   * GitHub Personal Access Token (with 'repo' permissions)
   * Temporary Backup Directory 
3. **Execute:** Run the script using `./sql_to_git.sh`.

**Prerequisites:**

* MySQL or MariaDB installed on your server
* Git installed
* A GitHub personal access token (instructions: [https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token))


## Development Server Setup Script (`setup_dev_server.sh`)

This script simplifies the process of preparing a newly created development server. It installs a comprehensive set of essential tools and packages, laying the foundation for various development workflows.

**Key Features**

* **Core Tools:** Installs build tools (e.g., `build-essential`), version control (Git), and utilities like cURL and Wget.
* **Language Environments:** Sets up common development environments like Python (with `pip` and `venv`), Java (JDK), and optionally Node.js.
* **Customization:** Designed with flexibility in mind, allowing for easy addition or removal of packages.
* **Menu-Driven:** Features a user-friendly menu for selecting specific installation categories or an option to install everything.

**Usage**

1. **Download:** Copy the `setup_dev_server.sh` script to your new server.
2. **Execute:** Run the script `./setup_dev_server.sh` and follow the interactive menu.

**Example Customization**

To include PostgreSQL in the database options:

```bash
6)  echo "Database Options (Choose one):"
    echo "  a. MySQL"
    echo "  b. PostgreSQL"
    read -p "Enter your choice (a/b): " database_choice
    if [[ $database_choice == "a" ]]; then
      install_package mysql-server 
    elif [[ $database_choice == "b" ]]; then
      install_package postgresql 
    else
      echo "Invalid database choice"
    fi 
    ;;


## Contributing 

We welcome contributions to expand this repository's utility for fellow system administrators. If you have a script you'd like to share, please follow the template below:

---

**Script Name:** (Name of your new script)

**Description:** (A concise explanation of what the script does)

**Requirements:** (List any specific dependencies for the script)

**Usage Instructions:** (Clear steps on how to use the script)

## Disclaimer

While these scripts are designed to be helpful, always exercise caution when performing system administration tasks. Thoroughly test scripts in a non-production environment before deployment.

## License

[Include the license of your choice here, e.g., MIT License]
