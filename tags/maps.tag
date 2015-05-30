<keg_distribution_map>

    <div id="map" class="medium_float"></div>

    <script>
        this.on('mount', function() {
            var map = new Datamap({
                element: this.map,
                scope:'usa'
            });
        });
    </script>
</keg_distribution_map>