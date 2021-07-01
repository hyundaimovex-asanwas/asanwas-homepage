<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�         : �����������
 * ���α׷�ID   	: CU090I
 * J  S  P    		: cu090i
 * �� �� ��        	: Cu090I
 * �� �� ��        	: �迵��
 * �� �� ��        	: 2006-06-14
 * �������     	: ���� ��� ���� (��ȸ ��� ���� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-02-09][�ڰ汹] [��������] ������ ���ε��� �� �ֵ��� ����
 * [2010-04-19][�ɵ���] ���� ���ε带 42�� ���������� ����.. ů.. (�������� ����������)
 * [2015-09-17][�ɵ���] [���� ž��] �޴� �̿��ϸ鼭 �⺻ �����ڸ� ������ �ʿ� ����
 *						�ٵ� �������� ��� ����? ���� ���� ���� ��û�� �ʿ��� �� �ƴ�����, ������ �ʿ� �� ����� ���
 * [2015-10-01][�ɵ���] ���� �ϰ� ��Ͽ� ���� �׸� ����
 * [2015-11-11][�ɵ���] ���� ��Ϲ�ȣ 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="sales.menu.cu.*"%>
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
        
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU017&s_item1=Y";
        ds2.Reset(); //����1(*)
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU018&s_item1=Y";
        ds3.Reset(); //���ʹ湮����
        ds_tt_car_type.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU026&s_item1=Y";
        ds_tt_car_type.Reset();	//���� ���� ����
        ds_tt_gubn.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU027&s_item1=Y";
        ds_tt_gubn.Reset();	//���� ���� ����
        ds_tt_start.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU029&s_item1=Y";
        ds_tt_start.Reset();	//���� ������ �����
        
        ds_tt_site.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU030&s_item1=Y";
        ds_tt_site.Reset();	//���� ��������
        ds_tt_issue.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU031&s_item1=Y";
        ds_tt_issue.Reset();	//���� ������ ����ó
        ds_tt_use.Dataid = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&dsType=2&s_Head=CU028&s_item1=Y";
        ds_tt_use.Reset();	//���� ����뵵
        
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sCarNo="  + getObjectFirst("v_car_no").value + ","
            + "sClientCd="  + getObjectFirst("v_client_cd").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
            "JSP(O:DEFAULT=ds1)",
            param);
		tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���߰� (�׸��庰)
// Parameter    : 
%>
    function fnAddRow() {
		ds1.AddRow();
		if(ds1.CountRow>0){	//��ȸ�Ѱ� ������ 1���� ���¾�ü�� �״�� -20150917
			//alert(1);
			getObjectFirst("client_cd").value = ds1.NameValue(1, "CLIENT_CD");
			getObjectFirst("client_nm").value = ds1.NameValue(1, "CLIENT_NM");
			ds1.NameValue(ds1.RowPosition, "CLIENT_SID") = ds1.NameValue(1, "CLIENT_SID");
		}
        fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ����� (�׸��庰)
// Parameter    : 
%>
    function fnDeleteRow() {
        ds1.DeleteRow(ds1.RowPosition);
		fnScreenDisplay();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� 
// Parameter    : 
%>
    function fnApply() {
        if (ds1.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "CAR_NO")==""){
                    alert("������Ϲ�ȣ<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("car_no").focus();
                    return;
                }
                if(ds1.NameValue(i, "TT_CAR_TYPE")==""){
                    alert("���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirs("tt_car_type").focus();
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


                if(ds1.NameValue(i, "NORTH_YN")==""){
                    alert("���ʹ湮���� <%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("north_yn").focus();
                    return;
                }
            }
            
            //alert(rate_tt_car_kg.text);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu090I",
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
// Description :  �������� �˾�
%>
    function fnDrivePop() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnDriveInfoPop("<%=dirPath%>");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_drive_no.value = arrParam[0];
            
        } else {
            v_drive_no.value = "";
            
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
    function fnClientFindTT() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "TT_CLIENT_SID") = arrParam[0];
            tt_client_nm.value = arrParam[1];
            
        } else {
            if(getObjectFirst("ds1").RowStatus(getObjectFirst("ds1").RowPosition)==1){
                getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "TT_CLIENT_SID") = 0;
                ttclient_nm.value = "";
            }
        }               
    }    
    

    //ȭ�� ��� ����
    function fnScreenDisplay(){
        if(ds1.CountRow>0){
            //if(ds1.RowStatus(ds1.RowPosition) == "1")	//���߰� �ÿ��� ���� �����ϰ� ��������.
                getObjectFirst("car_no").readOnly = false;
            //else 
                //getObjectFirst("car_no").readOnly = true;

            getObjectFirst("car_nm").readOnly       = false;
            getObjectFirst("rate_tt_car_kg").Enable      = "True";
            getObjectFirst("tt_car_type").Enable    = "True";            
            getObjectFirst("car_persons").Enable    = "True";
            getObjectFirst("tt_client_img").style.display = "inline";	// ���� �Ҽ� ã�� ��ư
            getObjectFirst("tt_bgndate").Enable     = "True";
            getObjectFirst("tt_enddate").Enable     = "True";
            getObjectFirst("tt_gubn").Enable       	= "True";
            getObjectFirst("tt_count").Enable       = "True";
            getObjectFirst("tt_start").Enable       = "True";
            getObjectFirst("tt_site").Enable       	= "True";
            getObjectFirst("tt_issue").Enable       = "True";
            getObjectFirst("tt_use").Enable     	= "True";
            getObjectFirst("tt_cf_bgndate").Enable     = "True";
            getObjectFirst("tt_cf_enddate").Enable     = "True";
            
            
            getObjectFirst("car_form").readOnly     = false;
            getObjectFirst("car_year").Enable       = "True";
            getObjectFirst("car_cc").Enable         = "True";
            //getObjectFirst("max_kg").Enable         = "True";
            getObjectFirst("car_dno").readOnly      = false;
            getObjectFirst("north_yn").Enable       = "True";
            //getObjectFirst("car_type_cd").Enable    = "True";
            getObjectFirst("client_img").style.display = "inline";	// ���¾�ü ã�� ��ư
        } else {

            getObjectFirst("car_no").readOnly       = true;
            getObjectFirst("car_nm").readOnly       = true;
            getObjectFirst("rate_tt_car_kg").Enable      = "False";
            getObjectFirst("tt_car_type").Enable    = "False";            
            getObjectFirst("car_persons").Enable    = "False";
            getObjectFirst("tt_client_img").style.display = "none";	// ���� �Ҽ� ã�� ��ư
            getObjectFirst("tt_bgndate").Enable     = "False";
            getObjectFirst("tt_enddate").Enable     = "False";
            getObjectFirst("tt_gubn").Enable       	= "False";
            getObjectFirst("tt_count").Enable       = "False";
            getObjectFirst("tt_start").Enable       = "False";
            getObjectFirst("tt_site").Enable       	= "False";
            getObjectFirst("tt_issue").Enable       = "False";
            getObjectFirst("tt_use").Enable     	= "False";
            getObjectFirst("tt_cf_bgndate").Enable     = "False";
            getObjectFirst("tt_cf_enddate").Enable     = "False";
            
            getObjectFirst("car_form").readOnly     = true;
            getObjectFirst("car_year").Enable       = "False";
            getObjectFirst("car_cc").Enable         = "False";
            //getObjectFirst("max_kg").Enable         = "False";
            getObjectFirst("car_dno").readOnly      = true;
            getObjectFirst("north_yn").Enable       = "False";
            //getObjectFirst("car_type_cd").Enable    = "False";
            getObjectFirst("client_img").style.display = "none";	// ���¾�ü ã�� ��ư
        }
    }


	//2010-04-19 ��������� ���ε�â ------------------------------------------
	function fnUploadPop_carLcs(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/carLcs_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}

	//2010-04-19 �������� ���ε�â ------------------------------------------
	function fnUploadPop_carIns(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/carIns_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}
	    
    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
        photo.src  = "<%=HDConstant.PIC_PATH_CAR%>"+ds1.NameValue(Row,"car_no")+".JPG";
        photo2.src = "<%=HDConstant.PIC_PATH_CAR%>"+ds1.NameValue(Row,"car_no")+"_����.JPG";
        
	</script>


<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  �۾�����
%>
        <script language="javascript" for="tr1" event="onsuccess()">
            msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
            
            fnScreenDisplay();
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  �۾�����
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
        

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
        msgTxt.innerHTML="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
        
        
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
            msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
             
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�Ϸ�
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ��ȸ�� ���� 
%>      
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
            msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
            
        </script>
        


<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_tt_car_type classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_gubn classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_start classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_site classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_issue classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_tt_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

    
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


	<table width="1002px" border="0" cellspacing="0" cellpadding="0">
	  <tr>
        <td align="right" height="30px">
			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;" onclick="fnSelect()">
			<img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:pointer;" onClick="fnAddRow()" >
			<img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:pointer;" onClick="fnDeleteRow()" >
			<img src="<%=dirPath%>/Sales/images/save.gif"    style="cursor:pointer;" onClick="fnApply()">
			<img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:pointer;" onClick="fnCancel()">
        </td>
      </tr>
    
	  <tr>
        <td>
            <table  width="1002px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                <tr>
                    <td width="150px" height="30px" class="text">���¾�ü �ڵ� | ��</td>
                    <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
                        <input type="text" name="v_client_cd" size="6" maxlength="5" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
                        <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                        <input type="text" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                    </td>

                    <td width="100px" height="30px" class="text">������Ϲ�ȣ</td>
                    <td align="left" bgcolor="#ffffff">&nbsp;
                        <input type=text name=v_car_no size="20" maxlength="20" class="textbox"  onkeydown="if(event.keyCode==13) fnSelect();">
                    </td>
                </tr>
            </table>
        </td>
	  </tr>

      <tr>
        <td height="10px"></td>
      </tr>

      <tr>
        <td width="100%" colspan="6">

			<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
              <tr>
				<td WIDTH="350px" valign="top">
		             <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width:350px; height:420px" border="1">
		                 <param name="DataID"            value="ds1">
		                 <param name="BorderStyle"       value="0">
		                 <param name="ColSizing"         value="true">
		                 <param name="editable"          value="false">
		                 <param name="SuppressOption"    value="1">
		                 <param name="SortView"  		 value="Right">
		                 <param name="ViewSummary"  	 value="1">
		                 <param name="Format"            value=" 
		                     <C>name='���»��'    	 ID='CLIENT_NM' Width=80   align=Left	sort=true suppress='1' SumText='��' SumTextAlign='right' </C>
		                     <C>name='������Ϲ�ȣ'	 ID='CAR_NO'     Width=90   align=Left	sort=true SumText=@count SumTextAlign='right' </C>
		                     <C>name='����'  		 ID='TT_CAR_TYPE'	 Width=70 	 align=Left	sort=true SumText='��' SumTextAlign='left' editstyle=lookup data= 'ds_tt_car_type:DETAIL:DETAIL_NM' </C>
		                     <C>name='����'      	 ID='CAR_NM'     Width=90    align=Left sort=true </C>
		                 ">
		             </object>
				</td>
                <td width="5px"></td>
                <td valign="top"><!-- ���Ͼ��ε�κ�... -->
					<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_carLcs()" style="cursor:pointer">[���������]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=26></td></tr>
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_carIns()" style="cursor:pointer">[��������]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center ><img id="photo2" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=25></td></tr>
					</table>
				</td>
				<td width="5px"></td>
                <td width="530px" valign="top" >
                
                
                    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666">
                        <tr bgcolor="#ffffff">
                            <td colspan=4 class='boardt02'>���� - ������ν�û</td>
                        </tr>

                        <tr bgcolor="#ffffff">
                            <td width='130px' height='30px'  class='boardt02'>������Ϲ�ȣ(*)</td>
                            <td align='absmiddle'>&nbsp;<input type=text name="car_no" size=20 id="car_no" maxlength="28" class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                            </td>
                            <td width='100px' height='30px'  class='boardt02'>���� ��Ī(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;<input type=text name=car_nm id=car_nm size=18 maxlength=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);" readOnly>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>�����߷�(��)(*)  </td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=rate_tt_car_kg classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;">
									<param name=Text        value="">
	                                <param name=Alignment   value=2>
	                                <param name=VAlign	    value=1>
	                                <param name=Numeric  	value="true">
	                                	<param name=MaxLength	value=3>
										<param name=MaxDecimalPlace	value=1>
	                                <param name=Border      value="false">      
	                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
	                                <param name=ReadOnly    value="false">
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">			                    </object>&nbsp;Ton
                            </td>
                            <td height='30px'  class='boardt02'>���� ����(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=tt_car_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_car_type>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>��������(��)(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_persons classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='17px' width='40px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=2>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">
                                </object>
                                &nbsp;��
                            </td>
                            <td height='30px'  class='boardt02'>�����Ҽ�(*)  </td>
                            <td bgcolor='#ffffff'>&nbsp;<input type="text" name="tt_client_nm" id="tt_client_nm" size="15" class="input01" readonly  onkeydown="if(event.keyCode==13) fnClientFindTT();">
								<img id="tt_client_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="���¾�ü ������ ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFindTT()">
                                <input type=hidden name=tt_client_sid id=tt_client_sid size=16 maxlength=18  readOnly>
                            </td>

                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>����Ⱓ(*)  </td>
                            <td colspan=3 bgcolor='#ffffff'>&nbsp;
		                        <object id=tt_bgndate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>&nbsp;~&nbsp; 
		                        <object id=tt_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>
                            </td>
                        </tr>
    
                        <tr>
                            <td height='30px'  class='boardt02'>���౸��(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_gubn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_gubn>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>����Ƚ��(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=tt_count classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='17px' width='40px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=2>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">
                                </object>
                                &nbsp;ȸ
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>������-�����(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_start classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_start>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>��������(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_site classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_site>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>��������������ó(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_issue classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_issue>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^100">
                                </object>
                            </td>
                            <td height='30px'  class='boardt02'>����뵵(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;                                
                                <object id=tt_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds_tt_use>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^120">
                                </object>
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>���� �Ⱓ</td>
                            <td colspan=3 bgcolor='#ffffff'>&nbsp;
		                        <object id=tt_cf_bgndate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>&nbsp;~&nbsp; 
		                        <object id=tt_cf_enddate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=90 align=center class="textbox">
		                           <param name=Text value="">
		                           <param name=Alignment value=1>
		                           <param name=Format value="0000-00-00">
		                           <param name=Cursor value="iBeam">
		                           <param name=Border value="0">
		                           <param name=InheritColor value="true">
		                           <param name=ReadOnly value="false">
		                           <param name=SelectAll value="true">
		                           <param name=SelectAllOnClick value="true">
		                           <param name=SelectAllOnClickAny value="false">
		                        </object>
                            </td>
                        </tr>
                        
                        <tr bgcolor="#ffffff">
                            <td colspan=4 class='boardt02'>ERP - �����������</td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>����(*)</td>
                            <td bgcolor='#ffffff'>
                            	&nbsp;<input type=text name=car_form id=car_form size=20 maxlength=18 class="textbox" OnKeyUp="cfLengthCheck(this, 18);" readOnly>
                            </td>
                            <td height='30px'  class='boardt02'>&nbsp;����(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_year classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=4>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false"> 
                                </object>
                                &nbsp;���
                            </td>
                        </tr>
                        <tr>
                            <td height='30px'  class='boardt02'>���ʹ湮����(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=north_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                    <param name=ComboDataID     value=ds3>
                                    <param name=Enable          value=False>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^150">
                                </object>
                            </td>
                            <td height='30px' class='boardt02'>&nbsp;��ⷮ(*)</td>
                            <td bgcolor='#ffffff'>&nbsp;
                                <object id=car_cc classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                                    <param name=Enable      value=False>
                                    <param name=MaxLength	value=5>
                                    <param name=Alignment   value=2>
	                                <param name=VAlign	    value=2>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
	                                <param name=SelectAll   value="true">
	                                <param name=SelectAllOnClick    value="true">
	                                <param name=SelectAllOnClickAny   value="false">                                    
                                </object>
                                &nbsp;CC
                            </td>
                        </tr>
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>�����ȣ</td>
                            <td colspan=3 bgcolor='#ffffff'>
                            	&nbsp;<input type=text name=car_dno id=car_dno size=20 maxlength=28 class="textbox" OnKeyUp="cfLengthCheck(this, 28);" readOnly>
                                * �Ǽ����� �ʼ�
                            </td>
                        </tr>
                        <!-- <tr>
                            <td width='130px' height='30px'  class='boardt02'>���������ȣ</td>
                            <td align="left" bgcolor="#ffffff">&nbsp;&nbsp;
                                <input type="text" name="drive_no" id="drive_no" size="15" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                <img id="cust_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="���������ȣ�� ��ȸ�մϴ�." align='absmiddle' onClick="fnDrivePop1()">
                                <input type="text" name="cust_nm" id="cust_nm" size="10" class="input01" readonly>
                            </td>
                        </tr>-->
                        <tr>
                            <td width='130px' height='30px'  class='boardt02'>���¾�ü(*)</td>
                            <td colspan=3 align="left" bgcolor="#ffffff">&nbsp;<input type="text" name="client_cd" id="client_cd" size="10" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);" onkeydown="if(event.keyCode==13) fnClientFind1();">
                                <img id="client_img" src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" alt="���¾�ü ������ ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind1()">
                                <input type="text" name="client_nm" id="client_nm" size="15" class="input01" readonly>
                            </td>
                        </tr>
                    </table>

				</td>
			  </tr>
        	</table>
		</td>
      </tr>
      <tr>
		<td>�� �ڵ�, ������Ϲ�ȣ ������ EnterŰ ������ �ٷ� ��ȸ�մϴ�.<br>
		�� (*)�׸��� �ʼ� �Է� �׸��Դϴ�. (���� = ���Դ���� ������ ����, ���淡���)
     
		</td>
      </tr>
	</table>
<%
/*=============================================================================
            Bind ����
=============================================================================*/
%>

     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=CAR_NO         Ctrl=car_no        Param=value</C>
                <C>Col=TT_CAR_TYPE    Ctrl=tt_car_type   Param=value</C>
                <C>Col=CAR_NM         Ctrl=car_nm        Param=value</C>
                <C>Col=CAR_FORM       Ctrl=car_form      Param=value</C>
                <C>Col=CAR_YEAR       Ctrl=car_year      Param=Text</C>
                <C>Col=CAR_CC         Ctrl=car_cc        Param=Text</C>
                <C>Col=CAR_PERSONS    Ctrl=car_persons   Param=Text</C>
                <C>Col=CAR_DNO        Ctrl=car_dno       Param=value</C>
                <C>Col=NORTH_YN       Ctrl=north_yn      Param=BindColVal</C>
                <C>Col=CUST_NM        Ctrl=cust_nm       Param=value</C>
                <C>Col=CLIENT_CD      Ctrl=client_cd     Param=value</C>
                <C>Col=CLIENT_NM      Ctrl=client_nm     Param=value</C>

                
                <C>Col=TT_CAR_TYPE		Ctrl=tt_car_type	Param=BindColVal</C>
                <C>Col=RATE_TT_CAR_KG	Ctrl=rate_tt_car_kg		Param=Text</C>
				<C>Col=TT_GUBN			Ctrl=tt_gubn		Param=BindColVal</C>
                <C>Col=TT_BGNDATE		Ctrl=tt_bgndate		Param=Text</C>
                <C>Col=TT_ENDDATE		Ctrl=tt_enddate		Param=Text</C>
                <C>Col=TT_CLIENT_SID    Ctrl=tt_client_sid	Param=value</C>
                <C>Col=TT_CLIENT_NM		Ctrl=tt_client_nm	Param=value</C>
                <C>Col=TT_CAR_TYPE		Ctrl=tt_car_type	Param=BindColVal</C>
                <C>Col=TT_COUNT		    Ctrl=tt_count		Param=Text</C>
                <C>Col=TT_USE			Ctrl=tt_use			Param=BindColVal</C>
                <C>Col=TT_START			Ctrl=tt_start		Param=BindColVal</C>
                <C>Col=TT_SITE			Ctrl=tt_site		Param=BindColVal</C>
                <C>Col=TT_ISSUE			Ctrl=tt_issue		Param=BindColVal</C>
				<C>Col=TT_CF_BGNDATE	Ctrl=tt_cf_bgndate		Param=Text</C>
                <C>Col=TT_CF_ENDDATE	Ctrl=tt_cf_enddate		Param=Text</C>
             ">
      </object>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


