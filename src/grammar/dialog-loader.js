let dialogParser = require('./dialog-parser');

let load = (path) => {
    let waterfallDialog = [];
    console.log('Loading dialog:', path);

    let lineReader = require('readline').createInterface({
        input: require('fs').createReadStream(path)
    });

    lineReader.on('line', function (line) {
        console.log('Line from file:', line);

        waterfallDialog.push(dialogParser.parse(line));
    });

    return waterfallDialog;
};


module.exports = {
    load
};