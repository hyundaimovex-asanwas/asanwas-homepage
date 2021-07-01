<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �ް����
+ ���α׷�ID : ks_em27i.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2008.10.06
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : KS_Em027_S1.java  KS_Em027_t1.java
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
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

		
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em027_S1"
											 + "?v_str1=" + fn_trim(gclx_dept_cd_s.bindcolval)	  // �μ�          
											 + "&v_str2=" + fn_trim(txt_empno_s.value)			      // ���       
											 + "&v_str3=" + fn_trim(txt_empnmk_s.value)	      		// ����       
											 + "&v_str4=" + fn_trim(gcem_start_dt.text) 		  	// �ް�����FR 
											 + "&v_str5=" + fn_trim(gcem_end_dt.text);			      // �ް�����TO 
								 
		gcds_data.Reset();
	
}

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//������  KS006
	gcds_ks006.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em010_Cmsosok?v_str1=KS006";	
	gcds_ks006.Reset();
	
	
	//�ް�����
	gcds_ks019.DataID="<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s1?v_str1=KS019";
	gcds_ks019.Reset();

	gcem_start_dt.text = gs_date1;
   	gcem_end_dt.text = gs_date2;

	gcem_start_dt_s.text = gs_date2;
   	gcem_end_dt_s.text = gs_date2;
	//	prompt('',gcem_start_dt.text);


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
		
		gctr_data.KeyValue = "KS_Em027_t1(I:USER=gcds_data)";
		
		gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em027_t1?";
		
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
		
			gctr_data.KeyValue = "KS_Em027_t1(I:USER=gcds_data)";
			
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em027_t1?";
			
			gctr_data.Parameters = "v_str1="+gusrid;
			
			//prompt('',gcds_data.text);
			
			gctr_data.post();
			
		}
	}
}



/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(e){//��ȸ
	gcds_data.clearAll();
  	var arrParam	= new Array();  
 	var strURL   = "./ks_com_pop2.jsp"; 
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";	
	var arrResult = showModalDialog(strURL,window,strPos);
  
      if (arrResult != null) {     
        arrParam = arrResult.split(";");        
        txt_empno.value = arrParam[0];        
        txt_empnmk.value = arrParam[1];       
        gcem_dept_nm.value = arrParam[2];    
        gcem_dept_cd.value = arrParam[3]; 
       }       
       else{
        txt_empno.value = "";
        txt_empnmk.value = "";
      }      
		//prompt(this, arrResult);		
}

/*----------------------------------------------------------------------------
	Description : �����ϱ�
----------------------------------------------------------------------------*/
function ln_Create(){

	if(!ln_Create_Chk()) return;
	
	var diff;
	
	diff = ln_Day_Chk(gcem_start_dt_s.text,gcem_end_dt_s.text);	
	
	gcds_day_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_KS_EM%>KS_Em_com_s2?v_str1=" + gcem_start_dt_s.text + "&v_str2=" +gcem_end_dt_s.text ;
	gcds_day_cd.Reset();	  	
	

	ln_SetDataHeader();
	
				var start_day = gcem_start_dt_s.text;
				
				var end_day = gcem_end_dt_s.text;
	
				var yymm = start_day.substring(0,6);				
				
				var dd = start_day.substring(6,8);
		
		for(i=1;i<=diff;i++){
		
				gcds_data.addrow();
						
				var nextdd = dd++;
				
				var nextday = yymm + nextdd;
	      		
				//�ް�����
	      		gcds_data.namevalue(gcds_data.rowposition,"HOL_DT") = nextday ;

				//����
	      		gcds_data.namevalue(i,"DAY_CD") = gcds_day_cd.namevalue(i,"DAY_CD");

			  	//���屸��
				gcds_data.namevalue(gcds_data.rowposition,"DEPT_CD")=gcem_dept_cd.value;
				gcds_data.namevalue(gcds_data.rowposition,"DEPT_NM")=gcem_dept_nm.value;

			  	//���� �� ����				
				gcds_data.namevalue(gcds_data.rowposition,"EMPNO")=txt_empno.value;
				gcds_data.namevalue(gcds_data.rowposition,"EMPNMK")=txt_empnmk.value;
	
			  	//�ް�����				
				gcds_data.namevalue(gcds_data.rowposition,"HOL_GB")=gcra_hol_gb.bindcolval;
				
			}

}

/******************************************************************************
	Description : ��¥ ���� ��ȸ
	Parameter   : frdt - �����, todt - ������
******************************************************************************/
function ln_Day_Chk(frdt,todt) { 

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
	Description : ������ üũ
******************************************************************************/
function ln_Create_Chk(){



	//�ʼ��׸�
	if(fn_trim(txt_empnmk.value)==""){
		alert("������ �ʼ��׸��Դϴ�.");
		return false;
	}

	//�ʼ��׸�
	if(fn_trim(txt_empno.value)==""){
		alert("����� �ʼ��׸��Դϴ�.");
		return false;
	}
	
	//alert("�o��?");

	//�ʼ��׸�
	if(gcem_start_dt_s.text==""){
		alert("�ް��������� �ʼ��׸��Դϴ�.");
		return false;
	}


	//�ʼ��׸�
	if(gcem_end_dt_s.text==""){
		alert("�ް����������� �ʼ��׸��Դϴ�.");
		return false;
	}

	return true;

	

}


/******************************************************************************
	Description : ����� üũ
******************************************************************************/
function ln_Save_Chk(){


	return true;
	
}

/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){

	if (gcds_data.countrow<1){
	

		var s_temp = " CHK:STRING(1), HOL_DT:STRING(8), EMPNO:STRING(10), EMPNMK:STRING(10),"
		
							 + " DAY_CD:STRING(1), DAY_NM:STRING(5),"		
							 
							 + " DEPT_CD:STRING(5), DEPT_NM:STRING(5), HOL_GB:STRING(1),"
							 
							 + " I_EMPNO:STRING(10),I_DATE:STRING(10),"
							 
							 + "U_EMPNO:STRING(10),U_DATE:STRING(10)";
							 							 
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

 <script lanaguage=JavaScript for=gcem_start_dt_s event=onLastChar(char)>
     if(gcem_start_dt_s.text!=""&&gcem_end_dt_s.text!=""){
			  gcem_h_day.text=ln_DataChk(gcem_start_dt_s.text,gcem_end_dt_s.text);
     }
 </script>

 <script lanaguage=JavaScript for=gcem_end_dt_s event=onLastChar(char)>
     if(gcem_start_dt_s.text!=""&&gcem_end_dt_s.text!=""){
				gcem_h_day.text=ln_DataChk(gcem_start_dt_s.text,gcem_end_dt_s.text);
     }
 </script>

<!-- �ٹ�����  -->
<script language="javascript" 	for="gcds_ks006" event="onloadCompleted(row,colid)">
	gcds_ks006.insertrow(1);
	gcds_ks006.namevalue(1,"COM_CODE") = "";
	gcds_ks006.namevalue(1,"COM_SNAME") = "��ü";
	gclx_dept_cd_s.index = 0;
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

<OBJECT id=gcem_h_day classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>



<!-- �����ڵ� -->
<OBJECT id=gcds_ks006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>


<OBJECT id=gcds_ks019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_day_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
 <table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">		
							<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand"  onclick="ln_Query()">
              				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="ln_Delete()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="ln_Save()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
        <table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
						<td bgcolor="#eeeeee" align="center" width="80px">����</td>
						<td bgcolor="#FFFFFF"  width="135px">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd_s classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_ks006">
								<param name=CBDataColumns		value="COM_CODE,COM_SNAME">
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
				              <OBJECT id=gcem_start_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      value=true>
				              <param name=Format	      value="YYYY/MM/DD">
				              <param name=PromptChar	  value="_">
				              </OBJECT></comment><script>__ws__(__NSID__);</script>
				              
				              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_start_dt_s','Text');">
						  <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span> 
							
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_end_dt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              					style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
				              <param name=Alignment			value=0>
				              <param name=Border	      value=true>
				              <param name=Format	      value="YYYY/MM/DD">
				              <param name=PromptChar	  value="_">
				              </OBJECT></comment><script>__ws__(__NSID__);</script>
				              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_end_dt_s','Text');">

	
				 		</td>
					</tr> 
				</table> 
			</td>
		</tr>
		
		
		<tr>&nbsp;
		</tr>	
		
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					  <td bgcolor="#eeeeee" align="center" rowspan ="2">�Է¼���</td>					          
						<td align="center" width="120" bgcolor="#eeeeee"> �ް��� </td>
						<td bgcolor="#FFFFFF">
						  <input type="text" id="txt_empnmk" style="position:relative;left:8px;width:70px;top:-1px;">&nbsp;
							<img src="<%=dirPath%>/Sales/images/help.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;top:2px;cursor:hand;" onclick="ln_Find(1)">
 							<input type="text" id="txt_empno" style="position:relative;left:8px;width:70px;top:-1px;">&nbsp;							
						</td>
					
						<td bgcolor="#eeeeee" align="center">&nbsp;�ް�����</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcra_hol_gb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_ks019">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					<td bgcolor="#FFFFFF" rowspan = "2">&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Create()">&nbsp;&nbsp;	
							<img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand" onclick="ln_Cancel()">
					</td>
					</tr>		
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">&nbsp;�ް�����</td>
						<td bgcolor="#FFFFFF" colspan = "3">
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

							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_day_gb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:0px;top:0px;font-size:0px;width:0px;">
								<param name=ComboDataID			value="gcds_day_cd">
								</OBJECT><%=HDConstant.COMMENT_END%>
  							  <input type="text" id="gcem_dept_cd" style="position:relative;left:0px;width:0px;top:0px;">
  							  <input type="text" id="gcem_dept_nm" style="position:relative;left:0px;width:0px;top:0px;">
 						</td>	
						</tr>
				</table>
			</td>
		</tr>				
			
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=1 style="width:	829px;height:370px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:350px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<param name="Editable"			value=true>
							<PARAM NAME="Colsizing"		VALUE="true">
							<param name=MultiRowSelect	value=true>
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
                				<FC> Name=NO			 ID={CurRow}   HeadAlign=Center   HeadBgColor=#B9D4DC   Width=28,  align=center  edit=none</FC> 
               	 				<FC> Name=����,          ID=CHK	,    width=30,HeadBgColor=#B9D4DC, HeadAlign=center   EditStyle=CheckBox </FC>
               					<FC>name=�ް�����      ID=HOL_DT,  width=100 	HeadBgColor=#B9D4DC, align=center, mask='XXXX/XX/XX' edit=none</FC>   
								<FC>Name=����,   		 ID=DAY_CD,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none 
								value={IF (DAY_CD='1','��',IF (DAY_CD='2','��' ,IF (DAY_CD='3','ȭ' ,IF (DAY_CD='4','��' , IF (DAY_CD='5','��' ,  IF (DAY_CD='6','��' ,  IF (DAY_CD='7','��' , '')))))))} </FC>	
								<FC>Name=����,     		 ID=DEPT_CD,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, show=false </FC>
								<FC>Name=����,     		 ID=DEPT_NM,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </FC>
                				<FC>Name=����,     		 ID=EMPNO,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </FC>
                				<FC>Name=����,       	 ID=EMPNMK,  width=100,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, edit=none </FC>
								<FC>Name=�ް�����, 	 ID=HOL_GB,   width=160,HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,   edit= none 
								value={IF (HOL_GB='1','�����ް�',IF (HOL_GB='2','�����ް�' ,IF (HOL_GB='3','�����ް�' ,IF (HOL_GB='4','�����ް�' ,IF (HOL_GB='5','�����ް�' ,'' )))))} </FC>							
							">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:829;height:20px;solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
											&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
				</tr>
<!-- �⺻�� -->
		<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
			<PARAM NAME="DataID"				VALUE="gcds_data">
			<PARAM NAME="ActiveBind"		VALUE="true">
			<PARAM NAME="BindInfo"			VALUE="
			    <C>Col=EMPNO   			  Ctrl=txt_empno   					    Param=text</C>                      
        		<C>Col=EMPNMK   			  Ctrl=txt_empnmk   						Param=text</C>			
				<C>Col=DEPT_CD			  Ctrl=gcem_dept_cd					Param=text</C>
				<C>Col=DEPT_NM			  Ctrl=gcem_dept_nm					Param=text</C>	
				<C>Col=HOL_GB   			  Ctrl=gcra_hol_gb   				    Param=codevalue</C>			
			">
		</OBJECT><%=HDConstant.COMMENT_END%>
	</table> 
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>

