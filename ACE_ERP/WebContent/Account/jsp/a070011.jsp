<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:  �ڱݰ��� - ���Ա���Ȳ,��ȯ���ǰ���,��ȯ������
+ ���α׷� ID	:  A700011.html
+ �� �� �� ��	:  ����,����,��ȸ �� ��� ȭ���̴�.
+ �� �� �� �� :  �� �� �� (��ȸ) 
+ �� �� �� ��	:	
------------------------------------------------------------------------------>

<html>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���Ա���Ȳ</title>


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

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_date3  = gcurdate.substring(0,4);
var gs_date4  = gcurdate.substring(5,7);
var gs_fdcode = gfdcode;
var cuserid		= gusrid;	
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	ln_DispChk(0);
	
	ln_HederSet();
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.bindcolval;					//�����ڵ�   
		var str2  = fn_trim(txt_atcodenm_fr.value);		//������
		var str3  = fn_trim(txt_atcode_fr.value);			//�����ڵ�
		var str4  = fn_trim(gclx_sstdiv2.bindcolval);	//ó������ 
		var str5  = gcem_mortbank.value;							//����� 
		var str6  = txt_mortbank.value;								//�����ڵ�   
		var str7  = fn_trim(gcem_sgetdatefr1.text);		//��������fr   
		var str8  = fn_trim(gcem_sgetdateto1.text);		//��������to
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8;
		gcds_data1.Reset();
	}else if(s=="02") {
		var str1  = gclx_sfdcode2.bindcolval;					//�����ڵ�   
		var str2  = fn_trim(txt_atcodenm_fr2.value);	//������
		var str3  = fn_trim(txt_atcode_fr2.value);		//�����ڵ�
		var str4  = fn_trim(gclx_sstdiv2.bindcolval);	//ó������ 
		var str5  = gcem_mortbank2.value;							//����� 
		var str6  = txt_mortbank2.value;							//�����ڵ�   
		var str7  = fn_trim(gcem_sgetdatefr2.text);		//��������fr   
		var str8  = fn_trim(gcem_sgetdateto2.text);		//��������to
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8;
		gcds_data2.Reset();

		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_s4"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8;
		gcds_data4.Reset();
	}else if(s=="03") {
		var str1  = gclx_sfdcode3.bindcolval;					//�����ڵ�   
		var str2  = fn_trim(txt_atcodenm_fr3.value);	//������
		var str3  = fn_trim(txt_atcode_fr3.value);		//�����ڵ�
		var str4  = fn_trim(gclx_sstdiv2.bindcolval);	//ó������ 
		var str5  = gcem_mortbank4.value;							//����� 
		var str6  = txt_mortbank4.value;							//�����ڵ�   
		var str7  = fn_trim(gcem_stdatefr3.text);			//��������fr   
		var str8  = fn_trim(gcem_stdateto3.text);			//��������to
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_s3"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8;
		gcds_data3.Reset();
	}
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(e){
	if(e=="02"){
		if(gcds_data2.countrow>0){
			var row1 = gcds_data2.rowposition;
			var row  = gcds_data4.rowposition;
			gcds_data4.AddRow();
			gcds_data4.namevalue(1,"FDCODE")		= gcds_data2.namevalue(row1,"FDCODE");
			gcds_data4.namevalue(1,"ATCODE")		= gcds_data2.namevalue(row1,"ATCODE");
			gcds_data4.namevalue(1,"FUNDDIV")		= gcds_data2.namevalue(row1,"FUNDDIV");
			gcds_data4.namevalue(1,"REFCODE2")	= gcds_data2.namevalue(row1,"REFCODE2");
			return false;
		}else alert("����� ������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : Header ����
******************************************************************************/
function ln_HederSet(){
	var THeader1 = "FDCODE:STRING,ATCODE:STRING,FUNDDIV:STRING,REFCODE2:STRING,"
							 + "RTNTERM_N:DECIMAL,RTNTERM:DECIMAL,RTNUNIT:DECIMAL,RTNSEQ:DECIMAL,"
							 + "RTNDIV:STRING,FSTDATE:STRING";
	gcds_data2.SetDataHeader(THeader1);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(e){
	if(e=="02"){
		if(gcds_data2.countrow>0){
			if(gcds_data4.IsUpdated) {
				gctr_data1.KeyValue = "Account.a070011_t1(I:USER=gcds_data4)";
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_t1";
				gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+cuserid;
				gctr_data1.post();
				ln_Query('02');
			}else alert("����� ������ �����ϴ�.");
		}else alert("������ ������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(e){
	if(gcds_data4.countrow>0){
		if(e=="02"){
			if (confirm("���� �Ͻðڽ��ϱ�?")){	
				gcds_data4.DeleteRow(gcds_data4.RowPosition);
				gctr_data1.KeyValue   = "Account.a070011_t1(I:USER=gcds_data4)";
				gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070011_t1";
				gctr_data1.Parameters = "v_str1="+gs_date+",v_str2="+cuserid;
				gctr_data1.post();
				ln_Query('02');
			}
		}
	}else alert("������ ������ �����ϴ�.");
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Create(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
	alert("�غ����Դϴ�.");
	/*
  if(e=="01") {
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
	}
	*/
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
  if(e=="01") {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('���Ա���Ȳ');
	}else if(e=="02") {
		if (gcds_data2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp02.RunExcel('��ȯ���ǰ���');
	}else if(e=="03") {
		if (gcds_data3.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp05.RunExcel('��ȯ������');
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_sgetdatefr1.text = gs_date2+"01";	
	gcem_sgetdateto1.text = gs_date;				

	gcem_sgetdatefr2.text = gs_date2+"01";	
	gcem_sgetdateto2.text = gs_date;

	gcem_stdatefr3.text = gs_date2+"01";	
	gcem_stdateto3.text = gs_date;

	gclx_sstdiv1.index =1;
	gclx_sstdiv2.index =1;
	gclx_sstdiv3.index =1;

	//�����ڵ�[�˻�]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode3.Reset();	

	//�ڱݱ���
	gcds_funddiv3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0053"; 
	gcds_funddiv3.Reset();
}

/******************************************************************************
	Description : �����ڵ�  �˾�
******************************************************************************/
function ln_Popup1(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./banklist1_popup.jsp";
	strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if(e=='01'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcem_mortbank.value = ln_Trim(arrParam[0]);
			txt_mortbank.value = ln_Trim(arrParam[1]); 
		} else {
			gcem_mortbank.value = "";
			txt_mortbank.value = "";
		}
	}else if(e=='02'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcem_mortbank2.value = ln_Trim(arrParam[0]);
			txt_mortbank2.value = ln_Trim(arrParam[1]); 
		} else {
			gcem_mortbank2.value = "";
			txt_mortbank2.value = "";
		}
	}else if(e=='03'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcem_mortbank3.value = ln_Trim(arrParam[0]);
			txt_mortbank3.value = ln_Trim(arrParam[1]); 
		} else {
			gcem_mortbank3.value = "";
			txt_mortbank3.value = "";
		}
	}else if(e=='04'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcem_mortbank4.value = ln_Trim(arrParam[0]);
			txt_mortbank4.value = ln_Trim(arrParam[1]); 
		} else {
			gcem_mortbank4.value = "";
			txt_mortbank4.value = "";
		}
	}
}

/******************************************************************************
	Description : �����ڵ� �����˻�	        
******************************************************************************/
function ln_Bank_Find(obj,e){
	var  vend = eval(obj).value;
  if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
	gcds_bank.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s01?v_str1="+eval(obj).value+"&v_str2="; 
	gcds_bank.Reset();  

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;	  
	
	strURL = "./ast_banklist_popup.jsp";
	arrParam[0] = ln_Trim(vend);
	strPos = "dialogWidth:318px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(e=='01'){
		if (gcds_bank.countrow>0){
			if (arrResult != null) 
				arrParam = arrResult.split(";");
				gcem_mortbank.value = arrParam[0];		
				txt_mortbank.value = arrParam[1];        
			}else {	
				alert("�������� �ʴ� �ڵ��Դϴ�");  
				gcem_mortbank.value="";		
				txt_mortbank.value = "";
			}
	}else if(e=='02'){
		if (gcds_bank.countrow>0){
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    gcem_mortbank2.value = arrParam[0];		
			  txt_mortbank2.value = arrParam[1];
			} else {
		    gcem_mortbank2.value = "";		
			  txt_mortbank2.value = "";
			}
		}else {	
			alert("�������� �ʴ� �ڵ��Դϴ�"); 
			gcem_mortbank2.value = "";		
			txt_mortbank2.value = "";
		}
	}else if(e=='03'){
		if (gcds_bank.countrow>0){
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    gcem_mortbank3.value = arrParam[0];		
			  txt_mortbank3.value = arrParam[1];
			} else {
		    gcem_mortbank3.value = "";		
			  txt_mortbank3.value = "";
			}
		}else {	
			alert("�������� �ʴ� �ڵ��Դϴ�"); 
			gcem_mortbank3.value = "";		
			txt_mortbank3.value = "";
		}
	}else if(e=='04'){
		if (gcds_bank.countrow>0){
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    gcem_mortbank4.value = arrParam[0];		
			  txt_mortbank4.value = arrParam[1];
			} else {
		    gcem_mortbank4.value = "";		
			  txt_mortbank4.value = "";
			}
		}else {	
			alert("�������� �ʴ� �ڵ��Դϴ�"); 
			gcem_mortbank4.value = "";		
			txt_mortbank4.value = "";
		}
	}///if	
}///function

/***********************************************************************************************
	Description : �����ڵ� 
	parameter   : p1 - ����  p2-����2, p3-�ڱݱ��а� obj
**********************************************************************************************/
function ln_Popup3(p1,p2,p3,obj1,obj2){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_fund_popup.jsp";
	arrParam[0]=eval(obj1).value;
	arrParam[1]=eval(obj2).value;
	arrParam[2]="'30'";//p3;
	arrParam[3]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (p1=="01"){//��������
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}
		} else {
			if(p2=="fr") {
			    txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
				gstr_fundiv = "";
			}
		}
	}else if(p1=="02"){
			if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr2.value = arrParam[0];
				txt_atcodenm_fr2.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}
		} else {
				if(p2=="fr") {
					txt_atcode_fr2.value="";
					txt_atcodenm_fr2.value="";
					gstr_fundiv = "";
				}
			}
    }else if(p1=="03"){
			if (arrResult != null) {
			arrParam = arrResult.split(";");
			 if(p2=="fr"){
				txt_atcode_fr3.value = arrParam[0];
				txt_atcodenm_fr3.value = arrParam[1];
				gstr_fundiv = arrParam[2];
			}
		} else {
			if(p2=="fr") {
			  txt_atcode_fr3.value="";
				txt_atcodenm_fr3.value="";
				gstr_fundiv = "";
			}
		}
	}
}

/******************************************************************************
	Description : lost focus �� 
	prameter    : p1 - 01 ��ǥ�ۼ� / 02 ������ȸ
								p2 - atcode:����	obj
******************************************************************************/
function ln_Blur(p1,p2,obj1,obj2){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
				ln_Popup3('01','fr','B',obj1,obj2);
		}
	}else if(p1=="02"){
		if(p2=="atcode"){
		  if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
				ln_Popup3('02','fr','B',obj1,obj2);
		}
	}else if(p1=="03"){
		if(p2=="atcode"){
			if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
				ln_Popup3('03','fr','B',obj1,obj2);
		}
	}
}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
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

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script> <!-- ���� -->

<comment id="__NSID__"><object  id=gcds_funddiv3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

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
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data3" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	if(cuserid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	if(cuserid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="";
	if(cuserid=="ACCOUNT"){
		gclx_sfdcode3.index=2;
	}else{
		gclx_sfdcode3.bindcolval=gs_fdcode;
	}
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
	ln_DispChk((index-1)); 
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
    <td><img src="../img/a070011_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2 align=left style="position:relative;left:5px">
      <table width="0" cellpadding="1" cellspacing="0" border="0" style="position:relative;top:4px;left:1px;">
				<tr> 
					<td width="0" align=left><nobr>
					  <comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=���Ա���Ȳ</T>									
							  <T>divid=div_2		title=��ȯ���ǰ���</T>
							  <T>divid=div_3		title=��ȯ������</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
        </tr>
      </table>
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
		
<!-- ���Ա���Ȳ ===========================================================================================================-->
<!--<fieldset id=field1 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" style="display:block">
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
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:220px">
						<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr', 'txt_atcodenm_fr')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('01','fr','B','txt_atcode_fr','txt_atcodenm_fr');">
						<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr','txt_atcodenm_fr')" >
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab22" style="width:210px">
						<comment id="__NSID__"><object id=gcem_sgetdatefr1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr1', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('01')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" width="250px" colspan="3"><!--<nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('03')"><comment id="__NSID__">
						<object id=gcem_sbancod2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="######">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>-->
						<input type=text   id=gcem_mortbank style= "position:relative;top:0px;left:5px;width:40px; height:20px;"  class="txtbox"  maxlength=7 onkeydown="ln_Bank_Find('gcem_mortbank','01');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:2px" onclick="ln_Popup1('01');">	
						<input id="txt_mortbank" type="text" class="txtbox"  style= "position:relative;top:0px;width:150px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td width="100px">
						<comment id="__NSID__"><object  id=gclx_sstdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData					value="^��ü,0^����,1^�Ϸ�">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
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
							<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data1">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'					ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=BANNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=FUNDDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_funddiv3:CDCODE:CDNAM'</C> 
 									<C> Name='���¹�ȣ'			ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		SumText='��'	SumBgColor='#C3D0DB'</C> 
									<G> Name='��ȭ'	HeadAlign=Center		HeadBgColor=#B9D4DC
									<C> Name='���Աݾ�'			ID=CRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right  	SumText=@sum	SumBgColor='#C3D0DB'</C> 
									<C> Name='��ȯ�ݾ�'			ID=DRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right   SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='�ܾ�'					ID=JANAMT01	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
                  </G>
									<C> Name='��������'			ID=STRDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='��������'			ID=ENDDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='����'					ID=OUTRATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
                  <G> Name='��ȭ'	HeadAlign=Center		HeadBgColor=#B9D4DC
									<C> Name='���Աݾ�'			ID=CRFAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C> 
									<C> Name='��ȯ�ݾ�'			ID=DRFAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='�ܾ�'					ID=JANAMT02	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='��ȭ'					ID=CURDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='ȯ��'					ID=EXRATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									</G>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:6px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 			 

<!-- ��ȯ���ǰ��� ===========================================================================================================-->
<!--<fieldset id=field2 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="dispaly:none">		
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
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:220px">
						<input id="txt_atcodenm_fr2" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr2', 'txt_atcodenm_fr2')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('02','fr','B','txt_atcode_fr2','txt_atcodenm_fr2');">
						<input id="txt_atcode_fr2" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('02','atcode','txt_atcode_fr2','txt_atcodenm_fr2')" >
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab22" style="width:210px"><comment id="__NSID__">
						<object id=gcem_sgetdatefr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object id=gcem_sgetdateto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_sgetdateto3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<!--<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Delete('01')">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Add('01')">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Save('01')">-->
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" width="250px" colspan="3"><!--<nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('01')"><comment id="__NSID__">
						<object id=gcem_sbancod1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="######">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>-->
						<input type=text   id=gcem_mortbank2 style= "position:relative;top:0px;left:5px;width:40px; height:20px;"  class="txtbox"  maxlength=7 onkeydown="ln_Bank_Find('gcem_mortbank2','02');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:2px" onclick="ln_Popup1('02');">	
						<input id="txt_mortbank2" type="text" class="txtbox"  style= "position:relative;top:0px;width:150px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td width="100px"><comment id="__NSID__">
						<object  id=gclx_sstdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:110px;height:110px;">
							<param name=CBData					value="^��ü,0^����,1^�Ϸ�">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
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
							<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:510px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data2">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
	                <C> Name='No.'					ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=BANNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'					ID=FUNDDIV	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_funddiv3:CDCODE:CDNAM' show=false</C> 
        					<C> Name='���¹�ȣ'			ID=REFCODE2	HeadAlign=Center HeadBgColor=#B9D4DC Width=155	align=left		SumText='��'	SumBgColor='#C3D0DB'</C>
									<G> Name='��ȯ����'	HeadAlign=Center		HeadBgColor=#B9D4DC
                  <C> Name='���Աݾ�'			ID=CRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='��ȯ�ݾ�'			ID=DRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C>
									<C> Name='�ܾ�'					ID=JANAMT01	HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
                  </G>
									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:5px;width:512px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
					</fieldset>
						</td>
						<td>
							<table border= "0" class=itemdisp cellpadding=0 cellspacing=0  border=0  style='width:354px;height:402px;border:1 solid #708090;position:relative;left:7px'>
							<tr>											
								<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"  bgcolor="" colspan=4></td>								
							</tr>
							<tr>											
								<td class="tab11"  bgcolor="#eeeeee" Style="height:25px;width:80px;border:0 solid #708090;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">���¹�ȣ</td>
								<td class="tab22" COLSPAN=3 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-top-width:1px;border-bottom-width:1px"><comment id="__NSID__">
									<object  id=gcem_refcode21 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:180px;height:20px;position:relative;left:5px;top:0px;">		
										<param name=Text					value="">
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
										<param name=Language			value=1>
									</object></comment><script>__ws__(__NSID__);</script>
								</td>
							</tr>
							<tr>					
								<td width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��������</td>
								<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
									<comment id="__NSID__"><object id=gcem_sgetdatefr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdatefr3', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">
							</td>
							<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��������</td>
							<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
								<comment id="__NSID__"><object id=gcem_sgetdateto4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_sgetdateto4', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">
						</td>
					</tr>
					<tr>											
						<td class="tab11" style="width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="tab22" COLSPAN=3><nobr>
							<input type=text id=gcem_mortbank3 style= "position:relative;top:0px;left:6px;width:90px; height:20px;"  class="txtbox"  maxlength=7 onkeydown="ln_Bank_Find('gcem_mortbank3','03');">
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:2px" onclick="ln_Popup1('03');">	
							<input id="txt_mortbank3" type="text" class="txtbox"  style= "position:relative;top:0px;width:120px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled></nobr>
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">���Աݾ�</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_cramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȭ����</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
							<comment id="__NSID__"><OBJECT id=gcem_crfamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȯ�ݾ�</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_dramt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȭ��ȯ</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
							<comment id="__NSID__"><OBJECT id=gcem_drfamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_janamt01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
							<comment id="__NSID__"><OBJECT id=gcem_janamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
					<tr>
						<td  style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_outrate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td   style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">ȯ&nbsp;&nbsp;&nbsp;&nbsp;��</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_exrate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
          <tr>											
						<td class="tab11" style="width:80px;" bgcolor="#eeeeee">��ȭ����</td>
						<td class="tab22" COLSPAN=3><comment id="__NSID__">
							<object  id=gclx_curdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:85px;height:110px;">
								<param name=CBData					value="^,0^�̹���,1^����">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^110">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
          <tr>											
						<td class="tab11" style="width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="tab22" COLSPAN=3><comment id="__NSID__">
							<object  id=gcem_remark classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:240px;height:20px;position:relative;left:6px;top:0px">		
								<param name=Text					value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language			value=1>
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>											
						<td class="tab11" style="width:200px;" bgcolor="" COLSPAN=4>
							<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;top:2px;left:180px" onClick="ln_Delete('02')">
							<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;top:2px;left:180px" onClick="ln_Add('02')">
							<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;top:2px;left:180px" onClick="ln_Save('02')">
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ġ�Ⱓ</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_rtntermn classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȯ�Ⱓ</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
							<comment id="__NSID__"><OBJECT id=gcem_rtnterm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȯ�ֱ�</td>
            <td  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
							<comment id="__NSID__"><OBJECT id=gcem_rtnunit classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;">
								<param name=Text          value="">
								<param name=Alignment			value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��ȯȸ��</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
							<comment id="__NSID__"><OBJECT id=gcem_rtnseq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</td>
					</tr>
					<tr>					
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">��������</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><comment id="__NSID__">					<object  id=gclx_rtndiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  													
								style="position:relative;left:5px;top:0px;width:85px;height:110px;">
								<param name=CBData					value="^,T^�̹���,F^����">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^110">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
						<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:0px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">���ʳ�����</td>
            <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" colspan=3>
							<comment id="__NSID__"><object id=gcem_fstdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable				value="true">
							</object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fstdate', 'Text')" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">
						</td>
					</tr>
					<!--<tr><td colspan=2 style="height:100%;border:0 solid #708090;" >&nbsp;</td></tr>-->
				</table>
				</TD>
			</tr>
		</table>
	</td>
 </tr>
</table>
			 
<!-- ��ȯ������ ===========================================================================================================-->
<!--<fieldset id=field3 style="position:absolute;top:70px;left:4px;height:470px;width:875px;bacground-color:#708090"></fieldset>-->
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:7px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:90px"><comment id="__NSID__">
						<object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode3">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="FDNAME^0^80">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td class="tab21" style="width:250px"><nobr>
						<input id="txt_atcodenm_fr3" type="text" class="txtbox"  style= "position:relative;top:0px;left:6px;width:115px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr3', 'txt_atcodenm_fr3')">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:0px;" align=center onclick="ln_Popup3('03','fr','B','txt_atcode_fr3','txt_atcodenm_fr3');">
						<input id="txt_atcode_fr3" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:50px; height:20px;" maxlength="36" onkeydown="ln_Blur('03','atcode','txt_atcode_fr3','txt_atcodenm_fr3')" > </nobr>
					</td>
					<td class="tab11" style="width:70px;" bgcolor="#eeeeee"><nobr>ó������</nobr></td>
					<td class="tab22" style="width:160px"><comment id="__NSID__">
						<object  id=gclx_sstdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:100px;height:110px;">
							<param name=CBData					value="^��ü,0^����,1^�Ϸ�">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^110">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab22" align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_cancle.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Cancel('03')">
						<img src="../../Common/img/btn/com_b_create.gif"	style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create('03')">
						<!-- <img src="../../Common/img/btn/com_b_print.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('03')"> -->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Excel('03')">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('03')"> 
						</nobr>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" width="250px" colspan="3">
					<!--<nobr><comment id="__NSID__">
						<object  id=gcem_sbancodnm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:152px;height:20px;position:relative;left:5px;top:0px">		
							<param name=Text					value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:0px;left:8px;cursor:hand"	 onclick="ln_Popup('04')"><comment id="__NSID__">
						<object id=gcem_sbancod3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:12px;width:45px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="######">
							<param name=PromptChar	value="_">
							<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script></nobr>-->
						<input type=text   id=gcem_mortbank4 style= "position:relative;top:0px;left:5px;width:40px; height:20px;"  class="txtbox"  maxlength=7 onkeydown="ln_Bank_Find('gcem_mortbank4','04');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="������� �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:2px" onclick="ln_Popup1('04');">	
						<input id="txt_mortbank4" type="text" class="txtbox"  style= "position:relative;top:0px;width:150px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
					<td class="tab12" style="width:70px;" bgcolor="#eeeeee"><nobr>��������</nobr></td>
					<td width="200px" colspan="2"><nobr><comment id="__NSID__">
						<object id=gcem_stdatefr3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_stdatefr3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
							<comment id="__NSID__"><object id=gcem_stdateto3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
								style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_stdateto3', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
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
							<OBJECT id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:452px;HEIGHT:353px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data3">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='No.'			ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'			ID=BANNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left		SumText=''		SumBgColor='#C3D0DB'</C> 
									<C> Name='����'			ID=FUNDDIV		HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=left		SumText=''		SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_funddiv3:CDCODE:CDNAM' show=false</C> 
                  <C> Name='���¹�ȣ'	ID=REFCODE2		HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=center	SumText='��'	SumBgColor='#C3D0DB'</C> 
									<G> Name='��ȯ����'	HeadAlign=Center	HeadBgColor=#B9D4DC
                  <C> Name='���Աݾ�'	ID=CRAMT_1		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C> 
									<C> Name='��ȯ�ݾ�'	ID=DRAMT_2		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
									<C> Name='�ܾ�'			ID=JANAMT01		HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
                  </G>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<table><tr><td></td></tr></table><comment id="__NSID__">
							<OBJECT id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:452px;HEIGHT:40px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data3">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='��ȯ����'		ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center</C> 
									<C> Name='��ġ�Ⱓ'		ID=RTNTERM_N	HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=right	</C> 
									<C> Name='��ȯ�Ⱓ'		ID=RTNTERM		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=right	</C> 
                  <C> Name='��ȯ�ֱ�'		ID=RTNUNIT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right	</C> 
									<C> Name='��ȯȸ��'		ID=RTNSEQ			HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right </C>
									<C> Name='���ʳ�����'	ID=FSTDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	Mask='XXXX/XX/XX'</C>
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
						<td style="width:460" ALIGN=LEFT VALIGN=TOP><comment id="__NSID__">
							<OBJECT id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:411px;HEIGHT:380px;border:1 solid #777777;display:block;position:relative;left:6px" viewastext>
								<PARAM NAME="DataID"        VALUE="gcds_data3">
								<PARAM NAME="Editable"			VALUE="false">
								<PARAM NAME="BorderStyle"		VALUE="0">
								<PARAM NAME="IndWidth"			VALUE="0">
								<PARAM NAME="ColSizing"			VALUE="true">
								<param NAME="Fillarea"      VALUE="true">
								<PARAM NAME="viewSummary"		VALUE="1">
								<PARAM NAME="Format"        VALUE="  
									<C> Name='ȸ��'			ID={CURROW}	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center	SumText='��'	SumBgColor='#C3D0DB'</C> 
									<C> Name='�ܾ�'			ID=CRTAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C> 									
									<G> Name='��ȯ����'	HeadAlign=Center HeadBgColor=#B9D4DC
                  <C> Name='����'			ID=DRAMT0		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C> 
									<C> Name='����'			ID=DRAMT1		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=right		SumText=@sum	SumBgColor='#C3D0DB' </C>
									<C> Name='��'				ID=AMTSUM		HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
                  </G>                                    
                  <C> Name='��ȯ����'	ID=RTNDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=center	SumText=''		SumBgColor='#C3D0DB' Mask='XXXX/XX/XX'</C> 
								">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset style="position:relative;left:6px;width:413px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
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
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value='  
	<C>Col=REFCODE2		Ctrl=gcem_refcode21			Param=text</C>
	<C>Col=STRDATE		Ctrl=gcem_sgetdatefr3		Param=text</C>
	<C>Col=ENDDATE		Ctrl=gcem_sgetdateto4		Param=text</C>
	<C>Col=BANCOD			Ctrl=gcem_mortbank3			Param=value</C>
	<C>Col=BANNAM			Ctrl=txt_mortbank3			Param=value</C>
	<C>Col=CRAMT			Ctrl=gcem_cramt					Param=text</C>
	<C>Col=CRFAMT			Ctrl=gcem_crfamt				Param=text</C>
	<C>Col=DRAMT			Ctrl=gcem_dramt					Param=text</C>
	<C>Col=DRFAMT			Ctrl=gcem_drfamt				Param=text</C>
	<C>Col=JANAMT01		Ctrl=gcem_janamt01			Param=text</C>
	<C>Col=JANAMT02		Ctrl=gcem_janamt02			Param=text</C>
	<C>Col=OUTRATE		Ctrl=gcem_outrate				Param=text</C>
	<C>Col=EXRATE			Ctrl=gcem_exrate				Param=text</C>
	<C>Col=CURDIV			Ctrl=gclx_curdiv				Param=bindcolval</C>
	<C>Col=REMARK			Ctrl=gcem_remark				Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - ���Աݻ�ȯ����
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data4>
	<param name=BindInfo  value='  
		<C>Col=RTNTERM_N	Ctrl=gcem_rtntermn			Param=text</C>
		<C>Col=RTNTERM		Ctrl=gcem_rtnterm				Param=text</C>
		<C>Col=RTNUNIT		Ctrl=gcem_rtnunit				Param=text</C>
		<C>Col=RTNSEQ			Ctrl=gcem_rtnseq				Param=text</C>
		<C>Col=RTNDIV			Ctrl=gclx_rtndiv				Param=bindcolval</C>
		<C>Col=FSTDATE		Ctrl=gcem_fstdate				Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 