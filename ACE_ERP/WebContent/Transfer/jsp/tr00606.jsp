<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �� �� �� ��	: �����纰ȭ�ְ���
+ ���α׷� ID	: TR00606
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �̹���
+ �� �� �� ��	: tr00501_s1, tr00501_s2, tr00501_s3, tr00501_t1, tr00501_t2
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

		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]

			ln_Start();//����ȸ

			window.status="�Ϸ�";

		}
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	get_cookdata();
	
	
	gcds_hch.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00606_s1"; 
	gcds_hch.Reset(); 

	txt_usests.checked	=	true;


}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";

	var str1 = gclx_userid_fr.BindColVal;

//	gcds_hcl.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00606_s2?v_str1=" + str1; 
//prompt('',gcds_hcl.DataID);
//	gcds_hcl.Reset();

//	gcds_hcl.rowposition=1;

		gcds_hcl.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00606_s2?v_str1="+str1;
	  gcds_hcl.Reset(); 

	//txt_minorcd.disabled = true;


	//txt_usests.checked	=	true;

	if (gcds_hcl.namevalue(1,"USESTS") == "T") {
		txt_usests.checked = true;
	} else {
		txt_usests.checked = false;
	}
//alert(gcds_hcl.namevalue(1,"USESTS") == "T");

	var row = gcds_hch.rowposition;

//	txt_majorcd1.value = str1; 
//	txt_majorcd1.disabled = true;
//	txt_majornm2.value = gcds_hch.namevalue(row,"MAJORNM");
	

//	txt_memo2.value = gcds_hch.namevalue(row,"MEMO");
//alert("ln_Query 2");
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_MajorQuery(){

	var str1 = gclx_userid_fr.BindColVal;           //������Ʈ


	gcds_hch.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s2?v_str1="+str1; 

	gcds_hch.Reset(); 

	tb_majorcd.BindColVal = gcds_hch.namevalue(gcds_hch.rowposition,"MAJORNM");
	tb_majorcd.index = 0;


}
/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	gcds_hcl.addrow();

	//txt_minorcd.disabled = false;
	//txt_minorcd.focus();
	
	txt_usests.checked = false; 

	for(i=1;i<=gcds_hcl.countrow;i++){

		if(gcds_hcl.NameValue(i,"USEYN") == "T"){
			txt_usests.checked = true; 
		}else{
			txt_usests.checked = false;
		}
	}

	var row = gcds_hcl.rowposition;
	gcds_hcl.namevalue(row, "CUSTID") = gclx_userid_fr.bindcolval;
//	alert(gclx_userid_fr.bindcolval);
	//txt_userid1

}

/*-----------------------------------------------------------------------------
 #  ������  : �߰�
-----------------------------------------------------------------------------*/
function ln_Add2(){

	txt_majorcd1.value	=	"";
	//txt_majornm2.value		=	"";
	//txt_useyn2.checked	=	false;
//	txt_memo2.value			=	"";


	//gcds_hch.addrow();
	
	ln_TempSave();

	txt_majorcd1.disabled = false;
	txt_majorcd1.focus();

	gcds_hcl.ClearData();

}

/******************************************************************************
	Description : ȭ��ID ����
******************************************************************************/
function ln_Save(){

	var row = gcds_hcl.rowposition;

	if (txt_usests.checked==false) {gcds_hcl.namevalue(row,"USEYN")='F'} else gcds_hcl.namevalue(row,"USEYN")='T'; 

	if (!ln_Valchk()) return;

	//if (!ln_Valchk2()) return;

	if (gcds_hcl.IsUpdated) {	//�����ڵ� ��ȸ
	
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){
			gctr_hcl.KeyValue = "tr00606_t1(I:USER=gcds_hcl)";
			gctr_hcl.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00606_t1";
			gctr_hcl.post();
			return ln_Query();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  �����ڵ�  : ����
-----------------------------------------------------------------------------*/
function ln_Save2() {

	var row		= gcds_hch.rowposition;
	var rtemp = gcds_temp.rowposition;

	gcds_temp.namevalue(rtemp,"MAJORCD")	=	txt_majorcd1.value;
	gcds_temp.namevalue(rtemp,"MAJORNM")	=	txt_majornm2.value;
	gcds_temp.namevalue(rtemp,"MEMO")		=	txt_memo2.value;
	gcds_temp.namevalue(rtemp,"MEMO")		=	txt_memo2.value;

	if (txt_useyn2.checked ==	false) { gcds_temp.namevalue(rtemp,"USEYN") = "F"; 
	}else { gcds_temp.namevalue(rtemp,"USEYN") = "T"; }

	if (!ln_Valchk1()) return;
	if (!ln_Valchk2()) return;

}

/******************************************************************************
	Description : �����ڵ� �ӽ�����
******************************************************************************/
function ln_TempSave() {

	var THeader = "MAJORCD:String(4),MAJORNM:String(30),USEYN:String(1),MEMO:String(30)";

	gcds_temp.SetDataHeader(THeader);

	gcds_temp.addrow();

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		if (gcds_hcl.sysStatus(gcds_hcl.rowposition)=="1") gcds_hcl.undo(gcds_hcl.rowposition);
		else {
			gcds_hcl.deleterow(gcds_hcl.rowposition);
			gctr_hcl.KeyValue = "tr00606_t1(I:USER=gcds_hcl)";
			gctr_hcl.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00606_t1";
			gctr_hcl.post();
			return ln_Query();
		}
	}
}

/*-----------------------------------------------------------------------------
 #  �����ڵ�  : ����
-----------------------------------------------------------------------------*/
function ln_Delete2(){

	if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		gcds_hch.deleterow(gcds_hch.rowposition);
		gctr_hch.KeyValue = "tr00501_t2(I:USER=gcds_hch)";
		gctr_hch.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t2";
		gctr_hch.post();
		tb_majorcd.index = 0;
		return ln_Query();
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

	gcds_hcl.undo(gcds_hcl.rowposition);
	return ln_Query();

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
	Descrition : CheckBox
******************************************************************************/
function ln_Chkbox(e,a){

	var row = gcds_hcl.rowposition;

	if (e.checked) gcds_hcl.namevalue(row,a) = "T";
	else gcds_hcl.namevalue(row,a) = "F";
}

/******************************************************************************
	Description : �Է°� üũ[�����ڵ�]
******************************************************************************/
function ln_Valchk() {

	if (fn_trim(txt_userid.value) == "") {			
		alert("��Ȯ�� �����ID�� �Է��� �ֽʽÿ�");
		txt_userid.value = "";
		txt_userid.focus();
		return false;
	}

	if (fn_trim(txt_usernm.value)== "") {			
		alert("��Ȯ�� ����ڸ��� �Է��� �ֽʽÿ�");
		txt_usernm.value = "";
		txt_usernm.focus();
		return false;
	}

	/*if (gcds_hcl.NameValue((i,"USEYN")== "") {			
		alert("��뿩�θ� üũ���ֽʽÿ�");
		//txt_usernm.value = "";
		//txt_usernm.focus();
		return false;
	}
*/


	/*	if(gcds_hcl.NameValue(i,"USEYN") == "T"){
			txt_useyn.checked = true; 
		}else{
			txt_useyn.checked = false;
		}
	}


*/


	return true;

}

/*-----------------------------------------------------------------------------
 #  Description : �Է°� üũ[�����ڵ�]
-----------------------------------------------------------------------------*/
function ln_Valchk1() {

	if (fn_trim(txt_majorcd1.value) == "") {			
		alert("��Ȯ�� �����ڵ带 �Է��� �ֽʽÿ�");
		txt_majorcd1.value ="";
		txt_majorcd1.focus();
		return false;
	}

	if (fn_trim(txt_usernm.value) == "") {			
		alert("��Ȯ�� ����ڸ��� �Է��� �ֽʽÿ�");
		txt_usernm.value = "";
		txt_usernm.focus();
		return false;
	}

	return true;
}

/******************************************************************************
	Description : ���̵�üũ 
******************************************************************************/
/*function ln_Popup(){
	if (gcds_data.countrow<1) return;
	if (gcds_data.sysStatus(gcds_data.rowposition)!="1") return;

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Transfer/html/TR00605_popup.html";
	strPos = "dialogWidth:370px;dialogHeight:160px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);
		
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_userid.value = arrParam[0].toUpperCase();
	}
}
*/
function ln_Popup(){
	if (gcds_hcl.countrow<1) return;
	if (gcds_hcl.sysStatus(gcds_hcl.rowposition)!="1") return;

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "/Transfer/html/TR00606_popup.html";
	strPos = "dialogWidth:383px;dialogHeight:499px;status:no;scroll:no;resizable:no";
	//strPos = "dialogWidth:370px;dialogHeight:160px;status:no;scroll:no;resizable:no";
 	arrResult = showModalDialog(strURL,'',strPos);
		
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_userid.value = arrParam[0];
		txt_usernm.value = arrParam[1];
	}
}
/******************************************************************************
	Description : �Է°� üũ
******************************************************************************/
function ln_Valchk2() {

	var str1 =  txt_majorcd1.value;
	gcds_hch3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s3?v_str1=" + str1; 
	gcds_hch3.Reset(); 

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcds_hcl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--���������ڵ�-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_hch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--��������ڵ�-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_hch3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id=gcds_userid_fr classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT><%=HDConstant.COMMENT_END%>



<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id="gctr_hcl" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--���������ڵ� TR-->
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT id="gctr_hch" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--��������ڵ� TR-->
</OBJECT><%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_hcl" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_hcl" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_hch" event="OnSuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_hch" event="OnFail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language=JavaScript  for=gcds_hcl event=OnLoadCompleted(rowcount)>	//�����ڵ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 

	ft_cnt.innerText = "��ȸ�Ǽ� : �� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

var row = gcds_hcl.rowposition;

	if (gcds_hcl.namevalue(row,"USESTS") == "T" ) {
		txt_usests.checked = true;
	}	else {
		txt_usests.checked = false;
	}

</script>





<script language="javascript" for="gcgd_hcl" event="onClick(row,colid)" >

	if (row<1) {
		if (colid=="MINORNM"||colid=="MINORCD"){
			gcds_hcl.sortExpr = colid + "+";
			gcds_hcl.sort();
			gcds_hcl.rowposition = 1;
		}
	}
	
	if (gcds_hcl.namevalue(row,"USESTS") == "T" ) {
		txt_usests.checked = true;
	}	else {
		txt_usests.checked = false;
	}
</script>




<script language="javascript" for="gclx_userid_fr" event="OnSelChange2()">

	var str1 = gclx_userid_fr.BindColVal;
	var row = gcds_hch.rowposition;



	txt_userid1.value = str1; 
	txt_majornm2.value = gcds_hch.namevalue(row,"USERNM");

	ln_Query();
</script> 



<script language="javascript" for="gcds_hch3" event="OnLoadCompleted(rowcnt)">
		
		var row		= gcds_hch.rowposition;
		var rtemp = gcds_temp.rowposition;

		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){

			gctr_hch.KeyValue = "tr00501_t2(I:USER=gcds_temp)";
			gctr_hch.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_t2";
			gctr_hch.post();
			tb_majorcd.index = 0;
			ln_Query();
			ln_MajorQuery();
		}


</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_hcl" event="OnRowPosChanged(row)">

</script> 

<!-- �����μ� [�˻�] -->
<script language="javascript" for="gcds_userid_fr" event="onloadCompleted(row,colid)">
	gcds_userid_fr.InsertRow(1);
	gcds_userid_fr.NameValue(1,"USERID")="";
	gcds_userid_fr.NameValue(1,"USERNM")="��ü";
	gclx_userid_fr.index=0;
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
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/TR00606_head.gif"></td>
    <td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;"> 
			<img src="../../common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100" align=center style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>&nbsp;������ ID&nbsp;&nbsp;</nobr></td>
					<td>&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_userid_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=150 style="position:relative;top:2px;" class="txtbox">
							<param name=ComboDataID			value=gcds_hch>
							<param name=SearchColumn		value="USERNM">
							<param name=Sort                value="true">
							<param name=SortColumn			value="USERID">
							<param name=ListExprFormat	    value="USERNM^0^120">
							<!-- <param name=ComboStyle		    value=2> -->
							<param name=BindColumn			value="USERID">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td width="150" align=RIGHT></td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;"></td>
					<td width="150" align=RIGHT	style="border:0 solid #708090;border-right-width:0px;"></td>
					<td width="10"	align=RIGHT style="border:0 solid #708090;border-right-width:0px;"></td>
					<td><nobr></nobr></td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=3> 
		</td>
	</tr>  	
  <tr> 
    <td colspan="2" align=left style="padding-left:0px;"> 
      <table width="867" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:500">
						<%=HDConstant.COMMENT_START%><OBJECT id=gcgd_hcl classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="WIDTH: 500px; HEIGHT: 419px;border:1 solid #777777;" viewastext class="txtbox">
              <PARAM NAME="DataID"			VALUE="gcds_hcl">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Sort"				value="true">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="
								<C> Name='����� ID'		ID=USERID	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center Edit=none</C>
								<C> Name='����ڸ�'			ID=USERNM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=200 align=left		Edit=none</C>
								<C> Name='��뿩��'			ID=USESTS  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=177	 align=center  EditStyle=combo  Data='T:���,F:�̻��' Edit=none</C>
							">
            </OBJECT><%=HDConstant.COMMENT_END%>
						<fieldset style="width:502px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
						</fieldset>
					</td>
          <td width=3><nobr>&nbsp;</nobr></td>
					<td style="" valign=top>
						<table border="0" cellpadding="0" cellspacing="0" style="width:367px; height:420px;">
							<tr>
								<td valign=middle width=250 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;ȭ������&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<img src="../../common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete()" >
									<img src="../../common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()" >
									<img src="../../common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
								</td>									
							</tr>
							<tr>
								<td style="height:30px;width:205px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox"><nobr>&nbsp;&nbsp;&nbsp;&nbsp;�����ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_userid" type="text" class="txtbox" style= "width:80px; height:20px;position:relative;left:-6px"  maxlength="10" onBlur="bytelength(this,this.value,10);" ReadOnly>
									<img src="../img/btn_find.gif" style="position:relative;left:-5px;top:2px;cursor:hand" onclick="ln_Popup();" >
								</td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">����ڸ�</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_usernm" type="text" class="txtbox"  style= "width:183px; height:20px;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);" ReadOnly>
								</td>
							</tr>
							<!-- <tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�� �� ��</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<%=HDConstant.COMMENT_START%><OBJECT id=gcem_seq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:63px;height:20px;position:relative;left:-6px;top:3px">
										<PARAM name="DataID"			value="gcds_hcl">								
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Border        value=true>
										<param name=ClipMode      value=true>
										<param name=Numeric       value=true>
										<param name=IsComma				value=true>
										<param name=PromptChar    value="_">
										<param name=IsComma       value=false>
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</OBJECT><%=HDConstant.COMMENT_END%>
									
								</td>
							</tr> -->
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�������</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;">
									<input type=checkbox  name=txt_usests class="txtbox"  style="position:relative;left:0px" onclick="ln_Chkbox(this,'USESTS')">
								</td>
							</tr>
							<!-- <tr>
								<td style="height:80px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_memo" class="txtbox"  style= "width:255px; height:71px; overflow:auto;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea>
								</td>
							</tr> -->
							<tr>
								<td style="height:17px;border:0 solid #708090;border-top-width:0px;" >&nbsp;</td>
								<td style="border:0 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;</td>
							</tr>
							<tr>
								<td valign=middle width=150 style="height:30px;border:1 solid #708090;border-bottom-width:0px;" bgcolor="#B9D4DC" align=center class="txtbox"><nobr>&nbsp;����������&nbsp;</nobr></td>
								<td width="100%" style="border:0 solid #708090;border-bottom-width:0px;" align=right>
									<!-- <img src="../../common/img/btn/com_b_delete.gif"	style="cursor:hand" onClick="ln_Delete2()">
									<img src="../../common/img/btn/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add2()">
									<img src="../../common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save2()"> -->
								</td>				
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">������ID&nbsp;&nbsp;&nbsp;</td>
								<td style="border:1 solid #708090;border-top-width:1px;border-left-width:0px">&nbsp;
									<input id="txt_userid1" type="text" class="txtbox"  style= "width:80px; height:20px;position:relative;left:-6px" maxlength="4" onBlur="bytelength(this,this.value,10);" ReadOnly>
								</td>									
							</tr>
							<tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�������</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px">&nbsp;
									<input id="txt_majornm2" type="text" class="txtbox"  style= "width:183px; height:20px;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);" ReadOnly>
								</td>
							</tr>
							<!-- <tr>
								<td style="height:30px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">�������</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px;padding-left:2px;">
									<input type=checkbox id=txt_useyn2 name=txt_useyn2 class="txtbox"  checked style="position:relative;left:0px;">
								</td>
							</tr> -->
							<!-- <tr>
								<td style="height:74px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td style="border:1 solid #708090;border-top-width:0px;border-left-width:0px" >&nbsp;
									<textarea id="txt_memo2" name="txt_memo2" class="txtbox"  style= "width:255px; height:65px; overflow:auto;position:relative;left:-6px;IME-MODE: active" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td>
							</tr> -->
							<tr>
					<td height="150px" style="border:1 solid 
					#708090;border-left-width:1px;border-right-width:0px;border-top-width:0px;" >&nbsp;</td><!--�ؿ� ���ĭ-->
					 <td height="150px" style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan="3">&nbsp;</td>
						</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
	<!--
   <table border=0 cellpadding=0 cellspacing=0 width=875>
		<tr><td height=10></td></tr>
		<tr>
			<td height="24">��ȸ�Ǽ� : <label id="lbl_search1"></label></td>
		</tr>
 </table>-->
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_hcl classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_hcl>
	<param name=ActiveBind    value=true>
	<param name=BindInfo			value='
		<C>Col=USERID     Ctrl=txt_userid       Param=value</C>
		<C>Col=USERNM			Ctrl=txt_usernm				Param=value</C>
		<C>Col=USESTS			Ctrl=txt_usests				Param=value</C>
		<C>Col=CUSTID			Ctrl=txt_userid1			Param=value</C>

		
	
	'>
</OBJECT><%=HDConstant.COMMENT_END%>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

