const {resolve} = require('path');
const {execSync} = require('child_process');

console.log(execSync('hemtt.exe build --release', {pwd: resolve(__dirname, '..')}).toString());
