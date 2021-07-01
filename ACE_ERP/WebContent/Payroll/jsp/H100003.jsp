<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�����/ȣ��ǥ����
+ ���α׷� ID	: H100003
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: h100003_s1, h100003_t1
------------------------------------------------------------------------------>
 
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>ȣ��ǥ����</title>
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


 gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	ln_Luxequery();								//�����ڵ�

	gcem_stdym.enable = false;		//���س��
	gclx_paygrd.enable = false;		//����
	gcem_stdym1.Text=gs_date;

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	var str1 = gcem_stdym1.text;

	gcds_pay.DataID ="/servlet/Contract.h100003_s1?v_str1="+fn_trim(str1);
	gcds_pay.Reset();

	gcem_stdym.enable = false;		//���س��
	gclx_paygrd.enable = false;		//����

//prompt("",gcds_pay.DataID );	

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	//if (gcds_pay.Countrow<=0) { return false; }

	gcds_pay.addrow();

	gcem_stdym.enable = true;			//���س��
	gclx_paygrd.enable = true;		//����

	gclx_paygrd.index = 0;

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){  

	if (!ln_Valchk()) return;

	if (gcds_pay.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_pay.KeyValue = "h100003_t1(I:USER=gcds_pay)";
			gctr_pay.Action = "/servlet/Contract.h100003_t1?v_str1=I";
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
		gctr_pay.action = "/servlet/Contract.h100003_t1";
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
	Description : ���Ͽ���
******************************************************************************/
function ln_File(){

	var str1=gcem_stdym.Text;	//���س��
	
	gcif_file.Open();

	var str2=fn_trim(gcif_file.Value);										//open file
	var str3=str2.substr(str2.length-3,3).toLowerCase();	//Ȯ���� ����

	if(str2=="") {
		alert("������ �����ϼ���");
	} else if(str3 !="csv")	{
	  gcif_file.Value="";
		alert("CSVȮ���� ������ �����ϼ���");
	//}	else if(str1.length != 6) {
	//	alert("���س���� 6�ڸ��� ��Ȯ�� �Է��ϼ���");
	}else{
		ln_File_1();
	}
}

/******************************************************************************
	Description : ������ ����Ʈ
******************************************************************************/
function ln_File_1(){

	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";		

	var THeader = "STDYM:String(6),"					
							+	"PAYGRD:String(4),"					
							+	"PAYSEQ:String(4),"   			
							+	"TIMAMT:String(9.0),"				
							+	"BASAMT:String(9.0),"   		
							+	"ECTAMT:Decimal(9.0),"			
							+	"MONAMT:Decimal(9.0),"			
							+	"SAGAMT:Decimal(9.0),"			
							+	"YERAMT:Decimal(9.0)";			

	gcds_temp.DataID = gcif_file.Value;
	gcds_temp.Reset();

	gcds_pay.SyncLoad=true;
	gcds_pay.ClearAll();
	gcgd_pay.DataID = "";

	gcds_pay.SetDataHeader(THeader);								//Header Set

	var row = gcds_pay.rowposition;
	var ls_pd = gcem_stdym.Text;

	for(var j=1;j<=gcds_temp.countrow;j++) {
			
		gcds_pay.addrow();

		var ls_pos = gcds_pay.rowposition;

		for (var i=1; i<=9; i++) {
			
			gcds_txt=fn_trim(gcds_temp.ColumnValue(j,i));

			gcds_txt=ln_Ltrim(gcds_txt,",");
			gcds_pay.ColumnValue(ls_pos,i) = gcds_txt;
		
		}
	}

	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�."; 
	// document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + gcds_pay.countrow + " ��";
	if (gcds_pay.countrow <1) alert("�˻��� �����Ͱ� �����ϴ�.");

	gcgd_pay.DataID = "gcds_pay";
	gcds_pay.SyncLoad=false;
	gcif_file.Value="";

}

/******************************************************************************
	Description :
******************************************************************************/
function ln_Ltrim(src,arg) {
	if(src != undefined)
	{
	var li_chk = src.length/4+1;
	var ls_val = src;
	for (var i=1; i<=li_chk; i++)	ls_val = ls_val.replace(arg,"");
	return ls_val;
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

	if (gcds_pay.countrow<1) { 
		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�."); 
	} else {
		gcgd_pay.RunExcel('ȣ��ǥ����');
	}
	
}

/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Valchk(){

	if (gcem_stdym.text == "") {
		alert("��Ȯ�� ���س���� �Է��� �ֽʽÿ�.");
		gcem_stdym.Focus();
		return false;
	}
	
	return true;

}

/******************************************************************************
	Description : �����ڵ� ��ȸ
******************************************************************************/
function ln_Luxequery() { 

	//�����ڵ�
	gcds_paycd1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2001"; 
	gcds_paycd1.Reset();

	//����
	gcds_paycd2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd2.Reset();

	//����[�˻�]
	gcds_paycd3.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2018"; 
	gcds_paycd3.Reset();

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gcds_pay" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
	<PARAM NAME="SortExpr" VALUE="+PAYGRD">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_pay2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_pay3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--����-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--����-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_paycd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE" ><!--����[�˻�]-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pay classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h100003_t1(I:USER=gcds_pay)">
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
<script language="javascript" for="gcds_pay2" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_pay2" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	if(gcds_pay2.countrow <=0)
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


</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/h100003_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_file.gif"	style="cursor:hand" onclick="ln_File()">
			<img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
						<td style="height:23px;border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
							<nobr>&nbsp;���س��&nbsp;</nobr></td>
								<td style="height:23px;border:0 solid #708090;border-bottom-width:0px" align=center><nobr>
									<comment id="__NSID__"><OBJECT id=gcem_stdym1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:1px;top:2px; width:50px; height:20px;" class="txtbox">
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
									</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									
									<comment id="__NSID__"><OBJECT id=gcif_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:9px;width:0; height:0;" align="absmiddle">
										<param name="Text"		value='ã�ƺ���'>
										<param name="Enable"	value="True">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
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
							<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pay style="WIDTH:576px;HEIGHT:420px;border:1 solid #777777;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_pay">
								<PARAM NAME="Editable"		VALUE="FALSE">
								<PARAM NAME="BorderStyle" VALUE="0">
								<param name="Fillarea"		VALUE="true">
								<param name=Numeric       value=true>
								<param name=IsComma				value=true><!--���س�� : Mask='XXXX/XX'   -->
								<PARAM NAME="Format"			VALUE="  
									<F> Name='���س��'	ID=STDYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=CENTER		BgColor='#f5f5f5' </F>
									<F> Name='����'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=32  align=CENTER		BgColor='#f5f5f5' </F>
									<F> Name='ȣ��'			ID=PAYSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=32  align=CENTER		BgColor='#f5f5f5' Edit=Numeric  </F>
									<C> Name='�ñ�'			ID=TIMAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�⺻��'		ID=BASAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�ð���'		ID=ECTAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�����'		ID=TRAAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�������'		ID=PLAAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�����ٹ�����'	ID=NORAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=79  align=RIGHT		Edit=Numeric  </C>
									<C> Name='����޿�'		ID=MONAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='����޿�'		ID=PMOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='�����޿�'		ID=NMOAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='���翬��'		ID=YERAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='���忬��'		ID=PYEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									<C> Name='��������'		ID=NYEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=69  align=RIGHT		Edit=Numeric  </C>
									">
              </OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div1 style="width:578px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;
							</fieldset>
						</td>
						<td width=3></td>
						<td>
              <table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:295px;height:25px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
								<tr>
                  <td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;���س��</nobr></td>
									<td style="width:70px;height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_stdym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:3px; width:50px; height:20px;" class="txtbox" validFeatures="ignoreStatus=yes" validExp="">
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
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td> 
									<td style="height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  bgcolor="#eeeeee" class="txtbox"  align=center>
										<nobr>&nbsp;��&nbsp;��&nbsp;</nobr></td>
									<td style="width:90px;height:23px;border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-bottom-width:0px"  align=center><nobr>&nbsp;&nbsp;
										<comment id="__NSID__"><OBJECT id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=115 style="position:relative;top:3px;left:-5" class="txtbox">
											<param name=ComboDataID			value=gcds_paycd1>
											<param name=SearchColumn		value="MINORCD^MINORNM">
											<param name=Sort            value="TRUE">
											<param name=SortColumn			value="MINORCD">
											<param name=ListExprFormat	value="MINORNM">
											<param name=BindColumn			value="MINORCD">
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
                </tr>
							</table>

							<table border=0><tr><td height=1></td></tr></table>

							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0 style='width:295px;height:410px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>		
								<tr>
                  <td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" ><nobr>ȣ��</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff"><nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_1ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox" align=center>
										<nobr>&nbsp;�ñ�&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_5ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox" >
										<nobr>&nbsp;&nbsp;�⺻��&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_2ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px"  align=center bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;&nbsp;�ð���&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_3ho classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
									</td>
                </tr>

      

<!--���⿡ �ֱ� , ��������~ -->
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;�����&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_traamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;�������&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_plaamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;�����ٹ�����&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_noramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;������޿�&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_monamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;������޿�&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_pmoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;�������޿�&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_nmoamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center>
									<nobr>&nbsp;&nbsp;���翬��&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" bgcolor="#ffffff">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_yeramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script>
										</nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;���忬��&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_pyeamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>
								<tr>
									<td style="height:23px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;&nbsp;��������&nbsp;&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-bottom-width:1px">
										<nobr>&nbsp;
										<comment id="__NSID__"><OBJECT id=gcem_nyeamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;position:relative;left:0px;top:2px" class="txtbox" >
											<PARAM name="DataID"			value="gcds_pay">								
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=ClipMode      value=true>
											<param name=Numeric       value=true>
											<param name=IsComma				value=true>
											<param name=PromptChar    value="_">
											<param name=IsComma       value=false>
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</OBJECT></comment><script>__ws__(__NSID__);</script></nobr>
									</td>
								</tr>

								<tr>
                  <td style="height:70%;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" class="txtbox"  align=center><nobr>&nbsp;</nobr></td>
									<td style="height:23px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="#ffffff">
										<nobr></nobr></td>
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
<comment id="__NSID__"><OBJECT id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pay>
	<param name=BindInfo  value='
		<C>Col=STDYM		Ctrl=gcem_stdym       Param=text</C>
		<C>Col=PAYGRD		Ctrl=gclx_paygrd      Param=BindColVal</C>
		<C>Col=PAYSEQ		Ctrl=gcem_1ho		  Param=text</C>
		<C>Col=TIMAMT 		Ctrl=gcem_5ho		  Param=text</C>
		<C>Col=BASAMT 		Ctrl=gcem_2ho		  Param=text</C>
		<C>Col=ECTAMT 		Ctrl=gcem_3ho		  Param=text</C>
		<C>Col=TRAAMT 		Ctrl=gcem_traamt	  Param=text</C>
		<C>Col=PLAAMT 		Ctrl=gcem_plaamt	  Param=text</C>
		<C>Col=NORAMT 		Ctrl=gcem_noramt	  Param=text</C>
		<C>Col=MONAMT 		Ctrl=gcem_monamt	  Param=text</C>
		<C>Col=PMOAMT 		Ctrl=gcem_pmoamt	  Param=text</C>
		<C>Col=NMOAMT 		Ctrl=gcem_nmoamt	  Param=text</C>
		<C>Col=YERAMT 		Ctrl=gcem_yeramt	  Param=text</C>
		<C>Col=PYEAMT 		Ctrl=gcem_pyeamt	  Param=text</C>
		<C>Col=NYEAMT 		Ctrl=gcem_nyeamt	  Param=text</C>
	'>


</OBJECT></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



