<%@ page import="Resource.DBManager" %>
<%@ page import="sales.common.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.Cookie" %>

<%	
		String dirPath = request.getContextPath(); //HDASan

	    //java.util.Calendar date = java.util.Calendar.getInstance();
	    //ava.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	    //String strD = m_today.format(date.getTime());
		//String gusrid	= (String)session.getAttribute("vusrid");
		//String gusrnm	= (String)session.getAttribute("vusrnm");
		//String gusrpos	= (String)session.getAttribute("vusrpos");	
		//String gusrip	= (String)session.getAttribute("vusrip");	

		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "15";  	

		SmartRequest sr_db= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "15";  		
		
		ArrayList data_db = new ArrayList();	
		
		int len_db = 0;
		
		BaseDataClass bean_db;

		sr_db.setObject("requestedPage",(Object)requestedPage);				
		sr_db.setObject("pageSize",(Object)pageSize);						
		//sr_db.setObject("v_login_id",(Object)gusrid);						

		DBManager manager_db = new DBManager();
		data_db		= manager_db.list(sr_db);								
		manager_db.close();

%>


<!DOCTYPE html>
<html>
<head>
    <title>PMS2</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <link rel="stylesheet" href="/Mobile/lib/jquery.mobile.flatui.css" />
    <link rel="stylesheet" href="/Mobile/lib/mobipick.css" />
    <link rel="stylesheet" href="/Mobile/lib/common.css" />
    
    <script src="/Mobile/controller/nomu.js?v5"></script>
    <script data-main="/Mobile/lib/app" src="/Mobile/lib/require.js"></script>



	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui-jennifer.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/core.min.js" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/core.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/qunit-1.14.0.css">
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.css" />
	
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/qunit-1.14.0.js"></script>	
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/jquery-1.8.0.min.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/core.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.js"></script>





</head>

<script>

jui.ready([ "grid.xtable" ], function(xtable) {
    xtable_1 = xtable("#xtable_1", {
        fields: [ "cost_cd", "plj_nm" ],
        colshow: [ 0, 1],
        sort: [ 0, 1 ],
        sortLoading: true,
		resize: true,
        buffer: "scroll",
        bufferCount: 50,
		scrollHeight: 500,
        event: {
            colmenu: function(column, e) {
                this.showColumnMenu(e.pageX - 25);
 
		    }

        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),
			loading: $("#tpl_loading").html()
		}
    });

    xtable_1_submit = function() {
    	
        var result = [];
        
		<%
		len_db = data_db.size();
		bean_db = null;
		
        for(int h=0; h<len_db; h++) {
        	bean_db = (BaseDataClass)data_db.get(h);
        %>

            result.push({ cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>" });

        <%
        }
        %>

        xtable_1.update(result);

    }
});

</script>

<script id="tpl_row" type="text/template">
    <tr>
        <td><!= cost_cd !></td>
        <td><!= plj_nm !></td>
    </tr>
</script>
	
<script id="tpl_none" type="text/template">
    <tr>
        <td colspan="2" class="none" align="center">Data does not exist.</td>
    </tr>
</script>
	
<script id="tpl_loading" type="text/template">
    <div class="loading"></div>
</script>



<body class="jui" onLoad = "xtable_1_submit()">

    <div id="pagePMS" data-role="page">
        <div data-role="panel" id="menu">
            <ul id="listMenu" data-role="listview" data-theme="a">
            </ul>
        </div>
        <div data-role="header">
			<a href="#menu" data-icon="bars" data-iconpos="notext">Menu</a>
            <h1>PROJECT LIST</h1>
        </div>
    </div>
    
    <br><br>

	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover">
        <thead>
        <tr>
            <th width="60%">CODE</th>
            <th>PROJECT</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
	</div>



</body>


</html>

