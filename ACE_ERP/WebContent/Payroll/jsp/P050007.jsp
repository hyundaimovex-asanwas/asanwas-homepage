<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/��Ÿ��Ȳ�˻�
+ ���α׷� ID	: p050007.HTML
+ �� �� �� ��	: ��ȸ|����
+ �� �� �� ��	: 
+ �� �� �� ��	: �̼��� - 2005.08.05 - �ҽ� ����
+ �� �� �� ��	: ������ - 2007.06.12 - �系 ������� �߰�
+ �� �� �� ��	: p050007_s1, p050007_s2, p050007_s3, p050007_s4, p050007_s5, 
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>��Ÿ��Ȳ�˻�</title>


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
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_app_yyyy.Text=gs_date3;
	gcem_app_yyyymm.Text=gs_date2;
	nwgubun.value="1";
	ln_visible_hidden("1");

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	eval("ln_Query_"+nwgubun.value+"();");
}

/******************************************************************************
	Description : ��ȸ : ����������Ѱ�ǥ
******************************************************************************/
function ln_Query_1(){ 
	var str1 = fn_trim(gcem_app_yyyy.Text);  //��������
	if(str1.length != 4) {
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyy.Focus();
	}	else	{
		gcds_grid_ec01az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s1?"
									 + "v_str1=" + str1;
		gcds_grid_ec01az.Reset(); //�׸���
		gcds_grid_ec01az.rowposition=1;
	}
}

/******************************************************************************
	Description : ��ȸ : �������ο��ݳ�����Ȳ
******************************************************************************/
function ln_Query_2(){ //�������ο��ݳ�����Ȳ
	var str1 = fn_trim(gcem_app_yyyy.Text);  //��������
	if(str1.length != 4){
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyy.Focus();
	}	else	{
		gcds_grid_ec02az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s2?"
									 + "v_str1=" + str1;
		gcds_grid_ec02az.Reset(); //�׸���
		gcds_grid_ec02az.rowposition=1;
	}
}

/******************************************************************************
	Description : ��ȸ : �������ο��ݳ��γ���
******************************************************************************/
function ln_Query_3(){ 
	var str1 = fn_trim(gcem_app_yyyymm.Text);		//���س��
	if(str1.length != 6){
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyymm.Focus();
	}	else	{
		gcds_grid_ec03az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s3?"
									 + "v_str1=" + str1;
		gcds_grid_ec03az.Reset(); //�׸���
		gcds_grid_ec03az.rowposition=1;
	}
}

/******************************************************************************
	Description : ��ȸ : �����ǰ��������Ȳ
******************************************************************************/
function ln_Query_4(){ 
	var str1 = fn_trim(gcem_app_yyyymm.Text);		//���س��
	var str2 = "";        //temp
	if(str1.length != 6)	{
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyymm.Focus();
	}	else	{
	  yyyymmPlusMinus(str1,'','');
		gcds_grid_ec04az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s4?"
									 + "v_str1=" + str1
									 + "&v_str2=" + str2_1;
		gcds_grid_ec04az.Reset(); //�׸���
		gcds_grid_ec04az.rowposition=1;
	}
}

/******************************************************************************
	Description : ��ȸ : �к��������޳���
******************************************************************************/
function ln_Query_5(){ 
	var str1 = fn_trim(gcem_app_yyyymm.Text);		//���س��
	if(str1.length != 6){
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyymm.Focus();
	}	else	{
		gcds_grid_ec05az.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s5?"
									 + "v_str1=" + str1;
		gcds_grid_ec05az.Reset(); //�׸���

		gcds_grid_ec05az.rowposition=1;
	}
}



/******************************************************************************
	Description : ��ȸ : �系�������
******************************************************************************/
function ln_Query_6(){ 
	var str1 = fn_trim(gcem_app_yyyymm.Text);		//���س��
	if(str1.length != 6){
		alert("���س⵵�� �Է����ּ���");
		gcem_app_yyyymm.Focus();
	}	else	{
		gcds_loan_6.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p050007_s6?"
									     + "v_str1=" + str1;

		gcds_loan_6.Reset(); //�׸���
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvyyyy(yyyy,mm){
	if(parseInt(mm)==1)	{
    returnPrv=(parseInt(yyyy)-1)+"";
	}	else returnPrv=yyyy;
	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_prvmm(prv){
	if(parseInt(prv)==1) returnPrv="12";
	else
	{
		returnPrv=(parseInt(prv)-1)+"";
	}
	if(returnPrv.length ==1)
			returnPrv="0" + returnPrv ;
	return returnPrv;
}

function ln_prvmm2(prv){
	if(parseInt(prv)==1) returnPrv="12";
	else
	{
		returnPrv=(parseInt(prv)-1)+"";
	}
	return returnPrv;
}

/******************************************************************************
	Description : 
******************************************************************************/
function yyyymmPlusMinus(str2,str1,gs_date2){
	if( str2.length ==6)	 {
		str2_1=ln_prvyyyy(str2.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str2.substr(4,2));
		str2_2=str2.substr(0,4) +""+ str2.substr(4,2);
	} else if ( str1.length ==8) {
		str2_1=ln_prvyyyy(str1.substr(0,4),str2.substr(4,2)) +""+ ln_prvmm(str1.substr(4,2));
		str2_2=str1.substr(0,4) +""+ str1.substr(4,2);
 } else {
		str2_1=ln_prvyyyy(gs_date2.substr(0,4),gs_date2.substr(4,2)) +""+ ln_prvmm(gs_date2.substr(4,2));
		str2_2=gs_date2.substr(0,4) +""+ gs_date2.substr(4,2);
 }
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_visible_hidden(Obj){
   var str1="";
	 var str2="";
   disp01.style.visibility = "hidden";
   disp02.style.visibility = "hidden";
   disp03.style.visibility = "hidden";
   disp04.style.visibility = "hidden";
   disp05.style.visibility = "hidden"; 
	 disp06.style.visibility = "hidden"; 

  if(Obj=="1")
     disp01.style.visibility = "visible";
  else if (Obj=="2")
     disp02.style.visibility = "visible";
  else if (Obj=="3")
     disp03.style.visibility = "visible";
  else if (Obj=="4") {
     disp04.style.visibility = "visible";
		 str2 = gcem_app_yyyymm.text;
		 str2 = str2.substr(5,6);
		 str1 = ln_prvmm2(str2);
		 gcgd_grid_ec04az.ColumnProp('PRE_NAME','NAME') = "��������� " +str1+ "����";
		 gcgd_grid_ec04az.ColumnProp('CUR_NAME','NAME') = "�������� " +str2+ "����";

 }else if (Obj=="5")
     disp05.style.visibility = "visible";
 else if(Obj=="6"){
     disp06.style.visibility = "visible";
 }

	if(Obj=="1" || Obj=="2") {
		document.all.text_dsp01.style.display='block';
		document.all.text_dsp02.style.display='none';
		document.all.emedit_dsp01.style.display='block';
		document.all.emedit_dsp02.style.display='none';
	} else {
		document.all.text_dsp01.style.display='none';
		document.all.text_dsp02.style.display='block';
		document.all.emedit_dsp01.style.display='none';
		document.all.emedit_dsp02.style.display='block';
	}
  
}

/*******************************************************************************
  Description : Grid �����͸� Excel�� ������� ���
******************************************************************************/
function ln_Excel(){

	switch (nwgubun.value) {
		case '1' :
			if (gcds_grid_ec01az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_grid_ec01az.RunExcel("����������Ѱ�ǥ");  break;
		case '2' :
			if (gcds_grid_ec02az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_grid_ec02az.RunExcel("�������ο��ݳ�����Ȳ");  break;
		case '3' :
			if (gcds_grid_ec03az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_grid_ec03az.RunExcel("�������ο��ݳ��γ���");  break;
		case '4' :
			if (gcds_grid_ec04az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_grid_ec04az.RunExcel("�����ǰ��������Ȳ");  break;
		case '5' :
			if (gcds_grid_ec05az.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_grid_ec05az.RunExcel("�к��������޳���");  break;
    case '6' :
			if (gcds_loan_6.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else gcgd_loan_6.RunExcel("�系�������");  break;
		
	}
}


/*******************************************************************************
  Description : ��¹�
******************************************************************************/
function ln_Print(){
  var strmm=gcem_app_yyyymm.Text;
	switch (nwgubun.value) {
    case '6' :
			if (gcds_loan_6.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
			else {
			    gcds_rpt_head_6.ClearAll();
					ln_SetDataHeader();
					gcds_rpt_head_6.Addrow();
					 
					gcds_rpt_head_6.namevalue(1,"MM") = " �� �� �� �� �� �� ( "+strmm.substring(4,6)+" �� )" ;
          gcds_rpt_head_6.namevalue(1,"PRINTDT") = gs_date;
          gcds_rpt_head_6.namevalue(1,"CNT") = "�� (" +gcds_loan_6.countrow +" ��)" ;
          gcrp_print_6.preview();
			}
	}
}

/*******************************************************************************
  Description : ����Ÿ�� ���
******************************************************************************/
function ln_SetDataHeader(){
	switch (nwgubun.value) {
	  case '6':
			if(gcds_rpt_head_6.countrow<1){
				var s_temp = "MM:STRING,PRINTDT:STRING,CNT:STRING";
				gcds_rpt_head_6.SetDataHeader(s_temp);
			}
		}
 }
 </script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_grid_ec01az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec02az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec03az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec04az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_grid_ec05az classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��ȸ DataSet-->
		<param name=SortExpr	value="+DEPTNM+EMPNO">      
		<param name=SubsumExpr	value="DEPTNM">           
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_loan_6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �系�������-->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rpt_head_6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �系������� ��¹� head-->
</OBJECT></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><OBJECT id=gcds_rpt_detail_6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �系������� ��¹� detail-->
</OBJECT></comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_grid_ec01az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec01az" event="onloadcompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec01az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec02az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt2.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec02az" event="onloadcompleted(row,colid)">
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec02az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec03az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt3.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec03az" event="onloadcompleted(row,colid)">
	ft_cnt3.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec03az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec04az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt4.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec04az" event="onloadcompleted(row,colid)">
	ft_cnt4.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec04az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");

	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_grid_ec05az" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt5.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_grid_ec05az" event="onloadcompleted(row,colid)">
	ft_cnt5.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_grid_ec05az.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	nwgubun.disabled=false;
</script>

<script language="javascript" for="gcds_loan_6" event="OnLoadStarted()">
	nwgubun.disabled=true;
	ft_cnt6.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_loan_6" event="onloadcompleted(row,colid)">
	ft_cnt6.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_loan_6.countrow <=0) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	nwgubun.disabled=false;
</script>

<script language=JavaScript for=gcem_app_yyyymm event=OnKillFocus()>

	if (nwgubun.value==4){
		ln_visible_hidden(4);
  }
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
			B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<TABLE width="876" border="0"   cellpadding="0" cellspacing="0">
  <TR>
    <TD width=100% height="25px">
      <table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
        <tr> 
           <td width="197" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/p050006_head.gif" width=197></td>
           <td  width="100%" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:1px"> 
					    <img name="btn_print"   border="0" src="../../Common/img/btn/com_b_print.gif" align= "center"  style="cursor:hand"  onclick="ln_Print()">
							<img name="btn_excel"   border="0" src="../../Common/img/btn/com_b_excel.gif" align= "center"  style="cursor:hand"  onClick="ln_Excel()" >
							<img name="btn_display" border="0" src="../../Common/img/btn/com_b_query.gif" align= "center"  style="cursor:hand"  onClick="ln_Query()"></a>&nbsp;
           </td>
        </tr>
      </table>
    </TD>
  </TR>
  <TR>
    <TD style="padding-left:3px;">
      <TABLE cellpadding=0 cellspacing=0 border=0  style='width:876px; height:30px; font-size:9pt;background-color:#ffffff; BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	    <TR>
	    	<td style="border:0 solid #708090;BORDER-right-WIDTH:1px;" bgcolor="#eeeeee"><nobr>&nbsp;��±���&nbsp;</nobr></td>
		    <td style="border:0 solid #708090;BORDER-right-WIDTH:1px;"><nobr>&nbsp;
					<SELECT id="nwgubun" 		name="nwgubun" style="width:150px;" onchange="ln_visible_hidden(this.value);">
						<option selected value="1">����������Ѱ�ǥ</option>
						<option value="2">�������ο��ݳ�����Ȳ</option>
						<option value="3">�������ο��ݳ��γ���</option>
						<option value="4">�����ǰ��������Ȳ</option>
						<option value="5">�к��������޳���</option>
						<option value="6">�系�������</option>
					</SELECT>&nbsp;</nobr> 
		    </TD>
		    <td  width="10"  style="border:0 solid #708090;BORDER-right-WIDTH:1px;"  					         bgcolor="#eeeeee"><nobr>
					<div id="text_dsp01" style="display:block">&nbsp;���س⵵&nbsp;</div>
					<div id="text_dsp02" style="display:none">&nbsp;���س��&nbsp;</div></nobr></td>
		    <td  style="border:0 solid #708090;BORDER-right-WIDTH:0px;padding-top:4px;"   bgcolor="#ffffff"  ><nobr>
					<div id="emedit_dsp02" style="display:none"><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_app_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style=" width:50px;  font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
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
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</div>
				<div id="emedit_dsp01" style="display:block"><nobr>&nbsp;
          <comment id="__NSID__"><object id=gcem_app_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F tabindex="2" style=" width:40px; font-family:dotum; font-size:9pt; " class=objclsEme2	validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment	  value=1>
						<param name=Border	      value=True>
						<param name=ClipMode	  value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="YYYY">
						<param name=MaxLength     value=6>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</div></nobr>
				</td> 
		    <td width="100%"><nobr>&nbsp;&nbsp;</nobr></td>
	    </TR>
	  </TABLE>
    </TD>
   </TR>
 <tr> 
   <td height=3></td>
  </tr>  
</TABLE>

<div id=disp01 name=disp01 style="position:absolute;top:172px; left:173px; width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
	   <table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
       <tr> 
         <td style="width:100%">
						<comment id="__NSID__"><object id="gcgd_grid_ec01az" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410" width="874">
							<param name=dataid value=gcds_grid_ec01az>
							<PARAM NAME=BorderStyle     VALUE="0">
							<param name=indwidth        value=0>
							<param name=fillarea        value=true>
							<param name=titleheight     value=25>
							<param name=rowheight       value=20>
							<param name=headlinecolor   value=#999999>
							<param name=linecolor       value=>
							<param name=fontname        value=����>
							<param name=fontsize        value=9>
							<param name=Editable        value=false>
							<Param Name=SortView        value=Left>
              <Param Name="ColSizing"     Value=false>
              <param name="ColSelect"     value=False>
							<param name="ViewSummary"	VALUE="1">
     					<param name="format"        value='
								<C>ID=APPMM Name="��"  align=center  width=60  HeadBgColor=#B9D4DC SumBgColor=#C3D0DB SumText="�հ�" </C>
								<C>ID=B11000 Name="�ǰ�����" width=130, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB   SumText=@sum </C>
								<G> ID=DFG HeadBgColor=#B9D4DC  Name="��뺸��"
									<C>ID=SODUK_SUM Name="�޿�"  width=130, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  SumText=@sum  </C>
									<C>ID=SANG_SUM Name="��"  width=130, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  SumText=@sum </C>
									<C>ID=GO_TOTAL Name="��"    width=130, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  SumText=@sum </C>
								</G>
								<C>ID=BO_TOTAL  Name="������"   width=140, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  SumText=@sum   </C>
								<C>ID=B12000   Name="���ο���"   width=130, HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum </C>
								'>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</TR>
			</TABLE>
			<fieldset id=ft_div1 style="width:876px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt1 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</TR>
</TABLE>
</div>

<div id=disp02 name=disp02 style="position:absolute;top:82px; left:2px; width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
		<table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
      <tr> 
        <td style="width:100%">
					<comment id="__NSID__"><object id="gcgd_grid_ec02az"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410px" width=875  >
						<param name=dataid value=gcds_grid_ec02az>
						<PARAM NAME="BorderStyle" VALUE="0">
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=titleheight     value=25>
						<param name=rowheight       value=20>
						<param name=headlinecolor   value=#999999>
						<param name=linecolor       value=>
						<param name=fontname        value=����>
						<param name=fontsize        value=9>
						<param name=Editable        value=False>
						<Param Name=SortView        value=Left>
						<Param Name="ColSizing"     Value=True>
						<param name="ViewSummary"	VALUE="1">
            <param name="ColSelect"     value=False>
     				<param name=format          value='
							<C>ID=APPMM,			Name="��",				width=140, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText="�հ�"	align=center	</C>
							<C>ID=EMCOUNT,		Name="�ο�",			width=100, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText=""			align=right		</C>
							<C>ID=STDAMT,			Name="ǥ�ؼҵ�",  width=150, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText=@sum		align=right		</C>
							<G>NAME="���ο���", HeadBgColor=#B9D4DC
								<C>ID=INSSUM,		Name="�����",		width=160, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText=@sum		align=right		</C>
								<C>ID=INSAMT2,	Name="ȸ��δ�",	width=150, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText=@sum		align=right		</C>
								<C>ID=INSAMT1,	Name="���κδ�",	width=150, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB	SumText=@sum		align=right		</C>
							</G>
              '>
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</TR>
		</TABLE>
		<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
			<font id=ft_cnt2 style="position:relative;top:4px;"></font>
		</fieldset>
		</td>
	</TR>
</TABLE>
</div>

<div id=disp03 name=disp03 style="position:absolute;top:82px; left:2px; width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
		<table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
      <tr> 
        <td style="width:100%">
					<comment id="__NSID__"><object id="gcgd_grid_ec03az"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410px" width=875>
	          <param name=dataid value=gcds_grid_ec03az>
						<PARAM NAME="BorderStyle"		VALUE="0">
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=titleheight     value=25>
						<param name=rowheight       value=20>
						<param name=headlinecolor   value=#999999>
						<param name=linecolor       value=>
						<param name=fontname        value=����>
						<param name=fontsize        value=9>
						<param name=Editable        value=False>
						<Param Name=SortView        value=Left>
            <Param Name="ColSizing"     Value=True>
						<param name="ViewSummary"		VALUE="1">
            <param name="ColSelect"     value=False>
     				<param name=format          value='
							<F>  ID={CurRow},		Name=No,				Width=30,		HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=center HeadAlign=Center	class=label17 SumText="�հ�" </F> 
								<C>ID=PAYGRDNM,		Name="����",    width=100,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=left </C>
								<C>ID=EMPNMK,			Name="����",    width=80,		HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=center </C>
								<C>ID=PRTNM,		Name="�ٹ���",    width=90,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=left </C>
								<C>ID=DEPTNM,		Name="�Ҽ�",      width=100,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=left </C>
								<C>ID=STRTDT,			Name="�Ի���",  width=68,		HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=LEFT Mask="XXXX/XX/XX" </C>
								<C>ID=STDAMT,			Name="ǥ�ؼҵ�",width=90,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=right SumText=@sum  </C>
								<C>ID=GRDCD,			Name="���",		width=30,		HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=right </C>
							<G>NAME="���ο���", HeadBgColor=#B9D4DC
								<C>ID=INSSUM,			Name="�����(9%)",			width=90, HeadBgColor=#B9D4DC  SumText=@sum SumBgColor=#C3D0DB  align=right </C>
								<C>ID=INSAMT2,		Name="ȸ��δ�(4.5%)",  width=90, HeadBgColor=#B9D4DC  SumText=@sum SumBgColor=#C3D0DB  align=right </C>
								<C>ID=INSAMT1,		Name="���κδ�(4.5%)",	width=90, HeadBgColor=#B9D4DC	SumText=@sum SumBgColor=#C3D0DB  align=right </C>
							</G> '>
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</TR>
		</TABLE>
		<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
			<font id=ft_cnt3 style="position:relative;top:4px;"></font>
		</fieldset>
		</td>
  </TR>
</TABLE>
</div>

<div id=disp04 name=disp04 style="position:absolute;top:82px; left:2px;width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
	  <table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
      <tr> 
        <td style="width:100%">
					<comment id="__NSID__"><object id="gcgd_grid_ec04az" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410px" width=875  >
	          <param name=dataid value=gcds_grid_ec04az>
		        <PARAM NAME="BorderStyle" VALUE="0">
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=titleheight     value=25>
						<param name=rowheight       value=20>
						<param name=headlinecolor   value=#999999>
						<param name=linecolor       value=>
						<param name=fontname        value=����>
						<param name=fontsize        value=9>
						<param name=Editable        value=False>
						<Param Name=SortView        value=Left>
						<Param Name="ColSizing"     Value=True>
						<param name="ColSelect"     value=False>
						<param name="ViewSummary"	VALUE="1">
     				<param name=format          value='
							<F> Name=NO ID={CurRow} HeadAlign=Center class=label17  HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  Width=25  align=center</F> 
								<C>ID=MEDSNO, Name="����ȣ",    width=100, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB SumText="�հ�"  align=center</C>
								<C>ID=EMPNMK, Name="����",			width=45, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB align=center</C>
								<C>ID=PRTNM,	Name="�ٹ���",    width=70,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=left </C>
								<C>ID=DEPTNM,	Name="�Ҽ�",      width=80,	HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  align=left </C>
								<C>ID=RESINO, Name="�ֹι�ȣ",  width=90, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB align=center</C>
							<G>NAME=$PRE_NAME, HeadBgColor=#B9D4DC
								<C>ID=GRDCD,  Name="���",			width=30, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  </C>
								<C>ID=STDAMT, Name="��������",  width=80, HeadBgColor=#B9D4DC  SumBgColor=#C3D0DB  SumText=@sum </C>
								<C>ID=INSAMT, Name="�����",		width=70, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  SumText=@sum </C>
							</G>
							<G>NAME=$CUR_NAME, HeadBgColor=#B9D4DC
								<C>ID=GRDCD2,  Name="���",  width=30, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB  </C>
								<C>ID=STDAMT2, Name="��������",  width=80, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB SumText=@sum </C>
								<C>ID=INSAMT2, Name="�����",  width=70, HeadBgColor=#B9D4DC SumBgColor=#C3D0DB SumText=@sum </C>
							</G>
								<C>ID=INSDIF, Name="������",  width=80,HeadBgColor=#B9D4DC SumBgColor=#C3D0DB SumText=@sum </C>
							'>
					 </object></comment><script>__ws__(__NSID__);</script>
					</td>
				</TR>
			</TABLE>
			<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
				<font id=ft_cnt4 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</TR>
</TABLE>
</div>

<div id=disp05 name=disp05 style="position:absolute;top:82px; left:2px;width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
	  <table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
      <tr> 
        <td style="width:100%">
					<comment id="__NSID__"><object id="gcgd_grid_ec05az"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410" width=875  >
	          <param name=dataid value=gcds_grid_ec05az>
		        <PARAM NAME="BorderStyle" VALUE="0">
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=titleheight     value=25>
						<param name=rowheight       value=20>
						<param name=headlinecolor   value=#999999>
						<param name=linecolor       value=>
						<param name=fontname        value=����>
						<param name=fontsize        value=9>
						<param name=Editable        value=False>
						<Param Name=SortView        value=Left>
						<Param Name="ColSizing"     Value=True>
						<param name="ViewSummary"	VALUE="1">
            <param name="ColSelect"     value=False>
     				<param name=format          value='
							<C>ID=DEPTNM,		Name="�ҼӸ�",  width=155,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" suppress=1 SumBgColor=#C3D0DB SumText="�հ�" SubSumText=""</C>
							<C>ID=EMPNO,		Name="���",    width=70,		HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" suppress=2 SumBgColor=#C3D0DB align=center </C>
							<C>ID=FAMNM,		Name="����",    width=90,		HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center</C>
							<C>ID=REFCDNM,	Name="����",    width=60,		HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB </C>						 
							<C>ID=SCHNM,		Name="�б���",  width=160,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB </C>
							<C>ID=SCHYEAR,	Name="�г�",		width=80,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB </C>
							<C>ID=APPAMT,		Name="��û�ݾ�",width=120,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB SumText=@sum </C>
							<C>ID=PAYAMT,		Name="���ޱݾ�",width=120,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB SumText=@sum </C>
							'>
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</TR>
		</TABLE>
		<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
			<font id=ft_cnt5 style="position:relative;top:4px;"></font>
		</fieldset>
	</td>
 </TR>
</TABLE>
</div>

<div id=disp06 name=disp06 style="position:absolute;top:82px; left:2px;width:876px; height:410px; visibility:hidden">
  <table style="border:solid; border-width:0px;width:876px"  cellpadding=0 cellspacing=0 border=0 >
    <TR>
  	  <td height="410" width=97%  valign="top">
	  <table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#708090">
      <tr> 
        <td style="width:100%">
					<comment id="__NSID__"><object id="gcgd_loan_6"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" height="410" width=875  >
	          <param name=dataid value=gcds_loan_6>
		        <PARAM NAME="BorderStyle" VALUE="0">
						<param name=indwidth        value=0>
						<param name=fillarea        value=true>
						<param name=titleheight     value=30>
						<param name=rowheight       value=20>
						<param name=headlinecolor   value=#999999>
						<param name=linecolor       value=>
						<param name=fontname        value=����>
						<param name=fontsize        value=9>
						<param name=Editable        value=False>
						<Param Name=SortView        value=Left>
						<Param Name="ColSizing"     Value=True>
						<param name="ViewSummary"	VALUE="1">
            <param name="ColSelect"     value=False>
     				<param name=format          value='
							<G>NAME="������ ��Ȳ", HeadBgColor=#B9D4DC
								<FC>ID=CURROW,		Name="��",        width=30,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center Value={CurRow}</FC>
								<FC>ID=REASON,		Name="�������",  width=80,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=left  SumText="�հ�"</FC>
								<FC>ID=DEPTNM,		Name="�Ҽ�",      width=80,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=left </FC>
								<FC>ID=PAYGRDNM,	Name="����",      width=60,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=left </FC>						 
								<FC>ID=EMPNO,		  Name="���",      width=50,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center </FC>
								<FC>ID=EMPNMK,	  Name="����",		  width=50,	HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=left </FC>
								<C>ID=APPDAY,		Name="������",    width=65,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center  mask ="XXXX/XX/XX"</C>
								<C>ID=APPAMT,		Name="�����",    width=80,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right  SumText=@sum </C>
								<C>ID=ENDDT,		Name="������",    width=65,	HeadBgColor=#B9D4DC SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center  mask ="XXXX/XX/XX"</C>
							</G>
							<G>NAME="���ݻ�ȯ����", HeadBgColor=#B9D4DC
								<C>ID=APLAMT,	  Name="��ȯ����",	 width=80,HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right  SumText=@sum</C>
								<C>ID=APPCNT,	  Name="��ȯ\\Ƚ��", width=30,HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=center </C>
								<C>ID=APLAMT_SUM,	Name="��ȯ����\\����",width=80,HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum </C>
							</G>
							<G>NAME="���ڻ�ȯ����", HeadBgColor=#B9D4DC
								<C>ID=UNDER_2000,	Name="2000����\\(2%)",		 width=60,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
								<C>ID=UP_2000,	  Name="2000����\\�ʰ�(3%)", width=60,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
								<C>ID=APLRAT,	    Name="�Ұ�",		           width=60,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
								<C>ID=APLRAT_SUM,	Name="��ȯ����\\����",		   width=60,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
							</G>
							<G>NAME="�޿�����", HeadBgColor=#B9D4DC
								<C>ID=APLAMT_APLRAT,	Name="����+����",		width=60,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
							</G>
							<C>ID=BALANCE,	Name="�����ܾ�",		width=80,		HeadBgColor=#B9D4DC	SUBBGCOLOR="#D1D4DC" SumBgColor=#C3D0DB align=right SumText=@sum</C>
							'>
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
			</TR>
		</TABLE>
		<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;">
			<font id=ft_cnt6 style="position:relative;top:4px;"></font>
		</fieldset>
	</td>
 </TR>
</TABLE>
</div>

<comment id="__NSID__"><OBJECT id=gcrp_print_6  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_rpt_head_6">
	<param name="DetailDataID"			VALUE="gcds_loan_6">   
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<param name="PrintMargine"      value="false">                   
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=894 ,top=5 ,right=1918 ,bottom=106 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
		<L> left=11 ,top=294 ,right=1884 ,bottom=294 </L>
		<T>id='ȸ��' ,left=1601 ,top=336 ,right=1675 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ȯ' ,left=1601 ,top=296 ,right=1675 ,bottom=336 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2000����' ,left=1873 ,top=296 ,right=2021 ,bottom=336 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='2000����' ,left=2021 ,top=296 ,right=2170 ,bottom=336 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ʰ�(3%)' ,left=2021 ,top=336 ,right=2170 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=32 ,top=296 ,right=93 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����' ,left=484 ,top=296 ,right=577 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�Ҽ�' ,left=288 ,top=296 ,right=487 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�������' ,left=93 ,top=296 ,right=291 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����' ,left=1675 ,top=336 ,right=1876 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ȯ����' ,left=1675 ,top=296 ,right=1876 ,bottom=336 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���' ,left=587 ,top=296 ,right=730 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ȯ����' ,left=1450 ,top=296 ,right=1603 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='������' ,left=1251 ,top=296 ,right=1450 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�����' ,left=1072 ,top=296 ,right=1270 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='������' ,left=884 ,top=296 ,right=1082 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����' ,left=720 ,top=296 ,right=889 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��ȯ����' ,left=2323 ,top=296 ,right=2471 ,bottom=336 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����' ,left=2323 ,top=336 ,right=2471 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='����+����' ,left=2477 ,top=296 ,right=2633 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1871 ,top=294 ,right=2170 ,bottom=294 ,penstyle=dot ,penwidth=0 ,pencolor=#000000 </L>
		<L> left=2172 ,top=294 ,right=2633 ,bottom=294 </L>
		<T>id='�Ұ�' ,left=2167 ,top=296 ,right=2323 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='MM', left=923, top=13, right=1900, bottom=98, face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<L> left=11 ,top=209 ,right=2818 ,bottom=209 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<T>id='�� �� �� �� Ȳ' ,left=34 ,top=217 ,right=1450 ,bottom=291 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���ݻ�ȯ����' ,left=1450 ,top=217 ,right=1873 ,bottom=291 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���ڻ�ȯ����' ,left=1873 ,top=217 ,right=2471 ,bottom=291 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�޿�����' ,left=2477 ,top=217 ,right=2633 ,bottom=291 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�����ܾ�' ,left=2635 ,top=220 ,right=2813 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='PRINTDT', left=2614, top=106, right=2818, bottom=153, align='right' ,mask='XXXX.XX.XX', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='Print Date:' ,left=2350 ,top=106 ,right=2611 ,bottom=153 ,align='right' ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=11 ,top=384 ,right=2818 ,bottom=384 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<T>id='(2%)' ,left=1873 ,top=336 ,right=2021 ,bottom=376 ,face='����' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=1873 ,top=206 ,right=1873 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=2471 ,top=206 ,right=2471 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=1450 ,top=206 ,right=1450 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=2633 ,top=209 ,right=2633 ,bottom=389 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<T>id='���� : ��' ,left=2614 ,top=159 ,right=2818 ,bottom=201 ,align='right' ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<L> left=291 ,top=294 ,right=291 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=95 ,top=294 ,right=95 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=482 ,top=294 ,right=482 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=585 ,top=294 ,right=585 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=728 ,top=294 ,right=728 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=884 ,top=294 ,right=884 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1069 ,top=294 ,right=1069 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1265 ,top=294 ,right=1265 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1598 ,top=294 ,right=1598 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1675 ,top=294 ,right=1675 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2021 ,top=294 ,right=2021 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2164 ,top=294 ,right=2164 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2318 ,top=294 ,right=2318 ,bottom=386 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=11 ,top=209 ,right=11 ,bottom=386 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<L> left=2818 ,top=209 ,right=2818 ,bottom=386 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	</B>
	<B>id=default ,left=0,top=0 ,right=2871 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
		<C>id='REASON', left=95, top=0, right=294, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTNM', left=294, top=0, right=492, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNO', left=585, top=0, right=728, bottom=66, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APPDAY', left=881, top=0, right=1080, bottom=66 ,mask='XXXX/XX/XX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='UP_2000', left=2021, top=0, right=2167, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APLRAT', left=2167, top=0, right=2320, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APLRAT_SUM', left=2323, top=0, right=2471, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='BALANCE', left=2635, top=0, right=2813, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='UNDER_2000', left=1873, top=0, right=2021, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APPCNT', left=1601, top=0, right=1675, bottom=66, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APLAMT', left=1450, top=0, right=1601, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENDDT', left=1251, top=0, right=1450, bottom=66 ,mask='XXXX/XX/XX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APPAMT', left=1072, top=0, right=1267, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='APLAMT_APLRAT', left=2471, top=0, right=2630, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=733, top=0, right=884, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PAYGRDNM', left=484, top=0, right=585, bottom=66, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=11 ,top=0 ,right=11 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<L> left=11 ,top=69 ,right=2820 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=1450 ,top=0 ,right=1450 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<C>id='APLAMT_SUM', left=1675, top=0, right=1873, bottom=66, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=2471 ,top=0 ,right=2471 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=2633 ,top=0 ,right=2633 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=1873 ,top=0 ,right=1873 ,bottom=69 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<C>id='{CURROW}', left=34, top=0, right=95, bottom=66, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=95 ,top=3 ,right=95 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=291 ,top=3 ,right=291 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=482 ,top=3 ,right=482 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=728 ,top=3 ,right=728 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=585 ,top=3 ,right=585 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=881 ,top=3 ,right=881 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1598 ,top=3 ,right=1598 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1675 ,top=3 ,right=1675 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2021 ,top=3 ,right=2021 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2164 ,top=3 ,right=2164 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2318 ,top=3 ,right=2318 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1265 ,top=3 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1069 ,top=3 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2818 ,top=0 ,right=2818 ,bottom=69 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
	</B>
	<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=69 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=11 ,top=3 ,right=2818 ,bottom=66 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
		<C>id='{Sum(APPAMT)} ', left=1072, top=3, right=1267, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(APLAMT_APLRAT)}', left=2471, top=3, right=2630, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(BALANCE)}', left=2641, top=3, right=2818, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(APLRAT_SUM)}', left=2323, top=3, right=2477, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(APLRAT)}', left=2167, top=3, right=2320, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<L> left=11 ,top=0 ,right=11 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<L> left=1871 ,top=0 ,right=1871 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=1450 ,top=0 ,right=1450 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=2471 ,top=0 ,right=2471 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=2633 ,top=0 ,right=2633 ,bottom=66 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<L> left=1603 ,top=0 ,right=1603 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1672 ,top=0 ,right=1672 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1265 ,top=0 ,right=1265 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=1069 ,top=0 ,right=1069 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2021 ,top=0 ,right=2021 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2164 ,top=0 ,right=2164 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2318 ,top=0 ,right=2318 ,bottom=66 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
		<L> left=2818 ,top=0 ,right=2818 ,bottom=66 ,penstyle=solid ,penwidth=4 ,pencolor=#000000 </L>
		<C>id='{SUM(UP_2000)}', left=2021, top=3, right=2167, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(UNDER_2000)}', left=1873, top=3, right=2021, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='{SUM(APLAMT_SUM)}', left=1675, top=3, right=1873, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<C>id='CNT', left=32, top=0, right=1045, bottom=66, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		<L> left=11 ,top=66 ,right=2820 ,bottom=66 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
		<C>id='{SUM(APLAMT)}', left=1450, top=3, right=1601, bottom=69, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	</B>
	<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=8 ,top=0 ,right=2818 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
		<I>id='../../Common/img/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
	</B>
	">
	</OBJECT></comment><script>__ws__(__NSID__);</script>



<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</BODY>
</HTML>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	