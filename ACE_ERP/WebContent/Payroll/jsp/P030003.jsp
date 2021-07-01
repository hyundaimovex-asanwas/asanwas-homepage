<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	   ����������� - �����ٹ�������
+ ���α׷� ID	:   p030003.html
+ �� �� �� ��	:   
+ �� �� �� ��	: 
+ �� �� �� ��	:   p030003_s1,
                       	p030003_t1 : 
------------------------------------------------------------------------------>
<html>
<head>
<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>�����ٹ�������</title>
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
var gstrChk =""; //���
var gs_level;
var gs_treecd;

get_cookdata();

var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	gcem_curdt.text = gcurdate.substr(0,4);	//�ͼӳ⵵
	
	ln_Before();	//����ȸ
}

/******************************************************************************
	Description : ȸ���
******************************************************************************/
function ln_resino(){
 //txt_wknm.value = "7311151914224";
 //alert("txt_wknm.value" +txt_wknm.value );
 gf_Resino(txt_wknm.value);
}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

   if (gcem_curdt.text=="") {
			alert("����� �ʼ��׸��Դϴ�.");
			gcem_curdt.setFocus();
	 }

   gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030003_s1?v_str1=" + gcem_curdt.text
																	 +"&v_str2="+ gclx_deptcd.bindcolval
																	 +"&v_str3="+  fn_trim(txt_empnmk1.value)
																	 + "&v_str4=" + gs_level
																	 + "&v_str5=" + gs_treecd;

	 //prompt("gcds_data", gcds_data.DataID);
	 gcds_data.Reset(); 

	 ln_Enable("f");

	 gstrChk="";
}

/******************************************************************************
	Description : ����ȸ ����
******************************************************************************/
function ln_Before(){

	//�Ҽ��ڵ�[�˻�]
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1?";
	gcds_dept1.Reset();

	//�Ҽ��ڵ�2
	gcds_dept2.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s2?";
	gcds_dept2.Reset();

}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
//	ln_Header_create("1");
  gstrChk="A";
	gcds_data.addrow();	
	ln_Enable("t");

	gcem_yyyy.focus();
// gcem_yyyymm.text="200501"

//	gcem_yymm2.text = strgcem_yyymm
//	gcds_data.namevalue(gcds_data.RowPosition,"EVAYM")=gcem_yymm2.text;
//	gcds_data.namevalue(gcds_data.RowPosition,"GRPCD")="1";
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if(ln_Chk()){
			if (confirm("�����Ͻðڽ��ϱ�?")) {
			  //prompt("gcds_data",  gcds_data.text );
					gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030003_t1";
					gctr_data.post();
					//ln_Query();
			}
		}//if ln_Chk
	}

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	
	if (gcds_data.countrow<1){
		alert ("������ ������ �����ϴ�.");
	}else {
		if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
			gcds_data.deleterow(gcds_data.rowposition);
			gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_PAYROLL%>p030003_t1";
			gctr_data.post();
			ln_Query()
		}
	}
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

	if (gcds_data.countrow<1) {
		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	}else{
		gcgd_grid.RunExcel('�����ٹ�������');
	}
}


/******************************************************************************
	Description : DataSet head
******************************************************************************/
function ln_Header_create(p){

  alert(gcds_data.countrow);

	if (p=="1"){
		if (gcds_data.countrow<1){

			var Header1= "YYYY:STRING(4),	EMPNO:STRING(7),	WKRESINO:STRING(20),WKNM:STRING(30),STRTDT2:STRING(8),ENDDT2:STRING(2),"
			                 + "BP11000:DECIAML(9.0),BP12000:DECIAML(9.0),BP13000:DECIAML(9.0),BP10SUM:DECIAML(9.0),BP21000:DECIAML(9.0),"
											 + "BP22000:DECIAML(9.0),BP23000:DECIAML(9.0), BP31000:DECIAML(9.0),BP32000:DECIAML(9.0),BP33000:DECIAML(9.0),"
											 + "BP41000:DECIAML(9.0),BP42000:DECIAML(9.0),BP43000:DECIAML(9.0), BP40SUM:DECIAML(9.0),EMPNMK:STRING(20),"
											 + "PAYGRD:STRING(4),PAYNM:STRING(30),DEPTCD:STRING(4),DEPTNM:STRING(70),STRTDT:STRING(8), ENDDT:STRING(4)";

			gcds_data.SetDataHeader(Header1);
		}
	}
}

/******************************************************************************
	Description : Enable or Disable
******************************************************************************/
function ln_Enable(p){
	if (p=="f"){
		if (gstrChk==""){
			gcem_yyyy.enable=false;
			gcem_empno.enable=false;
			gcem_wkresino.enable=false;
			txt_wknm.disabled=true;
		}
	}else if(p=="t"){
		gcem_yyyy.enable=true;
		gcem_wkresino.enable=true;
		txt_wknm.disabled=false;
	}
}


/******************************************************************************
	Description : ��� �� ����ã��
******************************************************************************/
function ln_FindEmp(){
		var arrResult	= new Array();
		var arrSend	= new Array();
          arrSend[0]='P040001';
		window.dialogArguments=arrSend[0];
		var strURL;	
		var strPos;
			strURL = "./H030003_popup.jsp"
			strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrSend,strPos);
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				gcem_empno.text = arrParam[0];     //���
				txt_empnmk2.value = arrParam[1];  //����
				txt_deptcd.value = arrParam[2];       //�Ҽ��ڵ�
				txt_deptnm.value = arrParam[3];       //�ҼӸ�

        txt_paygrd.value = arrParam[11];     //�����ڵ�
 				txt_paygnm.value = arrParam[12];     //������
				
        gcem_strtdt.text = arrParam[6];       //�Ի���
		  	gcem_enddt.text = arrParam[7];       //����� 
		
			} else {
				gcem_empno.text = "";     
				txt_empnmk2.value = "";
				txt_deptcd.value=""; 
				txt_deptnm.value = ""; 
				txt_paygrd.value ="";
				txt_paygnm.value = ""; 
				gcem_strtdt.text = "";    
		  	gcem_enddt.text = "";  
			}

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){
	if (gcds_data.IsUpdated) {
		if ( gcem_yyyy.text ==""){
			   alert("�ͼӳ⵵�� �Է��� �ֽʽÿ�");
         gcem_yyyy.Focus();
			   return false;
		}

		if ( gcem_empno.text ==""){
			   alert("����� �Է��� �ֽʽÿ�");
         gcem_empno.Focus();
			   return false;
		}

		if ( gcem_wkresino.text ==""){
			   alert("����ڵ�Ϲ�ȣ��  �Է��� �ֽʽÿ�");
         gcem_wkresino.Focus();
			   return false;
		}
		return true; 
	}else{
		alert("����� ������ �����ϴ�");
		return false;
	}

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcds_data" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� �˻�-->
<comment id="__NSID__"><OBJECT id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- �Ҽ� -->
<comment id="__NSID__"><OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<!-- <PARAM NAME="SortExpr" VALUE="+deptnm"> -->
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
	<param name="KeyValue"     value="p030003_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	//ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	  alert("������ �߻� �߽��ϴ�.");
	  window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
  ft_cnt1.innerText = "��ȸ�Ǽ� : " + rowcount + " ��";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	} 
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_grid event=OnClick(Row,Colid)>
	if (Row>0) {
		ln_Enable("f");
	}
</script>

<script language="javascript" for="gcds_dept2" event="onloadCompleted(row,colid)">
			gcds_dept2.insertrow(1);
			gcds_dept2.namevalue(1,"DEPTCD") = "";
			gcds_dept2.namevalue(1,"DEPTNM") = "��ü";
			gclx_deptcd.index = 0;
</script>

<script language=JavaScript for=gclx_deptcd event=onSelChange()>
		gs_level = '';
		gs_treecd ='';
		gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
		gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

		gs_treecd = fn_treecd(gs_level, gs_treecd);
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	ln_Query();
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>

</head>

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/p030003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<nobr>	    
			 <img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel()">
			 <img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
			 <img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_Add()">
			 <img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_Save()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()"> 
			</nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
	
		<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
			<tr> 
				<td width="10" align=RIGHT  style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
					<nobr>&nbsp;�ͼӳ⵵&nbsp;&nbsp;</nobr></td>
				<td style="height:30px;border:0 solid #708090;border-right-width:0px;padding-top:2px;border-right-width:1px;"><nobr>&nbsp;
					<comment id="__NSID__"><object id=gcem_curdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1 validFeatures="ignoreStatus=yes" validExp="">
							<param name=Text          value="">
							<param name=Border	      value=True>
							<param name=Numeric	      value=false>
							<param name=Format	        value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=BackColor     value="#CCCCCC">
						</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
					</td>	
					<td width="0" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee">
					<nobr >&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_dept2">
								<param name=CBDataColumns		value="DEPTCD, DEPTNM">
								<param name=SearchColumn		value=DEPTNM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^150">
								<param name=BindColumn			value=DEPTCD>
 							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td width="10" align=RIGHT style="height:30px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" >
							<nobr>&nbsp;&nbsp;&nbsp;�� ��&nbsp;&nbsp;&nbsp;</nobr></td>
						<td><nobr>&nbsp;
							<input id="txt_empnmk1" name="txt_empnmk1" type="text" class="txtbox" style="width:70px; height:18px;position:relative;top:0px;left:-5px" onkeydown="if(event.keyCode==13) ln_Query();">
							</nobr>
							</td>
						<td width="100%" align=RIGHT >&nbsp;&nbsp;</td>
						<td style="padding-top:4px;"></td>
					</tr>
				</table>
		</td>
  </tr>
  <tr> <td colspan="2" height=3>
  </td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:440px" valign=top>
				<comment id="__NSID__"><OBJECT id=gcgd_grid  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 395px; HEIGHT: 400px;border:1 solid #777777;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data">
					<PARAM NAME="Editable"		VALUE="false">
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM name="SortView"    value="Left">
					<PARAM NAME="Format"			VALUE="  
	<C> Name='�ͼӳ⵵'				ID=YYYY  		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center  mask='XXXX'  </C> 
	<C> Name='���'						ID=EMPNO  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center  sort=true</C> 
	<C> Name='����'						ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=reft		sort=true</C> 
	<C> Name='����ڵ�Ϲ�ȣ'	ID=WKRESINO	HeadAlign=Center HeadBgColor=#B9D4DC Width=108	align=center  mask='XXX-XX-XXXXX'  sort=true</C>
	<C> Name='�����ٹ�ó��'		ID=WKNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=reft		sort=true</C>

	<C> Name='�����Ի�����'		ID=STRTDT2	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	show=false mask='XXXX/XX/XX'</C>
	<C> Name='�����������'		ID=ENDDT2 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	show=false mask='XXXX/XX/XX'</C>
	<C> Name='�޿��Ѿ�'				ID=BP11000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='��'						ID=BP12000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='������'				ID=BP13000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='�ѱ޿���'				ID=BP10SUM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='���ܱٷκ����'	ID=BP21000	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		show=false</C>
	<C> Name='�߰��ٷκ����'	ID=BP22000	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right		show=false</C>
	<C> Name='��Ÿ�����'			ID=BP23000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='���ο���'				ID=BP31000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='�ǰ�����'				ID=BP32000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='���뺸��'				ID=BP33000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='�ҵ漼'					ID=BP41000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='�ֹμ�'					ID=BP42000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
	<C> Name='��Ư��'					ID=BP43000	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
  <C> Name='���װ�'					ID=BP40SUM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		show=false</C>
						">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="width:397px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
						</fieldset>
					</td>
          <td>&nbsp;</td>
					<td STYLE="PADDING-TOP:0px;" valign=top>
					<table width="440" cellpadding="0" cellspacing="0" border="0">
					<tr> 
          <td valign=top>
						
						<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:473px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
						<tr>
						<td  class = "tab25"  style="height:25px;width:100px" bgcolor="#eeeeee">&nbsp;�ͼӳ⵵</td>
						<td  class = "tab24" style="width:150px; height:25px;width:60px;padding-left:6px" colspan=2>
							<comment id="__NSID__"><object id=gcem_yyyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:0px;top:1px;width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Text              value="">								
								<param name=Format	         value="YYYY">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				  value=false>
							</object></comment><script>__ws__(__NSID__);</script></td>
						<td class = "tab24" style="height:25px;width:80px;" bgcolor="#eeeeee">&nbsp;����</td>
						<td class = "tab24" style="height:25px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt; "   > 
								<param name=Text          value="">
								<param name=MaxLength     value=7>
                <param name=format           value="#######">
								<param name=BackColor     value="#CCCCCC">
							  <param name=enable				  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;<img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:1px;top:2px;cursor:hand;" onclick="ln_FindEmp()" >
								<input id="txt_empnmk2" name="txt_empnmk2" type="text" class="txtbox" style= "width:60px; height:18px;position:relative;left:-3px;top:-3px"  disabled></td>
						</td>
						</tr>
						<tr>
						<td class = "tab30" style="height:25px;width:100px;" bgcolor="#eeeeee">&nbsp;�Ի�����</td>
						<td class = "tab28" style="height:25px;;padding-left:6px;" colspan=2>
							<comment id="__NSID__"><object id=gcem_strtdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="width:70px; height:20px; font-family:����; font-size:9pt; " > 
								<param name=Text          value="">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td class = "tab28" style="height:25px;" bgcolor="#eeeeee">&nbsp;�������</td>
						<td class = "tab28" style="height:25px;padding-left:6px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_enddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; top:2px; width:70px; height:20px; font-family:����; font-size:9pt; " > 
								<param name=Text          value="">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=enable				value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></td>
					</tr>

					<tr>
						<td class = "tab30" style="height:25px;width:100px;" bgcolor="#eeeeee">&nbsp;�Ҽ�</td>
						<td class = "tab28" style="height:25px;" colspan=2>
								<input id="txt_deptnm" name="txt_deptnm" type="text"  class="txtbox" style= "width:100px; height:18px;position:relative;left:5px;top:1px" disabled>
								<input id="txt_deptcd" name="txt_deptcd" type="hidden"  class="txtbox" style= "width:100px; height:18px;position:relative;left:5px;top:1px" disabled>
								</td>
						<td class = "tab28" style="height:25px;" bgcolor="#eeeeee">&nbsp;����</td>
						<td class = "tab28" style="height:25px;" colspan=2>&nbsp;
								<input id="txt_paygnm" name="txt_paygnm" type="text" class="txtbox"  style= "position:relative; left:-6px; width:100px; height:18px;" value="" maxlength=16 disabled>
								<input id="txt_paygrd" name="txt_paygrd" type="hidden" class="txtbox"  style= "position:relative; left:-6px; width:100px; height:18px;" value="" maxlength=16 disabled>
						
						</td>
						</tr>

					<tr>
						<td style="height:5px;border:0 solid #708090;" colspan=4></td>
					</tr>
				</table>
				
				<table border= "0"  cellpadding=0 cellspacing=0  border=0  style='width:473px;height:0px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:0 solid #708090'>
					<tr>
						<td class="tab31" style="height:20px;"   bgcolor="#B9D4DC"  colspan=1><nobr>&nbsp;�����ٹ���</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=5></td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;����ڵ�Ϲ�ȣ</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=5>&nbsp;
							<comment id="__NSID__"><object id=gcem_wkresino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; top:2px; width:90px; height:20px; font-family:����; font-size:9pt; "> 
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="000-00-00000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
									<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
						<td class = "tab27" style="height:25px;" bgcolor="#eeeeee">&nbsp;ȸ���</td>
						<td class = "tab28"  style="" colspan=5>&nbsp;
								<input id="txt_wknm" name="txt_wknm" type="text" class="txtbox" style= "position:relative; left:-6px; width:185px; height:18px;" maxlength=14  onkeydown="if(event.keyCode==13) ln_resino();"></td>
					</tr>
					<tr>
						<td class = "tab27" style="height:25px;" bgcolor="#eeeeee">&nbsp;�Ի�����</td>
						<td class = "tab28" style="width:80px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gcem_strtdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:0px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="width:80px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�������</td>
						<td style="width:180px ;border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gcem_enddt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:0px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
					<tr>
						<td style="height:5px;border:0 solid #708090;" colspan=6></td>
					</tr>
					<tr>
						<td class="tab31" style="height:20px; width:100px;" bgcolor="#B9D4DC"  colspan=1><nobr>&nbsp;�����ٹ��� �ҵ�</nobr></td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:0px;" colspan=5></td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;" bgcolor="#eeeeee">&nbsp;�޿��Ѿ�</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp11000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="height:25px;border:1 solid #708090;border-LEFT-width:0px;" bgcolor="#eeeeee">&nbsp;���ο���</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;;border-top-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp31000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;���Ѿ�</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp12000  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
							<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�ǰ�����</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp32000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�����󿩾�</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp13000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;���뺸��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp33000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;���ܱٷκ����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp21000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
									</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�ҵ漼</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp41000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;�߰��ٷκ����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp22000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;�ֹμ�</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp42000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						
					</tr>
					<tr>
						<td style="height:25px;border:1 solid #708090;border-top-width:0px;" bgcolor="#eeeeee">&nbsp;��Ÿ�����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp23000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee">&nbsp;��Ư��</td>
						<td style="border:1 solid #708090;border-left-width:0px;border-top-width:0px;" colspan=2><nobr>
							<comment id="__NSID__"><object id=gcem_bp43000 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:6px;top:3px; width:90px; height:20px; font-family:����; font-size:9pt;" > 
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=9>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=true>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;</nobr>
						</td>
						</tr>
					</table>
						</td>
					</tr>
				</table>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=YYYY           Ctrl=gcem_yyyy     Param=Text    </C>
		<C>Col=EMPNO         Ctrl=gcem_empno       Param=Text    </C>
		<C>Col=WKRESINO  	          Ctrl=gcem_wkresino            Param=Text    </C>
		<C>Col=WKNM                   Ctrl=txt_wknm                    Param=value</C>
		<C>Col=STRTDT2     	        Ctrl=gcem_strtdt2               Param=Text    </C>
		<C>Col=ENDDT2                Ctrl=gcem_enddt2              Param=Text    </C>
		<C>Col=BP11000               Ctrl=gcem_bp11000           Param=Text    </C>
		<C>Col=BP12000     	         Ctrl=gcem_bp12000            Param=Text    </C>
		<C>Col=BP13000               Ctrl=gcem_bp13000            Param=Text    </C>
		<C>Col=BP21000     	         Ctrl=gcem_bp21000            Param=Text    </C>
		<C>Col=BP22000               Ctrl=gcem_bp22000           Param=Text    </C>
		<C>Col=BP23000               Ctrl=gcem_bp23000           Param=Text    </C>
		<C>Col=BP31000     	         Ctrl=gcem_bp31000            Param=Text    </C>
		<C>Col=BP32000               Ctrl=gcem_bp32000           Param=Text    </C>
		<C>Col=BP33000     	         Ctrl=gcem_bp33000            Param=Text    </C>
		<C>Col=BP41000               Ctrl=gcem_bp41000           Param=Text    </C>
		<C>Col=BP42000               Ctrl=gcem_bp42000           Param=Text    </C>
		<C>Col=BP43000     	          Ctrl=gcem_bp43000            Param=Text    </C>
		<C>Col=EMPNMK                Ctrl=txt_empnmk2              Param=value</C>
		<C>Col=PAYGRD        	        Ctrl=txt_paygrd                 Param=value    </C>
		<C>Col=PAYNM        	          Ctrl=txt_paygnm                 Param=value    </C>
		<C>Col=DEPTCD                Ctrl=txt_deptcd                  Param=value</C>
		<C>Col=DEPTNM                Ctrl=txt_deptnm                  Param=value</C>
		<C>Col=STRTDT                Ctrl=gcem_strtdt                 Param=Text    </C>
		<C>Col=ENDDT        	          Ctrl=gcem_enddt                 Param=Text    </C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	


