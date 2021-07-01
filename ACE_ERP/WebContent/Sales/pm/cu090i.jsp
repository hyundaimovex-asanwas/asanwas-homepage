<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�         : �����������
 * ���α׷�ID   : CU090I
 * J  S  P    : cu090i
 * �� �� ��        : Cu090I
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-06-14
 * �������     : ���� ��� ���� (��ȸ ��� ���� ����)
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
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU017";
        ds2.Reset(); 

        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU018";
        ds3.Reset(); 

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1,O:IMAGE=imgDs)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sCarNo="  + getObjectFirst("v_car_no").value + ","
            + "sCustNm=" + getObjectFirst("v_cust_nm").value +","
            + "sClientCd="  + getObjectFirst("v_client_cd").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���߰� (�׸��庰)
// Parameter    : 
%>
    function fnAddRow() {
        imgDs.AddRow();
        ds1.AddRow();
        fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ����� (�׸��庰)
// Parameter    : 
%>
    function fnDeleteRow() {
        ds1.DeleteRow(ds1.RowPosition);
        imgDs.DeleteRow(ds1.RowPosition);
        fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� 
// Parameter    : 
%>
    function fnApply() {
        if (ds1.IsUpdated || imgDs.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "CAR_NO")==""){
                    alert("������Ϲ�ȣ<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_no").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_TYPE")==""){
                    alert("���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_type").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_NM")==""){
                    alert("���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_nm").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_FORM")==""){
                    alert("����<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_form").focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_YEAR")==""){
                    alert("���<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_year").Focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_CC")==""){
                    alert("��ⷮ <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_cc").Focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_PERSONS")==""){
                    alert("�����ο� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_persons").Focus();
                    return;
                }
                if(ds1.NameValue(i, "MAX_KG")==""){
                    alert("�ִ����緮 <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("max_kg").Focus();
                    return;
                }
                if(ds1.NameValue(i, "CAR_TYPE_CD")==""){
                    alert("���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_type_cd").Focus();
                    return;
                }
                //�Ǽ����� ���ý� �����ȣ�� �ʼ� �Է��Դϴ�.
                if(ds1.NameValue(i, "CAR_TYPE_CD")=="5" && ds1.NameValue(i, "CAR_DNO")==""){
                    alert("�����ȣ <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_dno").focus();
                    return;
                }
                if(ds1.NameValue(i, "NORTH_YN")==""){
                    alert("���ʹ湮���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("north_yn").focus();
                    return;
                }
                if(ds1.NameValue(i, "NORTH_DATE")==""){
                    alert("���ʹ湮(����)��<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("north_date").focus();
                    return;
                }
                if(ds1.NameValue(i, "DRIVE_NO")==""){
                    alert("���������ȣ<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("drive_no").focus();
                    return;
                }
            }
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
                "JSP(I:REGIST=ds1,I:IMAGE=imgDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
        }else
            alert("����� ������ �����ϴ�.");
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
    function fnCancel() {
        ds1.undoall();
        imgDs.undoall();
        window. status="������ ������ ��ҵǾ����ϴ�.";
        fnScreenDisplay();
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �������� �˾�
%>
    function fnDrivePop() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnDriveInfoPop("<%=dirPath%>");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_drive_no.value = arrParam[0];
            v_cust_nm.value = arrParam[1];
        } else {
            v_drive_no.value = "";
            v_cust_nm.value = "";
        }               
    }

    function fnDrivePop1() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnDriveInfoPop("<%=dirPath%>");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            drive_no.value = arrParam[0];
            cust_nm.value = arrParam[1];
        } else {
            drive_no.value = "";
            cust_nm.value = "";
        }               
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
        }               
    }
    
    function fnClientFind1() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "CLIENT_SID") = arrParam[0];
            client_nm.value = arrParam[1];
            client_cd.value = arrParam[2];
        } else {
            if(getObjectFirst("ds1").RowStatus(getObjectFirst("ds1").RowPosition)==1){
                getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "CLIENT_SID") = 0;
                client_nm.value = "";
                client_cd.value = "";
            }
        }               
    }
    

    //ȭ�� ��� ����
    function fnScreenDisplay(){
        if(ds1.CountRow>0){
            gcip_file.Enable = "True";
            if(ds1.RowStatus(ds1.RowPosition) == "1")
                getObjectFirst("car_no").readOnly = false;
            else 
                getObjectFirst("car_no").readOnly = true;

            getObjectFirst("car_type").readOnly     = false;
            getObjectFirst("car_nm").readOnly       = false;
            getObjectFirst("car_form").readOnly     = false;
            getObjectFirst("car_year").Enable       = "True";
            getObjectFirst("car_cc").Enable         = "True";
            getObjectFirst("car_persons").Enable    = "True";
            getObjectFirst("max_kg").Enable         = "True";
            getObjectFirst("car_type_cd").Enable    = "True";
            getObjectFirst("car_dno").readOnly      = false;
            getObjectFirst("north_yn").Enable       = "True";
            getObjectFirst("north_date").Enable     = "True";
            getObjectFirst("cust_img").style.display = "inline";
            getObjectFirst("client_img").style.display = "inline";
        } else {
            gcip_file.Enable = "False";
            getObjectFirst("car_no").readOnly       = true;
            getObjectFirst("car_type").readOnly     = true;
            getObjectFirst("car_nm").readOnly       = true;
            getObjectFirst("car_form").readOnly     = true;
            getObjectFirst("car_year").Enable       = "False";
            getObjectFirst("car_cc").Enable         = "False";
            getObjectFirst("car_persons").Enable    = "False";
            getObjectFirst("max_kg").Enable         = "False";
            getObjectFirst("car_type_cd").Enable    = "False";
            getObjectFirst("car_dno").readOnly      = true;
            getObjectFirst("north_yn").Enable       = "False";
            getObjectFirst("north_date").Enable     = "False";
            getObjectFirst("cust_img").style.display = "none";
            getObjectFirst("client_img").style.display = "none";
        }
    }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language="javascript" for="gcip_file" event=OnClick()>
    var img_file_name = fn_trim(gcip_file.value);
    if (img_file_name!="") {
        var file_ext = img_file_name.substring(img_file_name.lastIndexOf('.')+1);
        if(file_ext=="JPG" || file_ext=="jpg")
            photo.src = gcip_file.value;
        else {
            alert("�������������� jpg ���ϸ� ��� �����մϴ�.");
            gcip_file.value = "";
            photo.src = "<%=dirPath%>/Sales/images/00000.gif";
        }
    }
</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  �۾�����
%>
        <script language="javascript" for="tr1" event="onsuccess()">
            window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
            document.all.LowerFrame.style.visibility="hidden";
            fnScreenDisplay();
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  �۾�����
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";

        var info_cnt = tr1.SrvErrCount("INFO");
        var info_msg = "";
        for(var i=0; i<info_cnt; i++){
            info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
        }
        if(info_msg!="") 
            alert("============= �ȳ� �޽���=============\n\n" + info_msg);
        
        fnScreenDisplay();           
    </script>
    
    <script language="javascript" for="tr1" event="OnFail()">
        window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";
        
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
        
        fnScreenDisplay();    
    </script>
<%
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�� 
%>
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�Ϸ�
%>
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
            document.all.LowerFrame.style.visibility="hidden";
            if( v_job!="H" && row < 1){
                alert("�˻��� ����Ÿ�� �����ϴ�."); 
            }
            fnScreenDisplay();
        </script>   
        <script language=JavaScript  for=imgDs event="OnLoadCompleted(row)">
            imgDs.RowPosition = ds1.RowPosition;
        </script>
        
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�� ���� 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
            window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
            document.all.LowerFrame.style.visibility="hidden";
        </script>
        
        <script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
            if(Row<1 || imgDs.CountRow<1) return;
            imgDs.RowPosition = Row;
            fnScreenDisplay();
            if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
                photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
            else 
                photo.src = "<%=dirPath%>/Sales/images/00000.gif";
        </script>
        <script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
            if(Row<1 || imgDs.CountRow<1) return;
            imgDs.RowPosition = Row;
            fnScreenDisplay();
            if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
                photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
            else 
                photo.src = "<%=dirPath%>/Sales/images/00000.gif";
        </script>

<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<table width="100%" border="0" cellspacing="0" cellpadding="0">

    <!--------------- �˻� ���� �� ��ư  ------------------------------------------->
    <tr>
        <td>
            <table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="500px">
                <tr>
                    <td width="100px" height="30px" class="text">������Ϲ�ȣ</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_car_no size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                    </td>
                
                    <td width="100px" height="30px" class="text">������</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_cust_nm size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                    </td>
                </tr>
                <tr>
                    <td width="100px" height="30px" class="text">���¾�ü�ڵ�</td>
                    <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
                        <input type="text" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                        <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                        <input type="text" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                    </td>
                </tr>
            </table>

            <!-- table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="500px">
                <tr>
                    <td width="100px" height="30px" class="text">������Ϲ�ȣ</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_car_no size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                    </td>
                </tr>
                <tr>
                    <td width="100px" height="30px" class="text">���������ȣ</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type="text" name="v_drive_no" size="20" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                        <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���������ȣ�� ��ȸ�մϴ�." align='absmiddle' onClick="fnDrivePop()">
                        <input type="text" name="v_cust_nm" size="10" class="input01" readonly>
                    </td>
                </tr>
            </table-->
        </td>
        <td align="right" valign="bottom" height="100%">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnAddRow()" >
                        <img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
                        <img src="<%=dirPath%>/Sales/images/save.gif"    style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
    <tr>
        <td height="10px"></td>
    </tr>

    <!--------------------------------- �� ����  ------------------------------>
    <tr>
        <td width="100%" colspan="6">
            <table  border="0" cellpadding="1" cellspacing="0" width="100%" >
                <tr>
                    <td  valign="top">
                        <table border="0" cellpadding="0" cellspacing="1" width="300px" >
                            <tr>
                                <td>
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=300px; height:420px" border="1">
                                        <param name="DataID"            value="ds1">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="false">
                                        <param name="Format"            value=" 
                                            <FC>name='������Ϲ�ȣ'    ID='CAR_NO'         Width=100   align=Left</FC>
                                            <C> name='���������ȣ'    ID='DRIVE_NO'       Width=100   align=Left</C>
                                            <C> name='�����ڸ�'       ID='CUST_NM'      Width=80    align=Left </C>
                                        ">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>                                     
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="10px"></td>
                    <td valign="top">
                        <table border="0" cellpadding="0" cellspacing="0" width="530px" bgcolor="#666666">
                            <tr bgcolor="#ffffff">
                                <td width="125px" bgcolor="#ffffff" valign=top>
                                    <table border="0" cellpadding="0" cellspacing="1" width="125px" height="130px" bgcolor="#666666">
                                        <tr bgcolor="#ffffff">
                                            <td width="125px" bgcolor="#ffffff"><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border=0 width="125px" height="130px"></td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td width="85px" align="center" bgcolor="#ffffff" align=absmiddle>
                                                <input type=hidden name=txt_file>
                                                <%=HDConstant.COMMENT_START%>
                                                <OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:125; height:20;">
                                                    <param name=Enable          value=False>
                                                    <param name="Text"      value="������� ã�ƺ���">
                                                </OBJECT>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="10px"></td>
                                <td width="390px" valign="top" >
                                    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666">
                                        <tr bgcolor="#ffffff">
                                            <td width='130px' height='30px'  class='boardt02'>������Ϲ�ȣ</td>
                                            <td align='absmiddle'>&nbsp;&nbsp;
                                                <input type=text name="car_no" size=28 id="car_no" maxlength="28" class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>����</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=car_type id=car_type size=20 maxlength=18 class="textbox" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>����</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=car_nm id=car_nm size=20 maxlength=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>����</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=car_form id=car_form size=20 maxlength=18 class="textbox" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>&nbsp;����</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=car_year classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                                    <param name=Enable      value=False>
                                                    <param name=Format      value="YYYY">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>&nbsp;���
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px' class='boardt02'>&nbsp;��ⷮ</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=car_cc classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                                    <param name=Enable      value=False>
                                                    <param name=Format      value="0000">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>&nbsp;CC
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>�����ο�</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=car_persons classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                                    <param name=Enable      value=False>
                                                    <param name=Format      value="00">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>&nbsp;��
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>�ִ����緮</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=max_kg classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                                    <param name=Enable      value=False>
                                                    <param name=Format      value="0000">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>&nbsp;Kg
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>����1</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=car_type_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds2>
                                                    <param name=Enable          value=False>
                                                    <param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
                                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>�����ȣ</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=car_dno id=car_dno size=20 maxlength=28 class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>���ʹ湮����</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=north_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=150 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds3>
                                                    <param name=Enable          value=False>
                                                    <param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
                                                    <param name=ListExprFormat  value="detail_nm^0^150">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>���ʹ湮(����)��</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=north_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                                    <param name=Enable      value=False>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <PARAM NAME=InputFormat value="YYYYMMDD">
                                                    <param name=Alignment   value=1>
                                                    <param name=ClipMode    value=true>
                                                    <param name=Border      value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>���������ȣ</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;&nbsp;
                                                <input type="text" name="drive_no" id="drive_no" size="15" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                                <img id="cust_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���������ȣ�� ��ȸ�մϴ�." align='absmiddle' onClick="fnDrivePop1()">
                                                <input type="text" name="cust_nm" id="cust_nm" size="10" class="input01" readonly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>���¾�ü</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;&nbsp;
                                                <input type="text" name="client_cd" id="client_cd" size="10" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                                <img id="client_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü ������ ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind1()">
                                                <input type="text" name="client_nm" id="client_nm" size="15" class="input01" readonly>
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
<%
/*=============================================================================
            Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
     <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="imgDs">
             <param name=BindInfo    value="
                <C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
              ">
     </object>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=CAR_NO         Ctrl=car_no        Param=value</C>
                <C>Col=CAR_TYPE       Ctrl=car_type      Param=value</C>
                <C>Col=CAR_NM         Ctrl=car_nm        Param=value</C>
                <C>Col=CAR_FORM       Ctrl=car_form      Param=value</C>
                <C>Col=CAR_YEAR       Ctrl=car_year      Param=Text</C>
                <C>Col=CAR_CC         Ctrl=car_cc        Param=Text</C>
                <C>Col=CAR_PERSONS    Ctrl=car_persons   Param=Text</C>
                <C>Col=MAX_KG         Ctrl=max_kg        Param=Text</C>
                <C>Col=CAR_TYPE_CD    Ctrl=car_type_cd   Param=BindColVal</C>
                <C>Col=CAR_DNO        Ctrl=car_dno       Param=value</C>
                <C>Col=NORTH_YN       Ctrl=north_yn      Param=BindColVal</C>
                <C>Col=NORTH_DATE     Ctrl=north_date    Param=Text</C>
                <C>Col=DRIVE_NO       Ctrl=drive_no      Param=value</C>
                <C>Col=CUST_NM        Ctrl=cust_nm       Param=value</C>
                <C>Col=CLIENT_CD      Ctrl=client_cd     Param=value</C>
                <C>Col=CLIENT_NM      Ctrl=client_nm     Param=value</C>
             ">
      </object>
<%=HDConstant.COMMENT_END%>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


