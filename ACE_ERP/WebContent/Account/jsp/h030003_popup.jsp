<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: H030003_POPUP.HTML
+ �� �� �� ��	: ��ȸ
+ �� �� �� ��	: 
+ �� �� �� ��	: h030003_s2
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����ȸ</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
var parentGubun="";
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	if(window.dialogArguments[0]=="H050009"||window.dialogArguments[0]=="EMPNO"){
	   parentGubun ="";
	}else if(window.dialogArguments[0] != undefined && window.dialogArguments[0] != "H030003" && window.dialogArguments[0] != "H050005"&& window.dialogArguments[0] != "H050008") { 
	   parentGubun="P040001";
	}else if(window.dialogArguments[0] == "H030003") {
		parentGubun="H030003";
	}else if(window.dialogArguments[0] == "H050008") {
		parentGubun="H050008";
	}else if(window.dialogArguments[0] == "H050005") {
		parentGubun="H050005";
	}
	//alert("window.dialogArguments[0]::"+window.dialogArguments[0]);
	//alert("parentGubun::"+parentGubun);
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(e){
	if(parentGubun=="") {	
		gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s2?"
										 + "v_str1=" + txt_nm.value;
	}	else if(parentGubun=="P040001") {	//�߰���������ȸ
		gcds_data.DataID = "/services/servlet/Payroll.p040001_pop_s1?"
									   + "v_str1=" + txt_nm.value;
  } else if(parentGubun == "H030003") {	//�����������
		gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s2?"
										 + "v_str1=" + txt_nm.value
										 + "&v_str2=" + "T";
  } else if(parentGubun == "H050008") {	//�߱�Ư�� �����.
	  if(window.dialogArguments[1]==""||window.dialogArguments[1]==undefined ){
			gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s5?"  //�߱�Ư�� ��ü��
											 + "v_str1=" + txt_nm.value;
		}else{
			gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s6?"  //�߱�Ư�� �μ� �����ڿ�
											 + "v_str1="+txt_nm.value
											 + "&v_str2="
											 + "&v_str3="+window.dialogArguments[1];//���
		}
	}else if(parentGubun == "H050005"){ //����
		if(window.dialogArguments[1]==""||window.dialogArguments[1]==undefined ){
			gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s7?"  //���� ��ü��
											 + "v_str1=" + txt_nm.value;
		}else{
			gcds_data.DataID ="<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s8?"  //���� �μ� �����ڿ�
											 + "v_str1="+txt_nm.value
											 + "&v_str2="
											 + "&v_str3="+window.dialogArguments[1];//���
		}
	}
	gcds_data.Reset();
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
******************************************************************************/
function ln_Close(e){
	if (e=="A") {
		var row = gcds_data.rowposition;
		if(parentGubun=="") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM") + ";"
												 + gcds_data.namevalue(row,"DEPTCD") + ";"
												 + gcds_data.namevalue(row,"PAYGRD") + ";"
												 + gcds_data.namevalue(row,"MEMO");
												 + "v_str1=" + txt_nm.value;
		}	else if(parentGubun=="P040001") { //�߰���������ȸ
			window.returnValue = gcds_data.namevalue(row,"EMPNO")   + ";" + gcds_data.namevalue(row,"EMPNMK")  + ";"
												 + gcds_data.namevalue(row,"DEPTCD")  + ";" + gcds_data.namevalue(row,"DEPTNM")  + ";"
												 + gcds_data.namevalue(row,"PAYSEQ")  + ";" + gcds_data.namevalue(row,"PAYSEQNM")+ ";" 
												 + gcds_data.namevalue(row,"STRTDT")  + ";" + gcds_data.namevalue(row,"ENDDT")   + ";"
												 + gcds_data.namevalue(row,"GRSTRTDT")+ ";" + gcds_data.namevalue(row,"RESINO")  + ";"
												 + gcds_data.namevalue(row,"DUYEAR")  + ";" + gcds_data.namevalue(row,"PAYGRD")  + ";"
												 + gcds_data.namevalue(row,"PAYGNM")  + ";"
												 + gcds_data.namevalue(row,"PAYDIV")  + ";";
		} else if (parentGubun=="H030003") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM");
												 + "v_str1=" + txt_nm.value;
		} if(parentGubun=="H050008"||parentGubun=="H050005") {
			window.returnValue = gcds_data.namevalue(row,"EMPNMK") + ";" 
												 + gcds_data.namevalue(row,"EMPNO")  + ";" 
												 + gcds_data.namevalue(row,"DEPTNM") + ";"
												 + gcds_data.namevalue(row,"PAYGNM") + ";"
												 + gcds_data.namevalue(row,"DEPTCD") + ";"
												 + gcds_data.namevalue(row,"PAYGRD") + ";"
												 + gcds_data.namevalue(row,"MEMO");
												 + "v_str1=" + txt_nm.value;
		}
		window.close();
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
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
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:360px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="80px;" bgcolor="#eeeeee">����</td>
		<td width="110px"><input type="text" class="txt11" id="txt_nm" style="width:100px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:2px;top:1px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:358;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_data">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"     value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=EMPNO,		Name=���,		width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=EMPNMK,		Name=����,		width=80,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=DEPTNM,		Name=�ҼӸ�,	width=106,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=PAYGNM,		Name=������,	width=86,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:360;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
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

<!-- <iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:25px; top:130px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 