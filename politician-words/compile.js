const path = require('path');
const fs = require('fs');
const solc = require('solc');

const politianWordsPath = path.resolve(__dirname, 'contracts', 'PoliticianWords.sol');
const source = fs.readFileSync(politianWordsPath, 'utf8');

module.exports = solc.compile(source, 1).contracts[':PoliticianWords'];