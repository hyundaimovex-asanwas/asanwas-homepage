<%@ page language="java" contentType="text/html;charset=euc-kr" %>
 <!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �ڻ���ȸ,����˾�
+ ���α׷� ID	:  A040001_popup.html
+ �� �� �� ��	:  �ڻ곻���˾� 
+ ��   ��  ��   :   �̹���
+ �� �� �� ��   :  
-----------------------------------------------------------------------------
+ �� �� �� ��   :	   
+ ��   ��  ��   :
+ �� �� �� ��   :
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------> 
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ڻ���</title>

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


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_gubun=""; //chk �� click����

function ln_Start(){

	ln_Before();

	//if(gclx_sfdcode.Enable==true)     gclx_sfdcode.BindColVal    =  gs_fdcode;		
  
	}

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
/*function ln_Start(){
	
	ln_Before(); //����ȸ
	ln_SetDataHeader();

}*/

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 

//	gcem_asq_fr.text		   = gs_date2 + "01";	        //������� from
	gcem_asq_fr.text		   = '19990101'//gs_date2 + "01";	        //������� from
	
	gcem_asq_to.text		   = gs_date;	             	//������� to 
	
   //gcem_asaqsdat.enable		= false;	

	//�����ڵ�[�˻�]
	gcds_sfdcode.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

  //�����μ��ڵ�[�˻�]
	gcds_dept1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_hcdept_s2?v_str1="; 
	gcds_dept1.Reset();

	//�ڻ��ߺз�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";  
	gcds_asdivcod.Reset();

	
	//�����ڵ�[�˻�]
	gcds_sys.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2106";  
	gcds_sys.Reset();
    
	gclx_sys_fr.index=0;
  
}

/******************************************************************************
	Description : �ڻ���ȸ
******************************************************************************/
function ln_Query(){  

  var str1 = gclx_sfdcode.BindColVal;             //�����ڵ�
	var str2 = gcem_asq_fr.text;                     //������� from
	var str3 = gcem_asq_to.text;                    //������� to
	var str4 = gclx_sys_fr.BindColVal;                    //������� to

	var str5 = gclx_cadeptcd.BindColVal;             //�Ҽ�(������)
 	var str6 = gclx_asdivcod.BindColVal;           //�ڻ��ߺз�
	var str7 = gclx_asdivcod_2.BindColVal;        //�ڻ�Һз�
	//var str7 = gcem_asnbr_1.text;                    //�ڻ��ȣ
	var str8 = gclx_sfdcode.BindColVal;            //ast1st


//  if(ln_Chk('01')){
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040001_popup_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
							          + "&v_str3="+str3+"&v_str4="+str4
									  + "&v_str5="+str5+"&v_str6="+str6
									//  + "&v_str7="+str7+"&v_str8="+str8;
                                      +"&v_str8="+str8;
//prompt("",gcds_code01.DataID);
	gcds_code01.Reset(); 

//}  //ln_Chk()
}


/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){  

}

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
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
	Description : �Է�üũ 
******************************************************************************/
function ln_Chk(e){

if(e=='01'){

     if(gclx_sfdcode.BindColVal==""){
		alert("�����ڵ带 �����ϼ���");		
		return false; 
	}

     //if(gclx_asdivcod.BindColVal==""){
			//alert("�ڻ��ߺз��� �����ϼ���");			
		//return false; 
//	}
  //     if(gclx_asdivcod.BindColVal=='14' && gclx_asdivcod_2.BindColVal==""){
//		alert("�ڻ�Һз��� �����ϼ���");			
//		return false; 
//	}  
       if(gclx_asdivcod.BindColVal=='16' && gclx_asdivcod_2.BindColVal==""){
		//alert("�ڻ�Һз��� �����ϼ���");			
		return false; 
	}  	

}else if(e=='02'){

	if(gcem_ASTYUSE.text==""){
		alert("�������� �Է����ּ���");		
		return false; 	
	}
}else{
     if(gclx_sfdcode2.BindColVal==""){
		alert("�����ڵ带 �����ϼ���");		
		return false; 
	}
	 if(gclx_asdivcod2.BindColVal==""){
		alert("�ڻ��ߺз��� �����ϼ���");		
		return false; 
	}
	if(gclx_asdivcod2.BindColVal=='14' && gclx_ascosdiv2_2.BindColVal==""){
		alert("�ڻ�Һз��� �����ϼ���");		
		return false; 
	
	}
	if(gclx_asdivcod2.BindColVal=='16' && gclx_ascosdiv2_2.BindColVal==""){
		alert("�ڻ�Һз��� �����ϼ���");		
		return false; 
	
	}

	}
	return true; 
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : DataSet Header �����
******************************************************************************/
function ln_SetDataHeader(){

		var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
							 + "TAXNBR:STRING";
		 strParam.gcds_insert.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(e){
  var cnt=0;
	var s_temp="";
	if (e=="A") {
		var row = gcds_code01.rowposition;

				for(i=1;i<=gcds_code01.countrow;i++){
					if(gcds_code01.namevalue(i,"CHECK")=="T") {
						 cnt+=1;
						 txt_nm.value=cnt;


						 s_temp +=  gcds_code01.namevalue(i,"SEQ") + ";"
													 + gcds_code01.namevalue(i,"ASTNAME")  + ";" 
													 + gcds_code01.namevalue(i,"FDCODE")  + ";" 
													 + gcds_code01.namevalue(i,"ATCODE")  + ";" 
													 + gcds_code01.namevalue(i,"AST1ST")  + ";" 
													 + gcds_code01.namevalue(i,"AST2ND")  + ";" 
													 + gcds_code01.namevalue(i,"AST3RD")  + ";" 
													 + gcds_code01.namevalue(i,"ASTSEQ") + ";" 

				//	alert(s_temp);

					 }// return s_temp ;

				}
			 
//			 alert("s_temp:::::::::"+s_temp);
			window.returnValue = 	s_temp + txt_nm.value;
			window.close();
							
    
	} else {
		window.close();
	}
}


 </script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- �����ڵ� -->
<comment id="__NSID__"><OBJECT id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-- �����μ� -->
<comment id="__NSID__"><OBJECT id="gcds_dept1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-- �ڻ�з� -->
<comment id="__NSID__"><OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ� -->
<comment id="__NSID__"><OBJECT id="gcds_sys" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!--�ڻ�Һз�-->
<comment id="__NSID__"><OBJECT id="gcds_ascosdiv2_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!--�ڻ�Һз�-->
<comment id="__NSID__"><OBJECT id="gcds_asdivcod_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id="gcds_code00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
<object  id="gcds_insert" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gclx_cadeptcd" event=OnSelChange()>
//alert(gclx_cadeptcd.BindColVal);
</script>

<!-- �����ڵ� -->
<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	gclx_sfdcode.index=0;
</script>

<!-- �ڻ��ߺз� (�˻�)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="��ü";
	gclx_asdivcod.index=0;
</script>

<!-- �ڻ�Һз� (�˻�)-->
<script language="javascript" for="gcds_asdivcod_2" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod_2.InsertRow(1);
	gcds_asdivcod_2.NameValue(1,"CDCODE")="";
	gcds_asdivcod_2.NameValue(1,"CDNAM")="";
	gclx_asdivcod_2.index=0;
</script>

<!-- �ڻ�Һз� (�˻�)-->
<script language="javascript" for="gcds_ascosdiv2_2" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";  	
  gcds_ascosdiv2_2.InsertRow(1);	
  gcds_ascosdiv2_2.NameValue(1,"CDCODE")="";
	gcds_ascosdiv2_2.NameValue(1,"CDNAM")="";
	gclx_ascosdiv2_2.index=0;	
</script>

<!--�����ڵ�-->
<script language="javascript" for="gcds_sys" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_sys.InsertRow(1);
	gcds_sys.NameValue(1,"CDCODE")="";
	gcds_sys.NameValue(1,"CDNAM")="";
//	gclx_sys.index=0;
</script>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row)">
if(row<1){
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
   ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
  alert("�˻��� �����Ͱ� �����ϴ�.");   
}else {
//alert(gcds_code01.countrow);

for(var i=1;i<=gcds_code01.countrow;i++){
//alert(gcds_code01.NameValue(i,"SEQ"));
//alert(gcds_code01.NameValue(i,"ASTSEQ"));
 var temp = gcds_code01.NameValue(i,"SEQ");  

 var temp1 =temp.substring(0,2);
 var temp2 =temp.substring(2,4);
 var temp3 =temp.substring(4,6);

 var temp4 = gcds_code01.NameValue(i,"ASTSEQ");
  // hy.value = temp4;

	if(temp1=='01')      temp1='S';
	else if(temp1=='02') temp1='S';
	else if(temp1=='03') temp1='K';
	else if(temp1=='04') temp1='G';

  if(temp2=='11')        temp2='L';
	else if(temp2=='12') temp2='B';
	else if(temp2=='13') temp2='S';
	else if(temp2=='14') temp2='V';
	else if(temp2=='15') temp2='I';
	else if(temp2=='16') temp2='F';
	else if(temp2=='17') temp2='E';
  
	if(temp3=='01')      temp3='H';
	else if(temp3=='02') temp3='B';
	else if(temp3=='03') temp3='C';
	else if(temp3=='04') temp3='O';
	else if(temp3=='05') temp3='T';
	else if(temp3=='06') temp3='F';
	else if(temp3=='07') temp3='E';
	else if(temp3=='00') temp3='0';
	else if(temp3=='=')  temp3='0';

  var temp5 = "" + temp1 + "" +  temp2 + "" + temp3+ "" + temp4;
 
  //gcem_asnbr.text    = temp5;

  // gcds_code01.NameValue(1,"SEQ") = gcem_asnbr.text;*/
gcds_code01.NameValue(i,"SEQ") = temp5;
}
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	gcgd_code01.Focus();

}
</script>

<script language="javascript" for="gcds_code00" event="onloadCompleted(row)">
//alert(gcds_code00.countrow);
if (row <1) {
   alert("�˻��� �����Ͱ� �����ϴ�.");   
	//gcem_asnbr_2.text = "";
	//ln_Insert('02');

     gclx_cadeptcd_3.BindColVal  = "";
	 gcem_ASTQTY.text      = "";
     txt_empno.value= ""; 
    txt_empnm.value = "";
	// gcds_code00.ClearAll();
 }else{  
//alert(gcds_code00.NameValue(1,"ATCODE"));

 var temp = gcds_code00.NameValue(1,"SEQ");  

 var temp1 =temp.substring(0,2);
 var temp2 =temp.substring(2,4);
 var temp3 =temp.substring(4,6);
 var temp4 = gcds_code00.NameValue(1,"ASTSEQ");

//alert(temp1);
	if(temp1=='01')      temp1='S';
	else if(temp1=='02') temp1='S';
	else if(temp1=='03') temp1='K';
	else if(temp1=='04') temp1='G';

   if(temp2=='11')       temp2='L';
	else if(temp2=='12') temp2='B';
	else if(temp2=='13') temp2='S';
	else if(temp2=='14') temp2='V';
	else if(temp2=='15') temp2='I';
	else if(temp2=='16') temp2='F';
	else if(temp2=='17') temp2='E';
  
	if(temp3=='01')      temp3='H';
	else if(temp3=='02') temp3='B';
	else if(temp3=='03') temp3='C';
	else if(temp3=='04') temp3='O';
	else if(temp3=='05') temp3='T';
	else if(temp3=='06') temp3='F';
	else if(temp3=='07') temp3='E';
	else if(temp3=='00') temp3='0';


  var temp5 = "" + temp1 + "" +  temp2 + "" + temp3+ "" + temp4;
 
  gcem_asnbr_2.text = temp5;

	//alert(gcem_asnbr_2.text);
	gclx_sfdcode2.BindColVal    = gcds_code00.NameValue(1,"FDCODE");
	txt_jasan.value             = gcds_code00.NameValue(1,"ASTNAME");
	gclx_asdivcod2.BindColVal   = gcds_code00.NameValue(1,"AST2ND");
	gclx_ascosdiv2_2.BindColVal = gcds_code00.NameValue(1,"AST3RD");
	gcem_atcode.text            = gcds_code00.NameValue(1,"ATCODE");
	gcem_count2.text            = gcds_code00.NameValue(1,"FSNBR");   //ȸ��������ȣ
    gcem_asq_fr2.text           = gcds_code00.NameValue(1,"ASAQSDAT"); //�������
    gcem_count.text             = gcds_code00.NameValue(1,"TAXNBR"); //��꼭��ȣ
    gclx_fdcode02.BindColVal    = gcds_code00.NameValue(1,"DEPTCD"); //���μ�
    txt_empno.value               = gcds_code00.NameValue(1,"EMPNO");	 //�����

//ln_search2();

}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 <script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
 //alert(gclx_asdivcod.BindColVal);
if(gclx_asdivcod.BindColVal=='14'){
	gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
	gcds_asdivcod_2.Reset();

}
else if(gclx_asdivcod.BindColVal=='16'){
	gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
	gcds_asdivcod_2.Reset();

}else{
 	//�ڻ�Һз�[�˻�]
	gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
	gcds_asdivcod_2.Reset();
}	
</script>

<script language="javascript" for="gcds_dept1" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_dept1.InsertRow(1);
	gcds_dept1.NameValue(1,"DEPTCD")="";
	gcds_dept1.NameValue(1,"DEPTNM")="��ü";
	gclx_cadeptcd.index=0;
</script>

<script language=JavaScript for=gclx_asdivcod2 event=OnSelChange()>
// alert(gclx_asdivcod2.BindColVal);
if(gclx_asdivcod2.BindColVal=='14'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
	gcds_ascosdiv2_2.Reset();
}
else if(gclx_asdivcod2.BindColVal=='16'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
	gcds_ascosdiv2_2.Reset();
}else{
 	//�ڻ�Һз�[�˻�]
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
	gcds_ascosdiv2_2.Reset();
}

for(var i=1;i<=7;i++){
  //alert(gclx_asdivcod2.BindColVal);
	}

if(gclx_asdivcod2.BindColVal==""){
layer2.style.display="block";
layer2_1.style.display="block";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="none";
layer2_6.style.display="none";

}else if(gclx_asdivcod2.BindColVal=='11'){ //�����ǹ����๰
//layer2.style.display="block";
layer2_1.style.display="block";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="none";
layer2_6.style.display="none";

}else if(gclx_asdivcod2.BindColVal=='12'){ //�����ǹ����๰
//layer2.style.display="block";
layer2_1.style.display="block";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="none";
layer2_6.style.display="none";

}else if(gclx_asdivcod2.BindColVal=='13'){//�����ǹ����๰
//layer2.style.display="block";
layer2_1.style.display="block";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="none";
layer2_6.style.display="none";
}else if(gclx_asdivcod2.BindColVal=='14'){//������ݱ�
//layer2.style.display="block";
layer2_1.style.display="none";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="block";
layer2_5.style.display="none";
layer2_6.style.display="none";

}else if(gclx_asdivcod2.BindColVal=='15'){//�����ġ
//layer2.style.display="block";
layer2_1.style.display="none";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="block";
layer2_6.style.display="none";

}else if(gclx_asdivcod2.BindColVal=='16'){ //���ⱸ��ǰ...����,����
//layer2.style.display="block";
layer2_1.style.display="none";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="block";
layer2_6.style.display="none";
}else if(gclx_asdivcod2.BindColVal=='17'){//�����ġ
//layer2.style.display="block";
layer2_1.style.display="none";
layer2_2.style.display="none";
layer2_3.style.display="none";
layer2_4.style.display="none";
layer2_5.style.display="block";
layer2_6.style.display="none";
}
</script> 

<script language="javascript" for="gcgd_code01" event="OnClick(row,colid)">
  gs_save_gubun="";

		if(colid == "CHECK") {
		if (gcds_code01.NameValue(row,colid) == "T") gcds_code01.NameValue(row,colid) = gcds_code01.orgNameValue(row,colid);
		else gcds_code01.NameValue(row,colid) = "T";
	}
	
	
	if((row==0) && (colid=="CHECK")){
	  if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		for(i=1;i<=gcds_code01.countrow;i++){
		  if(gs_gubun=="1"||gs_gubun==""){
        gcds_code01.namevalue(i,"CHECK")="T";
				//alert(gcds_code01.countrow);
			}else{
        gcds_code01.namevalue(i,"CHECK")="F";
			}
		//	if(gcds_code01.namevalue(i,"ACCSGNEND")=="B"||gcds_code01.namevalue(i,"ACCSGNEND")=="N"){
	//			gcds_code01.namevalue(i,"CHECK")="F";
	//		}
		}
//	}else if(row!=0){
//		if(gcds_code01.namevalue(row,"ACCSGNEND")=="B"||gcds_code01.namevalue(row,"ACCSGNEND")=="N"){
//			gcds_code01.namevalue(row,"CHECK")="F";
//		}
	}

</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>
<!-----------------------------------------------------------------------------
B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0"cellpadding="0"cellspacing="0"leftmargin="0"topmargin="0"marginwidth="0"marginheight="0"OnLoad="ln_Start()" style=overflow:hidden>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
         <table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
            <tr>      
             <td  background="../../Common/img/com_t_bg.gif"  align=left><img src="../img/a090001_1_head.gif">	  
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand;position:relative;right:-580px;top:-13px" onClick="ln_Close('A')" >  
						<img src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand;position:relative;right:-580px;top:-13px" onclick="ln_Query()">
						</td>						
				</td>
			</tr>
		</table>
	</td>
 </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;position:relative;left:3px;border:1 solid #708090'> 
		    <tr> 				
 				<td class="tab21" width="80px;" style="" bgcolor="#eeeeee" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				   <td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " width="160px;" >&nbsp;<comment id="__NSID__"><OBJECT id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
							<param name=ComboDataID         value="gcds_sfdcode">
							<param name=CBDataColumns	      value="FDCODE,FDNAME">
							<param name=SearchColumn	      value="FDNAME">
							<param name=Sort			          value=false>
							<param name=ListExprFormat      value="FDNAME^0^150">								
							<param name=BindColumn		      value="FDCODE">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					    </td> 
					 <td width="80px"  style="" bgcolor="#eeeeee" class="tab21" align=center >�������</td>
					<td class="tab22" style="width:300px;border-bottom-width:1px;border-right-width:1px;" >&nbsp;<comment id="__NSID__"><OBJECT id=gcem_asq_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:-1px;width:70px;height:20px;">
								<param name=Alignment			value=0>
								<param name=Border	            value=true>
								<param name=Format	            value="YYYY/MM/DD">
								<param name=PromptChar	   value="_">
					       </OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
					         <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_fr', 'Text')" style="position:relative;width:20px;left:-4px;top:1px;cursor:hand;">~	&nbsp;
                               <comment id="__NSID__"><OBJECT id=gcem_asq_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
									<param name=Alignment			value=0>
									<param name=Border	            value=true>
									<param name=Format	            value="YYYY/MM/DD">
									<param name=PromptChar	    value="_">
				       	</OBJECT></comment><script>__ws__(__NSID__);</script> 
				      	<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_to', 'Text')" style="position:relative;width:20px;left:4px;top:1px;cursor:hand;">
						    </td> 
							</td>			
							<td class="tab21" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " width="80px;" bgcolor="#eeeeee" align="center">�ڻ��</td>
				   <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " width="260px;" >&nbsp;
					 <input id="txt_jasan_1" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;left:-6px;" MaxLength=30>
				 <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-7px;cursor:hand"	 onclick="ln_Popup('01')">
				 <comment id="__NSID__"><OBJECT id=gcem_jasan_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:-6px;width:50px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="#######">
										<param name=PromptChar	value="_">
										<param name=Enable			value="false">
									</OBJECT></comment><script>__ws__(__NSID__);</script> </nobr>						
					    </td> 
					</tr>

					<tr width="876px"> 
							<td width="80px" style="border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>�����μ�</nobr></td>
								<td class="tab19" style="width:160px;border-bottom-width:1px;">&nbsp;<comment id="__NSID__"><OBJECT id=gclx_cadeptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=135 style="position:relative;left:0px;top:3px;" class="txtbox" >
								<param name=ComboDataID			value="gcds_dept1">
								<param name=CBDataColumns		value="DEPTCD,DEPTNM">
								<param name=SearchColumn		value="DEPTNM">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="DEPTNM^0^160">
								<param name=BindColumn			value="DEPTCD">
									</OBJECT></comment><script>__ws__(__NSID__);</script> 						
								</td>		
					<td width="80px"  style="border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>�ڻ��ߺз�</nobr></td>
					<td class="tab19" style="width:380px;border-bottom-width:1px;"><nobr>&nbsp;<comment id="__NSID__"><OBJECT id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
								<param name=ComboDataID			value="gcds_asdivcod">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 
								</td>								
						<td width="80px"  style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:0px;padding-left:0px;padding-right:1px;border-bottom-right-left-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>&nbsp;�԰�</nobr></td>
							<td class="tab19" style="width:210px;border-bottom-width:1px;border-right-width:0px;"><nobr>&nbsp;
												<input id="txt_atcodenm_1" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;left:-6px;" MaxLength=30>
				 <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-7px;cursor:hand"	 onclick="ln_Popup('01')"><comment id="__NSID__"><OBJECT id=gcem_atcodenm_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:-5px;width:50px">
										<param name=Text				value="">
										<param name=Alignment		value=0>
										<param name=Border			value=true>
										<param name=Format			value="#######">
										<param name=PromptChar	value="_">
										<param name=Enable			value="false">
									</OBJECT></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
							</tr>  
<!----------------------------------------------------------------------------------------------------------------->
					<tr width="876px"> 
							<td width="80px" style="" bgcolor="#eeeeee" class="tab23" align=center><nobr>���±���</nobr></td>
								<td class="tab19" style="width:160px;border-bottom-width:0px;">&nbsp;
				<comment id="__NSID__"><OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-4px;top:2px;font-size:12px;width:135px;">
							<param name=CBData					value="^��ü,0^����, 1^�Ű�,2^���,3^�ں�������">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
 								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^150">
								<param name=BindColumn			value="Code">
							</OBJECT></comment><script>__ws__(__NSID__);</script> 						

		</td>		
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab23" align=center><nobr>�ڻ�Һз�</nobr></td>
					<td class="tab19" style="width:380px;border-bottom-width:0px;"><nobr>&nbsp;
<comment id="__NSID__"><OBJECT id=gclx_asdivcod_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-3px;top:2px;font-size:12px;width:120px;border-right-width:0px;right:0px;">
									<param name=ComboDataID			value="gcds_asdivcod_2">
									<param name=CBDataColumns		value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="CDNAM^0^150">
									<param name=BindColumn			value="CDCODE">
					    	</OBJECT></comment><script>__ws__(__NSID__);</script> 					
		</td>								
						<td width="80px"  style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:0px;padding-left:0px;padding-right:1px;border-bottom-right-left-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>&nbsp;�Һз�</nobr></td>
							<td class="tab19" style="width:210px;border-bottom-width:0px;border-right-width:0px;"><nobr>&nbsp;
							<!-- <comment id="__NSID__"> -->
								<input id="txt_asdivcod_2" name="txt_asdivcod_2nnnnnn"			style="width:90px;left:-2px" class="txtbox" maxlength="30" onBlur="bytelength(this,this.value,7);">
						<!-- 	<OBJECT id=gclx_asdivcod_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-2px;top:2px;font-size:12px;width:120px;border-right-width:0px;right:0px;">
									<param name=ComboDataID			value="gcds_asdivcod_2">
									<param name=CBDataColumns		value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="CDNAM^0^150">
									<param name=BindColumn			value="CDCODE">
					    	</OBJECT></comment><script>__ws__(__NSID__);</script>  -->
								<input id="txt_nm" name="txt_nm"		type='hidden'	style="width:90px;left:px" class="txtbox" maxlength="7" onBlur="bytelength(this,this.value,7);">
					<!-- 			<input id="txt_empno" name="txt_empno"	type='hidden'	style="width:90px;left:px" class="txtbox" maxlength="7" onBlur="bytelength(this,this.value,7);"> -->
					</td>
							</tr>  

			 </table>
		</td>
	</tr> 
<tr>
<td height="3px" colspan =2 align="left" valign="top"></td></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:0px;width:280px;border:0 solid #708090;">
				<tr> 			
				 <td><comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code01  
							style="position:relative;left:3px;width:874px; height:360px; border:1 solid #708090;">
                                 <PARAM NAME="DataID"		VALUE="gcds_code01">
								<PARAM NAME="BorderStyle"    VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<!--<param name="ViewSummary"	value=1>-->
								<param name="ColSizing"     value="true">
								<param name="Editable"       value="false">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="Format"			VALUE="  
<C> Name='����'		    ID=CHECK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  SumBgColor=#C3D0DB align=center	EditStyle=CheckBox   </C> 
<C> Name='�ڻ��ȣ'	 ID=SEQ  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center  </C> 
<C> Name='�ڻ��ȣ'	 ID=SEQ2  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=76		align=center show=false  EDIT=NUMBER sort=true</C> 
<C> Name='���ݰ�꼭'	 ID=TAXNBR  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=76		align=center EDIT=NUMBER </C> 
<C> Name='�������'	 ID=ASAQSDAT  HeadBgColor=#B9D4DC Width=70 align=center Mask=XXXX-XX-XX</C> 
<C> Name='�ڻ�з�'	 ID=AST2ND    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left  EditStyle='lookup' Data='gcds_asdivcod:CDCODE:CDNAM' Edit=none</C> 
<C> Name='�ڻ��'	 ID=ASTNAME	 HeadAlign=Center HeadBgColor=#B9D4DC Width=160	align=left</C> 
<C> Name='����'		 ID=ASTUNIT  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center</C> 
<C> Name='����'	     ID=ASTQTY	 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=RIGHT</C> 
<C> Name='���ݾ�'	 ID=ASTAQAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=RIGHT</C>
<C> Name='������'	 ID=ASTYUSE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=RIGHT	 </C>
<C> Name='�����μ�'	 ID=MNGDPT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100  EditStyle='lookup' Data='gcds_dept1:DEPTCD:DEPTNM' Edit=none align=center</C>
<C> Name='���μ�'	 ID=USEDPT	HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=center EditStyle='lookup' Data='gcds_dept1:DEPTCD:DEPTNM' Edit=none align=center</C>
								">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:3px;width:876px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
				</tr>
				</table>
		</td>
	</tr>
</table>	
<!--================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
=================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 