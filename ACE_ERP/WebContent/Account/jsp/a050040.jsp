<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �����帧ǥ
+ ���α׷� ID	: A050040
+ �� �� �� ��	: ��ȸ|���
+ �� �� �� ��	: ������
+ �� �� �� ��	: a050040_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head
<jsp:include page="/Account/common/include/head.jsp"/>>
<title></title>

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

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date1 = gcurdate.substring(0,4) + "01";
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
//var gfdcode //����� ��������

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_Before();	//����ȸ

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query1(){

	var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
	var str2 = gcem_staxdatfr.text;       //��꼭�Ⱓ �� ��
	var str3 = gcem_staxdatto.text;			  //��꼭�Ⱓ �� ��

	gcds_data1.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050040_s1"
									  + "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3;
	gcds_data1.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save() {
  
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
function ln_Print1(){

	//var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
	//var str2 = gcem_staxdatto.text;			//��꼭�Ⱓ �� ��

	//gcds_print1.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1"+"?v_str1="+str1+"&v_str2="+str2;
	//gcds_print1.Reset();

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_RptFormat1() {

	var ls_for = "";

	var strto = gcem_staxdatto.text;
	var tyyyy = strto.substring(0,4);
	var tmm   = strto.substring(4,6);
	var fd = gcds_sfdcode.NameValue(gcds_sfdcode.rowposition,"FDNAME");

	gcrp_print1.format = ls_for + gcrp_print1.format;

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 

	//gclx_sfdcode.BindColVal = "01";					//�����ڵ�
	gcem_staxdatfr.text    = gs_date1;        //��꼭�Ⱓ �� ��
	gcem_staxdatto.text		 = gs_date2;				//��꼭�Ⱓ �� ��

	var str1 = gcem_staxdatfr.text;
	gcgd_data1.ColumnProp('GUBUN1','NAME') = "�� " + str1.substring(0,4) + " (��)��";
	gcgd_data1.ColumnProp('GUBUN2','NAME') = "�� " + Number(str1.substring(0,4)-1) + " (��)��";

	gcds_sfdcode.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //�����ڵ�

}

/******************************************************************************
	Description : �׸��� ���̱�
******************************************************************************/
function ln_visible_hidden(Obj){
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ� -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">

	//txt_fdcode.value = gclx_sfdcode.BindColVal;
	
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = row + " ��";
	if (row<1)
		alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	//if (row<1) {
	//	alert("����Ͻ� ������ �����ϴ�.");
	//}else{
		ln_RptFormat1();
		gcrp_print1.preview();
	//}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0; //�����ڵ�
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_sfdcode.BindColVal = gfdcode;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
		<td background="../../Common/img/com_t_bg.gif"><img src="../img/a050040_head.gif"></td>
    <td width="879" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" HEIGHT=47>
		  <img name="btn_print" src="../../Common/img/btn/com_b_print.gif"	style="cursor:hand"	onclick="ln_Print1()"> 
		  <img name="btn_query" src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand" onclick="ln_Query1()">&nbsp;
	  </td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�����ڵ�&nbsp;</nobr></td>
					<td width="150px;" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
							<param name=ListExprFormat		value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;ȸ����&nbsp;</nobr></td>
					<td width="150px"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">
						&nbsp;</nobr>
					</td>
					<td width=100%>&nbsp;</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2">
		<DIV ID="create1" STYLE="display:block;">
			<table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:875" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:420;width:875" >
              <PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="false">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="false">
							<PARAM NAME="ViewSummary"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="Format"		VALUE=" 
	<C>ID=PRTNAM, Name='��������' ,width=335, HeadBgColor=#B9D4DC,HeadAlign=center, align=left</C>
	<G>ID=GUBUN1, Name='', HeadBgColor=#B9D4DC,HeadAlign=center
	<C>ID=XLTTOT,	Name='�ݾ�',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
	<C>ID=XRTTOT,	Name='�ݾ�' ,width=130,HeadBgColor=#B9D4DC,HeadAlign=center,	align=right</C>
	</G>
	<G>ID=GUBUN2, Name='', HeadBgColor=#B9D4DC,HeadAlign=center
	<C>ID=YLTTOT,	Name='�ݾ�' ,width=130,HeadBgColor=#B9D4DC,HeadAlign=center,	align=right</C>
	<C>ID=YRTTOT,	Name='�ݾ�',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=right</C>
	</G>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font style="position:relative;top:4px;">��ȸ�Ǽ� : </font><font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
		</div>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �û�ǥ
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print1">
	<param NAME="DetailDataID"			VALUE="gcds_print1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="NullRecordFlag"		VALUE="true">
	<PARAM NAME="Format" VALUE="

">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 