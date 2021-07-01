<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ������
 * ���α׷�ID 	: CU100I
 * J  S  P		: cu100i
 * �� �� ��		: Cu100I
 * �� �� ��		: �迵��
 * �� �� ��		: 2006-06-13
 * �������		: �������� ��� ���� (��ȸ ��� ���� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-04-16][�ɵ���] �������� ���ε� ����(�̹��� ���ε� 42�� ������)
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
// Description 	:  ������ �ε� 
// Parameter 	: 
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

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU007";
        ds2.Reset(); //�����ڵ�

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu100I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
	function fnSelect() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sClientCd="  + getObjectFirst("sClientSid").value + ","
            + "sDriveNo=" + getObjectFirst("v_drive_no").value + ","
            + "sCustNm=" + getObjectFirst("v_cust_nm").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu100I",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
	function fnAddRow() {
		ds1.AddRow();
        fnScreenDisplay();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	: 
%>
	function fnDeleteRow() {
		ds1.DeleteRow(ds1.RowPosition);
        fnScreenDisplay();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
	function fnApply() {
		if (ds1.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "DRIVE_NO")==""){
                    alert("�������� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("drive_no").focus();
                    return;
                }
                if(ds1.NameValue(i, "CUST_SID")==""){
                    alert("������ <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("cust_img").focus();
                    return;
                }
                if(ds1.NameValue(i, "LICENSE_DATE")==""){
                    alert("�������� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("license_date").Focus();
                    return;
                }
                if(ds1.NameValue(i, "RENEWAL_DATE")==""){
                    alert("���űⰣ <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("renewal_date").Focus();
                    return;
                }
                if(ds1.NameValue(i, "LICENSE_TYPE")==""){
                    alert("�������� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("license_type").Focus();
                    return;
                }
            }
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu100I",
                "JSP(I:REGIST=ds1)",
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
		window. status="������ ������ ��ҵǾ����ϴ�.";
        fnScreenDisplay();
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ������
%>
    function fnCustInfo() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnCustInfoPop("<%=dirPath%>", "1");
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            ds1.NameValue(ds1.RowPosition, "CUST_SID") = arrParam[0];
            manage_no.value = arrParam[1];
            cust_nm.value   = arrParam[2];
            client_cd.value = arrParam[3];
            client_nm.value = arrParam[4];
        } else {
            ds1.NameValue(ds1.RowPosition, "CUST_SID") = "";
            manage_no.value = "";
            cust_nm.value   = "";
            client_cd.value = "";
            client_nm.value = "";
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
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          sClientSid.value = "";
        }               
    }
    
    //ȭ�� ��� ����
    function fnScreenDisplay(){
        if(ds1.CountRow>0){
//            gcip_file.Enable = "True";
            if(ds1.RowStatus(ds1.RowPosition) == "1")
                getObjectFirst("drive_no").readOnly = false;
            else 
                getObjectFirst("drive_no").readOnly = true;
//alert(ds1.RowStatus(ds1.RowPosition) + " : " + getObjectFirst("drive_no").readOnly);

            getObjectFirst("cust_img").style.display = "inline";
            getObjectFirst("license_date").Enable = "True";
            getObjectFirst("renewal_date").Enable = "True";
            getObjectFirst("license_type").Enable = "True";
        } else {
//            gcip_file.Enable = "False";
            getObjectFirst("drive_no").readOnly = true;
            getObjectFirst("cust_img").style.display = "none";
            getObjectFirst("license_date").Enable = "False";
            getObjectFirst("renewal_date").Enable = "False";
            getObjectFirst("license_type").Enable = "False";
        }
    }


	<%//2010-04-16 ������ ���ε�â ------------------------------------------%>
	function fnUploadPop_drvLcs(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/drvLcs_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
            document.all.LowerFrame.style.visibility="hidden";
            fnScreenDisplay();
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
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
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			if( v_job!="H" && row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
            fnScreenDisplay();
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
        
        <script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
		    if(Row<1) return;
            fnScreenDisplay();
	        photo.src  = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO_FULL").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO_FULL")+"_����.JPG";

        </script>
        
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="845" border="0" cellspacing="0" cellpadding="0">

    <!--------------- �˻� ���� �� ��ư  ------------------------------------------->
    <tr height="60px">
        <td>
            <table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="500px">
                <tr>
                    <td width="100px" height="30px" class="text">���������ȣ</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_drive_no size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
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
                        <input type="hidden" name="sClientSid" value="">
                    </td>
                </tr>
            </table>
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
    
    <tr height="10px">
        <td></td>
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
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=300px; height:440px" border="1">
                                        <param name="DataID"            value="ds1">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="false">
                                        <param name="Format"            value=" 
                                            <FC>name='���������ȣ'    ID='DRIVE_NO'         Width=120  align=Left</FC>
                                            <C> name='�����ڸ�'       ID='CUST_NM'          Width=80   align=Left</C>
                                            <C> name='���¾�ü'       ID='CLIENT_NM'        Width=80  align=Left </C>
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
                            <tr width="520px" bgcolor="#ffffff">
                                <td width="103px" bgcolor="#ffffff" valign=top>

                                            
									<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
									  <tr bgcolor="#ffffff">
										<td align=center height='25px' class='boardt02' onclick="fnUploadPop_drvLcs()" style="cursor:hand">���� ������</td>
									  </tr>
									  <tr bgcolor="#ffffff">
										<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="113px"></td>
									  </tr>
									</table>

                                </td>
                                <td width="10px"></td>
                                <td width="400" valign="top" >
                                    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666">
                                        <tr bgcolor="#ffffff">
                                            <td width='130px' height='30px'  class='boardt02'>���������ȣ</td>
                                            <td align=absmiddle >&nbsp;&nbsp;
                                                <input type=text name="drive_no" size=20 id="drive_no" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>�����ڸ�</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=cust_nm id=cust_nm size=10 maxlength=18 class="input01" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                                                <img src="<%=dirPath%>/Sales/images/help.gif" id="cust_img" style="cursor:hand;display:none" alt="�������� ��ȸ�մϴ�." align='absmiddle' onClick="fnCustInfo()">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>�ֹ�/���ǹ�ȣ</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=manage_no id=manage_no size=20 maxlength=18 class="input01" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>���¾�ü�ڵ�</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <input type=text name=client_cd id=client_cd size=10 maxlength=5 class="input01" readonly OnKeyUp="cfLengthCheck(this, 5);" readOnly>
                                                <input type=text name="client_nm" id="client_nm" size=15 class="input01" readonly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width='130px' height='30px'  class='boardt02'>��������</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=license_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                    <param name=Enable          value=False>
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
                                            <td width='130px' height='30px'  class='boardt02'>���űⰣ</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=renewal_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                    <param name=Enable          value=False>
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
                                            <td width='130px' height='30px'  class='boardt02'>���������ڵ�</td>
                                            <td bgcolor='#ffffff'>&nbsp;&nbsp;
                                                <%=HDConstant.COMMENT_START%>
                                                <object id=license_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=130 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds2>
                                                    <param name=Enable          value=False>
                                                    <param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
                                                    <param name=ListExprFormat  value="detail_nm^0^150">
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

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=DRIVE_NO           Ctrl=drive_no           Param=value</C>
                <C>Col=CUST_NM            Ctrl=cust_nm            Param=value</C>
                <C>Col=MANAGE_NO          Ctrl=manage_no          Param=value</C>
                <C>Col=CLIENT_CD          Ctrl=client_cd          Param=value</C>
                <C>Col=CLIENT_NM          Ctrl=client_nm          Param=value</C>
                <C>Col=LICENSE_DATE       Ctrl=license_date       Param=Text</C>
                <C>Col=RENEWAL_DATE       Ctrl=renewal_date       Param=Text</C>
                <C>Col=LICENSE_TYPE       Ctrl=license_type       Param=BindColVal</C>
             ">
      </object>
<%=HDConstant.COMMENT_END%>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


