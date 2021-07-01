<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>�������>�ŷ�ó ����>����ȸ�� ����>����ȸ�� ���
 * ���α׷�ID 	 : PMS/BC010I
 * J  S  P		 : bc010i.jsp
 * �� �� ��		 : Bc010I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2013-11-27
 * [ �������� ][������] ����
 * [2013-11-27][�ɵ���] �ű� ���� 
 * [2013-11-28][�ɵ���] ��ũ��Ʈ�� �־�� �մϴ�. ����/���� �׽�Ʈ �Ϸ�
 *****************************************************************************/

 ///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
    var v_job = ""; 	//Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
    var v_job1 = ""; 	//Transaction Job�� �Ӽ�����. �ű����� �׳� �������� �����Ϸ���

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_credit"), "comn");
		cfStyleGrid(getObjectFirst("gr_cashflow"), "comn");
		cfStyleGrid(getObjectFirst("gr_lic"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    sc_ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT018&s_item1=Y";
        sc_ds_in_cstr_kind.Reset(); //�˻�����/��ϰ���

        ds_lic_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT019&s_item1=Y";
        ds_lic_kind.Reset(); //��������

        sc_ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY006&s_item1=Y";
        sc_ds_loc_place.Reset(); //�˻�����/������

        ds_credit_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT021&s_item1=Y";
        ds_credit_grd.Reset(); //�ſ���

        ds_cashflow_grd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT022&s_item1=Y";
        ds_cashflow_grd.Reset();	//�����帧
        
        ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT018&s_item1=Y";
        ds_in_cstr_kind.Reset(); //��ϰ���
        ds_in_yn.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010&s_item1=Y";
        ds_in_yn.Reset(); //��Ͽ���
        ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY006&s_item1=Y";
        ds_loc_place.Reset(); //������
        ds_rcmd_man.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT006&s_item1=Y";
        ds_rcmd_man.Reset();	//��õ�μ�

		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
			+ ",v_bp_sid=-1"
			+ ",v_in_cstr_kind="
			+ ",v_lic_kind="
			+ ",v_loc_place="
			+ ",v_cstr_eval_fee_fr=0"
			+ ",v_cstr_eval_fee_to=0"
			+ ",v_credit_grd="
			+ ",v_cashflow_grd="
			+ ",v_in_yn=";
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)",
            param);
           
        tr_post(tr1);
    }
    
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_default.IsUpdated){	//}	 || ds_tender.IsUpdated) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
			v_job="S";
			var in_yn = "N";
	    	if(sc_v_in_yn.checked){
	    		in_yn="Y";	//��ϵ� �͸�
	    	}
		    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_bp_sid="+ sc_v_bp_sid.value
				+ ",v_in_cstr_kind=" + sc_lc_in_cstr_kind.ValueOfIndex("detail", sc_lc_in_cstr_kind.Index)
				+ ",v_lic_kind=" + sc_lc_lic_kind.ValueOfIndex("detail", sc_lc_lic_kind.Index)
				+ ",v_loc_place=" + sc_lc_loc_place.ValueOfIndex("detail", sc_lc_loc_place.Index)
				+ ",v_cstr_eval_fee_fr=" + sc_eme_cstr_eval_fee_fr.text
				+ ",v_cstr_eval_fee_to=" + sc_eme_cstr_eval_fee_to.text
				+ ",v_credit_grd=" + sc_lc_credit_grd.ValueOfIndex("detail", sc_lc_credit_grd.Index)
				+ ",v_cashflow_grd=" + sc_lc_cashflow_grd.ValueOfIndex("detail", sc_lc_cashflow_grd.Index)
				+ ",v_in_yn=" + in_yn;

	        //alert(param);
	        
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
		};
    }    

    <%// ������ �׸��� ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bp_sid="+getObjectFirst("ds_default").NameValue(row, "bp_sid");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
            "JSP(O:DS_GR_CREDIT=ds_gr_credit,O:DS_GR_CASHFLOW=ds_gr_cashflow,O:DS_GR_LIC=ds_gr_lic)",
            v_param);
        tr_post(tr2);
    }
    
	<%//���� %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_default.RowPosition;
		
		if (ds_default.IsUpdated || ds_gr_lic.IsUpdated || ds_gr_credit.IsUpdated || ds_gr_cashflow.IsUpdated) {
			if(ln_Chk()){
				//ds_lic �����ϱ� ���� ���� ����
				var data_str = ds_gr_lic.ExportData(1, ds_gr_lic.CountRow, false);
				ds_gr_lic.DeleteAll();
				ds_gr_lic.ImportData(data_str);
				ds_gr_lic.SortExpr = "-cstr_eval_fee";
				ds_gr_lic.Sort();	
				
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010I",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%// �Է°� üũ %>
	function ln_Chk() {
		var row1=ds_default.countrow;
		//var row2=ds_tender.countrow;

		for(i=1;i<=row1;i++) {
			if(ds_default.namevalue(i,"bizregi_no").length<10) {
				alert("����� ��� ��ȣ�� �Է��� �ֽʽÿ�");
				v_bizregi_no.focus();
				return;
			}
			if(ds_default.namevalue(i,"bp_nm")=="") {
				alert("���»���� �Է��� �ֽʽÿ�");
				v_bp_nm.focus();
				return;
			}
		}
		return true;
	}

	<%//���»� ��%>
    function fnSelCoopPopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnCtCoopPop(dirPath);
   
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            sc_v_bp_nm.value = arrParam[1];	//NM
            sc_v_bp_sid.value = arrParam[2];	//SID
        } else {
			fnSelBpCleanup();
        }               
    }
    function fnSelBpCleanup(){
        sc_v_bp_nm.value = "";
        sc_v_bp_sid.value  = "";
    }



	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		if (ds_default.IsUpdated || ds_gr_lic.IsUpdated || ds_gr_credit.IsUpdated || ds_gr_cashflow.IsUpdated) {
			alert("�������� ���� ������ �ű� ���»������� ������ �� �����ϴ�.");
			return;
		}else {
			v_job1="N";
			ds_default.addrow();
				ds_gr_credit.cleardata();
				ds_gr_cashflow.cleardata();
				ds_gr_lic.cleardata();
			lc_in_cstr_kind.index = 0;
			lc_in_yn.index = 1;
			lc_loc_place.index = 0;
			lc_rcmd_man.index = 0;
			v_in_date.value= "<%=DateUtil.getCurrentDate(8)%>";
			v_bizregi_no.focus();
			
			return;
		}
	}

	<%// ������ ���� %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("�������� �۾��� �־� ������ �� �����ϴ�.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%//������-�ſ��� ���߰� %>
	function fnAddRowDs21() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("���»� �⺻������ ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_gr_credit.addrow();
			ds_gr_credit.namevalue(ds_gr_credit.RowPosition, "BP_SID") = ds_gr_credit.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="�ſ��� ���� ���ԵǾ����ϴ�.";
		}
	}
	<%//������-�ſ��� ����� %>
	function fnDeleteRowDs21(){
		ds_gr_credit.deleterow(ds_gr_credit.rowposition);
		msgTxt.innerHTML="�ſ��� ���� �����Ǿ����ϴ�.";
	}
	<%//������-�����帧 ���߰� %>
	function fnAddRowDs22() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("���»� �⺻������ ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_gr_cashflow.addrow();
			ds_gr_cashflow.namevalue(ds_gr_cashflow.RowPosition, "BP_SID") = ds_default.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="�����帧 ���� ���ԵǾ����ϴ�.";
		}
	}
	<%//������-�����帧 ����� %>
	function fnDeleteRowDs22(){
		ds_gr_cashflow.deleterow(ds_gr_cashflow.rowposition);
		msgTxt.innerHTML="�����帧 ���� �����Ǿ����ϴ�.";
	}
	<%//������-���� ���߰� %>
	function fnAddRowDs23() {
		if (ds_default.namevalue(ds_default.rowposition,"bp_sid") == undefined || ds_default.namevalue(ds_default.rowposition,"bp_sid") == "" || ds_default.namevalue(ds_default.rowposition,"bp_sid") == 0 ) {
			alert("���»� �⺻������ ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_gr_lic.addrow();
			ds_gr_lic.namevalue(ds_gr_lic.RowPosition, "BP_SID") = ds_default.namevalue(ds_default.rowposition,"BP_SID");
			msgTxt.innerHTML="�������� ���� ���ԵǾ����ϴ�.";
		}
	}
	<%//������-���� ����� %>
	function fnDeleteRowDs23(){
		ds_gr_lic.deleterow(ds_gr_lic.rowposition);
		msgTxt.innerHTML="�������� ���� �����Ǿ����ϴ�.";
	}	
	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_gr_lic.undoall();
        ds_gr_credit.undoall();
        ds_gr_cashflow.undoall();
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
</script>

<%
/*=============================================================================
			GRID Components Event Scripts
=============================================================================*/
%>
	<%//���»� ���ý� ����� �������� �ҷ����� %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_gr_credit.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
		    //var row2=ds_tender.countrow;
		    if(Row==0) return;
		    if(v_default_row==Row){
				return;
			}else{
				fnSelectDetail(Row);
		    }
		};
	</script>
	





<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		//fnSelectDetail(v_default_row);
		
		if(v_job1=="N"){	//�ű� ������ ���� �����ͼ� �����
			ds_default.ClearData();
			ds_gr_lic.ClearData();
			ds_gr_credit.ClearData();
			ds_gr_cashflow.ClearData();
		}
	}

</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}else{
				fnSelectDetail(v_default_row);
			}
		}
	</script>
	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 	<!-- �⺻�˻� �׸��� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_gr_lic classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� �׸���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gr_credit classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �ſ��� �׸���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gr_cashflow classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����帧 �׸���-->
    <param name="SyncLoad"  value="True">
</object>

<object id=sc_ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �˻�����/��ϰ��� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_lic_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=sc_ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �˻�����/������ -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_credit_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �ſ��� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_cashflow_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����帧 -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ϰ��� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_in_yn classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ϰ��� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rcmd_man classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��õ�μ� -->
    <param name="SyncLoad"  value="True">
</object>



<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
							<!-- <img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" > -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td width="70" align="center" class="text">���»��</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='sc_v_bp_nm' id='sc_v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="�� �����">
                                        <input type="hidden" name='sc_v_bp_sid' id='sc_v_bp_sid'  style="width:40px;" class='input01' readOnly>
                                    </td>
			                        <td width="70" align="left" class="text">��ϰ���</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=sc_ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
			                        <td width="70" align="left" class="text">��������</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_lic_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_lic_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
                    			</tr>
                                <tr>
			                        <td align="left" class="text">������</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=sc_ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>                                
			                        <td align="left" class="text">�����</td>
			                        <td align="left" colspan=3 bgcolor="#ffffff">&nbsp;
			                            <object id=sc_eme_cstr_eval_fee_fr classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>			                                
			                            </object>&nbsp;<span style="position:relative;top:4px;">���</span>&nbsp;~&nbsp;
			                            <object id=sc_eme_cstr_eval_fee_to classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>
			                            </object>&nbsp;<span style="position:relative;top:4px;">���</span>
			                                                                                                         
			                        </td>
                                </tr>
                    			

	                    		<tr>
			                        <td align="left" class="text">�ſ���</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=sc_lc_credit_grd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_credit_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>&nbsp;�̻�
			                            
			                        </td>
                    				<td align="left" class="text">�����帧</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id="sc_lc_cashflow_grd" classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align="absmiddle">
			                                <param name=ComboDataID     value=ds_cashflow_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>&nbsp;�̻�
			                        </td>   			                        
		                			<td align="left" class="text">�������</td>
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="sc_v_in_yn" id="sc_v_in_yn"></td>

			             		</tr>
			           		</table>                    	
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='181px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="0">
                                <param name="Format"            value="
									<FC> name='��'			ID={CurRow} 		width=30	align=right </FC>
									<C> name='���»��ڵ�'	ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
									<C> name='���»��'		ID='BP_NM' 			width=170 	align=CENTER	Edit=None </C>
								">
                            </object>   
                            

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">���»��ڵ�</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_bp_cd' id='v_bp_cd' style="width:90px;" class='input01' readOnly="readonly">  
									</td>
									<td width="120px" class="boardt02">��ϰ���</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;
			                            <object id=lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>									
									</td>
								</tr>
								<tr height="21px">
									<td class="boardt02">����ڵ�Ϲ�ȣ</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=v_bizregi_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="000-00-00000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
		                			<td align="left" class="text">�������</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_in_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_yn>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
								</tr>
								<tr height="21px">
									<td class="text">���»��</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm'  maxlength="25" style="width:120px;" class='textbox' >
									</td>
									<td class="text">��ǥ��</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_exc_man' id='v_exc_man'  maxlength="10" style="width:120px;" class='textbox' >

									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">���������</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=v_built_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>  
									</td>
									<td class="text">����� ������</td>
									<td bgcolor='#ffffff'>&nbsp;
			                            <object id=lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>

								</tr>

								<tr height="21px">
									<td class="text">��ȭ</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_phone_no' id='v_phone_no' style="width:120px;" maxlength="19" class='textbox' >
									</td>
									<td width="120px" class="text">�ѽ�</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_fax_no' id='v_fax_no' style="width:120px;"  maxlength="19" class='textbox' >
									</td>
								</tr>								
								<tr height="21px">
                                    <td align="center" class="text">��õ</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
			                            <object id=lc_rcmd_man classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_rcmd_man>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>                                    
                                    </td>
									<td class="text">�����</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_in_date' id='v_in_date' style="width:90px;" class='input01' readOnly="readonly">
									</td>                                    								
								</tr>
								<tr height="21px">
                                    <td align="center" class="text">�������</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_remark' id='v_remark'  maxlength="50" style="width:382px;" class='textbox' >
                                    </td>
								</tr>
							</table>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td>
				<table width="849px" border=0>
		          <!-- <tr>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs21()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs21()" >
					</td>
					<td></td>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs22()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs22()" >
					</td>
					<td></td>
		            <td align=right>
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs23()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs23()" >
					</td>
		          </tr> -->
		          <tr>
		            <td valign="top" width="200px">
		                <object id="gr_credit" classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_credit">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='���س⵵' 	ID='bp_yymm'   		width=70 	align=CENTER	show=true </C>
		                         <C> name='�ſ���'	ID='credit_grd'    	width=60 	align=CENTER	editstyle=lookup Data='ds_credit_grd:detail:detail_nm'</C>
		                         <C> name='�����' 		ID='company'   		width=50 	align=CENTER	show=true </C>
		                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
		                 ">                             
		                </object>   
					</td>
					<td></td>
		            <td valign="top"  width="200px">
		                <object id="gr_cashflow" classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_cashflow">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='���س⵵' 	ID='bp_yymm'   		width=70 	align=CENTER	show=true </C>
		                         <C> name='�����帧'	ID='cashflow_grd'	width=60 	align=CENTER	editstyle=lookup Data='ds_cashflow_grd:detail:detail_nm'</C>
		                         <C> name='�����' 		ID='company'   		width=50 	align=CENTER	show=true </C>
		                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
		                 ">                             
		                </object>   
					</td>
					<td></td>
		            <td valign="top"  width="340px">
		                <object id="gr_lic" classid=<%=HDConstant.CT_GRID_CLSID%> width='340px' height='150px' border='1'>
		                    <param name="DataID"            value="ds_gr_lic">
		                    <param name="ColSizing"         value="true">
		                    <param name="Editable"          value="FALSE">
		                    <param name="SuppressOption"    value="1">
		                    <param name="BorderStyle"       value="0">
		                    <param name="Format"            value="
		                         <C> name='����'			ID='LIC_KIND' 		width=130 	align=CENTER	editstyle=lookup Data='ds_lic_kind:detail:detail_nm'</C>
		                         <C> name='�����(õ��)'	ID='CSTR_EVAL_FEE'	width=100	align=right		decao=0 </C>
		                         <C> name='���س⵵'		ID='BASE_YEAR'	width=70	align=center	</C>
		                         
		                 ">                             
		                </object>   
					</td>
		          </tr>		          
				</table>
  
			</td>
        </tr>
        <tr>
			<td>�� �ϴ��� 3�� GRID ����(�ſ���, �����帧, �������)�� �ſ��򰡻�� ������ �ڵ����� �ҷ��ɴϴ�.<BR>
			�� �ſ��򰡻� : E = Ecredible ��ũ������, N = Nicednb ���̽���غ�
			</td>
        </tr>
        
    </table>

	
	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=bp_cd	      	Ctrl=v_bp_cd			Param=Value </C>
					<C>Col=in_cstr_kind		Ctrl=lc_in_cstr_kind	Param=BindColVal </C>
					<C>Col=bizregi_no      	Ctrl=v_bizregi_no		Param=Text </C>
					<C>Col=in_yn	      	Ctrl=lc_in_yn			Param=BindColVal </C>
					<C>Col=bp_nm	      	Ctrl=v_bp_nm			Param=Value </C>
					<C>Col=exc_man	      	Ctrl=v_exc_man			Param=Value </C>
					<C>Col=built_date      	Ctrl=v_built_date		Param=Text </C>
					<C>Col=loc_place      	Ctrl=lc_loc_place		Param=BindColVal </C>
					<C>Col=phone_no     	Ctrl=v_phone_no			Param=Value </C>
					<C>Col=fax_no     		Ctrl=v_fax_no			Param=Value </C>
					<C>Col=rcmd_man      	Ctrl=lc_rcmd_man		Param=BindColVal </C>
					<C>Col=in_date        	Ctrl=v_in_date			Param=Value </C>
					<C>Col=remark	      	Ctrl=v_remark			Param=Value </C>
	              ">
	      </object>
	 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		