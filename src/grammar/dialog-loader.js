let dialogParser = require('./dialog-parser');

let load = (path) => {
    let waterfallDialog = [];
    console.log('Loading dialog:', path);

    var lines = require('fs').readFileSync(path, 'utf-8')
        .split('\n')
        .filter(Boolean)

    lines.forEach( (line) => {
        if (line.trim()) dialogParser.parse(line);
    })

    Object.keys(global['dialogVars']).forEach(function(key) {
        waterfallDialog.push(global['dialogVars'][key]);
      });
        
    return waterfallDialog;
};


module.exports = {
    load
};