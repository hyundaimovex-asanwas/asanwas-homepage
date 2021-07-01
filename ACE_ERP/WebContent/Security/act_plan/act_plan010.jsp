<%@ page import="security.common.DBManager001" %>
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
		SmartRequest sr_db= new SmartRequest(request);	

		ArrayList data_db = new ArrayList();	

		int len_db = 0;

		BaseDataClass bean_db;
%>

<!DOCTYPE html>
<meta charset="euc-kr">
<html>
<head>
    <title>Action Plan Folder</title>

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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!--  로컬용 -->
	
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
        fields: [ "folder_name"],
        colshow: [ 0 ],
        sort: [ 0 ],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 50,
		scrollHeight: 520,
        event: {

        	 click:function(e){ 

					if(e.index == "0"){
	        		
						var url = "/HDAsan/Security/act_plan/act_plan020.jsp";
						
					   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");							

					}else if(e.index == "1"){
						
						var url = "/HDAsan/Security/act_plan/act_plan030.jsp";
						
					   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
						
					}else if(e.index == "2"){
						
						var url = "/HDAsan/Security/act_plan/act_plan040.jsp";
						
					   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
						
					}else if(e.index == "3"){
						
						var url = "/HDAsan/Security/act_plan/act_plan050.jsp";
						
					   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
						
					}else if(e.index == "4"){
						
						var url = "/HDAsan/Security/act_plan/act_plan060.jsp";
						
					   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
						
					}				
					

				}

        },
		tpl: {
			row: $("#tpl_row").html(),

		}
    });

    xtable_1_submit = function() {

        var result = [];
        
			result.push({ folder_name : "금강산 관광"});
			result.push({ folder_name : "개성 관광"});
			result.push({ folder_name : "개성 공단"});
			result.push({ folder_name : "조직 및 인력"});
			result.push({ folder_name : "소요자금 및 조달 계획"});
			
		    xtable_1.update(result);

    		}
    var wNm = window.name;
    
    
    alert(wNm);
});

</script>



		
<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 

--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->

<jsp:include page="/Common/sys/body_s25.jsp"/>

<form name="movForm" id="movForm" method="post" action="/HDAsan/Security/act_plan/act_plan010.jsp"> 

﻿<section>

<div class="navbar">

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
            <th>폴더명</th>              
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
					<script id="tpl_row" type="text/template">
    					<tr>
							<td align="center"><!= folder_name !></td>
    					</tr>
					</script>                                                                                                                                                                                                                                                                                 
	</div>

</body>

</html>

