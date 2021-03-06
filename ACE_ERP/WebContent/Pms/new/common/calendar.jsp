<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

	<!--  ???ÿ? -->
	<link rel="stylesheet" href="../../../Resource/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../../Resource/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../../Resource/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../../Resource/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	 
	<script src="../../../Resource/node_modules/jui/lib/core.min.js"></script>
	<script src="../../../Resource/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../../Resource/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../../Resource/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../../Resource/node_modules/jui/lib/jui/js/ui.min.js" ></script>

</head>

<script>
jui.ready([ "ui.datepicker" ], function(datepicker) {
    datepicker_1 = datepicker("#datepicker_1", {
        titleFormat: "yyyy. MM",
        format: "yyyy/MM/dd",
        event: {
            select: function(date, e) {
                //alert(date);
            },
            prev: function(e) {
                //alert("prev");
            },
            next: function(e) {
                //alert("next");
            }
        },
        tpl: {
            date: $("#tpl_date").html()
        }
    });
});
</script>


<body class="jui">

<div id="datepicker_1" class="datepicker">
    <div class="head">
        <div class="prev"><i class="icon-chevron-left"></i></div>
        <div class="title"></div>
        <div class="next"><i class="icon-chevron-right"></i></div>
    </div>
    <table class="body">
        <tr>
            <th>SU</th><th>MO</th><th>TU</th><th>WE</th><th>TH</th><th>FR</th><th>SA</th>
        </tr>
    </table>
</div>

<script id="tpl_date" type="text/template">
    <td><!= date !></td>
</script>


</body>
</html>