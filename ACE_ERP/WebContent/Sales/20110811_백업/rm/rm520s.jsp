<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ����ȸ
 * ���α׷�ID 	 : RM520S
 * J  S  P		 : rm520s
 * �� �� ��		 : RM520S
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-06-21
 * �������		 : ����ȸ (��ȸ, ����, ����, ���)
 * [ �������� ][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-11-06][�ڰ汹] �˻����� �߰� : ��������� & ��������
 * [2009-04-24][�ڰ汹] �˻����� �߰� : ���� ����
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
	date.add(java.util.Calendar.MONTH,1);
//	date.add(java.util.Calendar.DATE, +30);	
	String lastday = m_today.format(date.getTime());
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

   	/*
   	 * �������ε�
   	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
   	/*
   	 * ����Ÿ�� ��� ����
   	 */
   	function fnSetHeader(){
   	}
   	/*
   	 * ����ȸ
   	 */
   	function fnInit(){
   		sBgnDate.text='<%=firstday%>';
   		sEndDate.text='<%=lastday%>';

           v_job = "H";
           cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnSetHeader();

            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           //�븮��
           ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
           ds3.Reset();
           //���������
       	   ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	       ds_saldam.Reset();
		   //����
		   ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		   ds_saup.Reset(); //�����ڵ�
       	   //��ǰ����
//           ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//           ds4.Reset();
           //��ȸ����
           ds5.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM016&s_Item1=Y";
           ds5.Reset();

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520S",
               "JSP(O:DS2=ds2)",
               "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
           tr_post(tr1);
   	}

   	/*
   	 * ������ȸ
   	 */
       function fnSelect() {
       	if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
   			alert("������ڸ� �Է����ּ���.");
   			return;
   		}
           v_job = "S";
            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
           var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
    	       + "sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)+","
               + "sBgnDate=" + sBgnDate.text + ","
               + "sEndDate=" + sEndDate.text +","
               + "sBlockStatusCd=" + ds2.namevalue(ds2.rowposition,"detail") + ","
               + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
               + "sAcceptBgnDate=" + sAcceptBgnDate.text + ","
               + "sAcceptEndDate=" + sAcceptEndDate.text + ","
               + "sTlBgnDate=" + sTlBgnDate.text + ","
               + "sTlEndDate=" + sTlEndDate.text + ","
               + "sCfBgnDate=" + sCfBgnDate.text + ","
               + "sCfEndDate=" + sCfEndDate.text + ","
               + "sQTypeCd=" + ds5.namevalue(ds5.rowposition,"detail") + ","
               + "sQTypeStr=" + sQTypeStr.value + ","
               + "sBlockNo=" + sBlockNo.value + ","
               + "sSalDamSid=" + sSalDamSid.value + ","
               + "sClientSid="+sClientSid.value + ",";
               
               if ( sResultsYn.checked == true ) {
		            param += "sResultsYn=Y";
        	    } else {
	        	    param += "sResultsYn=N";            
	            }

           ln_TRSetting(tr1,
               "<%=dirPath%><%=HDConstant.PATH_RM%>Rm520S",
               "JSP(O:DS1=ds1)",
               param);
           tr_post(tr1);

       }
   	/*
   	 * �븮���˾�
   	 */
   	function fnPopup() {

   			var arrParam	= new Array();
   			var arrResult	= new Array();
   			var strURL;
   			var strPos;
   			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
   			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

   			arrResult = showModalDialog(strURL,arrParam,strPos);

   			if (arrResult != null) {
   				arrParam = arrResult.split(";");
   		    	sClientSid.value = arrParam[0];
   				sClientCd.value = arrParam[2];
   				sClientNm.value = arrParam[1];
   			} else {
   		    	sClientSid.value = 0;
   				sClientCd.value = '';
   				sClientNm.value = '';
   			}
   	}
   	/*
	 * ��������� �˾�
	 */
	 
	function fnPopup4() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';
			}
	}
	
   	/*
   	 * ��ȸ���� �˾�
   	 */
   	function fnPopup3() {
   			var arrParam	= new Array();
   			var arrResult	= new Array();
   			var strURL;
   			var strPos;
               arrParam[0] = "RM016";
               arrParam[1] = ""; //�����ڵ��� �����Ͱ�
   			strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
   			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

   			arrResult = showModalDialog(strURL,arrParam,strPos);

   			if (arrResult != null) {
   				arrParam = arrResult.split(";");
   				sQTypeCd.value = arrParam[1];
   				sQTypeNm.value = arrParam[2];
   			} else {
   				sQTypeCd.value = '';
   				sQTypeNm.value = '';
   			}
   	}
   	
   	/*
   	 * ����
   	 */
   	function fnExcelDs1() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�����ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�����ȸ", "�����ȸ.xls", 8);        
   		
   	}
   	





   	
   	/*
   	 * �븮��, ��ǰ���� �ڵ�����(����)
   	 */
   	function fnSetting(dataSet) {
   		var exit=false;
   		if ( dataSet == 'ds3' ) {	//�븮��
   			for ( i=1; i<=ds3.CountRow; i++ ) {
   				if ( ds3.namevalue(i,"client_cd") == sClientCd.value ) {
   					sClientSid.value = ds3.namevalue(i,"client_sid");
   					sClientNm.value = ds3.namevalue(i,"client_nm");
   					exit=true;
   					return;
   				}
   			}
   			if ( exit != true ) {
   				sClientSid.value = 0;
   				sClientNm.value = '';
   			}
   		}
   	}


	//��ǰ��ȸ
	function fnSelectGoodsLC() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			+ ",sDepartDate=";
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS_ONLY=ds4)",
            param);
        tr_post(tr2);
	};	
	   	
   </script>

   <%
   /*=============================================================================
   			Gauce Components Event Scripts
   =============================================================================*/
   %>
       <script language=JavaScript for=sBgnDate event=OnKillFocus()>
           if( sBgnDate.Modified == true )
   			sEndDate.text = sBgnDate.text;
       </script>

       <script language=JavaScript for=sAcceptBgnDate event=OnKillFocus()>
           if( sAcceptBgnDate.Modified == true )
   			sAcceptEndDate.text = sAcceptBgnDate.text;
       </script>
       
       <script language=JavaScript for=sTlBgnDate event=OnKillFocus()>
           if( sTlBgnDate.Modified == true )
   			sTlEndDate.text = sTlBgnDate.text;
       </script>
       
       <script language=JavaScript for=sCfBgnDate event=OnKillFocus()>
           if( sCfBgnDate.Modified == true )
   			sCfEndDate.text = sCfBgnDate.text;
       </script>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//��ǰ ��˻�
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
   <!--  �븮�� -->
   <object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
       <param name="SyncLoad"  value=false>
   </object>
   <!--  ��ǰ -->
   <object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
       <param name="SyncLoad"  value=false>
   </object>
   <!--  ��ȸ���� -->
   <object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
       <param name="SyncLoad"  value=false>
   </object>
   <!--  ���� -->
   <object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
       <param name="SyncLoad"  value=false>
   </object>
   <!--  ��������� -->
   <object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
				<tr>
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr>
								<td align="right">
									<table border=0  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align=left>
											<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											  <tr bgcolor="#6f7f8d">
					                            <td align=center width=70 class="text">���������</td>
				                                <td align=left width=188 bgcolor="#ffffff">&nbsp;<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
													<input id="sSalDamSid" type="hidden" value="0">
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:hand;position:relative;" onclick="fnPopup4();">
													<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
												</td>
				            					<td align=left width=80 class="text">�븮��</td>
				                                <td align=left bgcolor="#ffffff" width=220>&nbsp;
													<input id="sClientSid" type="hidden" value="0">
													<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds3')">
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
													<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" readOnly>
												</td>
												<td align=left class="text" width="70">����(��)</td>
				                                <td align=left width=44 bgcolor="#ffffff" valign="middle">&nbsp;																							
													<input name="sResultsYn" type="checkbox" value="Y">
												</td>																				
				            				  </tr>
											</table>

											
											</td>
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
				<tr>
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr>
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
										<tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">�������</td>
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
											<td align=left class="text" width="80px">����</td>
						                    <td align=left bgcolor="#ffffff">&nbsp;	
												<%=HDConstant.COMMENT_START%>
						                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_saup>
													<param name=BindColumn      value="saup_sid">
						                            <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120">
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>												
			            					<td align=left width=70 class="text">��ǰ</td>
			                                <td align=left bgcolor="#ffffff" width=210>&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="goods_sid">
                                                    <param name=BindColVal      value="goods_sid">
													<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^140"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;
											</td>
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">&nbsp;��û����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
										     <comment id="__NSID__"><object id=sAcceptBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
										     <comment id="__NSID__"><object id=sAcceptEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
			            					<td align=left width=80 class="text">�˻�</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sQTypeCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^80"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;
												<input id="sQTypeStr" type="text" class="textbox"  style= "position:relative;left:-0px;top:0px;width:100px; height:20px;">
											</td>
			            					<td align=left width=70 class="text">������</td>
			                                <td align=left bgcolor="#ffffff" width=210>&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sBlockStatusCd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            				</tr>
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">&nbsp;T/L����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
										     <comment id="__NSID__"><object id=sTlBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
										     <comment id="__NSID__"><object id=sTlEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
			            					<td align=left width=80 class="text"><b>����</B>Ȯ������</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
											<object id=sCfBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
											</object><%=HDConstant.COMMENT_END%>&nbsp;-
											<%=HDConstant.COMMENT_START%>
										    <object id=sCfEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
											</object><%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left width=70 class="text">��Ϲ�ȣ</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;
												<input id="sBlockNo" type="text" class="textbox"  style= "position:relative;left:-0px;top:0px;width:100px; height:20px;">
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
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:340" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
                            <C> name='���No'       ID='block_no'        HeadAlign=Center Width=80  align=center edit=none mask=XXXXXX-XXXX</C>
                            <G> name='��ǰ����'
                                <C> name='��ǰ'         ID='goods_nm'        Width=90   align=left   edit=none sort=true suppress=1 </C>
                                <C> name='�����'       ID='depart_date'     Width=70    align=center   edit=none mask=XXXX-XX-XX suppress=2 Sort=True</C>
                            </G>
                            <C> name='�븮��'       ID='client_nm'       HeadAlign=Center Width=100  align=left edit=none sort=true show=true suppress=3 </C>
                            <C> name='��û��'       ID='a_emp_nm'        HeadAlign=Center Width=55  align=left show=true</C>
                            <G> name='��û����' edit=none
                                <C> name='Ÿ��'         ID='a_room_type_cd'    Width=50   align=left   edit=none  sort=true</C>
                                <C> name='Ÿ�Ը�'       ID='a_room_type_nm'    Width=70   align=left   edit=none</C>
                                <C> name='���Ǽ�'       ID='a_room_cnt'        Width=40    align=right  edit=none     </C>
                                <C> name='�ο�'         ID='accept_persons'    Width=40    align=right edit=none  </C>
                            </G>
                            <C> name='��ü��'       ID='group_nm'        HeadAlign=Center Width=200  align=left show=true edit=none suppress=4 </C>
                            <C> name='��û����'     ID='a_remarks'       HeadAlign=Center Width=300  align=left show=true edit=none </C>
                            <C> name='��û�Ͻ�'     ID='a_date'          HeadAlign=Center Width=80  align=left show=true</C>
                            <C> name='���'         ID='block_status_cd' HeadAlign=Center Width=50  align=center sort=true show=true edit=none editstyle=lookup Data='ds2:detail:detail' </C>
                            <G> name='Ȯ������' show=true
                                <C> name='Ÿ��'         ID='c_room_type_cd'  HeadAlign=Center Width=50  align=left edit=none editlimit=40 show=true sort=true</C>
                                <C> name='Ÿ�Ը�'       ID='c_room_type_nm'  HeadAlign=Center Width=70  align=left edit=none editlimit=40 show=true</C>
                                <C> name='���Ǽ�'       ID='c_room_cnt'      HeadAlign=Center Width=40  align=right editlimit=100 show=true</C>
                                <C> name='�ο�'         ID='confirm_persons' HeadAlign=Center Width=40  align=right editlimit=5 show=true</C>
                                <C> name='T/L'        ID='tl_date'         HeadAlign=Center Width=70  align=center editlimit=1 show=true mask=XXXX-XX-XX</C>
                                <C> name='����Ÿ��'   ID='cust_rate_type'  HeadAlign=Center Width=70  align=center editlimit=1 show=true</C>
                                <C> name='��������'     ID='deposit_rate'    HeadAlign=Center Width=60  align=right editlimit=1 show=true DEC=0</C>
                                <C> name='������'    ID='deposit_amt'     HeadAlign=Center Width=60  align=right editlimit=1 show=true DEC=0</C>
                                <C> name='�Աݾ�'  	ID='PAYED_AMT'     HeadAlign=Center Width=60  align=right editlimit=1 show=true DEC=0</C>
                            </G>
                            <G> name='��������'
                                <C> name='���Ǽ�'  	ID='actual_room_cnt' HeadAlign=Center Width=40  align=right editlimit=7 show=true</C>
                                <C> name='������'  	ID='actual_rate'     HeadAlign=Center Width=40  align=right editlimit=40 show=true</C>
                                <C> name='�ο�'		ID='actual_persons'  HeadAlign=Center Width=40  align=right editlimit=7 show=true</C>
                                <C> name='����'		ID='CUST_RATE'     HeadAlign=Center Width=40  align=right editlimit=40 show=true MASK=XXXXX</C>
                                <C> name='ȯ����'		ID='REFUND_RATE'	   	Width=50   Edit=none align=Center align=Right dec=0</C>
                                <C> name='��ü���ɾ�'	ID='REFUND_AMT'        	Width=70   SumText=@sum Edit=none align=Right dec=0</C>
                                <C> name='ȯ�Ծ�'		ID='EARNING_AMT'       	Width=60   SumText=@sum Edit=none align=Right dec=0</C>
                                <C> name='��ü�Ϸ��'	ID='PAY_AMT'        Width=70   SumText=@sum Edit=none align=Right dec=0</C>
                            </G>
                            <C> name='�������'     ID='c_remarks'       HeadAlign=Center Width=300  align=left  show=true</C>
                            <C> name='����Ȯ��'     ID='f_emp_nm'        HeadAlign=Center Width=55  align=left show=true</C>
                            <C> name='����Ȯ���Ͻ�' ID='f_date'          HeadAlign=Center Width=80  align=left show=true</C>
                            <C> name='Ȯ����'       ID='c_emp_nm'        HeadAlign=Center Width=55  align=left show=true</C>
                            <C> name='Ȯ���Ͻ�'     ID='c_date'          HeadAlign=Center Width=80  align=left show=true</C>
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
                                                                                    