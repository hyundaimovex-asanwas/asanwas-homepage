<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	�޿�/�Ű��ڷ��ۼ�
+ ���α׷� ID	: P030006.HTML
+ �� �� �� ��	: ��ȸ|����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�Ű��ڷ��ۼ�</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>


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
var gs_date = gcurdate.substr(0,4);// + gcurdate.substr(5,2); + gcurdate.substr(8,2);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_curdt.text = gcurdate.substring(0,4);	//�ͼӳ⵵

}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	var str1 = gcem_curdt.text;		//�ͼӳ⵵
	
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030006_s1?v_str1="+str1;
	gcds_data01.Reset();

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
	if (gcds_data01.countrow<1) {
		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	} else {
		gcgd_data02.ExportFileEx('�Ű��ڷ��ۼ�', true, 1, false);
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if(gcds_data01.countrow <=0) alert("��ȸ�� ����Ÿ�� �����ϴ�.");
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


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/p030006_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
			<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()"></nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӳ⵵&nbsp;&nbsp;</nobr></td>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
						<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:35px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Alignment			value=0>
							<param name=Border	      value=True>
							<param name=ClipMode			value=true>
							<param name=Numeric	      value=false>
							<param name=Format	      value="YYYY">
							<param name=MaxLength     value=4>
							<param name=PromptChar	  value="_">
							<param name=IsComma	      value=false>
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>
				</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2">
			<comment id="__NSID__"><OBJECT  id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:874px;HEIGHT:422px;border:1 solid #777777;">
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="Editable"		VALUE="false">
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="ColSelect"		value="false">
				<param name="ColSizing"		value="true">
				<!-- <param name=AutoResizing	value=true>  -->
				<PARAM NAME="Format"			VALUE="  
					<C> Name='���ڵ�'				ID=RECGUB   HeadAlign=Center HeadBgColor=#B9D4DC	Width=40		align=CENTER	Edit=NONE			</C> 
					<C> Name='�ڵ�'					ID=RECCOD  	HeadAlign=Center HeadBgColor=#B9D4DC	Width=25		align=CENTER	Edit=NONE			</C> 
					<C> Name='����'					ID=RECSEQ		HeadAlign=Center HeadBgColor=#B9D4DC	Width=25		align=CENTER	</C> 
					<C> Name='�� �� �� ��'	ID=DISKET		HeadAlign=Center HeadBgColor=#B9D4DC	Width=4063	align=LEFT		</C>
				">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
				<comment id="__NSID__"><OBJECT  id=gcgd_data02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:874px;HEIGHT:422px;border:1 solid #777777;display:none">
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="Editable"		VALUE="false">
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="ColSelect"		value="false">
				<PARAM NAME="Format"			VALUE="  
					<C> Name=''	
							ID=DISKET		HeadAlign=Center HeadBgColor=#B9D4DC	Width=1843	align=LEFT		
					</C>
				">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="POSiTION:ABSOLUTE;left:0px;TOP:506px;width:876;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;"><font id=ft_cnt1 style="position:relative;left:0px;TOP:4px;"></font>
			</fieldset>
    </td>
  </tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	