function filterArray(items, key, condition){
    if (!items) {
        return []
    }

    return items.filter(function(item) {
        return item[key] === condition
    }).slice() // shallow copy
};

function filterActionsByMonth(items, key, condition){
    if (!items) {
        return []
    }

    var arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    items.filter(function(item) {
        item[key] === condition
    }).forEach(function(item) {
        var month = Number(item.month) - 1;
        arr[month] += 1
    })

    return arr;
}

function addActionDataForTesting() {
    var index = 0;
    while (index < 27){
        var action =
        {
            brewery_id:2015001,
            brewery_name:"Joe Beer",
            action:"filled",
            beer:"IPA",
            month:5,
            year:2015,
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        }
        api.actions.push(action);
        index += 1;
    }
    var index = 0;
    while (index < 33){
        var action =
        {
            brewery_id:2015001,
            brewery_name:"Joe Beer",
            action:"emptied",
            beer:"IPA",
            month:5,
            year:2015,
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        }
        api.actions.push(action);
        index += 1;
    }
    var index = 0;
    while (index < 11){
        var action =
        {
            brewery_id:2015001,
            brewery_name:"Joe Beer",
            action:"ordered",
            beer:"IPA",
            month:5,
            year:2015,
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        }
        api.actions.push(action);
        index += 1;
    }
}

function addDataForTesting(kegs)
{
    var index = 0;
    while (index < 40){
        var keg =
        {
            brewery_id:2015001,
            brewery_name:"Joe Beer",
            state:"empty",
            keg_id:2015 + index,
            beer:"",
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        }
        kegs.push(keg);
        index += 1;
    }
    while (index < 67){
        var keg =
        {
            brewery_id:2015001,
            brewery_name:"Joe Beer",
            state:"filled",
            keg_id:2015 + index,
            beer:"IPA",
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        }
        kegs.push(keg);
        index += 1;
    }
    return kegs;
}

function addKegForTesting(kegs){
    var keg =
    {
        brewery_id:2015001,
        brewery_name:"Joe Beer",
        state:"empty",
        keg_id:"20150010001",
        beer:"",
        size:15.5,
        location:"Joe Beer"
    }
    kegs.push(keg)
    return kegs;
}

function getKegIndex(arr, item){
    var counter = 0;
    while(counter < arr.length){
        if(arr[counter].keg_id === item.keg_id){
            return counter;
        }
        counter += 1;
    }
}

function updateAPIValues(){
    api.kegs = getKegsByBreweryId();
    api.empty_kegs = getEmptyKegs();
    api.sanitized_kegs = getSanitizedKegs();
    api.filled = getFilledKegs();
    api.number_filled = getNumberOfFilledKegs();
    api.number_empty = getNumberOfEmptyKegs();
    api.number_sanitized = getNumberOfSanitizedKegs();
    api.total_number_empty = getTotalEmptyKegs();
    api.total = getTotalNumberOfKegs();
    api.filledpercent = api.number_filled === 0 ? "0%" : (Math.round((api.number_filled / api.total) * 100)) + "%";
    api.emptypercent = api.total_number_empty === 0 ? "0%" : (Math.round((api.total_number_empty / api.total) * 100)) + "%";
}

function getKegsByBreweryId(){
    if(!localStorage.brewery_id) {
        localStorage.brewery_id = "BR2015001";
    };

    var kegs = localStorage.kegs ? JSON.parse(localStorage.kegs) : [];

    return filterArray(kegs, "brewery_id", localStorage.brewery_id);
};

function addKegs(number, type){
    var id = localStorage.brewery_id;
    var count = 0;
    while(count < number)
    {
        var keg =
        {
            brewery_id:"BR2015001",
            brewery_name:"Joe Beer",
            state:type,
            keg_id:id + count,
            beer:"",
            size:15.5,
            location_name:"Joe Beer",
            location_lat:33.825200,
            location_long:-85.751400,
            location_id:1
        };
        api.kegs[api.kegs.length] = keg;
        localStorage.kegs = JSON.stringify(api.kegs);
        count += 1;
    }
}

function addBeer(name, style, size, cost){
    var beer =
    {
        beer_name:name,
        beer_style:style,
        beer_size:size,
        beer_cost:cost
    };

    api.beers[api.beers.length] = beer;
}

function getActionsByBreweryId() {
    if(!localStorage.actions) {
        localStorage.actions = [];
    }

    return filterArray(localStorage.actions, "brewery_id", localStorage.brewery_id);
};

function getFilledKegs() {
    return filterArray(api.kegs, "state", "filled");
};

function getFilledActions() {
    return filterActionsByMonth(api.actions, "action", "filled")
};

function getEmptyKegs() {
    return filterArray(api.kegs, "state", "empty");
};

function getEmptiedActions() {
    return filterActionsByMonth(api.actions, "action", "emptied")
};

function getOrderedActions() {
    return filterActionsByMonth(api.actions, "action", "ordered");
};

function getSanitizedKegs() {
    return filterArray(api.kegs, "state", "sanitized");
};

function getTotalEmptyKegs() {
    return api.number_empty + api.number_sanitized;
};

function getNumberOfFilledKegs(){
    var amount = api.filled ? api.filled.length : 0;
    return amount;
};

function getNumberOfSanitizedKegs() {
    var amount = api.sanitized_kegs ? api.sanitized_kegs.length : 0;
    return amount;
};

function getNumberOfEmptyKegs() {
    var amount = api.empty_kegs ? api.empty_kegs.length : 0;
    return amount;
};

function getTotalNumberOfKegs(){
    return api.number_filled + api.total_number_empty;
};



