<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ������� - �Ϲݰ����� ��Ȳ2 - �׸��� �˾�
+ ���α׷� ID	:  A080009_popup
+ �� �� �� ��	:  �Ϲݰ����� ��Ȳ �˾�2
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2014.03.10
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ϲݰ�������Ȳ �˾�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">


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

var xsatcode ="";

/******************************************************************************
	Description : ������ �ε�
	              ��ǥ�� ������ ���� ���� üũ�ؼ� �����ϸ� ����
								�������� ������ �ڱ� üũ�ؼ� �ڱ����� �ϸ� �ڱ�
******************************************************************************/
function ln_Start(){
	var strParam=window.dialogArguments;

	gcem_fdcode.text   = strParam[0];
	gcem_fdcodenm.text = strParam[1];
	gcem_frymd.text    = strParam[2];
	gcem_toymd.text    = strParam[3];
	gcem_atcode.text   = strParam[4];
	gcem_atcodenm.text = strParam[5];
	xsatcode = strParam[6];

	ln_Before();
	ln_Query();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Before(){
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s2?v_str1=0003"
		                                                                  + "&v_str2="+gcem_frymd.text.substring(0,4); 
	//prompt('',gcds_code02.DataID);
	gcds_code02.Reset();
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Query(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080009_popup_s1?v_str1="+gcem_fdcode.text
                                                                               + "&v_str2="+gcem_frymd.text		
								  		                                       + "&v_str3="+gcem_toymd.text		
										                                       + "&v_str4="+gcem_atcode.text	
											                                   + "&v_str5="+gclx_gubun.bindcolval
											                                   + "&v_str6="+xsatcode;
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
	gcgd_disp01.GridToExcel("�Ϲݰ�������Ȳ","",2);
}

/******************************************************************************
	Description : ��ǥ��ȸ
******************************************************************************/
function ln_Popup(sfdcode,sfsdat,sfsnbr){
	
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = sfdcode;
	arrParam[1] = sfsdat;
	arrParam[2] = sfsnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:610px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  <param name= SubsumExpr	value="ACTYYMM">
</object>
</comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<param name=SortExpr   value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	
</script>
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + gcds_code01.RealCount(0,gcds_code01.countrow) + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>
<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  
	var sfdcode		= gcds_code01.namevalue(gcds_code01.rowposition,"FDCODE");
    var sfsdat  	= gcds_code01.namevalue(gcds_code01.rowposition,"FSDAT");
	var sfsnbr    = gcds_code01.namevalue(gcds_code01.rowposition,"FSNBR");

	ln_Popup(sfdcode,sfsdat,sfsnbr);	
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:795px">
	<tr>
		<td  width="798" align="right" style="padding-top:4px;"> 
 			<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:795px;border:1 solid #708090">
	<tr>
		<td class="tab19" width="100px;" bgcolor="#eeeeee" align=center>����</td>
		<td class="tab19" width="120px"><nobr>
			<comment id="__NSID__"><object  id=gcem_fdcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
			style="position:relative;left:2px;top:3px; width:20px; height:20px;" class="txtbox">
			<param name=Alignment	    value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="##">
			<param name=PromptChar	  value="_">
			<param name=ReadOnlyBackColor  value="#ccffcc">
			<param name=ReadOnly           value="true">
			</object></comment><script>__ws__(__NSID__);</script>&nbsp;
			<comment id="__NSID__"><object  id=gcem_fdcodenm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
				style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
				<param name=Alignment	    value=0>
				<param name=Border	      value=true>
				<param name=PromptChar	  value="_">
				<param name=ReadOnlyBackColor  value="#ccffcc">
				<param name=ReadOnly           value="true">
				<param name=GeneralEdit   value="true">
			</object></comment><script>__ws__(__NSID__);</script> 
			</nobr>
		</td>

		<td class="tab19" width="100px;" bgcolor="#eeeeee" align=center>�Ⱓ</td>
		<td class="tab22" width="470px;" ><nobr>
			<comment id="__NSID__"><object  id=gcem_frymd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
			style="position:relative;left:2px;top:3px; width:80px; height:20px;" >
			<param name=Alignment	    value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			<param name=ReadOnlyBackColor  value="#ccffcc">
			<param name=ReadOnly           value="true">
			</object></comment><script>__ws__(__NSID__);</script>&nbsp;~&nbsp;
			<comment id="__NSID__"><object  id=gcem_toymd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
				style="position:relative;left:-3px;top:3px; width:80px; height:20px;" >
				<param name=Alignment	    value=0>
				<param name=Border	      value=true>
				<param name=Format	      value="YYYY/MM/DD">
				<param name=PromptChar	  value="_">
				<param name=ReadOnlyBackColor  value="#ccffcc">
				<param name=ReadOnly           value="true">
			</object></comment><script>__ws__(__NSID__);</script> 
			</nobr>
		</td>
	</tr>
	<tr>
    <td class="tab19" width="80px;" height="25px;" bgcolor="#eeeeee" align=center>����</td>
		<td class="tab19" >
			<comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:2px;top:2px;width:90px;">
				<param name=ComboDataID			value="gcds_code02">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort				value=false>
				<param name=ListExprFormat	    value="CDNAM^0^90">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td class="tab19" width="100px;" bgcolor="#eeeeee" align=center>����</td>
		<td class="tab22"  ><nobr>
			<comment id="__NSID__"><object  id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
			style="position:relative;left:2px;top:3px; width:80px; height:20px;">
			<param name=Alignment	    value=0>
			<param name=Border	      value=true>
			<param name=ReadOnlyBackColor  value="#ccffcc">
			<param name=ReadOnly           value="true">
			<param name=GeneralEdit   value="true">
			</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;&nbsp;
			<comment id="__NSID__"><object  id=gcem_atcodenm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
				style="position:relative;left:-3px;top:3px; width:263px; height:20px;">
				<param name=Alignment	    value=0>
				<param name=Border	      value=true>
				<param name=PromptChar	  value="_">
				<param name=ReadOnlyBackColor  value="#ccffcc">
				<param name=ReadOnly           value="true">
				<param name=GeneralEdit   value="true">
			</object></comment><script>__ws__(__NSID__);</script> 
			</nobr>
		</td>
	</tr>
  <tr><td height="2px" colspan =4></td></tr>
	<tr>
				<td ALIGN=LEFT VALIGN=TOP colspan=4>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:0px;width:798px; height:300px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_code01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
                            <param name="Editable"    value="false">
							<param name=ColSizing     value="true">
							<param name=ViewSummary   value="1">
							<PARAM NAME="Format"			VALUE="  
							<C> Name='ȸ������'	   ID=ACTDAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center sort=true SumBgColor=#C3D0DB mask='XXXX/XX/XX' </C> 
							<C> Name='��ǥ��ȣ'	   ID=SSDAT     HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center sort=true SumBgColor=#C3D0DB </C> 
							<C> Name='��ǥ��ȣ'	   ID=SSNBR     HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center sort=true SumBgColor=#C3D0DB </C> 
							<C> Name='����'	       ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=300	align=left   sort=true SumBgColor=#C3D0DB sumtext='��  ��'</C> 
							<C> Name='�ŷ�ó'	     ID=VEND_NM   HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left   sort=true SumBgColor=#C3D0DB SubSumText='��  ��' SumTextAlign=center </C> 
							<C> Name='�ݾ�'	       ID=DEAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  sort=true SumBgColor=#C3D0DB sumtext=@sum </C> 

								">
					</object></comment><script>__ws__(__NSID__);</script> 
					
					<fieldset style="position:relative;left:0px;width:800px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
					</fieldset>
		</td> 
	</tr> 

</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 