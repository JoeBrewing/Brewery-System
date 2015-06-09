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

function getKegIndex(arr, item){
    var counter = 0;
    while(counter < arr.length){
        if(arr[counter].keg_id === item.keg_id){
            return counter;
        }
        counter += 1;
    }
}