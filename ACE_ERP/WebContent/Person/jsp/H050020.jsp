<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�
+ ���α׷� ID	: h050020.html
+ �� �� �� ��	: ���ð���
+ �� �� �� ��	: ������
+ �� �� �� ��	: ������ 
-----------------------------------------------------------------------------
+ �� �� �� �� :	
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: h050020_s1 , h050020_t1
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
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
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


  gcem_appdt.text=gcurdate.substring(0,4) + gcurdate.substring(5,7) ;

  /*
  ln_SetDataHeader()
	
	gcem_fr.text = gcurdate.substring(0,7) + "01";	//��������
	gcem_to.text = gcurdate;												//��������
	//gcem_empno_1.value = gusrid;									//�����ID
	//txt_NAME.value	= gusrnm;											//����ڸ�

	ln_Query2();
  ln_Enable("F");

	gclx_closeyn.index=0;
	gclx_gubun.index=0;

	//SGNM.value="����ȯ";
  //txt_SGNID.value="1990098";
  */

  gclx_jtgb.index=0;
	gclx_gubun.index=0;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  gcds_data.DataID = "/servlet/Person.h050020_s2?v_str1=" + gcem_appdt.text  // �޿����
									 + "&v_str2=" + gcem_empno.text                                     // ���
									 + "&v_str3=" + fn_trim(txt_empnmmk.value)                          // ����
							  	 + "&v_str4=" + gclx_jtgb.bindcolval                                // ���ñ���
								   + "&v_str5=" + gclx_gubun.bindcolval ;                             // ����
  
	//prompt('',gcds_data.DataID);
	gcds_data.Reset(); 

}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Chk(){

  if(fn_trim(gcem_appdt.text)==""){
		alert("�޿������ Ȯ���Ͻʽÿ�");
		return false;
	}

	if(gclx_gubun.bindcolval==""){
		alert("������, ����� ������ Ȯ���Ͻʽÿ�");
		return false;
	}

  gcds_chk.DataID = "/servlet/Person.h050020_s1?v_str1=" + gcem_appdt.text  // �޿����
									 + "&v_str2=" + gclx_gubun.bindcolval;                             // ���
	//prompt('',gcds_chk.DataID);
	gcds_chk.Reset(); 

	return true;

}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Close() {
  
	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6)";
  	gcds_temp.SetDataHeader(THeader);							
	}

	gcds_temp.Addrow();
  gcds_temp.namevalue(gcds_temp.rowposition,"APPDT") =gcem_appdt.text ;
 
	if (gcds_temp.IsUpdated) {
		if (confirm("�޿���� "+gcem_appdt.text+" ���� �Ͻðڽ��ϱ�?")){	
			gctr_data2.Action = "/servlet/Person.h050020_t4?";
			gctr_data2.Parameters = "v_str1="+gclx_gubun.bindcolval;
			gctr_data2.post();
		}	
	}
}


/******************************************************************************
	Description : �ݿ�
******************************************************************************/
function ln_Update() {

  if(gcds_data.countrow<1){
		alert("�λ������� �ݿ��� �����Ͱ� �����ϴ�. Ȯ�� �ٶ��ϴ�.");
		return;
	}

	if(gcds_data.namevalue(gcds_data.rowposition,"CLOSEYN")=="Y"){
		alert("�̹� ���� �Ǿ����ϴ�. �ݿ��� �� �����ϴ�.");
		return;
	}
 
  
	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6),EMPNO:STRING(7),JTGB:DECIMAL(1.0)";
  	gcds_temp.SetDataHeader(THeader);							
	}


  for(i=1;i<=gcds_data.countrow;i++){
		gcds_temp.Addrow();
		gcds_temp.namevalue(gcds_temp.rowposition,"APPDT")=gcds_data.namevalue(i,"APPDT");
		gcds_temp.namevalue(gcds_temp.rowposition,"EMPNO")=gcds_data.namevalue(i,"EMPNO");
		gcds_temp.namevalue(gcds_temp.rowposition,"JTGB")=gcds_data.namevalue(i,"JTGB");
	}
 
	if (gcds_temp.IsUpdated) {
		if (confirm("�޿���� "+gcem_appdt.text+" ���� ������ �λ�⺻������ �ݿ��Ͻðڽ��ϱ�?")){	
			gctr_data3.Action = "/servlet/Person.h050020_t5?";
			gctr_data3.Parameters = "v_str1="+gclx_gubun.bindcolval;
			gctr_data3.post();
		}	
	}
}



/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Create() { 
 
  //���������� ���� �ϴ��� üũ 
	//������ �ȵ� ��츸 ����� ������.
	//������ �� ���� � ���� ����� �Ұ� //������, ����� �����Ͽ� üũ��.

	if(!ln_Chk()) return;

	gcds_temp.clearAll();
  if(gcds_temp.countrow<1){
		var THeader = "APPDT:STRING(6)";
  	gcds_temp.SetDataHeader(THeader);							
	}

	gcds_temp.Addrow();
  gcds_temp.namevalue(gcds_temp.rowposition,"APPDT") =gcem_appdt.text ;


	if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN")=="C"){
			alert("������ �Ǿ����ϴ�. �������� �����սýÿ�.");
			return;
		}
		if (confirm("���� "+gcem_appdt.text+ " �����Ͱ� �����մϴ�. ���� �� �ٽ� �����Ͻðڽ��ϱ�?")){	
				gctr_pyo.Action = "/servlet/Person.h050020_t1?";
				gctr_pyo.Parameters = "v_str1="+gclx_gubun.bindcolval+",v_str2="+gusrid+",v_str3=ReNew";
				gctr_pyo.post();
		}
	}else{
		//�űԻ��� 
		if (confirm("�޿���� "+gcem_appdt.text+" �����͸� �ϰ� ���� �Ͻðڽ��ϱ�?")){	
			gctr_pyo.Action = "/servlet/Person.h050020_t1?";
			gctr_pyo.Parameters = "v_str1="+gclx_gubun.bindcolval+",v_str2="+gusrid+",v_str3=New";
			gctr_pyo.post();
		}
	}
}



/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

  if(!ln_Chk()) return;

	if(gcds_chk.namevalue(gcds_chk.rowposition,"CNT")>=1){
		if(gcds_chk.namevalue(gcds_chk.rowposition,"CLOSEYN")=="C"){
			alert("������ �Ǿ����ϴ�. �������� �����սýÿ�.");
			return;
		}
	}

	if (gcds_data.IsUpdated) {
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			gctr_data.Action = "/servlet/Person.h050020_t2?";
			gctr_data.post();
		}	
	}
}

/******************************************************************************
	Description : �Է°� üũ[���°���]
******************************************************************************/
function ln_Valchk() {

  /*

	var row = gcds_data.rowposition;

	txt_SGDT.value = gcds_data.namevalue(row, "SGDT");
	txt_AGRDT.value = gcds_data.namevalue(row, "AGRDT");

	if (((txt_SGDT.value != "") && (txt_SGDT.value != "99999999")) || ((txt_AGRDT.value != "") && (txt_AGRDT.value != "99999999"))) { 
		alert("������ / ��������  ó�� �� �׸���  ���� �� �� �����ϴ�."); 
		return false;
	}
	
	if (gcem_frdt.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		gcem_frdt.focus()
		return false;
	}

	if (gcem_todt.text == "") { 
		alert("��Ȯ�� ��û �������� �Է��� �ֽʽÿ�."); 
		gcem_todt.focus()
		return false;
	}

	*/
	
	/**
	if (fn_trim(SGNM.value) == "") { 
		alert("��Ȯ�� �����ڸ� �Է��� �ֽʽÿ�."); 
		SGNM.value ="";
		SGNM.focus()
		return false;
	}
	**/

	return true;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
  /*

	if(!ln_Chk_Delete())return;
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
	  gcds_data.ClearAllMark();
		for(i=1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
				gcds_data.MarkRows(i,i);
			}
		}
		gcds_data.DeleteMarked();
		gctr_pyo.action = "/servlet/Person.h050005_t1?v_str1=" + gcem_to.text+ "&v_str2=" + gcem_empno_1.text;
		
		gctr_pyo.post();
		ln_Query();
	}

	*/
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

  gcgd_pyo.GridToExcel("���ð���","",2);

 
}


/******************************************************************************
	Description : �˾�
******************************************************************************/
function ln_Popup(gbn){

  
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(gbn=="1"){
	  if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
			return false;
		}
	}
	arrSend[0]="H050005";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmmk.value = arrParam[0]; //����
			
		} else {
			txt_empnmmk.value ="";			//����
		}
	}
}

/******************************************************************************
	Description : enable / disable
******************************************************************************/
function ln_Enable(p){

/*
	if (p=="T"){
		//gcem_empno_1.enable = true;
		//txt_empnmk_1.disabled = false ;
		//txt_deptnm.disabled = false ;
		//txt_paygrdnm.disabled = false ;
		gclx_LAZCD.enable = true;	//�ް�����
		gcem_frdt.enable = true;
		gcem_todt.enable = true;
		txt_DTYREM.disabled = false ;

	}else if (p=="F") {
		//gcem_empno_1.enable = false;
		gcem_empno_1.ReadOnly = true;
		txt_empnmk_1.ReadOnly = true ;
		//txt_deptnm.disabled = true ;
		//txt_paygrdnm.disabled = true ;
    gclx_LAZCD.enable = false;	//�ް�����
	//	gcem_frdt.enable = false;
	//	gcem_todt.enable = false;
		txt_DTYREM.disabled = true ;
	}

	*/
}


/******************************************************************************
	Description : data clear
******************************************************************************/
function ln_Clear(){
  /*
		gcem_empno_1.text = "";
		txt_empnmk_1.value= "" ;
		txt_deptnm.value = "" ;
		txt_paygrdnm.value = "" ;
		gclx_LAZCD.bindcolval = "";	//�ް�����
		gcem_frdt.text = "";
		gcem_todt.text = "";
		txt_DTYREM.value = "" ;	

		*/
}

/******************************************************************************
	Description : �����˾�
	Parameter :
******************************************************************************/
function ln_Submit(){
  /*
	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var cnt=0;
	var strFrdt="";
	var strTodt="";
	var yy="";
	var mm="";
	var dd="";
	var strFrtime="";
	var strTotime="";

	if(!ln_Chk_Submit()) return;
  
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			 arrMst[0]="HA4";                              //����ڵ�
			 arrMst[1]=gusrid;                             //����ڻ��
			 arrMst[2]=fn_trim(gcds_data.namevalue(i,"DIVNM"))  //+" / "+gcds_data.namevalue(i,"DEPTNM"); //�ٹ��μ���
			 arrMst[3]=gcds_data.namevalue(i,"EMPNO");    //���
			 arrMst[4]=gcds_data.namevalue(i,"PAYGRDNM"); //����
			 arrMst[5]=gcds_data.namevalue(i,"EMPNMK");   //����
			 break;
		}
  }

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}
	arrMst[6]=cnt;                                      //���ϱٹ��� �� 

	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			strFrdt = gcds_data.namevalue(i,"FRDT");       //������
			yy = strFrdt.substring(0,4);
			mm = strFrdt.substring(4,6);
			dd = strFrdt.substring(6,8);
			arrDtl[0+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd);  

			strTodt = gcds_data.namevalue(i,"FRDT");       //������
			yy = strTodt.substring(0,4);
			mm = strTodt.substring(4,6);
			dd = strTodt.substring(6,8);
			arrDtl[1+m]=yy+"/"+mm+"/"+dd+" "+gf_dayOfWeek(yy,mm,dd); 

			arrDtl[2+m]=gcds_data.namevalue(i,"LAZFEENM"); //���±���
			arrDtl[3+m]=gcds_data.namevalue(i,"DTYREM");   //��û����
			arrDtl[4+m]=gcds_data.namevalue(i,"HLNO");    //���¹�ȣ
			m+=5;
		}
  }
	
	//���ȣ��
	//document.all("ifrm").src ="../../Person/html/GP_form.html";
	ifrm.ln_Popup('HA4',arrMst,arrDtl);

	*/
}



/******************************************************************************
	Description : �޷°���
  parameter   : �������� ��� ������� key���̶� ���� ���ϰ� ����.
******************************************************************************/
function ln_Calendar(gbn){
  /*
	if(gcds_data.SysStatus(gcds_data.rowposition)!=1){
		return false;
	}
	if(gbn=="fr"){
		__GetCallCalendar('gcem_frdt','Text');
	}else if(gbn=="to"){
		__GetCallCalendar('gcem_todt','Text');
	}
	*/
}

/******************************************************************************
	Description : �����üũ
	Parameter :
******************************************************************************/
function ln_Chk_Submit(){
/*
	var cnt=0;
	_aa:
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"CLOSYN")!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"){
				alert("������ �� �����ϴ�. ������¸� Ȯ���Ͻʽÿ�.");
				return false;
  		}
			cnt+=1;

			//������ ��� 1�θ� ���� ����...
			for(j=1;j<=gcds_data.countrow;j++){
				if(gcds_data.namevalue(j,"CHK")=="T"){
					if(gcds_data.namevalue(i,"EMPNO")!=gcds_data.namevalue(j,"EMPNO")){
						alert("������ ����� ���� �����մϴ�.");
						return false;
						break _aa;
					}
				}
			}
		}
	}

	if(cnt==0){
		alert("������ ����� �����Ͻʽÿ�.");
		return false;
	}
	return true;

	*/
}


/******************************************************************************
	Description : ������ üũ
	Parameter :   N-������, R-ȸ��, B-�ݼ�, H-ȸ�� �� ����������.
******************************************************************************/
function ln_Chk_Delete(){
 /*
	var cnt=0;
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(fn_trim(gcds_data.namevalue(i,"CLOSYN"))!=""&&gcds_data.namevalue(i,"CLOSYN")!="N"&&gcds_data.namevalue(i,"CLOSYN")!="R"&&gcds_data.namevalue(i,"CLOSYN")!="B"&&gcds_data.namevalue(i,"CLOSYN")!="H"){
				alert("�ش���� ���� �� �� �����ϴ�.");
				return false;
  		}
			cnt+=1;
		}
	}

	if(cnt==0){
		alert("������ ����� �����Ͻʽÿ�.");
		return false;
	}
	return true;

	
	*/
}


/******************************************************************************
	Description : Dataset Head ���� -  
  parameter   : 1 - 
	              2 - 
******************************************************************************/
function ln_SetDataHeader(){
/*
	if(gcds_data.countrow<1){
		var THeader = "APPDT:String(8),EMPNO:String(7),LAZCD:String(4),DEPTCD:String(4),PAYSEQ:String(4),"
								+ "FRDT:String(8),TODT:String(8),DTYREM:String(100),"
								+ "CLOSYN:String(1),SGDT:String(8),SGNID:String(7),AGRDT:String(8),AGRID:String(7),"
								+ "PAYDT:String(8),AMT:Decimal(7),DEPTNM:String(50), PAYGRDNM:String(30),EMPNMK:String(20),"
								+ "LAZFEENM:String(20),BEFYEAR:String(3),CURYEAR:String(3),USEYEAR:String(3),PAYYEAR:String(3),"
								+ "SGNM:String(20),AGNM:String(20),DIVNM:String(50),CHK:String(1),HLNO:STRING(14)";
		gcds_data.SetDataHeader(THeader);								//Header Set
	}

	*/
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>
</comment><script>__ws__(__NSID__);</script>


<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
 <object id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t1(I:USER=gcds_temp)">
</object>

 <object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t2(I:USER=gcds_data)">
</object>

<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t4(I:USER=gcds_temp)">
</object>

<object id=gctr_data3 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050020_t5(I:USER=gcds_temp)">
</object>

</comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";

	

</script>








<!-- <script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>

	var row = gcds_data2.rowposition;

	if (txt_deptnm.value != "" && MINORNM.value != "" || gcds_data2.namevalue(row,"DEPTNM") != null) {
		txt_deptnm.value	= gcds_data2.namevalue(row,"DEPTNM");		//�ҼӸ�
		MINORNM.value = gcds_data2.namevalue(row,"MINORNM");	    //����
		txt_empnmk2.value	= gusrnm;																//����	
	} else {
		txt_deptnm.value	= "";
		MINORNM.value = "";
		txt_empnmk2.value	= gusrnm;	
	}

</script>
 -->
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_pyo event=OnClick(Row,Colid)>
  /*
	if(Row>0){
	  gcem_empno_1.text = gcds_data.namevalue(Row, "EMPNO");
		if(fn_trim(gcds_data.namevalue(Row,"CLOSYN"))!=""&&gcds_data.namevalue(Row,"CLOSYN")!="N"&&gcds_data.namevalue(Row,"CLOSYN")!="R"&&gcds_data.namevalue(Row,"CLOSYN")!="B"&&gcds_data.namevalue(Row,"CLOSYN")!="H"){
			ln_Enable("F");
		}else{
      ln_Enable("T");
		}
	}
	*/
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gctr_pyo" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_pyo" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_pyo.ErrorCode + "\n" + "Error Message : " + gctr_pyo.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_data2" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data2" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_data3" event="onsuccess()">//�����ڵ�
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>
<script language="javascript" for="gctr_data3" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data3.ErrorCode + "\n" + "Error Message : " + gctr_data3.ErrorMsg + "\n");
</script>



</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/h050020_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <FONT SIZE="" COLOR=""> �ݿ� �λ������� ����</FONT>&nbsp;
      <img src="../../Common/img/btn/com_b_banyoung.gif"   style="cursor:hand" onclick="ln_Update()">&nbsp;&nbsp;
		  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_finish.gif"  style="cursor:hand" onclick="ln_Close()">
		  <img src="../../Common/img/btn/com_b_create.gif"	style="cursor:hand" onclick="ln_Create()">
			<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>�޿����</nobr></td>
			<td width="210px" class="tab18"><nobr>&nbsp;<comment id="__NSID__"><nobr> 
				<object id=gcem_appdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1" style="position:relative;left:1px;top:2px;width:50px;height:20px;" >
					<param name=Text          value="">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_appdt', 'Text')" style="position:relative;width:20px;left:5px;cursor:hand;">
			</td>
			<td width="80px" align=center class="tab18" bgcolor="#eeeeee" ><nobr>���</nobr></td>
			<td width="130px" class="tab18" ><nobr>&nbsp;<comment id="__NSID__">
			<object id=gcem_empno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px;height:20px;  ">
					<param name=Text          value="">
					<param name=Alignment	    value=0>
					<param name=Border	      value=True>
					<param name=Format	      value="0000000">
					<param name=PromptChar	  value="_">
					<param name=BackColor     value="#CCCCCC">
					<param name=InheritColor  value=false>
					<param name=ReadOnly      value=false>
				</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td width="80px" align=center  class="tab18"  bgcolor="#eeeeee" ><nobr>����</nobr></td>
			<td class="tab18" >&nbsp;
				<input id="txt_empnmmk" name="txt_empnmmk" type="text"  class="txtbox"  style= "position:relative;left:-5px;top:-2px;width:90px;height:20px;"  maxlength="20" onBlur="bytelength(this,this.value,20);" onkeydown="if(event.keyCode==13) ln_Query();">
			  <img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-5px;top:2px;" onclick="ln_Popup('0')" >
			</td> 
			</tr>

			<tr>
			<td width="80px"  bgcolor="#eeeeee" class="tab17" align=center><nobr>���ñ���</nobr></td>
				<td class="tab19" style="width:140px;" align=center><nobr>&nbsp;
						<comment id="__NSID__">
						<object id=gclx_jtgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-20px;top:2px;" >
							<param name=CBData			    value="''^��ü,0^�ٹ�,1^��������,2^�ݰ�������,3^��������,4^��������,5^���������,6^��������">
							<param name=CBDataColumns	  value="MINORCD,MINORNM">
							<param name=SearchColumn		value="MINORNM">
							<param name=Sort						value="FALSE">
							<param name=ListExprFormat	value="MINORNM^0^100">
							<param name=BindColumn			value="MINORCD">
							<param name=Enable          value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</nobr>
				</td> 
       <td width="80px"  bgcolor="#eeeeee" class="tab19" align=center><nobr>����</nobr></td>
			 <td class="tab19" style="width:140px;" align=center colspan=3><nobr>&nbsp;
					<comment id="__NSID__">
					<object id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-20px;top:2px;" >
						<param name=CBData			    value="R^������,T^�����">
						<param name=CBDataColumns	  value="MINORCD,MINORNM">
						<param name=SearchColumn		value="MINORNM">
						<param name=Sort						value="FALSE">
						<param name=ListExprFormat	value="MINORNM^0^100">
						<param name=BindColumn			value="MINORCD">
						<param name=Enable          value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</nobr>
			</td> 
		</tr>
	</table>

	<tr>
	<td COLSPAN=2>
<!-- 		<table>
			<tr>
			<td>
 -->				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_pyo style="WIDTH:874px;HEIGHT:377px;border:1 solid #777777;display:block;" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data">
              <PARAM NAME="BorderStyle" VALUE="0">
							<param name="Fillarea"		VALUE="true">
              <param name=SortView      value="Left">
							<param name="ColSizing"   value="true">
							<param name=MultiRowSelect	value=true>
							<param name="editable"    value="true">
							<PARAM NAME="Format"			VALUE="  
								
								<C> Name='�޿����'	  ID=APPDT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=CENTER	sort= true Mask='XXXX/XX'   edit=none </C> 
								<C> Name='���'	   		ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=LEFT	  sort= true   edit=none </C>
								<C> Name='����'				ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80		  align=LEFT		sort= true   edit=none </C>
								<C> Name='���ñ���'		ID=JTGB 		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 		align=LEFT		sort= true  EditStyle=Combo		Data='0:�ٹ�,1:��������,2:�ݰ�������,3:��������,4:��������,5:���������,6:��������' BgColor=#ffffcc </C>
								<G> Name ='����μ�'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'    	  ID=CURDPT		HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=LEFT    sort= true edit=none</C> 
								<C> Name='��'    	    ID=CURDTPNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=LEFT    sort= true edit=none</C> 
								</G>
								<G> Name='�������μ�' HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ڵ�'	      ID=BEFDPT		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		  align=LEFT	sort= true  edit=none</C>
								<C> Name='��'	        ID=BEFDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		  align=LEFT	sort= true  edit=none</C>
								</G>
								<C> Name='������\\����'	ID=JTWK			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=CENTER	sort= true edit=none</C>
								<C> Name='����'	      ID=CLOSEYN	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		  align=CENTER	sort= true EditStyle=Combo		Data='C:����,N:������' edit=none</C>
								<C> Name='���'		    ID=REMARK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=132		align=LEFT		BgColor=#ffffcc </C>
							">
            </object></comment><script>__ws__(__NSID__);</script>
			  </td>
			  </tr>
			 </table>

<!-- 			</td>
			
		 </td>
		 </tr>
		</table>
 -->
 </td>
 </tr>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
  </tr>	
</table>




<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


