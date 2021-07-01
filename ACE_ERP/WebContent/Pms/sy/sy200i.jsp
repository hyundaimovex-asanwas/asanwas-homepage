<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>PMS>�������� ����>������Ʈ ����>������Ʈ �ڵ� ����
 * ���α׷�ID 	 : PMS/SY200I
 * J  S  P		 : sy200i.jsp, GAUCE5.x
 * �� �� ��		 : Sy200I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-08-20
 * [ �������� ][������] ����
 * [2015-08-20][�ɵ���] ȸ���� �����ڿ�, ��ü ������Ʈ ��Ȳ ��ȸ
 *						
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

<!-- HTML ���� : doctype�� html5��-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
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
	var menuWin;	//��â �����.
	var v_todt = "<%=DateUtil.getCurrentDate(8)%>";
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_pl"), "comn");	//project list
		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY010&s_item1=Y";
        ds_gc_useyn.Reset();	//��뿩�� YN (SY010)(��ü+ : dsType=4)
        ds_gc_prop1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY201&s_item1=Y";
        ds_gc_prop1.Reset();	//�������1 (SY201)(��ü+ : dsType=4)
        ds_gc_prop2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY202&s_item1=Y";
        ds_gc_prop2.Reset();	//�������2 (SY202)(��ü+ : dsType=4)
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200I",
            "JSP(O:DS_PL=ds_pl)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
//			+ ",v_cardspec=" + lc_gc_cardspec.ValueOfIndex("detail", lc_gc_cardspec.Index)	//����
//			+ ",v_cadiv=" + lc_gc_cadiv.ValueOfIndex("detail", lc_gc_cadiv.Index)	//����
//			+ ",v_mgr_no=" + v_mgr_no.value	//ó���� ���
//			+ ",v_useyn=" + lc_gc_useyn.ValueOfIndex("detail", lc_gc_useyn.Index)	//��뿩��
//			+ ",v_card_num=" + v_card_num.value	//ī���ȣ
			;
		alert(param);
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy200I",
            "JSP(O:DS_PL=ds_pl)",
            param);
        tr_post(tr1);
    }


	<%//���� %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_pl.RowPosition;
		
		if (ds_pl.IsUpdated || ds_coa.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
                "JSP(I:ds_pl=ds_pl,I:DS_COA=ds_coa)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%// �Է°� üũ %>
	function ln_Chk() {
		var row1=ds_coa.countrow;
		for(i=1;i<=row1;i++) {
			if(ds_coa.namevalue(i,"BGNDATE")=="") {
				alert("ó�������� �������ڸ� �Է��� �ֽʽÿ�");
				return;
			}else if (ds_coa.namevalue(i,"ENDDATE")=="") {			
				alert("ó�������� �������ڸ� �Է��� �ֽʽÿ�");
				return;
			}else if (ds_coa.namevalue(i,"MGR_NO")=="") {			
				alert("ó�������� ó���ڸ� �Է��� �ֽʽÿ�");
				return;
			}
		}		
		return true;
	}    
    
    
 
	<%//���� ��- ��ȸ ����%>
    function fnEmpNoPopup(dirPath){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
        } else {
			fnEmpNoCleanup();
        }               
    }
	<%//���� ��- ī�� ������ / ī�� �׸���%>
    function fnEmpNoPopup1(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_pl.namevalue(row, "CADEPTCD") = arrParam[4]; //�μ��ڵ�
    		ds_pl.namevalue(row, "DPT_NM") = arrParam[2];	//�μ���
    		ds_pl.namevalue(row, "CAEMPNO") = arrParam[1];	//������ ���
    		ds_pl.namevalue(row, "EMP_NM") = arrParam[0];	//ī�� ������
        } else {
    		ds_pl.namevalue(row, "CADEPTCD") = ""; //�μ��ڵ�
    		ds_pl.namevalue(row, "DPT_NM") = '';	//�μ���
    		ds_pl.namevalue(row, "CAEMPNO") = "";	//������ ���
    		ds_pl.namevalue(row, "EMP_NM") = "�̵��";	//ī�� ������
        }               
    }
    <%//���� ��- ó������ �׸���%>
    function fnEmpNoPopup2(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_coa.namevalue(row, "MGR_NO") = arrParam[1]; 
    		ds_coa.namevalue(row, "MGR_NM") = arrParam[0];
        } else {
    		ds_coa.namevalue(row, "MGR_NO") = ""; 
    		ds_coa.namevalue(row, "MGR_NM") = "";

        }               
    }
	<%//�ŷ�ó �˻� ��- ī���� ȸ�� �ŷ�ó%>
    function fnVenderPopup(dirPath, row){
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
    	strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	arrResult = showModalDialog(strURL,'',strPos);

    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		ds_pl.namevalue(row, "VEND_NM") = arrParam[1];	//�ŷ�ó��
    		ds_pl.namevalue(row, "VEND_CD") = arrParam[0];	//�ŷ�ó�ڵ�
        } else {
        	ds_pl.namevalue(row, "VEND_NM") = "";	//�ŷ�ó��
    		ds_pl.namevalue(row, "VEND_CD") = "";	//�ŷ�ó�ڵ�
        }               
    }
    
    
    
    
    function fnEmpNoCleanup(){
        v_mgr_no.value = "";
        v_mgr_nm.value  = "";
    }
    
    function fnCardNoCleanup(){
    	v_card_num.value = "";
    }

    
	<%//�׼� �ٿ��ϱ�%>
    function fnExcelDsDefault() {
        if(ds_pl.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_pl").SetExcelTitle(0, "");
        getObjectFirst("gr_pl").SetExcelTitle(1, "value:����ī�� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_pl").GridToExcel("����ī�� ��Ȳ", v_todt+"_����ī��_��Ȳ.xls", 8);        
    }

    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=gr_pl event=OnClick(Row,Colid)>
		if(Colid=="JOB_SEL") {
			if(ds_pl.namevalue(Row,"EMP_NM")=="�̵��"){
				//erpī�������� ���� ���. BCAS������ �����ؼ� �⺻������ ������ش�.
				ds_pl.namevalue(Row, "CACARDSPEC") = "004";											//ī��\\����
				if(ds_pl.namevalue(Row,"CardDetailGubun")="1"){		// ���� �� ���θ�, ���� �� ���θ�. ����Ʈ. ���ܵ� ����.
					ds_pl.namevalue(Row,"CADIV") = "2";												//ī�屸��
				}else{
					ds_pl.namevalue(Row,"CADIV") = "1";
				}
				ds_pl.namevalue(Row, "CANBR") = ds_pl.namevalue(Row,"CardNumber");					//ī���ȣ
				ds_pl.namevalue(Row, "CAUSEYYMM") = ds_pl.namevalue(Row,"CardExpiredDate");			//��ȿ�Ⱓ
				ds_pl.namevalue(Row, "CAISSYYMM") = ds_pl.namevalue(Row,"SENDDATE").substring(0,6);	//�߱޳��
				ds_pl.namevalue(Row, "CASTTDAT") = ds_pl.namevalue(Row,"AccountDate");				//��������
				ds_pl.namevalue(Row, "CAACCBANK") = "0"+ds_pl.namevalue(Row,"AccountBank");			//�����ڵ�
				ds_pl.namevalue(Row, "CABANKNO") = ds_pl.namevalue(Row,"AccountNumber");			//��������
				ds_pl.namevalue(Row, "CACUST") = ds_pl.namevalue(Row,"MemberKrName");				//ȸ���� -> ������
				ds_pl.namevalue(Row, "USE_TAG") = "Y"; 												//��뿩��
				
				
			}else{//erpī�������� �ִ� ���
				alert("�̵�� ī�常 üũ�� �� �ֽ��ϴ�.");
				ds_pl.undo(Row);//�ش� DataSet�� Row�� ������(=Original Data)�� ������Ų��.
			}
		}else{
			//fnSelectDetail(Row);
			//row.value = ds_cul.RowPosition;			
		}
			
	</script>



	<%//������ : �˾�  %>	
	<script language=JavaScript for=gr_pl event=OnPopup(row,colid,data)>
		if(colid=="EMP_NM") {
			//alert(row);
			fnEmpNoPopup1('<%=dirPath%>', row);
		}
		if(colid=="VEND_NM") {
			//alert(row);
			fnVenderPopup('<%=dirPath%>', row);
		}
		

	</script>
	
	<%//������1 : ó�� ���� �׸��� / ó����~! %>	
	<script language=JavaScript for=gr_coa event=OnPopup(row,colid,data)>
		if(colid=="MGR_NM") {
			//alert(row);
			fnEmpNoPopup2('<%=dirPath%>', row);
		}
	</script>
	
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
//		fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_pl" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_pl event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_cul.ClearData();
			    ds_coa.ClearData();
			}else{
				//fnSelectDetail(v_default_row);
			}
		}

	</script>
    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_pl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_useyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_prop1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_prop2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bc3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" 	onClick="fnApply();">							
							<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align="center" class="text" width="90">������Ʈ��</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="�� �����">
                        </td>
                        <td align="center" class="text" width="90">���ͼ���</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="left" class="text" width="90">����</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cardspec classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^40">
                            </object>
                        </td>                                
                        <td align="left" class="text" width="90">��� ����</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=60 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>                                
					</tr>
           			<tr>
                        <td align="center" class="text" width="90">�������1</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_prop1>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="center" class="text" width="90">�������2</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=120 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_prop2>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>
                        </td>
                        <td align="center" class="text" width="90">���� ��ǥ</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>
                        <td align="center" class="text" width="90">�ۼ���</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>

					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_pl classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='140px' border='1'>
                    <param name="DataID"            value="ds_pl">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     value="Right">                    
                    <param name="Format"            value="
						<C> name='Chk'          ID='JOB_SEL'    	Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </C>
						<C> name='����'   		 ID='CACARDSPEC' 	width=40 	align=CENTER	editstyle=lookup Data='ds_gc_useyn:detail:detail_nm' SumText='��' </C>
						<C> name='������Ʈ'   	 ID='PLJ_NM'   	 	width=180 	align=left	SumText=@count </C>
						<C> name='����1'   		 ID='PROP1' 		width=40 	align=CENTER	editstyle=lookup Data='ds_gc_prop1:detail:detail_nm' SumText='��' </C>
						<C> name='����2'   		 ID='PROP2' 		width=70 	align=LEFT		editstyle=lookup Data='ds_gc_prop2:detail:detail_nm' </C>
                        <C> name='�����ڵ�'		 ID='COST_CD'    	width=60 	align=center </C>
                        <C> name='���ͼ���'		 ID='PL_DEPT_NM'	width=100 	align=left  edit=none  </C>
                        <C> name='���������'	 ID='CTRT_BGNDATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='����������'	 ID='CTRT_ENDDATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='�������ó'	 ID='ORDER_COMP_NM'  width=100 	align=left  </C>
                        <C> name='������ǥ��'	 ID='EXC_NM'   width=70 	align=center </C>
                        <C> name='������־�'    ID='WIN_FEE'	 width=80 	align=right	 decao=0  </C>
                        <C> name='ERP�ڵ�'		 ID='PLJ_CD'    width=90 	align=left </C>
                        <C> name='���'			 ID='USE_YN'    width=40 	align=center </C>
                        
                        <C> name='���������'	 ID='WIN_DATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='PM��'			 ID='PM_NM'   width=70 	align=center </C>
                        <C> name='�������'      ID='COST_FEE'	 width=80 	align=right	 decao=0  </C>
                        <C> name='�������'		 ID='DSU_DATE'  width=70 	align=center mask='XXXX-XX-XX'</C>
                        <C> name='��¼���'		 ID='PRINT_SEQ'   width=70 	align=center </C>
                        <C> name='Ư�̻���'		 ID='NOTE'   width=70 	align=center </C>
                        
					">                             
                </object>                        

            </td>
        </tr>
		<tr height='6px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
            <!-- �� ȭ�� -->        

                <table  border='0' cellpadding='0' cellspacing='0'>
					<tr height="26px">
			            <td  class="b bold">�� ������Ʈ ����</td>
			        </tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >������Ʈ��</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >������Ʈ�ڵ�</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >�������1</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >�������2</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >���ͼ���</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >���������</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>								
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >���� ������</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >���� ������</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >���� ����ó</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >���</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >������ǥ</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >PM</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
								
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td width="150px"  class="c" bgcolor="#eeeeee" >���� ���־�</td>
									<td width="348px" bgcolor="#ffffff" >&nbsp;
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
									<td width="150px"  class="c" bgcolor="#eeeeee" >���� ����</td>
									<td width="349px" bgcolor="#ffffff" >
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
			            <td><br>
			            <table border="0" cellpadding="0" cellspacing="0">
			              <tr>
			            	<td class="t bold" width="650">�� ���缱
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">			            	
								  	<tr><!-- ���缱 -->
										<td>
											<object id=gr_apline classid=<%=HDConstant.MxGrid_CLSID_S%> width='648px' height='140px' border='0'>
												<param name="DataID"		    value="ds_apline">
												<param name="ColSizing"	    value="true">
												<param name="Fillarea"		    value="false">
												<param name="Editable"		    value="true">
												<param name="BorderStyle"	value="0">
												<param name=SortView  		    value="Left">
												<param name="SuppressOption"    value="1">
												<param name="Format" 			value="
												  <C> name='����SID'   ID='ap_m_sid'   	    width=80	align=left editlimit=5 show=FALSE edit=none    </C>
												  <C> name='����'     	ID=SEQ		       width=35	align=center editlimit=2 show=true edit=none</C>
												  <C> name='����'     	ID=AP_TYPE	       width=45	align=center EditStyle=Lookup Data='ds_gc_aptype:detail:detail_nm' edit=none</C>
									              <C> name='������'    	ID=ENO_NM		   	width=59 	align=center editlimit=50 show=true edit=none</C>
									              <C> name='���'    	ID=ENO_NO		   	width=80 	align=center editlimit=50 show=false edit=none</C>
									              <C> name='����'		ID=JOB_NM		    width=60 	align=center editlimit=20 show=true edit=none</C>
									              <C> name='�μ�'    	ID=DPT_NM	   	    width=100 	align=center editlimit=16 show=true edit=none</C>
									              <C> name='����'     	ID=AP_STATUS_D	    width=40 	align=center EditStyle=Lookup Data='ds_gc_apsts_d:detail:detail_nm' edit=none</C>
									              <C> name='�����Ͻ�'	ID=U_DATE			width=100 	align=center editlimit=50 show=true edit=none</C>
									              <C> name='�ǰ�'	    ID=AP_DESC     		width=208	align=center editlimit=200 show=true edit=true</C>
												">
											</object>   
											
										</td>
									</tr>
								</table>
			              	</td>
			              	<td class="t bold" width="350">���� ÷������
								<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
									<tr height="20px">
										<td width="60px" class="c" bgcolor="#eeeeee">��ȹ</td>
										<td width="272px" bgcolor="#ffffff" align="center">
				                            <object id=RATE_PLAN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:16px;" tabindex="5">
				                                <param name=Text        value="">
				                                <param name=Alignment   value=2>
				                                <param name=VAlign	    value=1>
				                                <param name=Numeric  	value="true">
				                                	<param name=MaxLength	value=3>
													<param name=MaxDecimalPlace	value=2>
				                                <param name=Border      value="false">      
				                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
				                                <param name=ReadOnly    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value="false">
				                            </object>&nbsp;%
				                         </td>
									</tr>
									<tr height="120px">
										<td  class="c" bgcolor="#eeeeee" >÷��<br>����</td>
										<td bgcolor="#ffffff" align="center">
				                            <object id=RATE_RESULT classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;" tabindex="6">
				                                <param name=Text        value="">
				                                <param name=Alignment   value=2>
				                                <param name=VAlign	    value=1>
				                                <param name=Numeric  	value="true">
				                                	<param name=MaxLength	value=3>
													<param name=MaxDecimalPlace	value=2>
				                                <param name=Border      value="false">      
				                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
				                                <param name=ReadOnly    value="false">
				                                <param name=SelectAll   value="true">
				                                <param name=SelectAllOnClick    value="true">
				                                <param name=SelectAllOnClickAny   value="false">
				                            </object>&nbsp;%</td>								
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
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		