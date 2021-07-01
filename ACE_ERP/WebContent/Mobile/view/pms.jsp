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
    <!--
    <link rel="stylesheet" href="/Mobile/lib/jquery.mobile.flatui.css" />
    <link rel="stylesheet" href="/Mobile/lib/mobipick.css" />
    
      <script data-main="/Mobile/lib/app" src="/Mobile/lib/require.js"></script>-->
 
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
	
<!--	

	<script src="/Mobile/controller/nomu.js?v5"></script>
	<link rel="stylesheet" href="/Mobile/lib/common.css" />
	
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/core.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.js"></script>
-->

	<!--  로컬용 
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	 
	<script src="../../Resource/node_modules/jui/lib/core.min.js"></script>
	<script src="../../Resource/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../Resource/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../Resource/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../Resource/node_modules/jui/lib/jui/js/ui.min.js" ></script>
	-->
	
	<!--  운영용 -->
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.min.css" />	
	
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/core.min.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/jui/js/ui.min.js" ></script>
	
	
<!--

	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid.min.css" />	
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	<link rel="stylesheet" href="../../Resource/node_modules/jui-grid/lib/qunit-1.14.0.css">	
	
	<script src="../../Resource/node_modules/jui-grid/lib/core.js"></script>
	<script src="../../Resource/node_modules/jui-grid/lib/jquery-1.8.0.min.js"></script>
	<script src="../../Resource/node_modules/jui-grid/lib/qunit-1.14.0.js"></script>		
	<script src="../../Resource/node_modules/jui-grid/dist/grid.js"></script>
<!--  
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
-->




</head>



<!------------------------------------------------------------------------------------------------------------------- 
                                  			참고 용도
                                  			
//onclick="win_2.show()
//	        <input type="text" id="colorcode_1" class="input" style="width: 118px;" />
--------------------------------------------------------------------------------------------------------------------->




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
		scrollHeight: 450,
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
			//String status = request.getParameter("STATUS");        		//품의번호
			//String role_cd = box.getString("SESSION_ROLE_CD");         //롤권한
			//String p_mode = request.getParameter("text");
			//System.out.println("I don't know. But");
			//String p_mode = text;
			//String _mode;
			//p_mode = request.getParameter("text").trim();
			//request.getParameter("year").trim();
			//System.out.println("p_mode -->" + p_mode);
			//boolean isMaster = false;
			%>			

			
		if(text == "관광"){
		
			<%
			
			isMaster = true;
			
			if(isMaster) {
				v_group = "01"; 
			}
			isMaster = false;
					
			sr_db.setObject("v_group",(Object)v_group);	

			DBManager manager_db1 = new DBManager();
			data_db1		= manager_db1.list(sr_db);								
			manager_db1.close();			
			
			len_db = data_db1.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db1.get(h);	
	        	
			%>
			
			result.push({ group_nm: "<%=bean_db.get("group_nm")%>",  detail_nm: "<%=bean_db.get("detail_nm")%>", dpt_nm: "<%=bean_db.get("dpt_nm")%>", startdt: "<%=bean_db.get("startdt")%>", enddt: "<%=bean_db.get("enddt")%>", order_nm: "<%=bean_db.get("order_nm")%>", cost: "<%=bean_db.get("cost")%>", pm: "<%=bean_db.get("pm")%>", cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>",  edit: "<%=bean_db.get("edit")%>"});
			xtable_1.update(result);

			<% 
				} 
			%>
			

		}else if(text == "MICE"){
			
			<%
			
			isMaster = true;
			
			if(isMaster) {
				v_group = "02"; 
			}
			isMaster = false;

			sr_db.setObject("v_group",(Object)v_group);	

			DBManager manager_db2 = new DBManager();
			data_db2	= manager_db2.list(sr_db);								
			manager_db2.close();			
			
			len_db = data_db2.size();
			bean_db = null;		

	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db2.get(h);	
	        	
			%>
			
			result.push({ group_nm: "<%=bean_db.get("group_nm")%>",  detail_nm: "<%=bean_db.get("detail_nm")%>", dpt_nm: "<%=bean_db.get("dpt_nm")%>", startdt: "<%=bean_db.get("startdt")%>", enddt: "<%=bean_db.get("enddt")%>", order_nm: "<%=bean_db.get("order_nm")%>", cost: "<%=bean_db.get("cost")%>", pm: "<%=bean_db.get("pm")%>", cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>",  edit: "<%=bean_db.get("edit")%>"});
			xtable_1.update(result);

			<% 
				}       
			%>
		
		}else if(text == "건설"){

			<%
			
			isMaster = true;
			
			if(isMaster) {
				v_group = "03"; 
			}
			isMaster = false;
					
			sr_db.setObject("v_group",(Object)v_group);	

			DBManager manager_db3 = new DBManager();
			data_db3		= manager_db3.list(sr_db);								
			manager_db3.close();			
			
			len_db = data_db3.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db3.get(h);	
	        	
			%>
			
			result.push({ group_nm: "<%=bean_db.get("group_nm")%>",  detail_nm: "<%=bean_db.get("detail_nm")%>", dpt_nm: "<%=bean_db.get("dpt_nm")%>", startdt: "<%=bean_db.get("startdt")%>", enddt: "<%=bean_db.get("enddt")%>", order_nm: "<%=bean_db.get("order_nm")%>", cost: "<%=bean_db.get("cost")%>", pm: "<%=bean_db.get("pm")%>", cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>",  edit: "<%=bean_db.get("edit")%>"});
			xtable_1.update(result);

			<% 
				} 
			%>
			
		}else if(text == "ODA"){
		
			<%
			
			isMaster = true;
			
			if(isMaster) {
				v_group = "04"; 
			}
			isMaster = false;
					
			sr_db.setObject("v_group",(Object)v_group);	

			DBManager manager_db4 = new DBManager();
			data_db4		= manager_db4.list(sr_db);								
			manager_db4.close();			
			
			len_db = data_db4.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db4.get(h);	
	        	
			%>
			
			result.push({ group_nm: "<%=bean_db.get("group_nm")%>",  detail_nm: "<%=bean_db.get("detail_nm")%>", dpt_nm: "<%=bean_db.get("dpt_nm")%>", startdt: "<%=bean_db.get("startdt")%>", enddt: "<%=bean_db.get("enddt")%>", order_nm: "<%=bean_db.get("order_nm")%>", cost: "<%=bean_db.get("cost")%>", pm: "<%=bean_db.get("pm")%>", cost_cd: "<%=bean_db.get("cost_cd")%>",  plj_nm: "<%=bean_db.get("plj_nm")%>",  edit: "<%=bean_db.get("edit")%>"});
			xtable_1.update(result);

			<% 
				} 
			%>
			
		}else{

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

    }
});

</script>



<script>
/********************************************
* 											*
********************************************/
	function fnc_popup() {
	
		//이곳에 해당 코딩을 입력 하세요
		//var url = "/HDAsan/Mobile/view/pms_detail.jsp";
		var url = "/Mobile/view/pms_detail.jsp";

		//window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		window.open(url, "modal", "Width=600, Height=350, location=no");    
            
	}
        
</script>
<!------------------------------------------------------------------------------------------------------------------- 
                                  			SelectBox Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "ui.select" ], function(SelectBox) {

	var items = [
		{ value : '01', text : '관광' } ,
		{ value : '02', text : 'MICE' } ,
		{ value : '04', text : 'ODA' },


	];

	window.themeList  = new SelectBox('.theme-list', {
		items : items,
		placeholder: '사업 구분',
		event : {
			change : function (value) {
				//console.log(value);
			}
		}
	});

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



<!------------------------------------------------------------------------------------------------------------------- 
                                  			Autocomplete Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "ui.autocomplete" ], function(autocomplete) {
    ac_1 = autocomplete("#ac_1", {
        target: "input[type=text]",
        words: [
            "관광",
            "MICE",
            "건설",
            "ODA"
        ],
        event: {
            change: function(text) {

            	xtable_1_submit(text);

            }
        }
    });
});
</script>

<script data-jui="#ac_1" data-tpl="words" type="text/template">
    <div class="dropdown">
        <ul>
            <! for(var i = 0; i < words.length; i++) { !>
            <li><!= words[i] !></li>
            <! } !>
        </ul>
    </div>
</script>




<!------------------------------------------------------------------------------------------------------------------- 
                                  			Button Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "ui.button" ], function(button) {
	
    button = button("#btn", {
        
 
        event: {
            click: function(data,e) {

                alert("111");
                
            }
        }
    });
    
    
    
    button mini = button("#button mini", {
        
    	 
        event: {
            click: function(data,e) {

                alert("222");
                
            }
        }
    });
    
    
});
</script>






<script language="javascript">


       var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function btn_submit() {


        	xtable_1_submit();

        }



</script>			
			
<!------------------------------------------------------------------------------------------------------------------- 
                                  				Tab Event
--------------------------------------------------------------------------------------------------------------------->
<script language="javascript">		
jui.ready([ "ui.tab" ], function(tab) {
    tab_1 = tab("#tab_1", {
        event: {
            change: function(data) {
                //alert(data.text);
            }
        },
        target: "#tab_contents_1",
        index: 0
    });
});
</script>

			
<!------------------------------------------------------------------------------------------------------------------- 
                                  				Window Event
--------------------------------------------------------------------------------------------------------------------->			
<script language="javascript">	
jui.ready([ "ui.window" ], function(win) {
	

    win_2 = win("#win_2", {


    	
    });


    //window.open("/HDAsan/Mobile/view/pms_detail.jsp", "modal", "Width=600, Height=350, location=no");
    
	/*
    win_2 = win("#win_2", {
        width: 600,
        height: 320,
        modal: true
    });
	*/
    
    
});				
</script>	
			
			
<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
                                   Script 와 html body 부분의 경계선
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->



<body class="jui" onload="xtable_1_submit()">

    <div id="pagePMS" data-role="page">
        <div data-role="panel" id="menu">
            <ul id="listMenu" data-role="listview" data-theme="a">
            </ul>
        </div>
        <div data-role="header">
			<a href="#menu" data-icon="bars" data-iconpos="notext">Menu</a>
            <h4>PROJECT LIST</h4>
        </div>
    </div>
    
    <br><br><br>



<div id="ac_1" class="group">
    <label class="label"><i class="icon-search"></i></label>
    <input type="text" class="input" style="width: 200px" />
   
</div>



<button class="btn" onclick="btn_submit()">
    <i class="icon-play"></i> Run
</button>
 &nbsp;Plz Click if you want more
<!--  
<div>
	<table border_nm=0>
		<tr>
			<td width="300" align="right">
				<a class="btn">RUN</a>
			</td>
		</tr>
	</table>
</div>



	<style type="text/css">
		.select-container {
			width:500px;
			height:150px;
			overflow:auto;
			border_nm:3px solid #ececec;
		}
	
		.select-container h1 {
			color:#333;
			margin-top:10px;
			margin-bottom:10px;
			border_nm-bottom:0px;
		}
	</style>
	<div class="select-container">
		<div>
			<div  class="theme-list"></div>
		</div>
	</div>
-->

	<ul id="tab_1" class="tab top">
	    <li><a href="#tab1">PROJECT</a></li>
	    <li><a href="#tab2">COST</a></li>
	    <li><a href="#tab3">DAILY</a></li>
	</ul>
	
	
	
	
<div id="tab_contents_1" style="background: #dcdcdc;"> <!-- 탭 div Start --> 
	    




<div id="tab1">
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

<!--  
	<div id="win_1" class="window">
	    <div class="head">
	        <div class="left">세부정보</div>
	        <div class="right">
	            <a href="#" class="close"><i class="icon-exit"></i></a>
	        </div>
	    </div>
	    <div class="body">

				<div id="xtable_1" class="xtable" style="margin-top: 7px;">
			    <table class="table classic hover" border=1>
			        <thead>
			        <tr> 

				        <th width="30%"> 
	       					
				        </th>
				        <th> 
	       					
				        </th>				        				        
			        </tr>			        
			        
			        </thead>
			        
			        <tbody>
			        <tr> 
				        <td width="30%" align=center> 
	       					코드
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					프로젝트
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					시작일
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>			        			        
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					종료일
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					발주처
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>			        
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					도급액
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>	
			        
			        <tr> 
				        <td width="30%" align=center> 
	       					수행PM
				        </td>
				        <td> 
	       					
				        </td>				        
			        </tr>				        
			        
			        </tbody>
			        
			        
			    </table>
				</div>
				
	    </div>
 
	    <div class="foot" align="center">
	        <a href="#" class="btn focus">Save</a> 
	        <a href="#" class="btn" onclick='win_2.hide()'>Close</a>
	    </div>

	</div>-->
</div>


<div id="tab2">2번째 TAB</div>
	    
	    
<div id="tab3">3번째 TAB</div>




</div> <!-- 탭 div End --> 

</body>


</html>

