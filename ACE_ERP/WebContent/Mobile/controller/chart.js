var dataset = [
    { id: 1, sales: 20, year: "02" },
    { id: 2, sales: 55, year: "03" },
    { id: 3, sales: 40, year: "04" },
    { id: 4, sales: 78, year: "05" },
    { id: 5, sales: 61, year: "06" },
    { id: 6, sales: 35, year: "07" },
    { id: 7, sales: 80, year: "08" },
    { id: 8, sales: 50, year: "09" },
    { id: 9, sales: 65, year: "10" },
    { id: 10, sales: 59, year: "11" }
];

var month_dataset = [
    { sales: "20", month: "Jan", color: "#ee3639" },
    { sales: "30", month: "Fen", color: "#ee9e36" },
    { sales: "50", month: "Mar", color: "#eeea36" },
    { sales: "40", month: "Apr", color: "#a9ee36" },
    { sales: "70", month: "May", color: "#36d3ee" },
    { sales: "80", month: "Jun", color: "#367fee" },
    { sales: "60", month: "Jul", color: "#9b36ee" }
];

function fnInitPage() {
  
    var barChart = new dhtmlXChart({
        view: "bar",
        container: "barchart",
        value: "#sales#",
        radius: 0,
        border: true,
        xAxis: {
            template: "'#year#"
        },
        yAxis: {
            start: 0,
            end: 100,
            step: 10,
            template: function(obj) {
                return (obj % 20 ? "": obj);
            }
        }
    });
    barChart.parse(dataset, "json");

    var chart = new dhtmlXChart({
        view: "pie",
        container: "piechart",
        value: "#sales#",
        color: "#color#",
        label: "#month#",
        pieInnerText: "#sales#",
        shadow: 0
    });
    chart.parse(month_dataset, "json");
    
    var chart = new dhtmlXChart({
        view: "line",
        container: "linechar",
        value: "#sales#",
        item: {
            borderColor: "#1293f8",
            color: "#ffffff"
        },
        line: {
            color: "#1293f8",
            width: 3
        },
        xAxis: {
            template: "'#year#"
        },
        offset: 0,
        yAxis: {
            start: 0,
            end: 100,
            step: 10,
            template: function(obj) {
                return (obj % 20 ? "": obj);
            }
        }
    });
    chart.parse(dataset, "json");

    var chart = new dhtmlXChart({
        view: "area",
        container: "areachart",
        value: "#sales#",
        color: "#36abee",
        alpha: 0.8,
        xAxis: {
            template: "'#year#"
        },
        yAxis: {
            start: 0,
            end: 100,
            step: 10,
            template: function(obj) {
                return (obj % 20 ? "": obj);
            }
        }
    });
    chart.parse(dataset, "json");

}
