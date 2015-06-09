<empty_keg_donut_chart_component>
    <div class="small_float">
        <div id="empty_div" if={empty}>
            <h3>No Empty Kegs</h3>
        </div>
        <div id="donut" if={empty===false}>
        </div>
    </div>

    <script>
        var provider = require('../../providers/components/total_keg_component_provider');
        var donut_chart = require('../../visuals/donut_chart');
        var self = this;

        self.model = provider.populateModel();
        self.empty = self.model.num_filled === 0;
        if(self.empty===false){
            donut_chart.drawChart("Empty Kegs", model.num_empty, model.num_filled, model.emptypercent);
        };
    </script>
</filled_keg_donut_chart_component>