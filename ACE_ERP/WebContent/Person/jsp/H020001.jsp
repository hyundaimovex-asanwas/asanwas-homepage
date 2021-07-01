<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: H020001.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: 
+ �� �� �� ��	: h020001_s1, h020001_s2, hclcode_s1, h020001_t1, h020001_t2
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Sales/common/include/head.jsp"/>
<title>ä������ȳ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
get_cookdata();
var gs_cdate = "";
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

   	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gcurdate;
	gs_cdate = gcem_to.text;

	//��ü�а�
	gcds_career.DataID = "/servlet/Person.hclcode_s1?v_str1=1129";
	gcds_career.Reset();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcta_disp.ActiveIndex = 1;
	gcds_data.DataID = "/servlet/Person.h020001_s1?"
									 + "v_str1=" + fn_trim(gcem_fr.text)
									 + "&v_str2=" + fn_trim(gcem_to.text)
									 + "&v_str3=" + gs_cdate;
	gcds_data.Reset();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_RQuery(){
	gcds_data.DataID = "/servlet/Person.h020001_s1?"
									 + "v_str1=" + fn_trim(gcem_fr.text)
									 + "&v_str2=" + fn_trim(gcem_to.text)
									 + "&v_str3=" + gs_cdate;
	gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(g){
	if (g=="A") {
		gcds_data.AddRow();
		gcds_careerd.ClearData();
		gcds_career.Reset();
	} else {
		gcds_careerd.AddRow();
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_data.countrow <1) {
		alert("�����Ͻ� ������ �����ϴ�.");
	} else {
		if (gcds_data.IsUpdated ){
			if (ln_ValChk()) {
				if (confirm("�ش� ä����� �����ϰڽ��ϱ� ?")) {
					gctr_data.KeyValue = "Person.h020001_t1(I:USER=gcds_data,I:CARRER=gcds_careerd)";
					gctr_data.Action = "/servlet/Person.h020001_t1";
					gctr_data.Parameters = "v_str1=" + gcurdate.substring(2,4)+gcurdate.substring(5,7);
					gctr_data.post();
				}
			}
		} else if (gcds_careerd.IsUpdated ){
			if (confirm("�ش� ä����� �����ϰڽ��ϱ� ?")) {
				gctr_data.KeyValue = "Person.h020001_t2(I:USER=gcds_careerd)";
				gctr_data.Action = "/servlet/Person.h020001_t2";
				gctr_data.Parameters = "v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"INFODIV");
				gctr_data.post();
			}
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(g){
	if (g=="A") {
		if (gcds_data.countrow <1) {
			alert("�����Ͻ� ������ �����ϴ�.");
		} else {
			if (confirm("�ش� ä����� ���� �ϰڽ��ϱ� ?")) {
				gcds_data.deleterow(gcds_data.rowposition);
				gcds_careerd.deleteall();

				gctr_data.KeyValue = "Person.h020001_t1(I:USER=gcds_data,I:CARRER=gcds_careerd)";
				gctr_data.Action = "/servlet/Person.h020001_t1";
				gctr_data.post();
			}
		}
	} else {
		var row = gcds_careerd.rowposition;
		if (gcds_careerd.sysStatus(row)=="1") gcds_careerd.undo(row);
		else gcds_careerd.deleterow(row);
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
	Description : ä���а�
******************************************************************************/
function ln_Before(){
	//�ش��а�
	gcds_careerd.DataID = "/servlet/Person.h020001_s2?v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"INFODIV");
	gcds_careerd.Reset();
}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_ValChk(){
	for (var i=1; i<= gcds_data.countrow; i++){

		if (gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2){
			if (gcds_data.namevalue(i,"CARRDIV")==""){
				alert("ä�뱸���� ������ �ֽʽÿ�");
				gcra_carrdiv.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"INFO")==""){
				alert("ä������� �ۼ��� �ֽʽÿ�");
				txt_info.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"RFRDT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \nä����� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=1;
				gcem_rfr.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"RTODT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \nä����� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=1;
				gcem_rto.focus();
				return false;
			}
			
			if (gcds_data.namevalue(i,"RMEMO")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \nä����� ������ �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=1;
				txt_rmemo.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"IFRDT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=2;
				gcem_ifr.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"ITODT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=2;
				gcem_ito.focus();
				return false;
			}
			
			if (gcds_data.namevalue(i,"IMEMO")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� ������ �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=2;
				txt_imemo.focus();
				return false;
			}
		
			if (gcds_data.namevalue(i,"PFRDT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=3;
				gcem_pfr.focus();
				return false;
			}

			if (gcds_data.namevalue(i,"PTODT")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� �Ⱓ�� �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=3;
				gcem_pto.focus();
				return false;
			}
			
			if (gcds_data.namevalue(i,"PMEMO")==""){
				alert("���� �о� [" + gcds_data.namevalue(i,"INFO") + "]�� \n�������� ������ �ۼ��� �ֽʽÿ�");
				gcta_disp.ActiveIndex=3;
				txt_pmemo.focus();
				return false;
			}
				
		}
	}

	return true;

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_career classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+minornm">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_careerd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_career" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
	ln_Before();
</script>

<script language="javascript" for="gcds_career" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_careerd" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_careerd" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="onclick(row,colid)">
	gcta_disp.ActiveIndex = 1;
	ln_Before();
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/h020001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_delete.gif" id=btn_del style="cursor:hand" onclick="ln_Delete('A')"> 
			<img src="../../Common/img/btn/com_b_insert.gif" id=btn_add style="cursor:hand" onclick="ln_Add('A')"> 
			<img src="../../Common/img/btn/com_b_save.gif" id=btn_save style="cursor:hand" onclick="ln_Save()"> 
			<img src="../../Common/img/btn/com_b_query.gif" id=btn_query style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="0" cellspacing="0" border="0" style="width:877px;height:20px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
	      <tr>
					<td width="100" class="tab12" bgcolor="#eeeeee">�˻�����</td>
					<td width="720">
						<table cellpadding=0 cellspacing=0 border="0">
							<tr>
								<td height="30px">&nbsp;
									<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
								</td>
								<td align=center>&nbsp;~&nbsp;</td>
								<td>
									<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
							    </object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;
								</td>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=3></td></tr>  	
  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:500">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:500px;height:419px;border:1 solid #777777" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
              <PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
						  <PARAM NAME="Format"			VALUE="  
								<C> Name='���úо�' ID=INFO 		HeadAlign=Center HeadBgColor=#B9D4DC Width=245, align=left </C> 
								<C> Name='ä�뱸��' ID=CARRDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,  align=center, EditStyle='combo', data='2:����,1:���,3:����' </C>
								<G> Name='�ȳ�����' HeadAlign=Center HeadBgColor=#B9D4DC 
									<C> Name='������' ID=RFRDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80, align=center, Mask='XXXX/XX/XX'</C> 
									<C> Name='������' ID=RTODT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center, Mask='XXXX/XX/XX'</C> 
                </G>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:502px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
          <td width=3>&nbsp;</td>
					<td>
						<table border="0" cellpadding="0" cellspacing="0" style="width:368px; height:415px;border:1 solid #708090">
							<tr>
								<td class="tab11" width="100px" bgcolor="#eeeeee">ä�뱸��</td>
								<td class="tab22">
									<comment id="__NSID__"><object id=gcra_carrdiv classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
						         style="position:relative;left:8px;top:0px;height:24;width:160;cursor:hand;">
					             <param name=Cols     value="3">
						           <param name=Format   value="2^����,1^���,3^����">
			            </object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" bgcolor="#eeeeee">ä�����</td>
								<td class="tab22"><input id="txt_info" type="text" class="txt11" style="width:253px;" maxlength="50" onBlur="bytelength(this,this.value,50);"></td>
							</tr>
							<tr>
								<td class="tab11" bgcolor="#eeeeee">ä���а�</td>
								<td class="tab22">
									<table cellpadding=0 cellspacing=0 border=0>
										<tr>
											<td class="tab22" align=right>
												<img src="../../Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete('B')"> 
												<img src="../../Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add('B')"> 
											</td>
										</tr>
										<tr>
											<td>
												<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_careerd 
													style="width: 265px; height: 99px;border:0 solid #708090;">
							              <PARAM NAME="DataID"			VALUE="gcds_careerd">
							              <PARAM NAME="Editable"		VALUE="true">
							              <PARAM NAME="BorderStyle" VALUE="0">
														<PARAM NAME="Fillarea"		VALUE="true">
														<PARAM NAME=IndWidth      VALUE=0>
													  <PARAM NAME="Format"			VALUE="   
															<C> Name='No'				ID={currow} HeadAlign=Center HeadBgColor=#B9D4DC Width=40,	align=right</C>
															<C> Name='ä���а�' ID=MAJORCD 	HeadAlign=Center HeadBgColor=#B9D4DC Width=208, align=left, EditStyle=Lookup, Data='gcds_career:minorcd:minornm'</C>
														">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr><td height="8px;"></td></tr>
							<tr>
								<td colspan="2">
									<comment id="__NSID__"><object id=gcta_disp classid=CLSID:ED382953-E907-11D3-B694-006097AD7252
										style="position:relative; left:0; top:0; width:300; height:20;"> 
						          <param name="BackColor"						value="#dddddd">
		                  <param name="DisableBackColor"    value="#ffffff">
				              <param name="Format"              value='
								        <T>divid="div1"    title="ä������"</T>
							          <T>divid="div2"    title="��������"</T>
							          <T>divid="div3"    title="�հ�����"</T>
							          <T>divid="div4"    title="���հ�����"</T>
											'>
				         </object></comment><script>__ws__(__NSID__);</script>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td style="height:233px;border:0 solid #708090;border-top-width:1px;" colspan="4">

												<div id=div1 style="position:absolute;left:509px;top:291px;border:0 solid #70890;border-top-width:1">
            						<table border="0" cellpadding="0" cellspacing="0">
            							<tr>
            								<td class="tab11" width="80px;" bgcolor="#eeeeee">ä��ȳ�</td>
            								<td class="tab22">
            									<comment id="__NSID__"><object id=gcem_rfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_rfr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            									&nbsp;<span style="position:relative;top:-3px;">~</span>&nbsp;
            									<comment id="__NSID__"><object id=gcem_rto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_rto', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            								</td>
            							</tr>
            							<tr>
            								<td class="tab12" bgcolor="#eeeeee">ä�볻��</td>
            								<td>&nbsp;<textarea id="txt_rmemo" style="font-size:9pt;width:278px;height:202px;border:0 solid #708090" onBlur="bytelength(this,this.value,150);"></textarea></td>
            							</tr>
            						</table>
												</div>
												<div id=div2 style="position:absolute;left:509px;top:291px;border:0 solid #70890;border-top-width:1">
            						<table border="0" cellpadding="0" cellspacing="0" id="tab2">
            							<tr>
            								<td class="tab11" width="80px;" bgcolor="#eeeeee">�����ȳ�</td>
            								<td class="tab22" width="285">
            									<comment id="__NSID__"><object id=gcem_ifr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ifr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            									&nbsp;<span style="position:relative;top:-3px;">~</span>&nbsp;
            									<comment id="__NSID__"><object id=gcem_ito classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ito', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            								</td>
            							</tr>
            							<tr>
            								<td class="tab12" bgcolor="#eeeeee">��������</td>
            								<td>&nbsp;<textarea id="txt_imemo" style="font-size:9pt;width:278px;height:202px;border:0 solid #708090" onBlur="bytelength(this,this.value,150);"></textarea></td>
            							</tr>
            						</table>
												</div>
												<div id=div3 style="position:absolute;left:509px;top:291px;border:0 solid #70890;border-top-width:1">
            						<table border="0" cellpadding="0" cellspacing="0" id="tab3">
            							<tr>
            								<td class="tab11" width="80px;" bgcolor="#eeeeee">�հݾȳ�</td>
            								<td class="tab22" width="285">
            									<comment id="__NSID__"><object id=gcem_pfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_pfr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            									&nbsp;<span style="position:relative;top:-3px;">~</span>&nbsp;
            									<comment id="__NSID__"><object id=gcem_pto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
            										style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;">
            											<param name=Alignment	  value=0>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
            									&nbsp;<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_pto', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
            								</td>
            							</tr>
            							<tr>
            								<td class="tab12" bgcolor="#eeeeee">�հݳ���</td>
            								<td>&nbsp;<textarea id="txt_pmemo" style="font-size:9pt;width:278px;height:202px;border:0 solid #708090" onBlur="bytelength(this,this.value,150);"></textarea></td>
            							</tr>
            						</table>
												</div>
												<div id=div4 style="position:absolute;left:509px;top:291px;border:0 solid #70890;border-top-width:1">
            						<table border="0" cellpadding="0" cellspacing="0" id="tab3">
            							<tr>
            								<td class="tab11" width="80px;" bgcolor="#eeeeee" colspan="2">���հݾȳ�</td>
            							</tr>
            							<tr>
            								<td class="tab12" width="80px;" bgcolor="#eeeeee">���հݳ���</td>
            								<td>&nbsp;<textarea id="txt_normemo" style="font-size:9pt;width:278px;height:202px;border:0 solid #708090" onBlur="bytelength(this,this.value,150);"></textarea></td>
            							</tr>
            						</table>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=INFO       Ctrl=txt_info      Param=value</C>
		<C>Col=CARRDIV    Ctrl=gcra_carrdiv  Param=codevalue</C>
		<C>Col=RFRDT			Ctrl=gcem_rfr			 Param=text</C>
		<C>Col=RTODT			Ctrl=gcem_rto		   Param=text</C>
		<C>Col=RMEMO      Ctrl=txt_rmemo		 Param=value</C>
		<C>Col=IFRDT			Ctrl=gcem_ifr      Param=text</C>
		<C>Col=ITODT			Ctrl=gcem_ito      Param=text</C>	
		<C>Col=IMEMO      Ctrl=txt_imemo     Param=value</C>
		<C>Col=PFRDT			Ctrl=gcem_pfr      Param=text</C>
		<C>Col=PTODT			Ctrl=gcem_pto      Param=text</C>
		<C>Col=PMEMO      Ctrl=txt_pmemo     Param=value</C>
		<C>Col=NORMEMO    Ctrl=txt_normemo   Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		