const fs = require('fs');
const path = require('path');
const {execSync} = require('child_process');

const version = execSync('.\\hemtt.exe var version').toString().trim();
console.log('\n\nLatest Version: ', version);

const latest = path.resolve(__dirname, '..', 'latestRelease');
try {
	fs.unlinkSync(latest);
} catch {}
execSync(`mklink /J latestRelease "releases\\${version}"`, {pwd: path.resolve(__dirname, '..'), stdio: 'inherit'});

const modFile = path.resolve(__dirname, '..', 'releases', version, '@qrfs', 'mod.cpp');
const mod = fs.readFileSync(modFile).toString();

fs.writeFileSync(modFile, mod.replace(/{{version}}/g, version));
console.log('Updated mod file with new versions.');
