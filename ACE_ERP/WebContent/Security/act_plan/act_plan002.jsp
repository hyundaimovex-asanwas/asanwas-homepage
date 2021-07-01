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
		String dirPath = request.getContextPath(); //HDASan

	    //java.util.Calendar date = java.util.Calendar.getInstance();
	    //ava.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	    //String strD 		= m_today.format(date.getTime());
		//String gusrid		= (String)session.getAttribute("vusrid");
		//String gusrnm		= (String)session.getAttribute("vusrnm");
		//String gusrpos	= (String)session.getAttribute("vusrpos");	
		//String gusrip		= (String)session.getAttribute("vusrip");	

		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "15";  	
		String v_group;
		String color1;
		
		SmartRequest sr_db= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	  = "15";  		
		v_group 	  = "0";

	
		
		
		ArrayList data_db = new ArrayList();	

		
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
    <title>Action Plan</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    
    <meta http-equiv="Content-Type" content="text/html;charset=euc-kr" />
    <!--
    <link rel="stylesheet" href="/Mobile/lib/jquery.mobile.flatui.css" />
    <link rel="stylesheet" href="/Mobile/lib/mobipick.css" />
    
      <script data-main="/Mobile/lib/app" src="/Mobile/lib/require.js"></script>-->
 
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
	
	
	
<!--  
	<script src="/Mobile/controller/nomu.js?v5"></script>
	<link rel="stylesheet" href="/Mobile/lib/common.css" />
-->	
	
<!--  	
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.min.css" />
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/lib/core.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.js"></script>
-->

<!--  
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
	
<!--  
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui/dist/ui-jennifer.min.css" />	
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.css" />
	<link rel="stylesheet" href="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid-jennifer.min.css" />	
	
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/core.min.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/dist/ui.min.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui-grid/dist/grid.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/qunit-1.14.0.js"></script>
	<script src="../../node/lib/node_modules/npm/node_modules/jui/lib/jui/js/ui.min.js" ></script>
-->	

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
-->
	
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
                                  			Xtable Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "grid.xtable" ], function(xtable) {
	
	var page = 1;
    var cd_gbn;
	document.movForm.reset();
	//var keyword;
	//var doc_kind;	
	//var app_status;	
	
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
             //colmenu: function(column, e) { this.showColumnMenu(e.pageX - 25);}
        	 click:function(e){ 

        		 						//alert(e.data["file_key"]);
        		 						//alert(e.index); 
										func_Popup(e.data["file_key"], e.data["file_name"]);

					}
             
             
             
             
        },
		tpl: {
			row: $("#tpl_row").html(),
			none: $("#tpl_none").html(),
			loading: $("#tpl_loading").html()
		}
    });


    //{ type : 'colors', title : 'Many Colors', key : 'colors', value : ['#ff0000', '#00ffff', '#ff00ff'], description : 'many colors'} 
    
	//{ type : 'colors', title : 'Many Colors', key : 'colors', value : ['#ff0000', '#00ffff', '#ff00ff'], description : 'many colors'},
	//{ type : 'color', title : 'Background Color', key : 'background-color', value : '', description : 'All CSS color formats are supported, like rgba() or hsl().' },

    
    var showEventMessage = function(fields){  
    	alert("[" + fields.getData(fields.index) + "]");

    	 } 

    xtable_1_submit = function(keyword, doc_kind) {

    	
    	
    	
    	
    	//alert("값확인1 ===="+keyword);    	
    	//alert("값확인2 ===="+doc_kind);  
    	//alert("값확인3 ===="+app_status);      	
    	
        var result = [];
        

			<%

			isMaster = true;
			
			if(isMaster) {
				v_group = "0"; 
			}
			
			isMaster = false;
					
			
			String keyword    = request.getParameter("keyword_param");
			String doc_kind   = request.getParameter("doc_kind_param");
			
			//String color1;
			//String app_status = request.getParameter("app_status_param");
			
			//System.out.println("keyword -->" + keyword);			
			//System.out.println("doc_kind -->" + doc_kind);
			//System.out.println("app_status -->" + app_status);			

			sr_db.setObject("keyword",(Object)keyword);	
			sr_db.setObject("doc_kind",(Object)doc_kind);	
			//sr_db.setObject("app_status",(Object)app_status);				
					
			
			DBManager001 manager_db = new DBManager001();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>
			
			result.push({ doc_status: "<%=bean_db.get("doc_status")%>", doc_nm1: "<%=bean_db.get("doc_nm1")%>", doc_nm2: "<%=bean_db.get("doc_nm2")%>", doc_nm3: "<%=bean_db.get("doc_nm3")%>", doc_title: "<%=bean_db.get("doc_title")%>", eno_nm: "<%=bean_db.get("eno_nm")%>", ipt_ymd: "<%=bean_db.get("ipt_ymd")%>", file_key: "<%=bean_db.get("file_key")%>", file_name: "<%=bean_db.get("file_name")%>"});
			
		

			
		    //page = 1;

		    xtable_1.update(result);
		    //xtable_1.resize();

			

		    
			<% 
			
	        //color1 = bean_db.get("status");
			//System.out.println("color1 -->" + color1);
			

			
			} 
	        
	        
	        

	        keyword = "";
	        doc_kind = "";
	        //app_status = "";
	        
	        
			%>
			
    		//prompt(this, result);
    		
    		



			
    		}

    

    
	    	xtable_1_page = function(no) {
	        page += no;
	        page = (page < 1) ? 1 : page;
	        xtable_1.page(page);
	        
	        

	        
	    	}
			
    
	    	
});

</script>


<script>
/********************************************
* 											*
********************************************/
	function fnc_popup() {
	
		var doc_no;
	
		var url = "/HDAsan/Security/act_plan/act_plan002.jsp?doc_no=";

		window.showModalDialog(url, "Modal", "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		
            
	}
        
</script>
<!------------------------------------------------------------------------------------------------------------------- 
                                  			SelectBox Event
                                  			
        <td align="center"><a class="btn mini" value="edit" onclick="fnc_popup()"><i class="icon-info"></i></a></td>                                  			
	        <td align="center"><!= doc_nm1 !></td>
        <td align="center"><!= DOC_NM2 !></td>
        <td align="center"><!= DOC_NM3 !></td>
        <td align="center"><!= DOC_TITLE !></td>
--------------------------------------------------------------------------------------------------------------------->
<script>

function func_Popup(file_key, file_name) {

	var url = "/HDAsan/Security/act_plan/act_plan003.jsp?file_key="+file_key;

	window.showModalDialog(url, "Modal", "dialogWidth:600px; dialogHeight:150px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
	
}

</script>



			
				
<!------------------------------------------------------------------------------------------------------------------- 
                                  			SelectBox Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "ui.combo" ], function(combo) {
    combo_1 = combo("#combo_1", {
        index: 0,
        event: {
            change: function(data) {
                //alert("text(" + data.text + "), value(" + data.value + ")");

                doc_kind = data.value;

                //금강산관광재개
                if(data.value = 'A'){
                	
                	//alert(data.text);
                	
                	
           			//$( 'li value = 0').append( '123' );

           			//$( 'ul2' ).append( '<li value=AA>관광운영2</li>' );
                	
            		//$("<ul>").appendTo("#combo_2");
                	//$("<li value='AA'>관광운영</li>").appendTo("#combo_2");
                	//$("<li value='AB'>영업 및 마케팅</li>").appendTo("#combo_2");
                	//$("<li value='AC'>시설 개보수</li>").appendTo("#combo_2");
                	//$("<li value='AD'>조직 및 인력</li>").appendTo("#combo_2");
                	//$("<li value='AE'>협력회사</li>").appendTo("#combo_2");
            		//$("</ul>").appendTo("#combo_2");

                	
                //개성관광재개	
                }else if(data.value = 'B'){
                	
                	alert(data.text);
                	
                //개성공단재개	
                }else if(data.value = 'C'){
                	
                	alert(data.text);                	
                	
                //조직 및 인력	
                }else if(data.value = 'D'){
                	
                	alert(data.text);                	
                	
                //소요자금 및 조달계획	
                }else if(data.value = 'E'){
                	
                	alert(data.text);                	
                	
                }
                

            }
        }
    });
});
</script>

<script>
jui.ready([ "ui.window" ], function(win) {
	
	
    file_win = win("#file_win", {
        width: 500,
        height: 200,
        modal: true
    });
    

    
});
</script>






<script>
jui.ready([ "ui.combo" ], function(combo) {
    combo_2 = combo("#combo_2", {
        index: 0,
        event: {
            change: function(data) {
                //alert("text(" + data.text + "), value(" + data.value + ")");
                
                
                
                
            }
        }
    });
});
</script>


<script>
jui.ready([ "ui.combo" ], function(combo) {
    combo_3 = combo("#combo_3", {
        index: 0,
        event: {
            change: function(data) {
                //alert("text(" + data.text + "), value(" + data.value + ")");
            	//app_status = data.value;
            }
        }
    });
});
</script>


<!------------------------------------------------------------------------------------------------------------------- 
                                  			Button Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "ui.button" ], function(button) {
	
    button = button("#btn", {
        
        event: {
            click: function(data,e) {
                alert("btn");
            }
        }
    });
    
    button small= button("##button small", {
        
        event: {
            click: function(data,e) {
                alert("small");
            }
        }
    });    
    
    button mini = button("#button mini", {

        event: {
            click: function(data,e) {
                alert("mini");
            }
        }
    });
    
});
</script>



<!------------------------------------------------------------------------------------------------------------------- 
                                  				Tab Event
--------------------------------------------------------------------------------------------------------------------->


			
<script language="javascript">



        function btn_submit(keyword, doc_kind) {
        	
            //document.movForm.reset();

            document.movForm.keyword_param.value    = keyword.value;
            document.movForm.doc_kind_param.value   = doc_kind;
            //document.movForm.app_status_param.value = app_status;        	
        	
        	
        	//alert("keyword ========" + keyword.value);
        	//alert("doc_kind ========" + doc_kind.value);        	
        	//alert("app_status ========" + app_status); 
        	//var kkk = keyword.value;
        	//var qqq = doc_kind;        	
        	//<form name="movForm" id="movForm" method="post" action="">
        	//<input name="keyword" type="hidden" value="#keyword"/>
        	//<input name="doc_kind" type="hidden" value=#doc_kind/>
        	//<input name="app_status" type="hidden" value='#doc_kind'/>
        	//<form action="/HDAsan/Security/act_plan/act_plan002.jsp" method="post">
        	//movForm.target = "por"; // iframe
        	//movForm.action = "./act_plan002.jsp?keyword="+kkk+"&doc_kind=" +doc_kind + "&app_status="+app_status;
        	//url = "./act_plan002.jsp?keyword="+kkk+"&doc_kind=" +doc_kind + "&app_status="+app_status;
        	//prompt(this,movForm.action);
        	//movForm.submit();        	
            //frm 초기화
            //document.movForm.c_terminal_id.value       = c_terminal_id;        	
            //<form name="acc_frm" method=post target="acc_iframe">
            //<input type=hidden name="c_pay_gubn">
            //<input type=hidden name="c_pay_manage_no">
            //<input type=hidden name="c_van_cd">
            //<input type=hidden name="c_pay_amt">
            //<input type=hidden name="c_acct_join_no">            
        	//var url = "/HDAsan/Security/act_plan/act_plan002.jsp?keyword="+kkk+"&doc_kind=" +doc_kind + "&app_status="+app_status;
        	//alert(url);
        	//window.location.href =  url;//
        	//alert("18");
			//var url = "/HDAsan/Security/act_plan/act_plan002.jsp?keyword="+kkk+"&doc_kind=" +doc_kind + "&app_status="+app_status;
			//alert(url);
			//window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        	//xtable_1_submit(keyword, doc_kind, app_status);
        	
        }
</script>				
			
<!------------------------------------------------------------------------------------------------------------------- 
                                  				Window Event
--------------------------------------------------------------------------------------------------------------------->			
<script language="javascript">	
jui.ready([ "ui.window" ], function(win) {
	
    win_2 = win("#win_2", {

    });

});				
</script>	
			
			
<!------------------------------------------------------------------------------------------------------------------- 
                                  				Window Event
--------------------------------------------------------------------------------------------------------------------->			
<script language="javascript">		
jui.ready([ "ui.switch" ], function(button) {
    switch_1 = button("#switch_1", {
        //checked: false
 
    });

});			
</script>	

			
<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 

--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->

<jsp:include page="/Common/sys/body_s25.jsp"/>

<form name="movForm" id="movForm" method="post" action="/HDAsan/Security/act_plan/act_plan001.jsp"> 

 <input type=hidden name="keyword_param">            
 <input type=hidden name="doc_kind_param">
 <!--  <input type=hidden name="app_status_param"> -->
     
<br>

﻿<section>

<div class="navbar">KeyWord &nbsp;

<input type="text" class="input small" name="keyword" size="10">

&nbsp;대분류&nbsp;
<div id="combo_1" class="combo">
    <a class="btn small" style="width: 150px;" id="doc_kind"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul>
        <li value="0">전체</li>
        <li value="A">금강산관광재개</li>
        <li value="B">개성관광재개</li>
        <li value="C">개성공단재개</li>
        <li value="D">조직 및 인력</li>
        <li value="E">소요자금 및 조달계획</li>      
    </ul>
</div>



&nbsp;중분류&nbsp;
<div id="combo_2" class="combo">
    <a class="btn small" style="width: 150px;" id="doc_kind2"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul2>
  
    </ul2>
</div>

 


&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
<!--  <div id="switch_1" class="switch inner small"></div>-->
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;






<button class="btn small" onclick="btn_submit(keyword, doc_kind);">
    <i class="icon-search"></i> Search
</button>

</div>
	
</section>

<br>




<!--  
<div id="tab_contents_1" style="background: #dcdcdc;">  
-->
    <div class="notify info">
		<div class="message"> * 클릭하시면 File을 Download 받으실 수 있습니다.</div>
	</div>


	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=2>
        <thead>
        
        <tr>   
            <th width="5%">상황</th>  
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
							<td align="center" onclick="func_Popup();">
							<! if(row.data["doc_status"] == "G") {   !>
									<span style="background-color: #1DDB16;">진행중</span>
							<! }else if(row.data["doc_status"] == "Y"){ !>
									<span style="background-color: #FFF000;">완   료</span>
							<! }else if(row.data["doc_status"] == "R"){ !>
									<span style="background-color: #FF0000;">HELP</span>
							<! } !>
							</td>
							
							<td align="center"><!= row.data["doc_nm1"] !></td>
							<td align="center"><!= row.data["doc_nm2"] !></td>
							<td align="center"><!= row.data["doc_nm3"] !></td>
							<td align="center"><!= doc_title !></td>
							<td align="center"><!= eno_nm !></td>
							<td align="center"><!= ipt_ymd !></td>

        					<td align="center">
        							<a class="btn mini" value="download"><i class="icon-save"></i></a>  
							</td> 

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

