<%@ page import="Resource.DBManagerFILE" %>
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

		String v_login_id	= (String)session.getAttribute("vusrid");
		String v_login_ip	= (String)session.getAttribute("vusrip");	

		SmartRequest sr_db= new SmartRequest(request);	

		ArrayList data_db = new ArrayList();	

		int len_db = 0;

		BaseDataClass bean_db;
%>

<!DOCTYPE html>
<meta charset="euc-kr">
<html>
<head>
    <title>Action Plan File</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    
    <meta http-equiv="Content-Type" content="text/html;charset=euc-kr" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	 
	<script src="../../Resource/node_modules/jui/lib/core.min.js"></script>
	<script src="../../Resource/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../Resource/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../Resource/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../Resource/node_modules/jui/lib/jui/js/ui.min.js" ></script>
	
</head>
<!------------------------------------------------------------------------------------------------------------------- 
                                  			Xtable Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "grid.xtable" ], function(xtable) {
	
	var page = 1;

    xtable_1 = xtable("#xtable_1", {
        fields: [ "file_key","file_name", "file_url"],
        colshow: [ 0, 1, 2],
        sort: [ 0, 1, 2],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 10,
        event: {

        	 click:function(e){ 

					},
             
	    	select:function(e){
    		

	    	}
             
        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),
		}
    });

    	xtable_1_submit = function() {

        var result = [];
        
			<%
		
			String file_key    = request.getParameter("file_key");         	//file_key
			//String file_name   = request.getParameter("file_name");         //file_name
			
			sr_db.setObject("file_key",(Object)file_key);
			//sr_db.setObject("file_name",(Object)file_name);			
			sr_db.setObject("v_login_id",(Object)v_login_id);	
			sr_db.setObject("v_login_ip",(Object)v_login_ip);			

			DBManagerFILE manager_db = new DBManagerFILE();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>

			result.push({ file_key: "<%=bean_db.get("file_key")%>", file_name: "<%=bean_db.get("file_name")%>", file_url: "<%=bean_db.get("file_url")%>"});
		    xtable_1.update(result);
		    
			<% 
			} 
			%>

    		}

});

</script>


<body class="jui" onload="xtable_1_submit()">

	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
	    <table class="table classic hover" border_nm=1 height="40px">
	        <thead>
	        <tr>  
	            <th></th> 
	            <th>FILE</th>    
	            <th></th>                        
	        </tr>
	        </thead>
	        <tbody>
	        </tbody>
	    </table>

	<script id="tpl_row" type="text/template">
			<tr>
				<td align="center" colspan=3><!= file_name !></td>
			</tr>
	</script>     
                                                                                                                                                                                            
	<script id="tpl_none" type="text/template">                                                                                                
			<tr>                                                                                                                                                     
				<td colspan="3" class="none" align="center">Data does not exist.</td>                                      
			</tr>                                                                                                                                                   
	</script>                                                                                                                                                      
</div>

<br>

<div align="center">
  	<a href="../../../Ehr/file/upload/<%=bean_db.get("file_url")%>" class="btn focus" value="download" target="_blank">O P E N</a>
</div>

</body>

</html>    