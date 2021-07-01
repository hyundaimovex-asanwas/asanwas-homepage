<%@ page import="Resource.DBManager101" %>
<%@ page import="sales.common.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>

<%	
		SmartRequest sr_db= new SmartRequest(request);	
		ArrayList data_db = new ArrayList();	
		int len_db = 0;
		BaseDataClass bean_db;
%>

<!DOCTYPE html>
<meta charset="euc-kr">
<html>
<head>
    <title>Action Plan</title>
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
    var cd_gbn;
	document.movForm.reset();
	
    xtable_1 = xtable("#xtable_1", {
        fields: [ "doc_status", "doc_nm1", "doc_nm2", "doc_nm3" ,"doc_title", "eno_nm", "ipt_ymd","file_key","file_name"],
        colshow: [ 0, 1, 2, 3, 4, 5, 6, 7, 8],
        sort: [ 0, 1, 2, 3, 4, 5, 6, 7, 8],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 50,
		scrollHeight: 520,
        event: {

        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),

		}
    });


    xtable_1_submit = function() {

        var result = [];
        
			<%

			String menu_seq    = "DB01";

			sr_db.setObject("menu_seq",(Object)menu_seq);				
			
			DBManager101 manager_db = new DBManager101();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {
	        	bean_db = (BaseDataClass)data_db.get(h);	
			%>
			
			result.push({ doc_status: "<%=bean_db.get("doc_status")%>", doc_nm1: "<%=bean_db.get("doc_nm1")%>", doc_nm2: "<%=bean_db.get("doc_nm2")%>", doc_nm3: "<%=bean_db.get("doc_nm3")%>", doc_title: "<%=bean_db.get("doc_title")%>", eno_nm: "<%=bean_db.get("eno_nm")%>", ipt_ymd: "<%=bean_db.get("ipt_ymd")%>", file_key: "<%=bean_db.get("file_key")%>", file_name: "<%=bean_db.get("file_name")%>"});

		    xtable_1.update(result);

			<% 
			} 
			%>

    		}

});
</script>

<script>
function func_Popup(file_key) {

	var url = "/Mobile/view/actionplanfile.jsp?file_key="+file_key;
   	window.open(url,"memoRead_from","width=600,height=150,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");		
	
}
</script>
	
<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 

--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->

<jsp:include page="/Common/sys/body_s25.jsp"/>

<form name="movForm" id="movForm" method="post" action="/Mobile/view/act_plan402.jsp">       

﻿<section>
<div class="navbar">조직 및 인력 - 조직체계
</div>
</section>

<br>

<div class="notify danger">
    <div class="image"><i class="icon-caution" style="font-size: 18px;"></i></div>
    <div class="title">Notification message</div>    
	<div class="message" width="50%"> * 보안을 위해 모든 사용 내역은 기록됩니다.</div>
</div>

<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=2>
        <thead>
        <tr>   
            <th width="10%">상황</th>  
            <th>대분류</th>              
            <th>중분류</th>    
            <th>세부분류</th>     
            <th width="20%">제목</th>   
            <th width="15%">작성자</th>    
            <th>작성일</th>   
            <th>FILE</th>   
            <th width="1%"></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>

					<script id="tpl_row" type="text/template">
    					<tr>
							<td align="center">
							<! if(row.data["doc_status"] == "G") {   !>
									<span style="background-color: #FFF000;">진행중</span>
							<! }else if(row.data["doc_status"] == "Y"){ !>
									<span style="background-color: #1DDB16;">완료</span>
							<! }else if(row.data["doc_status"] == "R"){ !>
									<span style="background-color: #FF0000;">HELP</span>
							<! } !>
							</td>
							
							<td align="center"><!= row.data["doc_nm1"] !></td>
							<td align="center"><!= row.data["doc_nm2"] !></td>
							<td align="center"><!= row.data["doc_nm3"] !></td>
							<td align="center"><!= doc_title !></td>
							<td align="center"><!= eno_nm !></td>'<!= file_key !>'
							<td align="center"><!= ipt_ymd !></td>
        					<td align="center"><a class="btn mini" value="download" onclick="func_Popup('<!= file_key !>')"><i class="icon-save"></i></a>  </td> 
        					<td align="center"></td> 
    					</tr>
					</script>                                                                                                                                                  
                                                                                                                                                                      
 					<script id="tpl_none" type="text/template">                                                                                                
 						<tr>                                                                                                                                                     
 							<td colspan="9" class="none" align="center">Data does not exist.</td>                                      
 						</tr>                                                                                                                                                   
 					</script>                                                                                                                                                      

</div>

</body>

</html>

