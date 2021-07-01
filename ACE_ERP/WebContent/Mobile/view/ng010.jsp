

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

		// ContextPath 변수 설정.
		//String dirPath = request.getContextPath(); //HDASan

		//서버시간 만들기
	    //java.util.Calendar date = java.util.Calendar.getInstance();
	    //java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("ssMMmmyyyyHHdd");
	    //String strD = m_today.format(date.getTime());
	
		//로그인 정보에서 불러오는 값 /////011-06-14 심동현수정 ///////////////////////////////////////////////////////////////////////////////////////
		String gusrid	= "6060002";

		//로그인 정보에서 불러오는 값 /////
		
		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "10";  	//1페이지에 표시될 개수

	//시작 //////////////////////////////////////////////////////////////////
	
	SmartRequest sr_db= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "10";  												//1페이지에 표시될 개수
		ArrayList data_db = new ArrayList();								//게시물 리스트를 받아올 것 생성.
		int len_db = 0;
		BaseDataClass bean_db;
	
		//이부분을 해줘야 매니저파일에서 sr.getObject()로 읽어올 수 있다.
		sr_db.setObject("requestedPage",(Object)requestedPage);				//요청페이지 세팅
		sr_db.setObject("pageSize",(Object)pageSize);						//페이지 사이즈 세팅
		sr_db.setObject("v_login_id",(Object)gusrid);						//로긴 아이디 셋팅 

		
		DBManager manager_db = new DBManager();
		data_db		= manager_db.list(sr_db);								//화면에 표시될 리스트 불러오기.
		manager_db.close();
		
	//끝//////////////////////////////////////////////////////////////////////
		
	//최초 tree_idx
	int tree_idx = 0;

	
%>





<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="EUC-KR">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>HTML5</title>


    
    <!--  2018.04.09  jui 컴포넌트 적용 Test 이동훈 -->  

	<link rel="stylesheet" href="../../Resource/jui/jui-master/jui-master/dist/ui.min.css" />
	<link rel="stylesheet" href="../../Resource/jui/jui-master/jui-master/dist/ui-jennifer.min.css" />
	
	<!-- Grid style components -->
	<link rel="stylesheet" href="../../Resource/jui/jui-grid-master/jui-grid-master/dist/grid.min.css" />
	<link rel="stylesheet" href="../../Resource/jui/jui-grid-master/jui-grid-master/dist/grid-jennifer.min.css" />

	
</head>
  
  
<script>

jui.ready([ "ui.notify" ], function(notify) {
    var handler = {
        show: function(data) {
            console.log("show : " + JSON.stringify(data));
        },
        hide: function(data) {
            console.log("hide : " + JSON.stringify(data));
        },
        click: function(data) {
            console.log("click : " + JSON.stringify(data));
        }
    };

    notify_1 = notify("body", {
        position: "top-right",
        event: handler,
        tpl: {
            item: $("#tpl_alarm").html()
        }
    });

    notify_2 = notify("body", {
        position: "top-left",
        event: handler,
        timeout: 0,
        tpl: {
            item: $("#tpl_alarm").html()
        }
    });

    notify_3 = notify("body", {
        position: "top",
        event: handler,
        timeout: 2000,
        padding: {
            top: 100
        },
        tpl: {
            item: $("#tpl_alarm").html()
        }
    });

    notify_top_submit = function(type, color) {
        var data = {
            title: "Caution message Send!!!",
            message: "Feb 15, 2013-12-24 02:24:19",
            color: color
        };

        if(type == 1) notify_1.add(data);
        if(type == 2) notify_2.add(data);
        if(type == 3) notify_3.add(data);
    }
});
</script>

  
<body class="jui">

<section>

	<p>
		<div class="row">
		<div class="panel">
			<div class="head">
				<B>HDASAN PMS Page</B>
			</div>
		</div>
		</div>
	</p>
</section>



<section>

	<p>
			    <h1>Table Style</h1>  
			
			  <table style="width: 90%" border="0" cellspacing="0" cellpadding="1"  class="table simple hover">

				<tr>


						<td width="80" align="center">Head</td>
						<td width="80" align="center">Team</td>
						<td width="80" align="center">Job</td>
						<td width="80" align="center">Name</td>
		 		</tr>
		                        
		            <%

		                  len_db = data_db.size();
		                  bean_db = null;
		
							for(int h=0; h<len_db; h++) {
		                     	bean_db = (BaseDataClass)data_db.get(h);



							
		            %>
		            
					<tr height=20>
						<td width="80" align="center"><%=bean_db.get("head_nm")%></td>
						<td width="80" align="center"><%=bean_db.get("dpt_nm")%></td>
						<td width="80" align="center"><%=bean_db.get("job_nm")%></td>
						<td width="80" align="center"><%=bean_db.get("eno_nm")%></td>

		 			</tr>

				   <%

		           		}
				   %>


			  </table>
	</p>
</section>

<section>

	<p>

	<table>
		<tr>
			<td width="300px">Default</td>
			<td width="300px">Focus</td>
			<td width="300px">Disabled</td>
		</tr>
		<tr>
			<td>
				<a class="btn" >Default</a>
			</td>

			<td>
			<button class="btn small" onclick="notify_top_submit(2, 'danger')">
    			<i class="icon-play"></i> Alert
			</button>
			</td>

			<td>
				<a class="btn" disabled>Disabled</a>
			</td>

		</tr>
	</table>

	</p>
</section>

<script id="tpl_alarm" type="text/template">
    <div class="notify <!= color !>">
        <div class="title"><!= title !></div>
        <div class="message"><!= message !></div>
    </div>
</script>



  </body>
</html>