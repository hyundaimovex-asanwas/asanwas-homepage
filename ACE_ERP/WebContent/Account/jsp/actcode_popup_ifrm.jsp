<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �����ڵ� �� �����׸�����(����)	
+ ���α׷� ID	:  Actcode_popup_ifrm.html
+ �� �� �� ��	:  �����ڵ� �˾�â
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2005.12.02
-----------------------------------------------------------------------------
+ �� �� �� �� :	   
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
<title>����������ȸ</title>

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
var g_fdcode="";
get_cookdata();
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam=window.dialogArguments;
	txt_atcode_nam.value=strParam[0];  //�����ڵ�
	g_fdcode=strParam[1];              //�����ڵ�
	ln_Query();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	gcds_code01.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>actcode_s1f?v_str1="+txt_atcode_nam.value+"&v_str2='Y'&v_str3="+g_fdcode;
	//prompt("",gcds_code01.DataID);                                                   
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
	alert("test");
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
		var row = gcds_code01.rowposition;
		//alert("cnt::"+gcds_code01.namevalue(row,"CNT"));
		window.returnValue = gcds_code01.namevalue(row,"ATCODE") + ";"   //0 
	                   	 + gcds_code01.namevalue(row,"ATKORNAM")+ ";" 
                       + gcds_code01.namevalue(row,"CNT")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE1")+ ";"  //�μ�
											 + gcds_code01.namevalue(row,"CDNAM1")+ ";"   
											 + gcds_code01.namevalue(row,"CDCODE2")+ ";"  //�ŷ�ó
											 + gcds_code01.namevalue(row,"CDNAM2")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE3")+ ";"  //7
											 + gcds_code01.namevalue(row,"CDNAM3")+ ";"   //8
											 + gcds_code01.namevalue(row,"CDCODE4")+ ";"  //9
											 + gcds_code01.namevalue(row,"CDNAM4")+ ";"   //10 
											 + gcds_code01.namevalue(row,"CDCODE5")+ ";" 
											 + gcds_code01.namevalue(row,"CDNAM5")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE6")+ ";" 
											 + gcds_code01.namevalue(row,"CDNAM6")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE7")+ ";" 
											 + gcds_code01.namevalue(row,"CDNAM7")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE8")+ ";" 
											 + gcds_code01.namevalue(row,"CDNAM8")+ ";" 
											 + gcds_code01.namevalue(row,"CDCODE9")+ ";" 
											 + gcds_code01.namevalue(row,"CDNAM9")+ ";"   //20 

												+ gcds_code01.namevalue(row,"TYPE1")+ ";"   
												+ gcds_code01.namevalue(row,"TYPE2")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE3")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE4")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE5")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE6")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE7")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE8")+ ";" 
												+ gcds_code01.namevalue(row,"TYPE9")+ ";" 

												+ gcds_code01.namevalue(row,"ARBALDIV1")+ ";"  //30  
												+ gcds_code01.namevalue(row,"ARBALDIV2")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV3")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV4")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV5")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV6")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV7")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV8")+ ";" 
												+ gcds_code01.namevalue(row,"ARBALDIV9")+ ";" 
											  
												+ gcds_code01.namevalue(row,"ATDEBTYN")+ ";"  //39 
												+ gcds_code01.namevalue(row,"ATDECR")+";"     //40   
												+ gcds_code01.namevalue(row,"BGTCMTYPE")+";" 
												+ gcds_code01.namevalue(row,"BGTCNT")+";" 
												+ gcds_code01.namevalue(row,"FUNDDIV")+";" 
												+ gcds_code01.namevalue(row,"BANJAEREF")+";" 
												+ gcds_code01.namevalue(row,"ATCURTYPE");
											
		window.close();
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

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
	ln_Close();
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close();
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:382px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">��������</td>
		<td width="255px"><input type="text" class="txt11" id="txt_atcode_nam" style="position:relative;left:4px;width:240px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="30"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand; " onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:380;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=ATCODE,		 Name=�ڵ�,   	  width=65,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=ATKORNAM,	 Name=���������, width=295,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:382;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 