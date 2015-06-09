var array_helpers = require('../helpers/array_helpers')

function getKegsByBreweryId(){
    if(!localStorage.brewery_id) {
        localStorage.brewery_id = "BR2015001";
    };

    var kegs = localStorage.kegs ? JSON.parse(localStorage.kegs) : [];

    return array_helpers.filterArray(kegs, "brewery_id", localStorage.brewery_id);
};


