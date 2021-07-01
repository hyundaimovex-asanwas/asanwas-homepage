<%@ page language="java"%>

<%@ page import="java.sql.*,javax.sql.*,javax.naming.*,java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.Cookie" %>

<%	
		//String dirPath = request.getContextPath(); //HDASan

	    //java.util.Calendar date = java.util.Calendar.getInstance();
	    //ava.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	    //String strD = m_today.format(date.getTime());
		//String gusrid	= (String)session.getAttribute("vusrid");
		//String gusrnm	= (String)session.getAttribute("vusrnm");
		//String gusrpos	= (String)session.getAttribute("vusrpos");	
		//String gusrip	= (String)session.getAttribute("vusrip");	


		Context init = new InitialContext();
		
		DataSource ds = (DataSource) init.lookup("CforPMS");
		
		Connection conn = ds.getConnection();
		
		//Connection conn = ds.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
		
		
		Vector vProcedure = new Vector();


		
		CallableStatement cstmt = conn.prepareCall("{call PMS.PR_CC010I_00(?,?)}");
		
		System.out.println("cstmt111111111111=========="+cstmt);
		
		
		cstmt.setString(1, "");
		cstmt.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);


		//cstmt.registerOutParameter(2, Types.VARCHAR);	//결과를 받을 커서		
		System.out.println("cstmt222222222222222=========="+cstmt);
		cstmt.execute();
		//System.out.println("cstmt33333333333333333333333=========="+cstmt);
		System.out.println("0000000000000000000000000000000000000");
		
		ResultSet rs;
		System.out.println("111111111111111111111111");
		rs = (ResultSet)cstmt.getObject(2);
		
		System.out.println("222222222222222222222222222");
		System.out.println("rs=========="+rs);
		
		while(rs.next()) { 

		   Hashtable htProcedure = new Hashtable();
		   
		   //System.out.println("PLJ_NM=========="+rs.getString("PLJ_NM");
		   
		   htProcedure.put("PLJ_NM", rs.getString("PLJ_NM"));

		   vProcedure.addElement(htProcedure);

		  }
		System.out.println("vProcedure=========="+vProcedure);
		cstmt.close();

		conn.close();

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
	
	<!--  ë¡ì»¬ì© -->
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
	

	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	
	

</head>

<script language="javascript">



    

</script>	


<!------------------------------------------------------------------------------------------------------------------- 
                                  			Xtable Event
--------------------------------------------------------------------------------------------------------------------->
<script>

$(document).ready(function() {
	  
	xtable_1_submit("1");
	  
});


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


    xtable_1_submit = function(data) {



    	//alert(data);
    	
    	//movForm.target = "por"; // iframe
    	//movForm.action = "./test.jsp?data= "+data;
    	//prompt(this,movForm.action);
    	//movForm.submit();

    	//result.clear();
    	
        var result = [];

        
	        <%
	
	        //v_project = request.getParameter("name").trim();
	
	        %>        
        
        
			<%
		    //Configuration conf = Configuration.getInstance();
		    //String FILEURL = conf.get("framework.file.upload.pds");
 			//String ROLE_CD      = box.getString("SESSION_ROLE_CD");
			//String status = request.getParameter("STATUS");        	//íìë²í¸
			//String role_cd = box.getString("SESSION_ROLE_CD");        //ë¡¤ê¶í
			//v_project = request.getParameter(data);
			//System.out.println("I don't know. But");
			//String p_mode;
			//String _mode;
			//p_mode = request.getParameter("text").trim();
			//request.getParameter("year").trim();
			//System.out.println("v_project -->" + v_project);
			//boolean isMaster = false;
			%>			

			<% 
			for(int i=0; i < vProcedure.size(); i++){


			Hashtable ht= (Hashtable)vProcedure.get(i);


			%>
			
	

			
			
			result.push({ group_nm: "",  detail_nm: "", dpt_nm: "", startdt: "", enddt: "", order_nm: "", cost: "", pm: "", cost_cd: "",  plj_nm: "<%=ht.get("PLJ_NM")%>",  edit: ""});
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
        <td colspan="11" class="none" align="center">Data does not exist!!</td>
    </tr>
</script>
	
<script id="tpl_loading" type="text/template">
    <div class="loading"></div>
</script>



<script>

	function fnc_popup() {
	
		//ì´ê³³ì í´ë¹ ì½ë©ì ìë ¥ íì¸ì
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
		
		
		//ì´ê³³ì í´ë¹ ì½ë©ì ìë ¥ íì¸ì
		//var url = "/HDAsan/Mobile/view/pms_detail.jsp";
		var url = "/HDAsan/Pms/new/common/calendar.jsp";

		window.showModalDialog(url, "Modal", "dialogWidth:100px; dialogHeight:170px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		//window.open(url, "modal", "Width=120, Height=180, location=no");    
            
	}	
	
</script>


<script language="javascript">

       //var dsTemp = window.dialogArguments;

        function btn_submit(e) {
        	//alert(e);

        	xtable_1_submit(e);

        }
</script>	


<script language="javascript">

$( function() {

    $( "#datepicker" ).datepicker({

    	showOn:"button",
    	dateFormat:"yy-mm-dd",
    	//setDate: "2018-01-01"
    	//buttonImage:"images/calendar.gif",
    	//buttonImageOnly:true
  } );
    
    $( "#datepicker2" ).datepicker({

    	showOn:"button",
    	dateFormat:"yy-mm-dd",
    	//setDate: "2018-01-01"
    	//buttonImage:"images/calendar.gif",
    	//buttonImageOnly:true
  } );    
} ); 

</script>	


 <script language="javascript">

 jui.ready([ "ui.button" ], function(button) {
	    button_1 = button("#button_1", {
	        type: "check",
	        event: {
	            change: function(data) {
	                var result = "";

	                for(var i = 0; i < data.length; i++) {
	                    if(data[i] != null) {
	                        result += "index(" + data[i].index + "), value(" + data[i].value + ")" + "\n";
	                    }
	                }

	                alert(result);
	            }
	        }
	    });

	});

</script>	


<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
                                   Script ì html body ë¶ë¶ì ê²½ê³ì 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->


<!-- body_start -->
<jsp:include page="/Common/sys/body_s25.jsp"/>

﻿<section>
</br>
	
	<div class="navbar">프로젝트 &nbsp; &nbsp;
	<input type="text" class="input small" id="project")/>

	<button class="btn small" onclick="btn_submit($('#project').val());" id="project">
	    <i class="icon-search"></i> Search
	</button>	
	
	&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;기간
	
	<input type="date" id="datepicker"/>
	&nbsp; ~ &nbsp; 
	<input type="date" id="datepicker2"/>

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



<%

for(int i=0; i < vProcedure.size(); i++){

    Hashtable ht= (Hashtable)vProcedure.get(i);

%>



<%=ht.get("PLJ_NM").toString()%>

<br>

<%
}

%>



<!-- body_end -->
</body>

</html>

