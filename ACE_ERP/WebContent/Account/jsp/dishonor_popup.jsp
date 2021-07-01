<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �������� �ε����� �˾�
+ ���α׷� ID	: dishonor_popup.html
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: dishonor_popup_s1, dishonor_popup_t1
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�������� �ε����� �˾�</title>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css"></style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var p_fdcode = "";
var p_atcode = "";
var p_fundiv = "";
var p_refcod = "";
var p_getdat = "";
var p_enddat = "";
var p_getamt = "";
var p_vendnm = "";
var p_vendcd = "";

/******************************************************************************
	Description : ������ �ε���
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam = window.dialogArguments;
	p_fdcode = strParam[0];	//�����ڵ�
	p_atcode = strParam[1];	//��������
	p_fundiv = strParam[2];	//�ڱݱ���
	p_refcod = strParam[3];	//������ȣ
	p_getdat = strParam[4];	//��������
	p_enddat = strParam[5];	//��������
	p_getamt = strParam[6];	//����ݾ�
	p_vendnm = strParam[7];	//�ŷ�ó��
	p_vendcd = strParam[8];	//�ŷ�ó�ڵ�

	ln_Query();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>dishonor_popup_s1?v_str1="+p_fdcode
	                  +"&v_str2="+p_atcode+"&v_str3="+p_fundiv+"&v_str4="+p_refcod;
	gcds_data1.Reset();
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Add(){
	gcds_data1.addrow();
	var row = gcds_data1.rowposition;
	gcds_data1.namevalue(row,"FDCODE")  = p_fdcode;
	gcds_data1.namevalue(row,"ATCODE")  = p_atcode;
	gcds_data1.namevalue(row,"FUNDDIV") = p_fundiv;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (!ln_Valchk()) return;
	if (gcds_data1.IsUpdated) {
		gctr_data1.KeyValue = "dishonor_popup_t1(I:USER=gcds_data1)";
		gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>dishonor_popup_t1";
		gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_userid;
		gctr_data1.post();
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if(fn_trim(gcem_strdate2.text)!=""&&fn_trim(gcem_rtndate.text)!=""
	&&fn_trim(gcem_rtnamt.text)!=0||gcds_data1.SysStatus(1)==3){
		if (confirm("���� �Ͻðڽ��ϱ�?")){
			gcds_data1.deleterow(gcds_data1.rowposition);
			gctr_data1.KeyValue = "dishonor_popup_t1(I:USER=gcds_data1)";
			gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>dishonor_popup_t1";
			gctr_data1.post();
			ln_Start();
		}
	}else{
		alert("������ ������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_refcode2.text = p_refcod;	//������ȣ
	gcem_getdate1.text = p_getdat;	//��������
	gcem_enddate1.text = p_enddat;	//��������
	gcem_amt.text      = p_getamt;	//����ݾ�
	gcem_vendnm1.text  = p_vendnm;	//�ŷ�ó��
	gcem_vendcd1.text  = p_vendcd;	//�ŷ�ó�ڵ�
}

/******************************************************************************
	Description : �ʼ��׸� üũ
******************************************************************************/
function ln_Valchk() {
	if (fn_trim(gcem_strdate2.text)==""||gcem_strdate2.text.length<=7) {			
		alert("��Ȯ�� �ε����ڸ� �Է��� �ֽʽÿ�.");
		gcem_strdate2.focus();
		return false;
	}

	if (fn_trim(gcem_rtndate.text)==""||gcem_rtndate.text.length<=7) {			
		alert("��Ȯ�� ȸ�����ڸ� �Է��� �ֽʽÿ�.");
		gcem_rtndate.focus();
		return false;
	}

	if (fn_trim(gcem_rtnamt.text)==0) {			
		alert("��Ȯ�� ȸ���ݾ׸� �Է��� �ֽʽÿ�.");
		gcem_rtnamt.focus();
		return false;
	}
	return true;
}

/***********************************************************************************************
	Description : �ŷ�ó ã��
	parameter   : arrParam[0] - �ŷ�ó�ڵ�, arrParam[1] - �ŷ�ó��
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./Commdtil_popup_ifrm.html";
	arrParam[0]="0020";
	if(e=="01"){
		arrParam[1]=gcem_vendnm1.text;
	}

	strPos = "dialogWidth:398px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="01") {
			gcem_vendcd1.text = arrParam[0];
			gcem_vendnm1.text = arrParam[1];
		}
	} else {
		if(e=="01") {
			gcem_vendcd1.text = "";
			gcem_vendnm1.text ="";
		}
	}
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_data = "FDCODE:STRING,ATCODE:STRING,FUNDDIV:STRING,REFCODE2:STRING,STRDATE:STRING,"
						 + "RTNDATE:STRING,RTNAMT:DECIMAL,SLIPYN:STRING,UPDT:STRING,UPID:STRING";
	gcds_data1.SetDataHeader(s_data);
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		ln_Add();
		ln_Before();
	}else{
		ln_Before();
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="gcgd_disp1" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp1" event=OnDblClick(row)>
	ln_Close('A');
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

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">  

<table width="310" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px">
  <tr align=right> 
    <td width="310" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"></td>
  </tr>
	<tr>
		<td colspan=2> 
			<table width="310" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td colspan=8 align=left>
						<table width="310" cellpadding="1" cellspacing="0" border="0" style='position:relative;left:1px;width:310px;border:1 solid #708090'>
							<tr>
								<td align=right><nobr>      
								<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px" onClick="ln_Delete()">
								<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:2px" onClick="ln_Save()">
								<img src="../../Common/img/btn/com_b_exit.gif"		style="cursor:hand;position:relative;top:2px" onClick="ln_Close('C')">&nbsp;</nobr>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
						<table width="310" cellpadding="1" cellspacing="0" border="0">
							<tr> 
								<td>
							<table cellpadding=0 cellspacing=0  border=0  style='width:310px;height:250px;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
							<tr>
								<td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee"><nobr>������ȣ</nobr></td>
								<td class="tab22" style="height:25px;"><nobr><comment id="__NSID__">
									<object id=gcem_refcode2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:195px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=GeneralEdit   value="true">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
										<param name=enable				value=false>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
							</tr>
							<tr>
                <td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>  
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_getdate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_getdate1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
								</td>
							</tr>
							<tr>
                <td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>  
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_enddate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_enddate1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
								</td>
							</tr>
							<tr>
								<td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee">����ݾ�</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gcem_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:100px;">
										<param name=Text				value="">
										<param name=Alignment		value=2>
										<param name=Border			value=true>
										<param name=MaxLength		value=15>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
										<param name=Enable			value="false">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��&nbsp;��&nbsp;ó</td>  
								<td class="tab22" style="height:45px;"><nobr><comment id="__NSID__">
									<object  id=gcem_vendnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:195px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
										<param name=Enable				value="false">
									</object></comment><script>__ws__(__NSID__);</script><br>
									<comment id="__NSID__">
									<object id=gcem_vendcd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="#############">
										<param name=PromptChar	value="_">
										<param name=Enable			value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									<!-- <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:8px;cursor:hand"	 onclick="ln_Popup('01')"> --></nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee">�ε�����</td>
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_strdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_strdate2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td class="tab11" style="height:25px;width:100px;" bgcolor="#eeeeee">ȸ������</td>
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_rtndate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment			value=0>
										<param name=Border	      value=true>
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_">
										<param name=Enable				value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_rtndate', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td class="tab12" style="height:25px;width:100px;" bgcolor="#eeeeee">ȸ���ݾ�</td>
								<td><comment id="__NSID__">
									<object  id=gcem_rtnamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:0px;width:100px;">
										<param name=Text				value="">
										<param name=Alignment		value=2>
										<param name=Border			value=true>
										<param name=MaxLength		value=15>
										<param name=Numeric			value="true">
										<param name=ClipMode		value="true">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
						</table>
					</TD>
				</tr>
			</table>
				</td>
					</tr>
			</table>
    </td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
	<C>Col=REFCODE2				Ctrl=gcem_refcode2		Param=text</C>
	<C>Col=STRDATE				Ctrl=gcem_strdate2		Param=text</C>
	<C>Col=RTNDATE				Ctrl=gcem_rtndate			Param=text</C>
	<C>Col=RTNAMT					Ctrl=gcem_rtnamt			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 