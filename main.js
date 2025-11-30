const { app, BrowserWindow } = require("electron");
const { spawn } = require("child_process");
let python;

function createWindow() {
    const win = new BrowserWindow({
        width: 1200,
        height: 800,
	icon: path.join(__dirname, 'backend', 'examples', 'chair.png')  // <-- window icon
    });

    win.loadURL("http://127.0.0.1:7860");
}

app.whenReady().then(() => {
    python = spawn("./backend/start.sh");

    python.stdout.on("data", d => console.log(`py: ${d}`));
    python.stderr.on("data", d => console.error(`pyerr: ${d}`));

    createWindow();
});

app.on("window-all-closed", () => {
    if (python) python.kill("SIGINT");
    app.quit();
});

