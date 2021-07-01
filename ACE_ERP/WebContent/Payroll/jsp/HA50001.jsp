<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: hA50001.html
+ �� �� �� ��	: �߱����Ͻ�û
+ �� �� �� ��	: �����
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: hA50001_s1, hA50001_s2, hA50001_s3, hA50001_t1, hA50001_s1_time
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title></title>
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


gs_date = gcurdate.substring(0,4);// + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
							+ "FRDT:String(8),TODT:String(8),FRTIME:String(6),TOTIME:String(6),DTYREM:String(40),"
							+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
							+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50),MINORNM:String(30),EMPNMK:String(20),"
							+ "LAZFEENM:String(20),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
							+ "SGNM:String(20),MINORCD:String(4),AGNM:String(20) ";

	gcds_data.SetDataHeader(THeader);								//Header Set

	ln_Query2();	//����ȸ ����

	gcem_fr.text = gcurdate.substring(0,7) + "01";	//�˻����� FROM
	gcem_to.text = gcurdate;												//�˻�����	TO
	txt_EMPNO.value = gusrid;												//�����ID
	txt_NAME.value	= gusrnm;												//����ڸ�

	//���ϱٹ�
	gcds_holiday.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h010002_s3?v_str1="+gs_date; 
	gcds_holiday.Reset();

	gclx_LAZCD.enable = false;	//�ٹ�����
	FRTIME.enable = false;			//��ٽð�
	TOTIME.enabled = false;			//��ٽð�
	FRDT.enable = false;	//������
   TODT.enable = false;

	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
  
	var v_str1=gcem_fr.text;
	var v_str2=gcem_to.text;
	var v_str4=v_str1.substring(0,4)+v_str1.substring(4,6);
	var v_str5=v_str2.substring(0,4)+v_str2.substring(4,6);
	

	gcds_data.DataID = "/servlet/Contract.hA50001_s1?v_str1=" + gcem_fr.text
									 + "&v_str2=" + gcem_to.text
									 + "&v_str3=" + txt_EMPNO.value 
									 + "&v_str4=" + v_str4
									 + "&v_str5=" + v_str5;
	gcds_data.Reset();

	gclx_LAZCD.enable = false;	//�ٹ�����
	FRTIME.enable = false;			//��ٽð�
	TOTIME.enabled = false;			//��ٽð�
	FRDT.enable = false;     	//������ 
  TODT.enable = false;
}

/*-----------------------------------------------------------------------------
		Description : ����ȸ ����
-----------------------------------------------------------------------------*/
function ln_Query2(){

	//���� �⺻����
	gcds_data2.DataID = "/servlet/Contract.hA50001_s3?v_str1="+gusrid;
	gcds_data2.Reset();

	// �ٹ�����
	gcds_holfee.DataID = "/servlet/Contract.hA50001_s2";
	gcds_holfee.Reset();

}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

	if (DEPTNM.value == "") { 
		alert("�ش� �Ҽ��� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 

	gcds_data.addrow();

	ln_Query2();

	var v_payseq  = gcds_data2.namevalue(gcds_data2.rowposition,"PAYSEQ");	//����

	gcds_temp.DataID = "/servlet/Contract.hA50001_s2?v_str3=" + txt_EMPNO.value;
	gcds_temp.Reset();

	gcem_to.text = gcurdate;				//������
	txt_APPDT.value = gcem_to.text;	//��û��
	FRDT.text = gcurdate;						//������
	TODT.text = gcurdate;						//������
	gclx_LAZCD.enable = true;

	//ln_CurTime1();	//��ٽð�
	
	TOTIME.text = '';									//��ٽð�
	FRTIME.text = '';						      //��ٽð�
	FRDT.enable = true;								//������
  TODT.enable = true;
	FRTIME.enabled = true;			//��ٽð�
	TOTIME.enabled = true;			//��ٽð�

	var row = gcds_data.rowposition;
	var row2 = gcds_data2.rowposition;

	if (DEPTNM.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_EMPNO.value	= gusrid;
		txt_MINORCD.value = v_payseq;		//����
		DEPTNM.value  = gcds_data2.namevalue(row2,"DEPTNM");		//�ҼӸ�
		txt_deptcd.value = gcds_data2.namevalue(row2,"DEPTCD");	//�Ҽ��ڵ�
		EMPNMK.value = gcds_data2.namevalue(row2,"EMPNMK");			//����
		//gclx_LAZCD.enable = true;
	} else {
		txt_EMPNO.value	= gusrid;
		DEPTNM.value	= "";
		MINORNM.value = "";
		EMPNMK.value	= gusrnm;	
		txt_deptcd.value = "";
		//gclx_LAZCD.enable = true;
	}
}

/******************************************************************************
	Description : ���� ��ٽð�����
******************************************************************************/
/*
function ln_CurTime1() {

	if (DEPTNM.value == "") { 
		alert("�Ҽӵ� �ҼӰ� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 

	if (FRTIME.text == "") { 
	
      FRTIME.text = gcurdate;
  //	  gcds_curtime.DataID = "/servlet/Contract.hA50001_s1_time";
	//		gcds_curtime.Reset();

		var h_time = gcds_curtime.namevalue(FRTIME.text,"TOTIME").substring(0,2);
		var m_time = gcds_curtime.namevalue(FRTIME.text,"TOTIME").substring(3,5);
		var s_time = gcds_curtime.namevalue(FRTIME.text,"TOTIME").substring(6,8);

		FRTIME.text = h_time+m_time+s_time;
		FRTIME.enabled = false;

	}else{
		return false;
	}

}
*/
/******************************************************************************
	Description : ���� ��ٽð�����
******************************************************************************/
/*
function ln_CurTime() {

	if (DEPTNM.value == "") { 
		//alert("�Ҽӵ� �ҼӰ� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 

	TOTIME.enabled = false;

	if (TOTIME.text == "") {
     TOTIME.text = gcurdate;
//	gcds_curtime.DataID = "/servlet/Contract.hA50001_s1_time";
//	gcds_curtime.Reset();

	var h_time = gcds_curtime.namevalue(TOTIME.text,"TOTIME").substring(0,2);
	var m_time = gcds_curtime.namevalue(TOTIME.text,"TOTIME").substring(3,5);
	var s_time = gcds_curtime.namevalue(TOTIME.text,"TOTIME").substring(6,8);

	TOTIME.text = h_time+m_time+s_time;

	ln_Save();
	}else{
		return false;
	}

}
*/
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if (DEPTNM.value == "") { 
		alert("�Ҽӵ� �ҼӰ� �����Ƿ� ����� �� �����ϴ�.");
		return false;
	} 

	if (FRDT.text != "") { TODT.text = FRDT.text; }
	
	if (!ln_Valchk()) return;

	var row = gcds_data.rowposition;

	gcds_data.namevalue(row,"DEPTCD")		=		fn_trim(txt_deptcd.value);		//�Ҽ��ڵ�
	gcds_data.namevalue(row,"EMPNO")		=		txt_EMPNO.value;							//���
	gcds_data.namevalue(row,"DEPTNM")		=		fn_trim(DEPTNM.value);				//�ҼӸ�
	gcds_data.namevalue(row,"PAYSEQ")		=		txt_MINORCD.value;						//����
	gcds_data.namevalue(row,"EMPNMK")		=		EMPNMK.value;									//����
	gcds_data.namevalue(row,"SGNID")		=		fn_trim(txt_SGNID.value);			//������ID
	//gcds_data.namevalue(row,"AGRID")		=		txt_AGRID.value;						//������ID
	gcds_data.namevalue(row,"DTYREM")		=		txt_DTYREM.value;							//���»���
	gcds_data.namevalue(row,"AMT")		=		txt_AMT.value;									//����ݾ�

	//�ް����� ���������� ������/������ üũ---------------------------------------------------------
	if (gclx_LAZCD.BindColVal == 'S05' ) {	//Ư��(����)
		if (FRTIME.text != "") {
			if (ln_Holchk(FRDT.text)==true) {
				var frt = FRTIME.text;	//��ٽð�
				var tot = TOTIME.text;	//��ٽð�
				var sum_time  = tot.substring(0,2) - frt.substring(0,2);
				if (sum_time >= 4) {
					if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '20') {
						txt_AMT.value = 40000;		//�����̻� ���ޱݾ�
						//txt_AMT.value = 0;			//�� 4�ð� �̻��� �� ����
					}else if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '22') {
						txt_AMT.value = 30000;		//�븮���� ���ޱݾ�
						//txt_AMT.value = 0;			//�� 4�ð� �̻��� �� ����
					}
				}else {
					txt_AMT.value = 0;
				}
			}else {
				alert("���Ͽ��� Ư��(����)�� ����� �� �����ϴ�.");
				txt_AMT.value = 0;
				TOTIME.text = "";
				return false;
			}
		}
	}

if (gclx_LAZCD.BindColVal  == 'S01' )	{ 

		
		var to_time = TOTIME.text;
 
		var h_time = to_time.substring(0,2);	//��
		var m_time = to_time.substring(3,5);	//��
		var s_time = to_time.substring(6,8);	//��

		if (TOTIME.text != "") {
			//21�� ���� ~ ���� 24�ñ���
			if (h_time.substring(0,2) >= '21' && m_time.substring(3,5) == '00') { 
				txt_AMT.value = 7000;
			//24�� ���� ~ ���� 8�ñ���
			} else if (h_time.substring(0,2) >=  '24' || (h_time.substring(0,2) <=  '08' && m_time.substring(3,5) <=  '00')) {
				txt_AMT.value = 10000;
			//18�� ���� ~ 21�� ��������
			} else if (h_time.substring(0,2) >=  '18' || h_time.substring(0,2) <  '21') {
				txt_AMT.value = 0;
			}
		}else{ txt_AMT.value = 0; }
	}
	//if (FRTIME.text != "") {
	//	var stfrtime = FRTIME.text + "00";
	//	gcds_data.namevalue(gcds_data.rowposition,"FRTIME") = stfrtime;
	//}else if (FRTIME.text != "" && TOTIME.text != "") {
	/*
	if (FRTIME.text != "" && TOTIME.text != "") {
		var stfrtime = FRTIME.text + "00";
		var sttotime = TOTIME.text + "00";
		gcds_data.namevalue(gcds_data.rowposition,"FRTIME") = stfrtime;
		gcds_data.namevalue(gcds_data.rowposition,"TOTIME") = sttotime;
	}
*/
	//-----------------------------------------------------------------------------------------------

	var v_str1 = txt_APPDT.value;
	var v_str2 = txt_EMPNO.value ;					//���
	var v_str3 = fn_trim(txt_SGNID.value);	//������
	//var v_str4 = txt_AGRID.value;						//������

	if (gcds_data.IsUpdated) {
//prompt('',gcds_data.text);
		if (confirm("�Է��Ͻ� ������ ����Ͻðڽ��ϱ�?")){	
		gctr_pyo.Action = "/servlet/Contract.hA50001_t1?v_str1="+ v_str1+"&v_str2="+v_str2 + "&v_str3=" + v_str3;
		gctr_pyo.post();
		ln_Query();
		}else {
			TOTIME.text ='';
		}		
	}
}

/******************************************************************************
	Description : Ư��(����) ��¥ üũ
******************************************************************************/
function ln_Holchk(str_frdt) {

	for (i=1;i<=gcds_holiday.countrow;i++) {	
		if (gcds_holiday.namevalue(i,"HOLDT") ==str_frdt && 
				(gcds_holiday.namevalue(i,"HOLDIV") == '2' || gcds_holiday.namevalue(i,"HOLDIV") == '1')) {
			return true;
		}	
	}
	return false;

}

/******************************************************************************
	Description : �Է°� üũ[���°���]
******************************************************************************/
function ln_Valchk() {

	var row = gcds_data.rowposition;

	txt_SGDT.value = gcds_data.namevalue(row, "SGDT");
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("������ / ��������  ó�� �� �׸���  ���� �� �� �����ϴ�."); 
		return false;
	}
	
	if (FRDT.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		FRDT.focus();
		return false;
	}

	 
	if (fn_trim(FRTIME.text) == "") { 
		alert("��Ȯ�� ��ٽð��� �Է��� �ֽʽÿ�."); 
		FRTIME.text = "";
		FRTIME.focus();
		return false;
	}
 
	if (TODT.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		TODT.focus();
		return false;
	}
	if (fn_trim(TOTIME.text) == "") { 
		alert("��Ȯ�� ��ٽð��� �Է��� �ֽʽÿ�."); 
		TOTIME.text = "";
		TOTIME.focus();
		return false;
	}
	/*
	if (fn_trim(SGNM.value) == "") { 
		alert("��Ȯ�� �����ڸ� �Է��� �ֽʽÿ�."); 
		SGNM.value ="";
		//SGNM.focus();
		return false;
	}
*/
	if (FRDT.text > TODT.text) {
		alert("�����ϰ� ������ Ʋ���ϴ�. Ȯ�� �� �����Ͻʽÿ�. ");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("������ / ��������  ó�� �� �׸��� ���� �� �� �����ϴ�."); 
		return false;
	}
	
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		gcds_data.deleterow(gcds_data.rowposition);
		gctr_pyo.action = "/servlet/Contract.hA50001_t1?v_str1=" + gcem_to.text+ "&v_str2=" + txt_EMPNO.value;
		gctr_pyo.post();
		ln_Query();
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

}

  /******************************************************************************
	Description : ������ ã��
******************************************************************************/
/*
function ln_Popup(e){

	var row = gcds_data.rowposition;

	txt_SGDT.value  = gcds_data.namevalue(row, "SGDT");		//���糯¥
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");	//���γ�¥

	if (gcds_data.IsUpdated) {

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("���� �� ������  ó�� �� �׸��Դϴ�."); 
		return false;
	}

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./H030003_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

 	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="SGNM") txt_SGNID.value = arrParam[1];	
	} else {
		eval(e).value = "";
		if (e=="SGNM") txt_SGNID.value = "";	
	}
	}
}
*/
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- �ٹ����� -->
<comment id="__NSID__"><OBJECT id=gcds_holfee classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="true">
	<PARAM NAME="SortExpr"  VALUE="+LAZFEENM">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ���� �ð����� -->
<comment id="__NSID__"><OBJECT id=gcds_curtime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-- ���ϱٹ� -->
<comment id="__NSID__"><OBJECT id=gcds_holiday classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"	VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="hA50001_t1(I:USER=gcds_data)">
</OBJECT></comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	// document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//������ ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
		ln_Query2();
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

</script>

<script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>

	var row = gcds_data2.rowposition;

	if (DEPTNM.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		DEPTNM.value	= gcds_data2.namevalue(row,"DEPTNM");		//�ҼӸ�
		MINORNM.value = gcds_data2.namevalue(row,"MINORNM");	//����
		EMPNMK.value	= gusrnm;																//����	
	} else {
		DEPTNM.value	= "";
		MINORNM.value = "";
		EMPNMK.value	= gusrnm;	
	}

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_LAZCD" event="OnSelChange()">
	
	//�ٹ����п� ���� �������ǰ� ���ޱݾ� ��ȸ
	var row = gcds_holfee.rowposition;
	var str1 = gcds_holfee.namevalue(row,"LAZCD");
	
	txt_MEMO.value = gcds_holfee.namevalue(row,"MEMO");
	txt_AMT.value = gcds_holfee.namevalue(row,"AMT");

	//�ٹ����� : Ư��(����)---------------------------------------------------------------
	if (gcds_holfee.namevalue(row,"LAZCD") == 'S05' ) {	
		if (FRTIME.text == "" && TOTIME.text == "") {
			if (ln_Holchk(FRDT.text)==true) {
				if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '20') {
					//txt_AMT.value = 40000;		//�����̻� ���ޱݾ�
					txt_AMT.value = 0;			//�� 4�ð� �̻��� �� ����
				}else if (gcds_data2.namevalue(gcds_data2.rowposition,"MEMO") == '22') {
					//txt_AMT.value = 30000;		//�븮���� ���ޱݾ�
					txt_AMT.value = 0;			//�� 4�ð� �̻��� �� ����
				}
			}else{
				txt_AMT.value = 0;	
			}
		}
	//�ٹ����� : �߱ٺ�(����)-------------------------------------------------------------
	} else if (gcds_holfee.namevalue(row,"LAZCD") == 'S01' )	{ 

		var to_time = TOTIME.text;
 		var h_time = to_time.substring(0,2);	//��
		var m_time = to_time.substring(3,5);	//��
		var s_time = to_time.substring(6,8);	//��

		if (TOTIME.text != "") {
			//21�� ���� ~ ���� 24�ñ���
			if (h_time.substring(0,2) >= '21' && m_time.substring(3,5) == '00') { 
				txt_AMT.value = 7000;
			//24�� ���� ~ ���� 8�ñ���
			} else if (h_time.substring(0,2) >=  '24' || (h_time.substring(0,2) <=  '08' && m_time.substring(3,5) <=  '00')) {
				txt_AMT.value = 10000;
			//18�� ���� ~ 21�� ��������
			} else if (h_time.substring(0,2) >=  '18' || h_time.substring(0,2) <  '21') {
				txt_AMT.value = 0;
			}
		}else{ txt_AMT.value = 0; }
	}

</script>

<script language="javascript"  for=gcgd_pyo  event=OnColumnPosChanged(Row,Colid)>
 	txt_AMT.value = gcds_data.namevalue(row,"AMT");
</script>

<script language="javascript"  for="FRDT"  event="OnKillFocus()">
 	TODT.text = FRDT.text;
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
			<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
  <tr> 
    <td COLSPAN=2>

	<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
    <tr> 
			<td width="10" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>&nbsp;�˻�����&nbsp;&nbsp;</nobr></td>
			<td width="10"style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
				<comment id="__NSID__"><object id=gcem_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fr', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
					
			</td>
			<td align=center> ~ </td>
			<td style="height:30px;border:0 solid #708090;border-right-width:0px;"><nobr> 
				<comment id="__NSID__"><object id=gcem_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=ClipMode			value=true>
					<param name=Numeric	      value=false>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=MaxLength     value=8>
					<param name=PromptChar	  value="_">
					<param name=IsComma	      value=false>
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script>
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_to', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">&nbsp;</nobr>
			</td>
			<td width="150" align=RIGHT ></td>   
			<td width="100" align=RIGHT  style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"><nobr>��û�ڻ��&nbsp;&nbsp;&nbsp;</nobr></td>
			<td>
				<input id="txt_EMPNO" name="txt_EMPNO" type=text value=""  class="txtbox" style="border:0px;position:relative;left:5px;top:2px"   maxlength="7" onBlur="bytelength(this,this.value,7);" disabled >
			</td>
			<td width="150" align=RIGHT style="border:0 solid #708090;border-right-width:1px;">&nbsp;&nbsp;</td>
			<td width="100" align=RIGHT  style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" ><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;</nobr></td>
			<td >
				<input id="txt_NAME" name="txt_NAME" type=text value="" class="txtbox" style="border:0px;position:relative;left:5px;top:1px"       maxlength="20" onBlur="bytelength(this,this.value,20);" disabled>
			</td>
			<td width="150" align=RIGHT >&nbsp;&nbsp;</td>
			<td style="padding-top:4px;"></td>
		</tr>
	</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="876" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:503">
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:484px;HEIGHT:419px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="Editable"		VALUE="false">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
							<PARAM NAME="Format"			VALUE="  
								<F> Name='��û��'			ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER	Mask='XXXX/XX/XX' BgColor='#f5f5f5' Edit=None  </F> 
								<F> Name='�ٹ�����'		ID=LAZCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=140	align=LEFT		Edit=None    BgColor='#f5f5f5' Editstyle=lookup data='gcds_holfee:LAZCD:LAZFEENM'  </F> 
								<G> Name='����'				ID=MIDSCR		HeadAlign=Center HeadBgColor=#B9D4DC 
								<C> Name='��¥'				ID=FRDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Mask='XXXX/XX/XX' Edit=None  </C>
								<C> Name='�ð�'				ID=FRTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
                <C> Name='���'				ID=ATTTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<G> Name='����'				ID=MIDSCR		HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='��¥'				ID=TODT			HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=CENTER	Mask='XXXX/XX/XX' Edit=None  </C>
								<C> Name='�ð�'				ID=TOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
                 <C> Name='���'				ID=CLOTIME		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=CENTER	Mask='XX:XX' Edit=None </C>
								</G>
								<C> Name='�����ڸ�'		ID=SGNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=88		align=LEFT		Edit=None </C>
								<C> Name='������'			ID=SGDT			HeadAlign=Center HeadBgColor=#B9D4DC Width=75		align=CENTER	Mask='XXXX/XX/XX' Edit=None </C>
								<C> Name='������ID'		ID=SGNID		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=CENTER	Edit=None SHOW=false</C>
								<C> Name='�����ڸ�'		ID=AGNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=88		align=LEFT		Edit=None </C>
								<C> Name='������'			ID=AGRDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=CENTER	Mask='XXXX/XX/XX' Edit=None </C>
								<C> Name='������ID'		ID=AGNID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		align=LEFT		Edit=None SHOW=false</C>
								<C> Name='�ҼӸ�'			ID=DEPTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=83		align=CENTER	Edit=None show=false</C>
								<C> Name='����'				ID=MINORNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
								<C> Name='�̸�'				ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=73		align=LEFT		Edit=None show=false</C>
							">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
			<td STYLE="PADDING-TOP:0px;" valign=top><table width="350" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td valign=top>
				<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:384px;height:421px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
					<tr>
						<td style="width:70px;height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >�� �� ��</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="DEPTNM" name="DEPTNM" type="text"   class="txtbox"  style= "position:relative;left:-6px;width:126px;height:20px;" maxlength="50" onBlur="bytelength(this,this.value,50);" disabled>
							<input id="DEPTCD" name="txt_deptcd" type="hidden" style= "position:relative;left:-6px;width:10px;height:20px;" value="" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="MINORNM" name="MINORNM"  class="txtbox" type="text" style= "position:relative;left:-5px;width:90px; height:20px;" value="" maxlength="30" onBlur="bytelength(this,this.value,30);" disabled>
							<input id="txt_MINORCD" name="txt_MINORCD"	type="hidden" style= "width:1px; height:1px;" maxlength="4" onBlur="bytelength(this,this.value,4);" readonly>
							<input id="txt_APPDT"		name="txt_APPDT"		type="hidden" style="height:20px" maxlength="8" onBlur="bytelength(this,this.value,8);" readonly>
						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >�ٹ�����</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=gclx_LAZCD name=gclx_LAZCD classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=186 width=128 class="txtbox" >
								<param name=ComboDataID			value=gcds_holfee>
								<param name=SearchColumn		value="LAZCD^LAZFEENM^ALWCON^AMT">
								<param name=Sort						value="LAZFEENM">
								<param name=ListExprFormat	value="LAZFEENM">
								<param name=BindColumn			value="LAZCD">
								<!-- <param name=Enable          value=false> -->
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td style="border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >
							<nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
						<td style="border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<input id="EMPNMK" name="EMPNMK" type="text"  class="txtbox" style= "position:relative;left:-5px;width:90px; height:20px;" value="" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled></td>
					</tr>					
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center><nobr>�� �� ��</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=FRDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; " 		validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>
							
							<img name="frimg" src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('FRDT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></td>
						
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" ><nobr>&nbsp;���۽ð�&nbsp;</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;
							<comment id="__NSID__"><object id=FRTIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="00:00">
								<param name=MaxLength     value=4>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script>

						</td>
					</tr>
					<tr>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox"><nobr>�� �� ��</nobr></td>
						<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
							<comment id="__NSID__"><object id=TODT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative; left:1px;top:1px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2; "  
				validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=ClipMode			value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=MaxLength     value=8>
								<param name=PromptChar	  value="_">
								<param name=IsComma	      value=false>
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
					
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('TODT', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;"></nobr>
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">����ð�</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><object id=TOTIME classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative; left:1px;top:1px; width:40px; height:20px; font-family:����; font-size:9pt;z-index:2; " 
				validFeatures="ignoreStatus=yes" validExp="">
						<param name=Text          value="">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=ClipMode			value=true>
						<param name=Numeric	      value=false>
						<param name=Format	      value="00:00">
						<param name=MaxLength     value=4>
						<param name=PromptChar	  value="_">
						<param name=IsComma	      value=false>
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>
				
					<nobr>
				</td>
			</tr>
			<tr>
				<!-- 	<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">�� �� ��</td>
				<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp; -->
					<input id="SGNM"			name="SGNM"				type="text"		 class="txt21" style= "position:relative;left:-6px;width:76px; height:20px;" maxlength="20" onBlur="bytelength(this,this.value,20);" disabled> 
					<input id="txt_SGNID" name="txt_SGNID"	type="hidden" style= "width:20px; height:1px;" maxlength="7" onBlur="bytelength(this,this.value,7);"> 
					<!-- <input id="txt_AGRID" name="txt_AGRID"	type="hidden" style= "width:20px; height:1px;" maxlength=7> -->
					<input id="txt_SGDT"	name="txt_SGDT"		type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
					<input id="txt_AGRDT"	name="txt_AGRDT"	type="hidden" style= "width:20px; height:1px;" maxlength="8" onBlur="bytelength(this,this.value,8);">
				</td>
			<!--	<td Style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="������ �˻��մϴ�" style="cursor:hand;position:relative;left:-2px;" align=center onclick="ln_Popup('SGNM');">
				</td>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" >&nbsp;</td>
				<td Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=2>&nbsp;</td>-->
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��������</br><nobr>(��ü������)</nobr></td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<textarea id="txt_DTYREM" class="txtbox"  style= "width:297px; height:74px; overflow:auto;position:relative;left:-6px" maxlength="40" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >��������</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="txt_MEMO" name="txt_MEMO" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="30" onBlur="bytelength(this,this.value,30);" disabled>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" >����ݾ�</td>
				<td  Style="height:30px;border:0 solid #708090;border-bottom-width:1px" colspan=5><nobr>&nbsp;
					<input id="txt_AMT" name="txt_AMT" type="text" class="txt21"  style="position:relative;left:-6px;width:257px;border=0;background-color:#f1f1f1;" maxlength="7" onBlur="bytelength(this,this.value,7);" disabled>&nbsp;</nobr>
				</td>
			</tr>
			<tr>
				<td colspan=6 style="height:100%;border:0 solid #708090;border-bottom-width:0px;" >&nbsp;</td>
			<!-- </tr>
					<tr>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox"  align=center ><nobr>&nbsp;&nbsp;&nbsp;��    ��</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-right-width:1px;">&nbsp;
							<input id="CURYEAR" name="CURYEAR" type="text"  class="txtbox" style= "width:50px; height:20px; border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled>
						</td>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" align=center><nobr>��  ��</nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-right-width:1px;">&nbsp;
							<input id="USEYEAR" name="USEYEAR" type="text"  class="txtbox" style= "width:50px; height:20px;border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled>
            </td>
						<td style="height:20px;width:50px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" class="txtbox" align=center ><nobr>��  ��</nobr></td>
						<td Style="height:20px;border:0 solid #708090;">&nbsp;
							<input id="PAYYEAR" name="PAYYEAR" type="text"  class="txtbox" style= "width:50px; height:20px;border=0;background-color:#f1f1f1;position:relative;left:-6px" maxlength="3" onBlur="bytelength(this,this.value,3);" disabled>
            </td>
					</tr> -->
				</table>
				</td>
			</tr>
		</table>
			</td>
		</tr>
  </table>
    </td>
  </tr>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search"></label></td>
  </tr>	
</table>

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=APPDT        Ctrl=txt_APPDT		Param=value			</C>
		<C>Col=EMPNO        Ctrl=EMPNO			  Param=value			</C>
		<C>Col=LAZCD        Ctrl=gclx_LAZCD	  Param=BindColVal</C>
		<C>Col=LAZFEENM     Ctrl=LAZFEENM			Param=BindColVal</C>
		<C>Col=DEPTCD       Ctrl=DEPTCD			  Param=value			</C>
		<C>Col=PAYSEQ       Ctrl=PAYSEQ			  Param=value			</C>
		<C>Col=FRDT					Ctrl=FRDT					Param=Text			</C>
		<C>Col=FRTIME				Ctrl=FRTIME				Param=Text			</C>
		<C>Col=TODT					Ctrl=TODT					Param=Text			</C>
		<C>Col=TOTIME				Ctrl=TOTIME			  Param=Text			</C>
		<C>Col=DTYREM				Ctrl=txt_DTYREM		Param=value			</C>
		<C>Col=CLOSYN				Ctrl=CLOSYN			  Param=value			</C>
		<C>Col=SGNID				Ctrl=txt_SGNID		Param=value			</C>
		<C>Col=SGDT					Ctrl=txt_SGDT			Param=value			</C>
		<C>Col=AGRID				Ctrl=AGRID				Param=value			</C>
		<C>Col=AGRDT				Ctrl=txt_AGRDT		Param=value			</C>
		<C>Col=PAYDT			   	Ctrl=PAYDT				Param=Text			</C>
		<C>Col=AMT					     Ctrl=txt_AMT			Param=value			</C>
		<C>Col=MINORNM			Ctrl=MINORNM		  Param=value			</C>
		<C>Col=DEPTNM				Ctrl=DEPTNM				Param=value			</C>
		<C>Col=EMPNMK				Ctrl=EMPNMK				Param=value			</C>
		<C>Col=SGNM					Ctrl=SGNM					Param=value			</C>
    <C>Col=ATTTIME				Ctrl=ATTTIME				Param=value			</C>
		<C>Col=CLOTIME					Ctrl=CLOTIME					Param=value			</C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script>
<!-- <C>Col=CURYEAR			Ctrl=CURYEAR			Param=value			</C>
		<C>Col=USEYEAR			Ctrl=USEYEAR			Param=value			</C>
		<C>Col=PAYYEAR			Ctrl=PAYYEAR			Param=value     </C> -->
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>