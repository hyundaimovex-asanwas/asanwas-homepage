<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:  �������� - ������ǥ���Һ�
+ ���α׷� ID	:  A200001.html
+ �� �� �� ��	:  ���޾��� ���,����,����,��ȸ �� ��� ȭ���̴�.
+ ��   ��  ��      :  �� ����
+ �� �� �� ��	:  a200001_s1
------------------------------------------------------------------------------>

<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������ǥ���Һ�</title>
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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3 = gcurdate.substring(0,4);
var gs_date4 = gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var gs_usrid = gusrid;
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_DispChk(0);
	ln_Before();
	ln_SetDataHeader();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		gcem_refcode21.enable = "false";
		gcem_billcnt.text="";
		var str1  = gclx_sfdcode1.BindColVal;				//�����ڵ�   
		var str2  = gclx_sbcdiv.BindColVal;					//����       
		var str3  = fn_trim(gcem_sgetdatefr1.text);	//��������fr
		var str4  = fn_trim(gcem_sgetdateto2.text);	//��������to 
		var str5  = gcem_sbancodnm1.text;						//�����   
		var str6  = gcem_sbancod1.text;							//�����ڵ�   
		var str7  = gclx_sstdiv1.BindColVal;				//ó������
		
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7;
		gcds_data1.Reset();
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.BindColVal;				//�����ڵ�   
		var str2  = gclx_sbcdiv2.BindColVal;				//����       
		var str3  = fn_trim(gcem_losdate1.text);		//��������fr
		var str4  = fn_trim(gcem_losdate2.text);		//��������to 
		var str5  = gcem_sbancodnm2.text;						//�����   
		var str6  = gcem_sbancod2.text;							//�����ڵ�   
		var str7  = gclx_sstdiv2.BindColVal;				//ó������   

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7;
		gcds_data2.Reset();
	}else if(s=="03") {
		var str1  = gclx_sfdcode3.BindColVal;				//�����ڵ�   
		var str2  = gclx_sbcdiv3.BindColVal;				//����       
		var str3  = fn_trim(gcem_stdatefr3.text);		//��������fr
		var str4  = fn_trim(gcem_stdateto3.text);		//��������to 
		var str5  = gcem_sbancodnm3.text;						//�����   
		var str6  = gcem_sbancod3.text;							//�����ڵ�   
		var str7  = gclx_sstdiv3.BindColVal;				//ó������   

		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_s3"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7;
		gcds_data3.Reset();
	}
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){
	gcds_data1.ClearData();
	gcds_temp1.ClearData();
	gcds_data1.AddRow();
	gcem_bancodnm1.text = '';
	gcem_getdate1.text = gs_date;		//��������
	gcem_stdate1.text = gs_date;		//ó������
	gclx_stdiv1.index = 0;					//ó������
	gclx_sbcdiv1.bindcolval = "B";	//����
	gcem_refcode21.enable = "true";
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){
	if(gcds_data1.IsUpdated) {
		if(ln_Chk()) {
			gctr_data1.KeyValue = "Account.a200001_t1(I:USER=gcds_temp1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gctr_data1.post();
			ln_Query('01');
		}
	}
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk() {
	
	//�̹����� �ƴϸ� skip
	if(gclx_stdiv1.BindColVal != '0') {
		alert('�̹����� �ƴϸ� ���� �� ��� �Ұ�');
		return false;
	}
	
	//�����ڵ�üũ
	if(gcem_bancod1.text == "") {
		alert('�����ڵ带 �Է��� �ּ���');
		return false;
	}

	for(var i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.SysStatus(i)==3){
			gctr_data1.KeyValue = "Account.a200001_t1(I:USER=gcds_data1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gctr_data1.post();
			ln_Query('01');
			return false;
		}else if(gcds_data1.SysStatus(i)==1){
			if (fn_trim(gcem_billcnt.text)==0){
				alert("�ż��� �Է��Ͻʽÿ�.");
				gcem_billcnt.focus();
				return false; 
			}
		}
	}

	//���ںκи� ����
	var tempNum = '';
	var tempChar = '';
	var tempStr = '';
	var tempCnt = 0;

	var splitString = gcem_refcode21.text.split('');
	for(var i=0;i<=splitString.length-1;i++) {
		if(isNaN(splitString[i])) {
			tempChar = tempChar + splitString[i];
		}
		if(isFinite(splitString[i])) {
			tempNum = tempNum + splitString[i];
		}
	}

	if(fn_trim(gcem_billcnt.text)!=0){ //�ż�
		var cnt = fn_trim(gcem_billcnt.text);
		if(gclx_sbcdiv.BindColVal=="B") {//����
			str1 = "0000000";	//��������
			str2 = "60";			//�ڱݱ���
		}else if(gclx_sbcdiv.BindColVal=="C") {//��ǥ
			str1 = "0000000";
			str2 = "60";
		}
		for(var i=1;i<=cnt;i++){
			gcds_temp1.AddRow();
			tempStr = tempChar + tempNum;
			gcds_temp1.namevalue(i,"REFCODE2") = tempStr;                       //������ǥ��ȣ
			gcds_temp1.namevalue(i,"FDCODE")  = gclx_sfdcode1.BindColVal;       //����
			gcds_temp1.namevalue(i,"ATCODE")  = str1;							//��������
			gcds_temp1.namevalue(i,"FUNDDIV") = str2;							//�ڱݱ���
			gcds_temp1.namevalue(i,"BANCOD")  = gcem_bancod1.text;				//����
			gcds_temp1.namevalue(i,"GETDATE") = gcem_getdate1.text;				//������
			gcds_temp1.namevalue(i,"GETMEN")  = gcem_getmen1.text;				//������
			gcds_temp1.namevalue(i,"BCDIV")   = gclx_sbcdiv.BindColVal;			//����
			gcds_temp1.namevalue(i,"STDIV")   = gclx_stdiv1.BindColVal;			//ó������
			gcds_temp1.namevalue(i,"STDATE")  = gcem_stdate1.text;				//ó������
			
			tempCnt = parseInt(tempNum);
			tempCnt = tempCnt + 1;
			tempNum = getZero(tempNum) + String(tempCnt);
		}
	}
	return true;
}
/******************************************************************************
	Description : zero���ھ�� �Լ�
******************************************************************************/
function getZero(tmpNum) {
	var tempZero = '';
	if(tmpNum.substr(0,1)=='0'){
		var tempDec = tmpNum.split('');
		for(var j=0;j<=tempDec.length-1;j++) {
			if(tempDec[j]=='0') {
				tempZero = tempZero + tempDec[j];
			}
		}
	}
	return tempZero;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(e){
	//�̹����� �ƴϸ� skip
	if(gclx_stdiv1.BindColVal != '0') {
	alert('�̹����� �ƴϸ� ���� �Ұ�');
	return false;
	}

	if(e=="01"){
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			gcds_data1.DeleteRow(gcds_data1.RowPosition);
			gctr_data1.KeyValue   = "Account.a200001_t1(I:USER=gcds_data1)";
			gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gctr_data1.post();
			ln_Query('01');
		}
	}
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_data = "FDCODE:STRING,ATCODE:STRING,FUNDDIV:STRING,BANCOD:STRING,REFCODE2:STRING," 
				+ "GETDATE:STRING,GETMEN:STRING,BCDIV:STRING,STDIV:STRING,STDATE:STRING";
	gcds_data1.SetDataHeader(s_data);
	
	var s_temp = "FDCODE:STRING,ATCODE:STRING,FUNDDIV:STRING,BANCOD:STRING,REFCODE2:STRING," 
	           + "GETDATE:STRING,GETMEN:STRING,BCDIV:STRING,STDIV:STRING,STDATE:STRING";
	gcds_temp1.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : �н�ȸ��
******************************************************************************/
function ln_ReBranch(){
	if(gcds_data1.countrow>0){
		var row = gcds_data1.rowposition;
		if(gcds_data1.namevalue(row,"STDIV")!="4"){
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			var row = gcds_data1.rowposition;

			strURL = "./loss_popup.jsp";
			arrParam[0]=gcds_data1.namevalue(row,"FDCODE");		//�����ڵ�
			arrParam[1]=gcds_data1.namevalue(row,"ATCODE");		//�����ڵ�
			arrParam[2]="50";																	//�ڱݱ���(��������)
			arrParam[3]=gcds_data1.namevalue(row,"REFCODE2");	//������ȣ

			if(arrParam[0]==""||arrParam[1]==""||arrParam[2]==""||arrParam[3]==""){
				alert("�ʼ��׸��� �Էµ��� �ʾ� ó���� �� �����ϴ�.");
				return false;
			}

			strPos = "dialogWidth:320px;dialogHeight:240px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
		}else alert("�н�ȸ������ �ƴմϴ�.");
	}else alert("�н�ȸ���� ������ �����ϴ�.");
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Disuse(){
	if(gcds_data1.countrow>0){
		var row = gcds_data1.rowposition;
		if (confirm("���ó�� �Ͻðڽ��ϱ�?")){	
			gcds_data1.namevalue(row,"STDIV")="4";	//ó������(���)
			gctr_data1.KeyValue = "Account.a200001_t1(I:USER=gcds_data1)";
			gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a200001_t1";
			gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+gs_usrid;
			gctr_data1.post();
			ln_Query('01');
		}
	}else alert("���ó���� ������ �����ϴ�.");
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
	alert("�غ����Դϴ�.");
  /*if(e=="01") {
		if(gcds_print1.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcrp_print1.preview();
		}
	}else if(e=="02") {
		if(gcds_print2.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcrp_print2.preview();
		}
	}else if(e=="03") {
		if(gcds_print3.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcrp_print3.preview();
		}
	}*/
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
  if(e=="01") {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('������ǥ���');
	}else if(e=="02") {
		if (gcds_data2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp02.RunExcel('�н�ȸ����Ȳ');
	}else if(e=="03") {
		if (gcds_data3.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp03.RunExcel('�����Ȳ');
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){

	/*������ǥ��� �׸� ��ȸ**************************************************/
	
	gcem_sgetdatefr1.text = gs_date2+"01";	//[�˻�]����from
	gcem_sgetdateto2.text = gs_date;				//[�˻�]����to
	gcem_getdate1.text    = gs_date;				//[�Է�]��������
	gcem_stdate1.text     = gs_date;				//[�Է�]ó������
	gclx_sstdiv1.index    = 1;							//[�˻�]ó������
	gclx_stdiv1.index     = 0;							//[�Է�]ó������
	
	//�����ڵ�[�˻�]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	/*�н�ȸ����Ȳ �׸� ��ȸ**************************************************/
	gcem_losdate1.text = gs_date2+"01";	//[�˻�]�н�from
	gcem_losdate2.text = gs_date;		//[�˻�]�н�to
	gclx_sstdiv2.index = 3;				//[�˻�]ó������

	//�����ڵ�[�˻�]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	/*�����Ȳ �׸� ��ȸ**************************************************/
	gcem_stdatefr3.text = gs_date2+"01";	//[�˻�]���from
	gcem_stdateto3.text = gs_date;			//[�˻�]���to
	gclx_sstdiv3.index  = 5;				//[�˻�]ó������

	//�����ڵ�[�˻�]
	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode3.Reset();

	gclx_stdiv1.enable = "false";
	gcem_stdate1.enable = "false";

	//�����ڵ�
	gcds_bank.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0022";
	gcds_bank.Reset();

}

/***********************************************************************************************
	Description : ���� ã��
	parameter   : arrParam[0] - �����ڵ�, arrParam[1] - �����
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./commdtil_popup_ifrm.jsp";
	arrParam[0]="0022";
	if(e=="01"){
		arrParam[1]=gcem_sbancodnm1.text;
	}else if(e=="02"){
		arrParam[1]=gcem_bancodnm1.text;
	}else if(e=="03"){
		arrParam[1]=gcem_sbancodnm2.text;
	}else if(e=="04"){
		arrParam[1]=gcem_sbancodnm3.text;
	}

	strPos = "dialogWidth:398px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="01") {
			gcem_sbancod1.text = arrParam[0];
			gcem_sbancodnm1.text = arrParam[1];
		}else if(e=="02") {
			gcem_bancod1.text = arrParam[0];
			gcem_bancodnm1.text = arrParam[1];
		}else if(e=="03") {
			gcem_sbancod2.text = arrParam[0];
			gcem_sbancodnm2.text = arrParam[1];
		}else if(e=="04") {
			gcem_sbancod3.text = arrParam[0];
			gcem_sbancodnm3.text = arrParam[1];
		}
	} else {
		if(e=="01") {
			gcem_sbancod1.text = "";
			gcem_sbancodnm1.text ="";
		}else if(e=="02") {
			gcem_sbancod1.text = "";
			gcem_sbancodnm1.text ="";
		}else if(e=="03") {
			gcem_sbancod2.text = "";
			gcem_sbancodnm2.text ="";
		}else if(e=="04") {
			gcem_sbancod3.text = "";
			gcem_sbancodnm3.text ="";
		}
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-�Ϻ��ڵ�, 1-�����׸�
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3");
	for(var i=0;i<=2;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_stdiv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_stdiv3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id="gcds_bank" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<OBJECT id=gctr_data1 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
    <PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
		
	}
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	gclx_sfdcode1.index=2;
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	gclx_sfdcode2.index=2;
</script>

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="";
	gclx_sfdcode3.index=2;
</script>

<script language="javascript" for="gcds_stdiv2" event="onloadCompleted(row,colid)">
	gcds_stdiv2.InsertRow(1);
	gcds_stdiv2.NameValue(1,"CDCODE")="";
	gcds_stdiv2.NameValue(1,"CDNAM")="";
	gclx_stdiv2.index = 0;
</script>

<script language="javascript" for="gcds_stdiv3" event="onloadCompleted(row,colid)">
	gcds_stdiv3.InsertRow(1);
	gcds_stdiv3.NameValue(1,"CDCODE")="";
	gcds_stdiv3.NameValue(1,"CDNAM")="";
	gclx_stdiv3.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*������ǥ���*/
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</head>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a200001_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					VALUE="#cccccc">
   					  	  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
							  <T>divid=div_1		title=������ǥ���Ұ���</T>									
							  <T>divid=div_2		title=�н�ȸ����Ȳ</T>
							  <T>divid=div_3		title=�����Ȳ</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- ������ǥ���Ұ��� ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">		
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode1">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sbcdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=CBData				value="B^����,C^��ǥ">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="CDNAM^0^80">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Delete('01')">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Add('01')">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Save('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" width="100px" colspan="3"><nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text				value="">
							<param name=Border				value=true>
							<param name=GeneralEdit			value="true">
							<param name=BackColor			value="#CCCCCC">
							<param name=InheritColor		value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('01')"><comment id="__NSID__">
						<object id=gcem_sbancod1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="######">
							<param name=PromptChar			value="_">
							<param name=Enable				value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData				value="^��ü,0^�̹���,1^����,2^�н�,3^ȸ��,4^���">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td align="right">
						<img src="../../Common/img/btn/com_b_rebranch.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_ReBranch('01')">
						<img src="../../Common/img/btn/com_b_disuse.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Disuse('01')">
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:564px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"		VALUE="gcds_data1">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="BorderStyle"	VALUE="0">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="ColSizing"		VALUE="true">
								<param NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Format"		VALUE="  
									<C> Name='No.'				ID={CURROW}	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='����'				ID=FDCODE		HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center	SumText=''	SumBgColor='#C3D0DB' show=false</C>
									<C> Name='��������'			ID=ATCODE		HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center	SumText=''	SumBgColor='#C3D0DB' show=false</C>
									<C> Name='�ڱݱ���'			ID=FUNDDIV	    HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center	SumText=''	SumBgColor='#C3D0DB' show=false</C>
									<C> Name='����'				ID=BANCOD		HeadAlign=Center HeadBgColor=#B9D4DC Width=145	align=left		SumText=''	SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_bank:CDCODE:CDNAM'</C>
									<C> Name='������ǥ��ȣ'	    ID=REFCODE2	    HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=left		SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='��������'			ID=GETDATE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='������'				ID=GETMEN		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		SumText=''	SumBgColor='#C3D0DB'</C>
									<C> Name='����'				ID=BCDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center	SumText=''	SumBgColor='#C3D0DB' EditStyle='combo' Data='B:����,C:��ǥ'</C>
									<C> Name='ó������'			ID=STDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		SumText=''	SumBgColor='#C3D0DB' EditStyle='combo' Data='0:�̹���,1:����'</C>
									<C> Name='ó������'			ID=STDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''	SumBgColor='#C3D0DB'  Mask='XXXX/XX/XX' show=false</C>
									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:6px;width:566px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset>
						</td>
						<td>

						<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:300px;height:402px;border:1 solid #708090;position:relative;left:7px'>
							<tr>											
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">������ǥ��ȣ</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gcem_refcode21 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:180px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text			value="">
										<param name=Border			value=true>
										<param name=GeneralEdit		value="true">
										<param name=BackColor		value="#CCCCCC">
										<param name=InheritColor	value=false>
										<param name=Language		value=1>
										<param name=MaxLength		value=30>
										<param name=Enable			value=false>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gcem_billcnt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:35px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text			value="">
										<param name=Alignment		value=2>
										<param name=Border			value=true>
										<param name=ClipMode		value=true>
										<param name=Numeric			value=true>
										<param name=Format			value="00000">
										<param name=MaxLength       value=3>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gclx_sbcdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
										<param name=CBData			value="B^����,C^��ǥ">
										<param name=CBDataColumns	value="CDCODE,CDNAM">
										<param name=SearchColumn	value="CDNAM">
										<param name=Sort			value="false">
										<param name=ListExprFormat	value="CDNAM^0^80">
										<param name=BindColumn		value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>  
								<td class="tab22" style="height:45px;"><nobr><comment id="__NSID__">
									<object  id=gcem_bancodnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:180px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Border				value=true>
										<param name=GeneralEdit		value="true">
										<param name=BackColor			value="#CCCCCC">
										<param name=InheritColor	value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script><br>
									<comment id="__NSID__">
									<object id=gcem_bancod1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:45px">
										<param name=Text			value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="######">
										<param name=PromptChar		value="_">
										<param name=Enable			value="false">
									</object></comment><script>__ws__(__NSID__);</script>
									<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:8px;cursor:hand"	 onclick="ln_Popup('02')"></nobr>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��������</td>
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_getdate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="YYYY/MM/DD">
										<param name=PromptChar		value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
									<img src="../img/calender.gif" value="calender.gif" id=img_calendar3 OnClick="__GetCallCalendar('gcem_getdate1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">��&nbsp;��&nbsp;��</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gcem_getmen1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text			value="">
										<param name=Border			value=true>
										<param name=GeneralEdit		value="true">
										<param name=BackColor		value="#CCCCCC">
										<param name=InheritColor	value=false>
										<param name=Language		value=1>
										<param name=MaxLength		value=20>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">ó������</td>
								<td class="tab22"><comment id="__NSID__">
									<object  id=gclx_stdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
										<param name=CBData			value="^,0^�̹���,1^����,2^�н�,3^ȸ��,4^���">
										<param name=CBDataColumns	value="CDCODE,CDNAM">
										<param name=SearchColumn	value="CDNAM">
										<param name=Sort			value="false">
										<param name=ListExprFormat	value="CDNAM^0^110">
										<param name=BindColumn		value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>
								<td class="tab11" style="width:100px;" bgcolor="#eeeeee">ó������</td>
								<td class="tab22"><comment id="__NSID__">
									<object id=gcem_stdate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="YYYY/MM/DD">
										<param name=PromptChar		value="_">
										<param name=Enable			value="true">
									</object></comment><script>__ws__(__NSID__);</script>
								<!--<img src="../img/calender.gif" value="calender.gif" id=img_calendar4 OnClick="__GetCallCalendar('gcem_stdate1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"> -->
								</td>
							</tr>
							<tr>
								<td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;
								</td>
							</tr>
						</table>
								</TD>
							</tr>
						</table>
					</td>
				 </tr>
			 </table>
			 

<!-- �н�ȸ����Ȳ ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sbcdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=CBData				value="B^����,C^��ǥ">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="CDNAM^0^80">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>�н�����</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_losdate1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_losdate2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('02')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" height="27px" width="100px" colspan="3"><nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text				value="">
							<param name=Border				value=true>
							<param name=GeneralEdit			value="true">
							<param name=BackColor			value="#CCCCCC">
							<param name=InheritColor		value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('03')"><comment id="__NSID__">
						<object id=gcem_sbancod2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="######">
							<param name=PromptChar			value="_">
							<param name=Enable				value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData						value="^��ü,0^�̹���,1^����,2^�н�,3^ȸ��,4^���">
							<param name=CBDataColumns			value="CDCODE,CDNAM">
							<param name=SearchColumn			value="CDNAM">
							<param name=Sort							value="false">
							<param name=ListExprFormat		value="CDNAM^0^110">
							<param name=BindColumn				value="CDCODE">
							<param name=Enable						value="false">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"      VALUE="gcds_data2">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="BorderStyle"	VALUE="0">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="ColSizing"		VALUE="true">
								<param NAME="Fillarea"    VALUE="true">
								<PARAM NAME="Format"      VALUE="  
									<C> Name='No.'					ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=BANNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=145	align=left		SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='������ǥ��ȣ'	ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center	SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='�н�����'			ID=LOSDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='�н����'			ID=LOSPLACE	HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=left		SumText=''	SumBgColor='#C3D0DB'</C>
									<C> Name='ȸ������'			ID=RTNDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='ȸ�����'			ID=RTNPLACE	HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='��������'			ID=GETDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='������'				ID=GETMEN		HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		SumText=''	SumBgColor='#C3D0DB'</C>
									<C> Name='����'					ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=190	align=center	SumText=''	SumBgColor='#C3D0DB' show=false</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

<!-- �����Ȳ ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode2">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab21" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sbcdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=CBData				value="B^����,C^��ǥ">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="CDNAM^0^80">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>�������</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_stdatefr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_stdatefr3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_stdateto3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment				value=0>
						<param name=Border					value=true>
						<param name=Format					value="YYYY/MM/DD">
						<param name=PromptChar				value="_">
						<param name=Enable					value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_stdateto3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('02')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('03')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('03')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" height="27px" width="100px" colspan="3"><nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text				value="">
							<param name=Border				value=true>
							<param name=GeneralEdit			value="true">
							<param name=BackColor			value="#CCCCCC">
							<param name=InheritColor		value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('04')"><comment id="__NSID__">
						<object id=gcem_sbancod3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment			value=0>
							<param name=Border				value=true>
							<param name=Format				value="######">
							<param name=PromptChar			value="_">
							<param name=Enable				value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData						value="^��ü,0^�̹���,1^����,2^�н�,3^ȸ��,4^���">
							<param name=CBDataColumns			value="CDCODE,CDNAM">
							<param name=SearchColumn			value="CDNAM">
							<param name=Sort							value="false">
							<param name=ListExprFormat		value="CDNAM^0^110">
							<param name=BindColumn				value="CDCODE">
							<param name=Enable						value="false">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
					</td>
				</tr>
				<tr>
					<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"      VALUE="gcds_data3">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="BorderStyle"	VALUE="0">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="ColSizing"		VALUE="true">
								<param NAME="Fillarea"    VALUE="true">
								<PARAM NAME="Format"      VALUE="  
									<C> Name='No.'					ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=BANNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=360	align=left		SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='������ǥ��ȣ'	ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=182	align=center	SumText=''	SumBgColor='#C3D0DB'</C> 
									<C> Name='�������'			ID=LOSDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='��������'			ID=RTNDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=center  SumText=''	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='������'				ID=GETMEN		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''	SumBgColor='#C3D0DB'</C>
									<C> Name='���'					ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=215	align=center	SumText=''	SumBgColor='#C3D0DB' show=false</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt03" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>	
		</td> 
	</tr> 
</table>


    <td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
		<C>Col=REFCODE2		Ctrl=gcem_refcode21		Param=text</C>
		<C>Col=BANCOD			ctrl=gcem_bancod1			Param=text</C>
		<C>Col=BANNAM			ctrl=gcem_bancodnm1		Param=text</C>
		<C>Col=BCDIV      Ctrl=gclx_sbcdiv1     Param=BindColVal</C>
		<C>Col=GETDATE		Ctrl=gcem_getdate1		Param=text</C>
		<C>Col=GETMEN			Ctrl=gcem_getmen1			Param=text</C>
		<C>Col=STDIV			Ctrl=gclx_stdiv1			Param=BindColVal</C>
		<C>Col=STDATE			Ctrl=gcem_stdate1			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"			value="A4">
	<param name="LandScape"			value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"			value="
	">
</object></comment><script>__ws__(__NSID__);</script> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 