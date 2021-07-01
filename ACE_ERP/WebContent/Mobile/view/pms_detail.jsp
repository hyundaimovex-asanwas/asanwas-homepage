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
    <title>PMS DETAIL</title>

    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

	<!--  개발용
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
	

</head>



<!------------------------------------------------------------------------------------------------------------------- 
                                  			i°¸e³? i?ⓒe??
                                  			
//onclick="win_2.show()
//<input type="text" id="colorcode_1" class="input" style="width: 118px;" />
--------------------------------------------------------------------------------------------------------------------->




<!------------------------------------------------------------------------------------------------------------------- 
                                  			Xtable Event
--------------------------------------------------------------------------------------------------------------------->
<script>
jui.ready([ "grid.xtable" ], function(xtable) {
    xtable_0 = xtable("#xtable_0", {
        fields: [ "group_nm", "detail_nm", "dpt_nm", "startdt", "enddt", "order_nm", "cost", "pm", "cost_cd", "plj_nm", "edit" ],
        colshow: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        sort: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        sortLoading: true,
		resize: true,
        buffer: "scroll",
        bufferCount: 50,
		scrollHeight: 450,
        event: {

        	 click:function(e){ 
        		 						//alert(e.data);
        		 						//alert(date.value); 
        		 						//alert(e.pageX); 
        	 							//showEventMessage(fields);  
        	 						}
    

        },

    });

    



    xtable_1_submit = function(text) {

        var result = [];

		if(text == "1111?"){

		}else if(text == "MICE"){
		
		}else if(text == "22222"){

		}else if(text == "ODA"){

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

<!------------------------------------------------------------------------------------------------------------------- 
                                  			SelectBox Event
--------------------------------------------------------------------------------------------------------------------->
<script>

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
        <td align="center"><a class="btn mini" value="edit" onclick="win_2.show()"><i class="icon-edit"></i></a></td>
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

});
</script>


<!------------------------------------------------------------------------------------------------------------------- 
                                  				Tab Event
--------------------------------------------------------------------------------------------------------------------->
<script language="javascript">		

</script>

<!------------------------------------------------------------------------------------------------------------------- 
                                  				Window Event
--------------------------------------------------------------------------------------------------------------------->			
<script language="javascript">	
		
</script>	
			
<!------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
                                   Script  html body 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------->



<body class="jui">


    <br/>

	    <div class="head">
	        <div class="left">세부정보</div>
	    </div>
	    <div>

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
	    
     <br/>
     
	    <div class="foot" align="center">
	        <a href="#" class="btn focus">Save</a> 
	        <a href="#" class="btn" onclick='window.close()'>Close</a>
	    </div>



</body>

</html>

