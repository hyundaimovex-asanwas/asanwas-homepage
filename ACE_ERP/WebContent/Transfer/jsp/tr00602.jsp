<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	:	�������� - �������װ���
+ ���α׷� ID	: TR00602.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: ���̼�
+ �ۼ����� :
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� :
+ �������� :
----------------------------------------------------------------------------------
+ ������ :
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
		
		//�ӽ�
		gusrid ="6070001";

		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!
			

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			ln_Start();
			window.status="�Ϸ�";

		}
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	txt_filenm.value = "";
	
	ln_Query();
	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_s01?v_str1=1&v_str2=";
	alert();
	gcds_data.Reset();
	
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	if (gcds_data.sysStatus(gcds_data.countrow)=="1") {
		alert("�� �Է��Ͻ� ������ �����Ͻ� �� �ű� ���� �ۼ��� �ֽʽÿ�.");
		return;
	}

	gcds_data.AddRow();
	gcds_data.Namevalue(gcds_data.rowposition,"MAIFLAG") = "F";
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (!gcds_data.IsUpdated) return;

	if (gcds_data.countrow > 0) {

		var tmaidesc = txt_text.value;
		var tmaisubj = txt_subject.value;
		var cdesc = tmaidesc.replace(/\s/g,"");
		var csubj = tmaisubj.replace(/\s/g,"");
		var curdate = gn_Replace(gcurdate,'-');
		var tfile = txt_filenm.value;
		var tmaifiles = gcip_file.FileInfo("size");
		var tmaifname = ln_Divide(txt_filenm.value, "\\");
		var tdaecod = gusrid;

		if (tfile == '' || tfile == null)	tfile = "";
		if (tmaifiles == '' || tmaifiles == null)	tmaifiles = 0;

		if (csubj == '' || csubj == null){
			alert('������ �Է��Ͻÿ�');
			txt_subject.focus();
			return;
		}

		if (cdesc == '' || cdesc == null){
			alert('������ �Է��Ͻÿ�');
			txt_text.focus();
			return;
		}
		
		if (tmaifiles >= 1048577){
			alert("÷�������� 1M Byte(1048576 Byte)���ϸ� �����մϴ�.\n\n���� ������ ������ ũ��� "+tmaifiles+" Byte�Դϴ�");
			return;
		}

		for (var j=1; j<=gcds_data.countrow; j++){
			if (gcds_data.sysStatus(j)=="1"){
				gcds_data.NameValue(j,"MAIGBN") = "1";	        //�Է±���
				gcds_data.NameValue(j,"MAIYMD") = curdate;			//�Է�����
				gcds_data.NameValue(j,"MAISEQ") = 0;		        //����

				gcds_data.NameValue(j,"MAITIME") = "0";							//�Է½ð�
				gcds_data.NameValue(j,"MAISMAN") = gusrid;					//�Է���
				gcds_data.NameValue(j,"MAISUBJ") = tmaisubj;				//����
				gcds_data.NameValue(j,"MAIDESC") = tmaidesc;			  //���� 
				gcds_data.NameValue(j,"MAIFILES") = Number(tmaifiles);		//÷������ SIZE
				gcds_data.NameValue(j,"MAIFNAME") = tmaifname;				    //÷�������̸�

				if (tfile != null || tfile != "")	gcds_data.NameValue(j,"MAIFILE") = tfile;				    //÷������

			} else if (gcds_data.sysStatus(j)=="3"){
				gcds_data.NameValue(j,"MAISUBJ") = tmaisubj;				//����
				gcds_data.NameValue(j,"MAIDESC") = tmaidesc;			  //���� 
				gcds_data.NameValue(j,"MAIFILES") = Number(tmaifiles);		//÷������ SIZE
				gcds_data.NameValue(j,"MAIFNAME") = tmaifname;				    //÷�������̸�
				if (tfile != null || tfile != "")	gcds_data.NameValue(j,"MAIFILE") = tfile;				    //÷������
			}
		}
	} 



	if (confirm("�ش� �Է������� �����ϰڽ��ϱ� ?")) {
	
		if (tfile == null || tfile == "")	{
			gctr_nfile.Parameters = "v_str1=" + "1" + ",v_str2=" + curdate;

			gctr_nfile.Post();		  //÷�������� ���� ���
		} else {
			gctr_tfile.Parameters = "v_str1=" + "1" + ",v_str2=" + curdate;
			gctr_tfile.Post();		  //÷�������� �����ϴ� ���
		}
	}

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	var row = gcds_data.rowposition;
	if (gcds_data.sysStatus(row)=="1") gcds_data.undo(row)
	else gcds_data.deleterow(row);
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
	Description :
******************************************************************************/
function ln_Divide(str, delim){

	var strArr = str.split(delim);
	var rtn = "";
	var a = strArr.length;

	if(a>0) rtn=strArr[a-1];

	strArr = null;
	return rtn;
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_nfile classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_t01">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00602_t01(I:DATA=gcds_data)">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gctr_tfile classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
  <PARAM NAME="Action" VALUE="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00602_t02">
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="tr00602_t02(I:DATA=gcds_data)">
</OBJECT>
<%=HDConstant.COMMENT_END%>


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	//window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";

</script>

<script language="javascript" for="gcds_data" event="CanRowPosChange(row)">
	if (gcds_data.sysStatus(row)=="1" || gcds_data.sysStatus(row)=="3" ) {

	} else return true;

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcip_file event=OnClick()>
	txt_filenm.value = gcip_file.value;

</script>
<script language="javascript"  for=gcgd_disp event=OnClick(Row,Colid)>
	 
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_nfile" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcds_data.reset();
</script>

<script language="javascript" for="gctr_tfile" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcds_data.reset();
</script>


<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td width="877" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif">
			<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Delete()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_insert.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Add()">
			<img src="<%=dirPath%>/Common/img/btn/com_b_save.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Save()">
	    	<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="position:relative;top:2px;cursor:hand" onclick="ln_Query()"> 
			&nbsp;
		</td>
  </tr>
	<tr><td height=2></td></tr>
	<tr>
		<td valign="top" colspan=2>
			<%=HDConstant.COMMENT_START%><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp
				style="position:relative;left:0px;width:875px; height:119px; border:1 solid #708090;">
			    <PARAM NAME="DataID"			VALUE="gcds_data">
				  <PARAM NAME="BorderStyle" VALUE="0">
				  <PARAM NAME="Editable"		VALUE="1">
					<PARAM NAME="IndWidth"		VALUE='17'>
					<PARAM NAME="Fillarea"		VALUE="true">
				  <PARAM NAME="Format"			VALUE="  
						<C> Name='No',  ID={CURROW},  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center</C> 
						<C> Name='÷��'  ID=						HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center value={decode(MAIFILES,0,'','Y')}, cursor=hand, edit=none</C> 
						<C> Name='����'		ID=MAIFLAG	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center cursor=hand, editstyle=checkbox</C> 
						<C> Name='�� ��'  ID=MAISUBJ  HeadAlign=Center HeadBgColor=#B9D4DC Width=457 align=left, edit=none</C> 
						<C> Name='�ۼ���' ID=MAIYMD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, mask='XXXX/XX/XX', edit=none</C> 
						<C> Name='�ۼ���' ID=REGNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=133 align=center, edit=none</C> 
					">
			</OBJECT><%=HDConstant.COMMENT_END%>
		</td>
	</tr>
	<tr><td height=3></td></tr>
	<tr>
		<td colspan=2>
      <table width="877" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td> 
            <table border="0" cellspacing="0" cellpadding="0" style="width:100%;border:1 solid #708090;border-right-width:0px;border-bottom-width:0px;">
              <tr> 
	              <td class="tab11" style="width:90;height:30px" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                <td colspan="3" class="tab21"><input type="text" class="txt11" id=txt_subject style="width:750px;IME-MODE: active" maxlength="100"></td>			
              		</tr>
					<tr> 
                			<td class="tab11" style="height:30px;" bgcolor="#eeeeee">÷������</td>
                			<td colspan="3" class="tab21">
                  			<input type="text" class="txt11" id=txt_filenm readonly style="width:685px">
								  <%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
						        style="position:relative;left:9px;width:80; height:20;" align="absmiddle">
								      <param name="Text"          value='ã�ƺ���'>
		                  			<param name="Enable"        value="true">
									</OBJECT><%=HDConstant.COMMENT_END%>
								</td>
              		</tr>
              		<tr style="height:300px"> 
                <td class="tab11" style="height:30px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                <td colspan="3" class="tab21"><TEXTAREA id=txt_text class="txt11" style="width:775px; height:290px;border:0;overflow:auto;IME-MODE: active"></TEXTAREA>
				</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=MAISUBJ    	Ctrl=txt_subject	Param=Value</C>
		<C>Col=MAIDESC		Ctrl=txt_text			Param=Value</C>
		<C>Col=MAIFNAME   Ctrl=txt_filenm		Param=Value</C>
	'>
</OBJECT>
<%=HDConstant.COMMENT_END%>


</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>
