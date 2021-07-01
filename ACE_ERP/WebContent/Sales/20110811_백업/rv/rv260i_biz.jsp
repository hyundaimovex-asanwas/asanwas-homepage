<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 전략물자 반출 관리화면
 * 프로그램ID 	 :  RV260
 * J  S  P		 : RV260
 * 서 블 릿		 : RV260
 * 작 성 자		 : 정하나
 * 작 성 일		 : 2009-05-15
 * 기능정의		 : 전략물자 반출 관리화면
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
	//선조회
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		gr1.TitleHeight = "35";        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am100I",
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
	            + "sSERIAL_NO=" + sSERIAL_NO.value
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
            									<img src="<%=dirPath%>/Sales/images/minus.gif" 		style="cursor:hand"  onClick="fnDeleteRow()" >
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"  onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
												<img src="<%=dirPath%>/Sales/images/upload.gif"   	style="cursor:hand"  onclick="fnUpload()">												
												<img src="<%=dirPath%>/Sales/images/excel.gif"   	style="cursor:hand"  onclick="fnExcel()">													
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
		            						<td align="center" width="100px" class="text">Serial_No</td>
											<td align="center" bgcolor="#ffffff"><input type="text" name="sSERIAL_NO" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align="center" width="100px" class="text">모델</td>
											<td align="center" bgcolor="#ffffff"><input type="text" name="sMODEL" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align=center width=100 class="text">&nbsp;&nbsp;&nbsp;품명&nbsp;&nbsp;&nbsp;</td>
			                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																										
													<comment id="__NSID__">
						    						<object id=sKIND classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
						    							<param name=ComboDataID			value=codeDs3>
						    							<param name=SearchColumn		value="kind_nm">
						    							<param name=Sort				value="false">
						    							<param name=ListExprFormat		value="kind_nm^0^140">
						    							<param name=BindColumn			value="kind">
						    						</object>
						                            </comment><script>__WS__(__NSID__);</script>
											</td>
			            				</tr>	
					                        	<tr bgcolor="#6f7f8d">
				            						<td align="center" width="100px" class="text">소속</td>
													<td align="center" bgcolor="#ffffff">
														<input type="text" name="sClient_nm" value="현대아산(주)" size="20" readonly="readonly" class="textbox">&nbsp;
														<input type="hidden" name="sClient_sid"  value="1237" size="5" readonly="readonly" class="textbox">&nbsp;
														<img src="/services/Sales/images/help.gif" 	style="cursor:hand" 	align=absmiddle onClick="fnClientPopup();" >
													</td>
					            					<td align="center" width="100px" class="text">이름</td>
													<td align="center" bgcolor="#ffffff"><input type="text" name="sNAME" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
													</td>
					            					<td align=center width=100 class="text">&nbsp;&nbsp;&nbsp;용도&nbsp;&nbsp;&nbsp;</td>
					                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																										
															<comment id="__NSID__">
								    						<object id=sUSE classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
								    							<param name=ComboDataID			value=codeDs3>
								    							<param name=SearchColumn		value="use_nm">
								    							<param name=Sort				value="false">
								    							<param name=ListExprFormat		value="use_nm^0^140">
								    							<param name=BindColumn			value="use">
								    						</object>
								                            </comment><script>__WS__(__NSID__);</script>
													</td>
					            				</tr>	
					     		               	<tr bgcolor="#6f7f8d">
				            						<td align="center" width="100px" class="text">반출일</td>
													<td align="center" bgcolor="#ffffff">
														<comment id="__NSID__">
														<object id=from_out_dt classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
														~
														<comment id="__NSID__">
														<object id=to_out_dt classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
													</td>
					            					<td align="center" width="100px" class="text">반입일</td>
													<td align="center" bgcolor="#ffffff">
														<comment id="__NSID__">
														<object id=from_in_dt classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
														~
														<comment id="__NSID__">
														<object id=to_in_dt classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
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
							               <C> name='품명'   			ID='KIND' 		 width=70 	align=center 	editlimit=200 	show=true </C>										
										   <C> name='Serial_No'     	ID='SN' 		 width=80 	BgColor=#fefec0   align=center editlimit=200 	show=true </C>
							               <C> name='CPU'    			ID='CPU'   	 		 width=70   align=center 	editlimit=200 	show=true </C>
							               <C> name='HDD'      			ID='HDD'     	 	 width=70 	align=center 	editlimit=200 	show=true </C>
							               <C> name='RAM'      		ID='RAM'     	 	 width=70 	align=center 	editlimit=200 	show=true </C>										   
							               <C> name='모델명'   			ID='MODEL' 		 width=70 	align=center 	editlimit=200 	show=true </C>
							               <C> name='소속'    			ID='CLIENT_NM'   	 	 width=80 	align=center 	BgColor=#fefec0 editstyle=popup align=left editlimit=200  show=true</C>
							               <C> name='이름'    			ID='NAME'   	 	 width=80 	align=center 	editlimit=200  	show=true</C>							               
							               <C> name='반출일'    		ID='OUT_DT'   width=80 	align=center 	editlimit=200  	show=true </C>
							               <C> name='반입일'        	ID='IN_DT'     width=80 	align=center 	</C>
							               <C> name='용도'       	    ID='USE'       width=80 	align=center 	editlimit=200  	show=true</C>
							               <C> name='비고'   			ID='NOTE'  	 		 width=100 	align=center 	editlimit=200 e show=true</C>					           
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
