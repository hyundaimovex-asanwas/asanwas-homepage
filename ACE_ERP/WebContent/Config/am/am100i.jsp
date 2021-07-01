<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 	: 전산기기 관리화면
 * 프로그램ID 	: AM100
 * J  S  P		 	: AM100
 * 서 블 릿		: AM100
 * 작 성 자		: 박경국
 * 작 성 일		: 2008-12-18
 * 기능정의		: 전산기기 관리화면(기기등록)
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%	// ContextPath 변수 설정.
   String dirPath = request.getContextPath(); //HDASan
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	// 페이지로딩
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		fnInit();
	}
	//선조회
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		//gr1.TitleHeight = "35";        
    }
	//메인조회
	function fnSelect() {
		    v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sITEM_SID=" + sITEM_SID.value
	            + ",sEMPNO=" 	+ sEMPNO.value
	            + ",sEMPNMK=" 	+ sEMPNMK.value;		                		           
	       	ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am100I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
	<%
	// 행추가 (그리드별)
	%>
	function fnAddRow() {
		ds1.addrow();
    }
	<%
	// 행삭제 (그리드별)
	%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
	// 인원 팝업 : 인원 그리드에서 
	function fnCustPopup() {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:420px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"EMPNO") 	= arrParam[0];
	   		ds1.namevalue(ds1.rowposition,"EMPNMK")  = arrParam[1];
	   	} else {
			ds1.namevalue(ds1.rowposition,"EMPNO") 	= "";
	   		ds1.namevalue(ds1.rowposition, "EMPNMK") = "";
	   }				
	}
	//적용
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	         ln_TRSetting(tr1, 
	              "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am100I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	// 취소
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	function fnExcel() {
		    getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("이름명단","이름명단.xls", 8);
	}
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="EMPNO") {
			fnCustPopup();
		}
		</script>         
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
	<%
		// 작업성공
	%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        //메시지 처리
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);             
	</script>
<%
		// 작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        //에러 메시지
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);      
        //메시지 처리
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		       
	</script>
<%
	//작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
	//작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);            
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
		<%=HDConstant.COMMENT_START%>
		<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="false">
		</object>
		<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		    <param name="ServerIP"   value="">
		    <param name="Action"     value="">
		    <param name="KeyName"    value="">
		    <param name="KeyValue"   value="">
		    <param name="Parameters" value="">
		</object>
		<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
		    <param name="ServerIP"   value="">
		    <param name="Action"     value="">
		    <param name="KeyName"    value="">
		    <param name="KeyValue"   value="">
		    <param name="Parameters" value="">
		</object>
		<%=HDConstant.COMMENT_END%>
		</head>
		<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand"  onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand"  onClick="fnAddRow()" >
            									<img src="<%=dirPath%>/Sales/images/minus.gif" 	style="cursor:hand"  onClick="fnDeleteRow()" >
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"  onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
												 <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                        	<tr bgcolor="#6f7f8d">
		            						<td align="center" width="100px" class="text">SERIAL_NO</td>
											<td align="center" bgcolor="#ffffff"><input type="text" name="sITEM_SID" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align="center" width="100px" class="text">사 번</td>
											<td align="center" bgcolor="#ffffff"><input type="text" name="sEMPNO" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align=center width=100 class="text">&nbsp;&nbsp;&nbsp;성 명&nbsp;&nbsp;&nbsp;</td>
			                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sEMPNMK" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;">
											</td>
			            				</tr>	
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption	value=1>								                                        
										<param name="Format" 		value="
										   <C> name='S/N'    			ID='ITEM_SID' 		 width=40 	BgColor=#fefec0	align=center  DECAO=0  editlimit=200 	show=true </C>
							               <C> name='모델명'   			ID='MODEL_NM' 		 width=100 	align=center 	editlimit=200 	show=true </C>
							               <C> name='제조사'   			ID='MADE_COMPANY' 		 width=60 	align=center 	editlimit=200 	show=true </C>
							               <C> name='CPU'    			ID='CPU'   	 			 width=170   	align=center 	editlimit=200 	show=true </C>
							               <C> name='HDD'      			ID='HDD'     	 	 		 width=40 	align=center 	editlimit=200 	show=true </C>
							               <C> name='RAM'      		ID='RAM'     	 	 		 width=40 	align=center 	editlimit=200 	show=true </C>
							               <C> name='GRAPHIC'  		ID='GRAPHIC'      	 	 width=40 	align=center 	editlimit=200  	show=true </C>
							               <C> name='구매일자'    	ID='PURCHASE_DATE'   width=60 align=center 	editlimit=200  	show=true </C>
							               <C> name='반납일자'      	ID='RETURN_DATE'   width=60 		align=center 	</C>
							               <C> name='폐기일자'       	ID='DONE_DATE'       width=60 		align=center 	editlimit=200  	show=true</C>
							               <C> name='비고'   			ID='REMARKS'  	 		 	 width=100 	align=center 	editlimit=200  show=true</C>
							               <C> name='사번'    			ID='EMPNO'   	 	 	 width=60 	align=center 	BgColor=#fefec0 editstyle=popup align=left editlimit=200  show=true</C>
							               <C> name='성명'    			ID='EMPNMK'   	 	 width=60 	align=center 	editlimit=200  	show=true</C>
							               <C> name='IP'    				ID='IP'   		 	 		 width=70 	align=center 	editlimit=200  	show=false</C>
							               <C> name='ASSETCODE'  ID='ASSETCODE'	 	 width=70 	align=center 	editlimit=200  	show=false</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
