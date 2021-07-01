<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 출입국 거부자 등록
 * 프로그램ID 	 : RV430I_00001
 * J  S  P		 : rv430i_00001
 * 서 블 릿		 : RV430I_00001
 * 작 성 자		 : 박경국
 * 작 성 일		 : 2008-11-20
 * 기능정의		 : 출입국 거부자 등록 및 관리
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan


   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());		   
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

	function fnSetHeader(){
		if (ds1.countrow < 1){
		var s_temp1 = "SOUTH_PERMIT_YN:STRING, NORTH_PERMIT_YN:STRING,CANCEL_CD:STRING, CUST_NM:STRING, MANAGE_NO:STRING, TEL_NO:STRING, ADDRESS1:STRING, COMPANY_NM:STRING, POSITIONS:STRING, CUST_SID:INT";
		ds1.SetDataHeader(s_temp1);
		}	
	}
	
	//선조회
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		gr1.TitleHeight = "35";        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv780I",
            "JSP(O:DS2=ds2,O:DS3=ds3,O:DS5=ds5,O:DS6=ds6)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);	
	}
	//메인조회
	function fnSelect() {
		    v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sCustGu=" 	+ ds5.namevalue(Row,"detail")	            
	            + ",sManegeNo=" + sManegeNo.value
	            + ",sCustNm=" 	+ sCustNm.value;		                		           
	       	ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv780I",
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
		strURL = "<%=dirPath%>/Sales/help/rv004h_02.jsp"
		strPos = "dialogWidth:420px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"cust_nm") 	= arrParam[0];
	   		ds1.namevalue(ds1.rowposition,"manage_no")  = arrParam[1];
	   		ds1.namevalue(ds1.rowposition,"ADDRESS1") 	= arrParam[2];
	   		ds1.namevalue(ds1.rowposition,"tel_no") 	= arrParam[3];
	   		ds1.namevalue(ds1.rowposition,"company_nm") = arrParam[4];
	   		ds1.namevalue(ds1.rowposition,"positions") 	= arrParam[5];
	   		ds1.namevalue(ds1.rowposition,"CUST_SID") 	= arrParam[6];
	   	} else {
			ds1.namevalue(ds1.rowposition,"cust_nm") 	= "";
	   		ds1.namevalue(ds1.rowposition, "manage_no") = "";
	   		ds1.namevalue(ds1.rowposition,"ADDRESS1") 	= "";
	   		ds1.namevalue(ds1.rowposition,"tel_no") 	= "";
	   		ds1.namevalue(ds1.rowposition,"company_nm") = "";
	   		ds1.namevalue(ds1.rowposition,"positions") 	= "";
	   		ds1.namevalue(ds1.rowposition,"CUST_SID") 	= "";
		}				
		
	}
	
				 
	//적용
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv780I",
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
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4()
		</script>	
		
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && ( colid=='south_permit_yn' || colid=='north_permit_yn' ) ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }	
		</script>	
		
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="cust_nm") {
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
	<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
	//	lc4.index=lc4.IndexOfColumn("detail","1");
	</script>
	
	<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
		div='';	
		fnSelectDs4(); 	
	</script>
	
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
		<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

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
            									<img src="<%=dirPath%>/Sales/images/minus.gif" 		style="cursor:hand"  onClick="fnDeleteRow()" >
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"  onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
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
		            						<td align=left class="text">&nbsp;고객구분</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
					                            <object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100"></object>
												<%=HDConstant.COMMENT_END%>		
											</td>	
			            					<td align="center" width="100px" class="text">주민/여권번호</td>
											<td align="center" bgcolor="#ffffff"><input type="text" name="sManegeNo" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align=left width=70 class="text">&nbsp;&nbsp;&nbsp;성명&nbsp;&nbsp;&nbsp;</td>
			                                <td align=left bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;">
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
							               <C> name='방북\\불허가√'     ID='south_permit_yn' width=50 	align=center 	editstyle=checkbox editlimit=1 show=true </C>
							               <C> name='북입국\\불허가√'   ID='north_permit_yn' width=50 	align=center 	editstyle=checkbox editlimit=1 show=false</C>
							               <C> name='거부사유'    		ID='cancel_cd'   	 width=150  align=center 	editlimit=200 show=true</C>
							               <C> name='예약SID'      		ID='RSV_SID'     	 width=50 	BgColor=#fefec0 align=right 	editlimit=12 edit=none show=false</C>
							               <C> name='고객SID'      		ID='cust_sid'     	 width=50 	BgColor=#fefec0 align=right 	editlimit=12 edit=none show=false</C>
							               <C> name='한글성명'  		ID='cust_nm'      	 width=80 	BgColor=#b4f0b4 align=left 		editlimit=20 editstyle=popup show=true</C>
							               <C> name='주민번호'    		ID='manage_no'   	 width=100 	BgColor=#fefec0 align=center 	editlimit=20 edit=none show=true </C>
							               <C> name='사는곳'      		ID='ADDRESS1'        width=150 	align=left 		Edit=None</C>
							               <C> name='전화번호'       	ID='tel_no'      	 width=80 	BgColor=#fefec0 align=left editlimit=20 edit=none show=true</C>
							               <C> name='직장명'   			ID='company_nm'  	 width=110 	BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
							               <C> name='직위'    			ID='positions'   	 width=90 	BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
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

