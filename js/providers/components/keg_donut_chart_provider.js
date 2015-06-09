var keg_provider = require('../keg_provider');

module.exports = function populateModel(){
    var model;
    model.num_empty = keg_provider.getTotalEmptyKegs();
    model.num_filled = keg_provider.getNumberOfFilledKegs();
    model.total = model.num_empty + model.num_filled;
    model.filledpercent = model.num_filled === 0 ? "0%" : (Math.round((model.num_filled / model.total) * 100)) + "%";
    model.emptypercent = model.num_empty === 0 ? "0%" : (Math.round((model.num_empty / model.total) * 100)) + "%";

    return model;
}