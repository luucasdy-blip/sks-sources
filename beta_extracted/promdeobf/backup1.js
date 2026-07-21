import { 
    Client, 
    GatewayIntentBits, 
    AttachmentBuilder, 
    ActionRowBuilder, 
    ButtonBuilder, 
    ButtonStyle 
} from 'discord.js';
import fs from 'fs-extra';
import { exec, execSync } from 'child_process';
import fetch from 'node-fetch';
import { performance } from 'perf_hooks';
import vm from 'vm'; 

const client = new Client({
    intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.MessageContent]
});

const PREFIX = '.';
const ALLOWED_CHANNEL_ID = '1517760356364189836';
const WATERMARK = `-- Ts file was generated using Sk Beta Version https://discord.gg/vGzAYErbYs\n`;

const config = {
    rawByteFixer: true
};

client.once('ready', () => {
    console.log(`Bot Online: ${client.user.tag}`);
});

function runCommand(command, timeoutMs) {
    return new Promise((resolve, reject) => {
        exec(command, { timeout: timeoutMs }, (error, stdout, stderr) => {
            if (error) reject(error);
            else resolve(stdout);
        });
    });
}

async function downloadFile(url, filepath) {
    const res = await fetch(url);
    if (!res.ok) throw new Error(`Download failed: ${res.status}`);
    const buffer = await res.arrayBuffer();
    await fs.writeFile(filepath, Buffer.from(buffer));
}

async function uploadToPastefy(content) {
    try {
        const response = await fetch("https://pastefy.app/api/v2/paste", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                content: content,
                title: "Deobfuscated by SkBot",
                encrypted: false,
                visibility: "UNLISTED",
                type: "PASTE",
                tags: [],
                ai: true
            })
        });
        const data = await response.json();
        return data.success && data.paste?.raw_url ? data.paste.raw_url : null;
    } catch (e) {
        console.error("Pastefy failed:", e);
        return null;
    }
}

function replaceTableNames(content) {
    let counter = 1;
    const tableRegex = /\b(r|sk_loc)\d+\s*=\s*\{/g;
    return content.replace(tableRegex, (match) => {
        return `local_items${counter++} = {`;
    });
}

function decryptLuaStrings(content) {
    let normalizedContent = content.replace(/\\\\x/g, '\\x').replace(/\\\\(\d{1,3})/g, '\\$1');
    const stringRegex = /"((?:[^"\\]|\\.)*)"|'((?:[^'\\]|\\.)*)'/g;

    return normalizedContent.replace(stringRegex, (match, doubleQuoteContent, singleQuoteContent) => {
        try {
            let innerContent = doubleQuoteContent !== undefined ? doubleQuoteContent : singleQuoteContent;
            let quoteSign = doubleQuoteContent !== undefined ? '"' : "'";

            let bytes = [];
            let i = 0;

            while (i < innerContent.length) {
                if (innerContent[i] === '\\') {
                    if (innerContent[i + 1] === 'x') {
                        let hex = innerContent.substr(i + 2, 2);
                        bytes.push(parseInt(hex, 16));
                        i += 4;
                    } else if (/\d/.test(innerContent[i + 1])) {
                        let matchNum = innerContent.substr(i + 1).match(/^(\d{1,3})/);
                        if (matchNum) {
                            bytes.push(parseInt(matchNum[1], 10));
                            i += 1 + matchNum[1].length;
                        } else {
                            bytes.push(innerContent.charCodeAt(i));
                            i++;
                        }
                    } else {
                        let escapeMap = { 'n': 10, 't': 9, 'r': 13, 'b': 8, 'v': 11, '\\': 92, '"': 34, "'": 39 };
                        let nextChar = innerContent[i + 1];
                        if (escapeMap[nextChar] !== undefined) {
                            bytes.push(escapeMap[nextChar]);
                        } else {
                            bytes.push(nextChar.charCodeAt(0));
                        }
                        i += 2;
                    }
                } else {
                    bytes.push(innerContent.charCodeAt(i));
                    i++;
                }
            }

            let decodedString = Buffer.from(bytes).toString('utf8');
            let safeString = decodedString
                .replace(/\\/g, '\\\\')
                .replace(/\n/g, '\\n')
                .replace(/\r/g, '\\r')
                .replace(/\t/g, '\\t');

            if (quoteSign === '"') {
                return `"${safeString.replace(/"/g, '\\"')}"`;
            } else {
                return `'${safeString.replace(/'/g, "\\'")}'`;
            }
        } catch (err) {
            return match;
        }
    });
}

function cleanAntiTamper(content) {
    let cleaned = content;

    const primaryEnvRegex = /local\s+\w+\s*=\s*getfenv\s*\(\s*\)[\s\S]*?for\s+\w+\s*=\s*1\s*,\s*\w+\s+do[\s\S]*?end\s*;?\s*end\s*;?/g;
    cleaned = cleaned.replace(primaryEnvRegex, '\n');

    const mathDecryptRegex = /local\s+\w+\s*=\s*getfenv\s*\(\s*\)[\s\S]*?\/[\s\S]*?\^\s*\d+[\s\S]*?end\s*;?\s*end\s*;?/g;
    cleaned = cleaned.replace(mathDecryptRegex, '\n');

    const conditionalJunkRegex = /local\s+\w+\s*=\s*\w+\s+and\s+\d+\s*==\s*\d+\s*;?\s*if\s+\w+\s+then[\s\S]*?if\s+#\w+\s*==\s*\d+\s+then\s+and\s+end\s*;?\s*end\s*;?/g;
    cleaned = cleaned.replace(conditionalJunkRegex, '\n');

    const trailingTrapRegex = /return\s*\(\s*function\s*\([\s\S]*?while\s+true\s+do[\s\S]*?end\s*;?\s*return\s*;?\s*end\s*\)\s*\(\s*\)\s*;?/g;
    cleaned = cleaned.replace(trailingTrapRegex, '\n');

    const brokenSyntaxRegex = /if\s+#\w+\s*==\s*\d+\s+then\s+and\s+end\s*;?/g;
    cleaned = cleaned.replace(brokenSyntaxRegex, '\n');

    cleaned = cleaned.replace(/\[\s*\w+\[\s*\w+\[\s*\d+\s*\]\s*\]\s*\]/g, '\n');
    cleaned = cleaned.replace(/;\s*(?!\s*$)/g, ';\n');

    return cleaned;
}

function processRawByteFixer(content) {
    let code = content;
    const arrayAssignmentRegex = /\b(\w+)\[\d+\]\s*=\s*(?:nil|false|true|\d+|"[^"]*"|\{\});?\s*/g;
    code = code.replace(arrayAssignmentRegex, '');
    const virtualPointerRegex = /\b(\w+)\[\d+\]\s*=\s*([a-zA-Z_]\w*);?\s*/g;
    code = code.replace(virtualPointerRegex, (lineMatch, targetTable, assignedValue) => {
        if (lineMatch.includes('function') || lineMatch.includes('split') || lineMatch.split('[').length > 2) {
            return lineMatch;
        }
        return '';
    });
    return code;
}

function structureMessyLayout(content) {
    let code = content;

    code = code.replace(/[ \t]{2,}/g, ' ');

    code = code.replace(/([;])\s*(if|else|elseif|local|return|task\.)/g, '$1\n$2');
    code = code.replace(/\b(then)\s+(if|local|return|\w+\.)/g, '$1\n$2');
    code = code.replace(/\b(else)\s+(if)\b/g, '$1\n$2');

    code = code.replace(/;{2,}/g, ';');
    
    return code;
}

function createConfigEmbed() {
    const labelText = config.rawByteFixer ? 'raw_byte_fixer (BETA): on' : 'raw_byte_fixer (BETA): off';
    const buttonStyle = config.rawByteFixer ? ButtonStyle.Success : ButtonStyle.Danger;

    const row = new ActionRowBuilder().addComponents(
        new ButtonBuilder()
            .setCustomId('toggle_raw_byte_fixer')
            .setLabel(labelText)
            .setStyle(buttonStyle)
    );

    return {
        components: [row]
    };
}

client.on('interactionCreate', async interaction => {
    if (!interaction.isButton()) return;
    if (interaction.channelId !== ALLOWED_CHANNEL_ID) return;

    if (interaction.customId === 'toggle_raw_byte_fixer') {
        config.rawByteFixer = !config.rawByteFixer;
        await interaction.update(createConfigEmbed());
    }
});

client.on('messageCreate', async message => {
    if (message.author.bot) return;
    if (message.channel.id !== ALLOWED_CHANNEL_ID) return;

    const lowerContent = message.content.trim().toLowerCase();

    if (lowerContent === '.cfg') {
        return message.channel.send(createConfigEmbed());
    }

    if (lowerContent === '.help') {
        return message.reply(
            "**SkBot Commands**\n\n" +
            "• Type `.l <raw_link_or_attached_file>` to run scripts using the env logger runtime stack.\n" +
            "• Type `.promdeobf <raw_link_or_attached_file>` to manually process a file through the WeAreDevs pipeline.\n" +
            "• Type `.cfg` to manage engine configuration options."
        );
    }

    if (message.content.startsWith('.l')) {
        let textInput = message.content.slice(2).trim();
        let targetUrl = null;
        const attachment = message.attachments.first();

        if (attachment && (attachment.name.toLowerCase().endsWith('.lua') || attachment.name.toLowerCase().endsWith('.txt') || attachment.name.toLowerCase().endsWith('.luau'))) {
            targetUrl = attachment.url;
        }

        if (!targetUrl) {
            const linkMatch = textInput.match(/https?:\/\/[^\s]+/);
            if (linkMatch) {
                targetUrl = linkMatch[0];
            }
        }

        if (!targetUrl && !textInput) {
            return message.reply("Provide a code script text body, code snippet, or an attached file to evaluate via env logger.");
        }

        const timestamp = Date.now();
        const sksenvloggerIn = `./temp/${timestamp}_sksenvlogger_in.lua`;
        const sksenvloggerOut = `./temp/${timestamp}_sksenvlogger_out.lua`;

        await fs.ensureDir('./temp');
        await message.channel.sendTyping();

        try {
            if (targetUrl) {
                await downloadFile(targetUrl, sksenvloggerIn);
            } else {
                await fs.writeFile(sksenvloggerIn, textInput);
            }

            try {
                await runCommand(`node Larry.js "${sksenvloggerIn}" "${sksenvloggerOut}"`, 90000);
            } catch (sksenvloggerErr) {
                if (!fs.existsSync(sksenvloggerOut) || (await fs.readFile(sksenvloggerOut, 'utf8')).trim() === "") {
                    throw new Error("time out.");
                }
            }

            let sksenvloggerOutputData = await fs.readFile(sksenvloggerOut, "utf8");

            sksenvloggerOutputData = sksenvloggerOutputData

            await fs.writeFile(sksenvloggerOut, sksenvloggerOutputData);

            const pastefyLink = await uploadToPastefy(sksenvloggerOutputData);
            const pasteDisplay = pastefyLink || "Failed to upload output array to Pastefy";

            await message.channel.send({
                content: `<@${message.author.id}> Env Logged Completed Successfully!\nPastefy: ${pasteDisplay}`,
                files: [new AttachmentBuilder(sksenvloggerOut, { name: "sks.lua" })]
            });

        } catch (err) {
            console.error(err);
            await message.reply(`Env Logger Framework Processing Failure: \`${err.message?.slice(0, 500)}\``);
        } finally {
            await fs.remove(sksenvloggerIn).catch(() => {});
            await fs.remove(sksenvloggerOut).catch(() => {});
        }
        return;
    }

    if (message.content.startsWith('.promdeobf')) {
        let textInput = message.content.slice(10).trim();
        let fileUrl = null;
        const attachment = message.attachments.first();

        if (attachment && (attachment.name.toLowerCase().endsWith('.lua') || attachment.name.toLowerCase().endsWith('.txt'))) {
            fileUrl = attachment.url;
        }

        if (!fileUrl) {
            const linkMatch = textInput.match(/https?:\/\/[^\s]+/);
            if (linkMatch) fileUrl = linkMatch[0];
        }

        if (!fileUrl) {
            return message.reply("Provide a code file string or attachment to process through WeAreDevs.");
        }

        const timestamp = Date.now();
        const tempIn = `./temp/${timestamp}_input.lua`;
        const tempOut = `./temp/${timestamp}_deobf.lua`;

        await fs.ensureDir('./temp');
        const startTime = performance.now();

        try {
            await message.channel.sendTyping();
            await downloadFile(fileUrl, tempIn);

            let outputFile = tempOut;

            try {
                await runCommand(`node main.js "${tempIn}" "${tempOut}"`, 90000);
            } catch (mainErr) {
                execSync(`node main.js "${tempIn}" formatted.lua`, { timeout: 60000 });
                outputFile = "formatted.lua";
            }

            let fileContent = await fs.readFile(outputFile, "utf8");

            fileContent = decryptLuaStrings(fileContent);
            fileContent = cleanAntiTamper(fileContent);
            fileContent = replaceTableNames(fileContent);
            
            if (config.rawByteFixer) {
                fileContent = processRawByteFixer(fileContent);
            }
            
            fileContent = structureMessyLayout(fileContent);
            fileContent = fileContent

            fileContent = WATERMARK + fileContent;

            await fs.writeFile(outputFile, fileContent);

            const pasteLink = await uploadToPastefy(fileContent);
            const pastefyDisplayLink = pasteLink || "Failed to upload to Pastefy";
            const fileName = "dumped.lua";

            const endTime = performance.now();
            const durationMs = endTime - startTime;
            const seconds = Math.floor(durationMs / 1000);
            const milliseconds = Math.floor(durationMs % 1000);
            const timeFormatted = `${seconds}s ${milliseconds}ms`;

            await message.channel.send({
                content: `<@${message.author.id}> Here you go!\n` +
                         `**Finished In:** \`${timeFormatted}\`\n\n` +
                         `> PromDeobf Provided By : hello12345a_17119\n` +
                         `Pastefy: ${pastefyDisplayLink}`,
                files: [new AttachmentBuilder(outputFile, { name: fileName })]
            });

        } catch (e) {
            console.error(e);
            await message.reply(`Error <@${message.author.id}>: \`${e.message?.slice(0, 500)}\``);
        } finally {
            await fs.remove(tempIn).catch(() => {});
            await fs.remove(tempOut).catch(() => {});
        }
        return;
    }
});

client.login('sonion');