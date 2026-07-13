<h1 align="center">🌿 GitBar (for Mac)</h1>

<p align="center">
  A lightweight macOS menu bar app for monitoring your GitHub profile, contributions, and repositories.
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/53c38c2b-814a-4fd6-8ce6-cf20cd150810" width="430" alt="GitBar Demo">
</p>

<p align="center">
  <strong>GitHub Profile • Contributions • Repository Management</strong>
</p>

---

## 🚀 Features

* **Real-time Profile Overview**: Instantly view your GitHub profile and today's commit count from the menu bar.
* **Repository Management**: Access and manage your repositories directly from the menu bar.
* **Lightweight Design**: Uses minimal system resources for efficient performance.
* **Simple & Intuitive UI**: Just sign in with your GitHub account—no complicated setup required.

## 🚀 Getting Started

To build this project and connect it to the GitHub API, you must first create a GitHub App in your GitHub Developer Settings.

### 1. Create a GitHub App

1. Go to [GitHub Developer Settings](https://github.com/settings/apps).

2. Click **GitHub Apps**.

3. Click **New GitHub App**.

4. Fill in the application information.

   * **GitHub App name**: `AlwaysGitBar` (or any name you prefer)
   * **Homepage URL**: `http://github.com/{Username}`
     *(This project does not use the homepage URL. You can temporarily use your GitHub profile URL.)*
   * **Callback URL**: `showGit://login`

5. Click **Create GitHub App** to finish.

### 2. Obtain the Client ID and Client Secret

1. Open the newly created GitHub App's details page.
2. Copy the **Client ID**.
3. Click **Generate a new client secret** to create a **Client Secret**.

> **Important:** The Client Secret is displayed only once immediately after it is generated. Be sure to save it somewhere secure.

### 3. Clone the Project

Open Terminal and run:

```bash
git clone https://github.com/Seojun1/GitBar.git
```

### 4. Open the Project

Open **AlwaysGitBar.xcodeproj** in Xcode.

### 5. Create the Config File

In the Xcode file navigator, locate:

```
Always_GitBar/Config.sample.plist
```

Rename it:

```
Config.sample.plist
        ↓
Config.plist
```

### 6. Configure GitHub API Credentials

Select `Config.plist`, then enter the following values in the **Property List** editor.

| Key                    | Value                        |
| ---------------------- | ---------------------------- |
| `GITHUB_CLIENT_ID`     | Paste your **Client ID**     |
| `GITHUB_CLIENT_SECRET` | Paste your **Client Secret** |

> **Note**
>
> `Config.plist` is included in `.gitignore`, so it is **not tracked by Git**.
> Your **GitHub Client ID** and **Client Secret** will not be uploaded to your remote GitHub repository.

## 💡 Usage

1. Launch the application.
2. Click the GitBar icon in the macOS menu bar.
3. Sign in with your GitHub account.
4. Start managing your GitHub profile and repositories.

---

## 🛠 Tech Stack

![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge\&logo=swift\&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge\&logo=swift\&logoColor=white)
![MVVM](https://img.shields.io/badge/MVVM-333333?style=for-the-badge)
![GitHub API](https://img.shields.io/badge/GitHub_API-181717?style=for-the-badge\&logo=github)

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

## ⚖️ License

This project is licensed under the **MIT License**.

See the `LICENSE` file for more details.

## 📧 Contact

Feel free to open an **Issue** in this repository or contact me at:

**[iseojun24@kookmin.ac.kr](mailto:iseojun24@kookmin.ac.kr)**
