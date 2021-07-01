<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���¾�ü���
 * ���α׷�ID 	: CU050I
 * J  S  P		: cu050i
 * �� �� ��		: Cu050I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-16
 * �������		: �븮���� �����ϴ� ���¾�ü(���������)�� ��ϸ޴�.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-02-27][�ɵ���] ��������� : ���̺� ������ ���� �ٽ� ����
 * [2015-10-01][�ɵ���] ���� ���¾�ü�� ���
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			
			fnInit(); 
			
			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
			codeDs3.deleteRow(1);
			codeDs4.deleteRow(1);
			codeDs5.deleteRow(1);
			
			dir_yn.index = 0;
			area_cd.index = 0;
			use_yn.index = 0;
			
			fnSetHeaderDs1();
		} 
			
		/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+ "CLIENT_SID:INT,VEND_CD:STRING,CLIENT_CD:STRING,CLIENT_NM:STRING,CLIENT_GU:STRING,AGEN_GU:STRING,DIR_YN:STRING,AREA_CD:STRING,SAL_DAM_SID:INT,CLIENT_DAM_NM:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,E_MAIL:STRING,ZIP_CD:STRING,ADDRESS1:STRING,ADDRESS2:STRING,COMMI_RATE:INT,CUNT_STATUS:STRING,BANCOD:STRING,BANK_ACC_NO:STRING,BANK_ACCT_NM:STRING,USE_YN:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING,VEND_TYPE:STRING,VEND_ID:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}		
		

		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
            	"JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);


	 		codeDs8.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU024";
			codeDs8.Reset(); //���α���

		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			if(sClient_nm.value == "" && sSal_dam_sid.value == ""){
				alert("���¾�ü �Ǵ� ����� �� �Ѱ����� �ݵ�� �ԷµǾ� �մϴ�.")
				return;
			}
			
			if (ds1.IsUpdated==false ) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾����� ���¿����� ��ȸ�Ҽ� �����ϴ�!");
			}
		}
			
		

			
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
			jobFlag = "N";
			ds1.addRow();
			rowNum.value = ds1.rowposition;
			
			ds1.namevalue(ds1.rowposition,"client_gu") = "2";	//����ó���� == 2(���¾�ü)��...;;;
			vend_type.index=1;	//���α��� �⺻�� [��������] ����.
		}
			
		
	
		
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
		}

		 
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
		 if (ds1.IsUpdated) {
				if (jobFlag != "D") {
				 for(var i=1; i<=ds1.CountRow; i++){
				  	if(ds1.NameValue(ds1.rowposition, "client_cd")=="") {
	                 	alert("���¾�ü �ڵ带 �Է��ϼ���!");
	                 	getObjectFirst("client_cd").focus();
	                 	return;
	                 }
	                 
				 	if(ds1.NameValue(ds1.rowposition, "client_nm")==""){
	                    alert("���¾�ü���� �Է��ϼ���!");
	                    getObjectFirst("client_nm").focus();
	                    return;
	                 }
	                
			  		if(ds1.NameValue(ds1.rowposition, "vend_cd")=="") {
	                 	alert("�ŷ�ó�� �����ϼ���!");
	                 	getObjectFirst("vend_nm").focus();
	                 	return;
	                 }
	
			  		if(ds1.NameValue(ds1.rowposition, "sal_dam_sid")=="") {
	                 	alert("��������ڸ� �����ϼ���!");
	                 	getObjectFirst("sal_dam_nm").focus();
	                 	return;
	                 }
			  		
			  		if(ds1.NameValue(ds1.rowposition, "dir_yn")=="") {
	                 	alert("���ǿ��θ� �����ϼ���!");
	                 	getObjectFirst("dir_yn").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
	                 	alert("���¾�ü����ڸ� �Է��ϼ���!");
	                 	getObjectFirst("client_dam_nm").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "tel_no")=="") {
	                 	alert("��ȭ��ȣ�� �Է��ϼ���!");
	                 	getObjectFirst("tel_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "mobile_no")=="") {
	                 	alert("�޴���ȭ�� �Է��ϼ���!");
	                 	getObjectFirst("mobile_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "fax_no")=="") {
	                 	alert("�ѽ��� �Է��ϼ���!");
	                 	getObjectFirst("fax_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "e_mail")=="") {
	                 	alert("�̸����� �Է��ϼ���!");
	                 	getObjectFirst("e_mail").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "zip_cd")=="") {
	                 	alert("�����ȣ�� �����ϼ���!");
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "address2")=="") {
	                 	alert("���ּҸ� �Է��ϼ���!");
	                 	getObjectFirst("address2").focus();
	                 	return;
	                 }
	                 

			  		if(ds1.NameValue(ds1.rowposition, "bancod")=="") {
	                 	alert("������ �����ϼ���!");
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "bank_acc_no")=="") {
	                 	alert("���¹�ȣ�� �Է��ϼ���!");
	                 	getObjectFirst("bank_acc_no").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "bank_acct_nm")=="") {
	                 	alert("�����ָ� �Է��ϼ���!");
	                 	getObjectFirst("bank_acct_nm").focus();
	                 	return;
	                 }
			  		if(ds1.NameValue(ds1.rowposition, "use_yn")=="") {
	                 	alert("��������� �����ϼ���!");
	                 	getObjectFirst("use_yn").focus();
	                 	return;
	                 }
	                }
              }
			 
		} 
		
		
			 
			 return true;
		}

		/*
		 * ����
		 */		
		function fnApply() {
	
			var row=ds1.countRow;
			
			if (ds1.IsUpdated ) {
				if(fnCheck()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
            	}
			}	
			
		}
			
		/*
		 * ��� 
		 */
		function fnCancel() {
		
			
			ds1.undoall();
			
			if (ds1.countrow >= 1) {
				fnSelectDs1();
			}
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}
			
			
		/*
		 * ����Ʈ
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			gr1.runexcelsheet("���������");
		}
			
		/*
		 * ����ȸ�� �˾�
		 */
		function fnPopup() {
			
		}
		
		/*
		 * ���� �˾�
		 */
		 function fnAreaPopup() {
		 }
		 
		/*
		 * �����ȣ �˾� 
		 */ 
		function fnZipCodePopup() {
	       var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	            
	        strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
	        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	        arrResult = showModalDialog(strURL,arrParam,strPos);    
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            zip_cd.Text= arrParam[0];
	            address1.value = arrParam[1];
	            
	        } else {
	          zip_cd.Text = "";
	          address1.value = "";
	        }       				
		}			
		
		/*
		 * ���������
		 */
		 
		 function fnSalDamPopup(flag) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
				
			 	if (flag == "S") {
			 		sSal_dam_sid.value = arrParam[0];
			 		sSal_dam_nm.value = arrParam[2];
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = arrParam[0];
			 		sal_dam_nm.value = arrParam[2];
			 	}
			} else {
				if (flag == "S") {
			 		sSal_dam_sid.value = "";
			 		sSal_dam_nm.value = "";
			 	} else if (flag == "I") {
			 		sal_dam_sid.value = "";
			 		sal_dam_nm.value = "";
			 	}
			}
		 }

		/*
		 * ���¾�ü �˾�
		 */
		function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			var dir = '<%=dirPath%>';
			
			arrResult = fnClientPop(dir,'1');
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		client_cd.value = arrParam[2];
		   		client_nm.value = arrParam[1];
			} else {
			  client_nm.value = "";
			  client_cd.value = "";
			}				
		}		 
		/*
		 * �ŷ�ó �˾� 
		 */
		function fnVendPopup() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/cu004h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		vend_cd.value = arrParam[0];
		   		vend_nm.value  = arrParam[1];
			} else {
			 	vend_cd.value = "";
			  	vend_nm.value = "";
			}
			return ;			
		}
		/*
		 * �����ڵ� �˾�
		 */
		function fnCommonCodePopup(head, headNm) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			arrParam[0] = head;
			arrParam[1] = headNm;
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
			if (head == 'AC002') {		// ���� 
					bancod.value = arrParam[1];
					bannam.value = arrParam[2];
				} 
				
	
			} else {
				if (head == 'AC002') {	// ���� 
					bancod.value = "";
					bannam.value = "";
				}
			}
			return ;	
		}		


	    // ���¾�ü �ڵ� �����
		function fnSelectClientCd() {
		        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2";

		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu050I",
		            "JSP(O:SEARCH_DS1=searchds1)",
		            param);
		        tr_post(tr1);
		}


		
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	
	<script language=JavaScript  for=searchds1 event="OnLoadCompleted(row)">
		client_cd.text = searchds1.namevalue(searchds1.rowposition,"CLIENT_CD");
		
	</script>
	
	
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���¾�ü ��ȸ -->
		<param name="SyncLoad" 	value="true">
	</object>
	
	<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���¾�ü���� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���Ǳ��� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��������ȸ�� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������¾�ü ���� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=codeDs8 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���α��� ���� -->
		<param name="SyncLoad" 	value="false">
	</object>

	<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���¾�ü�ڵ� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
		<param name="Action"     value="">
		<param name="KeyValue"   value="">
		<param name="Parameters" value="">
	</object>
	<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='525px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='70px' height="30px" class='text'>���¾�ü</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
							<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
						</td>
						<td width='70px' height="30px" class='text'>�����</td>
						<td width='120px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
							<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="��������ڸ� �˻��մϴ�"  style="cursor:pointer" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
						<td width='80px' height="30px" class='text'>�������</td>
						<td width='100px' height="30px" bgcolor='#FFFFFF'>&nbsp;
							<%=HDConstant.COMMENT_START%>
                            <object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
								<param name=ComboDataID		value=sCodeDs1>
								<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^80">
							</object>
							<%=HDConstant.COMMENT_END%>	
						</td>
					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='300px'>
					<tr>
						<td height='30px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:pointer"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:pointer" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"	align=absmiddle onclick="fnCancel()">
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='300px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='427px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="Format" 			value="
								                <C> name='���¾�üSID'   	ID='client_sid' 		Width=100  align=left editlimit=12 	show=false</C>
								                <C> name='�ŷ�ó�ڵ�'    	ID='vend_cd'    		Width=100  align=left editlimit=13 	show=false</C>
								                <C> name='�ŷ�ó��'      	ID='vend_nm'    		Width=100  align=left editlimit=62 	show=false</C>
								                <C> name='���¾�ü�ڵ�'    	ID='client_cd'  		Width=100  align=left editlimit=5 	show=true sort=true</C>
								                <C> name='���¾�ü��'    	ID='client_nm'  		Width=183  align=left editlimit=30 	show=true</C> <!-- �븮���� : ���¾�ü�� -->
								                
								                <C> name='�븮������'    	ID='client_gu'  		Width=100  align=left editlimit=1 	show=false</C> <!-- �븮�� ���� 1 = ���¾�ü -->
								                <C> name='���¾�ü����'    	ID='agen_gu'    	Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='���¾�ü���и�' 	ID='agen_gu_name'   Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='���ǿ���'      	ID='dir_yn'     		Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='���ǿ��θ�'  	ID='dir_yn_name'    	Width=100  align=left editlimit=50 	show=false</C>

								                <C> name='�����ڵ�'      	ID='area_cd'    		Width=100  align=left editlimit=2 	show=FALSE</C>
								                <C> name='�����ڵ��' 	ID='area_cd_name'   	Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='���������SID' 	ID='sal_dam_sid'    	Width=100  align=left editlimit=12 	show=FALSE</C>
								                <C> name='��������ڸ�'   ID='sal_dam_nm' 		Width=100  align=left editlimit=22 	show=false</C>
								                <C> name='���¾�ü�����' ID='client_dam_nm'  	Width=100  align=left editlimit=20 	show=false</C>

								                <C> name='��ȭ��ȭ '     	ID='tel_no'    			Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='�޴���ȭ'    	ID='mobile_no'  		Width=100  align=left editlimit=15 	show=false</C>
								                <C> name='�ѽ���ȣ'      	ID='fax_no'     		Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='�̸���'       	ID='e_mail'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='�����ȣ'      	ID='zip_cd'     		Width=100  align=left editlimit=6 	show=false</C>

								                <C> name='�ּ�1'     	ID='address1'   		Width=100  align=left editlimit=60 	show=false</C>
								                <C> name='�ּ�2'     	ID='address2'   		Width=100  align=left editlimit=60 	show=false</C>
								                <C> name='��������'   	ID='commi_rate' 		Width=100  align=left editlimit=7 	show=false</C>
								                <C> name='������'  	ID='cunt_status'        Width=100  align=left editlimit=1 	show=false</C>
								                <C> name='�����¸�' 	ID='cunt_status_name'   Width=100  align=left editlimit=50 	show=false</C>

								                <C> name='�����ڵ�'     ID='bancod'     		Width=100  align=left editlimit=6 	show=false</C>
								                <C> name='�����'       ID='bannam'     		Width=100  align=left editlimit=30 	show=false</C>
								                <C> name='������¹�ȣ' ID='bank_acc_no'        Width=100  align=left editlimit=20 	show=false</C>
								                <C> name='������' 		ID='bank_acct_nm'       Width=100  align=left editlimit=32 	show=false</C>
								                <C> name='��뿩��'     ID='use_yn'     		Width=100  align=left editlimit=1 	show=false</C>

								                <C> name='��뿩�θ�'  	ID='use_yn_name'        Width=100  align=left editlimit=50 	show=false</C>
								                <C> name='���α���'  	ID='vend_type'        Width=100  align=left editlimit=50 	show=FALSE</C>
								                <C> name='����ڹ�ȣ'  	ID='vend_id'        Width=100  align=left editlimit=50 	show=FALSE</C>
								        	">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						<td width='10px'></td>
						<td valign='top'>
							<table border='0' cellpadding='0' cellspacing='0' width='530px'>
								<tr>
									<td width='535px'>
										<table border='0' cellpadding='0' cellspacing='1' width='530px' height='244px' bgcolor="#666666">
											<tr>
												<td width='120px' height='30px' class='boardt02'>���¾�ü�ڵ�</td>
												<td bgcolor='#FFFFFF'>&nbsp;
													<%=HDConstant.COMMENT_START%>
													<object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
														<param name=Alignment 	value=1>
														<param name=Format 		value="00000">
														<param name=Enable      value="false">
                                                        <param name=Border   	value=false>
													</object>
													<%=HDConstant.COMMENT_END%>
													&nbsp;<img src="<%=dirPath%>/Sales/images/n_create.gif" border="0" 	ALT="��û����ȣ����"  		style="cursor:pointer"  onclick="javascript:fnSelectClientCd();" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>���¾�ü��</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;
													<input type='text' id='client_nm' 		name='client_nm' 		value='' maxlength='30' size='20' 	class='textbox' > <!-- �븮�� �� -->
													
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>ȸ��ŷ�ó��</td>
												<td  bgcolor='#FFFFFF'>
													<input type='hidden' id='vend_cd' 			name='vend_cd' 			value='' maxlength='13' size='10' 	class='textbox'> <!-- �ŷ�ó�ڵ� -->
													&nbsp;&nbsp;<input type='text' id='vend_nm' 			name='vend_nm' 			value='' maxlength='62' size='15' 	class='textbox' readonly> <!-- �ŷ�ó�� -->
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�ŷ�ó�� �˻��մϴ�"  style="cursor:pointer" id="vend_btn" onclick="javascript:fnVendPopup();" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>���������</td>
												<td   bgcolor='#FFFFFF'>
													<input type='hidden' id='sal_dam_sid' 		name='sal_dam_sid' 		value='' maxlength='12' size='12' 	class='textbox' readonly> <!-- ����������ڵ� -->
       												&nbsp;&nbsp;<input type='text' id='sal_dam_nm' 		name='sal_dam_nm' 		value='' maxlength='22' size='10' 	class='textbox' readonly> <!-- ��������ڸ� -->
       												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="��������ڸ� �˻��մϴ�"  style="cursor:pointer" id="sal_dam_btn" onclick="javascript:fnSalDamPopup('I');" align='absmiddle'>
												</td>
											</tr>
											<tr>
												<td width='120px' height='30px' class='boardt02'>���¾�ü�����</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='client_dam_nm' 	name='client_dam_nm' 	value='' maxlength='20' size='20' 	class='textbox'> <!-- �븮������� -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>���ǿ���</td>
												<td  bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='dir_yn' 			name='dir_yn' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- ���ǿ��� -->
       												<!-- &nbsp;&nbsp;<input type='text' id='dir_yn_name' 		name='dir_yn_name' 		value='' maxlength='50' size='10' 	class='textbox'> <!-- ���ǿ��θ� -->
      												<%=HDConstant.COMMENT_START%>
						                            <object id=dir_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs2>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>���α���</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
      												<%=HDConstant.COMMENT_START%>
						                            <object id=vend_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs8>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^120">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
												<td  width='120px' height='30px' class='boardt02'>����ڵ�Ϲ�ȣ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='vend_id' 	name='vend_id' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- �޴���ȭ -->
												</td>
											</tr>

											
											<tr>
												<td  width='120px' height='30px' class='boardt02'>��ȭ��ȣ</td>
												<td   bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='tel_no' 			name='tel_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- ��ȭ��ȣ -->
													
												</td>
												<td  width='120px' height='30px' class='boardt02'>�޴���ȭ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='mobile_no' 		name='mobile_no' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- �޴���ȭ -->
												</td>
											</tr>

											<tr>
												<td  width='120px' height='30px' class='boardt02'>�ѽ���ȣ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='fax_no' 			name='fax_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- FAX��ȣ -->
												</td>
												<td  width='120px' height='30px' class='boardt02'>�����ּ�</td>
												<td  bgcolor='#FFFFFF'>
													 &nbsp;&nbsp;<input type='text' id='e_mail' 			name='e_mail' 			value='' maxlength='30' size='23' 	class='textbox'> <!-- �̸��� -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>�����ȣ</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
													<!-- &nbsp;&nbsp;<input type='text' id='zip_cd' 			name='zip_cd' 			value='' maxlength='6' 	size='6' 	class='textbox'> <!-- �����ȣ -->
													
													<%=HDConstant.COMMENT_START%>
													<object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>			
														<param name=Alignment 	value=1>
														<param name=Format 		value="###-###">
														<param name=Cursor	 	value="Hand">
														<param name=Enable      value="False">
                                                        <param name=ReadOnly    value="True">
                                                        <param name=Border   	value=false>
													</object>
													<%=HDConstant.COMMENT_END%>&nbsp;&nbsp;
													<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ȣ�� �˻��մϴ�"  style="cursor:pointer" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>													
												</td>
												<td  width='120px' height='30px' class='boardt02'>�����ڵ�</td>
												<td  width='165px' height='30px' bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='area_cd' 			name='area_cd' 			value='' maxlength='2' 	size='2' 	class='textbox'> <!-- �����ڵ� -->
       												<!-- &nbsp;&nbsp;<input type='text' id='area_cd_name' 	name='area_cd_name' 	value='' maxlength='50' size='10' 	class='textbox'> <!-- ������ -->	
      												<%=HDConstant.COMMENT_START%>
						                            <object id=area_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs3>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
       												
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>�ּ�1</td>
												<td  bgcolor='#FFFFFF' colspan='3'>
													&nbsp;&nbsp;<input type='text' id='address1' 		name='address1' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- �ּ�1 -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>�ּ�2</td>
												<td  bgcolor='#FFFFFF'colspan='3'>
													&nbsp;&nbsp;<input type='text' id='address2' 		name='address2' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- �ּ�2 -->
												</td>
											</tr>

											<tr>
												<td  width='120px' height='30px' class='boardt02'>�����ڵ�</td>
												<td  bgcolor='#FFFFFF'>
													 <input type='hidden' id='bancod' 			name='bancod' 			value='' maxlength='6' 	size='6' 	class='textbox' readonly> <!-- �����ڵ� -->
													 &nbsp;&nbsp;<input type='text' id='bannam' 			name='bannam' 			value='' maxlength='30' size='10' 	class='textbox'> <!-- ����� -->
													 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ڵ带 �˻��մϴ�"  style="cursor:pointer" id="zipcode_btn" onclick="fnCommonCodePopup('AC002','�����ڵ�');" align='absmiddle'>
												</td>
												<td  width='120px' height='30px' class='boardt02'>���¹�ȣ</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='bank_acc_no' 		name='bank_acc_no' 		value='' maxlength='20' size='20' 	class='textbox'> <!-- ������¹�ȣ -->
												</td>
											</tr>
											<tr>
												<td  width='120px' height='30px' class='boardt02'>������</td>
												<td  bgcolor='#FFFFFF'>
													&nbsp;&nbsp;<input type='text' id='bank_acct_nm' 	name='bank_acct_nm' 	value='' maxlength='32' size='20' 	class='textbox'> <!-- ������ -->
												</td>
												<td  width='100px' height='30px' class='boardt02'>�������</td>
												<td  bgcolor='#FFFFFF'>&nbsp;
													<!-- <input type='hidden' id='use_yn' 			name='use_yn' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- ��뿩�� -->
													<!-- &nbsp;&nbsp;<input type='text' id='use_yn_name' 		name='use_yn_name' 		value='' maxlength='50' size='10' 	class='textbox'> <!-- ��뿩�θ� -->
													<%=HDConstant.COMMENT_START%>
						                            <object id=use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
														<param name=ComboDataID		value=codeDs5>
														<param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
														<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
														<param name=ListExprFormat  value="detail_nm^0^100">
													</object>
													<%=HDConstant.COMMENT_END%>	
													
												</td>
											</tr>
																																																																																																																			
										</table>
									</td>
								</tr>
								<tr>
									<td height='10px'></td>
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
                    <C>Col=client_sid      	Ctrl=client_sid         Param=value </C>
                    <C>Col=vend_cd         	Ctrl=vend_cd            Param=value </C>
                    <C>Col=vend_nm         	Ctrl=vend_nm            Param=value </C>
                    <C>Col=client_cd       	Ctrl=client_cd          Param=Text </C>
                    <C>Col=client_nm        Ctrl=client_nm          Param=value </C>
                    <C>Col=client_gu        Ctrl=client_gu          Param=value </C>
                    <C>Col=agen_gu          Ctrl=agen_gu            Param=BindColVal </C>
                    <C>Col=agen_gu_name     Ctrl=agen_gu_name       Param=value </C>
                    <C>Col=dir_yn           Ctrl=dir_yn             Param=BindColVal </C>
                    <C>Col=dir_yn_name      Ctrl=dir_yn_name        Param=value </C>
                    <C>Col=area_cd          Ctrl=area_cd            Param=BindColVal </C>
                    <C>Col=area_cd_name     Ctrl=area_cd_name       Param=value </C>
                    <C>Col=sal_dam_sid      Ctrl=sal_dam_sid        Param=value </C>
                    <C>Col=sal_dam_nm       Ctrl=sal_dam_nm         Param=value </C>
                    <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
                    <C>Col=tel_no           Ctrl=tel_no             Param=value </C>
                    <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
                    <C>Col=fax_no           Ctrl=fax_no             Param=value </C>
                    <C>Col=e_mail           Ctrl=e_mail             Param=value </C>
                    <C>Col=zip_cd           Ctrl=zip_cd             Param=Text </C>
                    <C>Col=address1         Ctrl=address1           Param=value </C>
                    <C>Col=address2         Ctrl=address2           Param=value </C>
                    <C>Col=commi_rate       Ctrl=commi_rate         Param=Text </C>
                    <C>Col=cunt_status      Ctrl=cunt_status        Param=BindColVal </C>
                    <C>Col=cunt_status_name	Ctrl=cunt_status_name   Param=value </C>
                    <C>Col=bancod           Ctrl=bancod             Param=value </C>
                    <C>Col=bannam           Ctrl=bannam             Param=value </C>
                    <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
                    <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
                    <C>Col=use_yn           Ctrl=use_yn             Param=BindColVal </C>
                    <C>Col=use_yn_name      Ctrl=use_yn_name        Param=value </C>
                    <C>Col=vend_type		Ctrl=vend_type          Param=BindColVal </C>
					<C>Col=vend_id			Ctrl=vend_id			Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

