
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �μ��ڵ�	
+ ���α׷� ID	:  Hcdept_poopup.html
+ �� �� �� ��	:  �ŷ�ó�ڵ� �˾�â
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ������
+ ��   ��  �� :	 �̼���
+ �� �� �� �� :  2006/04/04
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�μ��ڵ���ȸ</title>

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
var parentGubun="";
var gs_strGubun =""; //�����׸� �����ڵ� - 0002 (�μ�)
var gs_Gubun="";//�����μ�(A) �����μ�(B) ����
var gs_Divcd="";//����
var gs_Fdcode="";//����
var gs_yyyymm=""; //���
get_cookdata();
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
  
	var strParam = new Array();
	strParam=window.dialogArguments;

	if(strParam.length==0){

	}else if(strParam.length==1){
		gs_strGubun = strParam[0];
		ln_Query();
	}else if(strParam.length==2) {
    gs_strGubun = strParam[0];
		txt_deptnm.value=strParam[1];
    ln_Query();
	}else if(strParam.length==4) {
    gs_strGubun = strParam[0];
		txt_deptnm.value=strParam[1];
		gs_Gubun = strParam[2];
		gs_Divcd = strParam[3];
    ln_Query();
	}else if(strParam.length==5) {
    gs_strGubun = strParam[0];
		txt_deptnm.value=strParam[1];
		gs_Gubun = strParam[2];
		gs_Divcd = strParam[3];
		gs_Fdcode = strParam[4];
    ln_Query();
	}else if(strParam.length==6) {
    gs_strGubun = strParam[0];
		txt_deptnm.value=strParam[1];
		gs_Gubun = strParam[2];
		gs_Divcd = strParam[3];
		gs_Fdcode = strParam[4];
		gs_yyyymm = strParam[5];
    ln_Query();
  }
	/*
	//��������
	gcds_comcode01.DataID =  g_servlet+"/Account.hcdept_s1?v_str1=";
	//prompt("",gcds_comcode01.DataID);
	gcds_comcode01.Reset();*/
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_code01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s1?v_str1="+txt_deptcd.value+"&v_str2="+txt_deptnm.value+"&v_str3="
	                   +gs_Gubun+"&v_str4="+gs_Divcd+"&v_str5="+gs_Fdcode+"&v_str6="+gs_yyyymm;
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

}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {

		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"DEPTCD")  + ";"   
	                   	 + gcds_code01.namevalue(row,"DEPTNM")  + ";"
											 + gcds_code01.namevalue(row,"DEPTNMK") + ";"
											 + gcds_code01.namevalue(row,"DEPTCD2") + ";"
											 + gcds_code01.namevalue(row,"BGTDEPT") + ";"
											 + gcds_code01.namevalue(row,"BGTDETPNM") + ";"
											 + gcds_code01.namevalue(row,"BGTDIVCD") + ";"
											 + gcds_code01.namevalue(row,"BGTDIVNM");
											 
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

<!-- <comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>  -->

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	gcds_code01.insertrow(1);
	gcds_code01.namevalue(1,"DEPTCD") = "";
	gcds_code01.namevalue(1,"DEPTNM") = "��ü";
	gcds_code01.index=0;
</script> -->

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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
	<tr>
    <td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">�μ���</td>
		<td width="110px"><input type="text" class="txt11" id="txt_deptnm" style="position:relative;left:5px;width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="30"></td>

		<td class="tab16" width="70px;" bgcolor="#eeeeee" align="center">�μ��ڵ�</td>
		<td width="60px"><input type="text" class="txt11" id="txt_deptcd" style="position:relative;left:5px;width:50px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="7"></td>
	
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="�μ��ڵ带 �˻��մϴ�" style="position:relative;left:116px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=DEPTCD,		 Name=�μ��ڵ�,   width=140,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true</C>
					<C>ID=DEPTNM,		 Name=�μ���,			width=320,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort=true</C>
					<C>ID=DEPTNMK,	 Name=�μ���1,    width=50,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true show = false </C>
					<C>ID=DEPTCD2,	 Name=�μ��ڵ�2,  width=50,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort=true show = false </C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:478;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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