var keg_provider = require('../keg_provider')

module.exports = function populateModel(){
    var model;
    var kegs = keg_provider.getKegsByBreweryId();
    model.total = kegs ? kegs.total : 0;

    return model;
}