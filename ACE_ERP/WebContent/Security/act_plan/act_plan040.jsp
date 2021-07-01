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
	<!--  ë¡ì»¬ì© -->
	
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
	        		
						alert("등록된 문서가 없습니다.");
						//var url = "/HDAsan/Security/act_plan/act_plan301.jsp";
						
					   	//window.open(url,"memoRead_from","scrollbars=no,toolbar=no,location=no,directories=no,noresize");						

					}else if(e.index == "1"){
						
						alert("등록된 문서가 없습니다.");
						//var url = "/HDAsan/Security/act_plan/act_plan302.jsp";
						
					   	//window.open(url,"memoRead_from","scrollbars=no,toolbar=no,location=no,directories=no,noresize");
						
					}else if(e.index == "2"){
						
						alert("등록된 문서가 없습니다.");
						//var url = "/HDAsan/Security/act_plan/act_plan303.jsp";
						
					   	//window.open(url,"memoRead_from","scrollbars=no,toolbar=no,location=no,directories=no,noresize");					
						
					}else if(e.index == "3"){
						
						alert("등록된 문서가 없습니다.");
						//var url = "/HDAsan/Security/act_plan/act_plan304.jsp";
						
					   	//window.open(url,"memoRead_from","scrollbars=no,toolbar=no,location=no,directories=no,noresize");
						
					}else if(e.index == "4"){
						
						alert("등록된 문서가 없습니다.");
						//var url = "/HDAsan/Security/act_plan/act_plan305.jsp";
						
					   	//window.open(url,"memoRead_from","scrollbars=no,toolbar=no,location=no,directories=no,noresize");				
						
					}				
					

				}

        },
		tpl: {
			row: $("#tpl_row").html(),

		}
    });

    xtable_1_submit = function() {

        var result = [];
        
			result.push({ folder_name : "시설보수"});
			result.push({ folder_name : "영업 및 운영"});
			result.push({ folder_name : "건설공사"});
			result.push({ folder_name : "조직 및 인력"});
			result.push({ folder_name : "대북/대남 협의"});
			
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

<form name="movForm" id="movForm" method="post" action="/HDAsan/Security/act_plan/act_plan010.jsp"> 

<section>

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

