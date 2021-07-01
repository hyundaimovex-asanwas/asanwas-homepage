<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��Ͻ���[������]
 * ���α׷�ID 	 : RM420I
 * J  S  P		 : rm420i
 * �� �� ��		 : RM420I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-06-28
 * �������		 : ��Ͻ���[������] (��ȸ, ����, ���)
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
		gr1.TitleHeight = "35";        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv420I",
            "JSP(O:DS2=ds2,O:DS3=ds3,O:DS5=ds5,O:DS6=ds6)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);	
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","1");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sAcceptNo=" + sAcceptNo.value + ","
	            + "sCustGu=" + ds5.namevalue(Row,"detail") + ",";	            
	            if ( sSRejectYn.checked == true ) 
		            param += "sSRejectYn=Y,";	            	
		        else 
		            param += "sSRejectYn=N,"	            			        
	            if ( sNRejectYn.checked == true ) 
		            param += "sNRejectYn=Y,"	            	
		        else 
		            param += "sNRejectYn=N,"	            			    
	         	param += "sCustNm=" + sCustNm.value;		                		           
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv420I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ��ǰ��ȸ
	 */		
	function fnSelectDs4() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");	
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv420I",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	  
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv420I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * ���
	 */
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
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
            
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);             
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
     	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
     	
     	//�����޽��� ó��
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg); 
		    
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		          	
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
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
<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
//	lc4.index=lc4.IndexOfColumn("detail","1");
</script>
<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	div='';	
	fnSelectDs4(); 	
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

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->			
									
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
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
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
																<td  width="710px">
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left width=70 class="text">&nbsp;����</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds2>
																					<param name=BindColumn      value="saup_sid">
							                                                        <param name=BindColVal      value="saup_sid">
																					<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
																					<param name=ListExprFormat  value="saup_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>					
											            					<td align=left width=70 class="text">&nbsp;��ǰ����</td>
											                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds4>
																					<param name=BindColumn      value="goods_sid">
							                                                        <param name=BindColVal      value="goods_sid">
																					<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
																					<param name=ListExprFormat  value="goods_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>&nbsp;																																									                            
											            					<td align=left width=70 class="text">&nbsp;<b>�������</b></td>
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
																			</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=80 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds3>
																					<param name=BindColumn      value="depart_time">
							                                                        <param name=BindColVal      value="depart_time">
																					<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
																					<param name=ListExprFormat  value="depart_time_nm^0^80"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>	
											            				</tr>			
<%--									                            <tr bgcolor="#6f7f8d">
										            						<td align=left class="text">&nbsp;������</td>
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
											            				</tr>														            													            				
--%>											            				
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left width=70 class="text">&nbsp;��û����ȣ</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
																				<input id="sAcceptNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;">
																			</td>											                            
											            					<td align=left width=70 class="text">&nbsp;&nbsp;&nbsp;����&nbsp;&nbsp;&nbsp;</td>
											                                <td align=left bgcolor="#ffffff" colspan="3">&nbsp;																										
																				<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;">
																			</td>
											            				</tr>	
											            			</table>
																</td>
																<td width="10">
																</td>
																<td  id=cancel_cd width="130px">
																	<table width='130' border='0' cellpadding='0' cellspacing='0' style='border:1px solid #6f7f8d'>
																		<tr >
																			<td width='130' height='20'>
																				<table width='100%' border='0' cellspacing='0' cellpadding='0'>
																					<tr >
																						<td width='25' height='25'><input name='sSRejectYn' type='checkbox' value='Y'></td>
																						<td>&nbsp;��� ������</td>
																					</tr >
																				</table>							
																			</td>							
																		</tr>
																		<tr >
																			<td width='130' height='20'>
																				<table width='100%' border='0' cellspacing='0' cellpadding='0'>
																				<tr >
																					<td width='25' height='25'><input name='sNRejectYn' type='checkbox' value='Y'></td>
																					<td>&nbsp;���Ա� ������</td>
																				</tr >
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
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=SuppressOption value=1>								                                        
																		<param name="Format" 			value="
															               <C> name='���\\�㰡��'      ID='south_permit_yn'     width=40 align=center editstyle=checkbox editlimit=1 show=true </C>
															               <C> name='���Ա�\\�㰡��'      ID='north_permit_yn'   width=40 align=center editstyle=checkbox editlimit=1 show=true</C>
															               <C> name='��һ���'    ID='cancel_cd'   width=80 align=center editstyle=lookup data= 'ds6:cancel_cd:cancel_nm' editlimit=2 show=true</C>
															               <C> name='��û��ȣ'    ID='accept_no'   width=90 BgColor=#fefec0 align=center editlimit=15 edit=none show=true</C>
															               <C> name='����'      ID='cust_nm'     width=60 BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
															               <C> name='�ֹι�ȣ'    ID='manage_no'   width=100 BgColor=#fefec0 align=center editlimit=20 edit=none show=true </C>
															               <C> name='��ϱ�����'      ID='educ_dt'     width=65 BgColor=#fefec0 align=left editlimit=8 edit=none show=true</C>
															               <C> name='��ȭ��ȣ'       ID='tel_no'      width=80 BgColor=#fefec0 align=left editlimit=20 edit=none show=true</C>
															               <C> name='����Ÿ��' ID='room_type_cd'       width=55  BgColor=#fefec0 align=center editlimit=10 edit=none show=true</C>
															               <C> name='�����'   ID='company_nm'  width=110 BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
															               <C> name='����'    ID='positions'   width=90 BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
															               <C> name='����SID'      ID='rsv_sid'     width=50 BgColor=#fefec0 align=right editlimit=12 edit=none show=false</C>
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
							</td>
						</tr>
					</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
                                                                                    
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		                    
                                                                                    
