<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ������� - ������� �Է�
+ ���α׷� ID	:   H060004.html
+ �� �� �� ��	:   
+ �� �� �� ��	: 
+ �� �� �� ��	:   h060004_s1, h060004_s2, hclcode_s1, h060004_t1
------------------------------------------------------------------------------
+ �� �� �� �� : ��������Է�(����) �� ���п� �μ��� �߰�  
+ �� �� �� �� : 2009.11.05
+ ��   ��  �� : ������
+
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
/*******************************************************************************
Description :  ��������
gstr_yyymm   -- ������
gstr_empno   -- ���
gstr_grpcd   -- ���ޱ���(�����̻�/�븮����)
gstr_jobgrph -- ��������(�����/�繫��/������)
gstr_evaseq  -- ����
gstr_gubun   --  UserStatus ���� ( 1-insert, )
gstr_rowposition -- Row position
*******************************************************************************/
var gstr_yyyymm, gstr_empno, gstr_grpcd, gstr_jobgrph, gstr_evaseq,gstr_gubun, gstr_rowposition
get_cookdata();
lfn_init();

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	//gcem_yymm.text = gcurdate.substring(0,7); 

	//2008.12.01 ����Ⱓ�ʰ� �ؼ� ���Ƿ� ����
 // gcem_yymm.text ='200811';
	
	//2009.06.08 �ű��߰�
	gcds_evaym.DataID = "/servlet/Person.hclcode_s1?v_str1=2063";
	gcds_evaym.Reset();  

	gcem_yymm.text=gcds_evaym.namevalue(gcds_evaym.rowposition,"MINORNM");


	//strgcem_yyymm= gcem_yymm.text;
	txt_empnoh.value = gusrid;
	txt_empnmh.value = gusrnm;
	//gcra_divcd.CodeValue = '1';

	//�����ڵ�
	ln_Luxecombo_load();  
	gcra_gubun.CodeValue=1

}

/******************************************************************************
	Description : ��ȸ (�ǰ��������) OK
******************************************************************************/
function ln_Query(){

	if(gcra_gubun.codevalue=="3"){ //�μ��� 

		//����
		gcds_data.DataID = "/servlet/Person.h060004_s6?v_str1="+gcem_yymm.text		//������
										 +"&v_str2="+txt_empnoh.value	//�����	
										 +"&v_str3="+txt_empnm.value	//�ǰ����
										 +"&v_str4="+gcra_gubun.CodeValue;	//������ �����
    //prompt('',gcds_data.DataID);
		gcds_data.Reset(); 
		ln_Reset('q');

		 //����� 
		gcds_data5.DataID = "/servlet/Person.h060004_s7?v_str1="+gcem_yymm.text		//������
											+"&v_str2="+txt_empnoh.value //�����	
											+"&v_str3="+txt_empnm.value	 //�ǰ����
											+"&v_str4="+gcra_gubun.CodeValue;	//������ �����
    //prompt('',gcds_data5.DataID);
		gcds_data5.Reset(); 
		ln_Reset('q');

	}else{ //������, �����
    //����
		gcds_data.DataID = "/servlet/Person.h060004_s1?v_str1="+gcem_yymm.text		//������
														 +"&v_str2="+txt_empnoh.value	//�����	
														 +"&v_str3="+txt_empnm.value	//�ǰ����
														 +"&v_str4="+gcra_gubun.CodeValue;	//������ �����
		gcds_data.Reset(); 

		ln_Reset('q');
    //����� 
		gcds_data5.DataID = "/servlet/Person.h060004_s5?v_str1="+gcem_yymm.text		//������
														 +"&v_str2="+txt_empnoh.value	//�����	
														 +"&v_str3="+txt_empnm.value	//�ǰ����
														 +"&v_str4="+gcra_gubun.CodeValue;	//������ �����
		gcds_data5.Reset(); 
		ln_Reset('q');
	}
}

/******************************************************************************
	Description : ��ȸ (���ǥ  �� ������) OK
******************************************************************************/
function ln_Query2(){

	if(gcra_gubun.codevalue=="3"){ //�μ��� 
		gcds_data2.DataID = "/servlet/Person.h060004_s8?v_str1="+gstr_yyyymm						//������
                                                          +"&v_str2="+gstr_empno						//�ǰ���ڻ��
																													+"&v_str3="+gstr_grpcd					   //����(�����̻�/�븮����)
																													//+"&v_str4="+gcra_divcd.CodeValue//�ι�(�ɷ°��/�������)
																													+"&v_str5="+gstr_jobgrph		      //����&(�繫��or�����or������)
																													+"&v_str6="+txt_empnoh.value			//�����
																													+"&v_str7="+gstr_evaseq;					//����
		gcds_data2.Reset(); 
	}else{  //������/�����
		gcds_data2.DataID = "/servlet/Person.h060004_s2?v_str1="+gstr_yyyymm						//������
                                                          +"&v_str2="+gstr_empno						//�ǰ���ڻ��
																													+"&v_str3="+gstr_grpcd					   //����(�����̻�/�븮����)
																													//+"&v_str4="+gcra_divcd.CodeValue//�ι�(�ɷ°��/�������)
																													+"&v_str5="+gstr_jobgrph		      //����&(�繫��or�����or������)
																													+"&v_str6="+txt_empnoh.value			//�����
																													+"&v_str7="+gstr_evaseq;					//����
		gcds_data2.Reset(); 
	}
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

  //���� ����
	/*
  if(gusrid!="6070001"&&gusrid!="2020008"&&gusrid!="2050045"&&gusrid!="1990072"
	  &&gusrid!="1990101"&&gusrid!="1990025"&&gusrid!="2070034"&&gusrid!="2070031"
	){
		alert("����Է±Ⱓ�� �������ϴ�.");
		return false;
	}
	

	if(gusrid!="2020008"){
		alert("����Է±Ⱓ�� �������ϴ�.");
		return false;
	}

	*/


/*
	if(gusrid!="1990086"&&gusrid!="1990101"&&gusrid!="1990025"&&gusrid!="2040013"&&gusrid!="2040022"&&gusrid!="1990005"&&gusrid!="2070031"){
		alert("����Է±Ⱓ�� �������ϴ�.");
		return false;
	}
*/

	if(gcem_yymm.text<'201106'){
		alert("�ش� ����� ������ �� �����ϴ�.");
		return;
	}

	

  if (fn_trim(txt_empnoh.value)=="") {
		alert("����ڸ� �ٽ� ������ �ֽʽÿ�");
		return; 
	}

	if (gcds_data2.countrow<1){
	alert ("������ ������ �����ϴ�.");
	}else {
		if(ln_Chk()){
			if (confirm("�����Ͻðڽ��ϱ�?")) {
				ln_Datasave();
				if(gcra_gubun.codevalue=="3"){ //�μ��� 
          gctr_data.action = "/servlet/Person.h060004_t2";
        }else{ //������, �����
					gctr_data.action = "/servlet/Person.h060004_t1";
				}
			
			  //prompt("gcds_data2",gcds_data2.text);
				gctr_data.post();
				ln_Reset('r');
				ln_Query();
				ln_Query2();
			}
		}//if ln_Chk
	}
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
	alert("�������Դϴ�.");
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	gcgd_data2.RunExcel('�������');
}


/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

	//�ι�
	gcds_divcd.DataID = "/servlet/Person.hclcode_s1?v_str1=2015"; 
	gcds_divcd.Reset();

}

/******************************************************************************
	Description : Insert Data ����
	                   �����   �����, �ǰ����,���� ����
******************************************************************************/
function ln_Datasave(){

	for ( i=1;i<=gcds_data2.countrow;i++){
		if ((gcds_data2.SysStatus(i)==2)||(gcds_data2.SysStatus(i)==3)){
			gcds_data2.namevalue(i,"EMPNOH")=	fn_trim(txt_empnoh.value);
			gcds_data2.namevalue(i,"EMPNO")	=	gstr_empno;
			gcds_data2.namevalue(i,"EVASEQ")=	gstr_evaseq; 
		}
  }
}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){

	if (gcds_data2.IsUpdated){
		if(ln_Chk2()){
			return true;
			//alert("1");
		}else{
			return false;
			//alert("2");
		}
	}else{
		return false;
		//alert("3");
	}	
}

function ln_Chk2(){
	
	for (i=1;i<=gcds_data2.countrow;i++){
		if (gcds_data2.namevalue(i,"CHK01") == "F" && gcds_data2.namevalue(i,"CHK02") == "F"  
		 && gcds_data2.namevalue(i,"CHK03") == "F" && gcds_data2.namevalue(i,"CHK04") == "F" 
		 && gcds_data2.namevalue(i,"CHK05") == "F"){
			alert("��� �򰡿�Ҹ� üũ�Ͻʽÿ�");
      gcds_data2.rowposition = i;
  		return false;
			break;
		}
	}
	return true;
}

/******************************************************************************
	Description : ����� ���� Grid �ʱ�ȭ
	parameter - q : query��   r -reset �ʱ�ȭ
******************************************************************************/
function ln_Reset(p){

	if(p=="r"){
		if (gcds_data2.countrow>=1){
			gcds_data2.ClearData();	 
		}else{
			alert("�ʱ�ȭ �� �����Ͱ� �������� �ʽ��ϴ�.");
		}
	}else if(p=="q"){
		if (gcds_data2.countrow>=1) gcds_data2.ClearData();
	}
}


/******************************************************************************
	Description : ������� ( ������/����� ) 
******************************************************************************/
function ln_Corcal(){

  if(confirm("��������� �Ͻðڽ��ϱ�?")){
		gcds_col.DataID = "/servlet/Person.h060004_p5?v_str1="+gcem_yymm.text		//������
																												+"&v_str2="+txt_empnoh.value;	//�����
		gcds_col.Reset(); 
	}
}

/******************************************************************************
	Description : ������� ( �μ��� ) 
******************************************************************************/
function ln_Corcal2(){
  
	gcds_col2.DataID = "/servlet/Person.h060004_p6?v_str1="+gcem_yymm.text		//������
														                          +"&v_str2="+txt_empnoh.value;	//�����
	gcds_col2.Reset();

}


/******************************************************************************
	Description : �����ȸ
******************************************************************************/
function ln_FindEmp(e, row){
  if ( gusrid!="2020008"  && gusrid!="2050045" && gusrid!="6070001" && gusrid!="1990072"  ) return;
  var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

/*
	gs_level = '';
	gs_treecd ='';
	gs_level = gclx_deptcd.ValueOfIndex ("level", gclx_deptcd.Index);
	gs_treecd = gclx_deptcd.ValueOfIndex ("treecd", gclx_deptcd.Index);

	if (gs_treecd.length!=0 && gs_level!=0){
		gs_treecd = fn_treecd(gs_level, gs_treecd);
		arrParam[0]=gs_level;  
		arrParam[1]=gs_treecd;
	}else {
		arrParam[0]='';  
		arrParam[1]='';
	}
*/  
	strURL = "./H060004_popup.html";
	strPos = "dialogWidth:377px;dialogHeight:383px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];
   
		if (e=="txt_empnmh") {
		  txt_empnmh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];

		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];			
		}
	} else {
		//eval(e).value = "";
		if (e=="txt_empnmh") {
		  txt_empnmh.value="";
			txt_empnoh.value ="";
		}
	}
}


/******************************************************************************
	Description : ���������ȸ
******************************************************************************/
function ln_Grid_Onclick(gubun,row){
  gstr_yyyymm ="";
	gstr_empno = "";
	gstr_grpcd = "";
	gstr_jobgrph = "";
	gstr_evaseq = "";

	if(gubun=="1"){
		gstr_yyyymm		= gcds_data.namevalue(row,"EVAYM");
		gstr_empno		= gcds_data.namevalue(row,"EMPNO");
		gstr_grpcd		= gcds_data.namevalue(row,"GRPCD");
		gstr_jobgrph	= gcds_data.namevalue(row,"JOBGRPH");
		gstr_evaseq		= gcds_data.namevalue(row,"EVASEQ");
		gstr_rowposition =	gcds_data.RowPosition;
	}else if(gubun=="5"){
		gstr_yyyymm		= gcds_data5.namevalue(row,"EVAYM");
		gstr_empno		= gcds_data5.namevalue(row,"EMPNO");
		gstr_grpcd		= gcds_data5.namevalue(row,"GRPCD");
		gstr_jobgrph	= gcds_data5.namevalue(row,"JOBGRPH");
		gstr_evaseq		= gcds_data5.namevalue(row,"EVASEQ");
		gstr_rowposition =	gcds_data5.RowPosition;
	}
	
	ln_Query2();
}

/******************************************************************************
	Description : �����Ű�
******************************************************************************/
function ln_Work(){
	var result="";
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

 /*

	if(gstr_empno==""||gstr_empno==undefined){
		alert("�ǰ���ڸ� �����Ͻʽÿ�.");
		return;
	}

	if(gstr_empno.substring(0,1)=="3"||gstr_empno.substring(0,1)=="4"){
		alert("�����Ű� �ۼ� ����ڰ� �ƴմϴ�.")
		return;
	}

	*/

  //gstr_yyyymm="200711";
  //gstr_empno="1990057";
	//gstr_empno="2060005"; //<200
	//gstr_empno="2040081"; //<270
	//gstr_empno="2030005"; //<350
	//gstr_empno="2050051"; //<570
	//gstr_empno="2030005"; //<570


	arrParam[0]=gstr_yyyymm; //���
  arrParam[1]=gstr_empno; //���

	strURL = "./H060004_popup2.html";
	strPos = "dialogWidth:880px;dialogHeight:630px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

  /*
 	if (result != null) {
		arrResult = result.split(";");
		//eval(e).value  = arrResult[0];
   /*
		if (e=="txt_empnmh") {
		  txt_empnmh.value = arrResult[0];
			txt_empnoh.value = arrResult[1];

		}else if(e=="EMPNMKH"){
		  gcds_data2.namevalue(row,"EMPNMKH")= arrResult[0];
      gcds_data2.namevalue(row,"EMPNOH") = arrResult[1];			
		}
	} else {
		//eval(e).value = "";
		if (e=="txt_empnmh") {
		  txt_empnmh.value="";
			txt_empnoh.value ="";
		}
	}
	*/
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--����-->
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--�����-->
<comment id="__NSID__"><OBJECT id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!--����ι�-->
<comment id="__NSID__"><object id="gcds_divcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!--�������-->
<comment id="__NSID__">
 <OBJECT id=gcds_col classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_col2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
	<OBJECT id=gcds_evaym classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true"><!-- ������ -->
	</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"  value="toinb_dataid4">
	<param name="keyvalue" value="h060004_t1(I:USER=gcds_data2)">
</object></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	//if (rowcount ==0 )	alert("�˻��� ����Ÿ�� �����ϴ�."); 

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	gcds_data.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data5 event=OnLoadCompleted(rowcount)>
	lbl_search5.innerText = "�� ( " + rowcount + " ) ��";
	gcds_data5.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	//if (rowcount ==0 )	alert("�˻��� ����Ÿ�� �����ϴ�."); 
	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	gcds_data.RowPosition=gstr_rowposition;
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>

<script language=JavaScript  for=gcds_col event="OnLoadStarted()" >
	window.status="������� ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_col event=OnLoadCompleted(rowcount)>
	//window.status="��������� �Ϸ� �Ǿ����ϴ�.";
	////document.all.LowerFrame.style.visibility="hidden";
	if (rowcount==0) { 
		alert("������� ���� �ʾҽ��ϴ�.");
	}else{
		if(gcds_col.namevalue(1, "RETCOD") =="Y"){
			//alert("���������� ������� �Ǿ����ϴ�.");
			//ln_Query();
      //ln_Query2();
			ln_Corcal2(); //�μ��� 
		}else if (gcds_col.namevalue(1, "RETCOD") =="N"){
			alert("���������� ������� ���� �ʾҽ��ϴ�.");
		}	
	}
</script>

<script language=JavaScript  for=gcds_col2 event=OnLoadCompleted(rowcount)>
	window.status="��������� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (rowcount==0) { 
		alert("������� ���� �ʾҽ��ϴ�.");
	}else{
		if(gcds_col.namevalue(1, "RETCOD") =="Y"){
		  window.setTimeout('', 1000);
			alert("���������� ������� �Ǿ����ϴ�.");
			ln_Query();
      //ln_Query2();
		}else if (gcds_col.namevalue(1, "RETCOD") =="N"){
			alert("���������� ������� ���� �ʾҽ��ϴ�.");
		}	
	}
</script>


<script language="javascript"	for="gcgd_data2" event="OnClick(row,col)">
	
	if ("CHK01" == col || "CHK02" == col || "CHK03" == col || "CHK04" == col || "CHK05" == col) {
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK01") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK02") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK03") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK04") = "F";
		gcds_data2.namevalue(gcds_data2.rowposition,"CHK05") = "F";

		if ("CHK01" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK01") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "1";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"ESCR");
		}else if ("CHK02" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK02") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "2";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"GSCR");
		}else if ("CHK03" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK03") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "3";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"MSCR");
		}else if ("CHK04" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK04") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "4";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"LSCR");
		}else if ("CHK05" == col) {
			gcds_data2.namevalue(gcds_data2.rowposition,"CHK05") = "T";
			gcds_data2.namevalue(row,"SCRGBN") = "5";
			gcds_data2.namevalue(row,"SCR") = gcds_data2.namevalue(row,"PSCR");
		}
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_data event=OnClick(Row,Colid)>
	ln_Grid_Onclick('1',Row);
</script>

<script language="javascript"  for=gcgd_data5 event=OnClick(Row,Colid)>
	ln_Grid_Onclick('5',Row);
</script>

<!--<script language=JavaScript for=gcra_divcd event=OnSelChange()>
	if (gcds_data.rowposition<1) return;
		gstr_yyyymm		=	"";
		gstr_empno		= "";
		gstr_grpcd		= "";
		gstr_jobgrph	= "";
		gstr_evaseq		= "";

		gstr_yyyymm		= gcds_data.namevalue(gcds_data.rowposition,"EVAYM");
		gstr_empno		= gcds_data.namevalue(gcds_data.rowposition,"EMPNO");
		gstr_grpcd		= gcds_data.namevalue(gcds_data.rowposition,"GRPCD");
		gstr_jobgrph	= gcds_data.namevalue(gcds_data.rowposition,"JOBGRPH");
		gstr_evaseq		= gcds_data.namevalue(gcds_data.rowposition,"EVASEQ");
		
		gstr_rowposition =gcds_data.RowPosition;
		ln_Query2();
</script>-->

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
    alert("���忡 �����Ͽ����ϴ�");
</script>
 <jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h060004_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
		  <img src="../../Common/img/btn/btn_work.gif"		style="cursor:hand;"  onclick="ln_Work()">
			<img src="../../Common/img/btn/com_b_cor.gif"		style="cursor:hand;"  onclick="ln_Corcal()">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand"		onclick="ln_Excel()">
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand"		onclick="ln_Print()"> -->
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand"		onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr>
		<td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'></td>
				<tr>
						<td width="10"   style="border:0 solid #708090;border-right-width:1px;text-aglin:center" bgcolor="#eeeeee"><nobr>������</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
								style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; "> 
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr>
						</td>
						<td width="0" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;text-aglin:center" bgcolor="#eeeeee"><nobr >&nbsp;�����</nobr></td>
						<td style="height:30px;border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;
							<input  id="txt_empnmh" name="txt_name" type="text" style="position:relative; left:-8px;top:-2px; width:60px; size=20"  class="txt21" disabled>
							</nobr>
							<img src="../../Common/img/btn/com_b_find.gif" alt="����ڸ� �˻��մϴ�" style="position:relative;left:-9px;top:2px;cursor:hand;" onclick="ln_FindEmp('txt_empnmh','')">
							<input type="hidden" width="0" id="txt_empnoh">
						</td>
						<td width="0" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;text-aglin:center" bgcolor="#eeeeee"><nobr >&nbsp;�ǰ����</nobr></td>
						<td style="height:30px;border:0 solid #708090;"><nobr>&nbsp;
							<input  id="txt_empnm" name="txt_name" type="text"  style="position:relative; left:-8px; width:100px; size=20" class="txt21" onkeydown="if(event.keyCode==13) ln_Query();"> </nobr>
						</td>
						<td width="50px" align=LEFT style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;;text-aglin:center" bgcolor="#eeeeee"><nobr >&nbsp;&nbsp;����</nobr></td>
						<td style="height:30px;border:0 solid #708090;"><nobr>&nbsp;
							<comment id="__NSID__"><object id=gcra_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:20; width:200">
						  <param name=Cols	value="3">
			        <param name=Format	value="1^������,2^�����,3^�μ���">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
						<!-- <td width="100%" align=RIGHT><nobr>&nbsp;</nobr></td> -->
				</tr>
			</table> 
		</td>
	</tr>
	<tr><td height=3 colspan="2"></td></tr>

	<tr> 
		<td colspan=2>
			<table width="876" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:373px;" align=center valign=top>
							<table width="373px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:373px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data  style="WIDTH: 371px;; HEIGHT: 215px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=ViewSummary	    value=1>      
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<FC> Name='������'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' SumText=��� sumbgcolor=#89add6  BgColor='#f5f5f5'  show=false</FC>
													<FC> Name='�ǰ����'	ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		show=false</FC>
													<FC> Name='�Ҽ�'			ID=DEPTCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left   show=false </FC>
													<FC> Name='����:�Ҽ�'	ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<FC> Name='����'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left		show=false</FC>
													<FC> Name='����'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=left   sumbgcolor=#89add6  BgColor='#f5f5f5' SumText='�� ��'</FC>
													<FC> Name='�ǰ����'	ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<C> Name='����'				ID=SCR			HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right	SumText={Round(avg(SCR),2)}  	    sumbgcolor=#89add6</C>
													<C> Name='����'				ID=AVGSCR		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right  SumText={Round(avg(AVGSCR),1)} 		sumbgcolor=#89add6</C>
													<C> Name='��'				ID=ASSES		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center sumbgcolor=#89add6  Value=''</C>
													<C> Name='����׷�'		ID=GRPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show=false</C>
													<C> Name='����׷�'		ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show= false </C>

					
											"> 
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
						 </table>
						</td>

						<td style="width:500px;" align=center valign=top rowspan=2>
							<table width="500px" cellpadding="0" cellspacing="0" border="0">
							  <tr><td height=5></td></tr>
								<tr>
									<!-- <td width="500px" align=RIGHT><nobr>&nbsp;</nobr></td> -->
									<td style="height:30px;border:0"  ALIGN=RIGHT><nobr>
										<img src="../../Common/img/btn/com_b_reset.gif" style="cursor:hand"  onclick ="ln_Reset('r')" >
										<img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand"  onclick="ln_Save()">&nbsp;</nobr></td>
								</tr>
								<tr> 
									<td style="width:500px" align=LEFT valign=top   border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH: 499px; HEIGHT: 389px;border:1 solid #777777;z-index:2;border-TOP-width:1px;" viewastext>
												<PARAM NAME="DataID"			VALUE="gcds_data2">
												<PARAM NAME="Editable"    VALUE="false">
												<PARAM NAME="BorderStyle" VALUE="0">
												<param name=ViewSummary	  value=1>
												<param name="Fillarea"		VALUE="true">
												<param name=IndWidth      value="0">
												<PARAM NAME="Format"			VALUE="  
												<C> Name='����'			ID=JOBGRPH	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=RIGHT		Edit=none  show=false  </C>   
												<C> Name='����'			ID=JOBGRPNM HeadAlign=Center HeadBgColor=#B9D4DC Width=45		align=left		Edit=none  show=false SumText=�հ� sumbgcolor=#89add6 </C>   
												<C> Name='�׸񱸺�' ID=GRPITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=RIGHT		Edit=none  show=false</C>  
												<C> Name='�׸񱸺�' ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=95		align=left		Edit=none  show=false sumbgcolor=#89add6</C> 
												<C> Name='����'     ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	Edit=none  sumbgcolor=#89add6</C> 
												<C> Name='����'			ID=PRTSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=30		align=Center	Edit=none  sumbgcolor=#89add6</C>
												<C> Name='�򰡿��'	ID=ASKITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=148	align=left		Edit=none  sumbgcolor=#89add6 SumText='�� ��'</C>
											<G>Name='��   ��' 		HeadAlign=Center HeadBgColor=#B9D4DC Width=200
												<C> Name='Ź��'			ID=CHK01		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='���'			ID=CHK02		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='����'			ID=CHK03		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='����'			ID=CHK04		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
												<C> Name='����'			ID=CHK05		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		EditStyle=CheckBox	Pointer=Hand	align=center sumbgcolor=#89add6</C>
											</G>
												<C> Name='����'			ID=SCR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=RIGHT		Edit=none  SumText=@sum  sumbgcolor=#89add6</C> ">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
						 </table>
						</td>
					</tr>

					<tr> 
						<td style="width:373px;" align=center valign=top >
							<table width="373px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:373px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data5  style="WIDTH: 371px;; HEIGHT: 205px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data5">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=ViewSummary	    value=1>      
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<FC> Name='������'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' SumText=��� sumbgcolor=#89add6  BgColor='#f5f5f5'  show=false</FC>
													<FC> Name='�ǰ����'	ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		show=false</FC>
													<FC> Name='�Ҽ�'			ID=DEPTCD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left   show=false </FC>
													<FC> Name='�����:�Ҽ�'	ID=DEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=95  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<FC> Name='����'			ID=PAYGRD		HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left		show=false</FC>
													<FC> Name='����'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=left   sumbgcolor=#89add6  BgColor='#f5f5f5' SumText='�� ��'</FC>
													<FC> Name='�ǰ����'	ID=EMPNMK		HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=left		sumbgcolor=#89add6  BgColor='#f5f5f5'</FC>
													<C> Name='����'				ID=SCR			HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right	SumText={Round(avg(SCR),2)}			sumbgcolor=#89add6</C>
													<C> Name='����'				ID=AVGSCR		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=right  SumText={Round(avg(AVGSCR),1)}	sumbgcolor=#89add6</C>
													<C> Name='��'				ID=ASSES		HeadAlign=Center HeadBgColor=#B9D4DC Width=40  align=center sumbgcolor=#89add6    Value=''</C>
													<C> Name='����׷�'		ID=GRPCD		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show=false</C>
													<C> Name='����׷�'		ID=GRPNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=right  show= false </C>
											">
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>	
						 </table>
						</td>
					</tr>
					<tr>
						<td height="24"  style="width:380px">����Ǽ� : <label id="lbl_search"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ܰǼ� : <label id="lbl_search5"></label></td>
						<td height="24"  style="width:500px">��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
					</tr>	
			</table>
		</td>
	<tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>