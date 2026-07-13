# <center> 🌿 GitBar (for Mac) </center>
<img width="318" height="334" alt="Image" src="https://github.com/user-attachments/assets/53c38c2b-814a-4fd6-8ce6-cf20cd150810" />
GitBar is a lightweight macOS menu bar application that lets you quickly check your GitHub profile and contribution status directly from your menu bar.

No need to open your browser every time—you can keep track of your GitHub profile with ease.

## 🚀 Features

- **Real-time Profile Overview**: Instantly view your GitHub profile and today's commit count from the menu bar.
- **Repository Management**: Access and manage your repositories directly from the menu bar.
- **Lightweight Design**: Uses minimal system resources for efficient performance.
- **Simple & Intuitive UI**: Just sign in with your GitHub account—no complicated setup required.

---

## 🚀 GitHub App Setup Guide

To build this project and connect it to the GitHub API, you must first create a GitHub App in your GitHub Developer Settings.

### Create a GitHub App

1. Go to [GitHub Developer Settings](https://github.com/settings/apps).
2. Click **GitHub Apps**.
3. Click **New GitHub App**.
4. Fill in the application information.

   - **GitHub App name**: `AlwaysGitBar` (or any name you prefer)
   - **Homepage URL**: `http://github.com/{Username}`  
     *(This project does not use the homepage URL. You can temporarily use your GitHub profile URL.)*
   - **Callback URL**: `showGit://login`

5. Click **Create GitHub App** to finish.

### Obtain the Client ID and Client Secret

1. Open the newly created GitHub App's details page.
2. Copy the **Client ID**.
3. Click **Generate a new client secret** to create a **Client Secret**.

> **Important:** The Client Secret is displayed only once immediately after it is generated. Be sure to save it somewhere secure.

---

## 📦 Project Setup & API Configuration

### 1. Clone the Project

Open Terminal and run the following command:

```bash
git clone https://github.com/Seojun1/GitBar.git
```

---

### 2. Open the Project

Open **AlwaysGitBar.xcodeproj** in Xcode.

---

### 3. Create the Config File

In the Xcode file navigator, locate:

```
Always_GitBar/Config.sample.plist
```

Right-click the file and rename it as follows:

```
Config.sample.plist
        ↓
Config.plist
```

---

### 4. Configure Your GitHub API Credentials

Select `Config.plist`, then enter the following values in the **Property List** editor.

| Key | Value |
|------|-------|
| `GITHUB_CLIENT_ID` | Paste your **Client ID** |
| `GITHUB_CLIENT_SECRET` | Paste your **Client Secret** |

---

> **Note**
>
> `Config.plist` is included in `.gitignore`, so it is **not tracked by Git**.
> Your **GitHub Client ID** and **Client Secret** will not be uploaded to your remote GitHub repository.

---
## 💡 Usage

1. Launch the application.
2. Click the GitBar icon in the macOS menu bar.
3. Sign in with your GitHub account.
4. Start managing your GitHub profile and repositories.

---

## 🛠 Tech Stack

This project is built with the following technologies:

- **Language**: Swift
- **Framework**: SwiftUI
- **Architecture**: MVVM
- **API**: GitHub REST API

---

## 🤝 Contributing

Contributions are always welcome!

1. Before submitting a Pull Request, please open an Issue describing your proposed changes.
2. **Fork** this repository.
3. Create a new branch.

   ```bash
   git checkout -b feature/your-feature
   ```

4. Commit your changes.

   ```bash
   git commit -m "Add some AmazingFeature"
   ```

5. Push your branch.

   ```bash
   git push origin feature/AmazingFeature
   ```

6. Open a **Pull Request**.

---

## ⚖️ License

This project is licensed under the **MIT License**.

See the `LICENSE` file for more details.

---

## 📧 Contact

If you have any questions or suggestions, feel free to:

- Open an **Issue** in this repository.
- Contact me at **iseojun24@kookmin.ac.kr**.
