<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���� - �߷ɰ���
+ ���α׷�ID : ks_em011i.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2008.09.11
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em011_S1
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

<link rel="stylesheet" href="../common/include/common.css">

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
	
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
	/*
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';

	
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
	function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
		
		ln_before();//����ȸ
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		
		//fnInit(); //�ʱ�ȭ �Լ�
	
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
	Description : �⺻��ȸ
	Parameter : 
----------------------------------------------------------------------------*/
function ln_Query(){


	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em011_S1?"
											 + "v_str1="+fn_trim(txt_empno.value) 
											 + "&v_str2="+fn_trim(txt_empnmk.value)
                       						 + "&v_str3="+fn_trim(gclx_dept_cd.bindcolval)
                       						 + "&v_str4="+gcds_work_cd.value	
                       						 + "&v_str5="+gcds_vend_cd.value;	  
                       						                      						 
	//prompt (this, gcds_data01.DataID);	
                       						 
	gcds_data01.Reset();
	
	gcds_data02.ClearAll();

}


/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//�߷ɱ���
	gcds_ks010.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS010";
	gcds_ks010.Reset();

	//����  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();

  	gcds_ord_dt.text=gs_date;

}


/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

  var arrParam	= new Array();
  
	var strURL   = "./ks_com_pop.jsp";
	
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
	Description : �˾�â
----------------------------------------------------------------------------*/

function ln_FindC(e){

		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam = e;
		strURL = "../popup/ks_em_popup.jsp";
		strPos = "dialogWidth:370px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
		
		//	prompt (this, arrResult);
		//	gcds_data00.addrow();
			arrParam = arrResult.split(";");
		
		if ( arrParam[0] == '01'){						
			gcds_vend_cd.value=arrParam[1];							
			text_gcds_vend_nm.value=arrParam[2];					
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD") = arrParam[1];	
			gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM") = arrParam[2];			
						
		}else if	( arrParam[0] == '02'){	
			gcds_dept_cd.value=arrParam[1];				
			text_gcds_dept_nm.value=arrParam[2];
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD") = arrParam[1];
			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM") = arrParam[2];
			
		}else if	( arrParam[0] == '03'){			
			gcds_c_vend_cd.value=arrParam[1];
			text_gcds_c_vend_nm.value=arrParam[2];
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD") = arrParam[1];
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM") = arrParam[2];
			
		}else if	( arrParam[0] == '04'){			
			gcds_work_cd.value=arrParam[1];
			text_gcds_work_nm.value=arrParam[2];
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD") = arrParam[1];
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM") = arrParam[2];
			
		}else if	( arrParam[0] == '05'){			
			gcds_class_cd.value=arrParam[1];
			text_gcds_class_nm.value=arrParam[2];
			gcds_data02.namevalue(gcds_data02.rowposition,"CLASS_CD") = arrParam[1];
			gcds_data02.namevalue(gcds_data02.rowposition,"CLASS_NM") = arrParam[2];
			
		}else if	( arrParam[0] == '06'){	
			gcds_job_cd.value=arrParam[1];				
			text_gcds_job_nm.value=arrParam[2];	
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD") = arrParam[1];
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM") = arrParam[2];

		}else if	( arrParam[0] == '11'){			
			gcds_vend_cd.value=arrParam[1];	
			gcds_vend_nm.text=arrParam[2];							

		}else if	( arrParam[0] == '14'){			
			gcds_work_cd.value=arrParam[1];
			gcds_work_nm.text=arrParam[2];
				
		}	


}
}


/*****************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Save(){
	if (gcds_data02.IsUpdated) {
	
		if(confirm("�����Ͻðڽ��ϱ�?")){
		
			gctr_data.KeyValue = "KS_Em011_t1(I:USER=gcds_data02)";
			
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em011_t1?";
			
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
  
//	if(!ln_Order_Chk()) return;
	
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

			gcds_data02.namevalue(gcds_data02.rowposition,"CLASS_CD") = gcds_data01.namevalue(i,"CLASS_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"CLASS_NM") = gcds_data01.namevalue(i,"CLASS_NM");			
			
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD") = gcds_data01.namevalue(i,"WORK_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM") = gcds_data01.namevalue(i,"WORK_NM");

			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD") = gcds_data01.namevalue(i,"C_VEND_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM") = gcds_data01.namevalue(i,"C_VEND_NM");
			
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD") = gcds_data01.namevalue(i,"JOB_CD");
			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM") = gcds_data01.namevalue(i,"JOB_NM");
					
			gcds_data02.namevalue(gcds_data02.rowposition,"I_EMPNO") = gusrid;
			gcds_data02.namevalue(gcds_data02.rowposition,"U_EMPNO") = gusrid;


			//prompt(this, gcds_ord_cd.text);

			//******************************�űԹ߷��� �߰��Ѵ�.
			//�߷ɱ���
      		gcds_data02.namevalue(gcds_data02.rowposition,"ORD_NM") = gcds_ord_cd.text;
			gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD") = gcds_ord_cd.bindcolval;
			
			//�߷�����
      		gcds_data02.namevalue(gcds_data02.rowposition,"ORD_DT") = gcds_ord_dt.text;
			
				//�Ҽ�
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_CD")=gcds_vend_cd.value;
				gcds_data02.namevalue(gcds_data02.rowposition,"VEND_NM")=gcds_vend_nm.value;
			  
			  	//���屸��
				gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_CD")=gcds_dept_cd.value;
	//			gcds_data02.namevalue(gcds_data02.rowposition,"DEPT_NM")=gcds_dept_nm.value;

			  	//�ٹ�����
				gcds_data02.namevalue(gcds_data02.rowposition,"WORK_CD")=gcds_work_cd.value;
	//			gcds_data02.namevalue(gcds_data02.rowposition,"WORK_NM")=gcds_work_nm.value;
				
				//���δ��ü
				gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_CD")=gcds_c_vend_cd.value;
	//			gcds_data02.namevalue(gcds_data02.rowposition,"C_VEND_NM")=gcds_c_vend_nm.value;				
				
				//�߷�����
				gcds_data02.namevalue(gcds_data02.rowposition,"JOB_CD")=gcds_job_cd.value;
	//			gcds_data02.namevalue(gcds_data02.rowposition,"JOB_NM")=gcds_job_nm.value;
	

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
	
  if(gcds_ord_cd.bindcolval=="007"){ //����ϰ�� üũ����.
		if(gcds_retgb_cd.bindcolval==""){
			alert("�ͱ������� �����Ͻʽÿ�.");
			return false;
		}
	}else{
		if(chk1.value !="T"&&chk2.value!="T"){
			alert("�μ����� �Ǵ� ���������� ���� �����Ͻʽÿ�.");
			return false;
		}

		if(chk1.value=="T"){
			if(gcds_vend_cd.bindcolval==""){
				alert("�ٹ���ü�� ���� �����Ͻʽÿ�.");
				return false;
			}

			if(gcds_dept_cd.bindcolval==""){
				alert("�μ��� ���� �����Ͻʽÿ�.");
				return false;
			}

			if(gcds_team_cd.bindcolval==""){
				alert("�Ҽ����� ���� �����Ͻʽÿ�.");
				return false;
			}

      if(gcds_c_vend_cd.bindcolval==""){
				alert("����ü�� ���� �����Ͻʽÿ�.");
				return false;
			}
		}
		
		if(chk2.value=="T"){
			if(gcds_job_cd.bindcolval==""){
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
	
		var s_temp = " EMPNO:STRING(10),EMPNMK:STRING(30),"
		
							+  "SEQ:DECIMAL(2),"		

							+ "ORD_DT:STRING(8),ORD_CD:STRING(3),"
							
							+ "ORD_NM:STRING(50),"
							 
							 + "VEND_CD:STRING(10),VEND_NM:STRING(50),"

							 + "DEPT_CD:STRING(10),DEPT_NM:STRING(50),"						
							 
							 + "C_VEND_CD:STRING(10),C_VEND_NM:STRING(50),"
							 
							 + "WORK_CD:STRING(10),WORK_NM:STRING(50),"
							 
							 + "CLASS_CD:STRING(10),CLASS_NM:STRING(50),"
							 
							 + " JOB_CD:STRING(10),JOB_NM:STRING(50),"
							 
							 + " I_EMPNO:STRING(10),I_DATE:STRING(10),"
							 
							 + "U_EMPNO:STRING(10),U_DATE:STRING(10)";

		gcds_data02.SetDataHeader(s_temp);
		
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

<script language="javascript" for="gcds_ks001" event="onloadCompleted(row,colid)">
    ln_Insert_Row2(1,"gcds_ks001","gcds_vend_cd");
</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
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


<!-- �� �� -->
<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ���屸�� -->
<OBJECT id=gcds_dept_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �������� -->
<OBJECT id=gcds_class_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �ٹ����� -->
<OBJECT id=gcds_work_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ���δ��ü -->
<OBJECT id=gcds_c_vend_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>'

<!-- ����-->
<OBJECT id=gcds_job_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �߷ɱ���-->
<OBJECT id=gcds_ks010 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

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
				  <td bgcolor="#eeeeee" width="50" align = center>�� ��</td>
					<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcds_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:70px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gcds_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>										
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('11');">
									</td>					
					
										<td bgcolor="#eeeeee" width="50" align = center>���屸��</td>
										<td bgcolor="#FFFFFF">
										<%=HDConstant.COMMENT_START%>
											<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
											<param name=ComboDataID			value="gcds_ks006">
											<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
											<param name=SearchColumn		value=COM_SNAME>
											<param name=Sort						value=false>
											<param name=Index						value=0>
											<param name=ListExprFormat	value="COM_SNAME^0^100">
											<param name=BindColumn			value=COM_CODE>
											</OBJECT><%=HDConstant.COMMENT_END%>
												</td>					
			
											<td bgcolor="#eeeeee" width="50" align = center>�ٹ�����</td>
											<td bgcolor="#FFFFFF">
													<fieldset class=field_01 style="width:80px;  height: 18px;position:relative; left:2px;  top:1px;">
													<%=HDConstant.COMMENT_START%><OBJECT id=gcds_work_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:70px;  height: 16px;">
															<param name=Alignment			value=0>
															<param name=Border	      value=false>
															<param name=Format	      value="">
															<param name=PromptChar	  value="">
															<param name=UpperFlag     value=1>
															<param name=GeneralEdit   value="true">
															<param name=Enable        value="false">
													</OBJECT>
													<OBJECT id=gcds_work_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
														class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>	
													<%=HDConstant.COMMENT_END%>
													</fieldset>											
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('14');">
												</td>					
				
								<td align="center" width="50" bgcolor="#eeeeee">����</td>
								<td bgcolor="#FFFFFF">
					  			<input type="text" id="txt_empnmk" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find()">
					  <input type="text" id="txt_empno" style="position:relative;;left:8px;width:60px;top:-1px;">&nbsp;
					</td>
				</tr>
			</table>
		  </td>
	    </tr>
		<tr>
			<td>
				<table cellpadding=0 cellspacing=1 style="width:290px;" border="0">
					<tr>
						<td valign="top">
							<font style="position:relative;top:5px;left:0px; color=#0000FF"><b>[�߷ɴ���� ����]</b></font>
							<table cellpadding=0 cellspacing=1 style="position:relative;top:6px;width:409px;" bgcolor="#708090">
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
										<FC>ID=EMPNO,	  Name=����,		width=55,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none sort = true</FC>
										<FC>ID=EMPNMK,	Name=����,		width=60,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</FC>
										<C>ID=VEND_NM,	Name=�Ҽ�,width=70,  	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=DEPT_NM,	Name=���屸��,	width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=WORK_NM,	Name=�ٹ�����,	width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
										<C>ID=JOB_NM,	  Name=������,	width=70,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, edit=none sort = true</C>
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
									<td align="right"  style="position:relative;top:2px"><nobr>
										<font style="position:relative;top:0px;right:170px; color=#0000FF"><b>[�߷�]</b></font>&nbsp;
                    					<!-- <input type="text"		 id=chknm1 value=""  style="position:relative;top:0px;width:170px;border-width:0px" > -->
										<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Order()">
										<img src="<%=dirPath%>/Sales/images/minus.gif"      style="cursor:hand" onClick="ln_Del()" >		
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
										<!-- <img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()"> -->
										</nobr>
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1 style="width:410px;height:100px;" bgcolor="#708090">
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">�߷ɱ���</td>
												<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%>
														<object id=gcds_ord_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
														style="position:relative;left:2px;top:1px;font-size:12px;width:120px;" >
														<param name=ComboDataID			value="gcds_ks010">
														<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
														<param name=SearchColumn		value=COM_SNAME>
														<param name=Sort				    value=false>
														<param name=ListExprFormat	value="COM_SNAME^0^120">
														<param name=BindColumn			value=COM_CODE>
														</object></comment>	<script>__ws__(__NSID__);</script>
												</td>
												
												<td bgcolor="#eeeeee" align="center">�߷�����</td>
												<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
														<OBJECT id=gcds_ord_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
														style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
														<param name=Alignment			value=0>
														<param name=Border	      value=true>
														<param name=Format	      value="YYYY/MM/DD">
														<param name=PromptChar	  value="_">
														</OBJECT><%=HDConstant.COMMENT_END%>
														<img alt=�߷�������ȸ  id='img_search1' style="position:relative;left:15px;cursor:hand" src='<%=dirPath%>/Sales/images/help.gif'  onclick="__GetCallCalendar7('gcem_ord_dt', 'Text');">
												</td>
											</tr>
											
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">�� ��</td>
												<td bgcolor="#FFFFFF">												

					  								<input type="text" id="text_gcds_vend_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;													
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
							 						<img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('01');">
														</td>
																												
												<td bgcolor="#eeeeee" align="center">���屸��</td>
												<td bgcolor="#FFFFFF">
					  								<input type="text" id="text_gcds_dept_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;												
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_dept_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
													 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('02');">
												</td>
											</tr>
												<td bgcolor="#eeeeee" align="center">���δ��ü</td>
												<td bgcolor="#FFFFFF">
					  								<input type="text" id="text_gcds_c_vend_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;												
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_c_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('03');">		
												</td>
												<td bgcolor="#eeeeee" align="center">�ٹ�����</td>
												<td bgcolor="#FFFFFF">
					  								<input type="text" id="text_gcds_work_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;												
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_work_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('04');">
												</td>
											</tr>
											<tr height="22">
												<td bgcolor="#eeeeee" align="center">��������</td>
												<td bgcolor="#FFFFFF">
					  								<input type="text" id="text_gcds_class_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;												
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_class_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('05');">

												</td>
												<td bgcolor="#eeeeee" align="center">����</td>
												<td bgcolor="#FFFFFF">
					  								<input type="text" id="text_gcds_job_nm" style="position:relative;;left:2px;width:100px;top:-1px;">&nbsp;												
													<%=HDConstant.COMMENT_START%>
													<OBJECT id=gcds_job_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
													class="gcem_01" style="width:0px;height: 0px; hidden;">
													</OBJECT>																										
													<%=HDConstant.COMMENT_END%>
										
												 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('06');">
												</td>

											</tr>
										</table><!-- ���� ���̺� 1�� �� -->
									</td>
								</tr>
								<tr>
									<td>
										<table cellpadding=0 cellspacing=1  style="width:390px;height:280px;" bgcolor="#708090">
											<tr>
												<td bgcolor="#FFFFFF">
													<%=HDConstant.COMMENT_START%>
													<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2 style="width:405;height:270px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
													<PARAM NAME="DataID"		VALUE="gcds_data02">
													<PARAM NAME="BorderStyle"   VALUE="0">
													<PARAM NAME="Indwidth"		VALUE="0">
													<PARAM NAME="Fillarea"		VALUE="true">
													<param name="colsizing"   value=true> 
													<param name="sortview"      value=left>
													<PARAM NAME="Format"		VALUE="  
													<C>ID=EMPNO,	  Name=����,		  width=55,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center</C>
													<C>ID=EMPNMK,	  Name=����,		  width=60,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=ORD_NM,	  Name=�߷ɱ���,	width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center </C>
													<C>ID=ORD_DT, 	Name=�߷�����,	width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,  mask='XXXX/XX/XX'</C>
													<C>ID=VEND_NM,	Name=�Ҽ�,	width=50,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center</C>
													<C>ID=DEPT_NM,	Name=���屸��,		  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left</C>
													<C>ID=WORK_NM,	Name=�ٹ�����,	  width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=JOB_NM,	  Name=����,	    width=70,	 HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
													<C>ID=C_VEND_NM,Name=���δ��ü	  width=100, HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
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
						