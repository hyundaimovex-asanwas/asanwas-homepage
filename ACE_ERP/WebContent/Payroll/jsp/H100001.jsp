<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿��׸����
+ ���α׷� ID	: H100001
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: p010001_s1, p010001_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�޿��׸����</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>


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
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	ln_Luxequery();				//�����ڵ�

	gcem_frdt1.text		=		gcurdate.substring(0,7);

	gclx_paydiv.enable = false;
	gclx_pbdiv.enable = false;
	txt_paycd.disabled = true;

	gclx_paydiv1.index = 0;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	var str1 = gclx_paydiv1.BindColVal;
	var str2 = gclx_pbdiv1.BindColVal;
	var str3 = gcem_frdt1.text;

	//if (gcem_frdt1.text != "") {  str3 = str3+"01"; }

	ln_Luxequery1();

	gcds_pay.DataID = "/servlet/Contract.h100001_s1?v_str1="+str1+"&v_str2="+str2+"&v_str3="+fn_trim(str3);
	gcds_pay.Reset(); 

	gclx_paydiv.enable = false;
	gclx_pbdiv.enable = false;
	txt_paycd.disabled = true;

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	gcds_pay.addrow();

	gclx_paydiv.enable = true;
	gclx_pbdiv.enable = true;
	txt_paycd.disabled = false;

	gclx_paydiv.index  = 0;
	gclx_pbdiv.index  = 0;

	gcra_caldiv.CodeValue = 2;
	gcra_autoyn.CodeValue = 'Y';
	gcra_taxyn.CodeValue = 'Y';

	gcem_frdt.text		=		gcurdate.substring(0,7) + "01";
	gcem_todt.text		=		"99991231";

	gcds_pay.namevalue(gcds_pay.RowPosition,"FRDT")=gcem_frdt.text+"01";
	gcds_pay.namevalue(gcds_pay.RowPosition,"TODT")=gcem_todt.text+"31";
	
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (!ln_Valchk()) return;
  
	if (gcds_pay.IsUpdated) {	
	//prompt('',gcds_pay.text);
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_pay.KeyValue = "p010001_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "/servlet/Contract.h100001_t1";
			gctr_pay.post();
			ln_Query();
		}
	}

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete() {
	
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		gcds_pay.deleterow(gcds_pay.rowposition);
	//prompt('',gcds_pay.text);
    gctr_pay.action = "/servlet/Contract.h100001_t1";
		gctr_pay.post();
		ln_Query();
	}

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
	Description : �Է°� üũ
******************************************************************************/
function ln_Valchk(){

	if (txt_paycd.value == "") {
		alert("��Ȯ�� �׸��ڵ带 �Է��� �ֽʽÿ�.");
		txt_paycd.focus();
		return false;
	}
	
	if (txt_paycdnm.value == "") {
		alert("��Ȯ�� �׸��Ī�� �Է��� �ֽʽÿ�.");
		txt_paycdnm.focus();
		return false;
	}

	return true;

}

/******************************************************************************
	Description : �����ڵ� ��ȸ[�˻�]
******************************************************************************/
function ln_Luxequery() { 

	//�޿�����[�˻�]
	//gcds_paycd11.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	//gcds_paycd11.Reset();

	//�׸񱸺�[�˻�]
	gcds_paycd22.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd22.Reset();
}

/******************************************************************************
	Description : �����ڵ� ��ȸ
******************************************************************************/
function ln_Luxequery1() { 

	//�޿�����
	//gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1120"; 
	//gcds_paycd1.Reset();

	//�׸񱸺�
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=1126"; 
	gcds_paycd2.Reset();

}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--�޿�����[�˻�]
<comment id="__NSID__"><OBJECT id="gcds_paycd11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" >
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<!--�޿�����
<comment id="__NSID__"><OBJECT id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" >
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<comment id="__NSID__"><OBJECT id="gcds_paycd22" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--�׸񱸺�[�˻�]-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE"><!--�׸񱸺�-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="p010001_t1(I:USER=gcds_pay)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pay" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pay" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>


<script language="javascript" for="gcds_pay" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_pay" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h100001_head.gif"></td>
    <td align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	
	<table border="0" cellpadding="1" cellspacing="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
				<nobr>&nbsp;���ޱ���&nbsp;&nbsp;</nobr></td>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_paydiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
					<param name=CBData					value="T^����޿�">
					<param name=CBDataColumns		value="MINORCD,MINORNM">
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>
			<td width="20"  style="border:0 solid #708090;border-right-width:1px;border-left-width:0px;" bgcolor="#eeeeee">
				<nobr>&nbsp;�׸񱸺�&nbsp;&nbsp;</nobr></td>
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_pbdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
					<param name=ComboDataID			value=gcds_paycd22>
					<param name=SearchColumn		value="MINORCD^MINORNM">
					<param name=Sort            value="TRUE">
					<param name=SortColumn			value="MINORCD">
					<param name=ListExprFormat	value="MINORNM">
					<param name=BindColumn			value="MINORCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
			</td>  
			<td width="10" style="border:0 solid #708090;border-right-width:1px;"  bgcolor="#eeeeee">
				<nobr>&nbsp;������&nbsp;</nobr></td>
			<td style="border:0 solid #708090;border-right-width:1px;" ><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_frdt1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px;" class="txtbox"	validFeatures="ignoreStatus=yes" validExp="">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=True>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM">
					<param name=MaxLength     value=6>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt1', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"> -->&nbsp;</nobr>
			</td> 
			<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;</nobr></td>  
		</tr>
	</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 

      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_pay classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH:630px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_pay">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='���ޱ���'			ID=PAYDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=LEFT Mask='����޿�'</C> 
								<C> Name='�׸񱸺�'			ID=PBDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=LEFT Data='gcds_paycd2:MINORCD:MINORNM' EditStyle=Lookup</C> 
								<C> Name='�׸��ڵ�'			ID=PAYCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=CENTER </C>
								<C> Name='�׸��'				ID=PAYCDNM  HeadAlign=Center HeadBgColor=#B9D4DC Width=118 align=LEFT </C>
								<C> Name='���۳��'	ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=CENTER Mask='XXXX/XX'</C> 
								<C> Name='������'	ID=TODT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=CENTER Mask='XXXX/XX'</C> 
								<C> Name='���α׷�ID'		ID=PGMID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=LEFT </C> 
       					">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset id=ft_div1 style="width:632px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
</fieldset>

					</td>
					<td width=3>
					</td>
					<td>
						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:243px;height:442px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090;'>
							<tr>
								<td style="width:90px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>���ޱ���</td>
								<td style="height:30px; border:0 solid #708090;border-bottom-width:1px;"><nobr>&nbsp;
									<comment id="__NSID__"><OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
										<param name=CBData					value="T^����޿�">
										<param name=CBDataColumns		value="MINORCD,MINORNM">
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
								</td>
              </tr>
              <tr>
                <td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>�׸񱸺�</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>&nbsp;
									<comment id="__NSID__"><OBJECT id=gclx_pbdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=120 style="position:relative;top:2px;" class="txtbox">
										<param name=ComboDataID			value=gcds_paycd2>
										<param name=SearchColumn		value="MINORCD^MINORNM">
										<param name=Sort            value="TRUE">
										<param name=SortColumn			value="MINORCD">
										<param name=ListExprFormat	value="MINORNM">
										<param name=BindColumn			value="MINORCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee"  align=CENTER>�׸��ڵ�</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_paycd" name="txt_paycd"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="8" onBlur="bytelength(this,this.value,8);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>�׸��Ī</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_paycdnm" name="txt_paycdnm"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="40" onBlur="bytelength(this,this.value,40);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>��걸��</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_caldiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:145;cursor:hand;" class="txtbox">
										<param name=Cols     value="3">
										<param name=Format   value="1^��,2^����,3^ǥ">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>���α׷�ID</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_pgmid" name="txt_pgmid"	type='text' style="width:120px;position:relative;left:5px" class="txtbox" maxlength="20" onBlur="bytelength(this,this.value,20);">
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>�����޿�����</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_autoyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:115;cursor:hand;" class="txtbox">
										<param name=Cols     value="2">
										<param name=Format   value="Y^����,N^������">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>��������</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcra_taxyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:1px;top:0px;height:24;width:115;cursor:hand;" class="txtbox">
										<param name=Cols     value="2">
										<param name=Format   value="Y^����,N^�����">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
								</td> 
							</tr>
							<!--tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>������</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<input id="txt_calseq" name="txt_calseq"	type='text'	style="width:90px;position:relative;left:5px" class="txtbox" maxlength="3" onBlur="bytelength(this,this.value,3);">
								</td>
							</tr-->
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>������۳��</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
									<comment id="__NSID__"><OBJECT id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
										<param name=Text          value="">
										<param name=Alignment			value=0>
										<param name=Border	      value=True>
										<param name=ClipMode			value=true>
										<param name=Numeric	      value=false>
										<param name=Format	      value="YYYY/MM">
										<param name=MaxLength     value=6>
										<param name=PromptChar	  value="_">
										<param name=IsComma	      value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</OBJECT></comment><script>__ws__(__NSID__);</script>

									<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;"> -->
								</td> 
							</tr>
							<tr>
								<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=CENTER>����������</td>
								<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
								<comment id="__NSID__"><OBJECT id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:6px;top:2px; width:50px; height:20px;" class=txtbox validFeatures="ignoreStatus=yes" validExp="">
									<param name=Text          value="">
									<param name=Alignment			value=0>
									<param name=Border	      value=True>
									<param name=ClipMode			value=true>
									<param name=Numeric	      value=false>
									<param name=Format	      value="YYYY/MM">
									<param name=MaxLength     value=6>
									<param name=PromptChar	  value="_">
									<param name=IsComma	      value=false>
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
								</OBJECT></comment><script>__ws__(__NSID__);</script>
								
								<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;"> -->											
							</td> 
						</tr>
						<tr>
							<td style="sheight:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=CENTER>��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
							<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
								<textarea id="txt_memo" name="txt_memo"	style="width:140px;height:115px;position:relative;left:5px" class="txtbox"></textarea>
							</td> 
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
<comment id="__NSID__"><OBJECT	id=gcbn_pay classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_pay>
	<param name=BindInfo		value='
		<C>Col=PAYDIV				Ctrl=gclx_paydiv      Param=BindColVal</C>
		<C>Col=PBDIV				Ctrl=gclx_pbdiv       Param=BindColVal</C>
		<C>Col=PAYCD				Ctrl=txt_paycd				Param=value</C>
		<C>Col=PAYCDNM			Ctrl=txt_paycdnm			Param=value</C>
		<C>Col=CALDIV				Ctrl=gcra_caldiv			Param=CodeValue</C>
		<C>Col=PGMID				Ctrl=txt_pgmid				Param=value</C>
		<C>Col=AUTOYN				Ctrl=gcra_autoyn			Param=CodeValue</C>
		<C>Col=TAX				Ctrl=gcra_taxyn		    	Param=CodeValue</C>
		<C>Col=FRDT					Ctrl=gcem_frdt				Param=text</C>
		<C>Col=TODT					Ctrl=gcem_todt				Param=text</C>
		<C>Col=MEMO					Ctrl=txt_memo					Param=value</C>
	'>
</OBJECT></comment><script>__ws__(__NSID__);</script>
		<!--C>Col=CALSEQ				Ctrl=txt_calseq				Param=value</C-->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	