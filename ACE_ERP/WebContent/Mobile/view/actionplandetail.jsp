<%@ page import="Resource.DBManager001" %>
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
    <title>PMS</title>

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
	
	document.movForm.reset();
	//var keyword;
	//var doc_kind;	
	//var app_status;	
	
    xtable_1 = xtable("#xtable_1", {
        fields: [ "info", "doc_no", "doc_knd", "doc_title", "doc_seq", "person", "app_status", "app_no" ],
        colshow: [ 0, 1, 2, 3, 4, 5, 6, 7],
        sort: [ 0, 1, 2, 3, 4, 5, 6, 7],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 10,
		scrollHeight: 320,
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

    xtable_1_submit = function(keyword, doc_kind, app_status) {

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
			String app_status = request.getParameter("app_status_param");
			
			//System.out.println("keyword -->" + keyword);			
			//System.out.println("doc_kind -->" + doc_kind);
			//System.out.println("app_status -->" + app_status);			

			sr_db.setObject("keyword",(Object)keyword);	
			sr_db.setObject("doc_kind",(Object)doc_kind);	
			sr_db.setObject("app_status",(Object)app_status);				
					
			
			DBManager manager_db = new DBManager();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>
			
			result.push({ info: "<%=bean_db.get("info")%>", doc_no: "<%=bean_db.get("doc_no")%>",  doc_knd: "<%=bean_db.get("doc_knd")%>", doc_title: "<%=bean_db.get("doc_title")%>", doc_seq: "<%=bean_db.get("doc_seq")%>", person: "<%=bean_db.get("person")%>", app_status: "<%=bean_db.get("app_status")%>", app_no: "<%=bean_db.get("app_no")%>"});
			
			
		    page = 1;
		    xtable_1.update(result);
		    xtable_1.resize();

			<% 
				} 
	        
	        keyword = "";
	        doc_kind = "";
	        app_status = "";
	        
	        
			%>

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

		window.showModalDialog(url, "Modal", "dialogWidth:870px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		
            
	}
        
</script>
<!------------------------------------------------------------------------------------------------------------------- 
                                  			SelectBox Event
--------------------------------------------------------------------------------------------------------------------->
<script>

</script>



<script id="tpl_row" type="text/template">
    <tr>
        <td align="center"><a class="btn mini" value="edit" onclick="fnc_popup()"><i class="icon-info"></i></a></td>
        <td align="center"><!= doc_no !></td>
        <td align="center"><!= doc_knd !></td>
        <td align="left"><!= doc_title !></td>
        <td align="center"><!= doc_seq !></td>
        <td align="center"><!= person !></td>
        <td align="center"><!= app_status !></td>
        <td align="center"><!= app_no !></td>
    </tr>
</script>
	
<script id="tpl_none" type="text/template">
    <tr>
        <td colspan="8" class="none" align="center">Data does not exist.</td>
    </tr>
</script>
	
<script id="tpl_loading" type="text/template">
    <div class="loading"></div>
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
            	app_status = data.value;
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
jui.ready([ "ui.tab" ], function(tab) {
	
    tab_1 = tab("#tab_1", {
    	
        event: {
        	
            change: function(data) {

            }
        },
        
        target: "#tab_contents_1",
        
        index: 0
        
    });
    
});
</script>

			
<script language="javascript">



        function btn_submit(keyword, doc_kind, app_status) {
        	
            //document.movForm.reset();

            document.movForm.keyword_param.value    = keyword.value;
            document.movForm.doc_kind_param.value   = doc_kind;
            document.movForm.app_status_param.value = app_status;        	
        	
        	
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

<form name="movForm" id="movForm" method="post" action="/HDAsan/Security/act_plan/act_plan002.jsp"> 

 <input type=hidden name="keyword_param">            
 <input type=hidden name="doc_kind_param">
 <input type=hidden name="app_status_param">
     
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
 <!--  
&nbsp;중분류&nbsp;
<div id="combo_2" class="combo">
    <a class="btn small" style="width: 150px;" id="doc_kind2"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul2>
  
    </ul2>
</div>
 -->
 
&nbsp;결재상태&nbsp;
<div id="combo_3" class="combo">
    <a class="btn small" style="width: 100px;" name="app_status"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul>
        <li value="0">전체</li>
        <li value="S">결재상신</li>
        <li value="G">결재진행중</li>
        <li value="Y">결재완료</li>
    </ul>
</div>

&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
<!--  <div id="switch_1" class="switch inner small"></div>-->
&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;






<button class="btn small" onclick="btn_submit(keyword, doc_kind, app_status);">
    <i class="icon-search"></i> Search
</button>

</div>
	
</section>

<br>

<ul id="tab_1" class="tab top">
    <li><a href="#tab1">Document LIST</a></li>  
</ul>
	
<div id="tab_contents_1" style="background: #dcdcdc;">  
	    
<div id="tab1">
	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=2>
        <thead>
        <tr>
            <th width="5%">Info</th>         
            <th>문서번호</th>        
            <th>문서종류</th>          
            <th width="25%">제목</th>
            <th width="5%">차수</th>  
            <th>담당자</th>  
            <th>결재상태</th>              
            <th>결재번호</th>                        
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
	</div>
</div>

<div class="row" align="right" style="text-align: right; margin-top: 3px;">
    <div class="group">
        <button onclick="xtable_1_page(-1);" class="btn mini">Prev</button>
        <button onclick="xtable_1_page(1);" class="btn mini">Next</button>
    </div>
</div>



</body>

</html>

