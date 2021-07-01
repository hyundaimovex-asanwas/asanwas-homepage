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
 * [2014-04-16][�ɵ���] ������ ��Ÿ���� ����
 *						�ϴ� ���� �����ϰ� ��� ���Ŀ��� ����Ŭ�� �� �Ѱ������� ����~?
 *	���� : ���� sid=23
 * [2014-04-29][�ɵ���] ���»� ��� �߰�
 * [2014-05-02][�ɵ���] �������� �߰�, ���ó�¥�� ��??
 * [2014-06-05][�ɵ���] ���򰡰ų� ��ȿ���� ���� �ֵ鸸 �˻����� �߰�
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
	
	//���� ��¥ �߰�
	String v_todate = DateUtil.getCurrentDate(8);
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
        
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_bp_sid="+ v_bp_sid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_BC%>Bc010S",
            "JSP(O:DS_CNT=ds_cnt)",
            param);
           
        tr_post(tr1);        
    
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";    	
        var in_yn = "N";	//����ȸ�� �������
        var yet_only_yn = "N";	//�̵�� ȸ�縸 ���� ����

    	if(v_in_yn.checked){
    		in_yn="Y";	//��ϵ� �͸�
    	}
    	if(v_yet_only_yn.checked){
    		yet_only_yn="Y";	//�̵�� ������ ȸ�縸
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
			+ ",v_in_yn=" + in_yn
			+ ",v_yet_only_yn=" + yet_only_yn;

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
    

    //��ũ������ ����������
    function showEcreCert(u, p, i, k, c,Row) {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='http://www.esrm.co.kr/esrm/SrmplusLogin?u='+ u +'&p='+ p +'&i='+ getObjectFirst("ds_default").NameValue(Row, "BIZREGI_NO") +'&k='+ k +'&c=7&m=3&g=2';
        var features ='height=768, width=1024, status=no, scrollbars=auto, resizable=yes';
        window.open(link, 'watchwin', features); 
    } 
  	//���̽���غ� ����������
    function showNiceCert(Row) {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        var link ='http://clip.nice.co.kr/rep_nclip/rep_DLink/rep_Link_hdasan2.jsp?bz_ins_no='+ getObjectFirst("ds_default").NameValue(Row, "BIZREGI_NO") +'&';
		var width = 830;
		var height = 700;
		posx = (screen.width - width) / 2 - 1;
		posy = (screen.height - height) / 2 - 1;
        var features ='toolbar=no,location=no,locationbar=no,personalbar=no,directories=no,status=no,statusbar=no,menubar=no,titlebar=no,scrollbars=yes,resizable=no,menu=no,width=' + width + ',height=' + height + ',left=' + posx + ',top=' + posy;
        window.open(link, 'nicewin', features); 
        
  	}
  	
    //���»� �Ѱ� ���� ����
    function showBPDetail(Row) {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
		
    	//alert(getObjectFirst("ds_default").NameValue(v_default_row, "BIZREGI_NO"));
        var link ='bc010s_h1.jsp?i='+ getObjectFirst("ds_default").NameValue(Row, "BP_SID") +'&';
        var features ='height=768, width=900, status=yes, scrollbars=auto, resizable=yes';
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

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//����ȸ�� Ŭ���� ���̾�1 ��ȸ %>
	<script language=javascript for="gr_default" event="OnDblClick(Row, Colid)">
		v_job="SD";
		
	    if(Row==0){
	    	return;
		}else{
			if(Colid=="ECRE_YN"){
				showEcreCert('<%=u%>','<%=p%>','<%=i%>','<%=k%>','3',Row);
			}else if(Colid=="NICEDNB_YN"){
				showNiceCert(Row);
			}else{
				showBPDetail(Row);
			}		
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
<object id=ds_cnt classid=<%=HDConstant.CT_DATASET_CLSID%>> 
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




<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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

   
    <table border='0' cellpadding='0' cellspacing='0'> 
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
            <td>
                <table border='0' cellpadding="0" cellspacing="0" WIDTH="1045px">
                    <tr>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='820px'>
                    			<tr>
                                    <td width="70" align="center" class="text">���»��</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bp_nm' id='v_bp_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly" value="">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelBpCleanup();" alt="�� �����">
                                        <input type="hidden" name='v_bp_sid' id='v_bp_sid'  style="width:40px;" class='input01' readOnly value="">
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
			                        <td align="left" bgcolor="#ffffff" >&nbsp;<input type="checkbox" name="v_in_yn" id="v_in_yn">
			                        &nbsp;
			                        ��ȿ&nbsp;<input type="checkbox" name="v_yet_only_yn" id="v_yet_only_yn">
			                        
			                        </td>

			             		</tr>
			           		</table>
			           	</td>
			           	<TD WIDTH="10"></TD>
                    	<td ALIGN="RIGHT">
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" WIDTH="200">
                    			<tr>
                                    <td width="50" align="center" class="text">��ü</td>
                                    <td width="50"  bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_all' id='c_all' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>
									<td width="50" align="center" class="text">����</td>
                                    <td width="50"  bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_both' id='c_both' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
								</tr>
                    			<tr>
                                    <td align="center" class="text" rowspan="2"><b>�̵��</b></td>
                                    <td rowspan="2" bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_none' id='c_none' style="width:40px;text-align:right;font-weight:bold;" class='hidden' readOnly="readonly"></td>
									<td align="center" class="text">Ecre</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_ecre' id='c_ecre' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
								</tr>
                    			<tr>
									<td align="center" class="text">Nice</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='c_nice' id='c_nice' style="width:40px;text-align:right;" class='hidden' readOnly="readonly"></td>                                    
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
			  <table  border='0' cellpadding='0' cellspacing='0'>
				<tr>
				  <td valign='top'>

					<object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1165px' height='500px' border='1'>
						<param name="DataID"            value="ds_default">
						<param name="ColSizing"         value="true">
						<param name="Editable"          value="true">
						<param name="SuppressOption"    value="1">
						<param name="BorderStyle"       value="0">
						<param name="ViewSummary"       value="0">
						<param name=SortView  			value="Right">
						<param name="Format"            value="
                                 <C> name='��'				ID={CurRow} 		width=35	align=right </C> 
                                 <C> name='���»��ڵ�'		ID='BP_CD'    		width=80 	align=CENTER	Edit=None </C>
                                 <C> name='���»��'		ID='BP_NM' 			width=90 	align=left		Edit=None sort=true</C>
                                 <C> name='����ڵ�Ϲ�ȣ'	ID='BIZREGI_NO'		width=100 	align=left 		Edit=None show=false </C>
                                 <C> name='������'  		ID='LOC_PLACE'      width=44 	align=center 	Edit=None editstyle=lookup data='ds_loc_place:detail:detail_nm'</C>
                                 <C> name='��ϰ���'		ID='IN_CSTR_KIND'	width=70	align=center 	Edit=None editstyle=lookup data='ds_in_cstr_kind:detail:detail_nm'</C>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND1'   	width=80 	align=left	 	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE1'	width=70 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND2'   	width=80 	align=left  	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE2'	width=70 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='���������'
                                 <C> name='����'			ID='LIC_KIND3'   	width=70 	align=left  	Edit=None editstyle=lookup data='ds_lic_kind:detail:detail_nm'</C>
                                 <C> name='�����'    	    ID='CSTR_EVAL_FEE3'	width=60 	align=right 	Edit=None decao=0 sort=true</C>
								</G>
								<G> name='�����'
								 <C> name='Ecre'		ID='ECRE_YN'   		width=40 	align=center 	Edit=None bgColor={IF(ECRE_YN='Y','#FFFF00','#FFFFFF')} </C>
								 <C> name='Nice'		ID='NICEDNB_YN'  	width=40 	align=center 	Edit=None bgColor={IF(NICEDNB_YN='Y','#FFFF00','#FFFFFF')} </C>
								</G>
								<G> name='��������'
								 <C> name='Ecre'		ID='EXP_DATE_ECRE'  width=60 	align=center 	Edit=None bgColor={IF(ECRE_YN='Y',IF(EXP_DATE_ECRE<'<%=v_todate%>','#ffcccc','#99ff66'),'#FFFFFF') } </C> 
								 <C> name='Nice'		ID='EXP_DATE_NICE' 	width=60 	align=center 	Edit=None bgColor={IF(NICEDNB_YN='Y',IF(EXP_DATE_NICE<'<%=v_todate%>','#ffcccc','#99ff66'),'#FFFFFF') } </C>
								</G>
								<G> name='�ſ���'
								 <C> name='Ecre'		ID='CREDIT_GRD_E'   width=40 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								 <C> name='Nice'		ID='CREDIT_GRD_N'  	width=40 	align=center 	Edit=None editstyle=lookup data='ds_credit_grd:detail:detail_nm'</C>
								</G>
								<G> name='�����帧'
								 <C> name='Ecre'		ID='CASHFLOW_GRD_E'   	width=40 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								 <C> name='Nice'		ID='CASHFLOW_GRD_N'  	width=40 	align=center 	Edit=None editstyle=lookup data='ds_cashflow_grd:detail:detail_nm'</C>
								</G>
								 <C> name='���\\����'		ID='IN_YN'	 	 	width=40 	align=center 	Edit=None bgColor={IF(IN_YN='Y','#FFFF00','#FFFFFF')} </C>
                         ">                             
                        </object>   
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
			<td><br>�� GRID�� ����Ŭ���ϸ� ���»� �Ѱ����� â�� �˾��˴ϴ�.<BR>
			�� ����� Ecre, Nice �÷����� ����� Y�� ����Ŭ������ �ſ��򰡻� ���� â�� �˾��˴ϴ�.
			</td>
        </tr>
    </table>

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	<param name="DataId" value="ds_cnt">
	<param name=BindInfo    value="
		<C>Col=c_all	Ctrl=c_all	Param=Value </C>
		<C>Col=c_both	Ctrl=c_both	Param=Value </C>
		<C>Col=c_nice	Ctrl=c_nice	Param=Value </C>
		<C>Col=c_ecre	Ctrl=c_ecre	Param=Value </C>
		<C>Col=c_none	Ctrl=c_none	Param=Value </C>
	">
</object>
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		