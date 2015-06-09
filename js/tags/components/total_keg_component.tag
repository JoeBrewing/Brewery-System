<total_keg_component>
    <div class="small_float">
        <h3>Total Kegs</h3><br>
        <h1>{model.total}</h1>
    </div>
    <script>
        var provider = require('../../providers/components/total_keg_component_provider');
        var self = this;
        self.model = provider.populateModel();
    </script>
</total_keg_component>