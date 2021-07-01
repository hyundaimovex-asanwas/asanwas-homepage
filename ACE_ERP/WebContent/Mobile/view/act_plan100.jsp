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
     								
					var url = "/Mobile/view/act_plan101.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");							
					
				}else if(e.index == "1"){
					
					var url = "/Mobile/view/act_plan102.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
					
				}else if(e.index == "2"){
					
					var url = "/Mobile/view/act_plan103.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
					
				}else if(e.index == "3"){
					
					var url = "/Mobile/view/act_plan104.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
					
				}else if(e.index == "4"){
					
					var url = "/Mobile/view/act_plan105.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");					

				}else if(e.index == "5"){
					
					var url = "/Mobile/view/act_plan106.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
					
				}else if(e.index == "6"){
					
					var url = "/Mobile/view/act_plan107.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
					
				}else if(e.index == "7"){
					
					var url = "/Mobile/view/act_plan108.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
					
				}else if(e.index == "8"){
					
					var url = "/Mobile/view/act_plan109.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
					
				}else if(e.index == "9"){
					
					var url = "/Mobile/view/act_plan110.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");	
					
				}else if(e.index == "10"){
					
					var url = "/Mobile/view/act_plan111.jsp";
				   	window.open(url,"memoRead_from","scrollbars=yes,toolbar=no,location=no,directories=yes");						
					
				}else if(e.index == "11"){
					
					var url = "/Mobile/view/act_plan112.jsp";
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
        
		result.push({ folder_name : "관광일정"});
		result.push({ folder_name : "출입경"});
		result.push({ folder_name : "숙박"});
		result.push({ folder_name : "식음"});
		result.push({ folder_name : "교예공연"});
		result.push({ folder_name : "온천"});
		result.push({ folder_name : "판매"});
		result.push({ folder_name : "관광버스(45인승)"});
		result.push({ folder_name : "관광버스(33인승)"});
		result.push({ folder_name : "기타차량 장비"});
		result.push({ folder_name : "통신"});
		result.push({ folder_name : "관광조장"});
		
	    xtable_1.update(result);

    	}

});

</script>


<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 

--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->

<jsp:include page="/Common/sys/body_s25.jsp"/>

<form name="movForm" id="movForm" method="post" action="/Mobile/view/act_plan100.jsp"> 

﻿<section>
	
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
            <th align="center">폴더명</th>              
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

