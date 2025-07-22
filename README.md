已按你的要求，把文档里所有的 **“您”** 统一替换成了 **“你”**。  
下面给出更新后的 Markdown 全文，可直接复制进 GitBook 使用。

---

# Beboundless Provers 一键安装脚本及使用指南

## 简介

本脚本旨在简化 Beboundless Provers 的安装过程，提供一个交互式的一键安装体验，并支持多语言（英语/简体中文）。脚本将引导你完成仓库克隆、依赖安装（Docker、Nvidia Docker）、环境变量设置以及 CLI 工具的安装。

**重要提示：** 本脚本主要针对 Linux 环境设计。对于 Windows 和 macOS 用户，部分步骤可能需要手动完成，文档中会提供相应指引。

## 脚本特性

*   **交互式：** 引导用户逐步完成安装。
*   **多语言支持：** 可选择英语或简体中文进行安装提示。
*   **自动化：** 自动克隆仓库、运行 `npm install`、并可选择运行官方 `setup.sh` 脚本安装 Docker 和 Nvidia Docker。
*   **环境变量设置：** 提示你输入 `PRIVATE_KEY` 和 `RPC_URL` 并为当前会话设置。
*   **CLI 工具安装：** 自动安装 `bento_cli` 和 `boundless-cli`。

## 使用方法

### 1. 下载脚本

将 `install_beboundless.sh` 文件下载到你的机器上。如果你是通过他人获取此脚本，请确保其来源可靠。

### 2. 赋予执行权限

打开终端，导航到脚本所在的目录，并赋予脚本执行权限：

```bash
chmod +x install_beboundless.sh
```

### 3. 运行脚本

在终端中运行脚本：

```bash
./install_beboundless.sh
```

### 4. 按照提示操作

脚本运行后，会提示你选择语言（en/zh），然后逐步引导你完成以下安装步骤：

*   **语言选择：** 输入 `en` 或 `zh` 选择语言。
*   **前置条件检查：** 脚本会检查 `git`、`curl`、`node` 和 `npm` 是否已安装。如果未安装，会提示你手动安装。
*   **克隆仓库：** 脚本会自动克隆 Beboundless Provers 的 GitHub 仓库到当前目录下的 `boundless` 文件夹。如果该文件夹已存在，则会跳过克隆。
*   **安装 Node.js 依赖：** 脚本会在 `boundless` 目录中运行 `npm install` 来安装项目依赖。
*   **安装 Docker 和 Nvidia Docker：** 脚本会询问你是否运行官方提供的 `scripts/setup.sh` 脚本来安装 Docker 和 Nvidia Docker。**此步骤需要 `sudo` 权限。** 如果你选择跳过，则需要手动安装这些依赖。
*   **设置环境变量：** 脚本会提示你输入 `PRIVATE_KEY` 和 `RPC_URL`。这些变量对于 Prover 的运行至关重要。脚本会为当前会话设置这些变量。**为了持久化这些变量，你需要手动将它们添加到你的 `~/.bashrc` 或 `~/.profile` 文件中。**
    *   **PRIVATE_KEY:** 你的以太坊私钥，用于签名交易。
    *   **RPC_URL:** 你连接的以太坊 RPC 节点的 URL。
*   **安装 CLI 工具：** 脚本会自动全局安装 `bento_cli` 和 `boundless-cli`。

### 5. 后续手动步骤

脚本完成自动化安装后，你还需要根据 Beboundless 官方文档完成以下手动步骤：

*   **存入质押金 (Deposit Stake)：** 这是运行 Prover 的必要步骤。请参考官方文档的详细说明：
    [https://docs.beboundless.xyz/provers/quick-start#deposit-stake](https://docs.beboundless.xyz/provers/quick-start#deposit-stake)

*   **启动 Broker (Start the Broker)：** 启动 Prover 服务。
    [https://docs.beboundless.xyz/provers/quick-start#start-the-broker](https://docs.beboundless.xyz/provers/quick-start#start-the-broker)

## 常见问题与故障排除

*   **`git`、`curl`、`node` 或 `npm` 未找到：** 请根据脚本提示手动安装这些工具。例如，在 Ubuntu/Debian 上：
    ```bash
    sudo apt update
    sudo apt install git curl nodejs npm
    ```
*   **`npm install` 失败：** 检查你的 Node.js 和 npm 版本，确保它们是最新的。尝试清理 npm 缓存：`npm cache clean --force`。
*   **`setup.sh` 失败：** 检查脚本输出的错误信息。这通常与 Docker 或 Nvidia Docker 的安装问题有关。你可以尝试手动安装 Docker 和 Nvidia Docker，并确保你的用户在 `docker` 用户组中（`sudo usermod -aG docker $USER`，然后重新登录）。
*   **`PRIVATE_KEY` 和 `RPC_URL` 持久化：** 脚本只为当前会话设置环境变量。要使其在每次打开新终端时都生效，请将以下行添加到你的 `~/.bashrc` 或 `~/.profile` 文件末尾（将 `YOUR_PRIVATE_KEY` 和 `YOUR_RPC_URL` 替换为你的实际值）：
    ```bash
    export PRIVATE_KEY="YOUR_PRIVATE_KEY"
    export RPC_URL="YOUR_RPC_URL"
    ```
    保存文件后，运行 `source ~/.bashrc` 或 `source ~/.profile` 使其生效。

## 人工安装服务

如果你在安装过程中遇到任何困难，或者希望由专业人士为你完成安装，我们提供人工安装服务。

**联系方式：**

*   **Telegram:** `@yykkyy829`

**服务费用：**

*   **500元人民币** 负责安装。

## 免责声明

本脚本仅为辅助安装工具，不保证在所有系统环境下都能完美运行。在使用本脚本前，请确保你了解其操作，并自行承担所有风险。对于因使用本脚本而造成的任何损失，作者概不负责。

建议你在运行任何涉及 `sudo` 权限的脚本之前，仔细审查其内容。
