<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �����ڵ� ��	
+ ���α׷� ID	:  Commdtil_popup_ifrm.html
+ �� �� �� ��	:  �����׸�  �˾�â
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2005.12.07
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

<title>�����׸�</title>

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
var g_cdcodenam="";
var g_gbcd="";
var g_cmtype="";
var g_gubun="";
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	var strParam = new Array();
	strParam=window.dialogArguments;
  	g_cmtype=strParam[0];
	txt_cdcodenm.value=strParam[1];

	if(g_cmtype=="0003"){ //����μ�
		g_gbcd = strParam[2];
	}else if(g_cmtype=="0030"){//�����ڵ�
    	g_gbcd = strParam[2];

  	}else if(g_cmtype=="0997"||g_cmtype=="0023"||g_cmtype=="0022"){//���޺��  2010.03.19 jys : ��ǥ��ϰ� ��ȸ�� �ٸ��� ��ȸ��. ���¹�ȣ 0023 �߰� (2016.06.10)
		g_gubun = strParam[2];
	
	    //alert("g_gubun::"+g_gubun);
	}else{
		g_gbcd="";
	}
	ln_Query();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  if(g_cmtype =="0030"||g_cmtype =="0001"){ //�����ڵ� �Ǵ� �����ȣ
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_cost_s1?v_str1="+g_cmtype
	                                                                                 +"&v_str2="
																					 +"&v_str3="+txt_cdcodenm.value
																					 +"&v_str4=C"
																					 +"&v_str5="
																					 +"&v_str6=";  
  
     //prompt("",gcds_code01.DataID);
	  gcds_code01.Reset();
 	}else{

		if(g_gubun=="A"){
			gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s3f?v_str1="+g_cmtype
																					+"&v_str2="+txt_cdcodenm.value
																					+"&v_str3=&v_str4="+g_gbcd; 
			//prompt("A",gcds_code01.DataID);
			gcds_code01.Reset();

		}else{
			gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s2f?v_str1="+g_cmtype
																					+"&v_str2="+txt_cdcodenm.value
																					+"&v_str3=&v_str4="+g_gbcd; 
			//prompt("B",gcds_code01.DataID);
			gcds_code01.Reset();
		}
	}
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
		
		if(row<1){
			alert("���� ���õ��� �ʾҽ��ϴ�.");
			return false;
		}
		
		window.returnValue = gcds_code01.namevalue(row,"CDCODE")+";" 
		                   + gcds_code01.namevalue(row,"CDNAM")+";" 
						   + gcds_code01.namevalue(row,"GBCD")+ ";" 
	                   	   + gcds_code01.namevalue(row,"CDREMARK");
		window.close();
	} else {
		window.close();
	}
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:382px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee">�����׸�</td>
		<td width="255px"><input type="text" class="txt11" id="txt_cdcodenm" style="position:relative;left:4px;width:240px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="�ڵ� �� �ڵ���� �˻��մϴ�" style="cursor:hand;" onclick="ln_Query()"></td>
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
					<C>ID=CDCODE,		Name=�ڵ�,	width=65,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=CDNAM,		Name=��Ī,	width=295,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true</C>
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
