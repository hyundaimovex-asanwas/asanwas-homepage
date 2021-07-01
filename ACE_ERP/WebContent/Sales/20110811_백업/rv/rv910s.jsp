<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�         : �¶��� ������ �� ��������� ��ȸ
 * ���α׷�ID  : RV910s
 * J  S  P   : Rv910s
 * �� �� ��        : Rv910s
 * �� �� ��        : �ɵ���
 * �� �� ��        : 2006-11-15
 * �������     : �¶��� ������ �� ��������� ��ȸ
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-02-20][�ɵ���] ������ �׸��忡 ��й�ȣ ǥ��(�ݼ��� �ȳ���)
 * [2009-04-23][�ɵ���] ������ �׸��忡 ���� ���尡���ϵ��� ����. �÷����� ��
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
    date.add(java.util.Calendar.DATE, +0);
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
    c_cd = "99000";
    c_nm = "����ƻ� �¶���";    
    c_sid = "982";

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
//        getObjectFirst("ds_goods").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//       getObjectFirst("ds_goods").Reset();

		//2007-05-30 �¶��ο��� ����  by �ɵ��� 
		//�������� (����=Y, ����=N)
        codeDs1.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV032&s_item1=Y";
        codeDs1.Reset();

    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        if(getObjectFirst("v_client_cd").value==""){
            alert("�븮���� ���� �����Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        if(getObjectFirst("v_depart_date1").Text.trim()=="" || getObjectFirst("v_depart_date1").Text.trim().length!=8){
            alert("�˻�����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("v_depart_date1").Focus();
            return;
        }
        
        if(getObjectFirst("v_depart_date2").Text.trim()=="" || getObjectFirst("v_depart_date2").Text.trim().length!=8){
            alert("�˻�����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("v_depart_date2").Focus();
            return;
        }
        
        getObjectFirst("ds_detail").DeleteAll();
    
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_client_sid="+getObjectFirst("v_client_sid").value
                    + ",v_cond_gu="+ getObjectFirst("v_cond_gu").value
                    + ",v_depart_date1="+getObjectFirst("v_depart_date1").Text
                    + ",v_depart_date2="+getObjectFirst("v_depart_date2").Text
                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                    + ",v_cust_nm="+getObjectFirst("v_cust_nm").value;
//		alert(v_param);
//		return;                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
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
                    + ",v_accept_sid="+getObjectFirst("ds_main").NameValue(row, "ACCEPT_SID");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }
    
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : Master ���� ����
%>

    function fnApply() {
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
                	
        if (ds_main.IsUpdated) {
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv910S",
                "JSP(I:MAIN=ds_main,O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        } else {
            alert("���� ������ �����ϴ�.");
        }
        
        
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
        getObjectFirst("gr1").SetExcelTitle(1, "value:�¶��� ������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�¶��ο�������Ȳ", "�¶��ο�����Ȳ.xls", 8);

		/*
        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:�Աݳ��� ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("�Աݳ��� ��ȸ", "�Ա� ���Ա��� ��ȸ.xls", 32);
        */

    }
    </script>


<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//������ Ŭ���ϸ� ������ ȣ��
    if(Row==0) return;
    if(v_default_row==Row) return;
    fnSelectDetail(Row);
</script>

<script language=javascript for="gr2" event="OnDblClick(Row, Colid)">
//������ ����Ŭ�� 
//http://www.mtkumgang.com/asanway/upload/reservationUserUpload/�ֹι�ȣ.jpg
    if(Row==0) return;
	window.open("http://www.mtkumgang.com/asanway/upload/reservationUserUpload/"+getObjectFirst("ds_detail").NameValue(Row, "REGI_NO")+".jpg","pic","width=300,height=400");
</script>

<script language=javascript for="ds_main" event="OnLoadCompleted(row)">
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    } else {
	    fnSelectDetail(v_default_row);
	};
</script>

<script language=javascript for="ds_detail" event="OnLoadCompleted(row)">
    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<script language=JavaScript for=v_depart_date1 event=OnKillFocus()>
// �˻�����1���� ��Ŀ���ƿ��ϸ� �˻�����2�� ���� ��¥�� ����
	v_depart_date2.text = v_depart_date1.text;
</script>
<script language=JavaScript for=v_depart_date1 event=onKeyDown(kcode,scode)>
// (�˻�����1 ������)����Ű ������ ����2�� �̵��ϸ鼭 ��¥����
	if(kcode == 13) {
		v_depart_date2.text = v_depart_date1.text;	
		v_depart_date2.focus();
	}
</script>
<script language=JavaScript for=v_depart_date2 event=onKeyDown(kcode,scode)>
// (�˻�����2 ������)����Ű ������ ��ȸ ȣ��
	if(kcode == 13) fnSelect();
</script>
<script language=JavaScript for=v_accept_no event=onKeyDown(kcode,scode)>
// (��û����ȣ ������)����Ű ������ ��ȸ ȣ��
	if(kcode == 13) fnSelect();
</script>


<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    ds_main.ResetStatus();
    ds_detail.ResetStatus();
    
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>


<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="OnFail()">
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
</script>

<script language="javascript" for="tr2" event="OnFail()">
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
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<!-- �¶��ο������ -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                          	<td align=left width=300></td>
                          	<td align=right><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
	                          	<img src="<%=dirPath%>/Sales/images/save.gif" style="cursor:hand" onClick="fnApply()">
		                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()"></td>
                          </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">�븮���ڵ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" value="<%=c_cd%>" name="v_client_cd" id="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <input type="text" value="<%=c_nm%>" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" value="<%=c_sid%>" name="v_client_sid" readOnly>
                                </td>
                                <td width="100px" height="25px" class="text">�˻��� ����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<select name=v_cond_gu class="text">
                                        <option value="RESERVE">��������
                                        <option value="CLOSE">��������
                                        <option value="DEPART">�������                                        
                                    </select>
									&nbsp;<%=HDConstant.COMMENT_START%>
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
                                </td>
                                <td width="100px" height="25px" class="text">�����ڸ�</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="v_cust_nm" size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);" onkeydown="if(event.keyCode==13) fnSelect();"></td>
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
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=430; height:440px" border="1">
                            <param name="DataID"            value="ds_main">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <FC>name='��û����ȣ' ID='RACCEPT_NO' Width=100 SumText=@cnt  Edit=none align=RIGHT</FC>
                                <C> name='�������'   ID='RSTDT'    Width=60   SumText='��' Edit=none align=CENTER</C>
                                <C> name='��ǰ'       ID='RSCOD'   Width=50  Edit=none align=CENTER</C>
                                <C> name='����'       ID='RSTAT'   Width=80  editstyle=lookup data='codeDs1:detail:detail_nm'</C>
                                <C> name='������'     ID='RNAME'   Width=60   Edit=none align=CENTER</C>
                                <C> name='����ó'     ID='RMOB'    Width=85     Edit=none align=CENTER</C>
                                <C> name='�̸���'     ID='RMAIL'   Width=100   Edit=none align=Left </C>
                                <C> name='��й�ȣ'   ID='RPASS'   Width=60    Edit=none align=Left </C>
                                <C> name='�����Ͻ�'   ID='RDATE'   Width=100   Edit=none align=LEFT</C>
                                <C> name='��������'   ID='REDT'    Width=70   Edit=none align=center</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                    <td width="10">&nbsp;</td>
                    <td>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr2  style="width=385; height:440px" border="1">
                            <param name="DataID"            value="ds_detail">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <C> name='����' ID='CUST_NM'    Width=60  Edit=none align=Center sumtext=@cnt</C>
                                <C> name='�ֹι�ȣ' ID='REGI_NO'  Width=70  Edit=none align=left sumtext=��</C>
                                <C> name='�ǸŰ�' ID='USE_AMT'    Width=60  Edit=none align=right DECAO=0 sumtext=@sum</C>
                                <C> name='�Աݾ�' ID='PAY_AMT'    Width=60  Edit=none align=right DECAO=0 sumtext=@sum</C>

                                <C> name='����' ID='COMPANY_NM' Width=80  Edit=none align=LEFT</C>
                                <C> name='����' ID='POSITIONS'  Width=50  Edit=none align=LEFT</C>
                                <C> name='�ּ�1' ID='ADDRESS1'   Width=70  Edit=none align=LEFT</C>
                                <C> name='�ּ�2' ID='ADDRESS2'   Width=50  Edit=none align=LEFT</C>
                                <C> name='����' ID='STATUS_CD'  Width=40  Edit=none align=Center</C>
                                <C> name='�ڵ���' ID='MOBILE_NO'  Width=40  Edit=none align=LEFT</C>
                                <C> name='����\\��ȣ' ID='RSV_SID'    Width=40  Edit=none align=Center</C>
                                <C> name='��\\��ȣ' ID='CUST_SID'   Width=40  Edit=none align=Center</C>
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

