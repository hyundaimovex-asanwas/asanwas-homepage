<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �ް�����
+ ���α׷�ID : em015i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.07
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em015_S.java
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
	var gs_date = gcurdate;
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+"01";
    var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
    */
    
    var gs_date = '<%=firstday%>';
	  var gs_date1 = gs_date.substring(0,6)+"01";
    var gs_date2 = gs_date;

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em015_S1"
											 + "?v_str1=" + fn_trim(gclx_dept_cd_s.bindcolval)	  // �μ�       
											 + "&v_str2=" + fn_trim(gclx_team_cd_s.bindcolval)	  // �Ҽ�       
											 + "&v_str3=" + fn_trim(txt_empno_s.value)			      // ���       
											 + "&v_str4=" + fn_trim(txt_empnmk_s.value)	      		// ����       
											 + "&v_str5=" + fn_trim(gcem_start_dt_s.text) 		  	// �ް�����FR 
											 + "&v_str6=" + fn_trim(gcem_end_dt_s.text)			      // �ް�����TO 
											 + "&v_str7=Y" ;			  // �ް�����   
  prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

   //gcra_h_yn_s.codevalue="Y";
	 gcem_start_dt_s.text = gs_date1;
   gcem_end_dt_s.text = gs_date2;
	 gcra_h_yn.codevalue='Y';

  //�˻�
	//�μ�  CM006
	gcds_cm006_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006_s.Reset();
	
	//�Ҽ���  CM003
	gcds_cm003_s.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003_s.Reset();
	
	//�Է�
	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();
	
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();
}

/*----------------------------------------------------------------------------
	Description : ���߰�
	���߰��� ����������. �������� �ް������� ���� ��ų �� ��� ���´�.
	�˾����� �����Ǵ� �Ǹ� �߰��Ѵ�.
	������ - ���� �ް��� ��� ó������� �ʿ���.
----------------------------------------------------------------------------*/
function ln_Add(){
  ln_SetDataHeader();
	gcds_data.Addrow();
	gcra_h_yn.codevalue='Y';

}

/*----------------------------------------------------------------------------
	Description : �����
----------------------------------------------------------------------------*/
function ln_Delete(){
	
	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.ClearAllMark();
		for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.MarkRows(i,i);
			}
		}
		
		gcds_data.DeleteMarked();
		gctr_data.KeyValue = "Em015_t1(I:USER=gcds_data)";
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em015_t1?";
		//prompt('',gcds_data.text);
		gctr_data.post();
	}	
}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Save(){
  
	if(!ln_Save_Chk()) return;

	if (gcds_data.IsUpdated) {
		if (confirm("���ο� ������ �����Ͻðڽ��ϱ�?")){
			gctr_data.KeyValue = "Em015_t1(I:USER=gcds_data)";
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em015_t1?";
			gctr_data.Parameters = "v_str1="+gusrid;
			//prompt('',gcds_data.text);
			gctr_data.post();
		}
	}
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
			//gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = arrParam[8];
			//gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = arrParam[9];
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
			//gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = "";
			//gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = "";
		}
	}
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
function ln_Save_Chk(){
	//�ʼ��׸�
	if(fn_trim(txt_empno.value)==""){
		alert("����� �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	if(fn_trim(gcem_empnmk.text)==""){
		alert("������ �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	if(gclx_dept_cd.bindcolval==""){
		alert("�μ��� �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	/*
	if(gclx_team_cd.bindcolval==""){
		alert("�Ҽ��� �ʼ��׸��Դϴ�.");
		return false;
	}
	*/

	//�ʼ��׸�
	if(fn_trim(gcem_start_dt.text)==""){
		alert("�ް��������� �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	if(fn_trim(gcem_end_dt.text)==""){
		alert("�ް��������� �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	if(gcra_h_yn.codevalue==""){
		alert("�ް����δ� �ʼ��׸��Դϴ�.");
		return false;
	}

	//
	if(gcem_h_day.text<=0){
		alert("�ް��ϼ��� Ȯ���Ͻʽÿ�.");
    gcem_h_day.focus();
		return false;
	}

	if(gcem_reward_ym.text==""){
		alert("�޿���� Ȯ���Ͻʽÿ�.");
    gcem_reward_ym.focus();
		return false;
	}

	return true;
}

/******************************************************************************
	Description : �ް� ����� �˾�
******************************************************************************/
function ln_H_Find(){

	var arrParam	= new Array();
	var arrParam2	= new Array();

	var strURL   = "../popup/em015_popup.jsp";
	var strPos = "dialogWidth:680px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
 
		for(j=0;j<arrParam.length;j++){
			arrParam2="";
			arrParam2=arrParam[j].split(":");
      
			if(arrParam2[0]=="") return;

      ln_Add();
			gcds_data.namevalue(gcds_data.rowposition,"EMPNO")=arrParam2[0];     //���
			gcds_data.namevalue(gcds_data.rowposition,"EMPNMK")=arrParam2[1];    //����
			gcds_data.namevalue(gcds_data.rowposition,"DEPT_CD")=arrParam2[2];   //�μ�
			gcds_data.namevalue(gcds_data.rowposition,"DEPT_NM")=arrParam2[3];   //�μ���
			gcds_data.namevalue(gcds_data.rowposition,"TEAM_CD")=arrParam2[4];   //�Ҽ�
			gcds_data.namevalue(gcds_data.rowposition,"TEAM_NM")=arrParam2[5];   //�ҼӸ�
			gcds_data.namevalue(gcds_data.rowposition,"VEND_CD")=arrParam2[6];   //�ٹ���ü
			gcds_data.namevalue(gcds_data.rowposition,"WORK_CD")=arrParam2[7];   //�ٹ���
			gcds_data.namevalue(gcds_data.rowposition,"SEQ2")=arrParam2[8];      //����������
			gcds_data.namevalue(gcds_data.rowposition,"CUST_SID")=arrParam2[9];  //CUST_SID
			gcds_data.namevalue(gcds_data.rowposition,"H_YN")="Y";
			gcds_data.namevalue(gcds_data.rowposition,"BACK_GB")="0";            //�ް����ͱ��� 0 �̺���, 1 ���� 
			gcds_data.namevalue(gcds_data.rowposition,"REWARD_YM")=arrParam2[10]; //�޿����޳��
			gcds_data.namevalue(gcds_data.rowposition,"BON_YM")=arrParam2[11]; //�󿩳��
      gcds_data.namevalue(gcds_data.rowposition,"ORG_BON_YN")=arrParam2[11]; 
			gcds_data.namevalue(gcds_data.rowposition,"CON_YEARNM")=arrParam2[12]; 
			gcds_data.namevalue(gcds_data.rowposition,"SSTART_DT")=arrParam2[13];

		}
	}else{


	}

 //alert("cnt:::"+em015_popup.gcds_data.countrow);

  /*
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
			//gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = arrParam[8];
			//gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = arrParam[9];
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
			//gcds_data.namevalue(gcds_data.rowposition,"VEND_CD") = "";
			//gcds_data.namevalue(gcds_data.rowposition,"WORK_CD") = "";
		}
	}

	*/

}
/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "�ް�����";
    var szPath = "C:\\Test\\em015i.xls";
       if (gcds_data.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }


/******************************************************************************
	Description : ��¥��������
	Parameter   : frdt - �����, todt - ������
******************************************************************************/
function ln_Date(obj,objtxt){

		__GetCallCalendar7(obj,objtxt);
   
		if(gcem_start_dt.text!=""&&gcem_end_dt.text!=""){
		  gcem_h_day.text=ln_DataChk(gcem_start_dt.text,gcem_end_dt.text);
		}
}

/******************************************************************************
	Description : ��¥ ���� ��ȸ
	Parameter   : frdt - �����, todt - ������
******************************************************************************/
function ln_DataChk(frdt,todt) { 
	var fryy =frdt.substring(0,4);
	var frmm =frdt.substring(4,6);
	var frdd =frdt.substring(6,8);

	var toyy =todt.substring(0,4);
	var tomm =todt.substring(4,6);
	var todd =todt.substring(6,8);

	frdate=new Date(fryy,frmm-1,frdd); //�������� 1�� ���� 
	todate=new Date(toyy,tomm-1,todd); //���ó�¥ 

	frtime=frdate.getTime(); //��߽ð� 
	totime=todate.getTime(); //�����ð�
	cha=totime-frtime;       //�ð����� 
	conv=Math.floor(cha/(60*60*24*1000))+1; //�ð����̸� �������̷� ��� 
	return conv
}


/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data.countrow<1){

		var s_temp = " EMPNO:STRING(10),EMPNMK:STRING(30),YYYY:STRING(4),SEQ:DECIMAL(2),CUST_SID:DECIMAL(10),"
							 + " VEND_CD:DECIMAL(10),DEPT_CD:STRING(5),DEPT_NM:STRING(50),TEAM_CD:STRING(5),TEAM_NM:STRING(50),"
							 + " WORK_CD:STRING(5),START_DT:STRING(8),END_DT:STRING(8),H_DAY:DECIMAL(3),H_RES:STRING(40),"
							 + " H_YN:STRING(1),SEQ2:DECIMAL(2.0),CHK:STRING(1),REWARD_YM:STRING(6),BON_YM:STRING(6),BACK_GB:STRING(1),ORG_BON_YM:STRING(6), "
							 + " I_EMPNO:STRING(10),I_DATE:STRING(10),U_EMPNO:STRING(10),U_DATE:STRING(10),CON_YEARNM:STRING(50),SSTART_DT:STRING(8)";
		gcds_data.SetDataHeader(s_temp);
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
<!-- �˻� -->
<script language="javascript" for="gcds_cm006_s" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm006_s","gclx_dept_cd_s");
</script>

 <script language="javascript" for="gcds_cm003_s" event="onloadCompleted(row,colid)">
    ln_Insert_Row(2,"gcds_cm003_s","gclx_team_cd_s");
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

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ln_Start_Load()
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ln_End_Load(row,"ft_cnt1");
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
		 alert("�۾��� �Ϸ� �Ͽ����ϴ�");
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

 <script lanaguage=JavaScript for=gcem_start_dt event=onLastChar(char)>
     if(gcem_start_dt.text!=""&&gcem_end_dt.text!=""){
			  gcem_h_day.text=ln_DataChk(gcem_start_dt.text,gcem_end_dt.text);
     }
 </script>

 <script lanaguage=JavaScript for=gcem_end_dt event=onLastChar(char)>
     if(gcem_start_dt.text!=""&&gcem_end_dt.text!=""){
				gcem_h_day.text=ln_DataChk(gcem_start_dt.text,gcem_end_dt.text);
     }
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

<!-- �����ڵ� -->
<OBJECT id=gcds_cm006_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003_s classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>


</head>
<body>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
 <table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">		
						  <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"  onclick="ln_H_Find()">
							<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand"  onclick="ln_Query()">
							<!-- <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"  onClick="ln_Add()" > -->
              <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
        <table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
						<td bgcolor="#eeeeee" align="center" width="80px">�μ�</td>
						<td bgcolor="#FFFFFF"  width="135px">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006_s">
								<param name=CBDataColumns		value="COM_CODE,COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
						<td bgcolor="#eeeeee" align="center" width="80px">�Ҽ���</td>
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
								</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td>
           	<td bgcolor="#eeeeee" align="center" width="80px" >����</td>
						<td bgcolor="#FFFFFF">
						  <input type="text" id="txt_empnmk_s" style="position:relative;left:8px;width:70px;top:-1px;">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find(1)">
 							<input type="text" id="txt_empno_s" style="position:relative;left:8px;width:70px;top:-1px;">&nbsp;							
						</td>
					</tr>
					<tr>
						<td bgcolor="#eeeeee" align="center" >�ް�����</td>
						<td bgcolor="#FFFFFF" colspan =5>
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_start_dt_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_dt_s','Text');">
						  <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span> 
							
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_end_dt_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_end_dt_s','Text');">
 						</td>

						<!-- <td bgcolor="#eeeeee" align="center">�ް�����</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gcra_h_yn_s classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
							style="position:relative; left:8px;top:0px; width:120px;  font-family:����; font-size:9pt;z-index:2; ">
							<param name=Cols	value="2">
							<param name=AutoMargin	value="false">
							<param name=Format	value="Y^���,N^�̻��">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						</td> -->
					</tr> 
				</table> 
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:600px;height:370px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:600;height:350px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="Editable"			value=true>
							<PARAM NAME="Colsizing"		VALUE="true">
							<param name=MultiRowSelect	value=true>
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                <FC> Name=NO				   ID={CurRow}   HeadAlign=Center   HeadBgColor=#B9D4DC   Width=28,  align=center  edit=none</FC> 
                <FC> Name=����,       ID=CHK		 ,  width=27,HeadBgColor=#B9D4DC, HeadAlign=center  align=center EditStyle=CheckBox </FC>
								<FC>Name=�ٹ���ü,   ID=VEND_NM ,  width=70,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true show=false</FC>
								<FC>Name=�μ�,       ID=DEPT_CD ,  width=80,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm006:COM_CODE:COM_SNAME'</FC>
                <FC>Name=�Ҽ���,     ID=TEAM_CD ,  width=80,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true EditStyle=Lookup Data='gcds_cm003:COM_CODE:COM_SNAME'</FC>
                <FC>Name=����,       ID=EMPNMK  ,  width=53,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true </FC>
								<FC>Name=����,       ID=EMPNO  ,   width=60,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true show=false</FC>
								<FC>Name=�Ի���,     ID=SSTART_DT,  width=67,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none mask='XXXX/XX/XX' </FC>
								<FC>Name=����,       ID=CON_YEARNM  , width=35,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none  </FC>
                <G> name=�ް�����    HeadBgColor=#B9D4DC,     
									<C>Name=������,    ID=START_DT,  width=67,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none mask='XXXX/XX/XX' </C>
									<C>Name=������,    ID=END_DT,    width=67,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none mask='XXXX/XX/XX' </C>
								</G>
								<C>Name=�ް�\\�ϼ�,  ID=H_DAY,     width=28,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit= none </C>
								<C>Name=����\\����,  ID=BACK_GB,   width=42,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   edit= none, EditStyle=Combo,Data='0:�̺���,1:����'</C>
								<C>Name=�ް�����,    ID=H_RES,     width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff,align=left,   edit= none </C>
								<C>Name=�ް�\\����,  ID=H_YN,      width=40,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit= none EditStyle=Combo Data='Y:���,N:�̻��' show=false</C>
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:600;height:20px;solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
						<td bgcolor="#FFFFFF">&nbsp;</td>
						<td  valign="top">
							<table cellpadding=0 cellspacing=0 style="width:218px;height:320px;">
								<tr height="18">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
                    <%=HDConstant.COMMENT_START%><OBJECT id=gcem_empnmk classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
                    style="position:relative; left:8px;top:1px; width:70px;  font-family:����; font-size:9pt;z-index:2; ">
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
									  <param name=GeneralEdit   value="true">
									  <param name=ReadOnly      value="true">
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="ln_Find(2)">
										<input type="hidden" id="txt_empno" style="position:relative;;left:8px;width:1px;top:-1px;">&nbsp;
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
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								
                <tr height="25">
									<td align="center" bgcolor="#eeeeee" class="tab_z1011" >�Ҽ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >
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
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr height="25">
								<td colspan="2"><font color="blue"><b>[�ް�]</b></font></td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" height="25">������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_start_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="ln_Date('gcem_start_dt','Text');">
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">������</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM/DD">
                    <param name=PromptChar	  value="_">
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
                    <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="ln_Date('gcem_end_dt','Text');">
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�ް��ϼ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_h_day classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:8px;top:1px; width:30px; font-family:����; font-size:9pt;z-index:2; ">
										<param name=Alignment			value=1>
										<param name=Numeric       value="true">
										<param name=MaxLength     value=3>
										<param name=Border	      value=true>
										<param name=ReadOnly      value="true">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">���ͱ���</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
										<OBJECT id=gcra_back_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
										style="position:relative; left:8px;top:0px; width:150px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Cols	  value="2">
										<param name=Format	value="0^�̺���,1^����">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
                  </td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" >�ް�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<textarea id="txt_h_res" class="txtbox"  style= "width:130px;height:40px;overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</nobr>
                  </td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�ް�����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
										<OBJECT id=gcra_h_yn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
										style="position:relative; left:8px;top:0px; width:120px;  font-family:����; font-size:9pt;z-index:2; ">
										<param name=Cols	value="1">
                    <param name=Enable	value="false">
										<param name=Format	value="Y^���">
										</OBJECT></comment><script>__ws__(__NSID__);</script>
                  </td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�޿����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_reward_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
								<tr>
									<td align="center" bgcolor="#eeeeee" class="tab_z1010"  height="25">�󿩳��</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<%=HDConstant.COMMENT_START%>
                    <OBJECT id=gcem_bon_ym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
                    style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
                    <param name=Alignment			value=0>
                    <param name=Border	      value=true>
                    <param name=Format	      value="YYYY/MM">
                    <param name=PromptChar	  value="_">
                    </OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
								</tr>
                <tr>
									<td bgcolor="#FFFFFF" class="tab_z1111" colspan=2  height="42" >
								     * �޿������ �ް������ ������<BR>   * �����޳���� ������
                  </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
<!-- �⺻�� -->
		<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<PARAM NAME="DataID"				VALUE="gcds_data">
			<PARAM NAME="ActiveBind"		VALUE="true">
			<PARAM NAME="BindInfo"			VALUE="
			  <C>Col=EMPNO   			  Ctrl=txt_empno   					  Param=value</C>                      
        <C>Col=EMPNMK   			Ctrl=gcem_empnmk   					Param=text</C>
				<C>Col=DEPT_CD				Ctrl=gclx_dept_cd						Param=bindcolval</C>
				<C>Col=TEAM_CD   			Ctrl=gclx_team_cd   				Param=bindcolval</C>
				<C>Col=START_DT   		Ctrl=gcem_start_dt   				Param=text</C>
				<C>Col=END_DT   			Ctrl=gcem_end_dt   			  	Param=text</C>
				<C>Col=H_DAY   			  Ctrl=gcem_h_day   				  Param=text</C>
				<C>Col=H_RES   			  Ctrl=txt_h_res   				    Param=value</C>
				<C>Col=H_YN    			  Ctrl=gcra_h_yn   				    Param=codevalue</C>
        <C>Col=REWARD_YM		  Ctrl=gcem_reward_ym   		  Param=text</C>
        <C>Col=BON_YM		      Ctrl=gcem_bon_ym       		  Param=text</C>
				<C>Col=BACK_GB		    Ctrl=gcra_back_gb				    Param=codevalue</C>
			">
		</OBJECT><%=HDConstant.COMMENT_END%>
	</table> 
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>