<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : ��� ����
+ ���α׷�ID : em016i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.11
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em016_S.java
----------------------------------------------------------------------------------*/
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
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());		
%>
<!-- HTML ����-->
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
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
	/*
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	
	var gs_date ='<%=firstday%>';
	var gs_date1 =gs_date.substring(0,6);
	var gs_date2 =gs_date;
	
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			//gcem_start_fr.Text = gs_date1+'01';
			//gcem_start_to.Text = gs_date2;
			//gcem_end_ym.Text = gs_date1;
		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em016_S1"
									 + "?v_str1=" + gclx_dept_cd_s.bindcolval	  // �μ�         
									 + "&v_str2=" + gclx_team_cd_s.bindcolval	  // �Ҽ�         
									 + "&v_str3=" + txt_empno_s.value			      // ���         
									 + "&v_str4=" + txt_empnmk_s.value			    // ����         
									 + "&v_str5=" + gclx_contgb_cd_s.bindcolval // ��౸��     
									 + "&v_str6=" + fn_trim(gcem_end_ym.text)   // ��ุ���� 
									 + "&v_str7=" + fn_trim(gcem_start_fr_s.text)  // �������_fr  
									 + "&v_str8=" + fn_trim(gcem_start_to_s.text) // �������_to  
									 + "&v_str9=" + fn_trim(gclx_close_yn.bindcolval); // ��������  
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();

  if(gcem_end_ym.text!=""){
		ln_Date_Add(gcem_end_ym.text+"01");  //�ް��̽ǽú�����, �����޳�� 
	}
}
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){
	
	//�˻�
	//�μ�  CM006
	gcds_cm006_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006_s.Reset();
	
	//�Ҽ���  CM003
	gcds_cm003_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003_s.Reset();
	
	//��౸��  
	gcds_cm015_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM015";
	gcds_cm015_s.Reset();
	
	//�Է�
	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();

	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();
	
	//��౸��  
	gcds_cm015.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM015";
	gcds_cm015.Reset();

	//�ټӳ���  
	gcds_cm017.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM017";
	gcds_cm017.Reset();

  ln_SetDataHeader();
	gclx_close_yn.index=1;
}

/*----------------------------------------------------------------------------
	Description : �ϰ�����
----------------------------------------------------------------------------*/
function ln_Modify(){

}

/*----------------------------------------------------------------------------
	Description : ���߰�
----------------------------------------------------------------------------*/
function ln_Add(){
  ln_SetDataHeader();
	gcds_data.Addrow();
  
	gcds_data.namevalue(gcds_data.rowposition,"I_EMPNO")=gusrid;
	gcds_data.namevalue(gcds_data.rowposition,"U_EMPNO")=gusrid;

	gclx_contgb_cd.index=0;
	gclx_conyear_cd.index=0;
}

/*----------------------------------------------------------------------------
	Description : �����
----------------------------------------------------------------------------*/
function ln_Delete(){
	if(!ln_Delete_Chk()) return;

  if (gcds_data.IsUpdated) {
		if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_data.ClearAllMark();
			for(i=1;i<=gcds_data.countrow;i++){
				if(gcds_data.namevalue(i,"CHK")=="T"){
					gcds_data.MarkRows(i,i);
				}
			}
			
			gcds_data.DeleteMarked();
			gctr_data.KeyValue = "Em016_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em016_t1?";
			gctr_data.post();
		}	
	}
}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Save(){
  if(!ln_Save_Chk()) return;

	if (gcds_data.IsUpdated) {
		if (confirm("���ο� ������ �����Ͻðڽ��ϱ�?")){
			gctr_data.KeyValue = "Em016_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em016_t1?";
			gctr_data.Parameters = "v_str1="+gusrid;
			//prompt('',gcds_data.text);
			gctr_data.post();
		}
	}
}

/*----------------------------------------------------------------------------
	Description : ����� üũ 
----------------------------------------------------------------------------*/
function ln_Save_Chk(){
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==3&&gcds_data.namevalue(i,"CLOSE_YN")=="Y"){ // ������ ����Ÿ�� �����ҷ��� �Ұ��
			alert("�����Ұ����� ����Ÿ�� �����մϴ�. Ȯ�ιٶ��ϴ�.");
			gcds_data.RowPosition =i;
			return false;
		}


	  if(gcds_data.SysStatus(i)==3||gcds_data.SysStatus(i)==1){
			
			if(gcds_data.namevalue(i,"CONT_GB")=="001"&&gcds_data.namevalue(i,"CON_YEAR")!=1){  //�ű��ε� 1���� �ȴ� ���
				 alert("��౸�а� �ټӳ����� ���� �ʽ��ϴ�. Ȯ�� �ٶ��ϴ�.1");
				 return false;
			}

			if(gcds_data.namevalue(i,"CONT_GB")=="002"&&gcds_data.namevalue(i,"CON_YEAR")==1){  //�����ε� 1���� �ϰ��
         alert("��౸�а� �ټӳ����� ���� �ʽ��ϴ�. Ȯ�� �ٶ��ϴ�.2");
				 return false;
			}
		}
	}
	return true;
}


/*----------------------------------------------------------------------------
	Description : ������ üũ 
----------------------------------------------------------------------------*/
function ln_Delete_Chk(){
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"CLOSE_YN")=="Y"){ // ������ ����Ÿ�� �����ҷ��� �Ұ��
			alert("�����Ұ����� ����Ÿ�� �����մϴ�. Ȯ�ιٶ��ϴ�.");
			gcds_data.RowPosition =i;
			return false;
		}
	}

	return true;
}

/*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
function ln_Print(){

}

/*----------------------------------------------------------------------------
	Description : ���ã��
----------------------------------------------------------------------------*/
function ln_Find(gbn){//������ȸ

	if(gbn==2){
		if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false; 
		}
	}

    var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(gbn==1){
			txt_empno_s.value = arrParam[0];
			txt_empnmk_s.value = arrParam[1];
		}else{
      txt_empno.value = arrParam[0];
			gcem_empnmk.text = arrParam[1];
      txt_cust_sid.value = arrParam[4];
			gclx_dept_cd.bindcolval =arrParam[6];
			gclx_team_cd.bindcolval = arrParam[7];
			gclx_job_cd.bindcolval = arrParam[5];
			gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = arrParam[8];
			gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = arrParam[9];
			gcds_data.namevalue(gcds_data.rowposition,"SKILL_CD") = arrParam[10];
		}
	} else {
		if(gbn==1){
			txt_empno_s.value = "";
			txt_empnmk_s.value = "";
		}else{
      txt_empno.value = "";
			gcem_empnmk.text = "";
			txt_cust_sid.value ="";	
			gclx_dept_cd.bindcolval ="";
			gclx_team_cd.bindcolval="";
			gclx_job_cd.bindcolval = "";
			gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = "";
			gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = "";
			gcds_data.namevalue(gcds_data.rowposition,"SKILL_CD") ="";
		}
	}
}
/*----------------------------------------------------------------------------
	Description : ������
----------------------------------------------------------------------------*/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

  /**
	if(gbn=="1"){
	  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}else if(gbn=="2"){
		if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}
	**/

  if(gcem_empnmk.text=="") return false;
  
	
	var strURL   = "./Per_com_pop3.jsp";
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(gbn==1){
			gcem_c_empnmk.text = arrParam[0]; //����
			txt_c_empno.value = arrParam[1]; //���
			txt_c_posi_cd.value=arrParam[5];  //
			txt_c_posi_nm.value=arrParam[3];  //
		}else{
			gcem_t_empnmk.text = arrParam[0]; //����
			txt_t_empno.value = arrParam[1]; //���
			txt_t_posi_cd.value=arrParam[5];  //
			txt_t_posi_nm.value=arrParam[3];  //
		}	
	} else {
		if(gbn==1){
			gcem_c_empnmk.text =""; //����
			txt_c_empno.value =""; //���
			txt_c_posi_cd.value=""; //
			txt_c_posi_nm.value=""; //
		}else{
			gcem_t_empnmk.text =""; //����
			txt_t_empno.value =""; //���
			txt_t_posi_cd.value=""; //
			txt_t_posi_nm.value=""; //
		}
	}
}
/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "����Ϻ�����";
    var szPath = "C:\\Test\\em016i.xls";
       if (gcds_data.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }
/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data.countrow<1){
		var s_temp = " EMPNO:STRING(10),EMPNMK:STRING(30),SEQ:DECIMAL(2),CUST_SID:DECIMAL(10),"
							 + " JOB_CD:STRING(5),JOB_NM:STRING(50),VEND_CD:DECIMAL(10),VEND_NM:STRING(50),"
							 + " DEPT_CD:STRING(5),DEPT_NM:STRING(50),TEAM_CD:STRING(5),TEAM_NM:STRING(50),"
							 + " WORK_CD:STRING(5),WORK_NM:STRING(50),CONT_GB:STRING(3),CONT_NM:STRING(50),"
							 + " START_DT:STRING(8),END_DT:STRING(8),"
							 + " C_EMPNO:STRING(10),C_EMPNMK:STRING(30),C_POSI_CD:STRING(3),C_POSI_NM:STRING(30),C_OPI:STRING(60),"
							 + " T_EMPNO:STRING(10),T_EMPNMK:STRING(30),T_POSI_CD:STRING(3),T_POSI_NM:STRING(30),T_OPI:STRING(60),"
							 + " REMARK:STRING(40),"
							 + " CHK:STRING(1),I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10),"
							 + " REWARD_YM:STRING(6),PAYGBNM:STRING(10),CON_YEAR:DECIMAL(2),SKILL_CD:STRING(3),B_PAY0:DECIMAL(10,2),BON_YM:STRING(6),CLOSE_YN:STRING(1) ";
		gcds_data.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : �ϰ�����
******************************************************************************/
function ln_Batch(){
	if(!ln_Batch_Chk()) return;
  var arrParam	= new Array();
	var strURL = "../popup/em016_popup.jsp";
	var strPos = "dialogWidth:405px;dialogHeight:260px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
}

/******************************************************************************
	Description : �ϰ����� üũ
******************************************************************************/
function ln_Batch_Chk(){
	if(fn_trim(gcem_end_ym.text)==""){
		alert("��ุ������ �Է��Ͻʽÿ�.");
		return false;
	}

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"&&gcds_data.namevalue(i,"CLOSE_YN")=="Y"){ // ������ ����Ÿ�� �����ҷ��� �Ұ��
			alert("���κ� ������ ����Ÿ�� �ƴѰ��� �����մϴ�. Ȯ�ιٶ��ϴ�.");
			gcds_data.RowPosition =i;
			return false;
		}
	}
	return true
}

/******************************************************************************
	Description : ��¥�߰�
******************************************************************************/
function ln_Date_Add(strDate){
	gcds_ymd.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em016_S2"
									 + "?v_str1="+strDate;         // ��¥�߰� 
  gcds_ymd.Reset();
}

/******************************************************************************
	Description : ��ุ���� ���ý� dataset �ʱ�ȭ ��.
******************************************************************************/
function ln_End_ym(){
	__GetCallMonth('gcem_end_ym','Text');
	gcds_data.ClearAll();
}

/******************************************************************************
	Description : ��ุ������ ���ý� dataset �ʱ�ȭ ��.
******************************************************************************/
function ln_End_dt(){
	__GetCallCalendar7('gcem_end_dt', 'Text');
	ln_Ym_Date();
}


/******************************************************************************
	Description : ��ุ������ ���ý� dataset �ʱ�ȭ ��.
******************************************************************************/
function ln_Ym_Date(){
	if(gcem_end_dt.text!=""){
	//	 alert("gcem_end_dt.text::::"+gcem_end_dt.text);
		 ln_Date_Add(gcem_end_dt.text);
		 if(gclx_contgb_cd.bindcolval=="002"){ //������
			 //�󿩱� ���޳�� = ������ + 1���� ==> ����::���縸���� - 1�� + 1����(�����Է½�)
			 gcem_bon_ym.text = gcds_ymd.namevalue(gcds_ymd.rowposition,"mAYM"); 
			 //�ް������� = ������ + 1��1���� ==> ����::������ + 1����(�����Է½�) 2008.01.19
		   gcem_reward_ym.text = gcds_ymd.namevalue(gcds_ymd.rowposition,"AMM"); 
		 }else{
			 gcem_bon_ym.text = "";
			 gcem_reward_ym.text ="";
		 }
	}
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

<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>

	if(row<1&&colid=="CHK"){
		if(gcds_data.namevalue(1,colid)=="T"){
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="F";
			}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="T";
			}
		}
	}
</script>

<script language=JavaScript for=gclx_contgb_cd event=OnSelChange()>
  ln_Ym_Date(); //�ް��̽ǽ� ������ , �����޳��
</script>

<script language=JavaScript for=gcem_end_dt event=OnKillFocus()>
	ln_Ym_Date(); //�ް��̽ǽ� ������ , �����޳��
</script>

<script language=JavaScript for=gcem_end_dt event=onLastChar(char)>
  ln_Ym_Date(); //�ް��̽ǽ� ������ , �����޳��
</script>
 
<script language=JavaScript for=gcem_end_ym event=OnKillFocus()>
	gcds_data.ClearAll();
</script>

<script language=JavaScript for=gcem_end_ym event=onLastChar(char)>
  gcds_data.ClearAll();
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

	<!-- �˻� -->
<script language="javascript" for="gcds_cm006_s" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm006_s","gclx_dept_cd_s");
</script>

 <script language="javascript" for="gcds_cm003_s" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm003_s","gclx_team_cd_s");
</script>

<script language="javascript" for="gcds_cm015_s" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm015_s","gclx_contgb_cd_s");
</script>

<!-- �Է� -->
<!-- �μ� -->
 <script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm006","gclx_dept_cd");
</script>

<!-- �Ҽ� -->
<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm003","gclx_team_cd");
</script>
<!-- ���� -->
<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
    ln_Insert_Row(1,"gcds_cm004","gclx_job_cd");
</script>

 <!-- ��౸�� -->
<script language="javascript" for="gcds_cm015" event="onloadCompleted(row,colid)">
    //ln_Insert_Row(1,"gcds_cm015","gclx_contgb_cd");
</script>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
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
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- ��¥ -->
 <OBJECT id=gcds_ymd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm006_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm015_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm015 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">		
						  	<!-- <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"  onclick="ln_Modify()"> -->
							  <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"  onclick="ln_Batch()">
                <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
                <!-- <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"  onClick="ln_Add()" > -->
                <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete()" >		
                <img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
                <!-- <img src="<%=dirPath%>/Sales/images/print.gif"	style="cursor:hand"  onclick="ln_Print()"> -->
                <img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				 <table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="20">
					 	<td bgcolor="#eeeeee" align="center">�μ�</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006_s">
								<param name=CBDataColumns		value="COM_CODE,COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�Ҽ���</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_team_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;height:300px;">
								<param name=ComboDataID			value="gcds_cm003_s">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
           	<td bgcolor="#eeeeee" align="center" width="60">����</td>
						<td bgcolor="#FFFFFF">
						  <input type="text" id="txt_empnmk_s" style="position:relative;;left:8px;width:80px;top:-1px;">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find(1)">
							<input type="text" id="txt_empno_s" style="position:relative;;left:8px;width:70px;top:-1px;">&nbsp;
						</td>
						<td bgcolor="#eeeeee" align="center" width="60">����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_close_yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:8px;top:1px;font-size:12px;width:60px;">
								<param name=CBData					value="A^��ü,N^���,Y^����">
								<param name=CBDataColumns		value="COM_CODE,COM_SNAME">
								<param name=Index						value=1>
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
           </tr>
           
					 <tr>
						<td bgcolor="#eeeeee" align="center">��౸��</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_contgb_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm015_s">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">��ุ����</td>
						<td bgcolor="#FFFFFF" >
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_end_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="ln_End_ym();"> 
						</td>
						<td bgcolor="#eeeeee" align="center">�������</td>
						<td bgcolor="#FFFFFF" colspan=3>
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_start_fr_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_fr_s', 'Text');">
						  <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span> 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_start_to_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_to_s', 'Text');">
 						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
        <table cellpadding=0 cellspacing=1 style="width:580px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:580;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<param name=MultiRowSelect	value=true>
							<param name=Editable      value="true">
							<param name=UsingOneClick  value="1">
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO				   ID={CurRow}   HeadAlign=Center   HeadBgColor=#B9D4DC   Width=28,  align=center  edit=none</F> 
                <FC>Name=����,       ID=CHK     ,  width=28,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  EditStyle='CheckBox' </FC>
                <FC>Name=�ٹ���ü,   ID=VEND_NM ,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true show=false</FC>
								<FC>Name=�μ�,       ID=DEPT_CD ,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm006:COM_CODE:COM_SNAME'</FC>
                <FC>Name=�Ҽ���,     ID=TEAM_CD ,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm003:COM_CODE:COM_SNAME'</FC>
                <FC>Name=����,       ID=JOB_CD ,   width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm004:COM_CODE:COM_SNAME'</FC>
                <FC>Name=���,       ID=EMPNO  ,   width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true </FC>
								<FC>Name=����,       ID=EMPNMK  ,  width=50,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true </FC>						
								<C>Name='���\\����',ID=CONT_GB , width=55,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm015:COM_CODE:COM_SNAME'</C>
								<C>Name='��\\��',    ID=CON_YEAR , width=37,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm017:COM_CODE:COM_SNAME'</C>
                <G> name=���Ⱓ  HeadBgColor=#B9D4DC,     
									<C>Name=�����,    ID=START_DT,  width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none sort = true mask='XXXX/XX/XX' </C>
									<C>Name=������,    ID=END_DT,    width=65,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none sort = true mask='XXXX/XX/XX' </C>
								</G>
								<G> name=���  HeadBgColor=#B9D4DC, 
									<C>Name=����,      ID=C_EMPNMK,   width=60,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none </C>
									<C>Name=����,      ID=C_POSI_NM,  width=60,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none </C>
									<C>Name=�����,  ID=C_OPI,      width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff,align=left, edit=none </C>
								</G>
								<G> name=����  HeadBgColor=#B9D4DC, 
									<C>Name=����,      ID=T_EMPNMK,   width=60,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none </C>
									<C>Name=����,      ID=T_POSI_NM,  width=60,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none </C>
									<C>Name=������,  ID=T_OPI,      width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff,align=left, edit=none </C>
								</G>
								<C>Name=���, ID=REMARK   ,width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit= none </C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset style="width:580;height:20px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
								</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td>
							<table cellpadding=0 cellspacing=0 style="width:238px;height:390px;">
								<tr height="18">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    
										<input type="text" id="txt_empno" style="position:relative;;left:8px;width:55px;top:-1px;" readonly>&nbsp;
										<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:1px;top:3px;cursor:hand" onclick="ln_Find(2)">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_empnmk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:1px;top:3px; width:65px;  font-family:����; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
									  <param name=GeneralEdit   value="true">
									  <param name=ReadOnly      value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
										
										<input type="hidden" id="txt_cust_sid" style="position:relative;;left:8px;width:1px;top:-1px;">&nbsp;
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�μ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                     <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm006">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
										<param name=Enable          value="false">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�Ҽ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
									 <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;height:300px">
                    <param name=ComboDataID			value="gcds_cm003">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
										<param name=Enable          value="false">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_job_cd   classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm004">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^100">
                    <param name=BindColumn			value=COM_CODE>
										<param name=Enable          value="false">
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25" >��౸��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_contgb_cd   classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm015">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^80">
                    <param name=BindColumn			value=COM_CODE>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�ټӳ���</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gclx_conyear_cd   classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                    <param name=ComboDataID			value="gcds_cm017">
                    <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                    <param name=SearchColumn		value=COM_SNAME>
                    <param name=Sort						value=false>
                    <param name=Index						value=0>
                    <param name=ListExprFormat	value="COM_SNAME^0^80">
                    <param name=BindColumn			value=COM_CODE>
                    </OBJECT><%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >��������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_start_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_dt', 'Text');">
									</td>
								</tr>
                <tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >��ุ����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="ln_End_dt();">
									</td>
								</tr>
								<tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�ް���������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_reward_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
										<param name=ReadOnly      value="true">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                   <!--  <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_reward_ym', 'Text');"> -->
                    <input id="txt_paygbnm"  type="hidden"   class="txtbox"  style= "position:relative;top:-2px;left:10px;width:40px;height:20px;" ReadOnly>
									</td>
								</tr>
							  <tr  height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�����޳��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
                    <%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_bon_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:1px; width:50px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
										<!-- <param name=ReadOnly      value="true"> -->
										<param name=ReadOnlyBackColor   value="#CCFFCC">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <!-- <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_reward_ym', 'Text');">
                    <input id="txt_paygbnm"  type="text"   class="txtbox"  style= "position:relative;top:-2px;left:10px;width:40px;height:20px;" ReadOnly> -->
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="20">���</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_c_empnmk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:4px; width:50px;  font-family:����; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=GeneralEdit   value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand" onclick="ln_Popup(1)">
										<input id="txt_c_posi_nm"  type="text"    class="txtbox"  style= "position:relative;left:5px;width:55px;height:20px;" ReadOnly>
										<input id="txt_c_posi_cd"  type="hidden"  class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" ReadOnly>
										<input type="hidden" id="txt_c_empno" style="position:relative;left:8px;width:1px;top:-1px;">&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="20">�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<textarea id="txt_c_opi" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
									</td>                                                                                                                                           
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" height="20">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_t_empnmk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:4px; width:50px;  font-family:����; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=GeneralEdit   value="true">
                    </OBJECT><%=HDConstant.COMMENT_END%>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;top:3px;cursor:hand" onclick="ln_Popup(2)">
										<input id="txt_t_posi_nm"  type="text"     class="txtbox"  style= "position:relative;left:5px;width:55px;height:20px;" ReadOnly>
										<input id="txt_t_posi_cd"  type="hidden"   class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" ReadOnly>
										<input type="hidden" id="txt_t_empno" style="position:relative;;left:8px;width:1px;top:-1px;">&nbsp;
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="20">������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<textarea id="txt_t_opi" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</td>
								</tr>
								<tr >
									<td align="center" bgcolor="#eeeeee" class="tab_z1011" height="20">���</td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >
										<textarea id="txt_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
                                    </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- �⺻�� -->
		<%=HDConstant.COMMENT_START%>
		<OBJECT id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
			<PARAM NAME="DataID"				VALUE="gcds_data">
			<PARAM NAME="ActiveBind"		VALUE="true">
			<PARAM NAME="BindInfo"			VALUE="
			  <C>Col=EMPNO   			  Ctrl=txt_empno      			Param=value</C>
				<C>Col=EMPNMK   			Ctrl=gcem_empnmk     			Param=text</C>
				<C>Col=CUST_SID			  Ctrl=txt_cust_sid    			Param=value</C>
				<C>Col=DEPT_CD				Ctrl=gclx_dept_cd  			  Param=bindcolval</C>
				<C>Col=TEAM_CD   			Ctrl=gclx_team_cd    			Param=bindcolval</C>
				<C>Col=JOB_CD   			Ctrl=gclx_job_cd    			Param=bindcolval</C>
				<C>Col=CONT_GB 				Ctrl=gclx_contgb_cd				Param=bindcolval/C>
				<C>Col=START_DT				Ctrl=gcem_start_dt 				Param=Text</C>
				<C>Col=END_DT   			Ctrl=gcem_end_dt   				Param=Text</C>
			  <C>Col=C_EMPNO   		  Ctrl=txt_c_empno      		Param=value</C>
				<C>Col=C_EMPNMK  			Ctrl=gcem_c_empnmk 				Param=Text</C>
				<C>Col=C_POSI_CD 			Ctrl=txt_c_posi_cd 				Param=value</C>
				<C>Col=C_POSI_NM 			Ctrl=txt_c_posi_nm 				Param=value</C>
				<C>Col=C_OPI  		  	Ctrl=txt_c_opi     			  Param=value</C>
				<C>Col=T_EMPNO   		  Ctrl=txt_t_empno      		Param=value</C>
				<C>Col=T_EMPNMK 	  	Ctrl=gcem_t_empnmk 				Param=Text</C>
				<C>Col=T_POSI_CD	  	Ctrl=txt_t_posi_cd 				Param=value</C>
				<C>Col=T_POSI_NM			Ctrl=txt_t_posi_nm 				Param=value</C>
				<C>Col=T_OPI  		  	Ctrl=txt_t_opi     			  Param=value</C>
				<C>Col=REMARK  		  	Ctrl=txt_remark    				Param=value</C>
				<C>Col=REWARD_YM  		Ctrl=gcem_reward_ym				Param=text</C>
				<C>Col=PAYGBNM        Ctrl=txt_paygbnm  			  Param=value</C>
        <C>Col=CON_YEAR       Ctrl=gclx_conyear_cd  		Param=bindcolval</C>
			  <C>Col=BON_YM         Ctrl=gcem_bon_ym  		    Param=text</C>

		">
	</OBJECT><%=HDConstant.COMMENT_END%>
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>