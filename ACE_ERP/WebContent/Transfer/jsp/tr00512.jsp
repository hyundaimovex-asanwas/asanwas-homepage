<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	: ��������
+ ���α׷� ID	: TR00512
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ : tr00501_s1, tr00501_s2, tr00501_s3, tr00501_t1, tr00501_t2
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML ����-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>


<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

		get_cookdata();
		
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			Start();//����ȸ

			window.status="�Ϸ�";

		}	

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	ln_Query();

	CAR_TYPE.readonly =true ;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_hcl.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_s1?NOH=Y&gstr1="+ txt_hobby1.value; 
	gcds_hcl.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_hcl.addrow();
}
 
/******************************************************************************
	Description : �����ڵ� ����
******************************************************************************/
function ln_Save(){

	var row = gcds_hcl.rowposition;

	if (gcds_hcl.IsUpdated) {	 
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_hcl.KeyValue = "tr00512_t1(I:DATA=gcds_hcl)";
			gctr_hcl.Parameters = "v_str1=" + gusrid;
			gctr_hcl.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00512_t1";
			gctr_hcl.post();
		}
	}
}

/******************************************************************************
	Description : �����ڵ� ����
******************************************************************************/
function ln_Delete(){
	if (gcds_hcl.sysStatus(gcds_hcl.rowposition)=="1") gcds_hcl.undo(gcds_hcl.rowposition);
	else gcds_hcl.deleterow(gcds_hcl.rowposition);
	ln_Save();
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_hcl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--���������ڵ�-->
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id="gctr_hcl" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���������ڵ� TR-->
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_hcl" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gctr_hcl" event="onFail()">
	alert("error code : " + gctr_hcl.errorcode + "\n" + "error message : " + gctr_hcl.errormsg + "\n");
</script>

<script language=JavaScript  for=gcds_hcl event=OnLoadCompleted(rowcount)>	//�����ڵ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	lbl_search1.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcgd_hcl" event="onClick(row,colid)" >
	if (row<1) {
		if (colid=="MINORNM"||colid=="MINORCD"){
			gcds_hcl.sortExpr = colid + "+";
			gcds_hcl.sort();
			gcds_hcl.rowposition = 1;
		}
	}
	
	//if (gcds_hcl.namevalue(row,"USEYN") == "T" ) {
	//	txt_useyn.checked = true;
	//}	else {
	//	txt_useyn.checked = false;
	//}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcds_hcl event="OnRowPosChanged(row)">
	if (gcds_hcl.sysStatus(row)=="0") CAR_TYPE.disabled = true;
	else CAR_TYPE.disabled = false;
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>



<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<!-- OnLoad="ln_Start()" -->
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h050012_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr>
					<td width="100" align=center  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;������&nbsp;&nbsp;</nobr></td>
					<td><input id="txt_hobby1" name="txt_hobby1" type="text" class="txt11" style='width:100;position:relative;left:8px;top:0px;IME-MODE: active' onkeydown="if(event.keyCode==13) ln_Query();"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan=2 height=3></td></tr>  	
  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:500" valign=top>
						<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_hcl classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 560px; HEIGHT: 419px;border:1 solid #777777;" viewastext class="txtbox">
						<PARAM NAME="DataID"			VALUE="gcds_hcl">
						<PARAM NAME="Editable"		VALUE="false">
						<PARAM NAME="BorderStyle" VALUE="0">
						<param name="Sort"				value="true">
						<param name="Fillarea"		VALUE="true">
						<PARAM NAME="Format"			VALUE="
							<C> Name='�����ڵ�'		ID=CAR_TYPE	HeadAlign=Center HeadBgColor=#B9D4DC Width=60    align=center show=TRUE</C>
							<C> Name='������'		ID=CAR_NAME	HeadAlign=Center HeadBgColor=#B9D4DC Width=130   align=center Edit=none</C>
							<G> Name='������' HeadBgColor=#B9D4DC
								<C> Name='����'	ID=CAR_LENGTH	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=right</C>
								<C> Name='��'		ID=CAR_WIDTH  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=right</C>
								<C> Name='����'	ID=CAR_HEIGHT HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=right</C>
								<C> Name='CBM'	ID=CAR_CBM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=right</C>
							</G>
							<C> Name='���'		ID=CAR_TON  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	 align=right</C>
							<C> Name='����'		ID=SECTION    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	 align=center EditStyle=Combo Data='0000:����,0001:����,0002:�ݰ���'</</C>
							">  
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
          <td width=3><nobr>&nbsp;</nobr></td>
					<td style="" valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:307px; "><!-- height:420px; -->
							<tr>
								<td valign=middle  style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;�󼼳���&nbsp;</nobr></td>
								<td style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="../../common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()" >
									<img src="../../common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()" >
									<img src="../../common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
								</td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" class="txtbox">&nbsp;�����ڵ�</td>
								<td style="border:1 solid #708090;border-left-width:0px">
									<input id="CAR_TYPE" type="text" class="txtbox" style= "width:63px; height:20px;position:relative;left:8px"  maxlength="4" onBlur="bytelength(this,this.value,4);"></td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;������</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<input id="CAR_NAME" type="text" class="txtbox"  style= "width:150px; height:20px;position:relative;left:8px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);">
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;������ ����</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<%=HDConstant.COMMENT_START%><OBJECT id=CAR_LENGTH classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:8px;top:3px">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=MaxDecimalPlace value=2>
										<param name=IsComma					value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;������ ��</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<%=HDConstant.COMMENT_START%><OBJECT id=CAR_WIDTH classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:8px;top:3px">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=MaxDecimalPlace value=2>
										<param name=IsComma					value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;������ ����</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<%=HDConstant.COMMENT_START%><OBJECT id=CAR_HEIGHT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:8px;top:3px">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=MaxDecimalPlace value=2>
										<param name=IsComma					value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;������ CBM</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<%=HDConstant.COMMENT_START%><OBJECT id=CAR_CBM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:8px;top:3px">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=MaxDecimalPlace value=2>
										<param name=IsComma					value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" class="txtbox">&nbsp;���</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">
									<%=HDConstant.COMMENT_START%><OBJECT id=CAR_TON classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:8px;top:3px">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=MaxDecimalPlace value=2>
										<param name=IsComma					value=true>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
							</tr>
						<!--	
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">����</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<%=HDConstant.COMMENT_START%><OBJECT id=LuxeCombo3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 style='position:relative;left:0px;top:2px;height:10;'  >
									<param name=CBData			value="00^����,01^����,02^�ݰ���">
									<param name=CBDataColumns	value="code,Name">
									<param name=SearchColumn	value=Name>
									<param name=SortColumn  value="code"> 
									<param name=Sort			value=True>
									<param name=ListExprFormat	value="code^2^12,name^1^100">								
									<param name=BindColumn		value="code">
									<param name=Index		value=0>
									<param name=InheritColor  value="true"> 
									<param name=ComboStyle		value=2>
									</OBJECT><%=HDConstant.COMMENT_END%>
									<!-- <input id="txt_seq"			type="text" style= "width:183px; height:20px;position:relative;left:-6px"> -->
								</td>
					<!--		</tr>   --> 
							<tr>
								<!--<td style="height:17px;border:0 solid #708090;border-top-width:0px;" >&nbsp;s</td>-->
								<td style="height:181px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr> 
							<tr height=2px>
							<td>&nbsp;
							</td>
							</tr>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=875 style="position:relative;top:-10">
	<tr>
		<td height="24">&nbsp;��ȸ�Ǽ� : <label id="lbl_search1"></label></td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_hcl classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_hcl>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=CAR_TYPE     Ctrl=CAR_TYPE    Param=value</C>
		<C>Col=CAR_NAME     Ctrl=CAR_NAME    Param=value</C>
		<C>Col=CAR_LENGTH   Ctrl=CAR_LENGTH  Param=Text</C>
		<C>Col=CAR_WIDTH    Ctrl=CAR_WIDTH   Param=Text</C>
		<C>Col=CAR_HEIGHT   Ctrl=CAR_HEIGHT  Param=Text</C>
		<C>Col=CAR_CBM      Ctrl=CAR_CBM     Param=Text</C>
		<C>Col=CAR_TON      Ctrl=CAR_TON     Param=Text</C>
		<C>Col=CAR_CLASS    Ctrl=CAR_CLASS   Param=CodeValue</C>
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>