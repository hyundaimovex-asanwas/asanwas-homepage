<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�         : �Ա�/���Ա��� ��ȸ
 * ���α׷�ID       : RV330I
 * J  S  P      : Rv330i
 * �� �� ��        : Rv330i
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-06-28
 * �������     : �Ա�/���Ա��� ��ȸ
 * ��������     : 
 * �� �� ��        : �迵��
 * ������������   : 2006-06-28 
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-02-20][�ɵ���] ������� ���� ��ũ���� 
 *										���� Ȯ���� ��.. �ֱ�.
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
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
    String firstday = m_today.format(date.getTime());           
    date.add(java.util.Calendar.DATE, +2);
    String endDay = m_today.format(date.getTime());

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
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
        var v_default_row = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ �ε� 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

        fnInit(); 
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : ����ȸ 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        cfStyleGrid(getObjectFirst("gr2"), "comn1");
        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        getObjectFirst("ds_goods").Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        /*if(getObjectFirst("v_client_cd").value==""){
            alert("�븮���� ���� �����Ͻñ� �ٶ��ϴ�.");
            return;
        }*/
        
        if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("v_depart_date1").Focus();
            return;
        }
        
        if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("v_depart_date2").Focus();
            return;
        }
        
        getObjectFirst("ds_detail").DeleteAll();
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_client_sid="+getObjectFirst("v_client_sid").value
                    + ",v_goods_sid="+v_goods.ValueOfIndex ("GOODS_SID", v_goods.Index)
                    + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                    + ",v_depart_date2="+getObjectFirst("v_depart_date2").Text
                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                    + ",v_ipkum_gu="+ getObjectFirst("v_ipkum_gu").value
                    + ",v_pay_gubn="+ getObjectFirst("v_pay_gubn").value
                    + ",v_cust_nm="+getObjectFirst("v_cust_nm").value;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv330S",
            "JSP(O:DEFAULT=ds_main)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  Detail ��ȸ
// Parameter    : 
%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rsv_sid="+getObjectFirst("ds_main").NameValue(row, "RSV_SID")
                    + ",v_pay_gubn="+getObjectFirst("ds_main").NameValue(row, "OPTION_YN");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv330S",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ��� 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_main.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�Ա�/���Ա��� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�Աݹ��Ա��� ��ȸ", "�Ա� ���Ա��� ��ȸ.xls", 32);

        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:�Աݳ��� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("�Աݳ��� ��ȸ", "�Ա� ���Ա��� ��ȸ.xls", 32);

    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            v_client_sid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          v_client_sid.value = "";
        }               
    }
    
    /**
     * ��û�� ��ȣ ��ȸ
     */
    function fnAcceptNoPopup(){
        v_cust_row = 0;
        var arrResult   = new Array();
        arrResult = fnAcceptNoPop("<%=dirPath%>");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("v_accept_sid").value = arrParam[0];
            getObjectFirst("v_accept_no").Text   = arrParam[1];
        }
    }

<%
////////////////////////////////////////////////////////////////////////////////
// Description �Աݹ�� ���� �˾�

%>    

 function fnConfirmView(dir) {
	var arrParam    = new Array();
    var arrResult   = new Array();
	
	var accept_no = ds_main.namevalue(ds_main.rowposition,"ACCEPT_NO");
	var rsv_sid = ds_main.namevalue(ds_main.rowposition,"RSV_SID");	

	var pay_sid = ds_detail.namevalue(ds_detail.rowposition, "PAY_SID1");
	var pay_manage_no = ds_detail.namevalue(ds_detail.rowposition, "PAY_MANAGE_NO");
	var pay_cd = ds_detail.namevalue(ds_detail.rowposition,"PAY_CD");
	var pay_date = ds_detail.namevalue(ds_detail.rowposition,"PAY_DATE");
	

			        
		if (pay_sid == "020") { // �������
			var strURL = dir+"/Sales/help/rv007h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "030") { // ������ü
			var strURL = dir+"/Sales/help/rv008h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "040") { // �ſ�ī��
			var strURL = dir+"/Sales/help/rv009h.jsp?accept_no="+accept_no+"&rsv_sid="+rsv_sid+"&pay_manage_no="+pay_manage_no+"&pay_cd="+pay_cd+"&pay_date="+pay_date;
		} else if (pay_sid == "060") { // ��ǰ��
			var strURL = dir+"/Sales/help/rv010h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "080") { // �������Ա�
			var strURL = dir+"/Sales/help/rv014h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else if (pay_sid == "090") { // ��Ÿ��ü
			var strURL = dir+"/Sales/help/rv015h.jsp?pay_sid="+pay_sid+"&pay_manage_no="+pay_manage_no;
		} else {
			return;
		}

    var strPos = "dialogWidth:500px;dialogHeight:585px;status:no;scroll:no;resizable:no";
    
    arrResult =  showModalDialog(strURL,arrParam,strPos); 
        
    }
    
    
	//����Ȯ����  �˾�(�Ա���)
	function popConfirm(rsv_sid){
		var receiptURL ="http://www.mtkumgang.com/preserv/res_print.jsp?rsv_sid=" + rsv_sid;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=670,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	}
	//����Ȯ����  �˾�(���Ա���)
	function popConfirm2(rsv_sid){
		var receiptURL ="http://www.mtkumgang.com/preserv/res_print2.jsp?rsv_sid=" + rsv_sid;
	   	window.open(receiptURL,"rsvConfirm","width=730,height=300,scrollbars=yes,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
	}	
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=JavaScript for=v_depart_date1 event=OnKillFocus()>
   if( v_depart_date1.Modified == true )
		v_depart_date2.text = v_depart_date1.text;
</script>	


<script language=javascript for="ds_goods" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=javascript for="ds_goods" event="OnLoadError()">
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_SAVE_ERR%>");
</script>

<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//���ʹ�ư Ŭ���ϸ� ������ ���̱�
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>
<script language=JavaScript for="gr1" event="OnRButtonUp(Row, Colid, xpos, ypos)">
//������ư Ŭ���ϸ� Ȯ���� ���
	if(ds_main.namevalue(Row, "GOODS_SID")==57||ds_main.namevalue(Row, "GOODS_SID")==58||ds_main.namevalue(Row, "GOODS_SID")==59){
	 	if(ds_main.namevalue(Row, "TOT_TOUR_AMT") - ds_main.namevalue(Row, "TOT_PAY_AMT") == 0) {
		 	popConfirm(ds_main.namevalue(Row, "RSV_SID"));	//�Ա���
	 	}else{
		 	popConfirm2(ds_main.namevalue(Row, "RSV_SID"));	//���Ա�
	 	};
	}else{
		alert("�����Ǹ� ��ǰ�� Ȯ������ ���� �� �ֽ��ϴ�.");
	};
</script>

<script language=javascript for="ds_main" event="OnLoadCompleted(row)">
    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    fnSelectDetail(v_default_row);
</script>


<script language=javascript for="gr2" event="OnClick(Row, Colid)">
    if(Row<1) return;
    fnConfirmView('<%=dirPath%>');
</script>
<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="tr2" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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
<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds_main classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">�븮���ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <%if(v_ut.equals("")){%>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                                    <%}%>
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td width="100px" height="25px" class="text">�۾�����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_ipkum_gu class="text">
                                        <option value="">��ü
                                        <option value="T">�Ա���
                                        <option value="F">���Ա���
                                    </select>
                                    <select name=v_pay_gubn class="text">
                                        <option value="N">�������
                                        <option value="Y">OPTION���
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">��ǰ�ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=180 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_goods>
                                        <param name=EditExprFormat  value="%,%,%;goods_sid,goods_cd,goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^150">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            
                                <td width="100px" height="25px" class="text">�������</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_depart_date1 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>&nbsp;~&nbsp;
                                    <object id=v_depart_date2 classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=endDay%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="25px" class="text">��û����ȣ</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='120px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%><input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                                </td>
                                <td width="100px" height="25px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=580; height:380px" border="1">
                            <param name="DataID"            value="ds_main">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <FC> name='�������'       ID='DEPART_DATE'    Width=70   Edit=none align=Left suppress=1</FC>
                                <C> name='��û��ȣ'       ID='VIEW_ACCEPT_NO'      Width=110   SumText='���������ݾ�' Edit=none align=Left suppress=3</C>
                                <C> name='����'           ID='CUST_NM'        Width=60   Edit=none align=Left suppress=4</C>
                                <C> name='�������'    	ID='STATUS_CD'      width=60 	align=left 		Edit=None</C>
                                <C> name='����\\�ڵ�'     ID='ROOM_TYPE'   Width=50   Edit=none align=Left suppress=5</C>
                                <C> name='����\\�ڵ�'     ID='CUST_TYPE'   Width=50   Edit=none align=Left suppress=6</C>
                                <C> name='�ǸŰ�'         ID='TOT_TOUR_AMT'   Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
                                <C> name='�Աݾ�'         ID='TOT_PAY_AMT'    Width=70   SumText=@sum Edit=none align=Right Dec=0</C>
                                <C> name='��ǰ'          ID='GOODS_NM'       Width=100  Edit=none align=Left suppress=2</C>
                                <C> name='�ֹ�/���ǹ�ȣ'  ID='MANAGE_NO'      Width=100   Edit=none align=Left</C>
                                
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                    <td width="10">&nbsp;</td>
                    <td>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=255; height:380px" border="1">
                            <param name="DataID"            value="ds_detail">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <C> name='�Ա�����'        ID='VIEW_PAY_DATE'   Width=65   Edit=none align=Left suppress=1</C>
                                <C> name='�Ա�\\���'      ID='PAY_CD_NM'       Width=40   Edit=none align=Left</C>
                                <C> name='�Ա�\\����'      ID='PAY_YN'          Width=35   Edit=none align=Center</C>
                                <C> name='ȸ��\\����'      ID='ACCT_GUBN_NM'    Width=40   Edit=none align=Center</C>
                                <C> name='�Աݾ�'          ID='PAY_AMT'         Width=60   SumText=@sum  Edit=none align=Right dec=0</C>
                                <C> name='������ȣ'        ID='PAY_MANAGE_NO'   Width=100  Edit=none align=Left Dec=0</C>
                                <C> name='PAY_SID'        ID='PAY_SID1'   	Width=100  Edit=none align=Left show=false</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
	  <tr>
		<td>���� ���� GRID�� ���� <b>��</b> Ŭ���ϸ� ���� GRID�� <b><font color="blue">��������</font>�� ǥ��</b>�˴ϴ�.<br>
				���� ���� GRID�� ���� <b>����</b> Ŭ���ϸ� <b><font color="blue">����Ȯ����</font>�� ���</b>�մϴ�.<br>
		</td>
	  </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

