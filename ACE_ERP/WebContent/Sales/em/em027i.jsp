<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �Ϻ��޹��ϼ� ����
+ ���α׷�ID : em027i.jsp
+ ������� : 
+ �� �� �� : �� �� ��
+ �ۼ����� : 2008.04.30
----------------------------------------------------------------------------------
+ �������� : 
+ �� �� �� : 
+ �������� : 
----------------------------------------------------------------------------------
+ ������ : Em027_i.java
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
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';

 
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			gcem_att_dt_fr_s.Text = gs_date;
			gcem_att_dt_to_s.Text = gs_date;

		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){
	//gcds_data00.UseChangeInfo ="true"; 
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em027i_S"     
											 + "?v_str1=" + gcem_att_dt_fr_s.text			// from ����  
											 + "&v_str2=" + gcem_att_dt_to_s.text;			// to ����    
//	prompt('',	gcds_data00.DataID);								     
	gcds_data00.Reset();
}

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

}

/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(){//������ȸ

}

/*----------------------------------------------------------------------------
	Description : ���°��� �ϰ����� 
----------------------------------------------------------------------------*/
function ln_Batch_Create(){
	 
}


/*----------------------------------------------------------------------------
	Description : ���°��� �ӽ� - OT data ó�� �ø� �� ���
----------------------------------------------------------------------------*/
function ln_Batch_Update(){

}

/*----------------------------------------------------------------------------
	Description : ���߰�
----------------------------------------------------------------------------*/
/*
function ln_Add(){
  ln_SetDataHeader()
  gcds_data00.Addrow();
}
*/

/*----------------------------------------------------------------------------
	Description : �����
----------------------------------------------------------------------------*/
/*
function ln_Delete(){

}
*/

/*----------------------------------------------------------------------------
	Description : ����üũ ( ����Ÿ ����)
	//2008.03.05 ������ ����üũ//////////////////////////////////
----------------------------------------------------------------------------*/
function ln_Close_Chk2(){

}

/*----------------------------------------------------------------------------
	Description : ����üũ (����Ÿ ����)
	//2008.03.05 ������ ����üũ//////////////////////////////////
----------------------------------------------------------------------------*/
function ln_Close_Chk(){

}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
function ln_Save(){
	if (gcds_data00.IsUpdated) {
			if(confirm("������ �����Ͻðڽ��ϱ�?")){
				gctr_data.KeyValue = "Em027i_t(I:USER=gcds_data00)";
				gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em027i_t?";
				gctr_data.Parameters = "v_str1="+gusrid;
				//prompt(this,gcds_data.text);
			//	 prompt(this,gcds_data00.text);
				gctr_data.post();
			}
	}
}

/*----------------------------------------------------------------------------
	Description : ����� üũ
----------------------------------------------------------------------------*/
function ln_Save_Chk(){
	
}
/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

   }
/*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
function ln_Print(){
  
}

/*----------------------------------------------------------------------------
	Description : ���üũ
----------------------------------------------------------------------------*/


/*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
function ln_Sum(){
    
}

/******************************************************************************
	Description : �ϰ������� �����.
******************************************************************************/
function ln_Batch_Create(){ 
	   var strfrdt="";
		 var strtodt="";
		 var strfrscnt="";
		 var strtodcnt="";

		if(fn_trim(gcem_att_dt_fr.text)==""){
			alert("���ڸ� �Է��Ͻʽÿ�");
			return;
		}

		if(fn_trim(gcem_att_dt_to.text)==""){
				alert("���ڸ� �Է��Ͻʽÿ�");
				return;
		}
		if(fn_trim(txt_s_cnt.value)==""){
			alert("������ ���� �޹����� �Է��Ͻʽÿ�");
			return;
		}
		if(fn_trim(txt_d_cnt.value)==""){
			alert("���� ���� �޹����� �Է��Ͻʽÿ�");
			return;
		}
       	
        strfrdt =gcem_att_dt_fr.text.substring(0,6);
       	strtodt =gcem_att_dt_to.text.substring(0,6);
      
       	if (strfrdt != strtodt){
       		alert("�����ϰ� ������ ��,���� ���� �Է��Ͻʽÿ�");
       		return;
       		}
       	
		//��������Ÿ ��ȸ
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em027i_S"     
											 + "?v_str1=" + gcem_att_dt_fr.text			// from ����  
											 + "&v_str2=" + gcem_att_dt_to.text;			// to ����    
	//prompt('',gcds_data.DataID );
      
		gcds_data.Reset();
		gcds_data2.ClearAll();
		ln_SetDataHeader();
		gcds_data2.Addrow();
		gcds_data2.namevalue(gcds_data2.rowposition,"TEMP")="A";

		strfrdt =gcem_att_dt_fr.text;
		strtodt =gcem_att_dt_to.text;
		strfrscnt=txt_s_cnt.text;
		strtodcnt=txt_d_cnt.text;
        //alert(gcds_data.countrow);

		if(gcds_data.countrow==0){ //�űԻ���
			if(confirm(strfrdt+" ~ "+strtodt+" \n���� ����Ÿ�� �����Ͻðڽ��ϱ�?")){
				gcds_data00.AddRow();
				gctr_data.KeyValue = "Em027i_t_b(I:USER=gcds_data2)";
				gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em027i_t_b";
				gctr_data.Parameters = "v_str1="+gcem_att_dt_fr.text+",v_str2="+gcem_att_dt_to.text+",v_str3="+txt_s_cnt.value+",v_str4="+txt_d_cnt.value+",v_str5="+gusrid;
				//prompt(this,gcds_data.text);
				gctr_data.post();
				gcem_att_dt_fr_s.text = gcem_att_dt_fr.text ;
				gcem_att_dt_to_s.text = gcem_att_dt_to.text ;
				ln_Query();
			}
		} else{//��������Ÿ ����
			alert("������ �����Ͱ� �����մϴ�.���ڸ� �ٽ� �������ֽʽÿ�");
  		} 
}


/******************************************************************************
	Description : �ϰ������� �����.
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_data2.countrow<1){
		var s_temp = " TEMP:STRING(1)";
		gcds_data2.SetDataHeader(s_temp);
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

	<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
	</script>
	<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
		window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		document.all.LowerFrame.style.visibility="hidden";
		ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
		if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
		}
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
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">		
							<img src="<%=dirPath%>/Sales/images/refer.gif"    style="cursor:hand" onclick="ln_Query()">
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" onClick="ln_Save()">
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
					<tr height="25">
					  <td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_att_dt_fr_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_fr_s', 'Text');">
              <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span>
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_att_dt_to_s classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM/DD">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_to_s', 'Text');">
						</td>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=0 style="width:630px;height:350px;position:relative;top:-5px;" >
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:260;height:350px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=35>
							<param name="sortview"    value=left>
							<param name="editable"    value=true>
  							<PARAM NAME="Format"			VALUE="  
                					<F> Name=����				   ID=APPDT, HeadAlign=Center  , HeadBgColor=#B9D4DC,   Width=90, Height=80, align=center,  edit=none  mask='XXXX/XX/XX'</F>  
									<C>Name=�����ϱ���\\�޹���,       ID=S_CNT  ,width=30,HeadBgColor=#B9D4DC, Width=75,Height=80, bgcolor=#ffffff,  align=center, decao=1</C>
									<C>Name=���ϱ���\\�޹���, ID=D_CNT   ,width=90,HeadBgColor=#B9D4DC, Width=75, Height=80,bgcolor=#ffffff, align=center</C>     
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<fieldset style="width:260;height:20px;border:1 solid #708090;border-top-width:1px;border-bottom-width:0px;border-right-width:0px;text-align:left;">
									&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
								</fieldset>
						</td>
						<td bgcolor="#FFFFFF" >&nbsp;</td>
						<td bgcolor="#FFFFFF" >&nbsp;</td>
						<td bgcolor="#FFFFFF" >&nbsp;</td>
						<td bgcolor="#FFFFFF" >&nbsp;</td>
						<td bgcolor="#FFFFFF" >&nbsp;</td>
						<td valian="top">
							<table cellpadding=0 cellspacing=0 style="width:535px;height:350px;" valign="top">
								<tr height="20">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" width="75">�ϰ��Է�</td>
									<td height="20" bgcolor="#FFFFFF" class="tab_z1110" align="right">	
									    <img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand" onclick="ln_Batch_Create()">
									</td>
								</tr>
								<tr height="20">
								  <td bgcolor="#eeeeee" align="center" class="tab_z1010" width="75">����</td>
									<td bgcolor="#FFFFFF" class="tab_z1110">
							<%=HDConstant.COMMENT_START%>
             						 <OBJECT id=gcem_att_dt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
          							    style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >       						   
        						     <param name=Alignment			value=0>
         						     <param name=Border	      value=true>
         						     <param name=Format	      value="YYYY/MM/DD">
         						     <param name=PromptChar	  value="_">
         						     </OBJECT><%=HDConstant.COMMENT_END%>
        						      <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_fr', 'Text');">
       							       <span style="position:relative;left:0px;top:-4px;">&nbsp;&nbsp;&nbsp;~</span>
      						        <%=HDConstant.COMMENT_START%>
      						        <OBJECT id=gcem_att_dt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
      							        style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;" >
      						        <param name=Alignment			value=0>
      						        <param name=Border	      value=true>
      						        <param name=Format	      value="YYYY/MM/DD">
     						         <param name=PromptChar	  value="_">
     						         </OBJECT><%=HDConstant.COMMENT_END%>
       						       <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallCalendar7('gcem_att_dt_to', 'Text');">
								</td>
							</tr>
								<tr height="40">
									<td align="center" bgcolor="#eeeeee" class="tab_z1010" width="80" >������ ���� �޹� �����ϼ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1110" >
										<input id="txt_s_cnt"  type="text"   class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" >
										(�Ի�, �ް����� ����)
									</td>
								</tr>
								<tr  height="40">
									<td align="center" bgcolor="#eeeeee" class="tab_z1011" width="80"> ���� ���� &nbsp; �޹� �����ϼ�</td>
									<td bgcolor="#FFFFFF" class="tab_z1111" >				                    									
										<input id="txt_d_cnt"  type="text"   class="txtbox"  style= "position:relative;left:7px;width:35px;height:20px;" >
										(���, �ް����� ����)
									</td>
								</tr>
								<tr> <td bgcolor="#FFFFFF" colspan="5"></td></tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>