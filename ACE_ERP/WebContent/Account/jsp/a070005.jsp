
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - �����Աݰ���
+ ���α׷� ID	:   A700005.html
+ �� �� �� ��	:  �Է�,���,��ȸ ȭ���̴�.
+ ��   ��  ��   :   
+ �� �� �� ��	:	
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڱݰ���</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	ln_Header();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
		var str1  = gclx_sfdcode1.BindColVal;				//��������
		var str2  = gclx_cadeptcd.BindColVal;					//�μ�
		var str3  = fn_trim(gcem_sgetdatefr.text);			//�Ա�����fr
		var str4  = fn_trim(gcem_sgetdateto.text);			//�Ա�����to

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070005_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4;
		gcds_data1.Reset();

		gcem_asq_fr.enable = false;
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Insert(){
	
		gcds_data1.AddRow();
		gcem_asq_fr.enable = true;
		gcem_asq_fr.text = gs_date;		//�Ա�����
		gcem_amt.text	 = "";			//�Աݾ�
		gcem_remark.text = "";			//����
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if(gcds_data1.countrow>0){
		if(gcds_data1.IsUpdated) {
			if(ln_Chk()) {
				var str1 = gclx_sfdcode1.BindColVal;  //����
				var str2 = gclx_cadeptcd.BindColVal;  //�μ�
				var str3 = fn_trim(gcem_sgetdatefr.text);			//�Ա�����fr
				var str4 = fn_trim(gcem_sgetdateto.text);			//�Ա�����to
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070005_t1";
				gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3+",v_str4="+str4;
				gctr_data1.post();
				ln_Query('01');
			}
		}else alert("����� ������ �����ϴ�.");
	}else alert("������ ������ �����ϴ�.");
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk() {
	if (fn_trim(gcem_asq_fr.text)==""){
		alert("��Ȯ�� �Ա����ڸ� �Է��Ͻʽÿ�.");
		gcem_asq_fr.focus();
		return false; 
	}

	if (gcem_amt.text==0){
		alert("��Ȯ�� �Աݾ��� �Է��Ͻʽÿ�.");
		gcem_amt.focus();
		return false; 
	}
	return true;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if(gcds_data1.countrow>0){
		var str1 = gclx_sfdcode1.BindColVal;				//����
		var str2 = gclx_cadeptcd.BindColVal;				//�μ�
		var str3 = fn_trim(gcem_sgetdatefr.text);			//�Ա�����fr
		var str4 = fn_trim(gcem_sgetdateto.text);			//�Ա�����to

		if (confirm("���� �Ͻðڽ��ϱ�?")) {
			gcds_data1.deleterow(gcds_data1.rowposition);
			gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070005_t1";
			gctr_data1.Parameters = "v_str1="+str1+",v_str2="+str2+",v_str3="+str3+",v_str4="+str4;
			gctr_data1.post();
			ln_Query('01');
		}
	}else alert("������ ������ �����ϴ�.");
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_SetDataHeader(){	

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
	alert("�غ����Դϴ�.");
	/*
	if(gcds_print1.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else gcrp_print1.preview();
	*/
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="01"){
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('�����Աݰ���');
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr.text = gs_date2+"01";	 
	gcem_sgetdateto.text = gs_date;							
	
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_dept.DataID = "<%=dirPath%>/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept.Reset();
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_Header(){
	var Theder = "ACDATE:STRING,PYAMT:DECIMAL,REMARK:STRING,SEQNO:DECIMAL";
	gcds_data1.SetDataHeader(Theder);
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
<PARAM NAME="KeyValue" VALUE="a070005_t1(I:USER=gcds_data1)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.BindColVal =  gs_fdcode;
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="";
	gclx_cadeptcd.BindColVal =  gs_deptcd;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a070005_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:0px"></td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<table  cellpadding="0" cellspacing="0" border="0">		
	<tr>
		<td height="3px">
		</td>
	</tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:1px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�μ�</nobr>
					</td>
					<td class="tab23" style="width:120px"><comment id="__NSID__">
						<OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=110 style="position:relative;left:6px;top:0px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="DEPTNM^0^110">
								<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>�Ա�����</nobr>
					</td>
					<td style="width:250px"><comment id="__NSID__">
						<OBJECT id=gcem_sgetdatefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 		style="position:relative;top:2px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	            value=true>
							<param name=Format	            value="YYYY/MM/DD">
							<param name=PromptChar	   value="_">
						 </OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;
					   <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr', 'Text')" style="position:relative;width:20px;left:-5px;top:1px;cursor:hand;">~<comment id="__NSID__">
						 <OBJECT id=gcem_sgetdateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
						style="position:relative;top:2px;left:8px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 
				      <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdateto', 'Text')" style="position:relative;width:20px;left:10px;top:1px;cursor:hand;">
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;top:2px;right:2px" 
						onclick="ln_Delete()"> 
						<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Insert()">
						<input type="image" id=save_sys    src="../../Common/img/btn/com_b_save.gif" style="cursor:hand;position:relative;top:2px;right:2px" onclick="ln_Save()">
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print()"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query()"> 
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:520px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:-1px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="
						    <C> Name='No.'		ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''			SumBgColor='#C3D0DB'</C> 
							<C> Name='�Ա�����'	ID=ACDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=center	SumText='��'		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
							<C> Name='�Աݾ�'		ID=PYAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right		SumText=@sum		SumBgColor='#C3D0DB'</C>
							<C> Name='����'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=285	align=left		SumText=''			SumBgColor='#C3D0DB'</C>
							<C> Name='SEQNO'		ID=SEQNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=left		SumText=''			SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:-1px;width:522px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
					<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:350px;height:402px;border:1 solid #708090;position:relative;left:1px'>
							<tr>															
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">�Ա�����
								</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:0px;border-bottom-width:0px"><comment id="__NSID__">
								<OBJECT id=gcem_asq_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 		style="position:relative;top:2px;left:6px;width:70px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	            value=true>
									<param name=Format	            value="YYYY/MM/DD">
									<param name=PromptChar			value="_">
								</OBJECT></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_fr', 'Text')" style="position:relative;width:20px;left:8px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-bottom-width:0px;">�Աݾ�
								</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-bottom-width:0px"><comment id="__NSID__">
								<object  id=gcem_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:5px;top:0px;">		
									<param name=Text          value="">
									<param name=Alignment	  value=2>
									<param name=Border	      value=true>
									<param name=Numeric	      value=true>
									<param name=Format	      value="000,000,000">
									<param name=MaxLength     value=13>
									<param name=IsComma	      value=true>
								</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">����
								</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-bottom-width:1px"><comment id="__NSID__">
								<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:260px;height:20px;position:relative;left:5px;top:0px;">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<!--<param name=Language	  value=1>-->
								</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
								</td>
							</tr>
						</table>
					</TD>
				</tr>
			</table>
		</td>
	</tr>
</table>
			 
<td>
</tr>
</table>


<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
		<C>Col=ACDATE		Ctrl=gcem_asq_fr	Param=text</C>
		<C>Col=PYAMT		Ctrl=gcem_amt		Param=text</C>
		<C>Col=REMARK		Ctrl=gcem_remark	Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"			value="
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>