<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ĳ���� ��ȸ
 * ���α׷�ID 	 : RM310S
 * J  S  P		 : rm310s
 * �� �� ��		 : RM310S
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-06-27
 * �������		 : ��ĳ���� ��ȸ (��ȸ)
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windwos������ ASP�� �Ǿ� ����.
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
   date.set(java.util.Calendar.HOUR_OF_DAY, 120);      
   String lastday = m_today.format(date.getTime());
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

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
		sEndDate.text='<%=lastday%>';
		
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");       
		gr1.TitleHeight = "35";        
		gr2.TitleHeight = "35";        
		
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";		 		
        		
        //�˻�
        ds6.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM017&s_Item1=Y";
        ds6.Reset();
                
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds3.Reset(); //�����ڵ�
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310S",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated || ds2.IsUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
			if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
				alert("������ڸ� �Է��� �ּ���.");
				return;
			}		
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text + ","
	            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
	            + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid") + ","
	            + "sRoomTypeSid=" + ds5.namevalue(ds5.rowposition,"room_type_sid") + ","
	            + "sQTypeCd=" + ds6.namevalue(ds6.rowposition,"detail") + ","            	                                                
	            + "sQTypeStr=" + sQTypeStr.value;          	            	            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310S",
	            "JSP(O:DS1=ds1,O:DS2=ds2)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ������ ��ȸ
	 */		
	function fnSelectDs4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid");	
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310S",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	 
	/*
	 * ����Ÿ�� ��ȸ
	 */		
	function fnSelectDs5() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid") + ","
            + "sUpjangSid=" + ds4.namevalue(ds4.rowposition,"upjang_sid");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm310S",
            "JSP(O:DS5=ds5)",
            param);
        tr_post(tr3)
	}	 
	/*
	 * ����
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("���ɽ��� ��ȸ");
		gr2.runexcelsheet("���ɽ��� ��ȸ");		
	}		
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			for ( i=1;i<=ds2.CountRow;i++ ) {
				if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
					ds2.rowposition=i;
					ds2.namevalue(i,"select_div") = 'Y';
				} else {
					ds2.namevalue(i,"select_div") = 'N';				
				}
			}
			ds2.ResetStatus();									
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			for ( i=1;i<=ds2.CountRow;i++ ) {
				if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
					ds2.rowposition=i;
					ds2.namevalue(i,"select_div") = 'Y';
				} else {
					ds2.namevalue(i,"select_div") = 'N';				
				}
			}
			ds2.ResetStatus();							
		</script>

		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4()
		</script>
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs5()
		</script>				
		
	    <script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
				sEndDate.text = sBgnDate.text;
	    </script>	
	    
		<script language="javascript"  for=gr2 event=OnColumnPosChanged(row,colid)>
			if ( colid == 'rsv_close_date' || colid == 'use_date' || colid == 'yoil_nm' || colid == 'room_type_cd' ) {
				if ( ds2.namevalue(row,"select_div") == 'Y' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#E0CFE4";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";		
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";	
				}				
			} else if ( colid == 'use_cnt2' ) {
				if ( ds2.namevalue(row,"use_yn2") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";				
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}
			} else if ( colid == 'use_cnt1' ) {
				if ( ds2.namevalue(row,"use_yn1") == 'N' ) {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#F7B7F2";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";				
				} else {
					gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
					gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
					gr2.SelectionColorProp("EditCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("EditRow", "BgColor") = "";
					gr2.SelectionColorProp("CurCol", "BgColor") = "#FFFFFF'";
					gr2.SelectionColorProp("CurRow", "BgColor") = "";
					gr2.SelectionColorProp("SelRow", "BgColor") = "";					
				}	
			} else {
				gr2.SelectionColorProp("FocusEditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusEditRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusCurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("FocusCurRow", "BgColor") = "";
				gr2.SelectionColorProp("FocusSelRow", "BgColor") = "";
				gr2.SelectionColorProp("EditCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("EditRow", "BgColor") = "";
				gr2.SelectionColorProp("CurCol", "BgColor") = "#fefec0";
				gr2.SelectionColorProp("CurRow", "BgColor") = "";
				gr2.SelectionColorProp("SelRow", "BgColor") = "";			
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
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		for ( i=1;i<=ds2.CountRow;i++ ) {
			if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
				ds2.namevalue(i,"select_div") = 'Y';
			} else {
				ds2.namevalue(i,"select_div") = 'N';				
			}
		}    
		ds2.ResetStatus();					
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		fnSelectDs4(); 
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		fnSelectDs5(); 
		div='';			
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
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
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer" align=absmiddle onclick="fnSelect()">																			
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDs1()">  																																							
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
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;-
										     <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
			            					<td align=left width=70 class="text">&nbsp;����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>																				
			            					<td align=left width=70 class="text">&nbsp;������</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="upjang_sid">
                                                    <param name=BindColVal      value="upjang_sid">
													<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
													<param name=ListExprFormat  value="upjang_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>											                            
			            					<td align=left width=70 class="text">&nbsp;����Ÿ��</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="room_type_sid">
                                                    <param name=BindColVal      value="room_type_sid">
													<param name=EditExprFormat	value="%,%;room_type_sid,room_type_cd">
													<param name=ListExprFormat  value="room_type_cd^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>																			
			            				</tr>
			                            <tr bgcolor="#6f7f8d">											            				
			            					<td align=left width=70 class="text">�˻�</td>
			                                <td align=left bgcolor="#ffffff" colspan="7">&nbsp;																									
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sQTypeCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;
												<input id="sQTypeStr" type="text" class="textbox"  style= "position:relative;left:-0px;top:0px;width:100px; height:20px;">																				
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
									<%
									/*---------------------------------------------------------------------------->
										HTML Desc	: �˻� ���� - 
										Object ID 	: �׸��� , gr1
										Data ID		: ds1
									-----------------------------------------------------------------------------*/
									%>							
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:175" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>	
										<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											">								                                        																																                                        
										<param name="Format" 			value="
							                <C> name='������SID'     ID='upjang_sid'    align=left show=false </C>																		
							                <C> name='������'     ID='rsv_close_date'    width=70 align=left show=true mask=XXXX-XX-XX suppress=1</C>
							                <C> name='�����'     ID='use_date'   fontstyle=bold width=80 align=left show=true mask=XXXX-XX-XX  suppress=2 </C>
							                <C> name='����'      ID='yoil_nm'     width=40 align=center show=true  suppress=3 </C>
							                <C> name='ȣ��'    ID='upjang_nm'   width=100 align=left show=true  suppress=4 </C>
							                <C> name='�'       ID='open_goods_nm'      width=40 align=left show=true</C>
							                <C> name='�����'        ID='open_cnt'       width=50 align=right show=true</C>
							                <C> name='�̿�'     ID='use_cnt'    width=40 align=right show=true</C>
							                <C> name='����\\(2��)'        ID='use_cnt2'    fontstyle=bold   width=40 align=right show=true</C>
							                <C> name='����\\(1��)'   ID='use_cnt1' fontstyle=bold width=40 align=right show=true</C>
							                <C> name='����\\���'     ID='over_block_cnt'    width=40 align=right show=true</C>
							                <C> name='���'     ID='stay_cnt'    width=40 align=right show=true</C>
							                <C> name='���'     ID='assign_block_cnt'    width=40 align=right show=true</C>
							                <C> name='���\\����'  ID='rsv_block_cnt'         width=40 align=right show=true</C>
							                <C> name='����'  ID='rsv_cnt'         width=40 align=right show=true</C>
							                <C> name='���ͳ�'       ID='int_rsv_cnt'      width=50 align=right show=true</C>
							                <C> name='����'  ID='naekum_cnt'        width=40 align=right edit=none show=true</C>
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
<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<%
	/*---------------------------------------------------------------------------->
		HTML Desc	: �˻� �κ� 
					: 
	-----------------------------------------------------------------------------*/
	%>											
	<tr height="10">
		<td></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						<%
						/*---------------------------------------------------------------------------->
							HTML Desc	: �˻� ���� - 
							Object ID 	: �׸��� , gr2
							Data ID		: ds2
						-----------------------------------------------------------------------------*/
						%>							
						<%=HDConstant.COMMENT_START%>
						<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:175" border="1" >
                			<param name="DataID"		VALUE="ds2">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name=MultiRowSelect    value=true>	
							<param name=SuppressOption value=1>																																					
							<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='EditCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusEditRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='EditRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusCurCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='CurCol', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusCurRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='CurRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='FocusSelRow', BgColor='', TextColor='Black'</SC>
																						<SC>Type='SelRow', BgColor='', TextColor='Black'</SC>
																						">																									                                        								                                        
							<param name="Format" 			value="
				                <C> name='���ÿ���'     ID='select_div'   Width=60  align=center edit=none show=false </C> 																                																																				
				                <C> name='������SID'     ID='upjang_sid'   Width=60  align=center edit=none show=false </C> 																                																		
				                <C> name='����SID'     ID='room_type_sid'   Width=60  align=center edit=none show=false </C> 																                																																	                
				                <C> name='������'     ID='rsv_close_date'  bgColor={IF(select_div='Y','#E0CFE4','#fefec0')}  width=70 align=left edit=none show=true mask=XXXX-XX-XX suppress=1</C>															                															                
				                <C> name='�����'     ID='use_date'  fontstyle=bold bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=80  align=center edit=none mask=XXXX-XX-XX suppress=2</C> 																                
				                <C> name='����'     ID='yoil_nm'   bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=40  align=center edit=none  suppress=3</C> 
				                <C> name='����'     ID='room_type_cd'   bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} Width=100  align=center edit=none  suppress=4</C> 																                
				                <C> name='�����'     ID='open_cnt'   bgColor=#fefec0 Width=90  align=right edit=none  suppress=5 </C> 
				                <C> name='�̿�'     ID='use_cnt'   bgColor=#fefec0 Width=40  align=right edit=none </C> 															                
				                <C> name='����\\(2��)'       ID='use_cnt2'     bgColor={IF(use_yn2='N','#F7B7F2','#FFFFFF')} fontstyle=bold Width=40  align=right edit=none </C>
				                <C> name='����\\(2��) ����'       ID='use_yn2'     Width=70  align=right show=false </C>															                
				                <C> name='����\\(1��)'       ID='use_cnt1'     bgColor={IF(use_yn1='N','#F7B7F2','#FFFFFF')} fontstyle=bold Width=40  align=right edit=none  </C> 
				                <C> name='����\\(1��) ����'       ID='use_yn1'     Width=60  align=right edit=none  show=false </C> 															                
				                <C> name='����\\���'       ID='over_block_cnt'     bgColor=#fefec0  Width=40  align=right edit=none </C> 
				                <C> name='���'       ID='stay_cnt'     bgColor=#fefec0  Width=40  align=right edit=none </C>	 													                
				                <C> name='���'       ID='assign_block_cnt'     bgColor=#fefec0  Width=40  align=right edit=none </C>														                															                
				                <C> name='���\\����'       ID='rsv_block_cnt'     bgColor=#fefec0  Width=40  align=right edit=none </C> 															                															                
				                <C> name='����'       ID='rsv_cnt'     bgColor=#fefec0  Width=40  align=right edit=none </C>	 													                															                															                
				                <C> name='���ͳ�'       ID='int_rsv_cnt'     bgColor=#fefec0  Width=50  align=right edit=none </C>	 													                															                															                
				                <C> name='����1'  ID='remarks1'    bgColor=#fefec0     width=150 align=left edit=none show=true</C>
				                <C> name='����2'  ID='remarks2'   bgColor=#fefec0      width=150 align=left edit=none show=true</C>
				                <C> name='����3'  ID='remarks3'   bgColor=#fefec0      width=150 align=left edit=none show=true</C>															                															                															                															                
				                <C> name='���ͳ�\\����'       ID='int_rsv_yn'    bgColor=#fefec0  Width=50  align=center edit=none  </C>	 													                															                															                
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
				</tr>
			</table>
		</td>
	</tr>											
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
                                                                                    
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		                    
                                                                                    