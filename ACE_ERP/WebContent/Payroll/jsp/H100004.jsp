<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�����/�޿�����۾�
+ ���α׷� ID	: H100004
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: 
+ �� �� �� ��	: �̼��� - 2005.08.02 - �ҽ� ����
+ �� �� �� ��	: h100004_s1, h100004_s2, h100004_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�޿�����۾�</title>
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
var curtid = "88001";  
var key_sabun="";


gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	
	gcem_ec01af.Text=gs_date2;
	gcem_ec02af.Text=gs_date2+"25";
	gclx_select_ec01az.index=2;
	percent_div.style.display="none";

}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	var str1 = fn_trim(gcem_ec01af.Text);						//�޿����
	var str2 = gclx_select_ec01az.BindColVal;				//���ޱ���
	var str3 = fn_trim(gcem_ec02af.Text);						//��������

	gcds_data.DataID = "/servlet/Contract.h100004_s2?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2;
	
	gcds_data.Reset();				//�׸���
	gcds_data.rowposition=1;

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Finish(){

	var row = gcds_data.rowposition;
	var str1 = gcem_ec01af.text;
	var str2 = gclx_select_ec01az.BindColVal;

	for(i=1;i<=gcds_data.countrow;i++) {
		if (gcds_data.namevalue(row,"WRKSTS") == 'C') {
			alert("����ó�� �Ǿ����ϴ�.");
			return false;
		}else{
			for(i=1;i<=gcds_data.countrow;i++) {
				gcds_data.namevalue(i,"WRKSTS") = 'C';
			}
			if (confirm("������ ���� �Ͻðڽ��ϱ�?")){
				gctr_data.KeyValue = "p020002_t1(I:USER=gcds_data)";
				gctr_data.Action = "/servlet/Contract.h100004_t1?v_str1="+str1+"&v_str2="+str2;
				gctr_data.Post();
				ln_Query();
			}else{
				return false;
			}
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Create(){

	var row = gcds_data.rowposition;

	for(i=1;i<=gcds_data.countrow;i++) {
		if (gcds_data.namevalue(row,"WRKSTS") == 'C') {
			alert("����ó�� �Ǿ����ϴ�.");
			return false;
		}
	}

	var str1 = fn_trim(gcem_ec01af.Text);									//�޿����
	var str2 = fn_trim(gclx_select_ec01az.BindColVal);		//���ޱ���
	var str3 = fn_trim(gcem_ec02af.Text);									//��������
	var str4 = fn_trim(gcem_percent.Text);								//����
	
	if(str1.length < 6 ) 	{
		alert("�޿���� 6�ڸ��� �Է����ּ���");
		gcem_ec01af.Focus()
	}else if(str2.length < 1){
		alert("���ޱ����� �������ּ���");
		gclx_select_ec01az.Focus()
	}else if(str3.length < 8){
		alert("�������� 8�ڸ��� �Է����ּ���");
		gcem_ec02af.Focus()
	//}else if(str2=='5' && fn_trim(gcem_percent.Text)==''){
	//	alert("������ �Է��ϼ���");
  //	gcem_percent.Focus();
  } else {
		gcds_data.ClearData();
		var prcedure_gubun="/servlet/Contract.h100004_s1?"
											 + "v_str1=" + str1
											 + "&v_str2=" + str2
											 + "&v_str3=" + str3;
		if(str2=="T") {       //����޿�
			prcedure_gubun+= "&v_str4=SP_T100000";
		}else if(str2=="C"){  //�ұޱ޿�
				prcedure_gubun+= "&v_str4=SP_T200000";
		}else if(str2=="K"){  //�ұޱ޿�
				prcedure_gubun+= "&v_str4=SP_T100000";
		}


		gcds_select_create.DataID =prcedure_gubun;
		gcds_select_create.Reset(); //�׸���
		gcds_select_create.rowposition=1;
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

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ���ޱ��� 
<comment id="__NSID__"><OBJECT id=gcds_select_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>-->

<comment id="__NSID__"><OBJECT id=gcds_select_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ���� DataSet-->
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
<!-- <script language="javascript" for="gcds_select_ec01az" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_ec01az" event="onloadCompleted(row,colid)">
	for(i=gcds_select_ec01az.countrow;i>0; i--)  {   
		gcds_select_ec01az.rowposition=i;
		kkk=fn_trim(gcds_select_ec01az.NameValue(gcds_select_ec01az.rowposition,"MINORCD"))+"";
		if((kkk == '3' || kkk == '4') || kkk == '5') {
			gcds_select_ec01az.deleteRow(gcds_select_ec01az.rowposition); //�׸���
		}
	}
  gclx_select_ec01az.index=0;
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
</script> -->

<script language="javascript" for="gcds_select_create" event="OnLoadStarted()">
	//ft_cnt1.innerText="����Ÿ �������Դϴ�.";
	window.status=gclx_select_ec01az.Text+" ������Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_select_create" event="onloadcompleted(row,colid)">
	//ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status=gclx_select_ec01az.Text+" �޿� ��� ���α׷��� �Ϸ��߽��ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_select_create.countrow <0) {
			alert("���ϰ��� �����ϴ�.");
	}else {
		//if(gcds_select_create.NameValue(1,"RETCOD") == "Y") {
		alert(gclx_select_ec01az.Text+" �޿� ��� ���α׷��� ���������� ���� �Ǿ�����\n��ȸ ��ư�� ����Ͽ� ������¸� ��ȸ�Ͻñ� �ٶ��ϴ�.");
		//}else {
		//alert(gclx_select_ec01az.Text+" �޿� ��� ���α׷��� ���������� ���� ���� �ʾҽ��ϴ�.");
		//}
	}
	window.status="";
</script>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language=JavaScript for= "gclx_select_ec01az" event="OnSelChange()">
	var str1 = fn_trim(gclx_select_ec01az.BindColVal);   //���ޱ���
 if(str1=='5') {
    percent_div.style.display="block";
		gcem_percent.Focus();
 }else{
    percent_div.style.display="none";
 }
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h100004_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>
			<img src="../../Common/img/btn/com_b_finish.gif" style="cursor:hand" onclick="ln_Finish()">
			<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()" >
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		<table  cellpadding="0" cellspacing="0" border="0" style='width:877px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
      <tr> 
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;�޿����&nbsp;</nobr></td>	
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-top:2px;"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ec01af classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=0>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY/MM">
						<param name=MaxLength     value=6>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</OBJECT></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ec01af', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr></td>

				<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���ޱ���&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;">
				
			<table cellspacing=0 cellpadding=0 border=0 width=0>
				<tr>
					<td align=left><nobr>
						<comment id="__NSID__"><OBJECT id=gclx_select_ec01az  name="gclx_select_ec01az" classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=50 style="position:relative;left:8px;top:2px;font-size:12px;width:100px;height:200px;">
							<param name=CBData					value="T^����޿�,C^�ұޱ޿�,K^Ư����">
							<param name=CBDataColumns		value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORCD^MINORNM">
							<param name=Sort            value="TRUE">
							<param name=SortColumn			value="MINORCD">
							<param name=ListExprFormat	value="MINORNM">
							<param name=BindColumn			value="MINORCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</TD>
					<TD>
<div id=percent_div style="display:block;"><nobr>
			<table cellspacing=0 cellpadding=0 border=0 width=0>
				<tr>
					<td align=left>
						<comment id="__NSID__"><OBJECT id=gcem_percent classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:10px;top:0px;width:30px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="9999">
							<param name=MaxLength     value=4>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
					<td STYLE="PADDING-TOP:1px;"><nobr>&nbsp;&nbsp;<FONT  SIZE=2>%</FONT></nobr></td></tr></table></nobr></div></TD></TR></TABLE>
					</td>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;padding-left:3px;padding-right:3px;" bgcolor="#eeeeee"><nobr>&nbsp;��������&nbsp;</nobr></td>	
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;"><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gcem_ec02af classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1	validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment	  value=0>
							<param name=Border	      value=True>
							<param name=ClipMode	  value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=MaxLength     value=8>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ec02af', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="350"><nobr>&nbsp;</nobr></td>
				</tr>
			</table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
		<comment id="__NSID__"><OBJECT id=gcgd_hcl classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 875px; HEIGHT: 423px;border:1 solid #777777" viewastext>
			<PARAM NAME="DataID"			VALUE="gcds_data">
			<PARAM NAME="Editable"		VALUE="FALSE">
			<PARAM NAME="ColSizing"		VALUE="True">
			<PARAM NAME="BorderStyle" VALUE="0">
			<param name="Fillarea"		VALUE="true">
			<PARAM NAME="Format"			VALUE="
				<C> Name='�޿��⵵'		ID=APPDT	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  Mask='XXXX/XX' </C>
				<C> Name='���ޱ���'		ID=PAYDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center  Mask='����޿�'</C>
				<C> Name='�޿��׸�'		ID=PAYCD	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center</C>
				<C> Name='������'			ID=FRDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center  Mask='XXXX/XX/XX'</C> 
				<C> Name='���۽ð�'		ID=FRTM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center Mask='XX:XX:XX' </C> 
				<C> Name='������'			ID=TODT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XXXX/XX/XX'</C>
				<C> Name='����ð�'		ID=TOTM		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=center  Mask='XX:XX:XX' </C>
				<C> Name='����'				ID=WRKSTS	HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=center  Value={Decode(WRKSTS,1,'������',2,'�Ϸ�',E,'����','C','����')} </C>
				<C> Name='���'				ID=MEMO		HeadAlign=Center HeadBgColor=#B9D4DC Width=280 align=left</C>
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
			</fieldset>
						</td>
					</tr>
				</table>
			</td>
        </tr>
      </table>
    </td>
  </tr>
	</table>


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	




