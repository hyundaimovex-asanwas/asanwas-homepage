<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:  ���԰�ȹ���� - ���԰�ȹ�˻�		
+ ���α׷� ID	:  TR00301.html
+ �� �� �� ��	:  ���԰�ȹ������ ��ȸ �ϴ� ȭ���̴�
+ ��   ��  �� :  �̹���
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ �������� :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
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
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	get_cookdata();

	
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
	var gs_userid = gusrid;
	
	var gs_hisdat = gs_date;
    //var gs_date = '<%=firstday%>';
	//var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);			//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			ln_Start();//����ȸ

			window.status="�Ϸ�";

		}
		
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	ln_Before();

}

/******************************************************************************
	Description : �� ��ȸ
******************************************************************************/
function ln_Before() {

	gcem_acc_date_fr.text = gs_date2 + "01";	  //������� from
	gcem_acc_date_to.text = gs_date;						//������� to 

	//������Ʈ[�˻�]
	gcds_project_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; 
	gcds_project_cd.Reset();
	
	//������ �δ�[�˻�]
	gcds_project.DataID = "<%=dirPath%>/servlet/Account.commdtil_s1?v_str1=0030";  
	gcds_project.Reset();

	//��������[�˻�]
	gcds_sreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_sreach_ciq.Reset();

	//�԰������[�˻�]
	gcds_rreach_ciq.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  
	gcds_rreach_ciq.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_project_cd.BindColVal;           //������Ʈ
	var str2 = gclx_project.BindColVal;              //������ �δ�
	var str3 = gcem_acc_date_fr.text;                //������� from
	var str4 = gcem_acc_date_to.text;                //������� to
	var str5 = gcem_rtrn_date_fr.text;				 //�԰����� from
	var str6 = gcem_rtrn_date_to.text;				 //�԰����� to
	var str7 = gclx_sreach_ciq.BindColVal;			 //��������
	var str8 = gclx_rreach_ciq.BindColVal;			 //�԰������
	var str9 = gcem_accessno.text;					 //���Թ�ȣ
	var str10 = gcem_create_usr.text;				 //�Է���
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7+"&v_str8="+str8
										+ "&v_str9="+str9+"&v_str10="+str10;
									 
	gcds_code01.Reset(); 
	
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete() {
	
}

/******************************************************************************
	Description : ���
	parameter   : 
******************************************************************************/
function ln_Print(){
		
}

/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : Enable _ Disabled 
	parameter   : p==> t - Enable, f - Disable
******************************************************************************/
function ln_Enable(p) {
	
}

/******************************************************************************
	Description : �����ȣ ã��
******************************************************************************/
function ln_Popup(){             

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Person/html/H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);

if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_create_usr.text = arrParam[1];
		txt_create_usr.value = arrParam[0];
} else {
		gcem_create_usr.text = "";
		txt_create_usr.value ="";
		
	}
}

/******************************************************************************
	Description : ���԰�ȹ ����
******************************************************************************/
function ln_Create(){

	if (gcds_code01.countrow<1) return;

	var row = gcds_code01.rowposition;

	gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s3"
									  + "?v_str1="+gcds_code01.namevalue(row,"ACCESSNO");
	gcds_chk.Reset(); 

	if (gcds_chk.namevalue(1,"CNT")>0) {
		if (confirm("�̹� ������ �ڷᰡ �ֽ��ϴ�.\n\n�ڷḦ �� �����Ͻðڽ��ϱ�?")){
			gcds_cre.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s2?v_str1=" + gcds_code01.namevalue(row,"ACCESSNO");
			gcds_cre.Reset();
		}
	} else{
		if (confirm("�ڷḦ �����Ͻðڽ��ϱ�?")){
			gcds_cre.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00301_s2?v_str1=" + gcds_code01.namevalue(row,"ACCESSNO");
			gcds_cre.Reset();
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ������Ʈ -->
<OBJECT id=gcds_project_cd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ������ �δ� -->
<OBJECT id="gcds_project" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- �������� -->
<OBJECT id="gcds_sreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- �Է¸����� -->
<OBJECT id="gcds_rreach_ciq" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- ���԰�ȹ �������� -->
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- ���԰�ȹ ���� -->
<OBJECT id="gcds_cre" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-- ������Ʈ -->
<script language="javascript" for="gcds_project_cd" event="onloadCompleted(row,colid)">
	gcds_project_cd.InsertRow(1);
	gcds_project_cd.NameValue(1,"MINORCD")="";
	gcds_project_cd.NameValue(1,"MINORNM")="��ü";
	gclx_project_cd.index=0;
</script>

<!-- ������ �δ� -->
<script language="javascript" for="gcds_project" event="onloadCompleted(row,colid)">
	gcds_project.InsertRow(1);
	gcds_project.NameValue(1,"CDCODE")="";
	gcds_project.NameValue(1,"CDNAM")="��ü";
	gclx_project.index=0;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_sreach_ciq" event="onloadCompleted(row,colid)">
	gcds_sreach_ciq.InsertRow(1);
	gcds_sreach_ciq.NameValue(1,"MINORCD")="";
	gcds_sreach_ciq.NameValue(1,"MINORNM")="��ü";
	gclx_sreach_ciq.index=0;
</script>

<!-- �԰������ -->
<script language="javascript" for="gcds_rreach_ciq" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";      //���������� �ε��Ǵ°��� hidden����
	gcds_rreach_ciq.InsertRow(1);
	gcds_rreach_ciq.NameValue(1,"MINORCD")="";
	gcds_rreach_ciq.NameValue(1,"MINORNM")="��ü";
	gclx_rreach_ciq.index=0;
</script> 

<script language="javascript" for="gcds_cre" event="onloadCompleted(row,colid)">
	alert("���԰�ȹ�ڷᰡ ���������� �����Ǿ����ϴ�.");
</script> 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	var sUrl = "../../Transfer/html/TR00302.html"+
						 "?gstr="+gcds_code01.NameValue(row,"ACCESSNO") + 
						 "&" + gcds_code01.NameValue(row,"S_DATE").substring(0,20) +
						 "&" + gcds_code01.NameValue(row,"R_DATE").substring(0,20); 
	window.location.href = sUrl;

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../../Common/img/btn/com_b_create_trs.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Create()">
			<img src="../../../Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
				 <td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >������Ʈ</td>
					<td class="tab21" >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_project_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project_cd">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="" bgcolor="#eeeeee" class="tab21" align=center >������ �δ�</td>
						<td class="tab21" >
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_project classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_project">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn			value=CDNAM>
								<param name=Sort							value=false>
								<param name=ListExprFormat			value="CDNAM^0^180">
								<param name=BindColumn				value=CDCODE>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">�������</td> 
					 <td  class="tab21" width="180px;" > 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_acc_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:5px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;~&nbsp;
           				<%=HDConstant.COMMENT_START%>
           				<OBJECT id=gcem_acc_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
					</td> 
					<td width="70px" class="tab21" bgcolor="#eeeeee" align="center">�԰�����</td> 
				  	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt;" width="180px;" > 
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gcem_rtrn_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:5px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>&nbsp;
			
           				<%=HDConstant.COMMENT_START%>
           				<OBJECT id=gcem_rtrn_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT>
						<%=HDConstant.COMMENT_END%>
						</td> 
					<tr>
						 <td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " bgcolor="#eeeeee" align=center >��������</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; ">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_sreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_sreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " bgcolor="#eeeeee" align=center >�԰������</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; ">
						<%=HDConstant.COMMENT_START%>
						<OBJECT id=gclx_rreach_ciq classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:4px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_rreach_ciq">
								<param name=CBDataColumns		value="MINORCD, MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat		value="MINORNM^0^80">
								<param name=BindColumn			value=MINORCD>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " bgcolor="#eeeeee" align=center >���Թ�ȣ</td>
						 <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " onkeydown="if(event.keyCode==13) ln_Query();">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=gcem_accessno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:78px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							</td>
							<td width="70px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " bgcolor="#eeeeee" align=center >�Է���</td>
						 	<td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:25px;font-family:����;font-size:9pt; " >

					 		<%=HDConstant.COMMENT_START%>
					 		<OBJECT id=gcem_create_usr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:52px;height:20px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						 <img SRC="../../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�Է��ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:6px;top:0px" align=center onclick="ln_Popup();">
							<input id="txt_create_usr" type="text" class="txtbox"  style= "position:relative;left:4px;top:1px;width:70px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled> 
						</td> 
				</tr>
			</table>
		</td>
	</tr>  
							
	<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:3px;width:280px;border:0 solid #708090;">
		<tr> 			
			<td style="width:280" ALIGN=LEFT VALIGN=TOP>
				<%=HDConstant.COMMENT_START%>
				<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_code01">
						<PARAM NAME="IndWidth"		VALUE ='0'> 
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="Sort"		VALUE="left">
						<param name="ColSizing"   value="true"> 
						<Param Name="Editable"     value="false"> 
						<PARAM NAME="Format"			VALUE="  
						<F>	Name='����;����'	ID='FLAG', width=30 	   	HeadBgColor=#B9D4DC HeadCheckShow=true align=center bgcolor=@acolor </F>
						<F> Name='SEQ'	     	    ID=SEQ 		  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center  Edit=true  
						Value={ToString(CurRow)}</F>
						<C> Name='���Թ�ȣ'	      ID=ACCESSNO		  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	  Edit=none  </C> 
						<C> Name='������Ʈ'		    ID=P_CD         HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left	  Edit=none  
						</C> 
						<G> Name='�������'												HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='�Ͻ�'					  ID=S_DATE 		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=center  Edit=none 
						</C> 
						<C> Name='���'					  ID=A_COURSE		      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	    </C> 
						<C> Name='����'						ID=PURPOSE    	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=186	align=left    Edit=none  </C>
						<C> Name='������'					ID=S_CIQ 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center  Edit=none  </C> 
						<C> Name='�ο�'						ID=SPERSON_CNT    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right   Edit=none  </C> 
						<C> Name='����'						ID=SCAR_CNT    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right   Edit=none  </C> 
						<C> Name='���'						ID=REMARK   HeadAlign=Center HeadBgColor=#B9D4DC Width=173	align=left   Edit=none  </C> 
						</G>
						<G> Name='�԰�����' HeadAlign=Center HeadBgColor=#B9D4DC 
						<C> Name='�Ͻ�'						ID=R_DATE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=center   Edit=none </C> 
						<C> Name='���'						ID=R_COURSE	    		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	    </C> 
						<C> Name='����'						ID=PP_POSE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=186	align=left    Edit=none  </C>
						<C> Name='������'					ID=G_CIQ 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center    Edit=none  </C> 
						<C> Name='�ο�'						ID=RPERSON_CNT     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right    Edit=none  </C> 
						<C> Name='����'						ID=RCAR_CNT 		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right    Edit=none  </C> 
						<C> Name='���'						ID=REMARK 		HeadAlign=Center HeadBgColor=#B9D4DC Width=173	align=left    Edit=none  </C>
						</G>
						<C> Name='�Է���'					ID=C_USR       HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left    Edit=none  </C> 
						<C> Name='�Է��Ͻ�'				ID=C_DT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=center    Edit=none
					    </C>
						<C> Name='������'					ID=U_UST 		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left     Edit=none  </C> 
						<C> Name='�����Ͻ�'				ID=U_DT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=center    Edit=none  </C>
						">
				</OBJECT>
				<%=HDConstant.COMMENT_END%>
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
