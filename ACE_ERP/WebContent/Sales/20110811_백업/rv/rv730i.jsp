<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��������ȣ  �ο�
 * ���α׷�ID 	 : RV730I
 * J  S  P		 : rm730i
 * �� �� ��		 : RM730I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-07-03
 * �������		 : ��������ȣ  �ο� (��ȸ, ����, ���)
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
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv730I",
            "JSP(O:DS5=ds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�
	
        //�������
        ds8.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV001&s_item1=Y";
        ds8.Reset();
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
	            + "sDepartTime=" + ds_time.namevalue(ds_time.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
                + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams") + ","
                + "sStatus=" + ds8.namevalue(ds8.rowposition,"detail") + ","
	            + "sCustNm=" + sCustNm.value;
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv730I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ���ð�, ��ǰ��ȸ
	 */
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                    + ",sDepartDate=" + sBgnDate.Text;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
            v_param);
        tr_post(tr1);
	}
	
	/*
	 * �� ��ȸ
	 */
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
			+ "sDepartDate=" + sBgnDate.text + ","
            + "sDepartTime=" + ds_time.namevalue(ds_time.rowposition,"depart_time");
        ln_TRSetting(tr3,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv730I",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}

	/*
	 * �� ��ȸ
	 */
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sDepartDate=" + sBgnDate.text + ","
            + "sDepartTime=" + ds_time.namevalue(ds_time.rowposition,"depart_time") + ","
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv730I",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}

	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){
	        v_job = "I";
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	         ln_TRSetting(tr1,
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv730I",
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
	/*
	 * ��ȣ����
	 */
	function fnEraser() {
		for( i=1; i<=ds1.CountRow; i++ ) {
			ds1.namevalue(i,"tour_no") = '';
			ds1.namevalue(i,"page_no") = '';
		}
	}
	/*
	 * �ϰ�����
	 */
	function fnCreate() {
		var tour_no=1;		//������ no
		var page_no=1;	//Page no
		var count=0;
		for( i=1; i<=ds1.CountRow; i++ ) {
			if ((i > 1) && ((ds1.namevalue(i-1,"class") != ds1.namevalue(i,"class")) || (ds1.namevalue(i-1,"teams") != ds1.namevalue(i,"teams")))) {	//���� Row�� ���� ���� Row�� ���� �ٸ����
				tour_no=1;
			}
			if ((i > 1) && ((ds1.namevalue(i-1,"class") != ds1.namevalue(i,"class")) || (ds1.namevalue(i-1,"teams") != ds1.namevalue(i,"teams")))) {     // ���� Row�� ��, ���� ���� Row�� ��, ���� �ٸ����
				page_no++;
				count=0;
			}
			if ( count == 5 ) {
				page_no++;
				count =0;
			}
			if ( ds1.namevalue(i,"class") == '99' ) {
				if ( tour_no < 10 )
					ds1.namevalue(i,"tour_no") = "00"+tour_no;
				else if ( tour_no < 100 )
					ds1.namevalue(i,"tour_no") = "0"+tour_no;
				else
					ds1.namevalue(i,"tour_no") = tour_no;
			} else {
				if ( tour_no < 10 )
					ds1.namevalue(i,"tour_no") = "0"+tour_no;
				else
					ds1.namevalue(i,"tour_no") = tour_no;
			}
			ds1.namevalue(i,"page_no") = page_no;
			tour_no++;
			count++;
		}
	}
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( div != 'init' ) {	//�������
				if ( sBgnDate.Modified ) {
					div = 'init';
					fnSelectDs3();
				}
			}
		</script>

		<script language=JavaScript for= lc_saup event=OnSelChange()>
			alert(div);
			if ( div != 'init' ) {	//����
				div = 'init';
				fnSelectDs3();
			}
		</script>

		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div != 'init' ) {	//���ð�
				div = 'init';
				fnSelectDs6();
			}
		</script>

        <script language=JavaScript for= lc3 event=OnSelChange()>
            if ( div != 'init' ) {  //��ǰ
                div = 'init';
                fnSelectDs6();
            }
        </script>

		<script language=JavaScript for= lc5 event=OnSelChange()>
			if ( div != 'init' ) {	//��
				div = 'init';
				fnSelectDs7();
			}
		</script>

		<script language=javascript for="gr1" event="OnClick(Row,Colid)">
	        if(Row==0){
	            if(ds1.CountRow==0) return;

	            gr1.ReDraw = "False";
	            if(Colid=="confirm_yn"){
	                for(var i=1; i<=ds1.CountRow; i++){
	                    ds1.NameValue(i, "confirm_yn") = ds1.NameValue(1, "confirm_yn");
	                }
	            }
	            gr1.ReDraw = "True";
	            return;
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        //�����޽��� ó��
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	totalNum.value = ds1.CountRow;
</script>

<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDs3();
</script>

<script language=JavaScript  for=ds_time event="OnLoadCompleted(row)">
		fnSelectDs6();
</script>

<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div=''
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
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">
												<img src="<%=dirPath%>/Sales/images/eraser.gif"   	style="cursor:hand" onclick="fnEraser()">
												<img src="<%=dirPath%>/Sales/images/bundle.gif"		style="cursor:hand" onClick="fnCreate();">
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
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d" height=26>
			            					<td align=left class="text" width=70>&nbsp;����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_saup>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^100"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left class="text"  width="70"><b>�������</b></td>
			                                <td align=left bgcolor="#ffffff">&nbsp;
  												<%=HDConstant.COMMENT_START%>
  												<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Format 		value="0000-00-00">
													<param name=Cursor	 	value="iBeam">
													<param name=Border	 	value="false">
													<param name=InheritColor      value="true">
													<param name=ReadOnly  	value="false">
													<param name=SelectAll  	value="true">
													<param name=SelectAllOnClick  	value="true">
													<param name=SelectAllOnClickAny  	value="false">
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_time>
													<param name=BindColumn      value="depart_time">
                                                    <param name=BindColVal      value="depart_time">
													<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^50"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
			            					<td align=left class="text" width=70>&nbsp;��ǰ����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_goods>
													<param name=BindColumn      value="goods_sid">
                                                    <param name=BindColVal      value="goods_sid">
													<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;
											</td>
			            					<td align=left class="text" width="70">��/��</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc5 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="class">
                                                    <param name=BindColVal      value="class">
													<param name=EditExprFormat	value="%,%;class,class_nm">
													<param name=ListExprFormat  value="class_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc6 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
													<param name=BindColumn      value="teams">
                                                    <param name=BindColVal      value="teams">
													<param name=EditExprFormat	value="%,%;teams,teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
										</tr>
			                            <tr bgcolor="#6f7f8d" height=26>
		            						<td align=left class="text" width=70>&nbsp;������</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
											<%=HDConstant.COMMENT_START%>
					                            <object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100"></object>
												<%=HDConstant.COMMENT_END%>
											</td>
		            						<td align=left class="text" width="70">�̸�</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;
												<input id="sCustNm" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;">
											</td>
                                            <td align=left class="text" width=70>&nbsp;����</td>
                                            <td align=left bgcolor="#ffffff" valign="middle" colspan="3">&nbsp;
                                            <%=HDConstant.COMMENT_START%>
                                                <object id=lc7 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds8>
                                                    <param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
                                                    <param name=EditExprFormat  value="%,%;detail,detail_nm">
                                                    <param name=ListExprFormat  value="detail_nm^0^100"></object>
                                                <%=HDConstant.COMMENT_END%>
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
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
				                           <C> name='No'    ID='{String(CURROW)}'    Width=40 BgColor=#996699  Edit=none align=Center</C>
							               <C> name='��'        ID='class'       width=40 BgColor=#fefec0  align=right editlimit=3 edit=none show=true sort=true</C>
							               <C> name='��'        ID='teams'      width=40  BgColor=#fefec0 align=right editlimit=3 edit=none show=true sort=true</C>
							               <C> name='������-No'      ID='tour_no'     width=80 align=right editlimit=20 show=true sort=true</C>
							               <C> name='Page-No'      ID='page_no'     width=75  align=right editlimit=5 show=true sort=true</C>
							               <C> name='������'      ID='confirm_yn'     width=40 align=center EditStyle=CheckBox CheckBoxText='' HeadCheck=false HeadCheckShow=False</C>
							               <C> name='������'    ID='upjang_nm'   width=100 BgColor=#fefec0 align=left editlimit=10 edit=none show=true sort=true</C>
							               <C> name='����Ÿ��' ID='room_type_cd'        width=140 BgColor=#fefec0 align=left editlimit=10 edit=none show=true sort=true</C>
							               <C> name='����'      ID='cust_nm'     width=70 BgColor=#fefec0 align=left editlimit=30 edit=none show=true</C>
							               <C> name='�ֹι�ȣ'    ID='manage_no'   width=100 BgColor=#fefec0 align=center editlimit=20 edit=none show=true </C>
							               <C> name='������'   ID='cust_gu_nm'  width=60 BgColor=#fefec0 align=left editlimit=50 edit=none show=true</C>
							               <C> name='����'    ID='status_cd'   width=50 BgColor=#fefec0 align=center editlimit=2 edit=none show=true</C>
							               <C> name='��û����ȣ'    ID='accept_no'   width=115 BgColor=#fefec0 align=center editlimit=15 edit=none show=true sort=true</C>
            				               <C> name='��ǰ'     ID='goods_nm'    width=100 BgColor=#fefec0 align=left editlimit=60 edit=none show=true</C>
							               <C> name='�ּ�'     ID='address1'    width=170 BgColor=#fefec0 align=left editlimit=60 edit=none show=true</C>
							               <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
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
	<tr id="total">
		<td width="845px" height="30" class="textbox" style="border:0">
			�ѰǼ� : <input type="text" name="totalNum" style="border:0;align=left" width="20">
		</td>
	</tr>
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

