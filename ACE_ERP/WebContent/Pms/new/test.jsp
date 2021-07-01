<%@ page import="pms.new2018.common.DBManager" %>
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
		String v_group;
		
		SmartRequest sr_db= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	  = "15";  		
		v_group 	  = "0";
		
		ArrayList data_db = new ArrayList();	
		ArrayList data_db1 = new ArrayList();			
		ArrayList data_db2 = new ArrayList();
		ArrayList data_db3 = new ArrayList();
		ArrayList data_db4 = new ArrayList();		
		
		int len_db = 0;
		boolean isMaster = false;
		
		BaseDataClass bean_db;

		sr_db.setObject("requestedPage",(Object)requestedPage);				
		sr_db.setObject("pageSize",(Object)pageSize);						
		//sr_db.setObject("v_group",(Object)v_group);						

		//DBManager manager_db = new DBManager();
		//data_db		= manager_db.list(sr_db);								
		//manager_db.close();

%>

<!DOCTYPE html>

<meta charset="euc-kr">

<html>
<head>
    <title>PMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta http-equiv="Content-Type" content="text/html;charset=euc-kr" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	
	<!--  로컬용 -->
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	 
	<script src="../../Resource/node_modules/jui/lib/core.min.js"></script>
	<script src="../../Resource/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../Resource/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../Resource/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../Resource/node_modules/jui/lib/jui/js/ui.min.js" ></script>	
	<script src="../../Resource/node_modules/jui/js/datepicker.js" ></script>		
	

</head>


<!------------------------------------------------------------------------------------------------------------------- 
                                  			Xtable Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "grid.xtable" ], function(xtable) {
    xtable_1 = xtable("#xtable_1", {
        fields: [ "group_nm", "detail_nm", "dpt_nm", "startdt", "enddt", "order_nm", "cost", "pm", "cost_cd", "plj_nm", "edit" ],
        colshow: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        sort: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        sortLoading: true,
		resize: true,
        buffer: "scroll",
        bufferCount: 50,
		scrollHeight: 700,
        event: {
            //colmenu: function(column, e) { this.showColumnMenu(e.pageX - 25);}
        	
        	 colclick:function(e){ 
        		 						//alert(e.data);
        		 						//alert(date.value); 
        		 						//alert(e.pageX); 
        	 							//showEventMessage(fields);  
        	 						}
    

        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),
			loading: $("#tpl_loading").html()
		}
    });

    
    var showEventMessage = function(fields){  
    	alert("[" + fields.getData(fields.index) + "]");

    	 } 


    xtable_1_submit = function(text) {

        var result = [];

			<%
		    //Configuration conf = Configuration.getInstance();
		    //String FILEURL = conf.get("framework.file.upload.pds");
 			//String ROLE_CD      = box.getString("SESSION_ROLE_CD");
			//String status = request.getParameter("STATUS");        	//품의번호
			//String role_cd = box.getString("SESSION_ROLE_CD");        //롤권한
			//String p_mode = request.getParameter("text");
			//System.out.println("I don't know. But");
			//String p_mode;
			//String _mode;
			//p_mode = request.getParameter("text").trim();
			//request.getParameter("year").trim();
			//System.out.println("p_mode -->" + p_mode);
			//boolean isMaster = false;
			%>			


			<%
			
			isMaster = true;
			
			if(isMaster) {
				v_group = "0"; 
			}
			isMaster = false;
					
			sr_db.setObject("v_group",(Object)v_group);	

			DBManager manager_db = new DBManager();
			data_db		= manager_db.list(sr_db);								
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>
			
			result.push({ group_nm: "<%=bean_db.get("group_nm")%>",  detail_nm: "<%=bean_db.get("detail_nm")%>", dpt_nm: "<%=bean_db.get("dpt_nm")%>", startdt: "<%=bean_db.get("startdt")%>", enddt: "<%=bean_db.get("enddt")%>", order_nm: "<%=bean_db.get("order_nm")%>", cost: "<%=bean_db.get("cost")%>", pm: "<%=bean_db.get("pm")%>", cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>",  edit: "<%=bean_db.get("edit")%>"});
			xtable_1.update(result);

			<% 
				} 
			%>


    }
});

</script>



<script id="tpl_row" type="text/template">
    <tr>
        <td align="center"><!= group_nm !></td>
        <td align="center"><!= detail_nm !></td>
        <td align="center"><!= dpt_nm !></td>
        <td align="center"><!= startdt !></td>
        <td align="center"><!= enddt !></td>
        <td align="center"><!= order_nm !></td>
        <td align="right"><!= cost !></td>
        <td align="center"><!= pm !></td>
        <td align="center"><!= cost_cd !></td>
        <td><!= plj_nm !></td>
        <td align="center"><a class="btn mini" value="edit" onclick="fnc_popup()"><i class="icon-edit"></i></a></td>
    </tr>
</script>
	
<script id="tpl_none" type="text/template">
    <tr>
        <td colspan="11" class="none" align="center">Data does not exist.</td>
    </tr>
</script>
	
<script id="tpl_loading" type="text/template">
    <div class="loading"></div>
</script>



<script>

	function fnc_popup() {
	
		//이곳에 해당 코딩을 입력 하세요
		//var url = "/HDAsan/Mobile/view/pms_detail.jsp";
		var url = "/HDAsan/Pms/new/common/pms_detail.jsp";

		//window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		window.open(url, "modal", "Width=600, Height=350, location=no");    
            
	}
        
	
	function fnc_calendar() {
		
		
		
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var s_year  = String(year);
        var s_month = String(month);
        var s_day = String(day);
        var TODAY_VAL = s_year + "/" + s_month + "/" + s_day;
        
        alert(TODAY_VAL);
		
		
		//이곳에 해당 코딩을 입력 하세요
		//var url = "/HDAsan/Mobile/view/pms_detail.jsp";
		var url = "/HDAsan/Pms/new/common/calendar.jsp";

		window.showModalDialog(url, "Modal", "dialogWidth:100px; dialogHeight:170px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		//window.open(url, "modal", "Width=120, Height=180, location=no");    
            
	}	
	
</script>


<script language="javascript">

       var dsTemp = window.dialogArguments;

        function btn_submit() {

        	xtable_1_submit();

        }
</script>	

<script language="javascript">

$( function() {

    $( "#datepicker" ).datepicker();

  } );


</script>	

<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
                                   Script 와 html body 부분의 경계선
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->


<!-- body_start -->
<jsp:include page="/Common/sys/body_s25.jsp"/>

﻿<section>
</br>
	
	<div class="navbar">프로젝트 &nbsp; &nbsp;
	<input type="text" class="input small" />

	<button class="btn small" onclick="btn_submit()">
	    <i class="icon-search"></i> Search
	</button>	
	
	
	&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;기간
	
	
	
	
	<input type="text" id="datepicker"/><a class="btn mini"><i class="icon-calendar"></i></a>

	
	 &nbsp;~ &nbsp;
	<input type="text" class="input small" /><a class="btn mini" value="home"><i class="icon-calendar"></i></a>

	<button class="btn mini" onclick="button_calendar.setValue('gear')">
	    <i class="icon-play"></i> Run
	</button>
	
	</div>
	
	
</section>

 &nbsp;

<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=0>
        <thead>
        <tr>
            <th>대분류</th>
            <th>중분류</th>            
            <th>담당</th>            
            <th>시작일</th>            
            <th>종료일</th> 
            <th>발주처</th>
            <th>도급액</th>          
            <th>수행PM</th>    
            <th>코드</th>
            <th width="30%">PROJECT</th>
            <th>수정</th>            
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>





<!-- body_end -->
</body>

</html>

