<script>
    var screens = require('./tags/screens.tag');
    var charts = require('./tags/charts.tag');
    var maps = require('./tags/maps.tag');
    var provider = require('./tags/DataProvider.js');
    var api = riot.observable();
    api.main_screen = true;
    api.empty_keg_screen = false;
    api.filled_keg_screen = false;
    api.add_keg_screen = false;
    api.add_beer_screen = false;
    api.add_distributor_screen = false;
    api.actions = [];
    api.beers = [];

    updateAPIValues();

    riot.mount('title_header');
    riot.mount('desktop_main_screen');
    riot.mount('desktop_empty_keg_screen');
    riot.mount('desktop_filled_keg_screen');
    riot.mount('desktop_add_keg_screen');
    riot.mount('desktop_add_beer_screen');
    riot.mount('desktop_add_distributor_screen')
    riot.update();

    api.on('keg_update', function(){
        riot.update();
        updateAPIValues();

        console.log("total-" + api.total);
        console.log("Update-" + api.kegs.length);
        riot.update();
    });
</script>
