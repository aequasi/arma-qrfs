const fs = require('fs');
const path = require('path');

const versionFile = path.resolve(__dirname, '..', 'addons', 'main', 'script_version.hpp');
const version = ''+fs.readFileSync(versionFile);
const newVersion = version.replace(/#define BUILD (\d+)/, (_, num) => '#define BUILD ' + (parseInt(num, 10) + 1));

fs.writeFileSync(versionFile, newVersion);

console.log('\nUpdated version file: \n\n' + newVersion + "\n\n");
