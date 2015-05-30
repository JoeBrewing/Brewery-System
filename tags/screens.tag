<title_header>
    <div>
        <div if={ !api.main_screen }><i class="fa fa-home fa-lg navbar_item" onclick={goHome}></i></div>
        <div if={ !api.add_keg_screen }><i class="fa fa-plus fa-lg navbar_item" onclick={goAddKeg}></i></div>
        <div if={ !api.add_beer_screen }><i class="fa fa-beer fa-lg navbar_item" onclick={goAddBeer}></i></div>
        <div if={ !api.add_distributor_screen }><i class="fa fa-truck fa-lg navbar_item" onclick={goAddDistributor}></i></div>
        <h3>Brewery Keg Inventory Management System</h3>
    <div>

    <divider></divider>
    <script>
        goHome(){
            <!-- ToDo: add loop to go through these and assign false to all but the specified screen -->
            api.main_screen = true;
            api.empty_keg_screen = false;
            api.filled_keg_screen = false;
            api.add_keg_screen = false;
            api.add_beer_screen = false;
            api.add_distributor_screen = false;
            riot.update();
        };

        goAddKeg(){
            api.add_keg_screen = true;
            api.main_screen = false;
            api.empty_keg_screen = false;
            api.filled_keg_screen = false;
            api.add_beer_screen = false;
            api.add_distributor_screen = false;
            riot.update();
        }

        goAddBeer(){
            api.add_keg_screen = false;
            api.main_screen = false;
            api.empty_keg_screen = false;
            api.filled_keg_screen = false;
            api.add_beer_screen = true;
            api.add_distributor_screen = false;
            riot.update();
        }

        goAddDistributor(){
            api.add_keg_screen = false;
            api.main_screen = false;
            api.empty_keg_screen = false;
            api.filled_keg_screen = false;
            api.add_beer_screen = false;
            api.add_distributor_screen = true;
            riot.update();
        }
    </script>
</title_header>

<desktop_main_screen>
    <div if={ api.main_screen }>

        <keg_total Total={api.total}></keg_total>
        <div>
            <keg_percentage_donut Title="Filled Kegs" Amount={api.number_filled} Sub={api.total_number_empty} Percent={api.filledpercent} onclick={switchToFilledKegScreen}></keg_percentage_donut>
            <keg_percentage_donut Title="Empty Kegs" Amount={api.total_number_empty} Sub={api.number_filled} Percent={api.emptypercent} onclick={switchToEmptyKegScreen}></keg_percentage_donut>
        </div>
        <div>
            <keg_line_chart data={ self.line_graph_data.filled }></keg_line_chart>
            <keg_distribution_map></keg_distribution_map>
        </div>
    </div>

    <script>
        var self = this;

        switchToEmptyKegScreen(){
            api.main_screen = false;
            api.filled_keg_screen = false;
            api.empty_keg_screen = true;
            api.add_keg_screen = false;
            riot.update();
        };

        switchToFilledKegScreen(){
            api.main_screen = false;
            api.filled_keg_screen = true;
            api.empty_keg_screen = false;
            api.add_keg_screen = false;
            riot.update();
        }

        this.on('mount', function() {
            riot.mount('keg_percentage_donut');
            riot.mount('keg_line_chart');
            riot.mount('keg_total');
            riot.mount('keg_distribution_map');
        });


    </script>
</desktop_main_screen>

<desktop_add_beer_screen>
    <div class="large_float" if={ api.add_beer_screen }>
        <h3>Add Beer Screen</h3>
        <p>This screen allows you to enter new beers for use in the Brewery Keg Inventory Management System.</p>
        <p>It also displays the beers you have already entered.</p>
        <div>
            <div>
                <input type="text" name="beer_name" placeholder="Beer Name" />
                <input type="text" name="beer_style" placeholder="Style" />
            </div>
            <div>
                <input type="text" name="beer_size" placeholder="Keg Size" />
                <input type="text" name="beer_cost" placeholder="Cost to Distributor" />
            </div>
            <div>
                <input type="button" name="add_button" value="Add" onclick={addBeer} />
            </div>
        </div>
        <div class="scroll-y-small">
            <beer each={ beer, b in api.beers }></beer>
        </div>

        <script>
            var self = this;
            addBeer(){
                <!-- ToDo: Add input validation -->
                addBeer(self.beer_name.value, self.beer_style.value, self.beer_size.value, self.beer_cost.value);
            }
        </script>
    </div>
</desktop_add_beer_screen>

<desktop_add_distributor_screen>
    <div class="large_float" if={ api.add_distributor_screen }>
        <h3>This is the distributor adding screen</h3>
    </div>
</desktop_add_distributor_screen>

<desktop_add_keg_screen>
    <div class="small_float" if={ api.add_keg_screen }>
        <input type="text" name="number" class="input_item" placeholder="Enter Number of Kegs to Add" />
        <select name="state" >
            <option value="ordered">Ordered</option>
            <option value="empty">Empty</option>
        </select>
        <input type="button" name="add" value="Add" onclick={add} />
    </div>

    <script>
        var self = this;

        add(){
            var r = confirm("Are you sure you would like to add " + self.number.value + " " + self.state.value + " kegs?");
            if(r == true){
                addKegs(self.number.value, self.state.value);
                api.main_screen = true;
                api.empty_keg_screen = false;
                api.filled_keg_screen = false;
                api.add_keg_screen = false;
                riot.update();
                api.trigger('keg_update');
            }
            else{
                self.clearForm();
            }
        };

        clearForm(){
            self.number.value = "";
            self.state.value = "ordered";
            riot.update();
        };
    </script>
</desktop_add_keg_screen>

<desktop_empty_keg_screen>
    <div class="large_float" if={ api.empty_keg_screen }>
        <!-- add ability to add new kegs -->
        <select name="search_state">
            <option value="empty">Empty</option>
            <option value="sanitized">Sanitized</option>
        </select>
        <input type="button" value="Search" onclick={searchEmptyKegs} />

        <div class="scroll-y" if={ has_results }>
            <keg each={ result, r in results } data={ result } parentview={ parent } filled={ false } />
        </div>

        <div if={ empty_results }>
            <h3>No { search_state.value } kegs found in the system!</h3>
        </div>
    </div>
    <script>
        this.on('mount', function() {
            this.has_results = false;
            this.empty_results = false;
        });

        this.on('update', function(){
            this.searchEmptyKegs();
        });

        searchEmptyKegs(){
            this.results = [];
            if(this.search_state.value === "empty"){
                this.results = getEmptyKegs();
                this.has_results = this.results.length > 0;
                this.empty_results = this.results.length === 0;
            }
            else{
                this.results = getSanitizedKegs();
                this.has_results = this.results.length > 0;
                this.empty_results = this.results.length === 0;
            }
            riot.update();
        };
    </script>
</desktop_empty_keg_screen>

<desktop_filled_keg_screen>
    <div class="large_float" if={ api.filled_keg_screen }>
        <!-- rework this. Will they ever really be searching for anything other than filled on this screen -->
        <select name="search_state">
            <option value="filled">Filled</option>
            <option value="empty">Empty</option>
        </select>
        <input type="button" value="Search" onclick={searchFilledKegs} />

        <div class="result_table_header" class="text-align:left" if={ has_results }>
            <!-- make this line up with the result date -->
            <table>
                <th>Brewery</th>
                <th>Status</th>
                <th>ID</th>
                <th>Size</th>
            </table>
        </div>
        <div if={ has_results }>
            <div class="scroll-y">
                <keg each={ result, r in results } data={ result } parentview={ parent } filled={ true } />
            </div>
        </div>
        <div if={ empty_results }>
            <h3>No { search_state.value } kegs found in the system!</h3>
        </div>
    </div>

    <script>
        this.on('mount', function() {
            this.has_results = false;
            this.empty_results = false;
        });

        this.on('update', function(){
            this.searchFilledKegs();
        });

        searchFilledKegs(){
            this.results = [];
            if(this.search_state.value === "filled"){
                this.results = getFilledKegs();
                this.has_results = this.results.length > 0;
                this.empty_results = this.results.length === 0;
            }
            else{
                this.results = getEmptyKegs();
                this.has_results = this.results.length > 0;
                this.empty_results = this.results.length === 0;
            }
            riot.update();
        };

    </script>
</desktop_filled_keg_screen>

<beer>
    <div class="result_display">
        <label class="display_item">{ beer.beer_name }</label>
        <label class="display_item">{ beer.beer_style }</label>
        <label class="display_item">{ beer.beer_size }</label>
        <label class="display_item">{ beer.beer_cost }</label>
    </div>

    <script>
        var self = this;
        self.beer = opts.data;
    </script>

</beer>

<keg>
    <div class="result_display" >
        <label class="display_item">{ keg.brewery_name }</label>
        <select name="state" onclick={ checkFilled }>
            <option value="sanitized">Sanitized</option>
            <option value="empty">Empty</option>
            <option value="filled">Filled</option>
        </select>
        <label class="display_item">{ keg.keg_id }</label>
        <label class="display_item">{ keg.size }</label>
        <input type="text" name="beer" class="display_item" placeholder="Enter the Beer Name" if={ filled }/>
        <i class="fa fa-save" onclick={ save }></i>
    </div>

    <script>
        var self = this;
        self.keg = opts.data;
        self.filled = opts.filled;

        this.on('mount', function() {
            self.state.value = self.keg.state;
            self.beer.value = self.keg.beer;
        });

        checkFilled(){
            if(self.state.value === "filled"){
                self.filled = true;
            }
            else{
                self.filled = false;
            }
            riot.update();
        }

        save(){
            var index = getKegIndex(api.kegs, self.keg);
            self.keg.state = self.state.value;
            self.keg.beer = self.beer.value;
            api.kegs[index] = self.keg;
            localStorage.kegs = JSON.stringify(api.kegs);
            api.trigger('keg_update');
            riot.update();
        };
    </script>
</keg>

<keg_total>
    <div class="small_float">
        <h3>Total Kegs</h3><br>
        <h1>{opts.total}</h1>
    </div>
    <script>

    </script>
</keg_total>

