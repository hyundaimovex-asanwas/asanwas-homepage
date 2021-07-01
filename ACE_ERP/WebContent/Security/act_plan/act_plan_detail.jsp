<%@ page import="security.common.DBManager003" %>
<%@ page import="security.common.DBManager0032" %>
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
		boolean isMaster = false;
		
		BaseDataClass bean_db;

		sr_db.setObject("requestedPage",(Object)requestedPage);				
		sr_db.setObject("pageSize",(Object)pageSize);						

%>

<!DOCTYPE html>

<meta charset="euc-kr">

<html>
<head>
    <title>Action Plan Detail</title>

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
        fields: [ "doc_no", "doc_title", "doc_seq", "person", "file_cd" ],
        colshow: [ 0, 1, 2, 3, 4],
        sort: [ 0, 1, 2, 3, 4],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 10,
		scrollHeight: 220,
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

    	//alert("ê°íì¸1 ===="+keyword);    	
    	//alert("ê°íì¸2 ===="+doc_kind);  
    	//alert("ê°íì¸3 ===="+app_status);      	
    	
        var result = [];
        

			<%

			isMaster = true;
			
			if(isMaster) {
				v_group = "0"; 
			}
			
			isMaster = false;
					
			
			//String keyword    = request.getParameter("keyword_param");
			//String doc_kind   = request.getParameter("doc_kind_param");
			//String app_status = request.getParameter("app_status_param");
			
			//System.out.println("keyword -->" + keyword);			
			//System.out.println("doc_kind -->" + doc_kind);
			//System.out.println("app_status -->" + app_status);			

			//sr_db.setObject("keyword",(Object)keyword);	
			//sr_db.setObject("doc_kind",(Object)doc_kind);	
			//sr_db.setObject("app_status",(Object)app_status);				
					
			
			DBManager003 manager_db = new DBManager003();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>
			
			result.push({ doc_no: "<%=bean_db.get("doc_no")%>",  doc_title: "<%=bean_db.get("doc_title")%>", doc_seq: "<%=bean_db.get("doc_seq")%>", person: "<%=bean_db.get("person")%>", app_status: "<%=bean_db.get("app_status")%>", file: "<%=bean_db.get("app_no")%>"});
			
			
		    page = 1;
		    xtable_1.update(result);
		    xtable_1.resize();

			<% 
				} 
	        

	        
	        
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
jui.ready([ "grid.xtable" ], function(xtable) {
	
	var page = 1;
	
	document.movForm.reset();
	
    xtable_2 = xtable("#xtable_2", {
        fields: [ "doc_no", "doc_title", "doc_seq", "person", "file_cd" ],
        colshow: [ 0, 1, 2, 3, 4],
        sort: [ 0, 1, 2, 3, 4],
        sortLoading: true,
		resize: true,
        buffer: "s-page",
        bufferCount: 10,
		scrollHeight: 220,
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
			loading: $("#tpl_loading").html()
		}
    });

    var showEventMessage = function(fields){  
    	alert("[" + fields.getData(fields.index) + "]");

    	 } 

    xtable_2_submit = function(keyword, doc_kind, app_status) {

    	//alert("ê°íì¸1 ===="+keyword);    	
    	//alert("ê°íì¸2 ===="+doc_kind);  
    	//alert("ê°íì¸3 ===="+app_status);      	
    	
        var result = [];
        

			<%

			isMaster = true;
			
			if(isMaster) {
				v_group = "0"; 
			}
			
			isMaster = false;
					
			
			//String keyword    = request.getParameter("keyword_param");
			//String doc_kind   = request.getParameter("doc_kind_param");
			//String app_status = request.getParameter("app_status_param");
			
			//System.out.println("keyword -->" + keyword);			
			//System.out.println("doc_kind -->" + doc_kind);
			//System.out.println("app_status -->" + app_status);			

			//sr_db.setObject("keyword",(Object)keyword);	
			//sr_db.setObject("doc_kind",(Object)doc_kind);	
			//sr_db.setObject("app_status",(Object)app_status);				
					
			
			DBManager0032 manager_db = new DBManager0032();
			data_db		= manager_db.list(sr_db);	
			manager_db.close();			
			
			len_db = data_db.size();
			bean_db = null;		
			
	        for(int h=0; h<len_db; h++) {

	        	bean_db = (BaseDataClass)data_db.get(h);	
	        	
			%>
			
			result.push({ doc_no: "<%=bean_db.get("doc_no")%>",  doc_title: "<%=bean_db.get("doc_title")%>", doc_seq: "<%=bean_db.get("doc_seq")%>", person: "<%=bean_db.get("person")%>", app_status: "<%=bean_db.get("app_status")%>", file: "<%=bean_db.get("app_no")%>"});
			
			
		    page = 1;
		    xtable_2.update(result);


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

        <td align="center"><!= doc_no !></td>
        <td align="left"><!= doc_title !></td>
        <td align="center"><!= doc_seq !></td>
        <td align="center"><!= person !></td>
        <td align="center"><a class="btn mini" value="edit" onclick="fnc_popup()"><i class="icon-clip"></i></a></td>
    </tr>
</script>
	
<script id="tpl_none" type="text/template">
    <tr>
        <td colspan="5" class="none" align="center">Data does not exist.</td>
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

                //ê¸ê°ì°ê´ê´ì¬ê°
                if(data.value = 'A'){
                	
                	//alert(data.text);
                	
                	
           			//$( 'li value = 0').append( '123' );

           			//$( 'ul2' ).append( '<li value=AA>ê´ê´ì´ì2</li>' );
                	
            		//$("<ul>").appendTo("#combo_2");
                	//$("<li value='AA'>ê´ê´ì´ì</li>").appendTo("#combo_2");
                	//$("<li value='AB'>ìì ë° ë§ì¼í</li>").appendTo("#combo_2");
                	//$("<li value='AC'>ìì¤ ê°ë³´ì</li>").appendTo("#combo_2");
                	//$("<li value='AD'>ì¡°ì§ ë° ì¸ë ¥</li>").appendTo("#combo_2");
                	//$("<li value='AE'>íë ¥íì¬</li>").appendTo("#combo_2");
            		//$("</ul>").appendTo("#combo_2");

                	
                //ê°ì±ê´ê´ì¬ê°	
                }else if(data.value = 'B'){
                	
                	alert(data.text);
                	
                //ê°ì±ê³µë¨ì¬ê°	
                }else if(data.value = 'C'){
                	
                	alert(data.text);                	
                	
                //ì¡°ì§ ë° ì¸ë ¥	
                }else if(data.value = 'D'){
                	
                	alert(data.text);                	
                	
                //ìììê¸ ë° ì¡°ë¬ê³í	
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

            //document.movForm.keyword_param.value    = keyword.value;
            //document.movForm.doc_kind_param.value   = doc_kind;
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
            //frm ì´ê¸°í
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

ï»¿<section>

<div class="navbar">KeyWord &nbsp;

<input type="text" class="input small" name="keyword" size="10">

&nbsp;ëë¶ë¥&nbsp;
<div id="combo_1" class="combo">
    <a class="btn small" style="width: 150px;" id="doc_kind"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    
    


    <ul>
        <li value="0">ì ì²´</li>
        <li value="A">ê¸ê°ì°ê´ê´ì¬ê°</li>
        <li value="B">ê°ì±ê´ê´ì¬ê°</li>
        <li value="C">ê°ì±ê³µë¨ì¬ê°</li>
        <li value="D">ì¡°ì§ ë° ì¸ë ¥</li>
        <li value="E">ìììê¸ ë° ì¡°ë¬ê³í</li>      
    </ul>

</div>
 <!--  
&nbsp;ì¤ë¶ë¥&nbsp;
<div id="combo_2" class="combo">
    <a class="btn small" style="width: 150px;" id="doc_kind2"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul2>
  
    </ul2>
</div>
 -->
 
&nbsp;ê²°ì¬ìí&nbsp;
<div id="combo_3" class="combo">
    <a class="btn small" style="width: 100px;" name="app_status"></a>
    <a class="btn small toggle"><i class="icon-arrow2"></i></a>
    <ul>
        <li value="0">ì ì²´</li>
        <li value="S">ê²°ì¬ìì </li>
        <li value="G">ê²°ì¬ì§íì¤</li>
        <li value="Y">ê²°ì¬ìë£</li>
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


	<div id="xtable_1" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=2>
        <thead>
        <tr>
      
            <th>ë¬¸ìë²í¸</th>              
            <th>ì ëª©</th>
            <th>ì°¨ì</th>  
            <th>ë´ë¹ì</th>              
            <th>FILE</th>                        
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
	</div>


<br>


	<div id="xtable_2" class="xtable" style="margin-top: 7px;">
    <table class="table classic hover" border_nm=2>
        <thead>
        <tr>
      
            <th>결재번호</th>              
            <th>결재상태</th>
            <th>성명</th>  
            <th>일시</th>              
                       
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
	</div>



</body>

</html>

