
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());			
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
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : ���� �η� �λ���� - �߷ɰ���
+ ���α׷�ID : ks_em011i.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2008.09.04
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em011_S1
----------------------------------------------------------------------------------*/
%>
	 
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';
	var year_date = gs_date.substring(2,4);
	var chk_tab = "";
	
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
	function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		ln_before();//����ȸ

		//fnInit(); //�ʱ�ȭ �Լ�
	}

	/*----------------------------------------------------------------------------
	* ����Ÿ�� ��� ����	 
	----------------------------------------------------------------------------*/
	function fnSetHeader(){

	}
	/*----------------------------------------------------------------------------
	 * ����ȸ
	 ----------------------------------------------------------------------------*/
	function fnInit(){
	
		//*****  ������ �ʱ�ȭ �Լ��� ���⿡..  ********
    
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
    
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.
	
	}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
	Parameter : 
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em011_S1?"
											 + "v_str1="+fn_trim(txt_empno.value)
											 + "&v_str2="++fn_trim(txt_empnmk.value) 
											 + "&v_str3="gclx_dept_cd_s.bindcolval
                       						+ "&v_str4="+chk_s.value;

	gcds_data01.Reset();
	gcds_data02.ClearAll();
}


/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//�Ҽ��� �˻�  CM003
	//�μ�  CM006
	gcds_cm006_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006_s.Reset();

	gcds_cm003_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003_s.Reset();
  //�Է�
	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();
	//�ٹ���ü  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();
	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
	//�ٹ���  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();
	//�߷ɱ���
	gcds_cm012.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM012";
	gcds_cm012.Reset();
	//��ɱ���
	gcds_cm013.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM013";
	gcds_cm013.Reset();
	//��������
	gcds_cm032.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032.Reset();

	//��������
	gcds_cm032_g.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032_g.Reset();

  //���δ��ü
	gcds_tsy010.DataID = "<%=dirPath%>/servlet/sales.bm.Company_pop_s01?v_str1="; 
	gcds_tsy010.Reset();

  ln_ChkBox_Chk(0);
	ln_ChkBox_Chk(1);
	ln_ChkBox_Chk(2);
	ln_ChkBox_Chk(3);
	ln_Enable2();
  gcem_ord_dt.text=gs_date;

}
/******************************************************************************
	Description : �ŷ�ó�߰�
******************************************************************************/
function ln_Add(){

}

/*****************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Save(){
	if (gcds_data01.IsUpdated) {
		if(confirm("�����Ͻðڽ��ϱ�?")){
			gctr_data.KeyValue = "Em011_t1(I:USER=gcds_data02)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em011_t1?";
			//prompt(this,gcds_data02.text);
			gctr_data.post();
		}			
	}
}
/******************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Del(){
	gcds_data02.DeleteRow(gcds_data02.rowposition);
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_Start_Load(){
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
  document.all.LowerFrame.style.visibility="visible";
}

/******************************************************************************
	Description : Loading Bar 
******************************************************************************/
function ln_End_Load(row,cnt){
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	eval(cnt).innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
}

/******************************************************************************
	Description : �߷ɴ���� ���� �� �߷ɻ���
******************************************************************************/
function ln_Order(){
  var chk=0;
	if(!ln_Order_Chk()) return;
	ln_SetDataHeader();
	for(i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			chk = 1;
			gcds_data02.addrow();
			//��������Ÿ ����.
			gcds_data02.namevalue(gcds_data02.rowposition,"EMPNO") = gcds_data01.namevalue(i,"EMPNO");
			gcds_data02.namevalue(gcds_data02.rowposition,"EMPNMK") = gcds_data01.namevalue(i,"EMPNMK");
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD") = gcds_data01.namevalue(i,"VEND_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM") = gcds_data01.namevalue(i,"VEND_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD") = gcds_data01.namevalue(i,"DEPT_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM") = gcds_data01.namevalue(i,"DEPT_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_CD") = gcds_data01.namevalue(i,"TEAM_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_NM") = gcds_data01.namevalue(i,"TEAM_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD") = gcds_data01.namevalue(i,"WORK_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM") = gcds_data01.namevalue(i,"WORK_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_CD") = gcds_data01.namevalue(i,"SKILL_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_NM") = gcds_data01.namevalue(i,"SKILL_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD") = gcds_data01.namevalue(i,"JOB_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM") = gcds_data01.namevalue(i,"JOB_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"CUST_SID") = gcds_data01.namevalue(i,"CUST_SID");
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD") = gcds_data01.namevalue(i,"C_VEND_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM") = gcds_data01.namevalue(i,"C_VEND_NM");
			gcds_data02.namevalue(gcds_data02.rowposition,"I_EMPNO") = gusrid;
			gcds_data02.namevalue(gcds_data02.rowposition,"U_EMPNO") = gusrid;

			//******************************�űԹ߷��� �߰��Ѵ�.
			//�߷ɱ���
      gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD") = gclx_ord_cd.bindcolval;
			gcds_data02.namevalue(gcds_data02.rowposition,"ORD_NM") = gclx_ord_cd.text;
			//�߷�����
      gcds_data02.namevalue(gcds_data02.rowposition,"ORD_DT") = gcem_ord_dt.text;
			
      //
      if(chk1.checked){ 
				//�ٹ���ü
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD")=gclx_vend_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM")=gclx_vend_cd.text;
			  //�μ�
				gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD")=gclx_dept_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM")=gclx_dept_cd.text;
		 	  //�Ҽ���
				gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_CD")=gclx_team_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"TEAM_NM")=gclx_team_cd.text;
			  //�ٹ���
				gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD")=gclx_work_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM")=gclx_work_cd.text;
				//����ü
				gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD")=gclx_c_vend_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM")=gclx_c_vend_cd.text;
			}

      if(chk2.checked){
				//�߷�����
				gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD")=gclx_job_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM")=gclx_job_cd.text;
				//��ɱ���
				gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_CD")=gclx_skill_cd.bindcolval;
				gcds_data02.namevalue(gcds_data02.rowposition,"SKILL_NM")=gclx_skill_cd.text;
			} 	
			
			if(gclx_ord_cd.bindcolval=="007"){ //����ϰ��
				gcds_data02.namevalue(gcds_data02.rowposition,"RETGB") = gclx_retgb_cd.bindcolval;
				if(blchk.checked==true){
					blchk.value="Y";
				}else{
					blchk.value="";
				}
				gcds_data02.namevalue(gcds_data02.rowposition,"BLCHK") = blchk.value;
			}
		}
	}
	
	if(chk==0){
		alert("�߷ɴ���ڸ� �����Ͻʽÿ�.");
	}
}


/******************************************************************************
	Description : �߷� üũ

******************************************************************************/
function ln_Order_Chk(){
	
  if(gclx_ord_cd.bindcolval=="007"){ //����ϰ�� üũ����.
		if(gclx_retgb_cd.bindcolval==""){
			alert("�ͱ������� �����Ͻʽÿ�.");
			return false;
		}
	}else{
		if(chk1.value !="T"&&chk2.value!="T"){
			alert("�μ����� �Ǵ� ���������� ���� �����Ͻʽÿ�.");
			return false;
		}

		if(chk1.value=="T"){
			if(gclx_vend_cd.bindcolval==""){
				alert("�ٹ���ü�� ���� �����Ͻʽÿ�.");
				return false;
			}

			if(gclx_dept_cd.bindcolval==""){
				alert("�μ��� ���� �����Ͻʽÿ�.");
				return false;
			}

			if(gclx_team_cd.bindcolval==""){
				alert("�Ҽ����� ���� �����Ͻʽÿ�.");
				return false;
			}

      if(gclx_c_vend_cd.bindcolval==""){
				alert("����ü�� ���� �����Ͻʽÿ�.");
				return false;
			}
		}
		
		if(chk2.value=="T"){
			if(gclx_job_cd.bindcolval==""){
				alert("�߷������� ���� �����Ͻʽÿ�.");
				return false;
			}
		}
	}
	return true;
}


/******************************************************************************
	Description : �߷� ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data02.countrow<1){
		var s_temp = " EMPNO:STRING(10),EMPNMK:STRING(30),ORD_DT:STRING(8),ORD_CD:STRING(3),ORD_NM:STRING(50),"
							 + " VEND_CD:DECIMAL(10),VEND_NM:STRING(50),DEPT_CD:STRING(5),DEPT_NM:STRING(50),TEAM_CD:STRING(5),"
							 + " TEAM_NM:STRING(50),WORK_CD:STRING(5),WORK_NM:STRING(50),SKILL_CD:STRING(3),SKILL_NM:STRING(50),"
							 + " JOB_CD:STRING(5),JOB_NM:STRING(50),SEQ:DECIMAL(2),CUST_SID:DECIMAL(10),"
							 + " I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10),"
							 + " C_VEND_CD:DECIMAL(10),C_VEND_NM:STRING(62),RETGB:STRING(2),BLCHK:STRING(1)";
		gcds_data02.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : üũ�ڽ�����
	Parameter   : gbn  0 - �˻����� �����
	                   1 - �μ�����
								     2 - ��������
										 3 - black list
******************************************************************************/
function ln_ChkBox_Chk(gbn){
	if(gbn==0){
		if(chk_s.checked) {
			chk_s.value = '3';
		}else {
			chk_s.value = '1'
    }
	}else if(gbn==1){
		if(chk1.checked) {
			chk1.value = 'T';
			ln_Enable(gbn,true);
		}else {
			chk1.value = ''
			ln_Enable(gbn,false);
			gclx_vend_cd.index = 0;
			gclx_dept_cd.index = 0;
			gclx_team_cd.index = 0;
			gclx_work_cd.index = 0;
			gclx_c_vend_cd.index = 0;
		}
	}else if(gbn==2){
    if(chk2.checked) {
			chk2.value = 'T';
			ln_Enable(gbn,true);
		}else {
			chk2.value = ''
			ln_Enable(gbn,false);
      gclx_job_cd.index = 0;
		  gclx_skill_cd.index = 0;
		}
	}else if(gbn==3){
    if(gclx_ord_cd.bindcolval=="007"){ //�����
      ln_Enable(gbn,true);
		}else{ //����ڰ� �ƴ� ���
		  ln_Enable(gbn,false);
			gclx_retgb_cd.bindcolval ="";
		}
	}
}

/*=============================================================================
		Description : �߷� ���� �����޺� �������
=============================================================================*/
function ln_Enable(gbn,gbn2){
	if(gbn==1){ //
		gclx_vend_cd.Enable = gbn2;
		gclx_dept_cd.Enable = gbn2;
		gclx_team_cd.Enable = gbn2;
		gclx_work_cd.Enable = gbn2;
		gclx_c_vend_cd.Enable = gbn2;
	}else if(gbn==2){
    gclx_job_cd.Enable = gbn2;
		//gclx_skill_cd.Enable = gbn2;
		gclx_skill_cd.Enable = false;
	}else if(gbn==3){
    gclx_retgb_cd.Enable = gbn2;
		if(gbn2==false){
			blchk.disabled=true;
		}else{
      blchk.disabled=false;
		}
	}
}

/*=============================================================================
		Description : �ͱ����п� ���� �������
=============================================================================*/
function ln_Enable2(){
	if(gclx_retgb_cd.bindcolval=="01"){       //����
		blchk.checked =false;
		blchk.disabled=false;
		blchk.value="";
  }else if(gclx_retgb_cd.bindcolval=="02"){ //����
    blchk.checked =true;
		blchk.disabled=true;
		blchk.value="Y";
	}else if(gclx_retgb_cd.bindcolval=="03"){ //¡��
    blchk.checked =true;
		blchk.disabled=true;
		blchk.value="Y";
	}else{
		blchk.checked =false;
		blchk.disabled=true;
		blchk.value="";
	}
}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Excel(){
    var szName1 = "�߷ɴ���ڼ���";
    //var szName2 = "�߷�";
    var szPath = "C:\\Test\\em011i.xls";
       if (gcds_data01.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
          //gcgd_disp2.RunExcelSheet(szName2,szPath,2)
       }
   }
</script>
<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>
    
<%
/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/
%>
<script language=JavaScript for=gclx_job_cd event=OnSelChange()>
	for(i=1;i<=gcds_cm013.countrow;i++){
		if(gcds_cm013.namevalue(i,"COM_CODE")==gcds_cm004.namevalue(gcds_cm004.rowposition,"ITEM2")){
      gclx_skill_cd.index=i-1;
			break;
		}
	}
</script>

<script language=JavaScript for=gclx_ord_cd event=OnSelChange()>
	if(gclx_ord_cd.bindcolval=="007"){ //���
		ln_Enable('3',true);
		gclx_retgb_cd.index=1;
  }else{
    ln_Enable('3',false);
		gclx_retgb_cd.index=0;
	}
</script>

<script language=JavaScript for=gclx_retgb_cd event=OnSelChange()>
	ln_Enable2();
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/

///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����-TR1
%>
	<script language="javascript" for="gctr_data" event="onsuccess()">
		 alert("���忡 �����Ͽ����ϴ�");
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����-TR1
%>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
</script>

<script language="javascript" for="gcds_cm006_s" event="onloadCompleted(row,colid)">
	ln_Insert_Row(2,"gcds_cm006_s","gclx_dept_cd_s");
</script>

<script language="javascript" for="gcds_cm003_s" event="onloadCompleted(row,colid)">
	ln_Insert_Row(2,"gcds_cm003_s","gclx_team_cd_s");
</script>

<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
   ln_Insert_Row(1,"gcds_cm004","gclx_job_cd"); 
</script>

<script language="javascript" for="gcds_cm019" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm019","gclx_vend_cd");
</script>

<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm006","gclx_dept_cd");
</script>

<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm003","gclx_team_cd");
</script>

<script language="javascript" for="gcds_cm007" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm007","gclx_work_cd");
</script>

<script language="javascript" for="gcds_cm013" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm013","gclx_skill_cd");
</script>

<script language="javascript" for="gcds_tsy010" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_tsy010","gclx_c_vend_cd");
</script>

<script language="javascript" for="gcds_cm032" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm032","gclx_retgb_cd");
</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
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

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- ���� -->
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �ٹ���ü -->
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �μ� -->
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �Ҽ��� -->
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �ٹ��� -->
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �߷ɱ��� -->
<OBJECT id=gcds_cm012 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>'
<!-- ��ɱ���-->
<OBJECT id=gcds_cm013 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �ͱ�����-->
<OBJECT id=gcds_cm032 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm032_g classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �Ҽ��� _ �˻� -->
<OBJECT id=gcds_cm003_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_tsy010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black border=0><!-- body table -->
	<tr height="20px"><!-- ��ư ���� ����-->
		<td align="left" colspan="3">
			<table width="820" border="0"  cellspacing="0" cellpadding="0">
				<tr>
					<td align="right" height="30px">		
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"   	style="cursor:hand" onclick="ln_Excel()">
					</td>
				</tr>																		
			</table>
		</td>
	 </tr>
	 <tr height=20><!-- ��ȸ ���� ����-->
		<td>
			<table cellpadding=0 cellspacing=1 style="width:824px;height:20px;" bgcolor="#708090">
				<tr>
				  <td bgcolor="#eeeeee" width="70" align = center>�μ�</td>
					<td bgcolor="#FFFFFF">
					
									<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
									<%=HDConstant.COMMENT_START%>
									<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:90px;  height: 16px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="">
											<param name=PromptChar	  value="">
											<param name=UpperFlag     value=1>
											<param name=GeneralEdit   value="true">
											<param name=Enable        value="false">
									</OBJECT><%=HDConstant.COMMENT_END%>
									</fieldset>											
								 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
								</td>
								<td bgcolor="#eeeeee" width="70" align = center>�Ҽ���</td>
								<td bgcolor="#FFFFFF">
								<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
									class="gcem_01" style="width:90px;  height: 16px;">
										<param name=Alignment			value=0>
										<param name=Border	      value=false>
										<param name=Format	      value="">
										<param name=PromptChar	  value="">
										<param name=UpperFlag     value=1>
										<param name=GeneralEdit   value="true">
										<param name=Enable        value="false">
								</OBJECT><%=HDConstant.COMMENT_END%>
								</fieldset>											
							 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
							</td>

					<td align="center" width="70" bgcolor="#eeeeee">����</td>
					<td bgcolor="#FFFFFF">
					  <input type="text" id="txt_empnmk" style="position:relative;width:80px;left:2px;  top:0px;">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:2px;  top:1px; cursor:hand;" onclick="ln_Find()">
					  <input type="text" id="txt_empno" style="position:relative;left:2px;  top:1px; width:80px;">&nbsp;
					</td>
					<td align="center" width="70" bgcolor="#eeeeee">�����</td>
					<td bgcolor="#FFFFFF" width="70">
						<input type="checkbox" id=chk_s   value=""    style="position:relative;left:5px;top:0px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(0)" >
					</td>
				</tr>
			</table>
		  </td>
	    </tr>
		<tr>
			<td>
				<table cellpadding=0 cellspacing=1 style="width:290px;">
					<tr>
						<td valign="top">
							<font style="position:relative;top:0px;left:0px; color=#0000FF"><b>[�߷ɴ���� ����]</b></font>
							<table cellpadding=0 cellspacing=1 style="width:409px;" bgcolor="#708090">
								<tr>
									<td bgcolor="#FFFFFF">
										<%=HDConstant.COMMENT_START%>
										<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:405;height:380px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
										<PARAM NAME="DataID"	  VALUE="gcds_data01">
										<PARAM NAME="BorderStyle" VALUE="0">
										<PARAM NAME="Indwidth"	  VALUE="0">
										<PARAM NAME="Fillarea"	  VALUE="true">
										<param name="sortview"    value=left>
										<param name="colsizing"   value=true> 
										<param name=Editable      value="true">
										<PARAM NAME="Format"	  VALUE="  
										<FC>ID=CurRow,	Name=����,		width=30,  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center  edit=none value={CurRow}</FC>
										<FC>ID=CHK,		  Name=����,		width=30,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, EditStyle='CheckBox'</FC>
										<FC>ID=EMPNO,	  Name=���,		width=55,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none sort = true</FC>
										<FC>ID=EMPNMK,	Name=����,		width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</FC>
										<C>ID=VEND_NM,	Name=�ٹ���ü,width=90,  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=DEPT_NM,	Name=�μ���,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=TEAM_NM,	Name=�ҼӸ�,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=WORK_NM,	Name=�ٹ���,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=SKILL_NM, Name=��ɸ�,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=JOB_NM,	  Name=������,	width=90,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=C_VEND_NM,	  Name=���δ��ü,width=100,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										">
										</OBJECT><%=HDConstant.COMMENT_END%>
										<fieldset style="width:407;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top"><!-- �������̺� ���� -->
							<table cellpadding=0 cellspacing=1 style="width:410px;height:20px;">
								<tr>
									<td align="left"><nobr>
										<font style="position:relative;top:-10px;left:0px; color=#0000FF"><b>[�߷�]</b></font>&nbsp;
										<input type="checkbox" id=chk1   value=""        style="position:relative;top:-4px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(1)">
                    					<input type="text"		 id=chknm1 value="�μ�����"  style="position:relative;top:-4px;width:55px;border-width:0px" >
										<input type="checkbox" id=chk2   value=""          style=" position:relative;top:-4px;cursor:hand;width:20px" onClick="ln_ChkBox_Chk(2)">
                    					<input type="text"		 id=chknm2 value="��������"  style="position:relative;top:-4px;width:55px;border-width:0px" >
										<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Order()">
										<img src="<%=dirPath%>/Sales/images/minus.gif"     style="cursor:hand" onClick="ln_Del()" >		
										<img src="<%=dirPath%>/Sales/images/save.gif"		  style="cursor:hand" onClick="ln_Save()">
										<!-- <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()"> -->
										</nobr>
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1 style="width:410px;height:100px;" bgcolor="#708090">
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">�߷ɱ���</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												
												<td bgcolor="#eeeeee" align="center">�߷�����</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">�ٹ���ü</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">�μ�</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">�Ҽ���</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">�ٹ���</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">����ü</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>
												<td bgcolor="#eeeeee" align="center">����</td>
												<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:90px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT><%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
												</td>

											</tr>
										</table><!-- ���� ���̺� 1�� �� -->
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1  style="width:390px;height:290px;" bgcolor="#708090">
											<tr>
												<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
													<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2 style="width:405;height:249px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
													<PARAM NAME="DataID"		VALUE="gcds_data02">
													<PARAM NAME="BorderStyle"   VALUE="0">
													<PARAM NAME="Indwidth"		VALUE="0">
													<PARAM NAME="Fillarea"		VALUE="true">
													<param name="colsizing"   value=true> 
													<param name="sortview"      value=left>
													<PARAM NAME="Format"		VALUE="  
													<C>ID=EMPNO,	  Name=���,		  width=55,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
													<C>ID=EMPNMK,	  Name=����,		  width=60,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=ORD_NM,	  Name=�߷ɱ���,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=ORD_DT, 	Name=�߷�����,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true mask='XXXX/XX/XX'</C>
													<C>ID=VEND_NM,	Name=�ٹ���ü,	width=72,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=DEPT_NM,	Name=�μ�,		  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=TEAM_NM,	Name=�Ҽ���,	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=WORK_NM,	Name=�ٹ���,	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=JOB_NM,	  Name=����,	    width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=SKILL_NM,	Name=��ɱ���	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=C_VEND_NM,Name=����ü	  width=120, HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													">
													</OBJECT><%=HDConstant.COMMENT_END%>
													<fieldset style="width:408;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
														&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;"></font>
													</fieldset>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table><!-- ���� ���̺� �� -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>
