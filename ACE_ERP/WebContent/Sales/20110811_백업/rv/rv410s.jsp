<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȯ���� �ڷ�˻�
 * ���α׷�ID 	 : RM410S
 * J  S  P		 : rm410s
 * �� �� ��		 : RM410S
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-06-28
 * �������		 : Ȯ���� �ڷ�˻� (��ȸ)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   String firstday = m_today.format(date.getTime());		   
%>

<!-- HTML ����-->
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
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit();
		}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv410S",
            "JSP(O:DS2=ds2)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);		
        
		ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds3.Reset(); //�����ڵ�        
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	         if ( sParam01.checked == true ) 
	         	sParam01.value='Y';
	         else
	         	sParam01.value='N';	         
	         if ( sParam02.checked == true ) 
	         	sParam02.value='Y';
	         else
	         	sParam02.value='N';
	         if ( sParam03.checked == true ) 
	         	sParam03.value='Y';
	         else
	         	sParam03.value='N';
	         if ( sParam04.checked == true ) 
	         	sParam04.value='Y';
	         else
	         	sParam04.value='N';
	         if ( sParam05.checked == true ) 
	         	sParam05.value='Y';
	         else
	         	sParam05.value='N';
	         if ( sParam06.checked == true ) 
	         	sParam06.value='Y';
	         else
	         	sParam06.value='N';
	         if ( sParam07.checked == true ) 
	         	sParam07.value='Y';
	         else
	         	sParam07.value='N';
	         if ( sParam08.checked == true ) 
	         	sParam08.value='Y';
	         else
	         	sParam08.value='N';
	         if ( sParam09.checked == true ) 
	         	sParam09.value='Y';
	         else
	         	sParam09.value='N';
	         if ( sParam10.checked == true ) 
	         	sParam10.value='Y';
	         else
	         	sParam10.value='N';
	         if ( sParam11.checked == true ) 
	         	sParam11.value='Y';
	         else
	         	sParam11.value='N';
	         if ( sParam12.checked == true ) 
	         	sParam12.value='Y';
	         else
	         	sParam12.value='N';
	         if ( sParam13.checked == true ) 
	         	sParam13.value='Y';
	         else
	         	sParam13.value='N';
	         if ( sParam14.checked == true ) 
	         	sParam14.value='Y';
	         else
	         	sParam14.value='N';	         		         	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds2.namevalue(ds2.rowposition,"depart_time") + ","	            
	            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sParam01=" + sParam01.value + ","
	            + "sParam02=" + sParam02.value + ","
	            + "sParam03=" + sParam03.value + ","
	            + "sParam04=" + sParam04.value + ","
	            + "sParam05=" + sParam05.value + ","
	            + "sParam06=" + sParam06.value + ","
	            + "sParam07=" + sParam07.value + ","
	            + "sParam08=" + sParam08.value + ","
	            + "sParam09=" + sParam09.value + ","
	            + "sParam10=" + sParam10.value + ","
	            + "sParam11=" + sParam11.value + ","
	            + "sParam12=" + sParam12.value + ","	            	            	            	            	            	            	            	            	            	            	            
	            + "sParam13=" + sParam13.value + ","	            	            	            	            	            	            	            	            	            	            	            
	            + "sParam14=" + sParam14.value;	            	            	            	            	            	            	            	            	            	            	            	            	            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv410S",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ��ǰ ��ȸ
	 */		
	function fnSelectDs4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid");	
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv410S",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	  
	/*
	 * ����
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("Ȯ���� �ڷ�˻�");
	}		
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4();
		</script>			

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    	
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);      	
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
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
<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>
<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
</script>
<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	div='';
	fnSelectDs4();			
</script>
<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	fnOnProgressEnd();
</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
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

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
									<table width="845" border="0" cellpadding="0" cellspacing="0" style="border:1px solid #6f7f8d">
										<tr>
											<td width="270" height="20">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25"><input name="sParam01" type="checkbox" value="Y"></td>
														<td>&nbsp;���� ���� Ȯ����</td>
													</tr>
												</table>
											</td>
											<td width="270">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25"><input name="sParam02" type="checkbox" value="Y"></td>
														<td >&nbsp;���ڵ� ���ι�ȣ ���� �� ����� ��</td>
													</tr>
												</table>
											</td>
											<td width="270">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam03" type="checkbox" value="Y"></form></td>
														<td >&nbsp;������ �Ϸù�ȣ�� ���� ��</td>
													</tr>
												</table>
											</td>
										</tr>
										
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam04" type="checkbox" value="Y"></form></td>
														<td >&nbsp;��������ȣ�� ���� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam05" type="checkbox" value="Y"></form></td>
														<td>&nbsp;�����ȣ�� ���� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam06" type="checkbox" value="Y"></form></td>
														<td>&nbsp;�ѱۼ����� ���� ���</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam07" type="checkbox" value="Y"></form></td>
														<td>&nbsp;����/������ ��Ģ� �ִ� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam08" type="checkbox" value="Y"></form></td>
														<td>&nbsp;�Ǹ�Ȯ�� ���������� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam09" type="checkbox" value="Y"></form></td>
														<td >&nbsp;��û ������ ���� ���</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam10" type="checkbox" value="Y"></form></td>
														<td >&nbsp;Ȯ�� ������ ���� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam11" type="checkbox" value="Y"></form></td>
														<td>&nbsp;���ǹ�ȣ�� ���� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam12" type="checkbox" value="Y"></form></td>
														<td>&nbsp;��û���ǰ� Ȯ�������� �ٸ� ���</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam13" type="checkbox" value="Y"></form></td>
														<td >&nbsp;���Ϻ� ���ι�ȣ ���� ���</td>
													</tr>
												</table>
											</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="25" height="25" ><input name="sParam14" type="checkbox" value="Y"></form></td>
														<td>&nbsp;�����Է��� ���� ���(�ּ�,����)</td>
													</tr>
												</table>
											</td>
											<td>
											</td>
										</tr>
									</TABLE>
								</td>
							</tr>
						</table>
						<br>												
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr height="50px">
								<td align="left" >
									<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
										<tr> 
											<td align="right">
												<table border="0"  cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td align="right" height="30px">	
															<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">																																																																		
															<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  																																																																																			
											 			</td>
													</tr>																		
												</table>
											</td>
										</tr>															
									</table>	
								</td>											
							</tr>
							<tr height="30px">
								<td align="left" >
									<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
										<tr> 
											<td  width="845px">
						                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
						                            <tr bgcolor="#6f7f8d">
														<td align=left width=70 class="text">&nbsp;�������</td>
														<td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
															<comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">																																									
																<param name=SelectAllOnClickAny  	value="false">																																												
															</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
														</td>
						            					<td align=left width=70 class="text">&nbsp;���ð�</td>
						                                <td align=left bgcolor="#ffffff">&nbsp;																										
			     												<%=HDConstant.COMMENT_START%>
								                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds2>
																<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
																<param name=ListExprFormat  value="depart_time_nm^0^120"></object>
															<%=HDConstant.COMMENT_END%>
														</td>																				
						            					<td align=left width=70 class="text">&nbsp;����</td>
						                                <td align=left bgcolor="#ffffff">&nbsp;																										
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds3>
																<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
																<param name=ListExprFormat  value="saup_nm^0^120"></object>
															<%=HDConstant.COMMENT_END%>
														</td>											                            
						            					<td align=left width=70 class="text">&nbsp;&nbsp;&nbsp;��ǰ&nbsp;&nbsp;&nbsp;</td>
						                                <td align=left bgcolor="#ffffff">&nbsp;																										
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds4>
																<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
																<param name=ListExprFormat  value="goods_nm^0^120"></object>
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
					</td>											
				</tr>
				<tr height="10">
					<td></td>
				</tr>		
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:240" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>								                                        
										<param name="Format" 			value="
							               <C> name='�������'  ID='depart_date'         width=70 align=center editlimit=8 show=true mask=XXXX-XX-XX </C>
							               <C> name='��û��ȣ'    ID='accept_no'   width=90 align=center editlimit=15 show=true</C>
							               <C> name='�ֹι�ȣ'    ID='manage_no'   width=90 align=center editlimit=20 show=true</C>
							               <C> name='��û����'       ID='a_room_type_nm'     width=60 align=left editlimit=50 show=true</C>
							               <C> name='Ȯ������' ID='room_type_nm'        width=60 align=left editlimit=50 show=true</C>
							               <C> name='���ȣ'      ID='room_no'     width=40 align=right editlimit=10 show=true</C>
							               <C> name='��/��'  ID='class_teams'         width=40 align=left editlimit=7 show=true</C>
							               <C> name='���Ϻι�ȣ'     ID='unity_no'    width=70 align=right editlimit=10 show=true</C>
							               <C> name='�������Ϸù�ȣ'      ID='tour_no'     width=90 align=right editlimit=20 show=true</C>
							               <C> name='�����'   ID='company_nm'  width=70 align=left editlimit=30 show=true</C>
							               <C> name='����'    ID='positions'   width=70 align=left editlimit=30 show=true</C>
							               <C> name='�����ȣ'       ID='zip_cd'      width=50 align=center editlimit=6 show=true mask=XXX-XXX </C>
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

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

