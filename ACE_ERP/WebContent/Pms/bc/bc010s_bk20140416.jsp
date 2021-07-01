<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>�������>�ŷ�ó ����>����ȸ�� ����>����ȸ�� ��ȸ
 * ���α׷�ID 	 : PMS/BC010S
 * J  S  P		 : bc010s.jsp
 * �� �� ��		 : Bc010S
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2013-11-27
 * [ �������� ][������] ����
 * [2013-11-27][�ɵ���] �ű� ���� 
 * [2013-12-03][�ɵ���] ��â ���� �׽�Ʈ
 *						�Ҽ��� �ֵ��� js�� css�� ������ �ϸ� ��������;;;
 *						1) �α��� üũ
 * [2013-12-04][�ɵ���] head.jsp, body_s.jsp ����~						
 * [2014-02-20][�ɵ���] �̻갡����.. ȭ����!
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
%>

<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		/* ���̾�1 */
		cfStyleGrid(getObjectFirst("gr_1_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_3"), "comn");
		cfStyleGrid(getObjectFirst("gr_1_4"), "comn");
		/* ���̾�2 */
		cfStyleGrid(getObjectFirst("gr_2_1"), "comn");
		/* ���̾�3 */
		cfStyleGrid(getObjectFirst("gr_3_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_3_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_3_3"), "comn");
		/* ���̾�4 */
		cfStyleGrid(getObjectFirst("gr_4_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_4_2"), "comn");
		/* ���̾�5 */
		cfStyleGrid(getObjectFirst("gr_5_1"), "comn1");
		/* ���̾�6 */
		cfStyleGrid(getObjectFirst("gr_6_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_6_2"), "comn");
		/* ���̾�7 */
		cfStyleGrid(getObjectFirst("gr_7_1"), "comn");
		cfStyleGrid(getObjectFirst("gr_7_2"), "comn");
		cfStyleGrid(getObjectFirst("gr_7_3"), "comn");
		/* ���̾�8 */
		cfStyleGrid(getObjectFirst("gr_8_1"), "comn");
		/* ���̾�9 */
		cfStyleGrid(getObjectFirst("gr_9_1"), "comn");

		
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";    	
	    ds_in_cstr_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT018&s_item1=Y";
        ds_in_cstr_kind.Reset(); //��ϰ���
        ds_lic_kind.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT019&s_item1=Y";
        ds_lic_kind.Reset(); //��������
        ds_loc_place.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY006&s_item1=Y";
        ds_loc_place.Reset(); //������
        ds_credit_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT021&s_item1=Y";
        ds_credit_grd.Reset(); //�ſ���
        ds_cashflow_grd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT022&s_item1=Y";
        ds_cashflow_grd.Reset();	//�����帧
    
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";    	
        var in_yn = "N";

    	if(v_in_yn.checked){
    		in_yn="Y";	//��ϵ� �͸�
    	}
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_bp_sid="+ v_bp_sid.value
			+ ",v_in_cstr_kind=" + lc_in_cstr_kind.ValueOfIndex("detail", lc_in_cstr_kind.Index)
			+ ",v_lic_kind=" + lc_lic_kind.ValueOfIndex("detail", lc_lic_kind.Index)
			+ ",v_loc_place=" + lc_loc_place.ValueOfIndex("detail", lc_loc_place.Index)
			+ ",v_cstr_eval_fee_fr=" + eme_cstr_eval_fee_fr.text
			+ ",v_cstr_eval_fee_to=" + eme_cstr_eval_fee_to.text
			+ ",v_credit_grd=" + lc_credit_grd.ValueOfIndex("detail", lc_credit_grd.Index)
			+ ",v_cashflow_grd=" + lc_cashflow_grd.ValueOfIndex("detail", lc_cashflow_grd.Index)
			+ ",v_in_yn=" + in_yn;

        //alert(param);
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
           
        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:����ȸ��_��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("����ȸ��_��Ȳ", "����ȸ��_��Ȳ.xls", 8);        
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
            v_bp_nm.value = arrParam[1];	//NM
            v_bp_sid.value = arrParam[2];	//SID
        } else {
			fnSelBpCleanup();
        }               
    }
    function fnSelBpCleanup(){
        v_bp_nm.value = "";
        v_bp_sid.value  = "";
    }
    
    
    <%// ���̾�1 �Ѱ� ��ȸ%>
    function fnSelectLayer1(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bp_sid="+getObjectFirst("ds_default").NameValue(row, "bp_sid");
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_1_0=ds_1_0,O:DS_1_1=ds_1_1,O:DS_1_2=ds_1_2,O:DS_1_3=ds_1_3,O:DS_1_4=ds_1_4)",
            v_param);
        tr_post(tr1);
        
        
    }
    
    function fnSelectLayer2(){
    	alert(222);
    }
    function fnSelectLayer3(){
    	alert(333);
    }
    function fnSelectLayer4(){
    	alert(444);
    }
    function fnSelectLayer5(){
    	alert(555);
    }
    function fnSelectLayer6(){
    	alert(666);
    }
    function fnSelectLayer7(){
    	alert(777);
    }
    function fnSelectLayer8(){
    	alert(888);
    }
    function fnSelectLayer9(){
    	alert(999);
    }
    function fnSelectLayer10(){
    	alert(10);
    }
    
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//����ȸ�� Ŭ���� ���̾�1 ��ȸ %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		
	    if(Row==0) return;
	    if(v_default_row==Row){
			return;
		}else{
			fnSelectLayer1(Row);
	    }
	</script>
	
	<%//���� �׸��� ���� Ŭ���� ������� �� %>
	<script language=javascript for="gr_1_1" event="OnDblClick(Row, Colid)">
		//v_job="SD";
		
	    if(Row==0) return;
	    alert(Row);
	    /*if(v_default_row==Row){
			return;
		}else{
			fnSelectLayer1(Row);
	    }*/
	</script>
	
	<%//�� ���ý� ��ȸ�ϱ� %>
	<script language="javascript" for="gcte_disp" event="onselChanged(index)">
		if (ds_default.CountRow>0) {
			if (index=="2") 		fnSelectLayer2(); 
			else if (index=="3")	fnSelectLayer3();	
			else if (index=="4")	fnSelectLayer4();	
			else if (index=="5")	fnSelectLayer5();  
			else if (index=="6")	fnSelectLayer6();
			else if (index=="7")	fnSelectLayer7();
			else if (index=="8")	fnSelectLayer8();
			else if (index=="9")	fnSelectLayer9();
			
		}
	</script>	


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_default" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			//ds_tender.clearall();
			}else{
				fnSelectLayer1(v_default_row);
			}
		}
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_in_cstr_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ϰ��� -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_lic_kind classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_loc_place classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_credit_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �ſ��� -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_cashflow_grd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����帧 -->
    <param name="SyncLoad"  value="True"/>
</object>


<object id=ds_1_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���̾�1_0 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���̾�1_1 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���̾�1_2 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���̾�1_3 -->
    <param name="SyncLoad"  value="True"/>
</object>
<object id=ds_1_4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���̾�1_4 -->
    <param name="SyncLoad"  value="True"/>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
</head>


<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->






<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDsDefault()">
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
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly" value="����">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="�� �����">
                                        <input type="hidden" name='v_bp_sid' id='v_bp_sid'  style="width:40px;" class='input01' readOnly value="23">
                                    </td>
			                        <td width="70" align="left" class="text">��ϰ���</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_in_cstr_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 align=absmiddle>
			                                <param name=ComboDataID     value=ds_in_cstr_kind>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^120">
			                            </object>
			                        </td>
			                        <td width="70" align="left" class="text">��������</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id=lc_lic_kind classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 align=absmiddle>
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
			                            <object id=lc_loc_place classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_loc_place>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                        </td>                                
			                        <td align="left" class="text">�����</td>
			                        <td align="left" colspan=3 bgcolor="#ffffff">&nbsp;
			                            <object id=eme_cstr_eval_fee_fr classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=eme_cstr_eval_fee_to classid=<%=HDConstant.CT_EMEDIT_CLSID%> align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
			                            <object id=lc_credit_grd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=140 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_credit_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>&nbsp;�̻�
			                            
			                        </td>
                    				<td align="left" class="text">�����帧</td>
			                        <td align="left" bgcolor="#ffffff">&nbsp;
			                            <object id="lc_cashflow_grd" classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align="absmiddle">
			                                <param name=ComboDataID     value=ds_cashflow_grd>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>&nbsp;�̻�
			                        </td>   			                        
		                			<td align="left" class="text">�������</td>
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="v_in_yn" id="v_in_yn"></td>

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
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                         
                        <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='150px' border='1'>
                            <param name="DataID"            value="ds_default">
                            <param name="ColSizing"         value="true">
                            <param name="Editable"          value="true">
                            <param name="SuppressOption"    value="1">
                            <param name="BorderStyle"       value="0">
                            <param name="ViewSummary"       value="0">
                            <param name=SortView  			value="Right">
                            <param name="Format"            value="
                                 <F> name='��'				ID={CurRow} 		width=35	align=right </F> 
                                 <C> name='���»��ڵ�'		ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
                                 <C> name='���»��'		ID='BP_NM' 			width=100 	align=CENTER	Edit=None sort=true</C>
                                 <C> name='����ڵ�Ϲ�ȣ'	ID='BIZREGI_NO'		width=100 	align=left 		Edit=None show=false </C>
                                 <C> name='������'  		ID='LOC_PLACE'      width=60 	align=center 	Edit=None editstyle=lookup data='ds_loc_place:detail:detail_nm'</C>
                                 <C> name='��ϰ���'		ID='IN_CSTR_KIND'	width=80	align=center 	Edit=None editstyle=lookup data='ds_in_cstr_kind:detail:detail_nm'</C>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND1'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE1'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND2'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE2'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND3'   	width=80 	align=center 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE3'	width=80 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								 <C> name='�ſ���'		ID='CREDIT_GRD'   	width=60 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								 <C> name='�����帧'		ID='CASHFLOW_GRD'  	width=60 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								 <C> name='���'			ID='IN_YN'	 	 	width=50 	align=center 	Edit=None </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top"><br>
			<OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 style="width:800px;height:20px">
				<PARAM NAME="BackColor"					VALUE="#cccccc">
				<PARAM NAME="titleHeight"				VALUE="20px">
	            <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
				<PARAM NAME="Format"						VALUE="
					<T>divid=layer1  title='�Ѱ�'</T>
					<T>divid=layer2  title='�������'</T>									
					<T>divid=layer3  title='���� �� �ð��ɷ�'</T>
					<T>divid=layer4  title='����(���)'</T>
					<T>divid=layer5  title='����(Ÿ��)'</T>
					<T>divid=layer6  title='����/����ó'</T>
					<T>divid=layer7  title='ä��������'</T>
					<T>divid=layer8  title='�繫��ǥ'</T>
					<T>divid=layer9	 title='�ſ���'</T>
					<T>divid=layer10  title='�ſ��򰡺���'</T>

				">
			</OBJECT>
			
			

<!---------[TAB 1] �Ѱ� ----------->
<div id="layer1" style="border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
<script language='javascript'> 
    function showEcreCert(u, p, i, k, c) {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='http://www.esrm.co.kr/esrm/SrmplusLogin?u='+ u +'&p='+ p +'&i='+ getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO") +'&k='+ k +'&c=7&m=3&g=2';
        var features ='height=768, width=1024, status=no, scrollbars=auto, resizable=yes';
        window.open(link, 'watchwin', features); 
    } 
</script>
<%
	//��ũ������ ������ ����?
        // u : ���ڵ��� ����� ���̵�
        // p : ���ڵ��� ����� ��ȣ
        // i : ���¾�ü����ڹ�ȣ - �������ڹ�ȣ
	    // k : ���¾�ü���ι�ȣ
        // c : ��ȣȭ���
        //      1(��ȣȭ����), 2(base64), 3:(128bit,�ý����� java�� ��쿡��), 7:(128bit, �������� ����, ����ڹ�ȣ��ȣȭ X)
        // m : ���������� �⺻ ���� 
        //      1(��ü�˻�), 2(Watch����), 3(��������������), 4(�Ǽ���������), 5(�ŷ��������), 8(IT��������)
        // g : �����Ķ����

		String u ="2d2d424547494e204349504845522d2d313131310000000b3030303030303030cbdd77ad19cf5c1558642438a796c668e7c9c69e0c6d37758967171a01138e5c89170074853f9d0c500916f7e1699e9330302d2d454e44204349504845522d2d";	// ���ϳ��뿡 �ִ� ���̵�
		String p ="2d2d424547494e204349504845522d2d31313131000000043030303030303030ac976e9b5772c9c9347c8fe124537fcb02d4f647ae0d9ead209c0b4788690ea4eb4f8af8a3cce9beb5e58115a79e352a30302d2d454e44204349504845522d2d";	// ���ϳ��뿡 �ִ� ��ȣ
		String i ="";	// ���¾�ü����ڹ�ȣ
		String k ="";	// ���¾�ü���ι�ȣ

%>

	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">���»��</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l1_v_bp_nm' id='l1_v_bp_nm' style="width:220px;" class='hidden' readOnly="readonly">
	  	  			<img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="showEcreCert('<%=u%>','<%=p%>','<%=i%>','<%=k%>','3')" alt="��ũ������ �ſ��򰡺���"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">��ǥ��</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l1_v_exc_man' id='l1_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��ϰ���</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_in_cstr_kind_nm' id='l1_v_in_cstr_kind_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">������</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l1_v_loc_place' id='l1_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��������1</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND1' id='l1_v_LIC_KIND1' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(�����)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE1 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>	  	  		
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��������2</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND2' id='l1_v_LIC_KIND2' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(�����)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE2 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��������3</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l1_v_LIC_KIND3' id='l1_v_LIC_KIND3' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">(�����)</td>
	  	  		<td class="tab22">&nbsp;
					<object id=l1_v_CSTR_EVAL_FEE3 classid=<%=HDConstant.CT_EMEDIT_CLSID%> class="hidden" style= "position:relative;left:0px;top:4px;width:200px; height:17px;">
						<param name=Text        value="">
						<param name=Alignment   value=2>
						<param name=Format      value="">
						<param name=Cursor      value="iBeam">
						<param name=Border      value="false">      
						<param name=InheritColor      value="true">                                                                                                                                                                                                             
						<param name=ReadOnly    value="true">
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>			                                
                    </object>
	  	  		</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. ���� �� ���� ����</td>
	  </tr>
	  <tr>
	  	<td style="padding-left:20px">1) ����</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">(����:õ��, �ΰ��� ����)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_1_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_1_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'			ID={CurRow} 		width=30	align=right </F> 
					<C> name='��������'		ID='bid_day'    	width=96 	align=CENTER	Edit=None mask='XXXX-XX-XX' </C>
					<C> name='�����'		ID='site_nm' 		width=116 	align=CENTER	Edit=None </C>
					<C> name='����'			ID='ct_kind'		width=116	align=center 	Edit=None </C>
					<C> name='����(õ��)'	ID='act_amt'    	width=116	align=right 	edit=none decao=0 </C>
					<C> name='������(õ��)'	ID='bid_amt'    	width=116 	align=right 	edit=none decao=0 </C>
					<C> name='����(%)'		ID='bid_amt_pct2'	width=96 	align=right 	edit=none decao=1 </C>
					<C> name='���'			ID='RESULT_CP' 		width=66 	align=CENTER	edit=none </C>
					<C> name='����' 		ID='SEQ'    		width=50 	align=CENTER	 </C>
					<C> name='bid' 			ID='BID_SID'   		width=40 	align=CENTER	edit=none show=false </C>					
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:20px">2) ���</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">(����:õ��, �ΰ��� ����)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_1_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- �Ѱ�/��� -->
				<param name="DataID"            value="ds_1_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="true">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'			ID={CurRow} 		width=30	align=right </F> 
					<C> name='�������'		ID='bid_day'    	width=96 	align=CENTER	Edit=None mask='XXXX-XX-XX' </C>
					<C> name='�����'		ID='site_nm' 		width=116 	align=CENTER	Edit=None </C>
					<C> name='����'			ID='ct_kind'		width=116	align=center 	Edit=None </C>
					<C> name='���ݾ�'		ID='act_amt'    	width=116	align=right 	edit=none decao=0 </C>
					<C> name='����Ⱓ'		ID='bid_amt'    	width=160 	align=right 	edit=none </C>
					<C> name='���'			ID='bid_amt_pct2'	width=168 	align=right 	edit=none </C>
					<C> name='bid' 			ID='BID_SID'   		width=40 	align=CENTER	edit=none show=false </C>					
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">3. �ſ� ��� �� �����帧 ���</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">	
		<table style="border:0 solid #708090; width:823px" cellpadding="0" cellspacing="0">
		  <tr>
			<td>
                <object id="gr_1_3" classid=<%=HDConstant.CT_GRID_CLSID%> width='400px' height='90px' border='1'>
                    <param name="DataID"            value="ds_1_3">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='�⵵' 		ID='bp_yymm'   		width=120 	align=CENTER	show=true </C>
                         <C> name='�ſ���'	ID='credit_grd'    	width=80 	align=CENTER	editstyle=lookup Data='ds_credit_grd:detail:detail_nm'</C>
                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
                 ">
                </object>   
			</td>
			<td>
            <td valign="top"  width="160px">
                <object id="gr_1_4" classid=<%=HDConstant.CT_GRID_CLSID%> width='400px' height='90px' border='1'>
                    <param name="DataID"            value="ds_1_4">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='�⵵' 		ID='bp_yymm'   		width=120 	align=CENTER	show=true </C>
                         <C> name='�����帧'	ID='cashflow_grd'	width=80 	align=CENTER	editstyle=lookup Data='ds_cashflow_grd:detail:detail_nm'</C>
                         <C> name='bp_sid' 		ID='bp_sid'   		width=60 	align=CENTER	edit=none show=false </C>
                 ">
                </object>
			</td>   
		  </tr>
		</table>
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">4. ��Ÿ (ä�������� ���� ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px"></td>
	  </tr>
	</table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_1_0">
	             <param name=BindInfo    value="
					<C>Col=bp_nm	    Ctrl=l1_v_bp_nm				Param=Value </C>
					<C>Col=exc_man	    Ctrl=l1_v_exc_man			Param=Value </C>
					<C>Col=in_cstr_kind_nm	Ctrl=l1_v_in_cstr_kind_nm	Param=Value </C>
					<C>Col=loc_place    Ctrl=l1_v_loc_place			Param=Value </C>
					<C>Col=lic1			Ctrl=l1_v_LIC_KIND1			Param=Value </C>
					<C>Col=fee1			Ctrl=l1_v_CSTR_EVAL_FEE1	Param=text </C>
					<C>Col=lic2			Ctrl=l1_v_LIC_KIND2			Param=Value </C>
					<C>Col=fee2			Ctrl=l1_v_CSTR_EVAL_FEE2	Param=text </C>
					<C>Col=lic3      	Ctrl=l1_v_LIC_KIND3			Param=Value </C>
					<C>Col=fee3			Ctrl=l1_v_CSTR_EVAL_FEE3	Param=text </C>
	              ">
	      </object>
	<br>
</div>


<!---------[TAB 2] ������� ----------->
<div id="layer2" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">���»��</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l2_v_bp_nm' id='l2_v_bp_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">��ǥ��</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l2_v_exc_man' id='l2_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">����ڹ�ȣ</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_in_cstr_kind' id='l2_v_in_cstr_kind' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">���ι�ȣ</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l2_v_loc_place' id='l2_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��������</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_LIC_KIND1' id='l2_v_LIC_KIND1' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">��������</td>
	  	  		<td class="tab22">&nbsp;	
				</td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">�ּ�</td>
	  	  		<td class="tab22" colspan="3">&nbsp;</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. �濵��Ȳ</td>
	  </tr>
	  <tr>
	  	<td style="padding-left:20px">1) ��ǥ��</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="136px" bgcolor="#eeeeee">����</td>
	  	  		<td class="tab21" width="273px">&nbsp;<input type="text" name='l2_v_bp_nm' id='l2_v_bp_nm' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" width="136px" bgcolor="#eeeeee">�������</td>
	  	  		<td class="tab22" width="273px">&nbsp;<input type="text" name='l2_v_exc_man' id='l2_v_exc_man' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">��  ��</td>
	  	  		<td class="tab21" >&nbsp;<input type="text" name='l2_v_in_cstr_kind' id='l2_v_in_cstr_kind' style="width:200px;" class='hidden' readOnly="readonly"></td>
				<td class="tab11" bgcolor="#eeeeee">���� ��ű�</td>
	  	  		<td class="tab22">&nbsp;<input type="text" name='l2_v_loc_place' id='l2_v_loc_place' style="width:200px;" class='hidden' readOnly="readonly"></td>
	  		</tr>
			<tr>
				<td class="tab11" bgcolor="#eeeeee">�ֿ���</td>
	  	  		<td class="tab22" colspan="3"><br><br><br>&nbsp;</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:20px">2) ���ֱ���</td>
	  </tr>	  
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_2_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_2_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'						ID={CurRow} 		width=30	align=right </F> 
					<C> name='���ָ�'					ID='bid_day'    	width=250 	align=CENTER	Edit=None </C>
					<C> name='�濵 ��õ�ڿ��� ����'		ID='site_nm' 		width=250 	align=CENTER	Edit=None </C>
					<C> name='�����ֽ� ����(%)'			ID='ct_kind'		width=250	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 3] ���� �� �ð��ɷ� ----------->
<div id="layer3" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ���� ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='�����'			ID='bid_day'    	width=200 	align=CENTER	Edit=None </C>
					<C> name='�����ȣ'			ID='site_nm' 		width=180 	align=CENTER	Edit=None </C>
					<C> name='���� ����Ͻ�'	ID='ct_kind'		width=180	align=center 	Edit=None </C>
					<C> name='�����'			ID='ct_kind'		width=200	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ���� ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'				ID={CurRow} 		width=30	align=right </F>
					<C> name='���ؿ���'			ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='�����'			ID='site_nm' 		width=150 	align=CENTER	Edit=None </C>
					<C> name='�����'			ID='ct_kind'		width=100	align=center 	Edit=None </C>
				  <G> name='��������'
					<C> name='����'				ID='ct_kind'		width=70	align=center 	Edit=None </C>
					<C> name='��ü��'			ID='ct_kind'		width=140	align=center 	Edit=None </C>
				  </g>
				  <G> name='��������'
					<C> name='����'				ID='ct_kind'		width=70	align=center 	Edit=None </C>
					<C> name='��ü��'			ID='ct_kind'		width=140	align=center 	Edit=None </C>
				  </g>

				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">3. �Ǽ����� ���� ��Ȳ</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_3_3 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- -->
				<param name="DataID"            value="ds_3_3">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='���ؿ���'			ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='�����'			ID='site_nm' 		width=150 	align=CENTER	Edit=None </C>
				  <G> name='����'
					<C> name='�Ǽ�'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='�ݾ�'			ID='ct_kind'		width=180	align=center 	Edit=None </C>
				  </g>
				  <G> name='�⼺��'
					<C> name='�Ǽ�'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='�ݾ�'			ID='ct_kind'		width=180	align=center 	Edit=None </C>
				  </g>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 4] ����(���)----------->
<div id="layer4" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ���� ���� ��Ȳ</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">
			<object id=gr_4_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='140px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_4_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name=SortView  			value="Right">
				<param name="Format"            value="
					<C> name='��������' 	ID='BID_DAY'    	width=80 	align=CENTER	Edit=None suppress=1 sort=true</C>
					<C> name='����'			ID='CT_GUBN' 		width=40 	align=CENTER	Edit=None suppress=2 sumtext='��'  sumtextalign='right'</C>
					<C> name='�����'		ID='SITE_NM'       	width=120 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'	sort=true</C>
					<C> name='����'  		ID='CT_KIND'      	width=60 	align=left 		Edit=None suppress=4 sumtext='��' sumtextalign='left' 		sort=true</C>
					<C> name='��ü��'		ID='COOP_NM'		width=80	align=left 		Edit=None sort=true</C>
					<C> name='����'    	    ID='ACT_AMT'   		width=80 	align=right 	Edit=None suppress=5 decao=0	sort=true</C>
					<C> name='����'    	    ID='ACT_AMT_HA'   	width=60 	align=right 	Edit=None suppress=6 decao=0	sort=true</C>
					<C> name='�����ݾ�'		ID='BID_AMT'    	width=80 	align=right 	Edit=None decao=0	sort=true</C>
					<C> name='����(%)'		ID='BID_AMT_PCT2'	width=50 	align=right 	Edit=None dec=1	</C>
					<C> name='����(%)'		ID='BID_AMT_PCT1'	width=50 	align=right 	Edit=None dec=1</C>
					<C> name='����'			ID='SEQ'	 	    width=60 	align=center	Edit=None sort=true</C>
					<C> name='��ü��'		ID='COOP_CNT' 	    width=40 	align=center	Edit=None</C>
					<C> name='���'   		ID='RESULT_CP'		width=60 	align=CENTER	Edit=None sort=true</C>
					<C> name='��õ�μ�'		ID='RECO_DEPT'      width=70 	align=left 		Edit=None sort=true</C>
					<C> name='���'   		ID='REMARK'         width=160 	align=LEFT		Edit=None</C>
				">       
			</object> 	   		
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. ��� ��Ȳ</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">(����:õ��, �ΰ��� ����)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_4_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='140px' border='1'>
				<param name="DataID"            value="ds_4_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name=SortView  			value="Right">
				<param name="Format"            value="
					<C> name='����'			ID='CT_GUBN' 		width=40 	align=CENTER	Edit=None suppress=2 sumtext='��'  sumtextalign='right'</C>
					<C> name='����'			ID='site_nm' 		width=50 	align=CENTER	Edit=None </C>
					<C> name='�����'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='����'			ID='ct_kind'		width=110	align=center 	Edit=None </C>
					<C> name='���ݾ�'		ID='act_amt'    	width=116	align=right 	edit=none decao=0 sort=true</C>
					<C> name='����Ⱓ'		ID='bid_amt'    	width=146 	align=right 	edit=none decao=0 sort=true</C>
					<C> name='���'   		ID='REMARK'         width=180 	align=LEFT		Edit=None</C>
				">       
			</object> 	  	
 
		</td>
	  </tr>
	</table>
<br>
</div>

<!---------[TAB 5] ����(Ÿ��)----------->
<div id="layer5" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_5_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='220px' border='1'><!-- -->
				<param name="DataID"            value="ds_5_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<F> name='��'				ID={CurRow} 		width=30	align=right </F> 
					<C> name='�����'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='����'				ID='bid_day'    	width=60 	align=CENTER	Edit=None </C>
					<C> name='�����'			ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='������'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='��û��'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='��⵵\\����'	ID='ct_kind'		width=100	align=center 	Edit=None </C>
					<C> name='��⵵\\�⼺��'	ID='ct_kind'		width=100	align=center 	Edit=None </C>
					<C> name='�ذ��⵵'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 6] ����/����ó----------->
<div id="layer6" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_6_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='220px' border='1'><!-- -->
				<param name="DataID"            value="ds_6_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='��ü��'		ID='site_nm' 		width=160 	align=CENTER	Edit=None </C>
					<C> name='��ǥ�̻�'		ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='�ŷ�ǰ��'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='����(%)'		ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='���'			ID='ct_kind'		width=280	align=center 	Edit=None </C>
				">
			</object>
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. ���� �� ���� ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_6_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='290px' border='1'><!-- -->
				<param name="DataID"            value="ds_6_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='��ü��'		ID='site_nm' 		width=160 	align=CENTER	Edit=None </C>
					<C> name='��ǥ�̻�'		ID='bid_day'    	width=100 	align=CENTER	Edit=None </C>
					<C> name='�ŷ�ǰ��'		ID='SITE_NM'       	width=160 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right' sort=true</C>
					<C> name='����(%)'		ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='���'			ID='ct_kind'		width=280	align=center 	Edit=None </C>
				">
			</object>
		</td>
	  </tr>	  
	</table>
	<br>
</div>

<!---------[TAB 7] ä��������----------->
<div id="layer7" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ä��������</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">(����:õ��)</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_7_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='����'			ID='bid_day'    	width=396 	align=CENTER	Edit=None </C>
					<C> name='�Ǽ�'			ID='site_nm' 		width=106 	align=CENTER	Edit=None </C>
					<C> name='�ݾ�'			ID='act_amt'    	width=126	align=right 	edit=none decao=0 </C>
					<C> name='����������'	ID='bid_amt'    	width=166 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr>
	  	<td style="padding-top:10px; padding-left:10px">2. ����ó��</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_2 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_7_2">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='����'			ID='bid_day'    	width=201 	align=CENTER	Edit=None </C>
					<C> name='�Ǽ�'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='����'			ID='bid_amt'    	width=500 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	  <tr >
	  	<td style="padding-top:10px; padding-left:10px">3. �Ҽ�����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_7_3 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='90px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_7_3">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='����'			ID='bid_day'    	width=201 	align=CENTER	Edit=None </C>
					<C> name='�Ǽ�'			ID='site_nm' 		width=100 	align=CENTER	Edit=None </C>
					<C> name='����'			ID='bid_amt'    	width=500 	align=right 	edit=none decao=0 </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 8] �繫��ǥ----------->
<div id="layer8" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ��� ��������ǥ</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_8_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='390px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_8_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='����'			ID='bid_day'    	width=320 	align=CENTER	Edit=None </C>
				  <G> name='�ݾ�(�鸸��)'
					<C> name='2011'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2012'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2013'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				  </g>
				  <G> name='������(%)'
					<C> name='2011'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2012'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
					<C> name='2013'			ID='ct_kind'		width=80	align=center 	Edit=None </C>
				  </g>
				">       
			</object> 	  	
		</td>
	  </tr>
	  
	</table>
	<br>
</div>

<!---------[TAB 9] �ſ��� ----------->
<div id="layer9" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:10px">
			<object id=gr_9_1 classid=<%=HDConstant.CT_GRID_CLSID%> width='821px' height='190px' border='1'><!-- �Ѱ�/���� -->
				<param name="DataID"            value="ds_9_1">
				<param name="ColSizing"         value="true">
				<param name="Editable"          value="false">
				<param name="SuppressOption"    value="1">
				<param name="BorderStyle"       value="0">
				<param name="ViewSummary"       value="0">
				<param name="Format"            value="
					<C> name='��������'		ID='bid_day'    	width=160 	align=CENTER	Edit=None </C>
					<C> name='�ſ���'			ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='�����帧���'		ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='�������'		ID='ct_kind'		width=160	align=center 	Edit=None </C>
					<C> name='��ȿ�Ⱓ'			ID='ct_kind'		width=160	align=center 	Edit=None </C>
				">       
			</object> 	  	
		</td>
	  </tr>
	</table>
	<br>
</div>

<!---------[TAB 10] �ſ��򰡺���----------->
<div id="layer10" style="background-color:#ffffff;border:1 solid #333333; position:absolute; top:399px;left:13px; visibility:hidden;">
	<table style="width:845px" cellpadding="0" cellspacing="0">
	  <tr >
	  	<td style="padding-top:10px; padding-left:11px">1. ����</td>
	  </tr>
	  <tr>
	  	<td align="right" style="padding-right:11px">	
		<table style="border:1 solid #708090; width:823px" cellpadding="0" cellspacing="0">
			<tr>
				<td class="tab11" width="50%">��ũ������</td>
	  	  		<td class="tab11" width="50%">���̽���غ�</td>
	  		</tr>
		</table>
		</td>
	  </tr>
	</table>
	<br>
</div>

			
			
			
			</td>
        </tr>        
    </table>

	
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		