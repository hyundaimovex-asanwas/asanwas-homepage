<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �븮�����
 * ���α׷�ID 	: CU040I
 * J  S  P		: cu040i
 * �� �� ��		: Cu040I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-13
 * �������		 : �븮�� �ű� �Է� / ����
  * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
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
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");
			cfStyleGrid(getObjectFirst("gr4"), "comn");
			
			fnInit(); 

			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
			codeDs3.deleteRow(1);
			codeDs4.deleteRow(1);
			codeDs5.deleteRow(1);
			codeDs7.deleteRow(1);
			
			agen_gu.index = 0;
			dir_yn.index = 0;
			area_cd.index = 0;
			cunt_status.index = 0;
			use_yn.index = 0;
			
			fnSetHeaderDs1();
			fnSetHeaderDs2();
			fnSetHeaderDs3();
			fnSetHeaderDs4();
		} 
			
		/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
/*				+"client_sid:INT,vend_cd:STRING,vend_nm:STRING,client_cd:STRING,client_nm:STRING,"  	
				+"client_gu:STRING,agen_gu:STRING,agen_gu_name:STRING,dir_yn:STRING,dir_yn_name:STRING,"    
				+"area_cd:STRING,area_cd_name:STRING,sal_dam_sid:STRING,sal_dam_nm:STRING,client_dam_nm:STRING,  "
				+"tel_no:STRING,mobile_no:STRING,fax_no:STRING,e_mail:STRING,zip_cd:STRING,"     	
				+"address1:STRING,address2:STRING,commi_rate:INT,cunt_status:STRING,cunt_status_name:STRING,"
				+"bancod:STRING,bannam:STRING,bank_acc_no:STRING,bank_acct_nm:STRING,use_yn:STRING,use_yn_name:STRING";
*/
				+ "CLIENT_SID:INT,VEND_CD:STRING,CLIENT_CD:STRING,CLIENT_NM:STRING,CLIENT_GU:STRING,AGEN_GU:STRING,DIR_YN:STRING,AREA_CD:STRING,SAL_DAM_SID:INT,CLIENT_DAM_NM:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,E_MAIL:STRING,ZIP_CD:STRING,ADDRESS1:STRING,ADDRESS2:STRING,COMMI_RATE:DOUBLE,CUNT_STATUS:STRING,BANCOD:STRING,BANK_ACC_NO:STRING,BANK_ACCT_NM:STRING,USE_YN:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp = ""
				//+"client_sid:INT,cont_date:STRING,expire_date:STRING,insur_amt:STRING,insur_comp_cd:STRING,insur_comp_cd_name:STRING";
				 + "CLIENT_SID:INT,CONT_DATE:STRING,EXPIRE_DATE:STRING,INSUR_AMT:INT,INSUR_COMP_CD:STRING,INSUR_COMP_CD_NAME:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				
				ds2.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs3(){
			if (ds3.countrow<1){
				var s_temp = ""
				//+"client_sid:INT,branch_cd:STRING,branch_nm:STRING,area_cd:STRING,"
				//+"client_down_yn:STRING,empno:STRING,tel_no:STRING,mobile_no:STRING,fax_no:STRING,"
				//+"branch_url:STRING,area_nm:STRING,client_down_yn_name:STRING";
				+ "CLIENT_SID:INT,BRANCH_CD:STRING,BRANCH_NM:STRING,AREA_CD:STRING,AREA_NM:STRING,CLIENT_DOWN_YN:STRING,CLIENT_DOWN_YN_NAME:STRING,EMPNO:STRING,TEL_NO:STRING,MOBILE_NO:STRING,FAX_NO:STRING,BRANCH_URL:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";
				ds3.SetDataHeader(s_temp);
			}
		}		
		
		function fnSetHeaderDs4(){
			if (ds4.countrow<1){
				var s_temp = ""
				
					+ "CLIENT_SID:INT,"
					+ "FR_DATE:STRING,"
					+ "TO_DATE:STRING,"
					+ "COMMI_RATE:DOUBLE"
				ds4.SetDataHeader(s_temp);
			}
		}	
							
		 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
            	"JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",            	
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			if (ds1.IsUpdated==false || !ds2.IsUpdated==false || !ds3.IsUpdated==false || !ds4.IsUpdated==false) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sClient_nm="+ sClient_nm.value
				          + ",sSal_dam_sid=" + sSal_dam_sid.value
				          + ",sUse_yn=" + sUse_yn.ValueOfIndex("detail", sUse_yn.Index);
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾����� ���¿����� ��ȸ�Ҽ� �����ϴ�!");
			}
		}
			
		
		/*
		 * �������, ������ȸ
		 */	
		function fnSelectDs1() {
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sClient_sid=" + ds1.namevalue(ds1.rowposition,"client_sid");
			         
			
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
			    "JSP(O:DS3=ds3,O:DS2=ds2,O:DS4=ds4)",
			    param);
			tr_post(tr2);
		}
			
			
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
		
			if (!ds1.isUpdated) {
				jobFlag = "N";
				ds1.addRow();
				rowNum.value = ds1.rowposition;
				
				ds1.namevalue(ds1.rowposition,"client_gu") = "1";
				ds2.ClearAll();
				ds3.ClearAll();
				ds4.ClearAll();
				
				fnSetHeaderDs2();
				fnSetHeaderDs3();
				fnSetHeaderDs4();
			} else {
				alert("�ű��۾� ���Դϴ� �����Ŀ� ����ϼ���!");
				return;
			}
				
		}
			
		function fnAddRow() {
			if (tabFlag.value == "1") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined ) {
					alert("�븮�� �ڵ尡 ���� ���¿����� �߰��Ҽ� �����ϴ�!");
					return;
				} else {
					fnAddRowDs2();
				}
			} else if (tabFlag.value == "2") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined) {
					alert("�븮�� �ڵ尡 ���� ���¿����� �߰��Ҽ� �����ϴ�!");
					return;
				} else {
					fnAddRowDs3();
				}
			} else if (tabFlag.value == "3") {
				if (ds1.namevalue(ds1.rowposition, "client_cd") == "" || ds1.namevalue(ds1.rowposition,"client_cd") == undefined) {
					alert("�븮�� �ڵ尡 ���� ���¿����� �߰��Ҽ� �����ϴ�!");
					return;
				} else {
					fnAddRowDs4();
				}
			}
		}
		function fnAddRowDs2() {
			//if (jobFlag == "N") {
			//	ds2.addRow();
			//	gr2.setcolumn("cont_date");				
			//} else {
				ds2.addRow();
				ds2.namevalue(ds2.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr2.setcolumn("cont_date");
			//}
		}
		
		function fnAddRowDs3() {
			//if (jobFlag == "N") {
			//	ds3.addRow();
			//	gr3.setcolumn("branch_cd");
			//} else {
				ds3.addRow() ;
				
				ds3.namevalue(ds3.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr3.setcolumn("branch_cd");
			//}
		}
		
		function fnAddRowDs4() {
			//if (jobFlag == "N") {
			//	ds3.addRow();
			//	gr3.setcolumn("branch_cd");
			//} else {
				ds4.addRow() ;
				
				ds4.namevalue(ds4.rowposition, "client_sid") = ds1.namevalue(ds1.rowposition, "client_sid");
				gr4.setcolumn("fr_date");
			//}
		}
		
		
		
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
			ds2.deleteAll();
			ds3.deleteAll();
			ds4.deleteAll();
		}
		/*
		 * �����, ����
		 */
		function fnDeleteRow() {
		jobFlag = "D";
			if (tabFlag.value == "1") {
				fnDeleteRowDs2();
			} else if (tabFlag.value == "2") {
				fnDeleteRowDs3();
			} else if (tabFlag.value == "3") {
				fnDeleteRowDs4();
			} else {
				fnDeleteRowDs2();
			}
		}
			
		function fnDeleteRowDs2() {
			ds2.deleterow(ds2.rowposition);
		}
		
		function fnDeleteRowDs3() {
			ds3.deleterow(ds3.rowposition);
		}	
		
		function fnDeleteRowDs4() {
			ds4.deleterow(ds4.rowposition);
		}	

		 
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
		 if (ds1.IsUpdated) {
				if (jobFlag != "D") {
			  	if(ds1.NameValue(ds1.rowposition, "client_cd")=="") {
                 	alert("�븮�� �ڵ带 �Է��ϼ���!");
                 	getObjectFirst("client_cd").focus();
                 	return;
                 }
                 
			 	if(ds1.NameValue(ds1.rowposition, "client_nm")==""){
                    alert("�븮������ �Է��ϼ���!");
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
		  		if(ds1.NameValue(ds1.rowposition, "ange_gu")=="") {
                 	alert("�븮�������� �����ϼ���!");
                 	getObjectFirst("ange_gu").focus();
                 	return;
                 }
		  		if(ds1.NameValue(ds1.rowposition, "dir_yn")=="") {
                 	alert("���ǿ��θ� �����ϼ���!");
                 	getObjectFirst("dir_yn").focus();
                 	return;
                 }
		  		if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
                 	alert("�븮������ڸ� �Է��ϼ���!");
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
                 
                if(ds1.NameValue(ds1.rowposition, "commi_rate") =="") {
                	alert("���������� �Է��ϼ���!");
                	getObjectFirst("commi_rate").focus();
                 	return;
                }
		  		if(ds1.NameValue(ds1.rowposition, "cunt_status")=="") {
                 	alert("�����¸� �����ϼ���!");
                 	getObjectFirst("cunt_status").focus();
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
		
		if (ds2.IsUpdated) {	 
			 for(var i=1; i<=ds2.CountRow; i++){
			 	if(ds2.NameValue(i, "cont_date")=="") {
                 	alert("������ڸ� �Է��ϼ���!");
                 	gr2.setcolumn("cont_date");
                 	return;
                 }
			 	if(ds2.NameValue(i, "expire_date")=="") {
                 	alert("�������ڸ� �Է��ϼ���!");
                 	gr2.setcolumn("expire_date");
                 	return;
                 }
			 	if(ds2.NameValue(i, "insur_amt")=="") {
                 	alert("����Ḧ �Է��ϼ���!");
                 	gr2.setcolumn("insur_amt");
                 	return;
                 }
			 	if(ds2.NameValue(i, "insur_comp_cd")=="") {
                 	alert("����ȸ�縦 �Է��ϼ���!");
                 	gr2.setcolumn("insur_comp_cd_name");
                 	return;
                 }
			 }
		}
		
		if (ds3.IsUpdated) {
			 for(var i=1; i<=ds3.CountRow; i++){
			 	if(ds3.NameValue(i, "branch_cd")=="") {
                 	alert("�����ڵ带 �Է��ϼ���!");
                 	gr3.setcolumn("branch_cd");
                 	return;
                }
			 	if(ds3.NameValue(i, "branch_nm")=="") {
                 	alert("�������� �Է��ϼ���!");
                 	gr3.setcolumn("branch_nm");
                 	return;
                }                
			 	if(ds3.NameValue(i, "area_cd")=="") {
                 	alert("������ �����ϼ���!");
                 	gr3.setcolumn("area_nm");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "client_down_yn")=="") {
                 	alert("�������� �����ϼ���!");
               	 	gr3.setcolumn("client_down_yn_name");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "empno")=="") {
                 	alert("����ڸ� �Է��ϼ���!");
                 	gr3.setcolumn("empno");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "tel_no")=="") {
                 	alert("��ȭ��ȣ�� �Է��ϼ���!");
                 	gr3.setcolumn("tel_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "mobile_no")=="") {
                 	alert("�޴�����ȣ�� �����ϼ���!");
                 	gr3.setcolumn("mobile_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "fax_no")=="") {
                 	alert("�ѽ���ȣ�� �Է��ϼ���!");
                 	gr3.setcolumn("fax_no");
                 	return;
                }                  
			 	if(ds3.NameValue(i, "branch_url")=="") {
                 	alert("����Ȩ�������� �Է��ϼ���!");
                 	gr3.setcolumn("branch_url");
                 	return;
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
			
			if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated) {
				if(fnCheck()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
	                "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3,I:DS4=ds4)",
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
			ds2.undoall();
			ds3.undoall();
			ds4.undoall();
			
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
		 * �븮�� �˾�
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
				
				if (head == 'CU010') {				// ��������ȸ�� 
		   			ds2.namevalue(ds2.rowposition, "insur_comp_cd") = arrParam[1];
		   			ds2.namevalue(ds2.rowposition, "insur_comp_cd_name")  = arrParam[2];
				} else if (head == 'SY006') {		// ����
		   			ds3.namevalue(ds3.rowposition, "area_cd") = arrParam[1];
		   			ds3.namevalue(ds3.rowposition, "area_nm") = arrParam[2];
				} else if (head == 'AC002') {		// ���� 
					bancod.value = arrParam[1];
					bannam.value = arrParam[2];
				} else if (head = 'CU001') {
					ds3.namevalue(ds3.rowposition,"client_down_yn") = arrParam[1];
					ds3.namevalue(ds3.rowposition,"client_down_yn_name") = arrParam[2];
					
					
				}		
				
	
			} else {
				if (head == 'CU010') {			// ��������ȸ�� 
				  ds2.namevalue(ds2.rowposition, "insur_comp_cd") = "";
				  ds2.namevalue(ds2.rowposition, "insur_comp_cd_name") = "";
				} else if (head == 'SY006') {		// ���� 
				  ds3.namevalue(ds3.rowposition, "area_cd") = ""
				  ds3.namevalue(ds3.rowposition, "area_nm") = "";
				} else if (head == 'AC002') {	// ���� 
					bancod.value = "";
					bannam.value = "";
				} else if (head = 'CU001') {
					ds3.namevalue(ds3.rowposition,"client_down_yn") = "";
					ds3.namevalue(ds3.rowposition,"client_down_yn_name") = "";
					
				}
			}
			return ;	
		}		
		
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>

	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
	if (ds1.IsUpdated || ds2.IsUpdated || ds3.IsUpdated || ds4.IsUpdated) {
			if (confirm("���� ���� �۾����� �����Ͱ� �ֽ��ϴ�. �����Ͻðڽ��ϱ�?")) {
				if (Row >0 ) {
					
					rowNum.value = ds1.rowposition;
					fnCancel();
				//	fnSelectDs1();
				}
				
				
			} else {
				ds1.rowposition = rowNum.value;
				
			}
		} else {
			if (Row >0 ) {
				rowNum.value = Row;
				fnSelectDs1();
			}
		}
	</script>
	
 
 	<script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>
		if (rowcnt >0 ) {
			rowNum.value = rowcnt;
			fnSelectDs1();
		}
	</script>
 
 	
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	<script language="javascript" for="tr2" event="OnFail()">
		//20070921 �߰� 
	    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	
	    var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>	
	
	
	
	<script language=JavaScript for=mxTab event=OnSelChanged(index)>
		if (index == 1) {
			tabFlag.value = "1";
		} else if (index == 2) {
			tabFlag.value = "2";
		} else if (index == 3) {
			tabFlag.value = "3";
		}
	</script>
	
	<script language=JavaScript for=gr2 event=OnPopup(row,colid,data)>
		if(colid=="insur_comp_cd_name") {
			fnCommonCodePopup('CU010', '��������ȸ���ڵ�');
		}
	</script>
	<script language=JavaScript for=gr3 event=OnPopup(row,colid,data)>
		if(colid=="client_down_yn_name") {
			fnCommonCodePopup('CU011', '�����븮������');
		}
		if(colid=="area_nm") {
			fnCommonCodePopup('SY006', '�����ڵ�');
		}
	</script>	
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮�� ��ȸ -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���������� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮������ -->
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
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����븮�� ���� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
	<param name="SyncLoad" 	value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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

<table border='0' cellpadding='0' cellspacing='0' width='845'>	
	<tr>
		<td width='525px'>
			<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr>
					<td width='70px' height="30px" class='text'>�븮��</td>
					<td width='100px' bgcolor='#FFFFFF' align='center'>
						<input type='hidden'  	name='sClient_cd' 		value='' maxlength='10' 	size='10' 	class='textbox'>
						<input type='text' 		name='sClient_nm' 		value='' maxlength='30' 	size='10' 	class='textbox'>
					</td>
					<td width='70px' class='text'>�����</td>
					<td width='120px' bgcolor='#FFFFFF' align='center'>
						<input type='hidden'  		name='sSal_dam_sid' 		value='' maxlength='10' 	size='5' 	class='textbox'  >
						<input type='text'  		name='sSal_dam_nm' 			value='' maxlength='10' 	size='10' 	class='textbox' readonly onClick="javascript:fnSalDamPopup('S');">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="��������ڸ� �˻��մϴ�"  style="cursor:hand" id="zipcode_btn" onclick="javascript:fnSalDamPopup('S');" align='absmiddle'>
					<td width='80px' class='text' >�������</td>
					<td width='100px' bgcolor='#FFFFFF' align='center'>
						<%=HDConstant.COMMENT_START%>
                           <object id=sUse_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=80 border="0" align=absmiddle>
							<param name=ComboDataID		value=sCodeDs1>
							<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^100">
						</object>
						<%=HDConstant.COMMENT_END%>	
					</td>
				</tr>
			</table>
		</td>
		<td align='right'>
			<table border='0' cellpadding='0' cellspacing='0' width='300px'>
				<tr>
					<td height='25px' align='right'>
						<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
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
						<table  border='0' cellpadding='0' cellspacing='0' width='200px' height='440px' >
							<tr>
								<td>
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='200px' height='440px' border='1'>
										<param name="DataID"			value="ds1">
										<param name="ColSizing"			value="true">
										<param name="Fillarea"			value="false">
										<param name="Editable"  		value="false">
										<param name="BorderStyle"       value="0">
										<param name=SortView  			value="Left">

										
										<param name="Format" 			value="

							                <C> name='�븮��SID'   	ID='client_sid' 		Width=100  align=left editlimit=12 	show=false</C>
							                <C> name='�ŷ�ó�ڵ�'    	ID='vend_cd'    		Width=100  align=left editlimit=13 	show=false</C>
							                <C> name='�ŷ�ó��'      	ID='vend_nm'    		Width=100  align=left editlimit=62 	show=false</C>
							                <C> name='�ڵ�'    	ID='client_cd'  		Width=50  align=left editlimit=5 	show=true sort=true</C>
							                <C> name='�븮����'    	ID='client_nm'  		Width=183  align=left editlimit=30 	show=true sort=true</C> <!-- �븮���� : �븮���� -->
							                
							                <C> name='�븮������'    	ID='client_gu'  		Width=100  align=left editlimit=1 	show=false</C> <!-- �븮�� ���� 1 = �븮�� -->
							                <C> name='�븮������'    	ID='agen_gu'    		Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='�븮�����и�' 	ID='agen_gu_name'   	Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='���ǿ���'      	ID='dir_yn'     		Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='���ǿ��θ�'  	ID='dir_yn_name'    	Width=100  align=left editlimit=50 	show=false</C>

							                <C> name='�����ڵ�'      	ID='area_cd'    		Width=100  align=left editlimit=2 	show=false</C>
							                <C> name='�����ڵ��' 	ID='area_cd_name'   	Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='���������SID' 	ID='sal_dam_sid'    	Width=100  align=left editlimit=12 	show=false</C>
							                <C> name='��������ڸ�'   ID='sal_dam_nm' 		Width=100  align=left editlimit=22 	show=false</C>
							                <C> name='�븮�������'  	ID='client_dam_nm'  	Width=100  align=left editlimit=20 	show=false</C>

							                <C> name='��ȭ��ȭ '     	ID='tel_no'    			Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='�޴���ȭ'    	ID='mobile_no'  		Width=100  align=left editlimit=15 	show=false</C>
							                <C> name='�ѽ���ȣ'      	ID='fax_no'     		Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='�̸���'       	ID='e_mail'     		Width=100  align=left editlimit=30 	show=false</C>
							                <C> name='�����ȣ'      	ID='zip_cd'     		Width=100  align=left editlimit=6 	show=false</C>

							                <C> name='�ּ�1'     	ID='address1'   		Width=100  align=left editlimit=60 	show=false</C>
							                <C> name='�ּ�2'     	ID='address2'   		Width=100  align=left editlimit=60 	show=false</C>
							                <C> name='��������'   	ID='commi_rate' 		Width=100  align=left editlimit=7 	show=false</C>
							                <C> name='������'  		ID='cunt_status'        Width=100  align=left editlimit=1 	show=false</C>
							                <C> name='�����¸�' 	ID='cunt_status_name'   Width=100  align=left editlimit=50 	show=false</C>

							                <C> name='�����ڵ�'      	ID='bancod'     		Width=100  align=left editlimit=6 	show=false</C>
							                <C> name='�����'       	ID='bannam'     		Width=100  align=left editlimit=30 	show=false</C>
							                <C> name='������¹�ȣ'  	ID='bank_acc_no'        Width=100  align=left editlimit=20 	show=false</C>
							                <C> name='������' 		ID='bank_acct_nm'       Width=100  align=left editlimit=32 	show=false</C>
							                <C> name='��뿩��'      	ID='use_yn'     		Width=100  align=left editlimit=1 	show=false</C>

							                <C> name='��뿩�θ�'  	ID='use_yn_name'        Width=100  align=left editlimit=50 	show=false</C>
							                <C> name='Ȩ������'  	ID='client_url'        Width=100  align=left editlimit=50 	show=true</C>
							        	">											
									</object>	
									<%=HDConstant.COMMENT_END%>								
								</td>
							</tr>
						</table>
					</td>
					<td width='10px'></td>
					<td valign='top'>
						<table border='0' cellpadding='0' cellspacing='0' width='630px'>
							<tr>
								<td width='530px'height='244px'>
									<table border='0' cellpadding='0' cellspacing='1' width='630px' height='244px' bgcolor="#666666">
										<tr>
											<td width='100px' class='boardt02'>�븮���ڵ�</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												<!-- <input type='text' id='client_cd' 		name='client_cd' 		value='' maxlength='5' 	size='5' 	class='textbox' > <!-- �븮�� �ڵ� -->
												
												<%=HDConstant.COMMENT_START%>
												<object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
													<param name=Alignment 	value=1>
													<param name=Format 		value="00000">
													<param name=Enable      value="true">
                                                       <param name=Border   	value=false>
												</object>
												<%=HDConstant.COMMENT_END%>
			
											</td>
											<td  width='100px' class='boardt02'>�븮����</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;
												<input type='text' id='client_nm' 		name='client_nm' 		value='' maxlength='30' size='20' 	class='textbox' > <!-- �븮�� �� -->
												
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>�ŷ�ó��</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												<input type='hidden' id='vend_cd' 			name='vend_cd' 			value='' maxlength='13' size='10' 	class='textbox'> <!-- �ŷ�ó�ڵ� -->
												&nbsp;&nbsp;<input type='text' id='vend_nm' 			name='vend_nm' 			value='' maxlength='62' size='15' 	class='textbox' readonly> <!-- �ŷ�ó�� -->
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�ŷ�ó�� �˻��մϴ�"  style="cursor:hand" id="vend_btn" onclick="javascript:fnVendPopup();" align='absmiddle'>
											</td>
											<td  width='100px' class='boardt02'>���������</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												<input type='hidden' id='sal_dam_sid' 		name='sal_dam_sid' 		value='' maxlength='12' size='12' 	class='textbox' readonly> <!-- ����������ڵ� -->
      												&nbsp;&nbsp;<input type='text' id='sal_dam_nm' 		name='sal_dam_nm' 		value='' maxlength='22' size='10' 	class='textbox' readonly> <!-- ��������ڸ� -->
      												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="��������ڸ� �˻��մϴ�"  style="cursor:hand" id="sal_dam_btn" onclick="javascript:fnSalDamPopup('I');" align='absmiddle'>
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>�븮�� ����</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												 <!-- <input type='hidden' id='agen_gu' 			name='agen_gu' 			value='' maxlength='1' 	size='1' 	class='textbox'> <!-- �븮�� ���� -->
     												 <!-- &nbsp;&nbsp;<input type='text' id='agen_gu_name' 	name='agen_gu_name' 	value='' maxlength='50' size='10' 	class='textbox'> <!-- �븮�� ���и�-->
     												<%=HDConstant.COMMENT_START%>
					                            <object id=agen_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=codeDs1>
													<param name=BindColumn      value="detail">
                                                       <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100">
												</object>
												<%=HDConstant.COMMENT_END%>	
     												 
											</td>
											<td  width='100px' class='boardt02'>���ǿ���</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
											<td  width='130px' class='boardt02'>�븮�������</td>
											<td  bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='client_dam_nm' 	name='client_dam_nm' 	value='' maxlength='20' size='20' 	class='textbox'> <!-- �븮������� -->
											</td>
											<td  width='100px' class='boardt02'>Ȩ������</td>
											<td bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='client_url' 	name='client_url' 	value='' maxlength='50' size='30' 	class='textbox'> <!-- Ȩ������ -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>��ȭ��ȣ</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='tel_no' 			name='tel_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- ��ȭ��ȣ -->
												
											</td>
											<td  width='100px' class='boardt02'>�޴���ȭ</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='mobile_no' 		name='mobile_no' 		value='' maxlength='15' size='20' 	class='textbox'> <!-- �޴���ȭ -->
											</td>
										</tr>

										<tr>
											<td  width='100px' class='boardt02'>�ѽ���ȣ</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='fax_no' 			name='fax_no' 			value='' maxlength='20' size='20' 	class='textbox'> <!-- FAX��ȣ -->
											</td>
											<td  width='100px' class='boardt02'>�����ּ�</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												 &nbsp;&nbsp;<input type='text' id='e_mail' 			name='e_mail' 			value='' maxlength='30' size='23' 	class='textbox'> <!-- �̸��� -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>�����ȣ</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ȣ�� �˻��մϴ�"  style="cursor:hand" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>													
											</td>
											<td  width='100px' class='boardt02'>�����ڵ�</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
											<td  width='100px' class='boardt02'>�ּ�1</td>
											<td  width='495px' bgcolor='#FFFFFF' colspan='3'>
												&nbsp;&nbsp;<input type='text' id='address1' 		name='address1' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- �ּ�1 -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>�ּ�2</td>
											<td  width='495px' bgcolor='#FFFFFF'colspan='3'>
												&nbsp;&nbsp;<input type='text' id='address2' 		name='address2' 		value='' maxlength='60' size='50' 	class='textbox'> <!-- �ּ�2 -->
											</td>
										</tr>

										<tr>
											<td  width='100px' class='boardt02'>��������</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;<!-- <input type='text' id='commi_rate' 		name='commi_rate' 		value='' maxlength='7' 	size='7' 	class='textbox'> <!-- �������� -->
																									
												<%=HDConstant.COMMENT_START%>
												<object id=commi_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
													<param name=Alignment 	value=1>
													<param name=Enable      value="true">
                                                       <param name=Border   	value=false>
                                                       <param name=MaxDecimalPlace   value=2>
                                                       
												</object>
												<%=HDConstant.COMMENT_END%>

											</td>
											<td  width='100px' class='boardt02'>������</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
												<!-- <input type='hidden' id='cunt_status' 		name='cunt_status' 		value='' maxlength='1' 	size='1' 	class='textbox'> <!-- ������ -->
												<!-- &nbsp;&nbsp;<input type='text' id='cunt_status_name' name='cunt_status_name' value='' maxlength='50' size='10' 	class='textbox'> <!-- �����¸� -->
     												<%=HDConstant.COMMENT_START%>
					                            <object id=cunt_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=codeDs4>
													<param name=BindColumn      value="detail">
                                                       <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^100">													</object>
												<%=HDConstant.COMMENT_END%>														
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>�����ڵ�</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												 <input type='hidden' id='bancod' 			name='bancod' 			value='' maxlength='6' 	size='15' 	class='textbox' readonly> <!-- �����ڵ� -->
												 &nbsp;&nbsp;<input type='text' id='bannam' 	readonly="readonly"		name='bannam' 			value='' maxlength='30' size='15' 	class='textbox'> <!-- ����� -->
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ڵ带 �˻��մϴ�"  style="cursor:hand" id="zipcode_btn" onclick="fnCommonCodePopup('AC002','�����ڵ�');" align='absmiddle'>
											</td>
											<td  width='100px' height='22px' class='boardt02'>���¹�ȣ</td>
											<td  width='165px' height='22px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='bank_acc_no' 		name='bank_acc_no' 		value='' maxlength='20' size='20' 	class='textbox'> <!-- ������¹�ȣ -->
											</td>
										</tr>
										<tr>
											<td  width='100px' class='boardt02'>������</td>
											<td  width='165px' bgcolor='#FFFFFF'>
												&nbsp;&nbsp;<input type='text' id='bank_acct_nm' 	name='bank_acct_nm' 	value='' maxlength='32' size='20' 	class='textbox'> <!-- ������ -->
											</td>
											<td  width='100px' class='boardt02'>�������</td>
											<td  width='165px' bgcolor='#FFFFFF'>&nbsp;
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
							<tr>
								<td>
									<table  border='0' cellpadding='0' cellspacing='0' width='630px'>
										<tr>
											<td align='left'>
												<%=HDConstant.COMMENT_START%>
												<object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='200px' height='20px'> 
													<param name="BackColor"			value="#00FFFF">
													<param name="DisableBackColor"	value="#fffff0">
													<param name="Format"			value='
														<T>divid="tab1"	title="�������"</T>
														<T>divid="tab2"	title="��������"</T>
														<T>divid="tab3" title="��������"</T>
														'>
												</object>
												<%=HDConstant.COMMENT_END%>
											</td>
											<td width='330px' align='right' valign='top'>
												<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	onClick="fnAddRow()" >
												<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" onClick="fnDeleteRow()" >

											</td>
										<tr>
										<tr>
											<td colspan='2'>
												<div id=tab1 style="position:absolute; left:382; top:476; width:630; height:120">     
													<%=HDConstant.COMMENT_START%>                                                                                                        
													<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>                                       
														<param name="DataID"			value="ds2">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														<param name="BorderStyle"       value="0">                                                                                                                       
														<param name="Format" 			value="                                                                                                                                 
														   <C> name='�븮��SID'   		ID='client_sid'  		align=left editlimit=12 width=100 show=false</C>
														   <C> name='�������'    		ID='cont_date'   		align=left editlimit=8 	width=100 show=true mask='XXXX-XX-XX'</C>
														   <C> name='��������'  			ID='expire_date'    	align=left editlimit=8 	width=100 show=true  mask='XXXX-XX-XX'</C>
														   <C> name='�����'    			ID='insur_amt'   		align=right editlimit=10 width=100 show=true</C>
														   <C> name='��������ȸ��'   	ID='insur_comp_cd'  	align=left editlimit=2 	width=227 show=true editstyle=lookup data='codeDs6:detail:detail_nm'</C>
														   <C> name='��������ȸ���'  	ID='insur_comp_cd_name' align=left editlimit=50 width=227 show=false editstyle=popup</C>
														">                                                                                                                                                                              
													</object> 
													<%=HDConstant.COMMENT_END%>	                                                                                                                                                                              
												</div>   
												<div id=tab2 style="position:absolute; left:382; top:476; width:630; height:120">   
													<%=HDConstant.COMMENT_START%>                                                                                                                          
													<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>
														<param name="DataID"			value="ds3">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														 <param name="BorderStyle"       value="0">                                                                                                                                  
														<param name="Format" 			value="                                                                                                                                            
											               <C> name='�븮��SID'   			ID='client_sid'  			width=100 align=left editlimit=12 show=false</C>
											               <C> name='�����ڵ�'    			ID='branch_cd'   			width=60 align=left editlimit=3 	show=true</C>
											               <C> name='������'    				ID='branch_nm'   			width=100 align=left editlimit=20 show=true</C>
											               <C> name='������'      			ID='area_cd'     			width=60 align=left editlimit=2 	show=true editstyle=lookup data='codeDs3:detail:detail_nm'</C>
											               <C> name='������'					ID='area_nm'				width=60 align=left editlimit=10 show=false editstyle=popup</C>
											               <C> name='��������'       			ID='client_down_yn'      	width=80 align=left editlimit=1 	show=true editstyle=lookup data='codeDs7:detail:detail_nm'</C>
											               <C> name='�����븮�����θ�'  		ID='client_down_yn_name'    width=120 align=left editlimit=50 show=false editstyle=popup </C>
											               <C> name='�����'        			ID='empno'       			width=100 align=left editlimit=7 	show=true</C>
											               <C> name='��ȭ��ȣ'       			ID='tel_no'      			width=100 align=left editlimit=15 show=true</C>
											               <C> name='�޴���ȭ'    			ID='mobile_no'   			width=100 align=left editlimit=15 show=true</C>
											               <C> name='�ѽ���ȣ'       			ID='fax_no'      			width=100 align=left editlimit=20 show=true</C>
											               <C> name='����Ȩ������'   			ID='branch_url'  			width=100 align=left editlimit=40 show=true</C>
														">                                                                                                                                                                                         
													</object>     
													<%=HDConstant.COMMENT_END%>	      
												</div>
												<div id=tab3 style="position:absolute; left:382; top:476; width:630; height:120">     
													<%=HDConstant.COMMENT_START%>                                                                                                        
													<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=627; height=117" border='1'>
														<param name="DataID"			value="ds4">                                                                                                                            
														<param name="Fillarea"			value="true">                                                                                                                           
														<param name="Editable"  		value="true">                                                                                                                           
														<param name="BorderStyle"       value="0">                                                                                                                       
														<param name="Format" 			value="                                                                                                                                 
														     	<C> name='�븮��SID'   ID='client_sid'  width=100 align=left editlimit=12 show=true</C>
															   <C> name='��������'      ID='fr_date'     width=100 align=left editlimit=8 show=true mask='XXXX-XX-XX'</C>
															   <C> name='��������'      ID='to_date'     width=100 align=left editlimit=8 show=true mask='XXXX-XX-XX'</C>
															   <C> name='��������'   ID='commi_rate'  width=100 align=left editlimit=7 show=true</C>
														">                                                                                                                                                                              
													</object> 
													<%=HDConstant.COMMENT_END%>	                                                                                                                                                                              
												</div>                                                                                                                                                                                 
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
                     <C>Col=client_url      Ctrl=client_url        Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

