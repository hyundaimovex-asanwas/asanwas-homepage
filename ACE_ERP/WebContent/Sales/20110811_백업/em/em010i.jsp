<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<% String dirPath = request.getContextPath(); 
	java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());		
%>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - ��������
+ ���α׷�ID : em010i.jsp
+ ������� : �λ� �⺻������ ȭ�� �ϴ��� 11���� ���� �̿��Ͽ� �Է�,����,����,��ȸ�Ѵ�.
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.10.11
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em010_S1,Em010_S2
----------------------------------------------------------------------------------*/
%>

<!-- HTML ����-->
	<head>

    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
	var useid = gusrid;
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
    /*
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	var year_date = gcurdate.substring(2,4);
	*/
	
	var gs_date = '<%=firstday%>';
	var year_date = gs_date.substring(2,4);
	var chk_tab = "";

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			ln_before();//����ȸ
			window.status="�Ϸ�";
			ln_SetDataHeader();//gcds_data00 �ش�����
			txt_nm.focus();
		}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){
		if(gcds_data00.countrow<1){
			ln_Find_s();
		}else{
					if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1' || gcds_data00.SysStatus(gcds_data00.RowPosition)=='3'){
							alert("���� ������ �ּ���.");
							return;
					}else{	ln_Find_s();	}
		}
}

//�ٷ��� ����-----------------------------------------------------------------------
	function ln_Find_s(){

		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "../popup/em_popup.jsp";
		strPos = "dialogWidth:630px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			gcds_data00.addrow();
			arrParam = arrResult.split(";");
			gcem_empnmk.Text=arrParam[0];
			gcem_cust_sid.Text=arrParam[1];
			gcem_birthday.Text=arrParam[2];
			gcra_sex.codevalue=arrParam[3];
			gcem_pass_no.Text=arrParam[4];
			gcem_pass_epdate.Text=arrParam[5];
			gcem_n_card_no.Text=arrParam[6];
			gclx_nation_cd.bindcolval=arrParam[7];
			txt_tel_no.value=arrParam[8];
			txt_mobile_no.value=arrParam[9];
			txt_zipcd.value=arrParam[10];
			txt_address1.value=arrParam[11]&&arrParam[12];
			//txt_address2.value=arrParam[12];
			txt_usts.value=arrParam[13];
			gcem_eng_nm.Text=arrParam[14];
			gclx_ord_cd.bindcolval="001"; //�ű��Ի�
			gcem_con_year.text=1;
 
		}
}
/* �ּ� ��ȸ------------------------------------------------------------------------
	function ln_Popup(){
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "/common/html/com_zipcd.html";
		strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];
			eval("txt_addr1").value = val;
			eval("txt_addr2").focus();
		}
	}
/*
 /*-----------------------------------------------------------------------------
	Description : Dataset Head ���� - gcds_data00
-----------------------------------------------------------------------------*/
	function ln_SetDataHeader(){
			if(gcds_data00.countrow<1){
				var s_temp = "CUST_SID:DECIMAL(10),USESTS:STRING(1),EMPNMK:STRING(30),EMPNMC:STRING(20),LAST_NM:STRING(30),"
									 + "FIRST_NM:STRING(30),EMPNO:STRING(10),BIRTHDAY:STRING(8),SEX:STRING(1),NATION_CD:STRING(3),"
									 + "START_DT:STRING(8),JOB_CD:STRING(5),AGENCY_CD:STRING(3),VEND_CD:DECIMAL(10),DEPT_CD:STRING(5),"
									 + "TEAM_CD:STRING(5),WORK_CD:STRING(5),SKILL_CD:STRING(5),COUNTRY_CD:STRING(3),PASS_NO:STRING(20),"
									 + "PASS_EXPIRE_DATE:STRING(8),CON_YEAR:DECIMAL(2),I_DATE:STRING(10),U_DATE:STRING(10),I_EMPNO:STRING(10),"
									 + "U_EMPNO:STRING(10),N_CARD_NO:STRING(20),USTS:STRING(1),ZIP_ADD:STRING(86),ZIP_CD:STRING(6),"
									 + "ADDRESS1:STRING(80),ADDRESS2:STRING(60),TEL_NO:STRING(20),MOBILE_NO:STRING(20),HEIGHT:DECIMAL(4.1),"
									 + "WEIGHT:DECIMAL(4),SIZE_UP:STRING(3),SIZE_DN:STRING(3),SIZE_FT:DECIMAL(3),SIZE_WT:DECIMAL(3),"
									 + "BLOOD:STRING(1),ENG_NM:STRING(60),B_SKILL_CD:STRING(3),ORD_CD:STRING(3),"
									 + "END_DT:STRING(8),CHGYMD:STRING(8),C_VEND_CD:DECIMAL(10),CHI_NM:STRING(30),CHI_RNM:STRING(20),"
									 + "CHI_TEL:STRING(20),CHI_ADD:STRING(50),SCH_FR:STRING(6),SCH_TO:STRING(6),ATT_CD:STRING(2),ATT_NM:STRING(30),"
									 + "SCH_NM:STRING(30),HOBBY:STRING(30),SPC_NM:STRING(30),B_PAY:DECIMAL(10),MANAGE_NO:STRING(20),"
									 + "REM_BNK:STRING(3),SAV_NM:STRING(20),SAV_TEL:STRING(20),REM_ACC:STRING(30),PIC_DIR:STRING(120),"
									 + "WORK_NM:STRING(30),JOB_NM:STRING(30),AGENCY_NM:STRING(30),"
									 + "ORD_NM:STRING(30),COUNTRY_NM:STRING(30),NATION_NM:STRING(30),SEX_NM:STRING(30),REM_BNK_NM:STRING(30),SCH_FRTO:STRING(30),TEAM_NM:STRING(50)";
				gcds_data00.SetDataHeader(s_temp);
		}
	}

/*-----------------------------------------------------------------------------
	Description : PrintDataset Head ���� - gcds_data00
-----------------------------------------------------------------------------*/
function ln_SetPrintDataHeader(){
		if(gcds_report0.countrow<1){
			var s_temp = "CUST_SID:DECIMAL(10),USESTS:STRING(1),EMPNMK:STRING(30),EMPNMC:STRING(20),LAST_NM:STRING(30),"                
								 + "FIRST_NM:STRING(30),EMPNO:STRING(10),BIRTHDAY:STRING(8),SEX:STRING(1),NATION_CD:STRING(3),"                   
								 + "START_DT:STRING(8),JOB_CD:STRING(5),AGENCY_CD:STRING(3),VEND_CD:DECIMAL(10),DEPT_CD:STRING(5),"               
								 + "TEAM_CD:STRING(5),WORK_CD:STRING(5),SKILL_CD:STRING(5),COUNTRY_CD:STRING(3),PASS_NO:STRING(20),"              
								 + "PASS_EXPIRE_DATE:STRING(8),CON_YEAR:DECIMAL(2),I_DATE:STRING(10),U_DATE:STRING(10),I_EMPNO:STRING(10),"       
								 + "U_EMPNO:STRING(10),N_CARD_NO:STRING(20),USTS:STRING(1),ZIP_ADD:STRING(86),ZIP_CD:STRING(6),"                                     
								 + "ADDRESS1:STRING(80),ADDRESS2:STRING(60),TEL_NO:STRING(20),MOBILE_NO:STRING(20),HEIGHT:DECIMAL(4.1),"            
								 + "WEIGHT:DECIMAL(4),SIZE_UP:STRING(3),SIZE_DN:STRING(3),SIZE_FT:DECIMAL(3),SIZE_WT:DECIMAL(3),"                 
								 + "BLOOD:STRING(1),ENG_NM:STRING(60),B_SKILL_CD:STRING(3),ORD_CD:STRING(3),"                                     
								 + "END_DT:STRING(8),CHGYMD:STRING(8),C_VEND_CD:DECIMAL(10),CHI_NM:STRING(30),CHI_RNM:STRING(20),"                
								 + "CHI_TEL:STRING(20),CHI_ADD:STRING(50),SCH_FR:STRING(6),SCH_TO:STRING(6),ATT_CD:STRING(2),ATT_NM:STRING(30),"  
								 + "SCH_NM:STRING(30),HOBBY:STRING(30),SPC_NM:STRING(30),B_PAY:DECIMAL(10),MANAGE_NO:STRING(20),"                 
								 + "REM_BNK:STRING(3),SAV_NM:STRING(20),SAV_TEL:STRING(20),REM_ACC:STRING(30),PIC_DIR:STRING(120),"
								 + "WORK_NM:STRING(30),JOB_NM:STRING(30),AGENCY_NM:STRING(30),"
								 + "ORD_NM:STRING(30),COUNTRY_NM:STRING(30),NATION_NM:STRING(30),SEX_NM:STRING(30),REM_BNK_NM:STRING(30),SCH_FRTO:STRING(30),TEAM_NM:STRING(50),CUR_DT:STRING(8)";

			gcds_report0.SetDataHeader(s_temp);
	}
}

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	photo.src="../common/img/00000.gif";
	gcte_disp.ActiveIndex = 1;
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S1?"
											 + "v_str1=" + gclx_usts.bindcolval
											 + "&v_str2=" + gclx_cmsosok.bindcolval
											 + "&v_str3=" + txt_nm.value;
	gcds_data00.Reset();
	

  //prompt(this,gcds_data00.DataID);

}

/*----------------------------------------------------------------------------
	Description : �系��� ��ȸ
----------------------------------------------------------------------------*/
function ln_OrdQuery() {

	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S2?"
										 + "v_str1=" + txt_empno.value;
	gcds_data02.Reset();
}
/*----------------------------------------------------------------------------
	Description : ����������ȸ
----------------------------------------------------------------------------*/
function ln_FamQuery() {

	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S3?"
											 + "v_str1=" + txt_empno.value;
	gcds_data03.Reset();
}
/*----------------------------------------------------------------------------
	Description : �Ի������ ��ȸ
----------------------------------------------------------------------------*/
function ln_CarQuery() {

	gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S4?"
										 + "v_str1=" + txt_empno.value;
	gcds_data04.Reset();
}
/*----------------------------------------------------------------------------
	Description : �ڰݸ��� ��ȸ
----------------------------------------------------------------------------*/
function ln_LicQuery() {

	gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S5?"
											 + "v_str1=" + txt_empno.value;
	gcds_data05.Reset();
}
/*----------------------------------------------------------------------------
	Description : �ް� ��ȸ
----------------------------------------------------------------------------*/
function ln_VacQuery() {

	gcds_data06.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S6?"
											 + "v_str1=" + txt_empno.value;
	gcds_data06.Reset();
}
/*----------------------------------------------------------------------------
	Description : ��� ��ȸ
----------------------------------------------------------------------------*/
function ln_RewQuery() {

	gcds_data07.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S7?"
											 + "v_str1=" + txt_empno.value;
	gcds_data07.Reset();
}
/*----------------------------------------------------------------------------
	Description : ���� ��ȸ
----------------------------------------------------------------------------*/
function ln_MediQuery() {

	gcds_data08.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S8?"
											 + "v_str1=" + gcem_cust_sid.text;
	gcds_data08.Reset();
}
/*----------------------------------------------------------------------------
	Description : �ٹ������� ��ȸ
----------------------------------------------------------------------------*/
function ln_ClothQuery() {

	gcds_data09.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S9?"
											 + "v_str1=" + txt_empno.value;
	gcds_data09.Reset();
}
/*----------------------------------------------------------------------------
	Description : ���� ��ȸ
----------------------------------------------------------------------------*/
function ln_ReqQuery() {

	gcds_data10.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S10?"
											 + "v_str1=" + txt_empno.value;
	gcds_data10.Reset();
}
/*----------------------------------------------------------------------------
	Description : ��� ��ȸ
----------------------------------------------------------------------------*/
function ln_DeuQuery() {

	gcds_data11.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S11?"
											 + "v_str1=" + txt_empno.value;
	gcds_data11.Reset();
}
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//�ٹ���ü  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();
//prompt('',gcds_cm019.countrow);

	//�ٹ���  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();

	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();

	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();

	//��ɱ���  CM013
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM013";
	gcds_cm013.Reset();

	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();

	//�Ҽ���  CM003
	gcds_cmsosok.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cmsosok?v_str1=CM003";
	gcds_cmsosok.Reset();

	//����  SY005
	gcds_cm020.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm020?v_str1=SY005";
	gcds_cm020.Reset();

	//����  CM020
	gcds_cu003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cu003?v_str1=CM020";
	gcds_cu003.Reset();

	//�η´븮��  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM005";
	gcds_cm005.Reset();

	//����  RV0016
	gcds_Rv006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=RV006";
	gcds_Rv006.Reset();

	//�ڰݸ���(�ڰݱ���) CM021
	gcds_CM021.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM021";
	gcds_CM021.Reset();

	//�ڰݸ���(�ڰ�����) CM022
	gcds_CM022.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM022";
	gcds_CM022.Reset();

	//��� CM023
	gcds_CM023.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM023";
	gcds_CM023.Reset();

	//���� CM011
	gcds_CM011.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM011";
	gcds_CM011.Reset();

	//���� CM008(�ٹ�������)
	gcds_CM008.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM008";
	gcds_CM008.Reset();
	//���� CM009(�ʻ��±���)
	gcds_CM009.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM009";
	gcds_CM009.Reset();
	//���� CM010(�ʻ�����)
	gcds_CM010.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM010";
	gcds_CM010.Reset();

  //�Ի籸��
	gcds_cm024.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM024";
	gcds_cm024.Reset();

	//�߷ɱ���
	gcds_cm012.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM012";
	gcds_cm012.Reset();

	//�з�
	gcds_cm027.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM027";
	gcds_cm027.Reset();

	gcds_tsy010.DataID = "<%=dirPath%>/servlet/sales.bm.Company_pop_s01?v_str1="; 
	//prompt('',gcds_tsy010.DataID);
	gcds_tsy010.Reset();

	//�۱�����
	gcds_cm028.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM028";
	gcds_cm028.Reset();

	//�ڰݸ��� ����
	gcds_cm029.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM029";
	gcds_cm029.Reset();

	//�ڰݸ���
	gcds_cm030.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM030";
	gcds_cm030.Reset();

	//�����̼�����
	gcds_cm031.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM031";
	gcds_cm031.Reset();

	}
	/*----------------------------------------------------------------------------
		Description : �߰� - �λ縶����
----------------------------------------------------------------------------*/
	function ln_Add(e){
			if(e=='01'){
				  //2008.05.08.�ӽ÷� �߰���.
					gcds_data00.addrow();
					var row = gcds_data00.rowposition;
					gcem_pass_no.ReadOnly =false;
					gcem_pass_no.Enable=true;
					gclx_ord_cd.ReadOnly =false;
					gclx_ord_cd.Enable=true;
          gclx_ord_cd.bindcolval='001';
					gcds_data00.namevalue(gcds_data00.rowposition,"USTS")='1';
					gcds_data00.namevalue(gcds_data00.rowposition,"CUST_SID")=0;
					if (row<1) return;
			}else if(e=='03'){          //����
						gcds_data03.addrow();
			}else if(e=='04'){          //�Ի��� ���
						gcds_data04.addrow();
			}else if(e=='05'){          //�ڰݸ���
						gcds_data05.addrow();
			}else if(e=='07'){          //���
						gcds_data07.addrow(); 
			}else if(e=='09'){          //�ٹ���
						gcds_data09.addrow();
			}else if(e=='10'){          //����
						gcds_data10.addrow();
			}
	}
/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Save(e){
      
      if(!ln_Save_Chk(e)) return; 
			if(e=='01'){ //�⺻
			    var s_date = gcem_start_dt.text.substring(2,4);
					//prompt('',s_date);
					if (gcds_data00.IsUpdated) {
						 if(confirm("�����Ͻðڽ��ϱ�?")){
								gctr_data00.KeyValue = "Em010_T1(I:USER=gcds_data00)";
								gctr_data00.Parameters ="v_str1=9"+s_date+",v_str2="+gusrid;
								gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T1";
								prompt('',gcds_data00.text);
								gctr_data00.post();
						 }
					}
			}else if(e=='03'){
					if (gcds_data03.IsUpdated) {
							if(confirm("�����Ͻðڽ��ϱ�?")){
									gctr_data03.KeyValue = "Em010_T3(I:USER=gcds_data03)";
									gctr_data03.Parameters ="v_str1="+txt_empno.value+",v_str2="+gusrid;
									gctr_data03.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T3";
									gctr_data03.post();
							}
					}
			}else if(e=='04'){
						if (gcds_data04.IsUpdated) {
							if(confirm("�����Ͻðڽ��ϱ�?")){
										gctr_data04.KeyValue = "Em010_T4(I:USER=gcds_data04)";
										gctr_data04.Parameters ="v_str1="+txt_empno.value+",v_str2="+useid;
										gctr_data04.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T4";
										gctr_data04.post();
							}
						}
			}else if(e=='05'){
						if (gcds_data05.IsUpdated) {
								if(confirm("�����Ͻðڽ��ϱ�?")){	
										gctr_data05.KeyValue = "Em010_T5(I:USER=gcds_data05)";
										gctr_data05.Parameters ="v_str1="+txt_empno.value+",v_str2="+useid;
										gctr_data05.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T5";
										gctr_data05.post();
								}
						}
					
			}else if(e=='07'){
						if (gcds_data07.IsUpdated) {
								 if(confirm("�����Ͻðڽ��ϱ�?")){	
										gctr_data07.KeyValue = "Em010_T7(I:USER=gcds_data07)";
										gctr_data07.Parameters ="v_str1="+txt_empno.value+",v_str2="+useid;
										gctr_data07.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T7";
										gctr_data07.post();
								 }
						}
			}else if(e=='09'){
						if (gcds_data09.IsUpdated) {
								 if(confirm("�����Ͻðڽ��ϱ�?")){	
										gctr_data09.KeyValue = "Em010_T9(I:USER=gcds_data09)";
										gctr_data09.Parameters ="v_str1="+txt_empno.value+",v_str2="+useid;
										gctr_data09.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T9";
										gctr_data09.post();
								}
						}
			}else if(e=='10'){
						if (gcds_data10.IsUpdated) {
								if(confirm("�����Ͻðڽ��ϱ�?")){	
										gctr_data10.KeyValue = "Em010_T10(I:USER=gcds_data10)";
										gctr_data10.Parameters ="v_str1="+txt_empno.value+",v_str2="+useid;
										gctr_data10.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T10";
										gctr_data10.post();
								}
						}
			}
}
/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Delete(e){
		if (e=='01') {
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data00.deleterow(gcds_data00.rowposition);
						gctr_data00.KeyValue = "Em010_T1(I:USER=gcds_data00)";
						gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T1";
						gctr_data00.post();
				}
		} else if (e=='02') { //�系���
        if(!ln_Save_Chk(e)) return;
  
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data02.deleterow(gcds_data02.rowposition);
						gctr_data02.KeyValue = "Em010_T2(I:USER=gcds_data02)";
						gctr_data02.Parameters ="v_str1="+useid;
						gctr_data02.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T2";
						//prompt('',gcds_data02.text);
						gctr_data02.post();
				}
		}	else if(e=='03'){
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data03.deleterow(gcds_data03.rowposition);
						gctr_data03.KeyValue = "Em010_T3(I:USER=gcds_data03)";
						gctr_data03.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T3";
						gctr_data03.post();
				}
		}else if(e=='04'){
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data04.deleterow(gcds_data04.rowposition);
						gctr_data04.KeyValue = "Em010_T4(I:USER=gcds_data04)";
						gctr_data04.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T4";
						gctr_data04.post();
  			}
		}else if(e=='05'){
  			if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data05.deleterow(gcds_data05.rowposition);
						gctr_data05.KeyValue = "Em010_T5(I:USER=gcds_data05)";
						gctr_data05.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T5";
						gctr_data05.post();
				}
		}else if(e=='07'){
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data07.deleterow(gcds_data07.rowposition);
						gctr_data07.KeyValue = "Em010_T7(I:USER=gcds_data07)";
						gctr_data07.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T7";
						gctr_data07.post();
				}
		}else if(e=='09'){
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data09.deleterow(gcds_data09.rowposition);
						gctr_data09.KeyValue = "Em010_T9(I:USER=gcds_data09)";
						gctr_data09.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T9";
						gctr_data09.post();
				}
		}else if(e=='10'){
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data10.deleterow(gcds_data10.rowposition);
						gctr_data10.KeyValue = "Em010_T10(I:USER=gcds_data10)";
						gctr_data10.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_T10";
						gctr_data10.post();
				}
		}
}



/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
  function ln_Excel(){
    var szName = "��������";
    var szPath = "C:\\Test\\em010i.xls";
       if (gcds_data00.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName,szPath,2);
       }
   }

/*----------------------------------------------------------------------------
	Description : ����� üũ
----------------------------------------------------------------------------*/
function ln_Save_Chk(gbn){
	if(gbn=="01"){ //�⺻����
		if(gcem_start_dt.text==""){
			alert("�Ի����� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_vend_cd.bindcolval==""){
			alert("�ٹ���ü�� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_dept_cd.bindcolval==""){
			alert("�μ��� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_team_cd.bindcolval==""){
			alert("�Ҽ����� �Է��Ͻʽÿ�.");
			return false;
		}
    if(gclx_job_cd.bindcolval==""){
			alert("������ �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_country_cd.bindcolval==""){
			alert("������ �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_nation_cd.bindcolval==""){
			alert("������ �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_agency_cd.bindcolval==""){
			alert("�η´븮���� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_c_vend_cd.bindcolval==""){
			alert("���δ��ü�� �Է��Ͻʽÿ�.");
			return false;
		}
	}else if(gbn=="02"){ //�系��� ������ üũ 
		if(gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD")=="003"){ //
			alert("���������� ���Ƿ� ���� �� �� �����ϴ�.");
			return false;
		}

		if(gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD")=="001"){ //
			alert("�ű��Ի�� ���Ƿ� ���� �� �� �����ϴ�.");
			return false;
		}
	}else{

	}
	return true;
}


/*----------------------------------------------------------------------------
	Description : �����ҷ�����
----------------------------------------------------------------------------*/
function ln_Photo(row){
  //alert("ln_Photo::"+row+"::::"+gcds_data00.namevalue(row,"MANAGE_NO"));
	if(gcds_data00.namevalue(row,"MANAGE_NO")==undefined){
		photo.src="<%=dirPath%>/Sales/images/00000.gif";
	}else{
		var  dirFold = gcds_data00.namevalue(row,"MANAGE_NO").substring(0,1)+"/"; 
		photo.src = "<%=dirPath%>/Sales/file/photo/cust/"+dirFold+gcds_data00.namevalue(row,"MANAGE_NO")+".JPG";
	}
}


/******************************************************************************
	Description : ȭ�ϸ� üũ
******************************************************************************/
function ln_Divide(str, delim){
	var strArr=str.split(delim);
	var rtn="";
	var a=strArr.length;

	if(a>0){rtn=strArr[a-1];}
	strArr=null;
	return rtn;
}


/*----------------------------------------------------------------------------
	Description : ����ϱ�
----------------------------------------------------------------------------*/
function ln_Print(){
        
    var  dirFold = gcds_data00.namevalue(gcds_data00.rowposition,"MANAGE_NO").substring(0,1)+"/"; 

		//�λ�⺻����
		gcds_report0.ClearAll();
		ln_SetPrintDataHeader();
  	gcds_report0.ImportData(gcds_data00.ExportData(gcds_data00.rowposition,1,false));
	  gcds_report0.rowposition =  gcds_data00.rowposition;

		gcds_report0.namevalue(gcds_report0.rowposition,"PIC_DIR") = rDOMAIN+"<%=dirPath%>/Sales/file/photo/cust/"+dirFold+gcds_report0.namevalue(gcds_report0.rowposition,"MANAGE_NO")+".JPG";
    gcds_report0.namevalue(gcds_report0.rowposition,"CUR_DT") =gs_date;
      	
		//�系�����
		gcds_report2.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S2?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report2.Reset();

		//��������
		gcds_report3.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S3?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report3.Reset();

		//�Ի������
		gcds_report4.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S4?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report4.Reset();

		//�ڰݸ���
		gcds_report5.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S5?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report5.Reset();
    
		//�ް�
		gcds_report6.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S6?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report6.Reset();
   
		//���
		gcds_report7.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S7?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report7.Reset();
    
		//����
		//gcds_report8.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S8?"
		//									  + "v_str1=" + txt_empno.value;
	  //gcds_report8.Reset();

		//�ٹ���
		gcds_report9.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S9?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report9.Reset();
  
		//����
		gcds_report10.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S10?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report10.Reset();
     
		//���
		gcds_report11.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S11?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report11.Reset();
		
		gcrp_print.preview();
}
</script>
<%/*=============================================================================
				Developer Java Script ��
=============================================================================*/%>
<%/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/%>
<!-- �����ҷ����� -->
<!--  <script language="javascript" for="gcip_file" event=OnClick()>
  //alert("gcip_file::"+fn_trim(gcip_file.value));

	if (fn_trim(gcip_file.value)!="") {
		txt_file.value = gcip_file.value;
		photo.src = gcip_file.value;
		var tfile = txt_file.value;
		var tfilename = ln_Divide(txt_file.value, "\\");
		alert("tfilename::"+tfilename);
		gcds_data00.namevalue(gcds_data00.rowposition,"PICTURE") =  tfilename;
	}
</script>  -->
<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	
	if (gcds_data00.countrow>0) {
		if (index=="2") ln_OrdQuery();        //�系��� ��ȸ
		else if (index=="3")	ln_FamQuery();	//����������ȸ
		else if (index=="4")	ln_CarQuery();	//�Ի�����»�����ȸ
		else if (index=="5")	ln_LicQuery();  //�ڰ���������ȸ
		else if (index=="6")	ln_VacQuery();  //�ް���ȸ
		else if (index=="7")	ln_RewQuery();  //�������
		else if (index=="8")	ln_MediQuery();  //������ȸ
		else if (index=="9")	ln_ClothQuery();  //�ٹ�������
		else if (index=="10")	ln_ReqQuery();	//��������
		else if (index=="11")	ln_DeuQuery();  //�������
	}
</script>
<!-- ���� �׸��� -->
<script language=JavaScript for=gcds_data00 event=OnRowPosChanged(row)>
    if(row>=1){
			ln_Photo(row);
    }else{
			photo.src="<%=dirPath%>/Sales/images/00000.gif";
		}
		chk_tab = gcte_disp.ActiveIndex;

				if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1'){//�⺻ȭ�� Ǯ�ٿ�޴� �ű�,�������� �˻��� ��װ� Ǯ��
						gcra_sex.Enable=false;//sex �ʵ�� �λ縶���Ͱ� �ƴϹǷ� �׻� ���Ƴ���.
						gclx_nation_cd.Enable=true;
						//gcem_start_dt.Enable=true;
						gcem_start_dt.readonly=false;
						gcem_end_dt.readonly=false;
						gcem_chgymd.readonly=false;
						gclx_job_cd.Enable=true;
						gclx_agency_cd.Enable=true;
						gclx_vend_cd.Enable=true;
						gclx_dept_cd.Enable=true;
						gclx_team_cd.Enable=true;
						gclx_work_cd.Enable=true;
						//gclx_skill_cd.Enable=true;
						gclx_country_cd.Enable=true;
						gcem_empnmk.Enable=true;
						gcem_empnmc.Enable=true;
						gcem_eng_nm.Enable=true;
						gclx_c_vend_cd.Enable=true;

				}else{
						gcra_sex.Enable=false;//sex �ʵ�� �λ縶���Ͱ� �ƴϹǷ� �׻� ���Ƴ���.
						gclx_nation_cd.Enable=false;
						//gcem_start_dt.=false;
            gcem_start_dt.readonly=true;
						gcem_end_dt.readonly=true;
						gcem_chgymd.readonly=true;
						gclx_job_cd.Enable=false;
						gclx_agency_cd.Enable=false;
						gclx_vend_cd.Enable=false;
						gclx_dept_cd.Enable=false;
						gclx_team_cd.Enable=false;
						gclx_work_cd.Enable=false;
						gclx_skill_cd.Enable=false;
						gclx_country_cd.Enable=false;
						////gcem_empnmk.Enable=false;
						gcem_empnmc.Enable=false;
						gcem_eng_nm.Enable=false;
						////gclx_c_vend_cd.Enable=false;

				}
						if(chk_tab=='2'){
							ln_OrdQuery();//�系���
						}else if(chk_tab=='3'){
							ln_FamQuery();//����
						}else if(chk_tab=='4'){
							ln_CarQuery();//�Ի������
						}else if(chk_tab=='5'){
							ln_LicQuery();//�ڰݸ���
						}else if(chk_tab=='6'){
							ln_VacQuery();//�ް�
						}else if(chk_tab=='7'){
							ln_RewQuery();//���
						}else if(chk_tab=='8'){
							ln_MediQuery();//����
						}else if(chk_tab=='9'){
							ln_ClothQuery();//�ٹ�������
						}else if(chk_tab=='10'){
							ln_ReqQuery();//����
						}else if(chk_tab=='11'){
							ln_DeuQuery();//���
						}
</script>

<script language=JavaScript for=gcgd_disp05 event=OnCloseUp(row,colid)>
	if(row>0 && colid=="LCS_TYPE"){
		gcds_cm030.Filter();
	}
</script>

<!-- filter -->
<script language=JavaScript for=gcds_cm030 event=onFilter(row)>
	if(gcds_data05.namevalue(gcds_data05.rowposition,"LCS_TYPE")!="2"){//�ڰ�
		if(gcds_cm030.namevalue(row,"ITEM2")=="1") return true;
		else return false;
	}		

	if(gcds_data05.namevalue(gcds_data05.rowposition,"LCS_TYPE")!="1"){//����
		if(gcds_cm030.namevalue(row,"ITEM2")=="2") return true;
		else return false;
	}		
</script> 

<script language=JavaScript for=gclx_job_cd event=OnSelChange()>
for(i=1;i<=gcds_cm013.countrow;i++){
	if(gcds_cm013.namevalue(i,"COM_CODE")==gcds_cm004.namevalue(gcds_cm004.rowposition,"ITEM2")){
		gclx_skill_cd.index=i-1;
		break;
	}
}
</script>


<%
/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/	%>
	<script language="javascript" for="tr1" event="onsuccess()">
	</script>
	<!-- �λ縶���� -->
		<script language="javascript" for="gctr_data00" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data00" event="OnFail()">
			alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
		</script>

<!-- ���� -->
		<script language="javascript" for="gctr_data03" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data03" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>

<!-- �Ի������ -->
		<script language="javascript" for="gctr_data04" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data04" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>
<!-- �ڰݸ��� -->
		<script language="javascript" for="gctr_data05" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data05" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>
<!-- ��� -->
		<script language="javascript" for="gctr_data07" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data07" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>
<!-- �ٹ������� -->
		<script language="javascript" for="gctr_data09" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data09" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>
<!-- ���� -->
		<script language="javascript" for="gctr_data10" event="OnSuccess()">
			alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
		</script>
		<script language="javascript" for="gctr_data10" event="OnFail()">
			alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
		</script>
<%/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/	%>


<%/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/%>
<!-- �λ�⺻ -->
	<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
			document.all.LowerFrame.style.visibility="visible";
	</script>
	<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
			ln_Photo(1);
			if (row <1) {
				alert("�˻��� �����Ͱ� �����ϴ�.");
			}else{
			}
	</script>
<!-- �系��� -->
			<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>

<!-- �������� -->
			<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">

			gcgd_disp03.ColumnProp("BIRTHDAY","Edit")="Numeric";//����

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>

<!-- �Ի������ -->
			<script language="javascript" for="gcds_data04" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">

			gcgd_disp04.ColumnProp("START_DT","Edit")="Numeric";//�Ի���
			gcgd_disp04.ColumnProp("END_DT","Edit")="Numeric";//�����

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt4.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>

<!-- �ڰݸ��� -->
			<script language="javascript" for="gcds_data05" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data05" event="onloadCompleted(row,colid)">

			gcgd_disp05.ColumnProp("GET_DT","Edit")="Numeric";//�������

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt5.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- �ް� -->
			<script language="javascript" for="gcds_data06" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data06" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt6.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- ��� -->
			<script language="javascript" for="gcds_data07" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data07" event="onloadCompleted(row,colid)">

			gcgd_disp07.ColumnProp("RCV_DT","Edit")="Numeric";//��������
			gcgd_disp07.ColumnProp("PAY_DT","Edit")="Numeric";//���޳��

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt7.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- ���� -->
			<script language="javascript" for="gcds_data08" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data08" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt8.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- �ٹ������� -->
			<script language="javascript" for="gcds_data09" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data09" event="onloadCompleted(row,colid)">

			gcgd_disp09.ColumnProp("SUB_DT","Edit")="Numeric";//��������
			gcgd_disp09.ColumnProp("RTN_DT","Edit")="Numeric";//�ݳ���

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt9.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- ���� -->
			<script language="javascript" for="gcds_data10" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data10" event="onloadCompleted(row,colid)">

			gcgd_disp10.ColumnProp("START_DT","Edit")="Numeric";//����������
			gcgd_disp10.ColumnProp("END_DT","Edit")="Numeric";//����������

			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt10.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>
<!-- ��� -->
			<script language="javascript" for="gcds_data11 event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			</script>
			<script language="javascript" for="gcds_data11" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt11.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>

<!-- �⺻�� -->
		<!-- 	<script language="javascript" for="gcds_data12 event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			</script>
			<script language="javascript" for="gcds_data12" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script> -->

 <script language=JavaScript for=gcrp_print event=OnError()>
	alert("Error Code =" + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
				window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
</script>

<!-- �Ҽ��� -->
<script language="javascript" for="gcds_cmsosok" event="onloadCompleted(row,colid)">
	gcds_cmsosok.insertrow(1);
	gcds_cmsosok.namevalue(1,"COM_CODE") = "";
	gcds_cmsosok.namevalue(1,"COM_SNAME") = "��ü";
	gclx_cmsosok.index = 0;
</script>

<script language="javascript" for="photo" event=onerror>
	   photo.src="<%=dirPath%>/Sales/images/00000.gif";
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
<!-- 	<PARAM NAME="SortExpr" VALUE="+RESINO"> -->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data052 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+ORDDT">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data08 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data09 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="-EVAYM">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="-FRDT-TODT">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- <%=HDConstant.COMMENT_START%><OBJECT id=gcds_data12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%> -->

<!-- �����ڵ� DataSet ���� ------------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cmsosok classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+COM_SNAME">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cu003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_Rv006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM021 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM022 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM023 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM011 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM008 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_CM009 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_CM010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm024 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm012 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_tsy010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm027 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm028 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �ڰݸ��㱸�� -->
<OBJECT id=gcds_cm029 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �ڰݸ��� -->
<OBJECT id=gcds_cm030 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name="UseFilter"	value="true">
</OBJECT>
<!-- �����̼����� -->
<OBJECT id=gcds_cm031 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report10 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- �λ縶���� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>

<!-- �系��� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>

<!-- ���� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>

<!-- �Ի������ -->
<%=HDConstant.COMMENT_START%><object id="gctr_data04" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<!-- �ڰݸ��� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data05" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<!-- ��� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data07" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<!-- �ٹ������� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data09" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<!-- ���� -->
<%=HDConstant.COMMENT_START%><object id="gctr_data10" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" >
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>
</head>

<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border=0 cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=orange>
	<tr height="20px">
		<td align="left" colspan="3"><!-- ��ư ���� ����-->
		<table width="825" border="0"  cellspacing="0" cellpadding="0">
						<tr>
							<td align="right" height="30px">		
							  <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"  onclick="ln_Find('01')">
                <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
								<img src="<%=dirPath%>/Sales/images/plus.gif"     style="cursor:hand" onclick="ln_Add('01')">	
                <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete('01')" >		
                <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save('01')">
								<img src="<%=dirPath%>/Sales/images/print.gif"	style="cursor:hand"  onclick="ln_Print()">
								<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel('01')">
							</td>
					</tr>																		
		</table>
		</td><!-- ��ư ���� ��-->
	</tr>
	<tr>
<!-- ��Ģ �׸��� ���� ����-->
	<td align="left" width="175px" height="494" valign="top">
		<table height="0" border="0" cellpadding="0" cellspacing="1"  bgcolor="#708090">
						<!-- <tr height="35px"> -->
						<tr height="40">
							<td width="px" align="center" bgcolor="#eeeeee" style="width:80px;" cellpadding="1" >����<br>����</td>
							<td width="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><OBJECT id=gclx_usts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:5px;top:1px;font-size:12px;width:100px;">
									<param name=CBData					value="^��ü,1^����^,3^����">
									<param name=CBDataColumns		value="COM_CODE,COM_SNAME">
									<param name=Index						value=1>
									<param name=SearchColumn		value="COM_SNAME">
									<param name=ListExprFormat	value="COM_SNAME^0^70">								
									<param name=BindColumn			value="COM_CODE">
									<param name=Enable					value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
								<!-- <input type=text id="txt_nm" class="txt_a01" style="width:80px;top:0px;" maxlength=30> -->
								</td>
						</tr>
						<tr height="40">
							<td  align="center" bgcolor="#eeeeee">�Ҽ�<br>����</td>
							<td  bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%><OBJECT id=gclx_cmsosok classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:5px;top:1px;font-size:12px;width:100px;">
														<param name=ComboDataID			value="gcds_cmsosok">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=Index						value=0>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%>
								<!-- <input type=text id="txt_dept" class="txt_a01" style="width:80px;top:0px;" maxlength=30> -->
							</td>
						</tr>
						<tr height="40">
							<td  align="center" bgcolor="#eeeeee">����</td>
							<td  bgcolor="#FFFFFF">
								<input type=text id="txt_nm" class="" style="position:relative;left:5px;width:100px;top:0px;" maxlength=30 onkeydown="if(event.keyCode==13)ln_Query();">
								<input type=hidden id="txt_usts"  style="width:80px;top:0px;" maxlength=1 >
							</td>
						</tr>
						<tr>
							<td colspan="2" class="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%>
									<OBJECT id="gcgd_disp"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height:327;width:170">
										<param name=DataID							value="gcds_data00">
										<param Name=BorderStyle					value=0> 
										<param name=indwidth						value=0>
										<param name=fillarea						value=true>
										<param name=Colsizing						value=true>
										<param name=Editable						value=false>
										<param name=headlinecolor				value=#999999>
										<param name="sortview"					value=left>
										<param name=format							value='
											<FC>ID=EMPNO    	Name="���",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<FC>ID=EMPNMK    	Name="����",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<C>ID=JOB_CD    	Name="����",  width=60,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true,EditStyle=Lookup,Data="gcds_cm004:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=VEND_CD   	Name="�ٹ���ü", width=70, HeadBgColor=#B9D4DC,	HeadAlign=center , sort = false,EditStyle=Lookup,Data="gcds_cm019:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=DEPT_CD   	Name="�μ�",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm006:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=TEAM_CD   	Name="�Ҽ�",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm003:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=WORK_CD   	Name="�ٹ���",width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm007:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=AGENCY_CD 	Name="�η´븮��", width=70,	 HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm005:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=SEX,        Name="����",  width=30,  HeadBgColor=#B9D4DC, HeadAlign=center,  Value={IF(SEX="M","��","��")}, align="center"</C>
											<C>ID=COUNTRY_CD	Name="����",  width=45,	 HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm020:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=NATION_CD 	Name="����",  width=60,	 HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cu003:COM_CODE:COM_SNAME" ,align="left"</C>
										'>
								</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset bgcolor="#FFFFFF" style="width:170;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;bgcolor:#FFFFFF;" >
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;" ></font>
								</fieldset>
							</td>
					</tr>
		</table>
	</td>
<!-- ��Ģ �׸��� ���� ��-->
	<td width=10></td><!-- �߰� ����κ� -->
	<td width="649" valign="top"><!-- ���� ���̺� ��� ����-->
		<table width="649" height="473" border="0" cellpadding=0 cellspacing=0>
			<tr>
				<td width="125" valign="top">
					<table width="125" height="159" border="1" cellpadding=0 cellspacing=1>
						<tr>
							<td align="center"  bgcolor="#FFFFFF">
								<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border=0 width="100px" height="131px" style="position:relative;top:2px;">
								<!-- <img id="photo" src="worker/9080001.jpg" border=0 width="100px" height="124px" style="position:relative;top:2px;"> -->
							</td>
							</tr>
							<tr>
								<td align="center"  bgcolor="#FFFFFF" height="22">&nbsp;
								<!-- 	<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
									style="position:relative;left:0px;top:0px;width:80; height:25;">
									<param name="Text"		value="ã�ƺ���">
									<param name="Enable"  value="true">
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td align="center"  bgcolor="#FFFFFF" height="22">&nbsp;
								</td>
							</tr>
						</table>
				</td>
				<td width="524" align="left" valign="top">
					<table width=524 cellpadding=0 cellspacing=1 bgcolor="#708090" border=0>
						<tr height=23>
							<td width="80" bgcolor="#eeeeee">&nbsp;����</td>
							<td width="92" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><OBJECT id=gcem_empnmk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:80px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="###############">
								<param name=GeneralEdit   value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
							</td>
							<td width="80" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><OBJECT id=gcem_empnmc classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:60px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="##########">
								<param name=GeneralEdit   value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
							</td>
							<td width="92" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><OBJECT id=gcem_eng_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:80px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="##########">
								<param name=GeneralEdit   value="true">
								</OBJECT><%=HDConstant.COMMENT_END%>
							</td><!-- </form> -->
							<td width="80" bgcolor="#eeeeee">&nbsp;���</td> 
							<td width="92" bgcolor="#FFFFFF">
							   <input type="text" id=txt_empno class="txt_a01" style="position:relative;left:8px;width:75px;background-color:#CCFFCC" readonly>
							   <!-- <input type="hidden" id=txt_custid class="txt_a01" style="width:80px;" > -->
							</td>
						</tr>
						<tr height=22>
							<td bgcolor="#eeeeee">&nbsp;�������</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_birthday classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
										    </OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcra_sex classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
													style="position:relative;left:0px;top:0px;height:20;width:80;cursor:hand;">
														<param name=Cols      value="2">
														<param name=Format    value="M^��,F^��">
												</OBJECT><%=HDConstant.COMMENT_END%></td>
              <td bgcolor="#eeeeee">&nbsp;�Ի籸��</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_ord_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm024">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
                            <param name=Enable					value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
						<tr height=23>
							<td bgcolor="#eeeeee">&nbsp;�Ի���</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_start_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;�����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;�޿�������</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_chgymd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
												</OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
						<tr height=22>
							<td bgcolor="#eeeeee">&nbsp;�ٹ���ü</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_vend_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm019">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;�μ�</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm006">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;�Ҽ���</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm003">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=Index						value=0>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
						<tr height=22>
							<td bgcolor="#eeeeee">&nbsp;�ٹ���</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_work_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm007">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=Index						value=0>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
              <td bgcolor="#eeeeee">&nbsp;����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_job_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm004">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;��ɱ���</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_skill_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm013">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=Enable					value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
						<tr height=22>
              <td bgcolor="#eeeeee">&nbsp;����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_country_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm020">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_nation_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cu003">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td> 
							<td bgcolor="#eeeeee">&nbsp;�η´븮��</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gclx_agency_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_cm005">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^100">
														<param name=BindColumn			value=COM_CODE>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
						<tr height=22>
							<td bgcolor="#eeeeee">&nbsp;���ǹ�ȣ</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_pass_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment						value=0>
														<param name=Border							value=true>
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=Format							value="##########">
														<param name=PromptChar					value="_">
										    </OBJECT><%=HDConstant.COMMENT_END%> </td>
							<td bgcolor="#eeeeee">&nbsp;���Ǹ�����</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_pass_epdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
										    </OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;���ⱹ��No</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_n_card_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=Format	      value="000000000">
														<param name=PromptChar	  value="_">
										    </OBJECT><%=HDConstant.COMMENT_END%> </td>
						</tr>
						<tr height=22>
							<td bgcolor="#eeeeee">&nbsp;����ڹ�ȣ</td>
							<td bgcolor="#FFFFFF" ><%=HDConstant.COMMENT_START%><OBJECT id=gcem_cust_sid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			      value=0>
														<param name=Border	            value=true>
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=PromptChar	        value="_">
														<param name=IsComma             value=false>

										    </OBJECT><%=HDConstant.COMMENT_END%> 
							</td>
							<td bgcolor="#eeeeee">&nbsp;���δ��ü</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%>
							            <OBJECT id=gclx_c_vend_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
														<param name=ComboDataID			value="gcds_tsy010">
														<param name=CBDataColumns		value="VEND_SID,VEND_NM">
														<param name=SearchColumn		value=VEND_NM>
														<param name=Sort						value=false>
														<param name=ListExprFormat	value="VEND_NM^0^150">
														<param name=BindColumn			value=VEND_SID>
												</OBJECT><%=HDConstant.COMMENT_END%></td>
							<td bgcolor="#eeeeee">&nbsp;�ټӳ���</td>
							<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%><OBJECT id=gcem_con_year classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
													style="position:relative; left:8px;top:1px; width:20px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
														<param name=Alignment			 value=2>
														<param name=ReadOnly						value="true">
														<param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=Border	      value=true>
														<param name=MaxLength     value=2>
														<param name=PromptChar	  value="_">
										    </OBJECT><%=HDConstant.COMMENT_END%></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="1"><td colspan=3></td></tr>

			<tr height="20">
				<td colspan=3 valign="top" >
					<%=HDConstant.COMMENT_START%><OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 
					style="width:650px;height:20px">
					<PARAM NAME="BackColor"					VALUE="#cccccc">
					<PARAM NAME="titleHeight"				VALUE="20px">
					<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
					<PARAM NAME="Format"						VALUE="
					<T>divid=layer1  title='�⺻'</T>									
					<T>divid=layer2  title='�系���'</T>
					<T>divid=layer3  title='����'</T>
					<T>divid=layer4  title='�Ի������'</T>
					<T>divid=layer5  title=�ڰݸ���</T>
					<T>divid=layer6  title='�ް�'</T>
					<T>divid=layer7  title='���'</T>
					<T>divid=layer8  title='����'</T>
					<T>divid=layer9 title='�ٹ�������'</T>
					<T>divid=layer10  title='����'</T>
					<T>divid=layer11 title='���'</T>
					">
					</OBJECT><%=HDConstant.COMMENT_END%>
				</td>
			</tr>

			<tr height="230">
				<td>
<!---------[TAB 1] left:200px;�⺻���� ----------->
						<div id="layer1" style="position:absolute; top:360px; left:350px;">
							<table style="position:relative;top:4px;border:0 solid #708090;border-bottom-width:0px;" cellpadding=0 cellspacing=0 border=0 >
								<!-- �ּҺκ� -->
                 <tr> 
										<td>
											 <table style="position:relative;top:0px;border:1 solid #708090;border-bottom-width:0px;"  style="width:648px;" cellpadding=0 cellspacing=0 border=0 >
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >���ⱹ����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">�ּ�</td>
														<td class="tab22" width="502px" colspan=5 >
															<input type="text" id=txt_address1 class="txt11" style="position:relative;left:8px;width:460px;background-color:#CCFFCC" maxlength="40"  readonly>
															<input type="hidden" id=txt_zipcd class="txt11" style="width:0px;" maxlength="20" >
														 </td>
													</tr>
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan=2>�߱�����<BR>����ó</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">����</td>
														<td class="tab22" width="60px" >
															<input type="text" id=txt_chi_nm class="txt11" style="position:relative;left:8px;width:80px;" maxlength="10" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>����</td>
														<td class="tab22" width="60px" >
															<input type="text" id=txt_chi_rnm class="txt11" style="position:relative;left:8px;width:80px;" maxlength="10" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>��ȭ��ȣ</td>
														<td class="tab22" width="100px" >
															<input type="text" id=txt_chi_tel class="txt11" style="position:relative;left:8px;width:116px;" maxlength="20" >
														</td>
													</tr>
													<tr>
														<td class="tab11" width="60px"  bgcolor="#eeeeee">�ּ�</td>
														<td class="tab22" width="482px" colspan=5 >
															<input type="text" id=txt_chi_add class="txt11" style="position:relative;left:8px;width:460px;" maxlength="40" >
														 </td>
													</tr>
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan=2>�۱�����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">�۱�����</td>
														<td class="tab22" width="60px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gclx_rem_bnk classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
																style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
																	<param name=ComboDataID			value="gcds_cm028">
																	<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
																	<param name=SearchColumn		value=COM_SNAME>
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="COM_SNAME^0^100">
																	<param name=BindColumn			value=COM_CODE>
															 </OBJECT>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>������</td>
														<td class="tab22" width="60px" >
															<input type="text" id=txt_sav_nm class="txt11" style="position:relative;left:8px;width:80px;" maxlength="10" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>��ȭ��ȣ</td>
														<td class="tab22" width="100px" >
															<input type="text" id=txt_sav_tel class="txt11" style="position:relative;left:8px;width:116px;" maxlength="20" >
														</td>
													</tr>
													<tr>
														<td class="tab11" width="60px"  bgcolor="#eeeeee">�۱ݰ���</td>
														<td class="tab22" width="482px" colspan=5 >
															 <input type="text" id=txt_rem_acc class="txt11" style="position:relative;left:8px;width:252px;" maxlength="30" >
														 </td>
													</tr>

											 </table>
										</td>
								 </tr>
								  <tr> 
										<td>
											 <table style="position:relative;top:0px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;" style="width:648px;" cellpadding=0 cellspacing=0 border=0 >
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan=2>��ü<BR>����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">����</td>
														<td class="tab22" width="111px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_height classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
																	<param name=Text            value=0>
																	<param name=Alignment			  value=2>
																	<param name=Border	        value=true>
																	<param name=MaxLength       value=3>
																	<param name=MaxDecimalPlace value=1>
																	<param name=PromptChar	    value="_">
																	<param name=SelectAll       value=true>
																</OBJECT>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (cm)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>ü��</td>
														<td class="tab22" width="113px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_weight classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
																	<param name=Text            value=0>
																	<param name=Alignment			  value=2>
																	<param name=Border	        value=true>
																	<param name=MaxLength       value=3>
																	<param name=MaxDecimalPlace value=1>
																	<param name=PromptChar	    value="_">
																	<param name=SelectAll       value=true>
																</OBJECT>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (kg)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>������</td>
														<td class="tab22" width="165px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_blood classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
																	<param name=Alignment			  value=0>
																	<param name=Border	        value=true>
																	<param name=format         value="AA">
																	<param name=UpperFlag      value=1>
																</OBJECT>
														 <%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td class="tab11" width="60px" bgcolor="#eeeeee">�Ź�ũ��</td>
														<td class="tab22" width="111px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_size_ft classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
																	<param name=Text            value=0>
																	<param name=Alignment			  value=2>
																	<param name=Border	        value=true>
																	<param name=MaxLength       value=3>
																	<param name=PromptChar	    value="_">
																	<param name=SelectAll       value=true>
																</OBJECT>
														 <%=HDConstant.COMMENT_END%>&nbsp; (cm) 
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>�㸮�ѷ�</td>
														<td class="tab22" width="113px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_size_wt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
																	<param name=Text            value=0>
																	<param name=Alignment			  value=2>
																	<param name=Border	        value=true>
																	<param name=MaxLength       value=2>
																	<param name=PromptChar	    value="_">
																	<param name=SelectAll       value=true>
																</OBJECT>
														 <%=HDConstant.COMMENT_END%>&nbsp; (inch) 
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>&nbsp;����/����</td>
														<td class="tab22" width="100px" >
														    <input type="text" id=txt_size_up class="txt11" style="position:relative;left:8px;width:35px;" maxlength="5" >&nbsp;&nbsp;/
																<input type="text" id=txt_size_dn class="txt11" style="position:relative;left:8px;width:35px;" maxlength="5" >
														</td>
													</tr>
											 </table>
										</td>
								 </tr>
								 <tr> 
										<td>
											 <table style="position:relative;top:0px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;" style="width:648px;" cellpadding=0 cellspacing=0 border=0 >
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan=2>�����з�</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">�з�</td>
														<td class="tab22" width="111px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gclx_att_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
																style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
																	<param name=ComboDataID			value="gcds_cm027">
																	<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
																	<param name=SearchColumn		value=COM_SNAME>
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="COM_SNAME^0^100">
																	<param name=BindColumn			value=COM_CODE>
															 </OBJECT>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>�б���</td>
														<td class="tab22" width="113px" >
															<input type="text" id=txt_sch_nm class="txt11" style="position:relative;left:8px;width:80px;" maxlength="20" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>�Ⱓ</td>
														<td class="tab22" width="164px" >
															<%=HDConstant.COMMENT_START%>
																<OBJECT id=gcem_sch_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
																	<param name=Alignment			value=0>
																	<param name=Border	      value=true>
																	<param name=Format	      value="YYYY/MM">
																	<param name=PromptChar	  value="_">
																</OBJECT>
														  <%=HDConstant.COMMENT_END%>&nbsp;~
															<%=HDConstant.COMMENT_START%>
															<OBJECT id=gcem_sch_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
																style="position:relative; left:8px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
																	<param name=Alignment			value=0>
																	<param name=Border	      value=true>
																	<param name=Format	      value="YYYY/MM">
																	<param name=PromptChar	  value="_">
																</OBJECT>
														  <%=HDConstant.COMMENT_END%>
														</td>
													</tr>
											 </table>
										</td>
								 </tr>
								 <tr> 
										<td>
											 <table style="position:relative;top:0px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;" style="width:648px;" cellpadding=0 cellspacing=0 border=0 >
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >��Ÿ����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">���</td>
														<td class="tab22" width="111px" >
															<input type="text" id=txt_hobby class="txt11" style="position:relative;left:8px;width:80px;" maxlength="20" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>Ư��</td>
														<td class="tab22" width="113px">
															<input type="text" id=txt_spc_nm class="txt11" style="position:relative;left:8px;width:80px;" maxlength="20" >
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align=center>�⺻��</td>
														<td class="tab22" width="164px">
															<%=HDConstant.COMMENT_START%><OBJECT id=gcem_b_pay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
																style="position:relative; left:8px;top:3px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
																	<param name=Alignment			  value=2>
																	<param name=Border	        value=true>
																	<param name=MaxLength       value=3>
																	<param name=MaxDecimalPlace value=1>
																	<param name=PromptChar	    value="_">
																	<param name=ReadOnly						value="true">
														      <param name=ReadOnlyBackColor   value="#CCFFCC">
															</OBJECT><%=HDConstant.COMMENT_END%>&nbsp; <FONT style="position:relative;top:-3px;">(����⺻��)</FONT>
														    <input type="hidden"   id=txt_tel_no  class="txt11" style="width:80px;" maxlength="20" >
														    <input type="hidden" id=txt_mobile_no class="txt11" style="width:80px;" maxlength="20" >
														</td>
													</tr>
											 </table>
										</td>
								 </tr>
							</table>
						</div>
						<!---------[TAB 2] �系��� �׸���----------->
						<div id="layer2" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_OrdQuery()">
									  <img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('02')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data02>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
													<F> Name=NO				ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=center </F> 
													<F> Name=�߷�����	ID=ORD_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	 align=center, MASK="XXXX/XX/XX"</F> 
													<C> Name=�߷ɱ��� ID=ORD_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm012:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=�ٹ���ü ID=VEND_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm019:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=�Ҽ���		ID=TEAM_CD, HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm003:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=�ٹ���		ID=WORK_CD, HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm007:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=����			ID=JOB_CD,  HeadAlign=Center HeadBgColor=#B9D4DC Width=60,   EditStyle=Lookup,Data="gcds_cm004:COM_CODE:COM_SNAME" ,align="left"</C>
													<C> Name=���			ID=REMARK,  HeadAlign=Center HeadBgColor=#B9D4DC Width=140, ,align="left"</C>
													'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>

						<!---------[TAB 3] �������� �׸���----------->
						<div id="layer3" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('03')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('03')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('03')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data03>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO				ID={CurRow}	HeadAlign=Center HeadBgColor=#B9D4DC Width=26,	 align=center </F> 
												<C> Name=����			ID=FAMI_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=85,	 align=left</C>
												<C> Name=�������	ID=BIRTHDAY,	HeadAlign=Center HeadBgColor=#B9D4DC Width=74, align=center, Mask="XXXX/XX/XX"</C>
												<C> Name=����			ID=JOB_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	 align=left</C> 
												<C> Name=����			ID=REF_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=60,	 align=center,EditStyle=Lookup,Data="gcds_Rv006:COM_CODE:COM_SNAME"</C> 
												<C> Name=���			ID=REMARK,	HeadAlign=Center HeadBgColor=#B9D4DC Width=303,	 align=left</C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt3 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>

						<!---------[TAB 4] �Ի������ �׸���----------->
						<div id="layer4" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('04')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('04')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('04')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data04>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=Colsizing       value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC  Align=center Width=30 </F> 
												<C> Name=�Ի���	  	ID=START_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=75 Align=center Mask="XXXX/XX/XX"</C> 
												<C> Name=�����	  	ID=END_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=75   Align=center Mask="XXXX/XX/XX"</C> 
												<C> Name=ȸ���			ID=COMPNM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=110  Align=left</C> 
												<C> Name=������			ID=POSINM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=65   Align=left</C> 
												<C> Name=������		ID=DUTYNM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   Align=left</C>
												<C> Name=��������		ID=REAMRK,	HeadAlign=Center HeadBgColor=#B9D4DC Width=180  Align=left</C>
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt4 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>

						<!---------[TAB 5] �ڰݸ��� �׸���----------->
						<div id="layer5" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('05')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('05')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('05')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data05>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=Colsizing       value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=center </F> 
												<C> Name=������� ID=GET_DT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center, Mask="XXXX/XX/XX"</C> 
												<C> Name=�ڰݸ��㱸�� ID=LCS_TYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left , EditStyle=Lookup,Data="gcds_CM029:COM_CODE:COM_SNAME"</C> 
												<C> Name=�ڰ����� ID=LCS_CD	  HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left , EditStyle=Lookup,Data="gcds_CM030:COM_CODE:COM_SNAME"</C> 
												<C> Name=����ȣ   ID=LCS_NO		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=center </C> 
												<C> Name=����ó   ID=ISS_PART	HeadAlign=Center HeadBgColor=#B9D4DC Width=175	align=left </C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt5 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>

						<!---------[TAB 6] �ް� �׸���----------->
						<div id="layer6" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_VacQuery()">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp06 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data06>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=false>
												<param name=AllShowEdit     value=true>
												<param name=Colsizing       value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO			    	 ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=center</F>
												<C> Name=�Ҽ�		       ID=TEAM_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center </C>
												<C> Name=�ް�������		 ID=START_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center Mask="XXXX/XX/XX"</C>
												<C> Name=�ް�������		 ID=END_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center Mask="XXXX/XX/XX"</C>
												<C> Name=�ް��ϼ�			 ID=H_DAY,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right </C>
												<C> Name=�ް�����			 ID=H_RES,	HeadAlign=Center HeadBgColor=#B9D4DC Width=280  align=left  </C>
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt6 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>

						<!---------[TAB 7] ��� �׸���----------->
						<div id="layer7" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('07')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('07')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('07')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp07 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data07>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	align=center </F> 
												<C> Name=�������� ID=RCV_DT, 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center,	Mask="XXXX/XX/XX"</C> 
												<C> Name=������� ID=REW_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=left , EditStyle=Lookup,Data="gcds_CM023:COM_CODE:COM_SNAME"</C> 
												<C> Name=�����   ID=REW_AMT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right</C> 
												<C> Name=���޳�� ID=PAY_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center ,Mask="XXXX/XX"</C> 
												<C> Name=������� ID=REW_RK,	HeadAlign=Center HeadBgColor=#B9D4DC Width=250	align=left </C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt7 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<!---------[TAB 8] ���� �׸���----------->
						<div id="layer8" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_MediQuery()">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp08 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data08>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=false>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=center </F> 
												<F> Name=�������� ,ID=MEDI_DATE,	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center  mask="XXXX/XX/XX"</F> 
												<C> Name=���� ,    ID=DISEASE_NAME,	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left</C> 
												<C> Name=���᳻��	,ID=TREAT_CONTENT, HeadAlign=Center HeadBgColor=#B9D4DC Width=290 align=left</C> 
												<C> Name=���	,    ID=MEDI_FEE,      HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right</C> 
												<C> Name=��������	,ID=CALC_YN,       HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center</C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt8 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<!---------[TAB 9] �ٹ������� �׸���----------->
						<div id="layer9" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('09')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('09')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('09')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp09 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data09>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=Colsizing       value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO					ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=25,	align=center </F> 
												<C> Name=��������		ID=SUB_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center, Mask="XXXX/XX/XX"</C>
												<G> Name="�����ڵ�" HeadBgColor=#B9D4DC
												<C> Name=�⵵				ID=MAN_YY,	HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=center , 
												EditStyle=Combo,Data="07:07,08:08,09:09,10:10,11:11,12:12,13:13,14:14,15:15"</C> 
												<C> Name=����				ID=MAN_SEX,	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center , EditStyle=Combo,Data="M:��,F:��"</C> 
												<C> Name=�ٹ������� ID=MAN_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=left , EditStyle=Lookup,Data="gcds_CM008:COM_CODE:COM_SNAME" </C> 
												</G>
												<C> Name=���޳���		ID=SUP_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=left</C> 
												<G> Name="�ʻ���"		HeadBgColor=#B9D4DC
												<C> Name=����				ID=CLOTH_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=35		align=left , EditStyle=Lookup,Data="gcds_CM009:COM_CODE:COM_SNAME" </C> 
												<C> Name=������			ID=CLOTH_SIZE,	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=left , EditStyle=Lookup,Data="gcds_CM010:COM_CODE:COM_SNAME" </C> 
												</G>
												<C> Name=�ݳ���			ID=RTN_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=left , Mask="XXXX/XX/XX"</C>
												<C> Name=�ݳ�����		ID=RTN_RK,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=left</C>
												<C> Name=�ݳ�����		ID=RTN_RE,	HeadAlign=Center HeadBgColor=#B9D4DC Width=100		align=left</C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt9 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<!---------[TAB 10] ���� �׸���----------->
						<div id="layer10" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('10')">
										<img name="btn_add_3" src="<%=dirPath%>/Sales/images/plus.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('10')">
										<img name="btn_save_3" src="<%=dirPath%>/Sales/images/save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save('10')">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp10 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data10>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO				  ID={CurRow}   HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	 align=center </F> 
												<C> Name=���������� ID=START_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	   align=center, Mask="XXXX/XX/XX"</C>
												<C> Name=���������� ID=END_DT,	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		 align=left ,  Mask="XXXX/XX/XX"</C> 
												<C> Name=��������		ID=EDU_CD,	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=left ,  EditStyle=Lookup,Data="gcds_CM011:COM_CODE:COM_SNAME" </C> 
												<C> Name=�̼�����		ID=EDU_YN,	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		 align=left    EditStyle=Lookup,Data="gcds_CM031:COM_CODE:COM_SNAME"</C> 
												<C> Name=��������		ID=EDU_CO,	  HeadAlign=Center HeadBgColor=#B9D4DC Width=260	 align=left</C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt10 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>
						<!---------[TAB 11] ��� �׸���----------->
						<div id="layer11" style="position:absolute; top:364px; left:350px; visibility:hidden; border:1 solid #708090">
							<table cellpadding=0 cellspacing=0 border=0 >
								<tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_DeuQuery()">
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639;border:0 solid #708090;border-top-width:1px" colspan="2">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_disp11 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
											style="width:647;height:179">
												<param name=dataid					value=gcds_data11>
												<param Name=BorderStyle			value=0> 
												<param name=indwidth        value=0>
												<param name=fillarea        value=true>
												<param name=Editable        value=true>
												<param name=AllShowEdit     value=true>
												<param name=headlinecolor   value=#999999>
												<param name=format          value='
												<F> Name=NO				ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30,	    align=center </F> 
												<C> Name=�������� ID=START_DT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center, Mask="XXXX/XX/XX"</C>
												<C> Name=��ุ���� ID=END_DT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center, Mask="XXXX/XX/XX"</C> 
												<C> Name=��౸��   ID=CONT_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center,</C> 
												<C> Name=�ټӳ���   ID=CON_YEARNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center,</C> 
												<C> Name=���				ID=REMARK		  HeadAlign=Center HeadBgColor=#B9D4DC Width=300	align=left</C> 
												'>
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:639;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
											&nbsp;<font id=ft_cnt11 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</div>


<!-- ����Ÿ���ε� ���Ǻκ� -->
						<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
						<PARAM NAME="DataID"				VALUE="gcds_data00">
						<PARAM NAME="ActiveBind"		VALUE="true">
						<PARAM NAME="BindInfo"			VALUE="
								<C>Col=USTS           			Ctrl=txt_usts								Param=value</C>
								<C>Col=EMPNMK           		Ctrl=gcem_empnmk						Param=Text</C>
								<C>Col=EMPNMC           		Ctrl=gcem_empnmc						Param=Text</C>
								<C>Col=ENG_NM          			Ctrl=gcem_eng_nm						Param=Text</C>
								<C>Col=EMPNO            		Ctrl=txt_empno							Param=value</C>
								<C>Col=BIRTHDAY         		Ctrl=gcem_birthday					Param=Text</C>
								<C>Col=SEX              		Ctrl=gcra_sex								Param=codevalue</C>
								<C>Col=NATION_CD        		Ctrl=gclx_nation_cd					Param=bindcolval</C>
								<C>Col=START_DT         		Ctrl=gcem_start_dt					Param=Text</C>
								<C>Col=JOB_CD           		Ctrl=gclx_job_cd						Param=bindcolval</C>
								<C>Col=AGENCY_CD        		Ctrl=gclx_agency_cd					Param=bindcolval</C>
								<C>Col=VEND_CD          		Ctrl=gclx_vend_cd						Param=bindcolval</C>
								<C>Col=DEPT_CD          		Ctrl=gclx_dept_cd						Param=bindcolval</C>
								<C>Col=TEAM_CD          		Ctrl=gclx_team_cd						Param=bindcolval</C>
								<C>Col=WORK_CD          		Ctrl=gclx_work_cd						Param=bindcolval</C>
								<C>Col=SKILL_CD         		Ctrl=gclx_skill_cd					Param=bindcolval</C>
								<C>Col=COUNTRY_CD       		Ctrl=gclx_country_cd				Param=bindcolval</C>
								<C>Col=CON_YEAR         		Ctrl=gcem_con_year					Param=Text</C>
								<C>Col=CUST_SID        			Ctrl=gcem_cust_sid 					Param=Text</C>
								<C>Col=BIRTHDAY        			Ctrl=gcem_birthday 					Param=Text</C>
								<C>Col=PASS_NO         			Ctrl=gcem_pass_no 					Param=Text</C>
								<C>Col=PASS_EXPIRE_DATE			Ctrl=gcem_pass_epdate 			Param=Text</C>
								<C>Col=N_CARD_NO       			Ctrl=gcem_n_card_no 				Param=Text</C>
								<C>Col=ZIP_CD								Ctrl=txt_zipcd		 					Param=Value</C>
								<C>Col=ADDRESS1							Ctrl=txt_address1 					Param=Value</C>
								<C>Col=TEL_NO								Ctrl=txt_tel_no   					Param=Value</C>
								<C>Col=MOBILE_NO						Ctrl=txt_mobile_no					Param=Value</C>
								<C>Col=HEIGHT								Ctrl=gcem_height   					Param=text</C>
								<C>Col=WEIGHT								Ctrl=gcem_weight   					Param=text</C>
								<C>Col=SIZE_UP							Ctrl=txt_size_up  					Param=Value</C>
								<C>Col=SIZE_DN							Ctrl=txt_size_dn  					Param=Value</C>
								<C>Col=SIZE_FT							Ctrl=gcem_size_ft  					Param=text</C>
								<C>Col=SIZE_WT							Ctrl=gcem_size_wt  					Param=text</C>
								<C>Col=BLOOD								Ctrl=gcem_blood    					Param=text</C>
								<C>Col=ORD_CD								Ctrl=gclx_ord_cd    				Param=bindcolval</C>
								<C>Col=END_DT								Ctrl=gcem_end_dt  				  Param=text</C>
								<C>Col=CHGYMD								Ctrl=gcem_chgymd    				Param=text</C>
								<C>Col=C_VEND_CD						Ctrl=gclx_c_vend_cd   			Param=bindcolval</C>
								<C>Col=CHI_NM								Ctrl=txt_chi_nm    				  Param=value</C>
								<C>Col=CHI_RNM							Ctrl=txt_chi_rnm    				Param=value</C>
								<C>Col=CHI_TEL							Ctrl=txt_chi_tel    				Param=value</C>
								<C>Col=CHI_ADD							Ctrl=txt_chi_add    			  Param=value</C>
								<C>Col=SCH_FR								Ctrl=gcem_sch_fr    				Param=text</C>
								<C>Col=SCH_TO								Ctrl=gcem_sch_to    				Param=text</C>
								<C>Col=ATT_CD								Ctrl=gclx_att_cd    				Param=bindcolval</C>
								<C>Col=SCH_NM								Ctrl=txt_sch_nm    				  Param=value</C>
								<C>Col=HOBBY								Ctrl=txt_hobby   				    Param=value</C>
								<C>Col=SPC_NM								Ctrl=txt_spc_nm   				  Param=value</C>
								<C>Col=B_PAY								Ctrl=gcem_b_pay    				  Param=text</C>
								<C>Col=PICTURE							Ctrl=gcip_file    				  Param=value</C>
								<C>Col=REM_BNK							Ctrl=gclx_rem_bnk 				  Param=bindcolval</C>
								<C>Col=SAV_NM								Ctrl=txt_sav_nm   				  Param=value</C>
								<C>Col=SAV_TEL							Ctrl=txt_sav_tel   				  Param=value</C>
								<C>Col=REM_ACC							Ctrl=txt_rem_acc   				  Param=value</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>

<!-- �⺻�� -->
					<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data12 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
							<PARAM NAME="DataID"				VALUE="gcds_data12">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
							<C>Col=ZIP_ADD 				Ctrl=txt_address1 					Param=Value</C>
							
							<C>Col=TEL_NO   			Ctrl=txt_tel_no   					Param=Value</C>
							<C>Col=MOBILE_NO			Ctrl=txt_mobile_no					Param=Value</C>
							<C>Col=HEIGHT   			Ctrl=gcem_height   					Param=text</C>
							<C>Col=WEIGHT   			Ctrl=gcem_weight   					Param=text</C>
							<C>Col=SIZE_UP  			Ctrl=txt_size_up  					Param=Value</C>
							<C>Col=SIZE_DN  			Ctrl=txt_size_dn  					Param=Value</C>
							<C>Col=SIZE_FT  			Ctrl=gcem_size_ft  					Param=text</C>
							<C>Col=SIZE_WT  			Ctrl=gcem_size_wt  					Param=text</C>
							<C>Col=BLOOD    			Ctrl=gcem_blood    					Param=text</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%> -->
				</td>
			</tr>
	</table><!-- ���� ���̺� ��� ��-->
</td>
</tr>
</table>

<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F >
	<PARAM NAME="MasterDataID"			VALUE="gcds_report0">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="0">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=992 ,face='����' ,size=10 ,penwidth=1
	<X>left=389 ,top=931 ,right=1934 ,bottom=992 ,border=true</X>
	<X>left=106 ,top=550 ,right=201 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=550 ,right=392 ,bottom=614 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=614 ,right=392 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=741 ,right=392 ,bottom=868 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=868 ,right=392 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=868 ,right=1934 ,bottom=931 ,border=true</X>
	<X>left=929 ,top=931 ,right=1114 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=931 ,right=574 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=868 ,right=574 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=804 ,right=1934 ,bottom=868 ,border=true</X>
	<X>left=389 ,top=741 ,right=1934 ,bottom=804 ,border=true</X>
	<X>left=929 ,top=741 ,right=1114 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=741 ,right=574 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=804 ,right=574 ,bottom=868 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=677 ,right=1934 ,bottom=741 ,border=true</X>
	<X>left=389 ,top=677 ,right=574 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=614 ,right=1934 ,bottom=677 ,border=true</X>
	<X>left=574 ,top=206 ,right=1934 ,bottom=273 ,border=true</X>
	<X>left=389 ,top=550 ,right=1934 ,bottom=614 ,border=true</X>
	<X>left=108 ,top=206 ,right=389 ,bottom=540 ,border=true</X>
	<X>left=574 ,top=474 ,right=1934 ,bottom=540 ,border=true</X>
	<X>left=923 ,top=474 ,right=1109 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=273 ,right=1934 ,bottom=341 ,border=true</X>
	<X>left=923 ,top=273 ,right=1109 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=341 ,right=1934 ,bottom=407 ,border=true</X>
	<X>left=1450 ,top=206 ,right=1635 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=1455 ,top=212 ,right=1630 ,bottom=267 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�ٷ��� ���� ����' ,left=108 ,top=19 ,right=1934 ,bottom=122 ,face='HY�߰��' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=389 ,top=206 ,right=574 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=394 ,top=212 ,right=569 ,bottom=267 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=273 ,right=574 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='���ǹ�ȣ' ,left=394 ,top=275 ,right=569 ,bottom=331 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=341 ,right=574 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=407 ,right=1934 ,bottom=474 ,border=true</X>
	<X>left=389 ,top=407 ,right=574 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=474 ,right=574 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='EMPNMK', left=585, top=212, right=794, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=1640, top=212, right=1868, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�������' ,left=929 ,top=280 ,right=1103 ,bottom=336 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=273 ,right=1635 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=1455 ,top=278 ,right=1630 ,bottom=333 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='���Ǹ�����' ,left=394 ,top=347 ,right=569 ,bottom=402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=341 ,right=1109 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�Ի���' ,left=929 ,top=347 ,right=1103 ,bottom=402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=341 ,right=1635 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�����' ,left=1455 ,top=347 ,right=1630 ,bottom=402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=394 ,top=413 ,right=569 ,bottom=468 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=407 ,right=1109 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=929 ,top=413 ,right=1103 ,bottom=468 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=407 ,right=1635 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='����븮��' ,left=1455 ,top=413 ,right=1630 ,bottom=468 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�Ի籸��' ,left=394 ,top=476 ,right=569 ,bottom=532 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=929 ,top=476 ,right=1103 ,bottom=532 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=474 ,right=1635 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=1455 ,top=476 ,right=1630 ,bottom=532 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='����' ,left=111 ,top=736 ,right=196 ,bottom=794 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�⺻' ,left=111 ,top=691 ,right=196 ,bottom=746 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=550 ,right=574 ,bottom=614 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<I>id='PIC_DIR' ,left=111 ,top=209 ,right=389 ,bottom=540</I>
	<T>id='��  ��' ,left=405 ,top=556 ,right=553 ,bottom=609 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='EMPNMC', left=796, top=212, right=1005, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=585, top=280, right=905, bottom=336, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORD_NM', left=585, top=479, right=905, bottom=534, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_EXPIRE_DATE', left=585, top=347, right=905, bottom=402, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TEAM_NM', left=585, top=413, right=905, bottom=468, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BIRTHDAY', left=1117, top=280, right=1437, bottom=336, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX_NM', left=1640, top=280, right=1926, bottom=336, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_DT', left=1117, top=347, right=1437, bottom=402, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='END_DT', left=1640, top=347, right=1926, bottom=402, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1117, top=413, right=1437, bottom=468, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AGENCY_NM', left=1640, top=413, right=1926, bottom=468, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTRY_NM', left=1117, top=479, right=1437, bottom=534, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NATION_NM', left=1640, top=479, right=1926, bottom=534, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=582, top=556, right=1918, bottom=611, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ⱹ��' ,left=212 ,top=556 ,right=378 ,bottom=611 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='CHI_ADD', left=582, top=616, right=1918, bottom=672, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=389 ,top=614 ,right=574 ,bottom=677 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=405 ,top=616 ,right=553 ,bottom=669 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=405 ,top=680 ,right=553 ,bottom=733 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�߱���' ,left=225 ,top=627 ,right=355 ,bottom=683 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=929 ,top=677 ,right=1114 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=942 ,top=680 ,right=1090 ,bottom=736 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=677 ,right=1640 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='����ó' ,left=225 ,top=672 ,right=355 ,bottom=730 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='ATT_NM', left=582, top=870, right=902, bottom=926, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCH_FRTO', left=1122, top=873, right=1442, bottom=929, align='left' ,mask='XXXX/XX~XXXX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1455 ,top=868 ,right=1640 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=929 ,top=868 ,right=1114 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��Ÿ����' ,left=209 ,top=910 ,right=376 ,bottom=966 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�����з�' ,left=405 ,top=870 ,right=553 ,bottom=923 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=405 ,top=934 ,right=553 ,bottom=987 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=942 ,top=870 ,right=1090 ,bottom=926 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='ü  ��' ,left=942 ,top=934 ,right=1090 ,bottom=990 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=931 ,right=1640 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�۱�����' ,left=402 ,top=743 ,right=550 ,bottom=796 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='������' ,left=942 ,top=746 ,right=1090 ,bottom=799 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=741 ,right=1640 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�۱�����' ,left=209 ,top=783 ,right=376 ,bottom=839 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�۱ݰ���' ,left=402 ,top=810 ,right=550 ,bottom=863 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��ȭ��ȣ' ,left=1474 ,top=680 ,right=1622 ,bottom=736 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��ȭ��ȣ' ,left=1476 ,top=743 ,right=1625 ,bottom=796 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='Ư  ��' ,left=1476 ,top=934 ,right=1625 ,bottom=990 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=1476 ,top=870 ,right=1625 ,bottom=926 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='HOBBY', left=1648, top=870, right=1921, bottom=926, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPC_NM', left=1648, top=934, right=1921, bottom=990, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_NM', left=582, top=683, right=902, bottom=738, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_RNM', left=1122, top=683, right=1442, bottom=738, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_TEL', left=1648, top=683, right=1921, bottom=738, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SAV_NM', left=1122, top=746, right=1442, bottom=802, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SAV_TEL', left=1648, top=746, right=1921, bottom=802, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REM_BNK_NM', left=582, top=746, right=902, bottom=802, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REM_ACC', left=582, top=810, right=1439, bottom=865, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='cm' ,left=661 ,top=937 ,right=709 ,bottom=992 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HEIGHT', left=582, top=937, right=656, bottom=992, align='right' ,mask='XXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='WEIGHT', left=1122, top=937, right=1196, bottom=992, align='right' ,mask='XXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='kg' ,left=1201 ,top=937 ,right=1249 ,bottom=992 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENG_NM', left=1008, top=212, right=1437, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUR_DT', left=1601, top=151, right=1934, bottom=206, align='right' ,mask='��������:XXXX/XX/XX'</C>
</B>


<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=165 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=162 ,DetailDataID=gcds_report2
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ٹ���' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ҽ�' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�߷ɱ���' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�߷�����' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� �� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=489 ,top=0 ,right=489 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<C>id='ORD_NM', left=495, top=3, right=736, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TEAM_NM', left=749, top=3, right=1143, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='WORK_NM', left=1156, top=3, right=1524, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOB_NM', left=1535, top=3, right=1924, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORD_DT', left=217, top=3, right=479, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='family.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report3
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='���' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�������' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��  ��' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� �� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=111, top=0, right=204, bottom=56, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FAMI_NM', left=222, top=0, right=482, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='BIRTHDAY', left=495, top=0, right=733, bottom=56 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOB_NM', left=751, top=0, right=1146, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REF_NM', left=1162, top=0, right=1519, bottom=56, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=1537, top=0, right=1921, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=489 ,top=0 ,right=489 ,bottom=61 </L>
		</B>
	</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdorder.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report4
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1580 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=624 ,top=66 ,right=931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �Ի������' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=931 ,top=66 ,right=1220 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����' ,left=960 ,top=69 ,right=1188 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1220 ,top=66 ,right=1580 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��������' ,left=1603 ,top=69 ,right=1905 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=212 ,top=66 ,right=418 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ի���' ,left=220 ,top=69 ,right=415 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=418 ,top=66 ,right=624 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�����' ,left=421 ,top=69 ,right=611 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='ȸ���' ,left=630 ,top=69 ,right=908 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='������' ,left=1257 ,top=69 ,right=1556 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=418 ,top=0 ,right=418 ,bottom=61 </L>
			<L> left=624 ,top=0 ,right=624 ,bottom=61 </L>
			<L> left=931 ,top=0 ,right=931 ,bottom=61 </L>
			<L> left=1580 ,top=0 ,right=1580 ,bottom=61 </L>
			<L> left=1220 ,top=0 ,right=1220 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=220, top=3, right=413, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=423, top=3, right=616, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COMPNM', left=630, top=3, right=923, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='POSINM', left=937, top=3, right=1212, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DUTYNM', left=1225, top=3, right=1572, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REAMRK', left=1585, top=3, right=1926, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report5
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����ó' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����ȣ' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�ڰ�����' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�ڰݸ��㱸��' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�������' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� �� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GET_DT', left=220, top=3, right=479, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_TYPE_NM', left=492, top=3, right=733, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_CD_NM', left=749, top=3, right=1138, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_NO', left=1156, top=3, right=1513, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ISS_PART', left=1535, top=3, right=1916, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area6 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='vacation.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report6
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�ް�����' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ް��ϼ�' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�Ҽ�' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� �� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=820 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�ް�������' ,left=833 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=820 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�ް�������' ,left=497 ,top=69 ,right=807 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=820 ,top=0 ,right=820 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TEAM_NM', left=220, top=3, right=482, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=495, top=3, right=810, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=831, top=3, right=1138, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='H_DAY', left=1164, top=3, right=1513, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='H_RES', left=1537, top=3, right=1921, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area7 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='award.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report7
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�������' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='���޳��' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�����' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�������' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� �� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RCV_DT', left=225, top=3, right=476, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_NM', left=495, top=3, right=728, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_AMT', left=759, top=3, right=1138, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PAY_DT', left=1162, top=3, right=1516, bottom=58 ,mask='XXXX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_RK', left=1540, top=3, right=1921, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='cloth.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report9
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1580 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1013 ,top=66 ,right=1220 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=706 ,top=66 ,right=1013 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�� �� �� �� ' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=1220 ,top=66 ,right=1580 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=418 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��������' ,left=220 ,top=69 ,right=415 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='���޳���' ,left=712 ,top=69 ,right=990 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ݳ���' ,left=1257 ,top=69 ,right=1556 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ʻ���' ,left=1027 ,top=69 ,right=1217 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=418 ,top=66 ,right=706 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='�����ڵ�' ,left=442 ,top=69 ,right=669 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ݳ�����' ,left=1603 ,top=69 ,right=1905 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=418 ,top=0 ,right=418 ,bottom=61 </L>
			<L> left=1580 ,top=0 ,right=1580 ,bottom=61 </L>
			<L> left=1220 ,top=0 ,right=1220 ,bottom=61 </L>
			<L> left=706 ,top=0 ,right=706 ,bottom=61 </L>
			<L> left=1013 ,top=0 ,right=1013 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUB_DT', left=220, top=3, right=413, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MAN_NM', left=426, top=3, right=699, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUP_NM', left=714, top=3, right=1005, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CLOTH_NM', left=1019, top=3, right=1214, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RTN_DT', left=1225, top=3, right=1572, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RTN_RE', left=1585, top=3, right=1929, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
		</B>
	</R>
</A>

<A>id=Area10 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='education.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report10
	   <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��������' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�̼�����' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��������' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='����������' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='����������' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_CO', left=1537, top=0, right=1921, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=220, top=3, right=482, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=495, top=3, right=730, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_CD_NM', left=754, top=3, right=1135, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_YN_NM', left=1162, top=3, right=1527, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area11 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=����ü,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='contract.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report11
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='���' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�ټӳ���' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��౸��' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='��ุ����' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='��������' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='�� �� ��' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY�߰��' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=0, right=206, bottom=56, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=222, top=0, right=479, bottom=56 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=497, top=3, right=738, bottom=58 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CONT_NM', left=751, top=3, right=1143, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CON_YEARNM', left=1159, top=3, right=1521, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=1537, top=3, right=1924, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=2680 ,right=2000 ,bottom=2870 ,face='����' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=108 ,top=85 ,right=1934 ,bottom=164</T>
	<L> left=108 ,top=74 ,right=1934 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../common/img/icon.jpg' ,left=1487 ,top=85 ,right=1868 ,bottom=175</I>
</B>

">
</OBJECT><%=HDConstant.COMMENT_END%>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


