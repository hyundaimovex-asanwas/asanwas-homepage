<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : ���� �η� �λ���� - �⺻����
+ ������� : �λ� �⺻������ ȭ�� �ϴ��� 3���� ���� �̿��Ͽ� �Է�,����,����,��ȸ�Ѵ�.
+ ���α׷�ID : ks_em010i.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2008.07.22
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em010_S1,      KS_Em010_S2,      KS_Em010_S3 
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

<% String dirPath = request.getContextPath(); 
	java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());		
%>

<!-- HTML ����-->
	<html xmlns="http://www.w3.org/1999/xhtml"><head>

    <jsp:include page="/Sales/common/include/head.jsp" />
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
	
	var chk_tab = "";


/*----------------------------------------------------------------------------
	 * �������ε�
----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]	

			ln_before();//����ȸ			

			window.status="�Ϸ�";

			txt_nm.focus();

		}

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	photo.src="../common/img/00000.gif";
	
	gcte_disp.ActiveIndex = 1;
	
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_S1?"
											 + "v_str1=" + gclx_usts.bindcolval
											 + "&v_str2=" + gclx_cmsosok.bindcolval
											 + "&v_str3=" + txt_nm.value;

	gcds_data00.Reset();

}

/*----------------------------------------------------------------------------
	Description : �系��� ��ȸ
----------------------------------------------------------------------------*/
function ln_OrdQuery() {

	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_S2?"
										 + "v_str1=" + txt_empno.value;
	gcds_data02.Reset();
}

/*----------------------------------------------------------------------------
	Description : �ް� ��ȸ
----------------------------------------------------------------------------*/
function ln_VacQuery() {

	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_S3?"
											 + "v_str1=" + txt_empno.value;
											 
	prompt(this, gcds_data03.DataID);										 
											 
	gcds_data03.Reset();
}
	

	
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//�Ҽ���  KS007
	gcds_cmsosok.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS007";	
	gcds_cmsosok.Reset();
			
	//�з�
	gcds_cm027.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS003";
	gcds_cm027.Reset();

	ln_SetDataHeader();//gcds_data00 �ش�����
}


/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_FindC(e){
		
		ln_Find_s(e);
		
			if(e=="01"){ //�Ҽ�
			
				gcds_tsy010.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cm007?v_str1=KS007";
				gcds_tsy010.Reset();

			}else if(e=="02"){ //���屸��
			
				gcds_tsy010.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";				
				gcds_tsy010.Reset();
				
			}

}

//-----------------------------------------------------------------------

function ln_Find_s(e){

		var arrResult	= new Array();
		var strURL;
		var strPos;
		arrParam = e;
		strURL = "../popup/ks_em_popup.jsp";
		strPos = "dialogWidth:370px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
		
		//prompt (this, arrResult);
		//	gcds_data00.addrow();
			arrParam = arrResult.split(";");
		
		if ( arrParam[0] == '01'){			
			gclx_vend_cd.Text=arrParam[1];							
			gclx_vend_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '02'){	
			gclx_dept_cd.Text=arrParam[1];				
			gclx_dept_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '03'){	
			gclx_job_cd.Text=arrParam[1];				
			gclx_job_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '04'){			
			gclx_work_cd.Text=arrParam[1];
			gclx_work_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '05'){			
			gclx_c_vend_cd.Text=arrParam[1];
			gclx_c_vend_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '06'){			
			gclx_skill_cd.Text=arrParam[1];
			gclx_skill_nm.Text=arrParam[2];
		}else if	( arrParam[0] == '07'){			
			gclx_class_cd.Text=arrParam[1];
			gclx_class_nm.Text=arrParam[2];
		}					

}
}


/*----------------------------------------------------------------------------
	 * ���� �޴�
----------------------------------------------------------------------------*/

function ln_Create(){

	gcds_data00.addrow();
	
	photo.src="../common/img/00000.gif";

	gcds_data00.namevalue(gcds_data00.rowposition,"USESTS") = "1";	

	gcem_empnmk.focus();

}

 /*-----------------------------------------------------------------------------
	Description : Dataset Head ���� - gcds_data00
-----------------------------------------------------------------------------*/
	function ln_SetDataHeader(){
			if(gcds_data00.countrow<1){
				var s_temp = "CUST_SID:DECIMAL(10),"
									 + "USESTS:STRING(1),"
									 + "EMPNMK:STRING(30),"				
									 + "EMPNO:STRING(10),"
									 + "SEX:STRING(1),"	
									 
									 + "BIRTHDAY:STRING(8),"
									 + "RECOMMEND:STRING(1),"								 
									 + "START_DT:STRING(8),"
									 + "END_DT:STRING(8),"
									 
									 + "VEND_CD:STRING(10),"
									 + "VEND_NM:STRING(20),"									 						 
									 + "DEPT_CD:STRING(10),"
									 + "DEPT_NM:STRING(20),"
									 + "JOB_CD:STRING(10),"
									 + "JOB_NM:STRING(20),"	
									 
									 + "WORK_CD:STRING(10),"
									 + "WORK_NM:STRING(20),"
									 + "C_VEND_CD:STRING(10),"
									 + "C_VEND_NM:STRING(20),"
									 + "SKILL_CD:STRING(10),"
									 + "SKILL_NM:STRING(20),"
									
									 + "CLASS_CD:STRING(10),"
									 + "CLASS_NM:STRING(20),"
									 + "CON_YEAR:DECIMAL(2),"									 
									 
									 + "I_DATE:STRING(20),"
									 + "U_DATE:STRING(20),"
									 + "I_EMPNO:STRING(10),"
									 + "U_EMPNO:STRING(10),"

									 + "ADDRESS:STRING(50),"
									 + "HEIGHT:DECIMAL(4),"
									 + "WEIGHT:DECIMAL(4),"
									 
									 + "BLOOD:STRING(2),"
									 + "ATT_CD:STRING(2),"

									 + "SCH_NM:STRING(30),"
									 + "FAMILY:DECIMAL(2),"									 
									 + "MARRIED:STRING(1)";
								 					
				gcds_data00.SetDataHeader(s_temp);
				
		}
	}

/*-----------------------------------------------------------------------------
	Description : PrintDataset Head ���� - gcds_data00
-----------------------------------------------------------------------------*/
function ln_SetPrintDataHeader(){
		if(gcds_report0.countrow<1){
				var s_temp = "CUST_SID:DECIMAL(10),"
									 + "USESTS:STRING(1),"
									 + "EMPNMK:STRING(30),"				
									 + "EMPNO:STRING(10),"
									 + "SEX:STRING(1),"	
									 
									 + "BIRTHDAY:STRING(8),"
									 + "RECOMMEND:STRING(1),"								 
									 + "START_DT:STRING(8),"
									 + "END_DT:STRING(8),"
									 
									 + "VEND_CD:STRING(10),"
									 + "VEND_NM:STRING(20),"									 						 
									 + "DEPT_CD:STRING(10),"
									 + "DEPT_NM:STRING(20),"
									 + "JOB_CD:STRING(10),"
									 + "JOB_NM:STRING(20),"	
									 
									 + "WORK_CD:STRING(10),"
									 + "WORK_NM:STRING(20),"
									 + "C_VEND_CD:STRING(10),"
									 + "C_VEND_NM:STRING(20),"
									 + "SKILL_CD:STRING(10),"
									 + "SKILL_NM:STRING(20),"
									
									 + "CLASS_CD:STRING(10),"
									 + "CLASS_NM:STRING(20),"
									 + "CON_YEAR:DECIMAL(2),"										 
									 
									 + "I_DATE:STRING(20),"
									 + "U_DATE:STRING(20),"
									 + "I_EMPNO:STRING(10),"
									 + "U_EMPNO:STRING(10),"

									 + "ADDRESS:STRING(50),"
									 + "HEIGHT:DECIMAL(4),"
									 + "WEIGHT:DECIMAL(4),"
									 
									 + "BLOOD:STRING(2),"
									 + "ATT_CD:STRING(2),"

									 + "SCH_NM:STRING(30),"
									 + "FAMILY:DECIMAL(2),"									 
									 + "MARRIED:STRING(1)";

			gcds_report0.SetDataHeader(s_temp);
	}
	
}

/*----------------------------------------------------------------------------
	Description : ���� - �λ縶����
----------------------------------------------------------------------------*/
function ln_Save(e){
      
      if(!ln_Save_Chk(e)) return; 
      
			if(e=='01'){ //�⺻
			    
			    var s_date = gcem_start_dt.text.substring(2,4);		//������ �߿� �ڿ� �⵵ 2�ڸ�, ���� ������� �ʿ�??
					
					//prompt('',gcds_data00.text);
					
					if (gcds_data00.IsUpdated) {
					
						 if(confirm("�����Ͻðڽ��ϱ�?")){
						
								gctr_data00.KeyValue = "KS_Em010_T1(I:USER=gcds_data00)";
						
								gctr_data00.Parameters ="v_str1="+s_date+",v_str2="+"6060002";			//�ӽ÷� �� ��� ����
						
								gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_T1";
						
						//		prompt('',gctr_data00.Parameters);
						
								gctr_data00.post();
					
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
						gctr_data00.KeyValue = "KS_Em010_T1(I:USER=gcds_data00)";
						gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_T1";
						gctr_data00.post();
				}
		} else if (e=='02') { //�系���
        if(!ln_Save_Chk(e)) return;
  
				if (confirm("������ ������ �����Ͻðڽ��ϱ�?")) {
						gcds_data02.deleterow(gcds_data02.rowposition);
						gctr_data02.KeyValue = "KS_Em010_T2(I:USER=gcds_data02)";
						gctr_data02.Parameters ="v_str1="+useid;
						gctr_data02.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_T2";
						//prompt('',gcds_data02.text);
						gctr_data02.post();
				}
		}
}



/*----------------------------------------------------------------------------
	Description : Excel - �λ縶����
----------------------------------------------------------------------------*/
  function ln_Excel(){
    var szName = "��������";
    var szPath = "C:\\Test\\ks_em010i.xls";
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
/*
	if(gbn=="01"){ //�⺻����
		if(gcem_start_dt.text==""){
			alert("�������� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_vend_cd.text==""){
			alert("�Ҽ��� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_dept_cd.text==""){
			alert("���屸���� �Է��Ͻʽÿ�.");
			return false;
		}

    	if(gclx_job_nm.text==""){
			alert("������ �Է��Ͻʽÿ�.");
			return false;
		}
    	if(gclx_work_nm.text==""){
			alert("�ٹ������� �Է��Ͻʽÿ�.");
			return false;
		}
		if(gclx_c_vend_cd.text==""){
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
	*/
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
        
    var  dirFold = gcds_data00.namevalue(gcds_data00.rowposition,"EMPNO").substring(0,1)+"/"; 

		//�λ�⺻����
		gcds_report0.ClearAll();
		
		ln_SetPrintDataHeader();
  		
  		gcds_report0.ImportData(gcds_data00.ExportData(gcds_data00.rowposition,1,false));
	  	gcds_report0.rowposition =  gcds_data00.rowposition;

		gcds_report0.namevalue(gcds_report0.rowposition,"PIC_DIR") = rDOMAIN+"<%=dirPath%>/Sales/file/photo/cust/"+dirFold+gcds_report0.namevalue(gcds_report0.rowposition,"MANAGE_NO")+".JPG";
    	gcds_report0.namevalue(gcds_report0.rowposition,"CUR_DT") =gs_date;
      	
		//�系���
		gcds_report2.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_S2?"
											  + "v_str1=" + txt_empno.value;
	  	gcds_report2.Reset();
    
		//�ް�
		gcds_report6.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_S6?"
											  + "v_str1=" + txt_empno.value;
	  	gcds_report6.Reset();
   

}
</script>
<%/*=============================================================================
				Developer Java Script ��
=============================================================================*/%>





<%/*=============================================================================
			Gauce Components Event Scripts ����
=============================================================================*/%>

<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	
	if (gcds_data00.countrow>0) {
		if (index=="2") 			ln_OrdQuery();         //�系��� ��ȸ
		else if (index=="3")	ln_VacQuery();  		//�ް���ȸ
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
						gcra_sex.Enable=true;
						gcra_recommend.Enable=true;
						gcem_birthday.Enable=true;
						gcem_start_dt.readonly=false;
						gcem_end_dt.readonly=false;
						gclx_job_nm.Enable=true;
						gclx_vend_nm.Enable=true;
						gclx_dept_nm.Enable=true;
						gclx_work_nm.Enable=true;
						gcem_empnmk.Enable=true;
						gclx_c_vend_nm.Enable=true;

				}
			

						if(chk_tab=='2'){
						
							ln_OrdQuery();//�系���
							
						}else if(chk_tab=='3'){
						
							ln_VacQuery();//�ް�

						}
</script>

<script language=JavaScript for=gcgd_disp05 event=OnCloseUp(row,colid)>
	if(row>0 && colid=="LCS_TYPE"){
		gcds_cm030.Filter();
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

<!-- �ް� -->
			<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt6.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
			</script>



 <script language=JavaScript for=gcrp_print event=OnError()>
	alert("Error Code =" + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
				window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>


<!-- �ٹ�����  -->
<script language="javascript" 	for="gcds_cmsosok" event="onloadCompleted(row,colid)">
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
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>


<!-- �����ڵ� DataSet ���� ------------------------------------------------------------------------------------>

<!-- �Ҽ�  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_KS001 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- ����  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_KS002 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>


<!-- �з�  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_KS003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- �Ҽ� ���ε�  -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_cmsosok classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!-- �з� -->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_cm027 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 >
	<PARAM NAME="SyncLoad" VALUE="false">
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


<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>

<jsp:include page="/Common/sys/body_s.jsp" flush="true" />

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<body><table border="0" cellpadding="0" cellspacing="0" width="829" height="495" bordercolor="orange">
	<tbody><tr height="20px">
		<td align="left" colspan="3"><!-- ��ư ���� ����-->
		<table width="825" border="0" cellspacing="0" cellpadding="0">
						<tbody><tr>
							<td align="right" height="30px">		
							  	<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"  onclick="ln_Create()">  
                				<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor: hand" onclick="ln_Query()" />
                				<img src="<%=dirPath%>/Sales/images/save.gif" style="cursor: hand" onclick="ln_Save('01')" />
								<img src="<%=dirPath%>/Sales/images/print.gif" style="cursor: hand" onclick="ln_Print()" />
								<img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor: hand" onclick="ln_Excel('01')" />
							</td>
					</tr>																		
		</tbody></table>
		</td><!-- ��ư ���� ��-->
	</tr>
	<tr>
<!-- ��Ģ �׸��� ���� ����-->
	<td align="left" width="175px" height="494" valign="top">
		<table height="0" border="1" cellpadding="0" cellspacing="1" >
						<!-- <tr height="35px"> -->
						<tbody><tr height="40">
							<td width="px" align="center" bgcolor="#eeeeee" style="width: 80px" cellpadding="1">����<br />����</td>
							<td width="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><object id="gclx_usts" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 100px">
									<param name="CBData" value="^��ü,1^����^,3^����" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="1" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^70" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
								</object><%=HDConstant.COMMENT_END%>
								<!-- <input type=text id="txt_nm" class="txt_a01" style="width:80px;top:0px;" maxlength=30> -->
								</td>
						</tr>
						<tr height="40">
							<td align="center" bgcolor="#eeeeee">�Ҽ�<br />����</td>
							<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
							<object id="gclx_cmsosok" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 100px">
														<param name="ComboDataID" value="gcds_cmsosok" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^100" />
														<param name="BindColumn" value="COM_CODE" />
												</object><%=HDConstant.COMMENT_END%>
							</td>
						</tr>
						<tr height="40">
							<td align="center" bgcolor="#eeeeee">����</td>
							<td bgcolor="#FFFFFF">
								<input type="text" id="txt_nm" class="" style="position: relative; left: 5px; width: 100px; top: 0px" maxlength="30" onkeydown="if(event.keyCode==13)ln_Query();" />
								<input type="hidden" id="txt_usts" style="width: 80px; top: 0px" maxlength="1" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%>
									<object id="gcgd_disp" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height: 327; width: 170">
										<param name="DataID" value="gcds_data00" />
										<param name="BorderStyle" value="0" /> 
										<param name="indwidth" value="0" />
										<param name="fillarea" value="true" />
										<param name="Colsizing" value="true" />
										<param name="Editable" value="false" />
										<param name="headlinecolor" value="#999999" />
										<param name="sortview" value="left" />
										<param name="format" value='
											<FC>ID=EMPNO    	Name="����",  		width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<FC>ID=EMPNMK    	Name="����",  		width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<C>ID=JOB_NM    	Name="����",  		width=60,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true, align="left"</C>
											<C>ID=VEND_NM   	Name="�Ҽ�", 		width=70,     HeadBgColor=#B9D4DC,	HeadAlign=center , sort = false, align="left"</C>
											<C>ID=DEPT_NM   	Name="���屸��",  	width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , align="left"</C>
											<C>ID=WORK_NM   	Name="�ٹ���",	width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , align="left"</C>
										' />
								</object><%=HDConstant.COMMENT_END%>									
								<fieldset bgcolor="#FFFFFF" style="width: 170; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left; bgcolor: #ffffff">
									&nbsp;<font id="ft_cnt1" style="position:relative;top:4px;">
								</font></fieldset>
							</td>
					</tr>
		</tbody></table>
	</td>
	

<!-- ��Ģ �׸��� ���� ��-->
	<td width="10"></td><!-- �߰� ����κ� -->
	<td width="649" valign="top"><!-- ���� ���̺� ��� ����-->
		<table width="649" height="473" border="0" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td width="125" valign="top">
					<table width="125" height="159" border="1" cellpadding="0" cellspacing="1">
						<tbody><tr>
							<td align="center" bgcolor="#FFFFFF">
								<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border="0" width="100px" height="131px" style="position: relative; top: 2px" />
								<!-- <img id="photo" src="worker/9080001.jpg" border=0 width="100px" height="124px" style="position:relative;top:2px;"> -->
							</td>
							</tr>
							<tr>
								<td align="center" bgcolor="#FFFFFF" height="22">&nbsp;
								<!-- 	  ���� �ΰ� ����ȿ! <input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
									style="position:relative;left:0px;top:0px;width:80; height:25;">
									<param name="Text"		value="ã�ƺ���">
									<param name="Enable"  value="true">
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td align="center" bgcolor="#FFFFFF" height="22">&nbsp;
								</td>
							</tr>
						</tbody></table>
				</td>
				<td width="524" align="left" valign="top">
						<table width="539" cellpadding="0" cellspacing="1"
							bgcolor="#708090" border="0">
							<tbody>
								<tr height="23">
									<td width="80" bgcolor="#eeeeee">&nbsp;����</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcem_empnmk"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 80px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="###############" />
										<param name="GeneralEdit" value="true" />
									</object><%=HDConstant.COMMENT_END%></td>
									<td bgcolor="#eeeeee" width="93">&nbsp;����</td>
									<td bgcolor="#FFFFFF" width="171"><input type="text"
										id="txt_empno" class="txt_a01"
										style="position: relative; left: 8px; width: 75px; background-color: #ccffcc"
										readonly="readonly" /></td>
									<!-- </form> -->
								</tr>

								<tr height="22">
									<td bgcolor="#eeeeee">&nbsp;����</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcra_sex"
										classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
										style="position: relative; left: 0px; top: 0px; height: 20; width: 80; cursor: hand">
										<param name="Cols" value="2" />
										<param name="Format" value="M^��,F^��" />
									</object><%=HDConstant.COMMENT_END%></td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;�������</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%><object
										id="gcem_birthday"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnly" value="false" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
								<tr height="22">									
									<td bgcolor="#eeeeee">&nbsp;�˼���</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%>
									<object id="gcra_recommend"	classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
										style="position: relative; left: 0px; top: 0px; height: 20; width: 120; cursor: hand">
										<param name="Cols" value="2" />
										<param name="Format" value="Y^����,N^������" />
									</object><%=HDConstant.COMMENT_END%></td>								
									<td bgcolor="#eeeeee" width="93">&nbsp;����</td>
									<td bgcolor="#FFFFFF" width="170">
								</tr>																						
								<tr height="22">									
									<td bgcolor="#eeeeee">&nbsp;������</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcem_start_dt"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
									<!--	<param name="ReadOnlyBackColor" value="#CCFFCC" /> -->
									</object><%=HDConstant.COMMENT_END%></td>									
									<td bgcolor="#eeeeee" width="93">&nbsp;������</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%>
									<object
										id="gcem_end_dt"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnly" value="false" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>																
								<tr height="22">									
									<td  bgcolor="#eeeeee">&nbsp;�Ҽ�</td>
									<td  bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="true">
										</OBJECT>
										<OBJECT id=gclx_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('01');">
									</td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;���屸��</td>
									<td  bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_dept_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gclx_dept_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>											
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('02');">
									</td>
								</tr>
								<tr height="22">
									<td bgcolor="#eeeeee">&nbsp;����</td>
									<td bgcolor="#FFFFFF">										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%>
										<OBJECT id=gclx_job_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gclx_job_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('06');">
									</td>
									<td bgcolor="#eeeeee" width="93">&nbsp;�ٹ�����</td>
									<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_work_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gclx_work_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>	
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('04');">
									</td>
								</tr>
								<tr height="22">									
									<td bgcolor="#eeeeee">&nbsp;���δ��ü</td>
									<td bgcolor="#FFFFFF">
										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_c_vend_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gclx_c_vend_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('03');">
									</td>																		
									<td bgcolor="#eeeeee" width="93">&nbsp;�ڰݱ���</td>
									<td bgcolor="#FFFFFF">										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_skill_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT>
										<OBJECT id=gclx_skill_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('08');">
									</td>
								</tr>
								<tr height="22">								
									<td bgcolor="#eeeeee" width="93">&nbsp;��������</td>
									<td  bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gclx_class_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="true">
										</OBJECT>
										<OBJECT id=gclx_class_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:0px;height: 0px; hidden;">
										</OBJECT>										
										<%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_FindC('07');">
									</td>																	
									<td bgcolor="#eeeeee" width="93">&nbsp;�ټӳ���</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%>
									<object id="gcem_con_year" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" tabindex="1"
										style="position:relative;left:8px;top:1px; width: 50px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="2" />
										<param name="ReadOnly" value="true" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
										<param name="Border" value="true" />
										<param name="MaxLength" value="2" />
										<param name="PromptChar" value="_" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
							</tbody>
						</table>
						</td>
			</tr>
			<tr height="1"><td colspan="3"></td></tr>
			<tr height="20">
				<td colspan="3" valign="top">
					<%=HDConstant.COMMENT_START%><object id="gcte_disp" classid="clsid:ED382953-E907-11D3-B694-006097AD7252" style="position:relative;left:2px;width:650px;height:20px">
					<param name="BackColor" value="#cccccc" />
					<param name="titleHeight" value="20px" />
					<param name="DisableBackColor" value="#eeeeee" />
					<param name="Format" value="
					<T>divid=layer1  title='�⺻'</T>									
					<T>divid=layer2  title='�系���'</T>
					<T>divid=layer3  title='�ް�'</T>
					" />
					</object><%=HDConstant.COMMENT_END%>
				</td>
			</tr>
			<tr height="230">
				<td>
<!---------[TAB 1] left:200px;�⺻���� ----------->
						<div id="layer1" style="position: absolute; top: 360px; left: 350px;">
							<table style="position:relative;top:4px;left:-2px; border:0 solid #708090; border-bottom-width: 0px" cellpadding="0" cellspacing="0" border="0">
								<!-- �ּҺκ� -->
                 					<tbody><tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 1 solid #708090; border-bottom-width:0px;width:662px;" cellpadding="0" cellspacing="0" border="0">
													<tbody>
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee">�� ��</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">���ּ�</td>
														<td class="tab22" width="524px" >
															<input type="text" id=txt_address class="txt11" style="position:relative;left:8px;width:400px;" maxlength="300">  
														 </td>
													</tr>
													</tbody>
											  </table>
										</td>
								 </tr>
								  <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:662px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >��ü����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">����</td>
														<td class="tab22" width="130px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_height" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (cm)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">ü��</td>
														<td class="tab22" width="130px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_weight" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (kg)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">������</td>
														<td class="tab22" width="144px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_blood" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 30px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
																	<param name="Alignment" value="0" />
																	<param name="Border" value="true" />
																	<param name="format" value="AA" />
																	<param name="UpperFlag" value="1" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														</td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:662px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >�з»���</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">�����з�</td>
														<td class="tab22"  width="130px">
															<%=HDConstant.COMMENT_START%>
																<object id="gclx_att_cd" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 8px; top: 1px; font-size: 12px; width: 80px">
																	<param name="ComboDataID" value="gcds_cm027" />
																	<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
																	<param name="SearchColumn" value="COM_SNAME" />
																	<param name="Sort" value="false" />
																	<param name="ListExprFormat" value="COM_SNAME^0^100" />
																	<param name="BindColumn" value="COM_CODE" />
															 </object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center" >�б���</td>
														<td class="tab22" width="336px" >
															<input type="text" id="txt_sch_nm" class="txt11" style="position: relative; left: 8px; width: 80px" maxlength="20" />
														</td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>								 
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:662px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >��������</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">������</td>
														<td class="tab22" width="130px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_family" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: ����; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (��)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">��ȥ</td>
														<td class="tab22" width="336px" bgcolor="#FFFFFF" colspan="3"><%=HDConstant.COMMENT_START%><object
															id="gcra_married"
															classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
															style="position: relative; left: 0px; top: 0px; height: 20; width: 100; cursor: hand">
															<param name="Cols" value="2" />
															<param name="Format" value="N^��ȥ,Y^��ȥ" />
														</object><%=HDConstant.COMMENT_END%></td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>								 							 						 
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:662px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" >��Ÿ����</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee" align="center">�⺻��</td>
														<td class="tab22" width="535px" >
															<%=HDConstant.COMMENT_START%>
															<object id="gcem_f_pay" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" tabindex="1" style="position:relative;left:8px;top:3px;width:50px;height:20px; font-family: ����; font-size: 9pt; ">
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="ReadOnly" value="true" />
														      <param name="ReadOnlyBackColor" value="#CCFFCC" />
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp; <font style="position:relative;top:-3px;">(����⺻��)
														</font></td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>
							</tbody></table>
						</div>
						<!---------[TAB 2] �系��� �׸���----------->
						<div id="layer2" style="position: absolute;top:364px;left:348px; visibility: hidden; border: 1 solid #708090">
							<table cellpadding="0" cellspacing="0" border="0" style="width:660px;">
								<tbody><tr>
									<td height="30px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position:relative;top:0px; cursor: hand" onclick="ln_OrdQuery()" />
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width: 639; border: 0 solid #708090; border-top-width: 1px" colspan="2">
										<%=HDConstant.COMMENT_START%><object id="gcgd_disp02" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width: 647; height: 179">
												<param name="dataid" value="gcds_data02" />
												<param name="BorderStyle" value="0" /> 
												<param name="indwidth" value="0" />
												<param name="fillarea" value="true" />
												<param name="headlinecolor" value="#999999" />
												<param name="format" value='
													<F> Name=NO				ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=40,  align=center </F> 
													<F> Name=�߷�����		ID=ORD_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=90,	 align=center, MASK="XXXX/XX/XX"</F> 
													<C> Name=�߷ɱ��� 	ID=ORD_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  </C> 
													<C> Name=�Ҽ� 			ID=VEND_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  </C> 
													<C> Name=�ٹ�����		ID=WORK_NM, HeadAlign=Center HeadBgColor=#B9D4DC Width=90  </C> 
													<C> Name=����			ID=JOB_NM,  HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align="left"</C>
													<C> Name=���			ID=REMARK,  HeadAlign=Center HeadBgColor=#B9D4DC Width=140, ,align="left"</C>
													' />
										</object><%=HDConstant.COMMENT_END%>
										<fieldset style="width:660px; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left">
											&nbsp;<font id="ft_cnt2" style="position:relative;top:4px;">
										</font></fieldset>
									</td>
								</tr>
							</tbody></table>
						</div>
						<!---------[TAB 3] �ް� �׸���----------->
						<div id="layer3" style="position: absolute; top: 364px; left:348px; visibility: hidden; border: 1 solid #708090">
							<table cellpadding="0" cellspacing="0" border="0" style="width:660px;">
								<tbody><tr>
									<td height="30px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position: relative; top: 0px; cursor: hand" onclick="ln_VacQuery()" />
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width:639; border: 0 solid #708090; border-top-width: 1px" colspan="2">
										<%=HDConstant.COMMENT_START%><object id="gcgd_disp06" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width: 647; height: 179">
												<param name="dataid" value="gcds_data03" />
												<param name="BorderStyle" value="0" /> 
												<param name="indwidth" value="0" />
												<param name="fillarea" value="true" />
												<param name="Editable" value="false" />
												<param name="AllShowEdit" value="true" />
												<param name="Colsizing" value="true" />
												<param name="headlinecolor" value="#999999" />
												<param name="format" value='
												<F> Name=NO			    	 ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=center</F>
												<C> Name=�Ҽ�		       	 ID=VEND_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center </C>
												<C> Name=�ް�������		 ID=START_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center Mask="XXXX/XX/XX"</C>
												<C> Name=�ް�������		 ID=END_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center Mask="XXXX/XX/XX"</C>
												<C> Name=�ް��ϼ�			 ID=H_DAY,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right </C>
												<C> Name=�ް�����			 ID=H_RES,	HeadAlign=Center HeadBgColor=#B9D4DC Width=280  align=left  </C>
												' />
										</object><%=HDConstant.COMMENT_END%>
										<fieldset style="width: 660; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left">
											&nbsp;<font id="ft_cnt6" style="position:relative;top:4px;">
										</font></fieldset>
									</td>
								</tr>
							</tbody></table>
						</div>

<!-- ����Ÿ���ε� ���Ǻκ� -->
						<%=HDConstant.COMMENT_START%><object id="gcbn_data00" classid="clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49">
						<param name="DataID" value="gcds_data00" />
						<param name="ActiveBind" value="true" />
						<param name="BindInfo" value="
								<C>Col=USTS           			Ctrl=txt_usts									Param=value</C>
								<C>Col=EMPNMK           		Ctrl=gcem_empnmk						Param=Text</C>
								<C>Col=EMPNO            		Ctrl=txt_empno								Param=value</C>
								<C>Col=BIRTHDAY         		Ctrl=gcem_birthday						Param=Text</C>
								<C>Col=SEX              			Ctrl=gcra_sex								Param=codevalue</C>
								<C>Col=START_DT         		Ctrl=gcem_start_dt						Param=Text</C>
								<C>Col=VEND_CD          		Ctrl=gclx_vend_cd						Param=Text</C>
								<C>Col=VEND_NM          		Ctrl=gclx_vend_nm						Param=Text</C>
								<C>Col=DEPT_CD          		Ctrl=gclx_dept_cd						Param=Text</C>
								<C>Col=DEPT_NM          		Ctrl=gclx_dept_nm						Param=Text</C>
								<C>Col=JOB_CD            		Ctrl=gclx_job_cd							Param=Text</C>		
								<C>Col=JOB_NM           		Ctrl=gclx_job_nm							Param=Text</C>							
								<C>Col=WORK_CD        		Ctrl=gclx_work_cd						Param=Text</C>
								<C>Col=WORK_NM          		Ctrl=gclx_work_nm						Param=Text</C>
								<C>Col=C_VEND_CD          	Ctrl=gclx_c_vend_cd					Param=Text</C>
								<C>Col=C_VEND_NM			Ctrl=gclx_c_vend_nm   				Param=text</C>
								<C>Col=SKILL_CD         		Ctrl=gclx_skill_cd							Param=Text</C>	
								<C>Col=SKILL_NM         		Ctrl=gclx_skill_nm						Param=Text</C>
								<C>Col=CLASS_CD          	Ctrl=gclx_class_cd						Param=Text</C>		
								<C>Col=CLASS_NM          	Ctrl=gclx_class_nm						Param=Text</C>																
								<C>Col=CON_YEAR         		Ctrl=gcem_con_year					Param=Text</C>
								<C>Col=RECOMMEND           Ctrl=gcra_recommend					Param=codevalue</C>
								<C>Col=MARRIED              		Ctrl=gcra_married					Param=codevalue</C>								
								<C>Col=FAMILY             			Ctrl=gcem_family						Param=text</C>								
								<C>Col=CUST_SID        			Ctrl=gcem_cust_sid 					Param=Text</C>
								<C>Col=ADDRESS							Ctrl=txt_address 					Param=value</C>
								<C>Col=HEIGHT								Ctrl=gcem_height   					Param=text</C>
								<C>Col=WEIGHT								Ctrl=gcem_weight   					Param=text</C>
								<C>Col=BLOOD								Ctrl=gcem_blood    					Param=text</C>
								<C>Col=ORD_CD								Ctrl=gclx_ord_cd    				Param=bindcolval</C>
								<C>Col=END_DT								Ctrl=gcem_end_dt  				  Param=text</C>
								<C>Col=ATT_CD								Ctrl=gclx_att_cd    				Param=bindcolval</C>
								<C>Col=SCH_NM								Ctrl=txt_sch_nm    				  Param=value</C>
								<C>Col=F_PAY								Ctrl=gcem_f_pay    				  Param=text</C>
								<C>Col=PICTURE							Ctrl=gcip_file    				  Param=value</C>						
							" />
						</object><%=HDConstant.COMMENT_END%>

				</td>
			</tr>
	</tbody></table><!-- ���� ���̺� ��� ��-->
</td>
</tr>
</tbody></table>

<%=HDConstant.COMMENT_START%><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F">
	<param name="MasterDataID" value="gcds_report0" />
	<param name="PaperSize" value="A4" />	
	<param name="LandScape" value="0" />
  <param name="PrintSetupDlgFlag" value="true" />
	<param name="PreviewZoom" value="100" />
	<param name="Format" value="
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
	<X>left=389 ,top=206 ,right=574 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=394 ,top=212 ,right=569 ,bottom=267 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=273 ,right=574 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=341 ,right=574 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=407 ,right=1934 ,bottom=474 ,border=true</X>
	<X>left=389 ,top=407 ,right=574 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=474 ,right=574 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='EMPNMK', left=585, top=212, right=794, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=1640, top=212, right=1868, bottom=267, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�������' ,left=929 ,top=280 ,right=1103 ,bottom=336 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=273 ,right=1635 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=1455 ,top=278 ,right=1630 ,bottom=333 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=341 ,right=1109 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�Ի���' ,left=929 ,top=347 ,right=1103 ,bottom=402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=341 ,right=1635 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�����' ,left=1455 ,top=347 ,right=1630 ,bottom=402 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=394 ,top=413 ,right=569 ,bottom=468 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=407 ,right=1109 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��  ��' ,left=929 ,top=413 ,right=1103 ,bottom=468 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=407 ,right=1635 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�Ի籸��' ,left=394 ,top=476 ,right=569 ,bottom=532 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=474 ,right=1635 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=550 ,right=574 ,bottom=614 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<I>id='PIC_DIR' ,left=111 ,top=209 ,right=389 ,bottom=540</I>
	<T>id='��  ��' ,left=405 ,top=556 ,right=553 ,bottom=609 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='ORD_NM', left=585, top=479, right=905, bottom=534, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BIRTHDAY', left=1117, top=280, right=1437, bottom=336, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX_NM', left=1640, top=280, right=1926, bottom=336, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_DT', left=1117, top=347, right=1437, bottom=402, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='END_DT', left=1640, top=347, right=1926, bottom=402, align='left' ,mask='XXXX��XX��XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1117, top=413, right=1437, bottom=468, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=389 ,top=614 ,right=574 ,bottom=677 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=929 ,top=677 ,right=1114 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1455 ,top=677 ,right=1640 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1455 ,top=868 ,right=1640 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=929 ,top=868 ,right=1114 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='��Ÿ����' ,left=209 ,top=910 ,right=376 ,bottom=966 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='�����з�' ,left=405 ,top=870 ,right=553 ,bottom=923 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=405 ,top=934 ,right=553 ,bottom=987 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='��  ��' ,left=942 ,top=870 ,right=1090 ,bottom=926 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='ü  ��' ,left=942 ,top=934 ,right=1090 ,bottom=990 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=931 ,right=1640 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1455 ,top=741 ,right=1640 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='cm' ,left=661 ,top=937 ,right=709 ,bottom=992 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HEIGHT', left=582, top=937, right=656, bottom=992, align='right' ,mask='XXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='WEIGHT', left=1122, top=937, right=1196, bottom=992, align='right' ,mask='XXX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='kg' ,left=1201 ,top=937 ,right=1249 ,bottom=992 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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



<B>id=Footer ,left=0 ,top=2680 ,right=2000 ,bottom=2870 ,face='����' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=108 ,top=85 ,right=1934 ,bottom=164</T>
	<L> left=108 ,top=74 ,right=1934 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../common/img/icon.jpg' ,left=1487 ,top=85 ,right=1868 ,bottom=175</I>
</B>

" />
</object><%=HDConstant.COMMENT_END%>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp" flush="true" />		


</body></html>





