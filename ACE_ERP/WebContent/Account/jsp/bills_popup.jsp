<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - ���ݰ�꼭 List �˾� 
+ ���α׷� ID	:  Bills_poopup_1.html
+ �� �� �� ��	:  ��꼭 �� ��ǥ���� �ǿ� ���Ͽ� List ��ȸ ��.
+ ��   ��  �� :  ������
+ �� �� �� �� :  2010.05.20 
-----------------------------------------------------------------------------
+ �� �� �� ��	:  
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��꼭 List</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	gclx_fdcode.bindcolval="02";
	gcrd_regigb.codevalue="1";
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>bills_popup_s2?v_str1=A"
                                             							 +"&v_str2="+gusrid
																		 +"&v_str3="+gcem_taxdatfr.text
																		 +"&v_str4="+gcem_taxdatto.text
																		 +"&v_str5="+gclx_fdcode.bindcolval
																		 +"&v_str6="+gcrd_regigb.codevalue;

  //prompt('',gcds_code01.DataID );
	gcds_code01.Reset();
}

/******************************************************************************
	Description : �߰�
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
function ln_Delete(){

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

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"TAXNBR");										
		window.close();
	} else {
		window.close();
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	gcds_code01.insertrow(1);
	gcds_code01.namevalue(1,"DEPTCD") = "";
	gcds_code01.namevalue(1,"DEPTNM") = "��ü";
	gcds_code01.index=0;
</script> -->

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:690px;border:1 solid #708090">
	<tr>
    <td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">����</td>
		<td width="100px">
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:90px;height:110px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE,FDNAME">
				<param name=SearchColumn		value="FDNAME">
				<param name=Sort						value=false>
				<param name=Enable          value=false>
				<param name=ListExprFormat	value="FDNAME^0^90">
				<param name=BindColumn			value="FDCODE">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td class="tab16" width="70px;" bgcolor="#eeeeee" align="center">��꼭����</td>
		<td width="200px">
		<comment id="__NSID__"><object  id=gcem_taxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
			style="position:relative;left:2px;top:2px; width:68px; height:20px;" class="txtbox">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			<param name=Enable				value="true">
			</object></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
			<comment id="__NSID__"><object  id=gcem_taxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
			style="position:relative;left:2px;top:2px; width:68px; height:20px;" class="txtbox">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			<param name=Enable				value="true">
			</object></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
		</td>
		<td width="60px"  bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;">���ᱸ��</td>  
		<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;width:120px;">&nbsp;
			<comment id="__NSID__">
			<object id=gcrd_regigb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24;width:115">
				<param name=Cols	  value="2">
				<param name=Format	value="1^�̿���,2^�⿬��">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="�ڻ��ڵ带 �˻��մϴ�" style="position:relative;left:10px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:688;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
				<param name=ColSizing     value="true">
 		    <PARAM NAME="Format"			VALUE="  
					<C>ID=TAXNBR,		   Name=��꼭��ȣ,   width=85, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true MASK='XXXXXXX-XXXX'</C>
					<C>ID=TAXIODIV,		 Name=����,         width=50, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true EditStyle=Combo Data='A:����,B:����'</</C>
					<C>ID=TAXDAT,		   Name=��꼭����,		width=85, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort=true MASK='XXXX-XX-XX'</C>	
					<C>ID=TAXSUM,		   Name=���ް���,			width=100, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,	</C>	
					<C>ID=TAXVATAMT,	 Name=�ΰ�����,			width=90, 	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,	</C>	
					<C>ID=REMARK,		   Name=����,			    width=260,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		</C>	
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:690;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:100px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
