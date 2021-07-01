<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명     : 결재선 지정
 * 프로그램ID   : SY040H
 * J  S  P      : sy040h
 * 서 블 릿        : Sy040h
 * 작 성 자        : 정하나
 * 작 성 일        : 2010-09-06
 * 기능정의     :
 * [수  정   일  자][수정자] 내용

 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

    //대리점 구분
 
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);


    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());
    date.add(Calendar.DATE, +1);					//여기서 add()함수를 쓰려면 java.util.Calendar를 로드해야하는듯. 
    String lastday = m_today.format(date.getTime());	//근데 쓰는 곳이 없네..


%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

    
<%
/****************************************************************************
                사용자 스크립트
******************************************************************************/
%>      
    <script language="javascript">
        var v_default_row = 1;
        var emp='6080002';
     
        /*
         * 페이지로딩
         */
	function fnOnLoad(tree_idx){
//		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr_master"), "comn1");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
		fnInit(); 
		fnInit2(); 

	} 
        
        /*
         * 초기작업
         * Header 설정 
         */
    function fnInit() {    
   
       //트리 조회 
      //  alert(login_id);
		gcds_before.DataID = "<%=dirPath%>/servlet/Person.hcdept_s22?";
		gcds_before.Reset();			
   
 // strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?empno="+login_id;
	        
//결재 타입 조회              	        
	    v_job = "S";         
	     window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1";
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
            "JSP(O:DS5=gcds_approve_type)",
            param);
        tr_post(tr2);  	        	       	
    }
        
     function fnInit2() {          			
		// 결재선 luxcombo 조회			
        v_job = "S";         
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "v_empno=" +emp;        //+login_id
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
            "JSP(O:DS3=gcds_approve)",
            param);
        tr_post(tr2);  	        	        
     }
<%     
///////////////////////////////////////////////////////////////////////////////
// Description 	:  팝업창 닫기
// Parameter 	: A - 선택
%>			
			function fnClose(p){	
			var returnValue;
			var returnValue2="";
				if (p=="A") {			
					if(gcds_data2.countrow==4){
						   for(i=1;i<=gcds_data2.countrow;i++){
						       returnValue = "1" + "/" 
														+ gcds_data2.namevalue(i,"APPROVE_TYPE")  + "/" 
														+ gcds_data2.namevalue(i,"SEQ")  + "/" 
							                   	 		+ gcds_data2.namevalue(i,"APPROVE_EMPNO")+";"              	 	
							   returnValue2 =    returnValue2 + returnValue;            
							                   	 	
						   }
					}else{ 				
								for(i=1;i<=gcds_data2.countrow;i++){
								    returnValue = 	"1" + "/" 
																+ gcds_data2.namevalue(i,"APPROVE_TYPE")  + "/" 
																+ gcds_data2.namevalue(i,"SEQ")  + "/" 
									                   	 		+ gcds_data2.namevalue(i,"APPROVE_EMPNO")+";" 
         	 	
								   returnValue2 =     returnValue2 + returnValue;            
								} 
								for(i=gcds_data2.countrow+1;i<=4;i++) {
									returnValue = "1" + "/" + "X"  + "/" + "X"  + "/" + "X" +";"
									returnValue2 = returnValue2 + returnValue ;  
								}
							}
					window.returnValue = 	returnValue2 ;		
						 alert (returnValue2);									
 					window.close();
				} else {
					window.close();
				}
			}
		
		     
        
/******************************************************************************
	Description : 조회
******************************************************************************/


	/* 트리 조회 */
	function ln_tree(tree_idx){

		//메뉴트리 펼치기
		if(tree_idx==0){	//초기 인덱스화면인 경우
       		gcte_data.Expand(0);
		} else{
	    	for (i = 1; i <= gcds_before.countrow; i++) {
	    		if(tree_idx == gcds_before.namevalue(i,"DEPTCD")) {
		       		gcte_data.Expand(i);
	    		};
	    	};
		};	//		if(tree_idx=0){
    	
	}
	

	function ln_Query(e){		
	
		//prompt('',gcds_data.DataID);
		//gcds_data.Reset();			
        v_job = "S";         
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "v_dept_cd=" + e ;       
            
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
            "JSP(O:DS2=gcds_data)",
            param);
        tr_post(tr1);
        			
	}
        
    function fnSelect(){  //결재선지정  - 상단 조회 버튼

        v_job = "S";
      
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "v_cust_nm=" + v_cust_nm.value + ","
            + "v_dept_nm=" + v_dept_nm.value;       
            
            
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
            "JSP(O:DS1=gcds_data)",
            param);
        tr_post(tr2);	       
    }
        
        
        
    function fnSelect2(){ //결재선지정 tree onclick시에 

	        v_job = "S";         
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
			    + "v_empno="+emp+ "," //+login_id
			    + "v_sid=" + v_approve.BindColVal;
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
			    "JSP(O:DS4=gcds_data2)",
			    param);
			tr_post(tr2);  
			       
    }
        
     function ln_add_seq(){
     
           for(k=1;k<=gcds_data2.CountRow;k++){
				gcds_data2.NameValue(k, "SEQ") =  k ;
			   alert(gcds_data2.NameValue(k,"seq"));
			}	
     }
                        
    function fnSave(){
               		    
  		 if (gcds_data2.isUpdated ){  			  		 
		      var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
		   	     	+ "v_empno=" +  emp+ ","        //+login_id
		   	     	+ "v_app_nm=" + v_app_nm.value+","
		   	//     	+ "v_seq=" + cur_seq+","
		   	     	+ "v_sid=" + v_approve.BindColVal;  
		   	     	
			    ln_TRSetting(tr_save,
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
		            "JSP(I:DS1=gcds_data2)",
		            param);
		         tr_post(tr_save);
 	             fnInit2();
		  }else{
		  		alert("결재선을 넣어주세요");
		  }
	}
		  
    function fnCorrect(){
  		 if (gcds_data2.isUpdated ){  
 /* 		 
  		 
 for(k=1;k<=gcds_data2.CountRow;k++){
 var SysStatus = gcds_data2.SysStatus(k);		
		   alert(SysStatus);
}	*/
	  	//delete 해주기	 
		      var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=4,"
		   	     	+ "v_sid=" + v_approve.BindColVal;  
		   	     	
			    ln_TRSetting(tr_save,
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
		            "JSP(I:DS1=gcds_data2)",
		            param);
		         tr_post(tr_save);
		         
	  		 ln_add_seq(); //seq 다시 설정
	  		 
	  		 // insert / update 해주기
		      var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2,"
		   	   //  	+ "v_empno=" +  emp+ ","        //+login_id
		   	  //   	+ "v_app_nm=" + v_app_nm.value+","
		   	     	+ "v_sid=" + v_approve.BindColVal;  
		   	     	
			    ln_TRSetting(tr_save,
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
		            "JSP(I:DS1=gcds_data2)",
		            param);
		         tr_post(tr_save);

		  }else{
		  		alert("변경사항이 없습니다");
		  }    
    }
    
        function fnDelete(){
        
         for(i=1;i<=gcds_data2.CountRow;i++){
    	    alert(v_approve.BindColVal);
        	alert(gcds_data2.namevalue(i,"SEQ"));
        	gcds_data2.namevalue(i,"DUMMY") = 1;
        }

		      var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3,"
		   	     	+ "v_empno=" +  emp+ ","        //+login_id
		   	     	+ "v_app_nm=" + v_app_nm.value+","
		   	     	+ "v_sid=" + v_approve.BindColVal;  
		   	     	
			    ln_TRSetting(tr_save,
		            "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy040H",
		            "JSP(I:DS1=gcds_data2)",
		            param);
		         tr_post(tr_save);
		         fnInit2();
    }	
		                 
        
    function fnCancel(){ //새로고침
    
	    v_app_nm.value=""
        gcds_data2.UndoAll();
    }

    function fnDeleteRow() {
       for(i=1;i<=gcds_data2.CountRow;i++){
       	//	alert(gcds_data2.namevalue(row,"CREATE_YN"));
	   	if (gcds_data2.namevalue(i,"CREATE_YN")=='T') 
	   	   gcds_data2.DeleteRow(i);	    		            		     
//        gcds_data2.DeleteRow(gcds_data2.RowPosition);
		}
    } 
        
       //DEPTCD:STRING(4),PAYGRD:STRING(4)
	function ln_SetDataHeader(){
			if (gcds_data2.countrow<1){
			var s_temp = " CREATE_YN:STRING(1),DUMMY:DECIMAL(1),SEQ: DECIMAL(5),APPROVE_EMPNO:STRING(7),APPROVE_TYPE:STRING(10),EMPNMK:STRING(30),"
								 + " DEPTNM:STRING(50),PAYGNM:STRING(50) ";
				gcds_data2.SetDataHeader(s_temp);
			}
	}
	

    </script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="gcds_before" event="OnLoadStarted()">

</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">

	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";	
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	//fnInit2();
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";	
	

</script>

    <script language=JavaScript  for=gcds_approve event="OnLoadStarted()" >
     //   window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
    //    document.all.LowerFrame.style.visibility="visible"; 
    </script> 
  
    <script language=JavaScript  for=gcds_approve event="OnLoadCompleted(row)">
   //     window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
   //     document.all.LowerFrame.style.visibility="hidden";
    </script>   
    
    <script language=JavaScript  for=gcds_approve_type event="OnLoadStarted()" >
     //   window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
    //    document.all.LowerFrame.style.visibility="visible"; 
    </script> 
  
    <script language=JavaScript  for=gcds_approve_type event="OnLoadCompleted(row)">
   //     window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
   //     document.all.LowerFrame.style.visibility="hidden";
    </script> 
    
<script language="javascript" for="gcte_data" event="onClick()">
	var e = gcds_before.namevalue(gcds_before.rowposition,"DEPTCD");
	ln_Query(e);
</script>

<script language="javascript" for="gcds_approve" event="onloadCompleted(row,colid)">
	gcds_approve.insertrow(1);
	gcds_approve.namevalue(1,"SID") = "";
	gcds_approve.namevalue(1,"APPROVE_NM") = "신규등록";
	v_approve.index = 0;
	
//	var a_approve;
//	 a_approve = v_approve.BindColVal; 
//	 alert(a_approve);
//	 alert(v_approve.index);
</script>

<script language=JavaScript for=v_approve event=OnSelChange()>
 	        if (v_approve.index ==0 ) {
	 	        gcds_data2.ClearData();
	 	        v_app_nm.readOnly = false;
				sp0.style.display = "";
				sp1.style.display = "none";
				sp2.style.display = "none";
				v_app_nm.value = "";
		 	 	        
	 	    }else{
		 	    v_app_nm.readOnly = true;
				sp0.style.display = "none";
				sp1.style.display = "";
				sp2.style.display = "";	 	    	 	        	

				fnSelect2();
				
				v_app_nm.value = gcds_approve.NameValue(gcds_approve.RowPosition, "APPROVE_NM");

			//	alert(v_approve.BindColVal);
			}        	                   
</script>
  
		      
<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">

 //  alert(gcds_data.NameValue(Row, "EMPNO"));

    if(Row==0) return;
    ln_SetDataHeader();
    gcds_data2.AddRow();
    
    gcds_data2.NameValue(gcds_data2.RowPosition, "APPROVE_EMPNO")    = gcds_data.NameValue(Row, "EMPNO");
    gcds_data2.NameValue(gcds_data2.RowPosition, "EMPNMK")     = gcds_data.NameValue(Row, "EMPNMK");
    gcds_data2.NameValue(gcds_data2.RowPosition, "DEPTNM")      = gcds_data.NameValue(Row, "DEPTNM");
    gcds_data2.NameValue(gcds_data2.RowPosition, "PAYGNM")       = gcds_data.NameValue(Row, "PAYGNM");
	gcds_data2.namevalue(gcds_data2.RowPosition,"SEQ")= ln_add_seq();
</script>		


												
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="onsuccess()">
   	var tree_idx = gcds_data.namevalue(gcds_data.rowposition,"DEPTCD");
	ln_tree(tree_idx);
	
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";    
</script>

<script language="javascript" for="tr1" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr2" event="onsuccess()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr2" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
//     fnInit2();
    
    
</script>

<script language="javascript" for="tr_save" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
        
    fnSelect();
</script>


<%
/*******************************************************************************
            가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<!--tree --> 
<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="TREECD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--상단 --> 
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--하단 --> 
<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--결재선관리 --> 
<object  id=gcds_approve classid=<%=HDConstant.CT_DATASET_CLSID%>>  
    <param name="SyncLoad"  value="False">
</object>  

<!--결재선타입 --> 
<object  id=gcds_approve_type classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>

<object id=ds_business classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  지역 -->
    <param name="SyncLoad"  value="True">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		



    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 

        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text" width="70">조회구분</td>
                        <td class="text"  width="70">성명</td>
						<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 20);"></td>	                                                                                 
                        <td class="text" width="70">부서</td>
                 		<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="v_dept_nm" size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 20);">
                 		<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                 		</td>                 		
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=230>                            
							<comment id="__NSID__"><object id="gcte_data" classid="clsid:4401B994-DD33-11D2-B539-006097ADB678" 
								style="position:relative;left:3px;border:1 solid #708090; width:220px; height:320px; font-size:9pt"> 
								<Param Name="DataID"		value="gcds_before">
								<Param Name="TextColumn"	value="DEPTNM">
								<Param Name="LevelColumn"	value="LEVEL">
								<Param Name="BorderStyle"	value="0">
								<param name="useimage"		value="false">
							</object></comment><script>__ws__(__NSID__);</script>			                            
                        </td>
                        <td width=10>&nbsp;</td>
                        <td width=615 valign=top>
                            <table width="100%" border=0 cellspacing=0 cellpadding=0>
                                <tr height=5><td></td></tr>
                                <tr>
                                    <td>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='465px' height='280px' border='1'>
                                            <param name="DataID"            value="gcds_data">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="
												<C>ID=EMPNO,		Name=사번,			width=70,		HeadBgColor=#B9D4DC, align=center, Edit=None ,show=false</C>
												<C>ID=EMPNMK,		Name=성명,			width=67,		HeadBgColor=#B9D4DC, align=left, Edit=None</C>
												<C>ID=PAYGNM,		Name=직위명,		width=100,	HeadBgColor=#B9D4DC, align=left, Edit=None</C>																					
												<C>ID=DEPTNM,		Name=부서,		width=158,	HeadBgColor=#B9D4DC, align=left, Edit=None</C>												
                                         ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>                                                              
			                </table>
			            </td>       
			        <!--</tr>  -->
                  </table>
         
                        </td>                        
                    </tr>

                                <tr height=5><td></td></tr>
						        <tr>
						            <td width='845px'>
						                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
						                    <tr height='25px'>
						                        <td class="text" width="70">결재선관리</td>
				                                <td align=left bgcolor="#ffffff">&nbsp;																										
	  												<%=HDConstant.COMMENT_START%>	              										
						                            <object id=v_approve classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=gcds_approve>
														<param name=BindColumn      value="sid"">
	                                                    <param name=BindColVal      value="sid">
														<param name=EditExprFormat	value="%,%;sid,approve_nm">
														<param name=ListExprFormat  value="approve_nm^0^120"></object>
													<%=HDConstant.COMMENT_END%>
												</td>		                                                                                 
						                        <td class="text" width="80">개인결재선명</td>
						                 		<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="v_app_nm" size="20" maxlength="20" class="textbox"  OnKeyUp="cfLengthCheck(this, 20);" ReadOnly>
						                 		
						                 		<span id=sp0 style="display:none;">						                 		
							                 		<img src="<%=dirPath%>/Sales/images/new.gif"  style="cursor:hand" align=absmiddle onclick="fnSave()">
						                 		</span>
						                 		<span id=sp1 style="display:none;">
							                 		<img src="<%=dirPath%>/Sales/images/correct.gif"  style="cursor:hand" align=absmiddle onclick="fnCorrect()">
						                 		</span>
						                 		<span id=sp2 style="display:none;">
							                 		<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:hand" align=absmiddle onclick="fnDelete()">
						                 		</span>
						                 		</td>
						                 	</tr>
						                </table>	
						             </td>
						         </tr>    	
                                <tr height=5><td></td></tr>
                                
                    <tr>
                        <td width='845px' height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand"  align=absmiddle onClick="fnDeleteRow()" >
                        </td>
                    </tr>
                                                    
                                <tr>
                                    <td>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='280px' border='1'>
                                            <param name="DataID"            value="gcds_data2">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="												    
												<C>ID='CREATE_YN' ,  	 Name='Check',  		HeadAlign=Center, Width=30, HeadBgColor=#B9D4DC, align=center, editlimit=1, editstyle=checkbox</C> 												
												<C>ID=DUMMY,		Name=DUMMY,			width=70,		HeadBgColor=#B9D4DC, align=center, Edit=None ,show=false</C>													
												<C>ID=APPROVE_EMPNO,		Name=사번,			width=70,		HeadBgColor=#B9D4DC, align=center, Edit=None ,show=false</C>												                      												
												<C>ID=SEQ,		Name=순서,			width=70,		HeadBgColor=#B9D4DC, align=center, Edit=None ,show=false</C>												                                           
                                                <C>ID=APPROVE_TYPE,		Name=구분,			width=67,		HeadBgColor=#B9D4DC, align=center, EditStyle=Lookup,Data='gcds_approve_type:detail:detail_nm' Sort=True </C>               
												<C>ID=EMPNMK,		Name=성명,			width=67,		HeadBgColor=#B9D4DC, align=left, Edit=None</C>
												<C>ID=DEPTNM,		Name=부서,		width=158,	HeadBgColor=#B9D4DC, align=left, Edit=None</C>	       
												<C>ID=PAYGNM,		Name=직위명,		width=100,	HeadBgColor=#B9D4DC, align=left, Edit=None</C>																					
												                                 
                                         ">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>  

                    <tr>
                        <td width='845px' height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/ap_line.gif" style="cursor:hand"  align=absmiddle onClick="fnClose('A')" >
                            <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand" align=absmiddle onclick="fnCancel()">                              
                            <img src="<%=dirPath%>/Sales/images/p_exit.gif"  style="cursor:hand" align=absmiddle onclick="fnClose('C')">                          
                        </td>
                    </tr>                                                                                    						                 						                 
						             <!--</td> 
						        </tr>  						       						                            
                </table>
            </td>
        </tr> -->
    </table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<script language=javascript>
	var login_id;
	var login_nm;
	get_cookdata();
	login_id=GetCookie("vusrid");
	login_nm=GetCookie("vusrnm");
</script>
