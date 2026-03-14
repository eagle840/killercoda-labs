This lab covers the setup nodejs and general install and management of nodejs.


Options for Windows

| Feature | NVM for Windows | fnm (Fast Node Manager) | Volta | Runtime (rt) |
| --- | --- | --- | --- | --- |
| **Language** | Go | Rust (Very Fast) | Rust | Rust / Go |
| **Auto-switching** | No | Yes (via `.nvmrc`) | Yes (via `package.json`) | Yes (Advanced) |
| **Permissions** | Often requires Admin | Standard user | Standard user | Standard user |
| **Main URL** | [GitHub Repo](https://github.com/coreybutler/nvm-windows) | [fnm.vercel.app](https://fnm.vercel.app) | [volta.sh](https://volta.sh) | [Official Wiki](https://github.com/coreybutler/nvm-windows/wiki/Runtime) |
| **Best For** | Legacy users | Speed & Shell fans | Teams & Project stability | The "Official" Future |

* **nvm-windows** is effectively in "maintenance mode" while the creator shifts focus to **Runtime**.
* **fnm** remains the top choice for individual developers who want raw speed.
* **Volta** is the best "set it and forget it" tool, especially for professional teams who want to ensure everyone is on the same Node version without manual commands.