<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>����>�������>�۾�����>�۾� ��� �� �۾��Ϻ� ���ڰ���� 
 * J  S  P		 : si110i_h1.jsp
 * �� �� ��		 : Si110I_h1
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2014-06-13
 * [ �������� ][������] ����
 * [2014-06-13][�ɵ���] �ű� ���� : ��ȹ��� : �۾��Ϻ�. � ��Ÿ�Ϸ� �� ���ΰ�.
 *						���ڰ���� ��Ÿ�Ͻ�Ʈ ������
 * [2014-06-30][�ɵ���] ���ڰ��� ���� �׼��� ��� CONFIG. AP200I�� 
 *						���缱�� ����ڰ� �־�� ��ư�� �����ִ� �ɷ�....
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%> 

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	String v_dwr_sid = request.getParameter("v_dwr_sid");	//�۾��Ϻ� index
	String v_status	 = request.getParameter("v_status");	//������ �۾� ������ : ���� 010�ۼ���, 011�������������, 012�������Ϸ�
	String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//���縶���� sid : �ݷ��ÿ��� �������� ��°� �ƴϹǷ� �Ϻ� �ε����� ��ģ��.
%>
<!-- //body_s.jsp -->
<%@ page import="sales.org.common.request.SmartRequest"%>
<%
	SmartRequest sr = new SmartRequest(request);	
	//�α��� üũ : 2013-12-04 �ɵ��� ���� ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//������ �̵��� ����ID üũ(�̰� ������ ���� ���� ������?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//������ �̵��� ���Ǻ���("�α�") üũ
	String gusrip	= (String)session.getAttribute("vusrip");	//������ �̵��� IP���� üũ

%>

<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<meta http-equiv="Cache-control" content="no-cache"/>
		<meta http-equiv="Cache-control" content="no-store"/>
		<meta http-equiv="pragma" content="no-cache" />
		<meta name="viewport" content="width=1080" />
		<meta http-equiv="Content-Script-Type" content="text/javascript" />
		<meta http-equiv="Content-Style-Type" content="text/css" />
	
	<title>���ڰ��� : �۾��Ϻ���������������������������������������������������������������������������������������������������������������������������
	</title>
	<%
	/*=============================================================================
				Style Sheet, Common Java Script Link
	=============================================================================*/
	%>		
		<link href="<%=dirPath%>/Common/css30/basicPage.css" rel="stylesheet" type="text/css">
		<link href="<%=dirPath%>/Common/css30/ap_layout.css" rel="stylesheet" type="text/css">	<%//���ڰ�����... %>	
		
		<%// ���ڰ���� �ҽ� %>
		<script language="javascript" src="<%=dirPath%>/Config/common/js/ap_gauce.js"></script>
    

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	var v_status ="<%=v_status%>";
	<% //�������ε� %>
	function fnOnLoad(){
		cfStyleGrid(getObjectFirst("gr_wd"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail1"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail2"), "approval");
		cfStyleGrid(getObjectFirst("gr_detail3"), "approval");
		cfStyleGrid(getObjectFirst("gr_apline"), "apline");
		
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    gr_wd.RowHeight = "80";	//�׸��� �ο�����Ʈ ����

        ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        ds_gc_wdcode.Reset();	//�۾� ����(������) SI004
        ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        ds_gc_bskind.Reset();	//���� ���� CT001
        ds_gc_bpjob.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI006&s_item1=Y";
        ds_gc_bpjob.Reset();	//�����ο� ���� SI006
		ds_gc_aptype.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP005&s_item1=Y";
		ds_gc_aptype.Reset();	// �������� AP005 - �������� �����ڵ� �о����
		ds_gc_apsts_d.DataId = "<%=dirPath%><%=HDConstant.PATH_CONFIG_HELP%>Sy001H?proType=S&dsType=2&s_Head=AP003&s_item1=Y";
		ds_gc_apsts_d.Reset();	// �������_D AP003 - �������� �����ڵ� �о����

        
        fnSelect();
		
        if(v_status=="010"||v_status=="013"){ // �ۼ��� �Ǵ� �ΰ���� ������ ��� ���, �ݷ����� ���缱�� ����Կ��� �� �� �ִ�.
        	ln_SetDataHeader();	//���缱 ���
        	btn_apline.style.display="";	//���缱����
        	btn_new.style.display="";		//��� ��ư
        	btn_ing.style.display="none";		//����/�ݷ�
        }else if(v_status=="011"){	//��������������̸� ����|�ݷ� ���
        	fnSetApline(""); 			//�� ���缱 ��ȸ�ϱ�~!
        	btn_apline.style.display="none";	//���缱����
        	btn_new.style.display="none";		//��� ��ư
        	//btn_ing.style.display="";		//�̰� ���缱�� Ȯ���ϰ� ���� ����
        }else if(v_status=="012"){	//�������Ϸ�� �Ϸ���
        	fnSetApline(""); 			//�� ���缱 ��ȸ�ϱ�~!
        	btn_apline.style.display="none";	//���缱����
        	btn_new.style.display="none";		//��� ��ư
        	btn_ing.style.display="none";		//����/�ݼ�
        }else{
        	fnSetApline(""); 			//�� ���缱 ��ȸ�ϱ�~!
        }
        
    }
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_dwr_sid=<%=v_dwr_sid%>"
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_AP_DWR=ds_ap_dwr,O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            param);
        tr_post(tr1);
    }

    <%// ������ �׸��� ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_dwr_sid=<%=v_dwr_sid%>" ;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            v_param);
        tr_post(tr1);
    }
       		
	<% // ���缱 ���� ��%>
	function fnPopApline() {
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;
		var strPos;
		var sApproveLine;
		strURL = "<%=dirPath%>/Config/help/sy040h.jsp";
		strPos = "dialogWidth:620px;dialogHeight:500px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);
		fnSetApline(arrResult);
	}
	
	function fnSetApline(val){
		//alert("�޾ƿ� ���缱="+val);
		var apline_tot = new Array();
		var apline_row = new Array();

		if(val!=""){
			ds_apline.clearData();	//���� �����
			
			apline_tot=val.split(";");	// ���缱 �ະ�� ����
			//alert("���� ���缱 �� + 1�� == "+apline_tot.length);	// 1���̸� 2 ����.. ;�� �������� �� ������
			for(i=1;i<apline_tot.length;i++){
				apline_row = apline_tot[i-1].split("/");  // 1�����
				/*
				alert(apline_row.length);	//
				alert("�⺻���缱(1) : " + apline_row[0]);	//
				alert("���� : " + apline_row[1]);	//
				alert("�������� : " + apline_row[2]);	//
				alert("��� : " + apline_row[3]);	//
				alert("�̸� : " + apline_row[4]);	//
				alert("���� : " + apline_row[5]);	//
				alert("�μ� : " + apline_row[6]);	//
				alert("�� ���缱 SID : " + apline_row[7]);	//
				*/
				
				ds_apline.AddRow();
				ds_apline.NameValue(i, "SEQ") 				= apline_row[1];//����
				ds_apline.NameValue(i, "AP_TYPE") 			= apline_row[2];//��������
				ds_apline.NameValue(i, "ENO_NO")			= apline_row[3];//���
				ds_apline.NameValue(i, "ENO_NM") 			= apline_row[4];//�̸�
				ds_apline.NameValue(i, "JOB_NM") 			= apline_row[5];//����
				ds_apline.NameValue(i, "DPT_NM") 			= apline_row[6];//�μ�
				if(apline_row[1]==1){
					ds_apline.NameValue(i, "AP_STATUS_D") 	= "2";	//==���
					
				}else{
					ds_apline.NameValue(i, "AP_STATUS_D") 	= "1";	//==�̰�
				};
				ds_apline.NameValue(i, "U_DATE") 			= "";
				ds_apline.NameValue(i, "AP_DESC") 			= "";
			}
		}else{
			
	    	v_job="S_AP";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_dwr_sid=<%=v_dwr_sid%>"
				+ ",v_ap_m_sid=<%=v_ap_m_sid%>"	//���缱sid
				;
			
			//�� ���缱 ��ȸ�� Ap200I.java�� �ű�°� ���� ��.. -_-
	        ln_TRSetting(tr1, 
	        	"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",	
	            "JSP(O:DS_APLINE=ds_apline)",
	            param);
	        tr_post(tr1);
		}
	} 

	<% //���缱 �����ͼ� ��� %>
	function ln_SetDataHeader(){
		if (ds_apline.countrow<1){
			var s_temp = " SEQ: DECIMAL(5),ENO_NO:STRING(7),AP_TYPE:STRING(10),ENO_NM:STRING(30),"
					   + " DPT_NM:STRING(50),DPT_CD:STRING(10),JOB_NM:STRING(50),AP_STATUS_D:STRING(10), "
					   + " U_DATE:STRING(50), AP_DESC:STRING(100), SID:NUMERIC(10.0) ";
			ds_apline.SetDataHeader(s_temp);
		}
	}

	<% // ��� - �̰͵� Ap200I.java�� %>
	function fnApply_1() {
		if (ds_apline.countrow<1){
			alert("���缱�� ������ �Ŀ� ��� �����մϴ�.");
			return false;
		}
		v_job="A1";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
            + ",v_dwr_sid=<%=v_dwr_sid%>" ;	
		ln_TRSetting(tr2, 
			"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
    		"JSP(I:DS_APLINE=ds_apline)",	//���⿡ msgDs�� �־��µ� ó���� ���ϸ� tr2.onFail()�� �ν��Ѵ�. 2014-06-27
    		v_param);
		tr_post(tr2);
	}	
	<% // �ݼ� %>
	function fnApply_2() {
		if (ds_apline.countrow<1){
			alert("���缱 �����Դϴ�. ȭ���� ���ΰ�ħ���ּ���.");
			return false;
		}
	
		v_job="A2";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
            + ",v_dwr_sid=<%=v_dwr_sid%>,"
            + ",v_ap_m_sid="+ ds_apline.NameValue(0, "AP_M_SID");	
		ln_TRSetting(tr2, 
    		"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
    		"JSP(I:DS_APLINE=ds_apline)",	//
    		v_param);
		tr_post(tr2);
	}
	<% // ���� %>
	function fnApply_3() {
		if (ds_apline.countrow<1){
			alert("���缱 �����Դϴ�. ȭ���� ���ΰ�ħ���ּ���.");
			return false;
		}
		v_job="A3";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=3"
            + ",v_dwr_sid=<%=v_dwr_sid%>,"
            + ",v_ap_m_sid="+ ds_apline.NameValue(0, "AP_M_SID");	
		ln_TRSetting(tr2, 
				"<%=dirPath%><%=HDConstant.PATH_CONFIG_AP%>Ap200I",
	    		"JSP(I:DS_APLINE=ds_apline)",
    		v_param);
		tr_post(tr2);
	}	

	
	<% // â�ݱ�%>
	function  fnClose(){
		window.close();
		opener.fnSelect();
	}
    </script>


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr2" event="OnFail()">
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if((error_msg!="") && (error_msg!=null))
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
</script>
<script language="javascript" for="tr2" event="OnSuccess()">
	if(v_job=="A1"){
		alert("���������� ��ŵǾ����ϴ�.");
		fnClose(); // â�ݱ�
	}
	if(v_job=="A3"){
		alert("���� ó���Ǿ����ϴ�.");
		fnClose(); // â�ݱ�
	}
	if(v_job=="A2"){
		alert("�ݷ� ó���Ǿ����ϴ�.\n\n[Ȩ>����>����>�۾� ����>�Ϻ� ��ȸ]���� ��ȸ �� ������ �ּ���.");
		//fnClose(); // â�ݱ�
	}
</script>

<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="S_AP"&&v_status!="000"){	// ���缱 ��ȸ + ��ȸ��� �ƴ� ��
		for(i=1;i<=ds_apline.countrow;i++){	//1�����~
			// ��� ���°� �ƴϸ鼭 ����� �α� ����ڿ� ���� ����� ���� ��
			if(("2"!=ds_apline.NameValue(i, "AP_STATUS_D"))&&("<%=gusrid%>"==ds_apline.NameValue(i, "ENO_NO"))){
				btn_ing.style.display="";		//����, �ݼ� ��ư ���̱�	
			}
    		
		}
	}
</script>



<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_ap_dwr event="OnLoadCompleted(row)">
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_ap_dwr.ClearData();
			    ds_wd.ClearData();
			    ds_detail1.ClearData();
			    ds_detail2.ClearData();
			    ds_detail3.ClearData();
			}
		}
    </script>



    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_ap_dwr classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wm_chk classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_apline classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_wdcode classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bskind classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_aptype classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bpjob	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_apsts_d classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>



<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>

</head>



<body onLoad="fnOnLoad()">

<!-- table width�� �հ� 890�� ���� �ʵ���.. td�� border������ ������ �ٱ������� ���β���ŭ �÷�����! 
	10 890 10 �̷��� 
-->
<table border=0 cellpadding='0' cellspacing='0'>
  <tr>
  	<td width="10">&nbsp;</td>
  	<td width="890" class="t"><br>
	<table border="0" cellpadding="0" cellspacing="0">
	  <tr>
	  	<td class="t" height="70">
	  	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
	  	  <tr>
	  	  	<td width="200" class="l b "><img src="<%=dirPath%>/images/approval/2014start.gif" height="40"	 ><!-- width="299" height="100" --></td>
	  		<td width="490" class="c t bold"><span style="font-size:40px;">�� �� �� ��</span><br>
	  			<input type="text" name="site_nm" id="site_nm" class="hidden c" style="width:400px;" readOnly="readonly"></td>
	  		<td width="200" class="r b"><img src="<%=dirPath%>/images/approval/2014dreamit.gif" height="40" ><!-- width="222" height="100"  --></td>
	  	  </tr>
	  	</table>
	  	</td>
	  </tr>
	  <tr>
	  	<td class="t" >
		<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
			<tr height="20px">
				<td width="150px"  bgcolor="#ffffff" rowspan="2" align="center">&nbsp;
					<input type="text" name="w_date_nm" id="w_date_nm" class="hidden c bold" style="width:100px;" readOnly="readonly">
				</td>
				<td width="60px" class="text"  rowspan="2" >����</td>
				<td width="110px" bgcolor="#ffffff" rowspan="2" class="c">
					<input type="text" name="wed" id="wed" class="hidden c" style="width:80px;" readOnly="readonly">
				</td>
				<td width="80px" class="text" >�������</td>
				<td width="81px" bgcolor="#ffffff" align="center">
					<input type="text" name='TEMP_MIN' id="TEMP_MIN" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td width="79px" class="text"  rowspan="2" >������</td>
				<td width="60px" class="text" >��ȹ</td>
				<td width="80px" bgcolor="#ffffff" align="center">
					<input type="text" name='RATE_PLAN' id="RATE_PLAN" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td width="80px" class="text"  rowspan="2" >���</td>
				<td width="99px" bgcolor="#ffffff"  rowspan="2"  align="center">
					<input type="text" name='PROG_RATE' id="PROG_RATE" class="hidden c" style="width:74px;" readOnly="readonly"></td>																	
			</tr>

			<tr height="20px">
				<td class="text" >�ְ���</td>
				<td bgcolor="#ffffff" align="center">
					<input type="text" name="temp_max" id="temp_max" class="hidden c" style="width:50px;" readOnly="readonly"></td>
				<td class="text" >����</td>
				<td bgcolor="#ffffff" align="center">
					<input type="text" name='RATE_RESULT' id="RATE_RESULT" class="hidden c" style="width:50px;" readOnly="readonly"></td>
			</tr>
		</table>
	  	</td>
	  </tr>
      <tr>
		<td class="t" style="border-left:1px solid #666666;">
          <object id=gr_wd classid=<%=HDConstant.MxGrid_CLSID_S%> width='889px' height='340px' border="0">
              <param name="DataID"            value="ds_wd">
              <param name="Editable"          value="true">
              <param name="BorderStyle"       value="0">
              <param name="Format"            value="
                   <C> name='����'		ID='WD_CODE'	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wdcode:detail:detail_nm'</C>
                   <C> name='�����۾�'	ID='WD_NOW'   	width=386 	align=left	Edit=true  multiline=true</C>
                   <C> name='�����۾�'    ID='WD_POST'	width=403 	align=left	Edit=true  multiline=true</C>
           ">
          </object>
		</td>
      </tr>
      <tr>
		<td class="t">
		  <table border="0" cellpadding="0" cellspacing="0">
			<tr>
			  <td class="t" style="border-left:1px solid #666666;">
				<object id=gr_detail1 classid=<%=HDConstant.MxGrid_CLSID_S%> width='316px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail1">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='�ο�'
						<C> name='ȸ��'		ID='BP_NM'  width=80 	align=left  EditStyle=popup sumtext='�Ұ�'  </C>
						<C> name='ȸ��sid'	ID='BP_SID' width=80 	align=CENTER  edit=none  show=false suppress=1</C>
						<C> name='����sid'	ID='BID_SID' width=80 	align=CENTER  edit=none  show=false</C>
						<C> name='����'		ID='BID_SITE_KIND'   	width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bskind:detail:detail_nm'  suppress=1</C>
						<C> name='����'		ID='BP_JOB'  width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bpjob:detail:detail_nm'</C>
						<C> name='����'    	ID='NOW_COMMIT'		width=40 	align=right Edit=true decao=0 sumtext=@sum </C>
						<C> name='����'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum</C>
					</G>
                 	">
            	</object>   
              </td>
              <td class="t" style="border-left:1px solid #666666;">
            	<object id=gr_detail2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='256px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail2">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='���'
                         <C> name='���'		ID='ITEM_NM_S'		width=80 	align=left		sumtext='�Ұ�'  </C>
                         <C> name='���SID'		ID='ITEM_SID'		width=80 	align=CENTER edit=none  show=false</C>
                         <C> name='�԰�'		ID='ITEM_SIZE'   	width=60 	align=CENTER edit=none	Edit=None</C>
                         <C> name='����'    	ID='NOW_COMMIT'		width=40  	align=right edit=none decao=0  sumtext=@sum</C>
                         <C> name='����'    	ID='TOT_COMMIT'		width=60 	align=right edit=none decao=0 sumtext=@sum</C>
					</G>
                 	">                             
            	</object>   
              </td>
              <td class="t" style="border-right:1px solid #666666;border-left:1px solid #666666;">
            	<object id=gr_detail3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='314px' height='140px' border='0'>
	                <param name="DataID"            value="ds_detail3">
	                <param name="ColSizing"         value="false">
	                <param name="Editable"          value="true">
	                <param name="SuppressOption"    value="1">
	                <param name="BorderStyle"       value="0">
	                <param name="ViewSummary"       value="1">
	                <param name="Format"            value="
					<G> name='�ֿ�����' 
					<C> name='ǰ��'		ID='ITEM_NM'		width=80 	align=left   EditStyle=popup	sumtext='�Ұ�'  </C>
					<C> name='ǰ��SID'	ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
					<C> name='�԰�'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
					<C> name='����'		ID='ITEM_UNIT'   	width=58 	align=CENTER	Edit=None</C>
					<C> name='����'    	ID='NOW_COMMIT'		width=40 	align=right	Edit=true decao=0  sumtext=@sum</C>
					<C> name='����'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum</C>
					</G>
                 	">                             
				</object>   
			  </td>
			</tr>
		  </table>
		</td>
	  </tr>
	  <tr>
    	<td class="t" style="border:1px solid #666666;">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		  <tr>
			<td width="160px" class="text" style="border-right:1px solid #666666;">���� ��û����</td>
			<td bgcolor="#ffffff" align="center" >
				<textarea name="remark" id="remark"  class="hidden" style="width:100%;height:52px"></textarea>
			</td>
		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
		<td class="t">
			<!-- ���� -->
			<table border="0" cellpadding="0" cellspacing="0" align=center>
			  <tr>
				<td height=30 class="l">
					<span id=btn_apline style="display:none;">
				  		<img src="<%=dirPath%>/Sales/images/btn_apline.gif"	align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnPopApline();">
				  	</span>
				</td>
				<td class="r">
					<span id=btn_new style="display:none;">
				    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
				    </span>
				    <span id=btn_ing style="display:none;">
				    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_3();">
				    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif" style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
				     </span>
				</td>
			  </tr>
			  <tr>
				<td width=890 colspan=2 style="border:1px solid #666666;">
					<object id=gr_apline classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='120px' border='0'>
						<param name="DataID"		    value="ds_apline">
						<param name="ColSizing"	    value="true">
						<param name="Fillarea"		    value="false">
						<param name="Editable"		    value="true">
						<param name="BorderStyle"	value="0">
						<param name=SortView  		    value="Left">
						<param name="SuppressOption"    value="1">
						<param name="Format" 			value="
						  <C> name='����SID'   ID='ap_m_sid'   	    width=80	align=left editlimit=5 show=FALSE edit=none    </C>
						  <C> name='����'     	ID=SEQ		       width=40	align=center editlimit=2 show=true edit=none</C>
						  <C> name='����'     	ID=AP_TYPE	       width=55	align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' edit=none</C>
			              <C> name='������'    	ID=ENO_NM		   	width=79 	align=center editlimit=50 show=true edit=none</C>
			              <C> name='���'    	ID=ENO_NO		   	width=80 	align=center editlimit=50 show=false edit=none</C>
			              <C> name='����'		ID=JOB_NM		    width=90 	align=center editlimit=20 show=true edit=none</C>
			              <C> name='�μ�'    	ID=DPT_NM	   	    width=180 	align=center editlimit=16 show=true edit=none</C>
			              <C> name='����'     	ID=AP_STATUS_D	    width=60 	align=center EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm' edit=none</C>
			              <C> name='�����Ͻ�'	ID=U_DATE			width=120 	align=center editlimit=50 show=true edit=none</C>
			              <C> name='�ǰ�'	    ID=AP_DESC     		width=248	align=center editlimit=200 show=true edit=true</C>
						">
					</object>   
					
				</td>
			  </tr>
			</table>
			
			
			</td>
        </tr>        

	  <tr height="28">
	  	<td class="b c" ><img src="<%=dirPath%>/images/approval/2014ci.gif"	height="24" ></td>
	  </tr>
	</table>  	
  	</td>
  	<td width="10">&nbsp;</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.MxBinder_CLASSID%>>
	             <param name="DataId" value="ds_ap_dwr">
	             <param name=BindInfo    value="
					<C>Col=SITE_SID    		Ctrl=site_sid		Param=Value </C>
					<C>Col=SITE_NM       	Ctrl=site_nm       Param=Value </C>
					<C>Col=W_DATE_NM		Ctrl=w_date_nm     Param=Value </C>
					<C>Col=WED      		Ctrl=wed			Param=Value </C>
					<C>Col=TEMP_MAX       	Ctrl=TEMP_MAX      Param=Value </C>
					<C>Col=TEMP_MIN        	Ctrl=TEMP_MIN       Param=Value </C>
					<C>Col=RATE_PLAN		Ctrl=RATE_PLAN  	Param=Value </C>
					<C>Col=RATE_RESULT		Ctrl=RATE_RESULT    Param=Value </C>
					<C>Col=PROG_RATE	    Ctrl=PROG_RATE     Param=Value </C>
					<C>Col=MAN_PRE       	Ctrl=man_pre       Param=Text </C>
					<C>Col=MACHINE_PRE      Ctrl=machine_pre   Param=Text </C>
					<C>Col=MAN_NOW     		Ctrl=man_now   Param=Text </C>
					<C>Col=MACHINE_NOW  	Ctrl=machine_now    Param=Text </C>
					<C>Col=W_PRE        	Ctrl=w_pre        Param=Value </C>
					<C>Col=W_NOW    		Ctrl=w_now    	Param=Value </C>
					<C>Col=W_REMARK   		Ctrl=w_remark	Param=Value </C>
					<C>Col=REMARK   		Ctrl=remark		Param=Value </C>
	              ">
	      </object>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
</body>
</html>

		