const {resolve} = require('path');
const {execSync} = require('child_process');

const opts = {pwd: resolve(__dirname, '..'), stdio: 'inherit'};

execSync('node .\\bin\\preBuild.js', opts);
execSync('hemtt.exe build --release', opts);
execSync('node .\\bin\\postBuild.js', opts);
