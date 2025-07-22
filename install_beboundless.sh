#!/bin/bash

# Beboundless Provers One-Click Installation Script
# 支持多语言 (English/简体中文)

# --- Configuration ---
REPO_URL="https://github.com/beboundless/boundless.git"
REPO_DIR="boundless"
SCRIPT_NAME="install_beboundless.sh"

# --- Functions ---

# Function to display messages in selected language
display_message() {
    local key="$1"
    case "$LANG_CHOICE" in
        "en")
            case "$key" in
                "welcome") echo "Welcome to the Beboundless Provers One-Click Installation Script!" ;;
                "select_lang") echo "Please select your language (en/zh):" ;;
                "invalid_lang") echo "Invalid language choice. Defaulting to English." ;;
                "cloning_repo") echo "Cloning the Boundless repository..." ;;
                "repo_exists") echo "Repository '$REPO_DIR' already exists. Skipping cloning." ;;
                "clone_failed") echo "Failed to clone repository. Please check your internet connection and try again." ;;
                "change_dir") echo "Changing directory to '$REPO_DIR'..." ;;
                "setup_script_info") echo "The setup script (./scripts/setup.sh) will install Docker and Docker Nvidia Support. This requires sudo privileges." ;;
                "run_setup_prompt") echo "Do you want to run the setup script now? (y/n):" ;;
                "running_setup") echo "Running setup script..." ;;
                "setup_failed") echo "Setup script failed. Please check the output above for errors." ;;
                "setup_skipped") echo "Setup script skipped. You may need to install Docker and Nvidia Docker manually." ;;
                "env_vars_info") echo "Now, you need to set your PRIVATE_KEY and RPC_URL environment variables." ;;
                "private_key_prompt") echo "Enter your PRIVATE_KEY (e.g., 0x...):" ;;
                "rpc_url_prompt") echo "Enter your RPC_URL (e.g., https://rpc.example.com):" ;;
                "env_vars_set") echo "Environment variables set for this session. You might want to add them to your .bashrc or .profile for persistence." ;;
                "installing_bento_cli") echo "Installing bento_cli..." ;;
                "bento_cli_failed") echo "Failed to install bento_cli. Please check the error." ;;
                "installing_boundless_cli") echo "Installing boundless-cli..." ;;
                "boundless_cli_failed") echo "Failed to install boundless-cli. Please check the error." ;;
                "deposit_stake_info") echo "Next, you need to deposit stake. Please refer to the official documentation for detailed instructions:" ;;
                "start_broker_info") echo "Finally, you can start the broker. Please refer to the official documentation for detailed instructions:" ;;
                "installation_complete") echo "Beboundless Provers installation steps completed. Please follow the remaining manual steps." ;;
                "prereq_git") echo "Checking for git..." ;;
                "prereq_git_not_found") echo "git not found. Please install git (e.g., sudo apt install git) and try again." ;;
                "prereq_docker") echo "Checking for docker..." ;;
                "prereq_docker_not_found") echo "docker not found. Please install docker (e.g., sudo apt install docker.io) and try again." ;;
                "prereq_curl") echo "Checking for curl..." ;;
                "prereq_curl_not_found") echo "curl not found. Please install curl (e.g., sudo apt install curl) and try again." ;;
                "prereq_node") echo "Checking for Node.js and npm..." ;;
                "prereq_node_not_found") echo "Node.js or npm not found. Please install Node.js (LTS recommended) and npm." ;;
                "prereq_npm_install") echo "Running npm install in the current directory..." ;;
                "npm_install_failed") echo "npm install failed. Please check your Node.js and npm installation and try again." ;;
            esac
            ;;
        "zh")
            case "$key" in
                "welcome") echo "欢迎使用 Beboundless Provers 一键安装脚本！" ;;
                "select_lang") echo "请选择您的语言 (en/zh):" ;;
                "invalid_lang") echo "无效的语言选择。默认为英语。" ;;
                "cloning_repo") echo "正在克隆 Boundless 仓库..." ;;
                "repo_exists") echo "仓库 '$REPO_DIR' 已存在。跳过克隆。" ;;
                "clone_failed") echo "克隆仓库失败。请检查您的网络连接并重试。" ;;
                "change_dir") echo "正在进入目录 '$REPO_DIR'..." ;;
                "setup_script_info") echo "安装脚本 (./scripts/setup.sh) 将安装 Docker 和 Docker Nvidia 支持。这需要 sudo 权限。" ;;
                "run_setup_prompt") echo "您现在要运行安装脚本吗？(y/n):" ;;
                "running_setup") echo "正在运行安装脚本..." ;;
                "setup_failed") echo "安装脚本运行失败。请检查上面的输出以获取错误信息。" ;;
                "setup_skipped") echo "安装脚本已跳过。您可能需要手动安装 Docker 和 Nvidia Docker。" ;;
                "env_vars_info") echo "现在，您需要设置 PRIVATE_KEY 和 RPC_URL 环境变量。" ;;
                "private_key_prompt") echo "请输入您的 PRIVATE_KEY (例如, 0x...):" ;;
                "rpc_url_prompt") echo "请输入您的 RPC_URL (例如, https://rpc.example.com):" ;;
                "env_vars_set") echo "环境变量已为当前会话设置。您可能需要将它们添加到 .bashrc 或 .profile 中以实现持久化。" ;;
                "installing_bento_cli") echo "正在安装 bento_cli..." ;;
                "bento_cli_failed") echo "安装 bento_cli 失败。请检查错误。" ;;
                "installing_boundless_cli") echo "正在安装 boundless-cli..." ;;
                "boundless_cli_failed") echo "安装 boundless-cli 失败。请检查错误。" ;;
                "deposit_stake_info") echo "接下来，您需要存入质押金。请参考官方文档获取详细说明：" ;;
                "start_broker_info") echo "最后，您可以启动 broker。请参考官方文档获取详细说明：" ;;
                "installation_complete") echo "Beboundless Provers 安装步骤已完成。请按照剩余的手动步骤操作。" ;;
                "prereq_git") echo "正在检查 git..." ;;
                "prereq_git_not_found") echo "未找到 git。请安装 git (例如, sudo apt install git) 并重试。" ;;
                "prereq_docker") echo "正在检查 docker..." ;;
                "prereq_docker_not_found") echo "未找到 docker。请安装 docker (例如, sudo apt install docker.io) 并重试。" ;;
                "prereq_curl") echo "正在检查 curl..." ;;
                "prereq_curl_not_found") echo "未找到 curl。请安装 curl (例如, sudo apt install curl) 并重试。" ;;
                "prereq_node") echo "正在检查 Node.js 和 npm..." ;;
                "prereq_node_not_found") echo "未找到 Node.js 或 npm。请安装 Node.js (推荐 LTS 版本) 和 npm。" ;;
                "prereq_npm_install") echo "正在当前目录运行 npm install..." ;;
                "npm_install_failed") echo "npm install 失败。请检查您的 Node.js 和 npm 安装并重试。" ;;
            esac
            ;;
    esac
}

# Function to check for prerequisites
check_prerequisites() {
    display_message "prereq_git"
    if ! command -v git &> /dev/null; then
        display_message "prereq_git_not_found"
        exit 1
    fi

    display_message "prereq_curl"
    if ! command -v curl &> /dev/null; then
        display_message "prereq_curl_not_found"
        exit 1
    fi

    display_message "prereq_node"
    if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
        display_message "prereq_node_not_found"
        exit 1
    fi

    display_message "prereq_docker"
    if ! command -v docker &> /dev/null; then
        display_message "prereq_docker_not_found"
        echo "Note: Docker will be installed by the setup script if you choose to run it."
    fi
}

# --- Main Script ---

# Language selection
echo "Please select your language (en/zh):"
read -p "(en/zh): " LANG_CHOICE
if [[ "$LANG_CHOICE" != "en" && "$LANG_CHOICE" != "zh" ]]; then
    display_message "invalid_lang"
    LANG_CHOICE="en"
fi

display_message "welcome"
echo ""

# Check prerequisites
check_prerequisites

# 1. Clone the repository
display_message "cloning_repo"
if [ -d "$REPO_DIR" ]; then
    display_message "repo_exists"
else
    git clone "$REPO_URL" || { display_message "clone_failed"; exit 1; }
fi

display_message "change_dir"
cd "$REPO_DIR" || { echo "Failed to change directory to $REPO_DIR"; exit 1; }

# Run npm install in the cloned directory
display_message "prereq_npm_install"
npm install || { display_message "npm_install_failed"; exit 1; }

# 2. Install Docker and Docker Nvidia Support (via setup.sh)
display_message "setup_script_info"
read -p "$(display_message "run_setup_prompt") " run_setup_choice
if [[ "$run_setup_choice" =~ ^[Yy]$ ]]; then
    display_message "running_setup"
    sudo ./scripts/setup.sh || { display_message "setup_failed"; exit 1; }
else
    display_message "setup_skipped"
fi

# 3. Set PRIVATE_KEY and RPC_URL environment variables
display_message "env_vars_info"
read -p "$(display_message "private_key_prompt") " PRIVATE_KEY_INPUT
read -p "$(display_message "rpc_url_prompt") " RPC_URL_INPUT

export PRIVATE_KEY="$PRIVATE_KEY_INPUT"
export RPC_URL="$RPC_URL_INPUT"
display_message "env_vars_set"
echo "PRIVATE_KEY=$PRIVATE_KEY"
echo "RPC_URL=$RPC_URL"
echo ""

# 4. Install bento_cli
display_message "installing_bento_cli"
npm install -g bento_cli || { display_message "bento_cli_failed"; exit 1; }

# 5. Install boundless-cli
display_message "installing_boundless_cli"
npm install -g boundless-cli || { display_message "boundless_cli_failed"; exit 1; }

# 6. Deposit stake (manual step)
display_message "deposit_stake_info"
echo "https://docs.beboundless.xyz/provers/quick-start#deposit-stake"
echo ""

# 7. Start the broker (manual step)
display_message "start_broker_info"
echo "https://docs.beboundless.xyz/provers/quick-start#start-the-broker"
echo ""

display_message "installation_complete"
echo "You can now proceed with the manual steps for depositing stake and starting the broker."
echo "For detailed usage instructions, please refer to the generated documentation (README.md)."
