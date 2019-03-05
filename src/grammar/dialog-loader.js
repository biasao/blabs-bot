let dialogParser = require('./dialog-parser');

let load = (path) => {
    let waterfallDialog = [];
    console.log('Loading dialog:', path);

    let lineReader = require('readline').createInterface({
        input: require('fs').createReadStream(path)
    });

    lineReader.on('line', function (line) {
        console.log('Line from file:', line);

        dialogParser.parse(line);

        //TODO fix referencing dialogs while loading
        if(global['welcome']) waterfallDialog.push(welcome);
        if(global['askReservationTime']) waterfallDialog.push(askReservationTime);
    });

    return waterfallDialog;
};


module.exports = {
    load
};