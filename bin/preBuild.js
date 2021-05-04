const fs = require('fs');
const path = require('path');

const versionFile = path.resolve(__dirname, '..', 'addons', 'main', 'script_version.hpp');
const version = ''+fs.readFileSync(versionFile);
fs.writeFileSync(versionFile, version.replace(/#define BUILD (\d+)/, (_, num) => '#define BUILD ' + (parseInt(num, 10) + 1)));
