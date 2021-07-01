<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ� (�����������û)
+ ���α׷� ID	: H030007.HTML
+ �� �� �� ��	: ��ȸ,����,����
+ �� �� �� ��	: 
+ �� �� �� ��	: h030003_s1, h030003_t1
------------------------------------------------------------------------------>
<html>
<head>
	<jsp:include page="/Payroll/common/include/head.jsp"/>
<title>����������</title>

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
//lfn_init();
var gs_empno = "";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gcem_cerdate.text = gs_date;
	gcem_fr.text = gcurdate.substring(0,7) + "01";
	gcem_to.text = gs_date;
	gcem_cerfr.text = gs_date;
	gcem_certo.text = gs_date;
	gclx_prngbn.index = 0;

	txt_gusrnm.value = gusrnm;
	txt_gusrid.value = gusrid; 

	ln_Format(0);

	gcds_dept.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1";
	gcds_dept.Reset();

	gcds_dept1.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>hcdept_s1";
	gcds_dept1.Reset();

	gcds_paygrd.DataID="<%=dirPath%><%=HDConstant.PATH_PERSON%>hclcode_s1?v_str1=2002";
	gcds_paygrd.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s1?"
									 + "v_str1=" + gcem_fr.text
									 + "&v_str2=" + gcem_to.text
									 + "&v_str3=" + gclx_prngbn.BindColVal
									 + "&v_str4=" + gusrnm
									 + "&v_str5=" + gusrid;
	gcds_data.Reset();
}

/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_Query2(){

	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s3?"
									 + "v_str1=" + gcem_fr.text
									 + "&v_str2=" + gcem_to.text
									 + "&v_str3=" + gclx_prngbn.BindColVal
									 + "&v_str4=" + gusrnm
									 + "&v_str5=" + gusrid;
	gcds_data1.Reset();

	var row = gcds_data.rowposition;
	var row1 = gcds_data1.rowposition;

	//gclx_deptcd.BindColval = gcds_data1.namevalue(row1,"PDEPT");	;
	//gclx_predept.BindColval = gcds_data1.namevalue(gcds_data1.rowposition,"PREDEPT");

	gcds_data.namevalue(row,"PAYGRD")			=  gcds_data1.namevalue(row1,"PAYGRD");			//�����ڵ�
	gcds_data.namevalue(row,"PAYGNM")			=  gcds_data1.namevalue(row1,"PAYGRDNM");		//������
	gcds_data.namevalue(row,"PREDEPT")		=  gcds_data1.namevalue(row1,"PREDEPT");		//���Ҽ��ڵ�
	//gcds_data.namevalue(row,"PAYGRDNM")		=  gcds_data1.namevalue(row1,"PREDEPT");	//���ҼӸ�
	gcds_data.namevalue(row,"DEPTCD")			=  gcds_data1.namevalue(row1,"PDEPT");			//�Ҽ��ڵ�
	//gcds_data.namevalue(row,"DEPTNM")			=  gcds_data1.namevalue(row1,"PDEPTNM");	//�ҼӸ�
	gcds_data.namevalue(row,"BIRDT")			=  gcds_data1.namevalue(row1,"BIRDT");			//�������
	gcds_data.namevalue(row,"ORDDT")			=  gcds_data1.namevalue(row1,"ORDDT");			//�߷�����
	gcds_data.namevalue(row,"CERPLC")			=  gcds_data1.namevalue(row1,"DEPTPRT");		//�߷�����

}

/******************************************************************************
	Description : �������� ��ȸ
******************************************************************************/
function ln_InfoQuery(){

	var str1 = txt_hdid.value;	//EMPNO

	
	gcds_temp.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_s4?v_str1="+str1;
	gcds_temp.Reset();

	var row  = gcds_data.rowposition;
	var temp = gcds_temp.rowposition;

/*
	gcds_data.namevalue(row,"PAYGRD")			=  gcds_temp.namevalue(temp,"PAYGRD");			//�����ڵ�
	gcds_data.namevalue(row,"PAYGNM")			=  gcds_temp.namevalue(temp,"PAYGRDNM");		//������
	gcds_data.namevalue(row,"PREDEPT")		=  gcds_temp.namevalue(temp,"PREDEPT");			//���Ҽ��ڵ�
	gcds_data.namevalue(row,"DEPTCD")			=  gcds_temp.namevalue(temp,"PDEPT");				//�Ҽ��ڵ�
	gcds_data.namevalue(row,"BIRDT")			=  gcds_temp.namevalue(temp,"BIRDT");				//�������
	gcds_data.namevalue(row,"ORDDT")			=  gcds_temp.namevalue(temp,"ORDDT");				//�߷�����
	gcds_data.namevalue(row,"JOBDTYNM")		=  gcds_temp.namevalue(temp,"ORDDT");				//��å
	gcds_data.namevalue(row,"CERPLC")			=  gcds_temp.namevalue(temp,"DEPTPRT");			//������
*/

	gcds_data.namevalue(row,"DEPTCD")     =  gcds_temp.namevalue(temp,"DEPTCD");	//�Ҽ��ڵ�
	gcds_data.namevalue(row,"PAYGRD")			=  gcds_temp.namevalue(temp,"PAYGRD");	//�����ڵ�	
	gcds_data.namevalue(row,"BIRDT")			=  gcds_temp.namevalue(temp,"BIRDT");		//�������
	gcds_data.namevalue(row,"PREDEPT")		=  gcds_temp.namevalue(temp,"PREDEPT");	//���Ҽ��ڵ�
	gcds_data.namevalue(row,"ORDDT")			=  gcds_temp.namevalue(temp,"ORDDT");		//�߷�����

}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	gcds_data.addrow();
	gcem_cerdate.text = gcurdate;

  txt_cernm.value = gusrnm ; 
  txt_hdid.value = gusrid ; 
	//txt_cerplc1.didabled = false;

	//gclx_paygrd.BindColVal = gcds_data1.namevalue(gcds_data1.rowposition,"PAYGRD");

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (gcds_data.RowStatus(gcds_data.rowposition) == 1) { 		
		if (gcds_data.countrow <1) {
			alert("�����Ͻ� ������ �����ϴ�.");
		} else {
			if (gcds_data.IsUpdated ){
				//prompt('',gcds_data.text);
				if (confirm("�ش� ������ �߱������� �����ϰڽ��ϱ� ?")) {
					gctr_data.Parameters = "v_str1=" + gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
					gctr_data.KeyValue = "Person.h030003_t1(I:USER=gcds_data)";
					gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_t1";
					gctr_data.post();
				}
			}
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	if (gcds_data.countrow <1) {
		alert("�����Ͻ� ������ �����ϴ�.");
	} else {
		row = gcds_data.rowposition;
		if (gcds_data.sysStatus(row)=="1"||gcds_data.sysStatus(row)=="2") gcds_data.undo(row);
		else if (confirm("�ش� ������ �߱������� ���� �ϰڽ��ϱ� ?")) {
			gcds_data.deleterow(row);

			gctr_data.KeyValue = "Person.h030003_t1(I:USER=gcds_data)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h030003_t1";
			gctr_data.post();
		}
	}

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : �޷���ȸ
******************************************************************************/
function ln_Callen(arg1,arg2){
	if (gcds_data.sysStatus(gcds_data.rowposition)=="1") __GetCallCalendar(arg1,arg2);
}

/******************************************************************************
	Description : �����ȸ 1
******************************************************************************/
function ln_FindEmp(e){
	if (e=="txt_nmk") ln_InfoQuery(); // ln_Find(e);
	else if (gcds_data.sysStatus(gcds_data.rowposition)=="1") ln_InfoQuery(); //ln_Find(e);
}

/******************************************************************************
	Description : �����ȸ 2
******************************************************************************/
function ln_Find(e){
	var row = gcds_data.rowposition;
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_cernm") txt_hdid.value = arrParam[1]; ln_InfoQuery(); gcds_data.namevalue(row,"DEPTNM") = arrParam[2]; gcds_data.namevalue(row,"PAYGNM") = arrParam[3];
	} else {
		eval(e).value = "";
		if (e=="txt_cernm") txt_hdid.value = "";
	}
}

/******************************************************************************
	Description : ������ �������
******************************************************************************/
function ln_Format(e){
	if (gcds_data.sysStatus(e)=="1") {
		gclx_cerkind.enable = true;
		gcem_cerdate.enable = true;
		txt_ceruse.disabled = false;
		gcem_cernum.enable = true;
		txt_ceretc.disabled = false;
		gcem_cerfr.enable = true;
		gcem_certo.enable = true;
		txt_cerplc.disabled = false;
		txt_cerplc1.disabled = false;
		txt_rcvnm.disabled = false;
		txt_jobdtynm.disabled = false;
	} else {
		gclx_cerkind.enable = false;
		gcem_cerdate.enable = false;
		txt_ceruse.disabled = true;
		gcem_cernum.enable = false;
		txt_ceretc.disabled = true;
		gcem_cerfr.enable = false;
		gcem_certo.enable = false;
		txt_cerplc.disabled = true;
		txt_cerplc1.disabled = true;
		txt_rcvnm.disabled = true;
		txt_jobdtynm.disabled = true;
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_dept1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_paygrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="onrowposchanged(row)">
	ln_Format(row);
</script>

<script language="javascript" for="gclx_cerkind" event="OnSelChange2()">
	if (gclx_cerkind.bindcolval=="3") {  //���Ա�
		div1.style.display = "none";
		div2.style.display = "";
		div3.style.display = "none";
    txt_cerplc1.value = "";

	  txt_cernm.value = gusrnm;
    txt_hdid.value= gusrid;
    ln_FindEmp('txt_cernm');

	} else if (gclx_cerkind.bindcolval =="4") { //����
		div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "";
		
		txt_rcvnm.value = "";
		gclx_deptcd.bindcolval = ""; 
		gclx_paygrd.bindcolval = "";
		gclx_predept.bindcolval = "";
		txt_jobdtynm.value = "";
		gcem_certo.text = "";
		gcem_birdt.text = "";
		txt_cerplc.value = "";

	  txt_cernm.value = gusrnm;
    txt_hdid.value= gusrid;
    ln_FindEmp('txt_cernm');

	} else {
		div1.style.display = "";
		div2.style.display = "none";
		div3.style.display = "none";
		
		gcem_cerfr.text = "";
		gcem_certo.text = "";
		//txt_cerplc.value = "";
		//txt_cerplc1.value = "";
	}
</script>

<!-- <script language ="javascript" for=txt_cerplc  event=onkeydown()>

	txt_cerplc.focus();

</script> -->




<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("��û�Ͻ� �۾��� ���������� �����Ͽ����ϴ�.");
	gcds_data.Reset();
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table border="0" cellpadding="0" cellspacing="0" width="876" >
	<tr>
    <td width="100%" height="30">
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
			  <tr> 
					<td width="197" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h030007_head.gif" width=197></td>
					<td width="100%" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
						<table border="0" width="100%" >
							<tr align="right">
								<td  valign="top">
									<img name="btn_delete" border="0" src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onClick="ln_Delete()">
									<img name="btn_insert" border="0" src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onClick="ln_Add()">
									<img name="btn_save" border="0" src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onClick="ln_Save()">
									<img name="btn_display" border="0" src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onClick="ln_Query()">
								</td>
						  </tr>
						</table>
					</td>
			  </tr>
			</table>
    </td>
	</tr>
	<tr>
    <td style="padding-left:3px;" width=100%>
			<table width="876" height=30 border="0" cellpadding="0" cellspacing="0" style='height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
	      <tr>
					<td width="80" class="tab12" bgcolor="#eeeeee">�˻�����</td>
					<td width="75">
						<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
							<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
				    </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td><img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;"></td>
					<td>~</td>
					<td width="75px">
						<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
							<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
				    </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab23"><img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;"></td>
				  <td class="tab12" bgcolor="#eeeeee" width="80" align="center">�߱�����</td>
				  <td class="tab23" width="172px;">
 						<comment id="__NSID__"><object id=gclx_prngbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:8px;top:1px;font-size:12px;width:150px;height:200px;" >
								<param name=CBData					value="^��ü,1^����������,2^���������,3^���Ա�������,4^���Ӹ��ɼ�">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^150">
								<param name=BindColumn			value="Code">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				  <td class="tab12" bgcolor="#eeeeee" width="80" height="30px;">����</td>
				  <td width="80px"><input type="text" style="width:70px" class="txt11" id=txt_gusrid disabled></td>
				  <td width="80px"><input type="text" style="width:70px" class="txt11" id=txt_gusrnm disabled></td>
					<td width="78px;">
				</tr>
			</table>
		</td>
	</tr>
  <tr>
    <td width="100%" align="left" valign="top">
	    <table border="0" cellpadding="0" cellspacing="0" width="0">
		    <tr>
          <td width="500">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr height="5"><td></td></tr>
              <tr>
								<td width="0" style="padding-left:3px;">
									<comment id="__NSID__"><object id=gcgd_disp classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
								 		width="550" height="437" style="border:1 solid #708090" >
											<param name=dataid        value="gcds_data"> 
			  							<param name=Fillarea      value="true"> 
											<param name=FontName      value='����'>
											<param name=Indwidth	    value='0'>
											<param name=FontSize      value=9 >
											<param Name=BorderStyle   value=0> 
											<param name=Format        value='
												<F>ID=EMPNO,		Name=���,				width=60,			align=center,		bgcolor=#f5f5f5, suppress=1,		HeadBgColor=#B9D4DC </F>
												<F>ID=EMPNMK,		Name=����,				width=77,			align=left,			bgcolor=#f5f5f5, suppress=1,		HeadBgColor=#B9D4DC </F>
												<F>ID=DEPTNM,		Name=�ҼӸ�,			width=100,		align=left,			bgcolor=#f5f5f5, suppress=1,		HeadBgColor=#B9D4DC ,	Editstyle=lookup, Data="gcds_dept:minorcd:minornm"</F>
												<C>ID=PAYGNM,		Name=������,			width=100,		align=left,			HeadBgColor=#B9D4DC,	Editstyle=lookup, Data="gcds_paygrd:minorcd:minornm"</C>
												<C>ID=CERDATE,	Name="�߱�����",	width=70px,		align=center,		mask="XXXX/XX/XX",							HeadBgColor=#B9D4DC </C>
												<C>ID=CERKIND,	Name="�߱�����",	width=90px,   align=left,			EditStyle=combo, data="1:����������,2:���������,3:���Ա�������,4:���Ӹ��ɼ�,6:����������",   HeadBgColor=#B9D4DC  </C>
												<C>ID=CERTINO,	Name="�߱޹�ȣ",	width=90px,		align=center,		HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERUSE,		Name="�뵵",			width=120px,	align=left,			HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERNUM,		Name="�߱޼���",	width=60px,		align=right,		HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERETC,		Name="�������",	width=238px,	align=left,			HeadBgColor=#B9D4DC	</C>																																							 
											'>
									</object></comment><script>__ws__(__NSID__);</script>
									<fieldset style="width:552px;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
										&nbsp;<font id=ft_cnt style="position:relative;top:3px;"></font>
									</fieldset>
								</td>
							</tr>
						</table>
				  </td>
          <td width=3> </td>
          <td width="321" valign=top align=left style="padding-top:3px;">
						<table border="0" cellpadding="0" cellspacing="0" width="100%" >
							<tr>
							  <td style="padding-top:2px" valign=top align=left>
									<table cellpadding="0" cellspacing="0" border="0">
										<tr> 
										  <td valign=top align=left >
												<table border="0" cellpadding="0" cellspacing="0" width="100%" style="border:0 solid #708090;">
													<tr><td colspan="2" height="30px"></td></tr>
												</table>
												<table border="0" cellpadding="0" cellspacing="0" width="100%" height=180 style="border:0 solid #708090;border-top-width:1px;border-left-width:1px;">
								  			  <tr>
												    <td class="tab11" width="70" bgcolor="#eeeeee">�߱�����</td>
														<td class="tab21" height="30">
									 						<comment id="__NSID__"><object id=gclx_cerkind classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
                  							style="position:relative;left:8px;top:0px;font-size:12px;width:150px;height:200px;">
                  								<param name=CBData					value="1^����������,2^���������,3^���Ա�������,4^���Ӹ��ɼ�,6^����������">
                  								<param name=CBDataColumns		value="Code, Parm">
                  								<param name=SearchColumn		value="Parm">
                   								<param name=Sort						value="false">
                  								<param name=ListExprFormat	value="Parm^0^150">
                  								<param name=BindColumn			value="Code">
                  						</object></comment><script>__ws__(__NSID__);</script>
                          	</td>
            						  </tr>
            						  <tr>
              							<td class="tab11" bgcolor="#eeeeee">�߱�����</td>
              							<td class="tab21" height="30px">
            									<comment id="__NSID__"><object id=gcem_cerdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
            										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
            											<param name=Alignment			value=0>
            											<param name=Border	      value=true>
            											<param name=Format	      value="YYYY/MM/DD">
            											<param name=PromptChar	  value="_">
            							    </object></comment><script>__ws__(__NSID__);</script>
	            								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Callen('gcem_cerdate', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
	            							</td>
            						  </tr>
			   		          	  <tr>
              							<td class="tab11" height="30px" bgcolor="#eeeeee">��û�ڸ�</td>
	              						<td class="tab21" >
															<input id="txt_cernm" type="text" class="txt11" style="position:relative;top:-4;width:80px;" disabled>
															<input type="hidden" width="0" id="txt_hdid">
															</td>
            						  </tr>
            						  <tr>
						              	<td class="tab11" bgcolor="#eeeeee">���뵵</td>
              							<td class="tab21" ><input type="text" class="txt11" id=txt_ceruse style="width:220px;" maxlength="30" onBlur="bytelength(this,this.value,30);"></td>
						              </tr>
            						  <tr>
						              	<td class="tab11" bgcolor="#eeeeee">��û����</td>
              							<td class="tab21" >
            									<comment id="__NSID__"><object id=gcem_cernum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
            										style="position:relative; left:8px;top:2px; width:27px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
            											<param name=Alignment			value=2>
            											<param name=Border	      value=true>
            											<param name=Maxlength     value="3">
            											<param name=PromptChar	  value="_">
																	<param name=Numeric				value="true">
            							    </object></comment><script>__ws__(__NSID__);</script>
														</td>
			 			              </tr>
          			  			  <tr>
              							<td class="tab11" bgcolor="#eeeeee">�������</td>
              							<td class="tab21" ><input type="text" id=txt_ceretc class="txt11" style="width:220px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td>
              					  </tr>
												</table>
												<div id=div1>
													<table cellpadding="0" cellspacing="0" style="border:1 solid #708090;border-top-width:0px;">
														<tr><td height="248px" width="322px;">&nbsp;</td></tr>
													</table>
												</div>
												<div id=div2 style="display:none">
													<table cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;">
	            						  <tr>
	              							<td class="tab11" width="62" bgcolor="#eeeeee">���ӱⰣ</td>
		            							<td class="tab21" height="30px">
			        									<comment id="__NSID__"><object id=gcem_cerfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				      										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
					    											<param name=Alignment			value=0>
						  											<param name=Border	      value=true>
																		<param name=Format	      value="YYYY/MM/DD">
            												<param name=PromptChar	  value="_">
            								    </object></comment><script>__ws__(__NSID__);</script>
	            									<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="ln_Callen('gcem_cerfr', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
																&nbsp;<span style="position:relative;top:-3px;">~</span>
            										<comment id="__NSID__"><object id=gcem_certo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
	            										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
		          											<param name=Alignment			value=0>
			        											<param name=Border	      value=true>
				      											<param name=Format	      value="YYYY/MM/DD">
					    											<param name=PromptChar	  value="_">
						  							    </object></comment><script>__ws__(__NSID__);</script>
							  								<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="ln_Callen('gcem_certo', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
															</td>
														</tr>
          								  <tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">������</td>
              								<td class="tab21" ><input type="text" id=txt_cerplc1 class="txt11" style="width:220px;" disabled></td>
              						  </tr>
          			  				  <tr>
												  		<td class="tab21" height="194px" width="320px;" colspan=2>&nbsp;</td>
            							  </tr>
													</table>
												</div>
												<div id=div3 style="display:none">
													<table cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;">
	            						  <tr>
															<td class="tab11" height="30px" bgcolor="#eeeeee">������</td>
              								<td class="tab21" ><input type="text" id=txt_rcvnm class="txt11" style="width:170px;" maxlength="50" onBlur="bytelength(this,this.value,50);" disabled></td>
              						  </tr>
														<tr>
															<td class="tab11" height="30px" bgcolor="#eeeeee">��  å</td>
              								<td class="tab21" ><input type="text" id=txt_jobdtynm class="txt11" style="width:170px;" maxlength="30" onBlur="bytelength(this,this.value,30);" disabled></td>
              						  </tr>
														<tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">��   ��</td>
              								<td class="tab21" >
																<comment id="__NSID__"><object id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
																	<!-- <param name=ComboDataID			value="gcds_dept">
																	<param name=SearchColumn		value=DEPTNM>
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="DEPTNM^0^150">
																	<param name=BindColumn			value=DEPTCD>
																	<param name=enable					value=false> -->
																	
																	<param name=ComboDataID			value="gcds_dept">
																	<param name=CBDataColumns		value="DEPTCD, DEPTNM">
																	<param name=SearchColumn		value=DEPTNM>
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="DEPTNM^0^150">
																	<param name=BindColumn			value=DEPTCD>
																	<param name=enable					value=false>
																	
															</object></comment><script>__ws__(__NSID__);</script>
															</td>
														</tr>
														<tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">��   ��</td>
              								<td class="tab21" >
																<comment id="__NSID__"><object id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
																	<!-- <param name=ComboDataID			value="gcds_paygrd">
																	<param name=SearchColumn		value="PAYGNM">
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="PAYGNM^0^150">
																	<param name=BindColumn			value="PAYGRD">
																	<param name=enable					value=false> -->
																	<param name=ComboDataID			value="gcds_paygrd">
																	<param name=CBDataColumns		value="MINORCD, MINORNM">
																	<param name=SearchColumn		value="MINORNM">
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="MINORNM^0^150">
																	<param name=BindColumn			value="MINORCD">
																	<param name=enable					value=false>
															</object></comment><script>__ws__(__NSID__);</script>
															</td>
														</tr>
														<tr>
														 <td class="tab11" height="30px" bgcolor="#eeeeee">�������</td>
															<td class="tab21" width="75px">
																<comment id="__NSID__"><object id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
																	style="position:relative; left:8px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " class=objclsEme1>
																		<param name=Alignment			value=0>
																		<param name=Border	      value=true>
																		<param name=Format	      value="YYYY/MM/DD">
																		<param name=PromptChar	  value="_">
																		<param name=Enable				value="false">
															</object></comment><script>__ws__(__NSID__);</script>
															</td>
														</tr>
														<tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">���Ҽ�</td>
              								<td class="tab21" >
																<comment id="__NSID__"><object id=gclx_predept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:8px;top:1px;font-size:12px;width:160px;">
																	<param name=ComboDataID			value="gcds_dept1">
																	<param name=CBDataColumns		value="DEPTCD, DEPTNM">
																	<param name=SearchColumn		value=DEPTNM>
																	<param name=Sort						value=false>
																	<param name=ListExprFormat	value="DEPTNM^0^150">
																	<param name=BindColumn			value=DEPTCD>
																	<param name=enable					value=false>
															</object></comment><script>__ws__(__NSID__);</script>
															</td>
														</tr>
														<tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">������</td>
              								<td class="tab21" ><input type="text" id=txt_cerplc class="txt11" style="width:170px" maxlength="50" onBlur="bytelength(this,this.value,50)" disabled></td>
              						  </tr>
														<tr>
	              							<td class="tab11" height="30px" bgcolor="#eeeeee">�߷�����</td>
		            							<td class="tab21" height="30px">
			        									<comment id="__NSID__"><object id=gcem_orddt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				      										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
					    											<param name=Alignment			value=0>
						  											<param name=Border	      value=true>
																		<param name=Format	      value="YYYY/MM/DD">
            												<param name=PromptChar	  value="_">
																		<param name=enable					value=false>
            								    </object></comment><script>__ws__(__NSID__);</script>
	            									<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="ln_Callen('gcem_orddt', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;"> -->
															</td>
														</tr>
														<tr>
												  		<td class="tab21" height="44px" width="320px;" colspan=2>&nbsp;</td>
            							  </tr>
													</table>
												</div>
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

<comment id="__NSID__"><OBJECT id=gcbn_data  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
  <PARAM NAME="DataID" VALUE="gcds_data">
  <PARAM NAME="BindInfo" VALUE="
		<C>Col=CERKIND	Ctrl=gclx_cerkind   Param=BindColVal</C>
		<C>Col=CERDATE	Ctrl=gcem_cerdate		Param=Text</C>
		<C>Col=EMPNMK		Ctrl=txt_cernm			Param=value</C>
		<C>Col=EMPNO		Ctrl=txt_hdid				Param=value</C>
		<C>Col=CERUSE		Ctrl=txt_ceruse     Param=value</C>
		<C>Col=CERNUM		Ctrl=gcem_cernum    Param=Text</C>
		<C>Col=CERETC		Ctrl=txt_ceretc     Param=value</C>
		<C>Col=CERPLC		Ctrl=txt_cerplc     Param=value</C>
		<C>Col=CERPLC		Ctrl=txt_cerplc1    Param=value</C>
		<C>Col=CERFR		Ctrl=gcem_cerfr     Param=Text</C>
		<C>Col=CERTO		Ctrl=gcem_certo     Param=Text</C>

		<C>Col=RCVNM		Ctrl=txt_rcvnm			Param=Value</C>
		<C>Col=DEPTCD		Ctrl=gclx_deptcd    Param=BindColVal</C>
		<C>Col=PAYGRD		Ctrl=gclx_paygrd    Param=BindColVal</C>
		<C>Col=PREDEPT	Ctrl=gclx_predept   Param=BindColVal</C>
		<C>Col=JOBDTYNM	Ctrl=txt_jobdtynm   Param=Value</C>
		<C>Col=ORDDT		Ctrl=gcem_certo     Param=Text</C>
		<C>Col=ORDDT		Ctrl=gcem_orddt     Param=Text</C>
		<C>Col=BIRDT		Ctrl=gcem_birdt     Param=Text</C>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>



</BODY>
</HTML>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>