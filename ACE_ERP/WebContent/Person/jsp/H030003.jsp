<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: H030003.HTML
+ �� �� �� ��	: ��ȸ,����,����,���
+ �� �� �� ��	: 
+ �� �� �� ��	: h030003_s1, h030003_t1
------------------------------------------------------------------------------>

<html>
<head>
	<jsp:include page="/Sales/common/include/head.jsp"/>
<title>��������</title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
lfn_init();
var gs_empno = "";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gcem_cerdate.text = gs_date;
	gcem_fr.text			= gcurdate.substring(0,7) + "01";
	gcem_to.text			= gs_date;
	gcem_cerfr.text		= gs_date;
	gcem_certo.text		= gs_date;
	gclx_prngbn.index = 0;

	ln_Format(0);

	gcds_dept.DataID="/servlet/Person.hcdept_s1";
	gcds_dept.Reset();

	gcds_dept1.DataID="/servlet/Person.hcdept_s1";
	gcds_dept1.Reset();

	gcds_paygrd.DataID="/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_paygrd.Reset();

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	gcds_data.DataID = "/servlet/Person.h030003_s1?"
									 + "v_str1=" + gcem_fr.text
									 + "&v_str2=" + gcem_to.text
									 + "&v_str3=" + gclx_prngbn.BindColVal
									 + "&v_str4=" + txt_nmk.value
									 + "&v_str5=" + txt_hdid.value;
	gcds_data.Reset();
}

/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_Query2(){

	gcds_data1.DataID = "/servlet/Person.h030003_s3?"
									 + "v_str1=" + gcem_fr.text
									 + "&v_str2=" + gcem_to.text
									 + "&v_str3=" + gclx_prngbn.BindColVal
									 + "&v_str4=" + txt_nmk.value
									 + "&v_str5=" + txt_hdid.value;
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
	
	gcds_temp.DataID = "/servlet/Person.h030003_s4?v_str1="+str1;
	gcds_temp.Reset();

	var row  = gcds_data.rowposition;
	var temp = gcds_temp.rowposition;

  if (gclx_cerkind.bindcolval =="4") { //����
		gcds_data.namevalue(row,"DEPTCD")     =  gcds_temp.namevalue(temp,"DEPTCD");	//�Ҽ��ڵ�
		gcds_data.namevalue(row,"PAYGRD")			=  gcds_temp.namevalue(temp,"PAYGRD");	//�����ڵ�	
		gcds_data.namevalue(row,"BIRDT")			=  gcds_temp.namevalue(temp,"BIRDT");		//�������
		gcds_data.namevalue(row,"PREDEPT")		=  gcds_temp.namevalue(temp,"PREDEPT");	//���Ҽ��ڵ�
		gcds_data.namevalue(row,"ORDDT")			=  gcds_temp.namevalue(temp,"ORDDT");		//�߷�����
	}
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();
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
				if (confirm("�ش� ���� �߱������� �����ϰڽ��ϱ� ?")) {
					//prompt('',gcds_data.text);
					gctr_data.Parameters = "v_str1=" + gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
					gctr_data.KeyValue = "Person.h030003_t1(I:USER=gcds_data)";
					gctr_data.Action = "/servlet/Person.h030003_t1";
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
		else if (confirm("�ش� ���� �߱������� ���� �ϰڽ��ϱ� ?")) {
			gcds_data.deleterow(row);
			gctr_data.KeyValue = "Person.h030003_t1(I:USER=gcds_data)";
			gctr_data.Action = "/servlet/Person.h030003_t1";
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
	Description : ���
******************************************************************************/
function ln_Print(){

	var	row = gcds_data.rowposition;
	if (gcds_data.countrow<1) alert("����Ͻ� �ڷᰡ �����ϴ�");
	else if (gcds_data.sysStatus(row)=="1") alert("���� ����� ����Ҽ� �ֽ��ϴ�.");
	else {
		var ls_ehtml = "";

		ls_ehtml += "EMPNO:STRING(7),EMPNMK:STRING(20),PAYGNM:STRING(30),DEPTNM:STRING(30),CERTINO:STRING(8),";
		ls_ehtml += "CERDATE:STRING(8),CERKIND:STRING(1),CERUSE:STRING(30),CERNUM:DECIMAL(3.0),CERETC:STRING(100),";
		ls_ehtml += "OADDR:STRING(200),CADDR:STRING(200),RESINO:STRING(13),STRTDT:STRING(8),ENDDT:STRING(8),";
		ls_ehtml += "CURDT:STRING(8),CERPLC:STRING(50),CERFR:STRING(8),CERTO:STRING(8),CERDAT:STRING(16),";
		ls_ehtml += "DEPTCD:STRING(4),PAYGRD:STRING(4),PREDEPT:STRING(4),JOBDTYNM:STRING(30),ORDDT:STRING(8),";
		ls_ehtml += "RCVNM:STRING(50),BIRDT:STRING(8)";
               
		gcds_print.SetDataHeader(ls_ehtml);

		gcds_print.addrow();

		for (var i=1;i<=gcds_data.countcolumn;i++){
			gcds_print.namevalue(1,gcds_data.columnid(i)) = gcds_data.namevalue(row,gcds_data.columnid(i));
			//gcds_print.namevalue(1,gcds_data.columnid(i)) = gcds_data.namevalue(row,gcds_data.columnid(i));
				if (i =='26') {
					gcds_print.namevalue(1,gcds_data.columnid(i)) = gcds_data.namevalue(row,"RCVNM");
				}			
		}
			 gcds_print.namevalue(1,"CURDT") = gs_date;
//      gcds_print.namevalue(1,"CURDT") = '20090213';
		if (fn_trim(gcds_print.namevalue(1,"ENDDT"))=="") gcds_print.namevalue(1,"ENDDT") = " ";

		if (gcds_data.namevalue(row,"CERKIND")=="1") gcrp_print2.preview();				//��������
		else if (gcds_data.namevalue(row,"CERKIND")=="2") gcrp_print1.preview();	//�������
		else if (gcds_data.namevalue(row,"CERKIND")=="3") gcrp_print3.preview();	//���Ա�����
		else if (gcds_data.namevalue(row,"CERKIND")=="4") gcrp_print4.preview();	//���Ӹ�ɼ�
		else if (gcds_data.namevalue(row,"CERKIND")=="5") gcrp_print5.preview();	//�ͱ�����
    else if (gcds_data.namevalue(row,"CERKIND")=="6") gcrp_print6.preview();	//�ͱ�����
	}
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
	if (e=="txt_nmk") ln_Find(e);
	else if (gcds_data.sysStatus(gcds_data.rowposition)=="1") ln_Find(e);
}

/******************************************************************************
	Description : �����ȸ 2
******************************************************************************/
function ln_Find(e){
	var row = gcds_data.rowposition;
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	var arrSend	= new Array();
	arrSend[0]='H030003';
	window.dialogArguments=arrSend[0];

	strURL = "./H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:363px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

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
	if (gcds_data.sysStatus(e)=="1") {	//���
		gclx_cerkind.enable		= true;
		gcem_cerdate.enable		= true;
		txt_ceruse.disabled		= false;
		gcem_cernum.enable		= true;
		txt_ceretc.disabled		= false;
		gcem_cerfr.enable			= true;
		gcem_certo.enable			= true;
		txt_cerplc.disabled		= false;
		txt_cerplc1.disabled	= false;
		txt_rcvnm.disabled		= false;
		txt_jobdtynm.disabled = false;

		gcem_cerdt4.enable		= true;
		txt_cerplc4.disabled	= false;
		gcem_cerdate.text = gs_date;
	} else {
		gclx_cerkind.enable		= false;
		gcem_cerdate.enable		= false;
		txt_ceruse.disabled		= true;
		gcem_cernum.enable		= false;
		txt_ceretc.disabled		= true;
		gcem_cerfr.enable			= false;
		gcem_certo.enable			= false;
		txt_cerplc.disabled		= true;
		txt_cerplc1.disabled	= true;
		txt_rcvnm.disabled		= true;
		txt_jobdtynm.disabled = true;

		gcem_cerdt4.enable		= false;
		txt_cerplc4.disabled	= true;
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
		div4.style.display = "none";

		txt_cerplc1.value = "";
	} else if (gclx_cerkind.bindcolval =="4") { //����
		div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "";
		div4.style.display = "none";
		
		txt_rcvnm.value = "";
		gclx_deptcd.bindcolval = ""; 
		gclx_paygrd.bindcolval = "";
		gclx_predept.bindcolval = "";
		txt_jobdtynm.value = "";
		gcem_certo.text = "";
		gcem_birdt.text = "";
		txt_cerplc.value = "";
	} else if (gclx_cerkind.bindcolval =="5") { //�ͱ�
		div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "";

		txt_cerplc4.value = "";
		gcem_cerdt4.text = gs_date;
	} else {
		div1.style.display = "";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "none";
		
		gcem_cerfr.text = "";
		gcem_certo.text = "";
		//txt_cerplc.value = "";
		//txt_cerplc1.value = "";
	}
</script>

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
					<td width="197" background="../../Common/img/com_t_bg.gif"><IMG height=47 src="../img/h030003_head.gif" width=197></td>
					<td width="100%" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
						<table border="0" width="100%" >
							<tr align="right">
								<td  valign="top">
									<img name="btn_print" border="0" src="../../Common/img/btn/com_b_print.gif" style="cursor:hand" onClick="ln_Print()">
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
								<param name=CBData					value="^��ü,1^��������,2^�������,3^���Ա�����,4^���Ӹ�ɼ�,5^�ͱ�����">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^150">
								<param name=BindColumn			value="Code">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				  <td class="tab12" bgcolor="#eeeeee" width="80" height="30px;">����</td>
				  <td width="80px"><input type="text" style="width:70px" class="txt11" id=txt_nmk></td>
				  <td width="158px;"><img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:3px;cursor:hand;" onclick="ln_FindEmp('txt_nmk')" ></td>
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
												<C>ID=CERKIND,	Name="�߱�����",	width=90px,   align=left,			EditStyle=combo, data="1:��������,2:�������,3:���Ա�����,4:���Ӹ�ɼ�,5:�ͱ�����,6:��������",   HeadBgColor=#B9D4DC  </C>
												<C>ID=CERTINO,	Name="�߱޹�ȣ",	width=90px,		align=center,		HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERUSE,		Name="�뵵",			width=120px,	align=left,			HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERNUM,		Name="�߱޼���",	width=60px,		align=right,		HeadBgColor=#B9D4DC	</C>																																							 
												<C>ID=CERETC,		Name="������",	width=238px,	align=left,			HeadBgColor=#B9D4DC	</C>																																							 
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
                  								<param name=CBData					value="1^��������,2^�������,3^���Ա�����,4^���Ӹ�ɼ�,5^�ͱ�����,6^��������">
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
															<img src="../../Common/img/btn/com_b_find.gif" border="0" alt="������ �˻��մϴ�" style="position:relative;top:2px;left:6px;cursor:hand;" onclick="ln_FindEmp('txt_cernm')"></td>
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
              							<td class="tab11" bgcolor="#eeeeee">������</td>
              							<td class="tab21" ><input type="text" id=txt_ceretc class="txt11" style="width:220px;" maxlength="100" onBlur="bytelength(this,this.value,100);"></td>
              					  </tr>
												</table>
												<div id=div1>
													<table cellpadding="0" cellspacing="0" style="border:1 solid #708090;border-top-width:0px;">
														<tr><td height="248px" width="322px;">&nbsp;</td></tr>
													</table>
												</div>

												<div id=div2 style="display:none"><!-- ���Ա����� -->
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

												<div id=div3 style="display:none"><!-- �������� -->
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

												<div id=div4 style="display:none"><!-- �ͱ����� -->
													<table cellpadding="0" cellspacing="0" style="border:0 solid #708090;border-left-width:1px;">
	            						  <tr>
	              							<td class="tab11" width="62" bgcolor="#eeeeee">�ͱ���</td>
		            							<td class="tab21" height="30px">
			        									<comment id="__NSID__"><object id=gcem_cerdt4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
				      										style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
					    											<param name=Alignment			value=0>
						  											<param name=Border	      value=true>
																		<param name=Format	      value="YYYY/MM/DD">
            												<param name=PromptChar	  value="_">
            								    </object></comment><script>__ws__(__NSID__);</script>
	            									<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="ln_Callen('gcem_cerdt4', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
															</td>
														</tr>
          								  <tr>
              								<td class="tab11" height="30px" bgcolor="#eeeeee">������</td>
              								<td class="tab21" ><input type="text" id=txt_cerplc4 class="txt11" style="width:220px;"></td>
              						  </tr>
          			  				  <tr>
												  		<td class="tab21" height="194px" width="320px;" colspan=2>&nbsp;</td>
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

		<C>Col=ORDDT		Ctrl=gcem_cerdt4    Param=Text</C>
		<C>Col=CERPLC		Ctrl=txt_cerplc4    Param=value</C>
	"> 
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------------------
��¹� ���Ǻκ�
--------------------------------------------------------------------------------------->
<comment id="__NSID__"><object id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2001 ,bottom=2729 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=740 ,top=2613 ,right=1219 ,bottom=2713</I>
	<X>left=37 ,top=269 ,right=1943 ,bottom=2605 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=37 ,top=2136 ,right=363 ,bottom=2605 ,border=true</X>
	<X>left=37 ,top=1303 ,right=1943 ,bottom=1474 ,border=true</X>
	<X>left=37 ,top=1131 ,right=1943 ,bottom=1305 ,border=true</X>
	<X>left=37 ,top=962 ,right=1943 ,bottom=1134 ,border=true</X>
	<X>left=37 ,top=794 ,right=1943 ,bottom=965 ,border=true</X>
	<X>left=37 ,top=456 ,right=1943 ,bottom=628 ,border=true</X>
	<X>left=37 ,top=625 ,right=1943 ,bottom=796 ,border=true</X>
	<L> left=37 ,top=269 ,right=37 ,bottom=2602 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=269 ,right=1940 ,bottom=269 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=42 ,top=2605 ,right=1940 ,bottom=2605 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1943 ,top=269 ,right=1943 ,bottom=2602 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=321 ,top=272 ,right=321 ,bottom=1471 </L>
	<L> left=985 ,top=625 ,right=985 ,bottom=962 </L>
	<L> left=1274 ,top=628 ,right=1274 ,bottom=965 </L>
	<L> left=1274 ,top=1134 ,right=1274 ,bottom=1303 </L>
	<L> left=985 ,top=1131 ,right=985 ,bottom=1303 </L>
	<L> left=37 ,top=269 ,right=37 ,bottom=2605 </L>
	<L> left=1940 ,top=269 ,right=1940 ,bottom=2605 </L>
	<L> left=118 ,top=2228 ,right=118 ,bottom=2605 </L>
	<L> left=42 ,top=2415 ,right=358 ,bottom=2415 </L>
	<L> left=37 ,top=2225 ,right=355 ,bottom=2225 </L>
	<C>id='CERTINO', left=37, top=190, right=600, bottom=256, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=345, top=675, right=974, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAYGNM', left=1293, top=675, right=1925, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CERUSE', left=345, top=1018, right=1922, bottom=1084, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNMK', left=345, top=844, right=974, bottom=910, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CERETC', left=345, top=1353, right=1922, bottom=1419, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='STRTDT', left=345, top=1184, right=974, bottom=1250, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=1319, top=1975, right=1819, bottom=2043, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CADDR', left=345, top=509, right=1922, bottom=575, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='OADDR', left=345, top=335, right=1922, bottom=401, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='RESINO', left=1293, top=844, right=1925, bottom=910, align='left' ,mask='XXXXXX - XXXXXXX', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENDDT', left=42, top=1503, right=1938, bottom=1569 ,mask='����ڴ� XXXX�� XX�� XX�Ϻη� ��� �����Ͽ����� ������.', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=695 ,top=198 ,right=1290 ,bottom=198 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='�� �� �� �� ��' ,left=24 ,top=42 ,right=1959 ,bottom=187 ,face='HY�߰��' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=987 ,top=675 ,right=1274 ,bottom=741 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹε�Ϲ�ȣ' ,left=987 ,top=844 ,right=1274 ,bottom=910 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENDDT', left=1293, top=1184, right=1925, bottom=1250, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=987 ,top=1184 ,right=1274 ,bottom=1250 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ   ��' ,left=63 ,top=2149 ,right=334 ,bottom=2215 ,face='����' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=45 ,top=2436 ,right=118 ,bottom=2497 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=45 ,top=2529 ,right=118 ,bottom=2587 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=45 ,top=2352 ,right=118 ,bottom=2405 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=45 ,top=2297 ,right=118 ,bottom=2347 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ' ,left=45 ,top=2236 ,right=118 ,bottom=2291 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../Common/img/new_attampt1.jpg' ,left=1135 ,top=2207 ,right=1864 ,bottom=2502</I>
	<T>id='��     ��' ,left=45 ,top=327 ,right=319 ,bottom=393 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=45 ,top=504 ,right=319 ,bottom=570 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=45 ,top=670 ,right=319 ,bottom=733 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=45 ,top=836 ,right=319 ,bottom=902 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=45 ,top=1012 ,right=319 ,bottom=1078 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=45 ,top=1179 ,right=319 ,bottom=1245 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��     ��' ,left=45 ,top=1347 ,right=319 ,bottom=1413 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2756 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=319 ,right=1944 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2187 ,right=363 ,bottom=2656 ,border=true</X>
		<X>left=38 ,top=1353 ,right=1944 ,bottom=1525 ,border=true</X>
		<X>left=38 ,top=1012 ,right=1944 ,bottom=1184 ,border=true</X>
		<X>left=38 ,top=844 ,right=1944 ,bottom=1016 ,border=true</X>
		<X>left=38 ,top=675 ,right=1944 ,bottom=847 ,border=true</X>
		<X>left=38 ,top=506 ,right=1944 ,bottom=678 ,border=true</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1219 ,bottom=2756</I>
		<L> left=694 ,top=247 ,right=1291 ,bottom=247 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=319 ,right=1941 ,bottom=319 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2656 ,right=1941 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=319 ,right=1944 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2656 </L>
		<L> left=1941 ,top=319 ,right=1941 ,bottom=2656 </L>
		<L> left=322 ,top=322 ,right=322 ,bottom=1522 </L>
		<L> left=984 ,top=675 ,right=984 ,bottom=1012 </L>
		<L> left=1309 ,top=678 ,right=1309 ,bottom=1016 </L>
		<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
		<L> left=41 ,top=2466 ,right=359 ,bottom=2466 </L>
		<L> left=38 ,top=2275 ,right=363 ,bottom=2275 </L>
		<C>id='OADDR', left=344, top=384, right=1922, bottom=450, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CADDR', left=344, top=559, right=1922, bottom=625, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTNM', left=344, top=725, right=975, bottom=791, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=344, top=894, right=975, bottom=959, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERUSE', left=344, top=1069, right=1922, bottom=1134, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STRTDT', left=344, top=1234, right=975, bottom=1300, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERETC', left=344, top=1403, right=1922, bottom=1469, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=1319, top=2025, right=1819, bottom=2094, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERTINO', left=38, top=241, right=600, bottom=306, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='�� �� �� �� ��' ,left=25 ,top=91 ,right=1959 ,bottom=237 ,face='HY�߰��' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=994 ,top=894 ,right=1306 ,bottom=959 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=994 ,top=725 ,right=1306 ,bottom=791 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2200 ,right=334 ,bottom=2266 ,face='����' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2487 ,right=119 ,bottom=2547 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2578 ,right=119 ,bottom=2637 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2403 ,right=119 ,bottom=2456 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2347 ,right=119 ,bottom=2397 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2287 ,right=119 ,bottom=2341 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../Common/img/new_attampt1.jpg' ,left=1134 ,top=2256 ,right=1863 ,bottom=2553</I>
		<T>id='��     ��' ,left=47 ,top=378 ,right=316 ,bottom=444 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=553 ,right=316 ,bottom=619 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=719 ,right=316 ,bottom=784 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=887 ,right=316 ,bottom=953 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1062 ,right=316 ,bottom=1128 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=47 ,top=1228 ,right=316 ,bottom=1294 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1397 ,right=316 ,bottom=1462 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='PAYGNM', left=1334, top=725, right=1925, bottom=791, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RESINO', left=1334, top=894, right=1925, bottom=959, align='left' ,mask='XXXXXX - XXXXXXX', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STRTDT', left=344, top=1547, right=1934, bottom=1644, align='left' ,mask='����ڴ� XXXX�� XX�� XX�Ϻ��� ��翡 �����ϰ� ������ ������.', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	</B>
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2756 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=319 ,right=1944 ,bottom=2656 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2187 ,right=363 ,bottom=2656 ,border=true</X>
		<X>left=38 ,top=1353 ,right=1944 ,bottom=1525 ,border=true</X>
		<X>left=38 ,top=1012 ,right=1944 ,bottom=1184 ,border=true</X>
		<X>left=38 ,top=844 ,right=1944 ,bottom=1016 ,border=true</X>
		<X>left=38 ,top=675 ,right=1944 ,bottom=847 ,border=true</X>
		<X>left=38 ,top=506 ,right=1944 ,bottom=678 ,border=true</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2656 ,right=1219 ,bottom=2753</I>
		<L> left=38 ,top=319 ,right=38 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=319 ,right=1941 ,bottom=319 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2656 ,right=1941 ,bottom=2656 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=319 ,right=1944 ,bottom=2653 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=319 ,right=38 ,bottom=2656 </L>
		<L> left=1941 ,top=319 ,right=1941 ,bottom=2656 </L>
		<L> left=322 ,top=322 ,right=322 ,bottom=1522 </L>
		<L> left=984 ,top=675 ,right=984 ,bottom=1012 </L>
		<L> left=1309 ,top=678 ,right=1309 ,bottom=1016 </L>
		<L> left=119 ,top=2278 ,right=119 ,bottom=2656 </L>
		<L> left=41 ,top=2466 ,right=359 ,bottom=2466 </L>
		<L> left=38 ,top=2275 ,right=363 ,bottom=2275 </L>
		<C>id='OADDR', left=344, top=384, right=1922, bottom=450, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CADDR', left=344, top=559, right=1922, bottom=625, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTNM', left=344, top=725, right=975, bottom=791, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=344, top=894, right=975, bottom=959, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STRTDT', left=344, top=1234, right=975, bottom=1300, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERETC', left=344, top=1403, right=1922, bottom=1469, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=1319, top=2025, right=1819, bottom=2094, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERDAT', left=344, top=1234, right=1225, bottom=1300, align='left' ,mask='XXXX�� XX�� XX�� ~ XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERUSE', left=344, top=1403, right=1922, bottom=1469, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERTINO', left=38, top=241, right=506, bottom=306, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='�� �� (Ȯ��) �� �� ��' ,left=25 ,top=91 ,right=1959 ,bottom=237 ,face='HY�߰��' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=994 ,top=894 ,right=1306 ,bottom=959 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=994 ,top=725 ,right=1306 ,bottom=791 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2200 ,right=334 ,bottom=2266 ,face='����' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2487 ,right=119 ,bottom=2547 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2578 ,right=119 ,bottom=2637 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2403 ,right=119 ,bottom=2456 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2347 ,right=119 ,bottom=2397 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2287 ,right=119 ,bottom=2341 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../Common/img/new_attampt1.jpg' ,left=1134 ,top=2256 ,right=1863 ,bottom=2553</I>
		<T>id='��     ��' ,left=47 ,top=378 ,right=316 ,bottom=444 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=553 ,right=316 ,bottom=619 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=719 ,right=316 ,bottom=784 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=887 ,right=316 ,bottom=953 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=47 ,top=1062 ,right=316 ,bottom=1128 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���ӱⰣ' ,left=47 ,top=1228 ,right=316 ,bottom=1294 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=47 ,top=1397 ,right=316 ,bottom=1462 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='PAYGNM', left=1334, top=725, right=1925, bottom=791, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RESINO', left=1334, top=894, right=1925, bottom=959, align='left' ,mask='XXXXXX - XXXXXXX', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STRTDT', left=344, top=1547, right=1934, bottom=1644, align='left' ,mask='���� ���� �ⱹ �Ͽ����� ������.', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
		<L> left=538 ,top=241 ,right=1438 ,bottom=241 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<C>id='CERPLC', left=344, top=1062, right=1922, bottom=1128, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print4 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2731 ,face='Arial' ,size=10 ,penwidth=1
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2612 ,right=1219 ,bottom=2716</I>
		<X>left=38 ,top=78 ,right=1944 ,bottom=2606 ,border=true</X>
		<X>left=38 ,top=919 ,right=388 ,bottom=1819 ,border=true</X>
		<X>left=1038 ,top=919 ,right=1384 ,bottom=1212 ,border=true</X>
		<L> left=41 ,top=2606 ,right=1941 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=78 ,right=38 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=78 ,right=1944 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=919 ,right=1941 ,bottom=919 </L>
		<L> left=38 ,top=1066 ,right=1941 ,bottom=1066 </L>
		<L> left=38 ,top=1212 ,right=1941 ,bottom=1212 </L>
		<L> left=38 ,top=1369 ,right=1941 ,bottom=1369 </L>
		<L> left=38 ,top=1516 ,right=1941 ,bottom=1516 </L>
		<L> left=38 ,top=1666 ,right=1941 ,bottom=1666 </L>
		<L> left=1038 ,top=919 ,right=1038 ,bottom=1212 </L>
		<L> left=38 ,top=1819 ,right=1941 ,bottom=1819 </L>
		<T>id='�� �� �� �� ��' ,left=44 ,top=200 ,right=1938 ,bottom=337 ,face='HY�߰��' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� �� �� �� ��' ,left=44 ,top=2200 ,right=1806 ,bottom=2269 ,align='right' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� ��   ��  ��  ��' ,left=44 ,top=2281 ,right=1806 ,bottom=2350 ,align='right' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�߷�����' ,left=44 ,top=1672 ,right=381 ,bottom=1812 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='��     ��' ,left=1044 ,top=925 ,right=1378 ,bottom=1062 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='(������) - ' ,left=138 ,top=100 ,right=369 ,bottom=197 ,align='left' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     �� : ' ,left=138 ,top=612 ,right=403 ,bottom=709 ,align='left' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     �� : ' ,left=138 ,top=716 ,right=403 ,bottom=819 ,align='left' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=925 ,right=381 ,bottom=1062 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='��     ��' ,left=44 ,top=1072 ,right=381 ,bottom=1209 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='�� �� ��' ,left=44 ,top=1219 ,right=381 ,bottom=1366 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='�� �� ��' ,left=44 ,top=1375 ,right=381 ,bottom=1512 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='��     å' ,left=44 ,top=1522 ,right=381 ,bottom=1662 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<T>id='�������' ,left=1044 ,top=1072 ,right=1378 ,bottom=1203 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
		<C>id='CERPLC', left=381, top=119, right=756, bottom=184, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERTINO', left=138, top=503, right=600, bottom=603, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PAYGNM', left=1428, top=950, right=1856, bottom=1016, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTNM', left=428, top=959, right=997, bottom=1025, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=428, top=1106, right=813, bottom=1172, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='BIRDT', left=1428, top=1106, right=1853, bottom=1172, align='left' ,mask='XXXX��XX��XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTPRE', left=428, top=1253, right=809, bottom=1319, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERPLC', left=428, top=1416, right=1878, bottom=1481, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=44, top=2050, right=1806, bottom=2150, align='right' ,mask='XXXX�� XX�� XX��', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERETC', left=416, top=716, right=1853, bottom=819, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RCVNM', left=416, top=612, right=1850, bottom=709, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=41 ,top=78 ,right=1941 ,bottom=78 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<C>id='ORDDT', left=428, top=1709, right=1878, bottom=1775, align='left' ,mask='XXXX��XX��XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='����  ����  ������  ����' ,left=428 ,top=1850 ,right=1878 ,bottom=1950 ,align='left' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='JOBDTYNM', left=428, top=1569, right=1878, bottom=1634, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	</B>
	">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id=gcrp_print5 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2731 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=38 ,top=269 ,right=1944 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2612 ,right=1219 ,bottom=2716</I>
		<X>left=38 ,top=2137 ,right=363 ,bottom=2606 ,border=true</X>
		<X>left=38 ,top=1303 ,right=1944 ,bottom=1475 ,border=true</X>
		<X>left=38 ,top=962 ,right=1944 ,bottom=1134 ,border=true</X>
		<X>left=38 ,top=794 ,right=1944 ,bottom=966 ,border=true</X>
		<X>left=38 ,top=625 ,right=1944 ,bottom=797 ,border=true</X>
		<X>left=38 ,top=456 ,right=1944 ,bottom=628 ,border=true</X>
		<L> left=588 ,top=197 ,right=1397 ,bottom=197 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=269 ,right=38 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=269 ,right=1941 ,bottom=269 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2606 ,right=1941 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1941 ,top=269 ,right=1941 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=38 ,top=269 ,right=38 ,bottom=2606 </L>
		<L> left=1941 ,top=269 ,right=1941 ,bottom=2606 </L>
		<L> left=322 ,top=272 ,right=322 ,bottom=1472 </L>
		<L> left=984 ,top=625 ,right=984 ,bottom=962 </L>
		<L> left=1275 ,top=628 ,right=1275 ,bottom=966 </L>
		<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
		<L> left=41 ,top=2416 ,right=359 ,bottom=2416 </L>
		<L> left=38 ,top=2225 ,right=359 ,bottom=2225 </L>
		<T>id='��   ��' ,left=988 ,top=675 ,right=1275 ,bottom=741 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=988 ,top=844 ,right=1275 ,bottom=909 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� (Ȯ��) ����' ,left=25 ,top=41 ,right=1959 ,bottom=187 ,face='HY�߰��' ,size=26 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2150 ,right=334 ,bottom=2216 ,face='����' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2437 ,right=119 ,bottom=2497 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2528 ,right=119 ,bottom=2587 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2353 ,right=119 ,bottom=2406 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2297 ,right=119 ,bottom=2347 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2237 ,right=119 ,bottom=2291 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='DEPTNM', left=344, top=675, right=975, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PAYGNM', left=1294, top=675, right=1925, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=344, top=844, right=975, bottom=909, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ORDDT', left=344, top=1184, right=1213, bottom=1250, align='left' ,mask='XXXX�� XX�� XX��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERUSE', left=344, top=1353, right=1922, bottom=1419, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=1319, top=1975, right=1819, bottom=2044, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CADDR', left=344, top=509, right=1922, bottom=575, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='OADDR', left=344, top=334, right=1922, bottom=400, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RESINO', left=1294, top=844, right=1925, bottom=909, align='left' ,mask='XXXXXX - XXXXXXX', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERPLC', left=344, top=1019, right=1922, bottom=1084, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERTINO', left=38, top=191, right=578, bottom=256, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<I>id='../../Common/img/new_attampt1.jpg' ,left=1134 ,top=2206 ,right=1863 ,bottom=2503</I>
		<T>id='��     ��' ,left=44 ,top=328 ,right=319 ,bottom=394 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=503 ,right=319 ,bottom=569 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=669 ,right=319 ,bottom=734 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=837 ,right=319 ,bottom=903 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=44 ,top=1012 ,right=319 ,bottom=1078 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=44 ,top=1178 ,right=319 ,bottom=1244 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=1347 ,right=319 ,bottom=1412 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='���� ���� �ͱ� �Ͽ����� ������.' ,left=344 ,top=1503 ,right=1922 ,bottom=1569 ,align='left' ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	</B>
	">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object id=gcrp_print6 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
  <PARAM NAME="MasterDataID"			VALUE="gcds_print">
  <PARAM NAME="DetailDataID"			VALUE="gcds_print">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
  <PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"			VALUE="TRUE">
	<param NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            VALUE="
	<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2729 ,face='Arial' ,size=10 ,penwidth=1
		<I>id='../../Common/img/icon.jpg' ,left=741 ,top=2612 ,right=1219 ,bottom=2712</I>
		<X>left=38 ,top=269 ,right=1944 ,bottom=2606 ,border=true ,penstyle=solid ,penwidth=1</X>
		<X>left=38 ,top=2137 ,right=363 ,bottom=2606 ,border=true</X>
		<X>left=38 ,top=1303 ,right=1944 ,bottom=1475 ,border=true</X>
		<X>left=38 ,top=1131 ,right=1944 ,bottom=1306 ,border=true</X>
		<X>left=38 ,top=962 ,right=1944 ,bottom=1134 ,border=true</X>
		<X>left=38 ,top=794 ,right=1944 ,bottom=966 ,border=true</X>
		<X>left=38 ,top=456 ,right=1944 ,bottom=628 ,border=true</X>
		<X>left=38 ,top=625 ,right=1944 ,bottom=797 ,border=true</X>
		<L> left=38 ,top=269 ,right=38 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=269 ,right=1941 ,bottom=269 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=41 ,top=2606 ,right=1941 ,bottom=2606 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=1944 ,top=269 ,right=1944 ,bottom=2603 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<L> left=322 ,top=272 ,right=322 ,bottom=1472 </L>
		<L> left=984 ,top=625 ,right=984 ,bottom=962 </L>
		<L> left=1275 ,top=628 ,right=1275 ,bottom=966 </L>
		<L> left=1275 ,top=1134 ,right=1275 ,bottom=1303 </L>
		<L> left=984 ,top=1131 ,right=984 ,bottom=1303 </L>
		<L> left=38 ,top=269 ,right=38 ,bottom=2606 </L>
		<L> left=1941 ,top=269 ,right=1941 ,bottom=2606 </L>
		<L> left=119 ,top=2228 ,right=119 ,bottom=2606 </L>
		<L> left=41 ,top=2416 ,right=359 ,bottom=2416 </L>
		<L> left=38 ,top=2225 ,right=356 ,bottom=2225 </L>
		<C>id='CERTINO', left=38, top=191, right=600, bottom=256, align='left' ,mask='�� XXXX - XXXX ȣ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='DEPTNM', left=344, top=675, right=975, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='PAYGNM', left=1294, top=675, right=1925, bottom=741, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERUSE', left=344, top=1019, right=1922, bottom=1084, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='EMPNMK', left=344, top=844, right=975, bottom=909, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CERETC', left=344, top=1353, right=1922, bottom=1419, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='STRTDT', left=344, top=1184, right=975, bottom=1250, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CURDT', left=1319, top=1975, right=1819, bottom=2044, align='right' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='CADDR', left=344, top=509, right=1922, bottom=575, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='OADDR', left=344, top=334, right=1922, bottom=400, align='left', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='RESINO', left=1294, top=844, right=1925, bottom=909, align='left' ,mask='XXXXXX - XXXXXXX', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<C>id='ENDDT', left=41, top=1503, right=1938, bottom=1569 ,mask='����ڴ� XXXX�� XX�� XX�Ϻη� ��� �����Ͽ����� ������.', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<L> left=694 ,top=197 ,right=1291 ,bottom=197 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		<T>id='�� �� �� �� ��' ,left=25 ,top=41 ,right=1959 ,bottom=187 ,face='HY�߰��' ,size=26 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=988 ,top=675 ,right=1275 ,bottom=741 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�ֹε�Ϲ�ȣ' ,left=988 ,top=844 ,right=1275 ,bottom=909 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<C>id='ENDDT', left=1294, top=1184, right=1925, bottom=1250, align='left' ,mask='XXXX�� XX�� XX�� ', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		<T>id='�����' ,left=988 ,top=1184 ,right=1275 ,bottom=1250 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ   ��' ,left=63 ,top=2150 ,right=334 ,bottom=2216 ,face='����' ,size=13 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2437 ,right=119 ,bottom=2497 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2528 ,right=119 ,bottom=2587 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2353 ,right=119 ,bottom=2406 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��' ,left=44 ,top=2297 ,right=119 ,bottom=2347 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='Ȯ' ,left=44 ,top=2237 ,right=119 ,bottom=2291 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<I>id='../../Common/img/new_attampt1.jpg' ,left=1134 ,top=2206 ,right=1863 ,bottom=2503</I>
		<T>id='��     ��' ,left=44 ,top=328 ,right=319 ,bottom=394 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=503 ,right=319 ,bottom=569 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=669 ,right=319 ,bottom=734 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=837 ,right=319 ,bottom=903 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=1012 ,right=319 ,bottom=1078 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='�� �� ��' ,left=44 ,top=1178 ,right=319 ,bottom=1244 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
		<T>id='��     ��' ,left=44 ,top=1347 ,right=319 ,bottom=1412 ,face='����' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	</B>
	">
</object></comment><script>__ws__(__NSID__);</script>
</BODY>
</HTML>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>