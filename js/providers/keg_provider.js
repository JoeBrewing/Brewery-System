var array_helpers = require('../helpers/array_helpers');
var base_provider = require('./base_provider');

var kegs = base_provider.getKegsByBreweryId();

module.exports = function getFilledKegs() {
    return array_helpers.filterArray(kegs, "state", "filled");
};

module.exports = function getEmptyKegs() {
    return array_helpers.filterArray(kegs, "state", "empty");
};

module.exports = function getSanitizedKegs() {
    return array_helpers.filterArray(kegs, "state", "sanitized");
};

module.exports = function getTotalEmptyKegs() {
    var empty_kegs = getEmptyKegs();
    var num_empty = empty_kegs ? empty_kegs.length : 0;
    var sanitized_kegs = getSanitizedKegs();
    var num_sanitized = sanitized_kegs ? sanitized_kegs.length : 0;
    return num_empty + num_sanitized;
};

module.exports = function getNumberOfFilledKegs(){
    var filled_kegs = getFilledKegs();
    var amount = filled_kegs ? filled_kegs.length : 0;
    return amount;
};