const fs = require('fs');
const path = require('path');
const {execSync} = require('child_process');

const version = execSync('.\\hemtt.exe var version').toString().trim();
console.log(version);

const latest = path.resolve(__dirname, '..', 'latestRelease');
try {
	fs.unlinkSync(latest);
} catch {}
console.log(`mklink /J latestRelease "releases\\${version}"`)
console.log(execSync(`mklink /J latestRelease "releases\\${version}"`, {pwd: path.resolve(__dirname, '..')}).toString());

const modFile = path.resolve(__dirname, '..', 'releases', version, '@qrfs', 'mod.cpp');
const mod = fs.readFileSync(modFile).toString();

fs.writeFileSync(modFile, mod.replace(/{{version}}/g, version));
