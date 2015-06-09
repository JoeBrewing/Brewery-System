module.exports = drawChart(title, num_empty, num_filled, percent)
{
    sub = sub === 0 ? .0001 : sub;
    console.log("this is when the chart is being drawn.");
    var pie = new d3pie(self.donut, {
        "header": {
            "title": {
                "text": title === "Empty Kegs" ? num_empty : num_filled,
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
            "text": title
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
                    "value": Number(num_filled),
                    "color": "#edf810"
                },
                {
                    "label": "Empty",
                    "value": Number(num_empty),
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
        "misc": {
            "gradient": {
                "enabled": true,
                "percentage": 100
            }
        }
    });
}