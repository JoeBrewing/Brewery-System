<keg_percentage_donut>
    <div class="small_float">
        <div id="empty_div" if={empty}>
            <h3>No {opts.title}</h3>
        </div>
        <div id="donut" if={empty===false}>
        </div>
    </div>

    <script>
        var self = this;

        this.on('mount', function() {
            self.empty = true;
            if(opts.amount === 0){
                self.empty = true;
            };
            if(opts.amount > 0){
                self.empty = false;
                self.drawChart(opts.title, opts.amount, opts.percent, opts.sub);
            };
            self.update();
        });

        api.on('keg_update', function(){
            self.update();
            self.empty = true;
            if(opts.amount === 0){
                self.empty = true;
            };
            if(opts.amount > 0){
                self.empty = false;
                self.drawChart(opts.title, opts.amount, opts.percent, opts.sub);
            };
            self.update();
            console.log(opts.title + "-" + opts.amount + "-" + self.empty);
        });

        drawChart(title, amount, percent, sub){
            sub = sub === 0 ? .0001 : sub;
            console.log("this is when the chart is being drawn.");
            var pie = new d3pie(self.donut, {
                "header": {
                    "title": {
                        "text": amount,
                        "color": "#C8F7C5",
                        "fontSize": 24,
                        "font": "open sans"
                    },
                    "subtitle": {
                        "text": percent,
                        "color": "#C8F7C5",
                        "fontSize": 12,
                        "font": "open sans"
                    },
                    "location": "pie-center",
                    "titleSubtitlePadding": 9
                },
                "footer": {
                    "color": "#C8F7C5",
                    "fontSize": 24,
                    "font": "open sans",
                    "location": "bottom-left",
                    "text":title
                },
                "size": {
                    "canvasWidth": 200,
                    "canvasHeight": 200,
                    "pieInnerRadius": "80%",
                    "pieOuterRadius": "100%"
                },
                "data": {
                    "sortOrder": "value-desc",
                    "content": [
                        {
                            "label": "Filled",
                            "value": Number(amount),
                            "color": "#edf810"
                        },
                        {
                            "label": "Empty",
                            "value": Number(sub),
                            "color": "#f7f8e8"
                        }
                    ]
                },
                "labels": {
                    "outer": {
                        "hideWhenLessThanPercentage": 100,
                        "pieDistance": 32
                    },
                    "inner": {
                        "hideWhenLessThanPercentage": 100
                    },
                    "mainLabel": {
                        "fontSize": 11
                    },
                    "percentage": {
                        "color": "#ffffff",
                        "decimalPlaces": 0
                    },
                    "value": {
                        "color": "#adadad",
                        "fontSize": 11
                    },
                    "lines": {
                        "enabled": true
                    },
                    "truncation": {
                        "enabled": true
                    }
                },
                "effects": {
                    "pullOutSegmentOnClick": {
                        "effect": "linear",
                        "speed": 400,
                        "size": 8
                    }
                },
                "misc": {
                    "gradient": {
                        "enabled": true,
                        "percentage": 100
                    }
                }
            });
        }

    </script>
</keg_percentage_donut>

<keg_line_chart>
    <div class="medium_float">
        <div id="line_chart" class="ct-chart ct-golden-section"></div>
    </div>

    <script>
        var self = this;

        this.on('mount', function() {
            self.line_graph_data = [];
            self.line_graph_data.filled = [];
            self.line_graph_data.filled = getFilledActions();
            self.line_graph_data.emptied = [];
            self.line_graph_data.emptied = getEmptiedActions();
            self.line_graph_data.ordered = [];
            self.line_graph_data.ordered = getOrderedActions();

            new Chartist.Line(self.line_chart, {
                labels: ['January', 'February', 'March', 'April', 'May', 'June'],
                series: [
                    {
                        name: 'Filled',
                        data: self.line_graph_data.filled
                    },
                    {
                        name: 'Ordered',
                        data: self.line_graph_data.ordered
                    }
                ]
            });

            var $chart = $(self.line_chart);

            var $toolTip = $chart
                .append('<div class="tooltip"></div>')
                .find('.tooltip')
                .hide();

            $chart.on('mouseenter', '.ct-point', function() {
                var $point = $(this),
                value = $point.attr('ct:value'),
                seriesName = $point.parent().attr('ct:series-name');
                $toolTip.html(seriesName + '<br>' + value).show();
            });

            $chart.on('mouseleave', '.ct-point', function() {
                $toolTip.hide();
            });

            $chart.on('mousemove', function(event) {
                $toolTip.css({
                    left: (event.offsetX || event.originalEvent.layerX) - $toolTip.width() / 2 - 10,
                    top: (event.offsetY || event.originalEvent.layerY) - $toolTip.height() - 40
                });
            })


        });

    </script>
</keg_line_chart>