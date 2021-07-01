<%@ page import="security.common.DBManager003" %>
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

		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "15";  	
		String v_group;
		
		SmartRequest sr_db= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	  = "15";  		
		v_group 	  = "0";
		
		ArrayList data_db = new ArrayList();	

		int len_db = 0;

		BaseDataClass bean_db;

		sr_db.setObject("requestedPage",(Object)requestedPage);				
		sr_db.setObject("pageSize",(Object)pageSize);						

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
             //colmenu: function(column, e) { this.showColumnMenu(e.pageX - 25);}
        	 click:function(e){ 

        		 						//alert(e.data["file_key"]);
        		 						//alert(e.index); 
										//func_Popup(e.data["file_key"], e.data["file_name"]);

					},
             
	    	select:function(e){

	    		//alert(e.data["file_url"]);
	    		//https://ace.hdasan.com:447/Ehr/file/upload/2170015.jpghttp://10.61.4.55:7001/HDAsan/Security/act_plan/url
	    		//var vFILE_NAME  = e.data["file_name"];
	    	    //var vFILE_URL   = e.data["file_url"];
	    	    //alert(vFILE_NAME);
	    	    //alert(vFILE_URL);
	    	    // 첨부 파일이 존재하는 경우만 수행하게~
	    	    //if (vFILE_NAME != "" && vFILE_URL != "") {
	    		//	cfDownload(vFILE_NAME,vFILE_URL);
	    	    //}		    		

	    	}
             
        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),
		}
    });

		//var url= "https://ace.hdasan.com:447/Ehr/file/upload/";
		//var url = "/HDAsan/Pms/new/common/pms_detail.jsp";
		
		//alert(url);
		
    	xtable_1_submit = function() {

        var result = [];
        
			<%
		
			String file_key   = request.getParameter("file_key");         	//file_key

			sr_db.setObject("file_key",(Object)file_key);	
		
			DBManager003 manager_db = new DBManager003();
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



    <div class="notify danger">
        <div class="image"><i class="icon-caution" style="font-size: 18px;"></i></div>
		<div class="message" width="50%"> * 보안을 위해 모든 사용 내역은 기록됩니다.</div>
	</div>

	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
	    <table class="table classic hover" border_nm=1 height="20px">
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


                                                                                                                                                                                                                       
