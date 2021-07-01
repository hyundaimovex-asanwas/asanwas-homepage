<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>PMS>����ī��>ī�� ����>ī�� ��Ȳ
 * ���α׷�ID 	 : PMS/CC110I
 * J  S  P		 : cc110i.jsp, GAUCE5.x
 * �� �� ��		 : Cc110I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2015-08-05
 * [ �������� ][������] ����
 * [2015-08-05][�ɵ���] �繫�� �����ڿ�, ��ü ī�� ��Ȳ ��ȸ
 *						BCAS ī�� ��Ȳ�� �����ؼ� �̵��ī��� ǥ��������
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
		
		cfStyleGrid(getObjectFirst("gr_cl"), "comn");	//card list
		cfStyleGrid(getObjectFirst("gr_coa"), "comn");	//card operating author

		fnInit();
	}
	
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    //v_frdt.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
	    
        ds_gc_cardspec.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC011&s_item1=Y";
        ds_gc_cardspec.Reset();	//ī�� ����
        ds_gc_cadiv.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CC012&s_item1=Y";
        ds_gc_cadiv.Reset();	//ī�� ����
        ds_gc_useyn.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY010&s_item1=Y";
        ds_gc_useyn.Reset();	//��뿩�� YN (SY010)(��ü+ : dsType=4)
        ds_gc_cabank.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC013&s_item1=Y";
        ds_gc_cabank.Reset();	//ī�� ��������(3�ڸ�)

        ds_gc_bc1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC001&s_item1=Y";
        ds_gc_bc1.Reset();	//bc ī����������
        ds_gc_bc2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC002&s_item1=Y";
        ds_gc_bc2.Reset();	//bc ī�弼�α���
        ds_gc_bc3.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CC003&s_item1=Y";
        ds_gc_bc3.Reset();	//bc �̵�����
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
            "JSP(O:DS_CL=ds_cl)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	
    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_cardspec=" + lc_gc_cardspec.ValueOfIndex("detail", lc_gc_cardspec.Index)	//����
			+ ",v_cadiv=" + lc_gc_cadiv.ValueOfIndex("detail", lc_gc_cadiv.Index)	//����
			+ ",v_mgr_no=" + v_mgr_no.value	//ó���� ���
			+ ",v_useyn=" + lc_gc_useyn.ValueOfIndex("detail", lc_gc_useyn.Index)	//��뿩��
			+ ",v_card_num=" + v_card_num.value	//ī���ȣ
			;
		//alert(param);
		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
            "JSP(O:DS_CL=ds_cl)",
            param);

        tr_post(tr1);
        
    }

    
    
    <%// ������ - ī�庰 ó�� ����%>
    function fnSelectDetail(row) {
    	
        if(row!=v_default_row){
    		v_default_row = row;//�̹��� �������� ��ȸ�ϴ� row�� ��Ƶΰ� ��
        }
        
	        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
	                    + ",v_ca_sid="+ ds_cl.namevalue(row,"CA_SID");
			ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
	            "JSP(O:DS_COA=ds_coa)",
	            v_param);
			
	        tr_post(tr2);
	        
    }    
    
    
    
    <%//ó������ ���߰�%>
    function fnAddRowDt1(){
    	
		ds_coa.addrow();
		
		ds_coa.namevalue(ds_coa.RowPosition, "ca_sid") = ds_cl.namevalue(ds_cl.RowPosition,"CA_SID");
		ds_coa.namevalue(ds_coa.RowPosition, "canbr") = ds_cl.namevalue(ds_cl.RowPosition,"CANBR");
		
		msgTxt.innerHTML="[ó������] ���� ���ԵǾ����ϴ�.";		
		
    }    
    
    
    
    <%//ó������ �����%>
    function fnDelRowDt1(){
    	
		ds_coa.deleterow(ds_coa.RowPosition);
		
		ds_coa.namevalue(ds_coa.RowPosition, "ca_sid") = ds_cl.namevalue(ds_cl.RowPosition,"CA_SID");
		ds_coa.namevalue(ds_coa.RowPosition, "canbr") = ds_cl.namevalue(ds_cl.RowPosition,"CANBR");
		
		msgTxt.innerHTML="[ó������] ���� �����Ǿ����ϴ�.";		
		
    }   
    
    

	<%//���� %>
	function fnApply(){
		
		v_job = "A";
		
		v_default_row = ds_cl.RowPosition;
		
		if (ds_cl.IsUpdated || ds_coa.IsUpdated) {
			
			if(ln_Chk()){
				
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CC%>Cc010I",
                "JSP(I:DS_CL=ds_cl,I:DS_COA=ds_coa)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	);
			  
			  //prompt(this, ds_coa.text);
			  
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
    		ds_cl.namevalue(row, "CADEPTCD") = arrParam[4]; //�μ��ڵ�
    		ds_cl.namevalue(row, "DPT_NM") = arrParam[2];	//�μ���
    		ds_cl.namevalue(row, "CAEMPNO") = arrParam[1];	//������ ���
    		ds_cl.namevalue(row, "EMP_NM") = arrParam[0];	//ī�� ������
    		
        } else {
        	
    		ds_cl.namevalue(row, "CADEPTCD") = ""; //�μ��ڵ�
    		ds_cl.namevalue(row, "DPT_NM") = '';	//�μ���
    		ds_cl.namevalue(row, "CAEMPNO") = "";	//������ ���
    		ds_cl.namevalue(row, "EMP_NM") = "�̵��";	//ī�� ������
    		
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
    		ds_cl.namevalue(row, "VEND_NM") = arrParam[1];	//�ŷ�ó��
    		ds_cl.namevalue(row, "VEND_CD") = arrParam[0];	//�ŷ�ó�ڵ�
    		
        } else {
        	
        	ds_cl.namevalue(row, "VEND_NM") = "";	//�ŷ�ó��
    		ds_cl.namevalue(row, "VEND_CD") = "";	//�ŷ�ó�ڵ�
    		
        }               
    	
    }
    
    
    
    
    function fnEmpNoCleanup(){
    	
        v_mgr_no.value = "";
        
        v_mgr_nm.value  = "";
        
    }
    
    
    
    
    function fnCardNoCleanup(){
    	
    	v_card_num.value = "";
    	
    	v_card_num.focus();
    	
    }

    
    
    
	<%//�׼� �ٿ��ϱ�%>
    function fnExcelDsDefault() {
    	
        if(ds_cl.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        getObjectFirst("gr_cl").SetExcelTitle(0, "");
        getObjectFirst("gr_cl").SetExcelTitle(1, "value:����ī�� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_cl").GridToExcel("����ī�� ��Ȳ", v_todt+"_����ī��_��Ȳ.xls", 8);     
        
    }

    
    </script>
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>



	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=gr_cl event=OnClick(Row,Colid)>
	
	
		if(Colid=="JOB_SEL") {
			
			if(ds_cl.namevalue(Row,"EMP_NM")=="�̵��"){
				
				//erpī�������� ���� ���. BCAS������ �����ؼ� �⺻������ ������ش�.
				ds_cl.namevalue(Row, "CACARDSPEC") = "004";											//ī��\\����
				
				if(ds_cl.namevalue(Row,"CardDetailGubun")="1"){										// ���� �� ���θ�, ���� �� ���θ�. ����Ʈ. ���ܵ� ����.
					ds_cl.namevalue(Row,"CADIV") = "2";												//ī�屸��
				}else{
					ds_cl.namevalue(Row,"CADIV") = "1";
				}
				
				ds_cl.namevalue(Row, "CANBR") = ds_cl.namevalue(Row,"CardNumber");					//ī���ȣ
				ds_cl.namevalue(Row, "CAUSEYYMM") = ds_cl.namevalue(Row,"CardExpiredDate");			//��ȿ�Ⱓ
				ds_cl.namevalue(Row, "CAISSYYMM") = ds_cl.namevalue(Row,"SENDDATE").substring(0,6);	//�߱޳��
				ds_cl.namevalue(Row, "CASTTDAT") = ds_cl.namevalue(Row,"AccountDate");				//��������
				ds_cl.namevalue(Row, "CAACCBANK") = "0"+ds_cl.namevalue(Row,"AccountBank");			//�����ڵ�
				ds_cl.namevalue(Row, "CABANKNO") = ds_cl.namevalue(Row,"AccountNumber");			//��������
				ds_cl.namevalue(Row, "CACUST") = ds_cl.namevalue(Row,"MemberKrName");				//ȸ���� -> ������
				ds_cl.namevalue(Row, "USE_TAG") = "Y"; 												//��뿩��
				
				
			}else{//erpī�������� �ִ� ���
				alert("�̵�� ī�常 üũ�� �� �ֽ��ϴ�.");
				ds_cl.undo(Row);//�ش� DataSet�� Row�� ������(=Original Data)�� ������Ų��.
			}
		}else{
			fnSelectDetail(Row);
			//row.value = ds_cul.RowPosition;			
		}
			
	</script>




	<%//������ : �˾�  %>	
	<script language=JavaScript for=gr_cl event=OnPopup(row,colid,data)>
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
		//fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}
	
</script>




<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    <script language="JavaScript"  for="ds_cl" event="OnLoadStarted()" >
    
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.";
        
    </script>
 
 
    <script language=JavaScript  for=ds_cl event="OnLoadCompleted(row)">
    
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_cul.ClearData();
			    ds_coa.ClearData();
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

<object id=ds_cl classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_coa classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cardspec classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cadiv classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_useyn classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_cabank classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
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
            <td>
                <table border='0' cellpadding='0' cellspacing='0' width='1050px'>
                    <tr>
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
            <td>
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1050px'>
           			<tr>
                        <td align="left" class="text" width="90">ī�� ����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cardspec classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=60 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_cardspec>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^40">
                            </object>
                        </td>                                
                        <td align="left" class="text" width="90">����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_cadiv classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=80 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_cadiv>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
                            </object>
                                                        
                        </td>                                
                        <td align="center" class="text" width="90">������</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_mgr_no' id="v_mgr_no" style="width:60px;" class='input01' readOnly="readonly" value="">
                        	&nbsp;<input type="text" name='v_mgr_nm' id="v_mgr_nm" style="width:60px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="�� �����">
                        </td>
                        <td align="left" class="text" width="90">��� ����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_useyn classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
                                <param name=ComboDataID     value=ds_gc_useyn>
								<param name=BindColumn      value="detail">
								<param name=BindColVal      value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
                            </object>                   
                        </td>                                
					</tr>

           			<tr>
                        <td align="center" class="text" width="90">ī���ȣ</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_card_num' id="v_card_num" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnCardNoCleanup();" alt="�� �����">
                        </td>
                        <td colspan=6 bgcolor="#ffffff">&nbsp;</td>
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <object id=gr_cl classid=<%=HDConstant.MxGrid_CLSID_S%> width='1050px' height='250px' border='1'>
                    <param name="DataID"            value="ds_cl">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"         value="true">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     value="Right">                    
                    <param name="Format"            value="
						<C> name='Chk'          	ID='JOB_SEL'   	 	 Width=30   EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False </C>
						<C> name='ī��\\����'   	ID='CACARDSPEC'   	 width=50 	align=CENTER	editstyle=lookup Data='ds_gc_cardspec:detail:detail_nm' SumText='��' </C>
						<C> name='����'   		 	ID='CADIV'   		 width=50 	align=CENTER	editstyle=lookup Data='ds_gc_cadiv:detail:detail_nm' SumText=@count </C>
                        <C> name='�����μ�'	 		ID='DPT_NM'   		 width=100 	align=left  edit=none SumText='��' </C>
                        <C> name='ī��\\������' 	ID='EMP_NM'   		 width=70 	align=CENTER EditStyle=popup bgColor={IF(EMP_NM='�̵��','#ffcccc','#FFFFFF') }</C>
                        <C> name='ī���ȣ'	 		ID={IF(EMP_NM='�̵��',CardNumber, CANBR) }  width=140 	align=left	edit=none mask='XXXX-XXXX-XXXX-XXXX' bgColor={IF(EMP_NM='�̵��','#ffcccc','#FFFFFF') } </C>
                        <C> name='��ȿ\\�Ⱓ'	 	ID='CAUSEYYMM'	 	 width=60 	align=CENTER edit=none mask='XXXX/XX'</C>
                        <C> name='���'				ID='USE_TAG'   	 	width=40 	align=center	 bgColor={IF(USE_TAG='N','#ffcccc','#FFFFFF') }	editstyle=lookup Data='ds_gc_useyn:detail:detail_nm'</C>
                        <C> name='�������'			ID='DSUDT'   	 	width=70 	align=center	 bgColor={IF(USE_TAG='N','#ffcccc','#FFFFFF') }</C>                        
                        <C> name='�ѵ�'   	     	ID='CAMAX'			 width=70 	align=right	 decao=0  </C>
                        <C> name='���'			 	ID='CAETC'   		 width=60 	align=left	 </C>
                        <C> name='�߱�\\���'		ID='CAISSYYMM'   	width=60 	align=center mask='XXXX/XX'</C>
                        <C> name='������'			ID='CASTTDAT'    	width=50 	align=center </C>
                        <C> name='����\\����'		ID='CAACCBANK'   	width=50 	align=center editstyle=lookup Data='ds_gc_cabank:detail:detail_nm' </C>
                        <C> name='��������'			ID='CABANKNO'    	width=100 	align=left	</C>
                        <C> name='������'			ID='CACUST'   	 	width=120 	align=left	</C>
                        <C> name='(ȸ��)\\�ŷ�ó'	ID='VEND_NM'   	 	width=120 	align=left	EditStyle=popup </C>

					  <G> name='ī������ (BC����)'
						<C> name='����1'   			ID='CARDGUBUN'   	 width=50 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_bc1:detail:detail_nm' </C>
						<C> name='����2'   			ID='CardDetailGubun' width=40 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_bc2:detail:detail_nm' </C>
						<C> name='ī���ȣ'			ID='CardNumber'  	 width=140 	align=left		edit=none mask='XXXX-XXXX-XXXX-XXXX' </C>
						<C> name='ȸ����'			ID='MemberKrName'	 width=80 	align=left		edit=none </C>
						<C> name='��ȿ�Ⱓ'			ID='CardExpiredDate' width=70 	align=CENTER 	edit=none </C>
						<C> name='�̵�'   			ID='InfoGubun'   	 width=70 	align=left		editstyle=lookup Data='ds_gc_bc3:detail:detail_nm' bgColor={IF(InfoGubun='3','#ffff00','#FFFFFF') }</C>
						<C> name='������'			ID='AccountDate'   	 width=50 	align=CENTER	edit=none </C>
                        <C> name='����'				ID='AccountBank'   	 width=50 	align=CENTER	edit=none </C>
                        <C> name='��������'			ID='AccountNumber'   width=90 	align=left		edit=none </C>
                        <C> name='��������'			ID='SENDDATE'   	 width=70 	align=center	edit=none </C>
					  </G>
                 ">                             
                </object>                        

            </td>
        </tr>
        <tr>
            <td valign="top"><br>
            	<table border=0>
				  <tr>
					<td></td>
					<td height='21px' align='right'>
						<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:pointer" onClick="fnDelRowDt1()" >					
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
    				</td>
				  </tr>            	
            	  <tr>
            	  	<td width=240 class="t"><h3>ó�� ���� ����</h3>
            	  	ó���ڴ� ī�� �����Ȳ �޴�����<br>
            	  	���ӹ��� ��� ī���� �����Ȳ��<br>
            	  	Ȯ���� �� �ֽ��ϴ�.</td>
            	  	<td width=520>
		                <object id=gr_coa classid=<%=HDConstant.MxGrid_CLSID_S%> width='800px' height='300px' border='1'>
		                    <param name="DataID"            value="ds_coa">
		                    <param name="Editable"          value="true">
		                    <param name="BorderStyle"       value="0">
		                    <param name="SuppressOption"    value="1">
		                    <param name="Format"            value="
		                    	<C> name='No'		 ID='{CurRow}'	 width=30 	align=center    edit=none</C>
		                        <C> name='ī���ȣ'	 ID='CANBR'		 width=200  align=center    edit=none mask='XXXX-XXXX-XXXX-XXXX' suppress='1' </C>
		                        <C> name='��������'	 ID='BGNDATE'	 width=150 	align=center	 mask='XXXX-XX-XX' </C>
		                        <C> name='��������'	 ID='ENDDATE'	 width=150 	align=center	 mask='XXXX-XX-XX' </C>
		                        <C> name='ó����'	 ID='MGR_NM'	 width=120 	align=CENTER	EditStyle=popup </C>
		                        <C> name='���'		 ID='MGR_NO'	 width=120 	align=CENTER	edit=none </C>
		                 ">                             
		                </object>                        
            	  	</td>
            	  </tr>
            	</table>
            </td>
        </tr>

    </table>
    

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		