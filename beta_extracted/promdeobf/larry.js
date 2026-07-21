const { spawn, execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const args = process.argv.slice(2);
const inputFile = args[0];
const outputFile = args[1] || 'out.lua';

if (!inputFile) {
    console.error("Usage: node larry.js <input.lua> [output.lua]");
    process.exit(1);
}

if (!fs.existsSync(inputFile)) {
    console.error(`Error: Input file '${inputFile}' not found.`);
    process.exit(1);
}

const luaScriptPath = path.join(__dirname, 'larry_dumper.lua');

if (!fs.existsSync(luaScriptPath)) {
    console.error(`Error: Core Lua runner script missing. Please ensure 'larry_dumper.lua' is in the same directory.`);
    process.exit(1);
}

console.log(`[Larry] Initializing dump tracking on ${inputFile}...`);

const luaProcess = spawn('lua', [luaScriptPath, inputFile, outputFile]);

luaProcess.stdout.on('data', (data) => {
    process.stdout.write(data.toString());
});

luaProcess.stderr.on('data', (data) => {
    process.stderr.write(`[Lua Error] ${data}`);
});

luaProcess.on('close', (code) => {
    if (code === 0) {
        console.log(`\n[Larry] Process completed successfully! Output saved to: ${outputFile}`);
    } else {
        console.error(`\n[Larry] Execution failed with exit code: ${code}`);
    }
});