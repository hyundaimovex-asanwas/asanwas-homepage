<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ��ΰ��� - ��������
+ ���α׷� ID	:  A030016.html
+ �� �� �� ��	:  
+ ��   ��  �� :  YS.JEONG
+ �� �� �� �� :  2006.11.01
-----------------------------------------------------------------------------
+ �� �� �� ��  :	��¹�  
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.11.1
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��������</title>

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
//get_cookdata();

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //���
var gs_date3 = gcurdate.substring(0,4); //��
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var g_date, g_time;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
    gclx_refcd.index=0;
    ln_Before();
  
	var date = new Date();
	g_date = "������� : " + date.getFullYear() + "/" + date.getMonth() + "/"
											+ date.getDate();
	g_time = "��½ð� : " + date.getHours() + ":" + date.getMinutes();
	gclx_fdcode.bindcolval = gs_fdcode;
	
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){

  gcgd_disp01.DataID =""; 
	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030016_s1?v_str1="+gclx_fdcode.bindcolval
																									 +"&v_str2="+gcem_datefr.text
																									 +"&v_str3="+gcem_dateto.text
																									 +"&v_str4="+txt_atcode_fr.value
																									 +"&v_str5="+txt_atcode_to.value	
																									 +"&v_str6="+gclx_refcd.bindcolval;		
	//prompt("",gcds_data01.DataID );																							
	gcds_data01.Reset();									
}	

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){

}

/******************************************************************************************
	Description : ����
******************************************************************************************/
function ln_Save(){
	
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
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
function ln_Print01(){
	
  alert("�������Դϴ�.");
  return;
	if(gcds_data01.countrow<1) {
			alert("����� ������ �����ϴ�.");
	}	else {

	gcds_print01.ClearData();
	ln_PrintHeader();

		for(i=1;i<=gcds_data01.countrow;i++) {
			gcds_print01.Addrow();
			gcds_print01.namevalue(i,"ATCODE")   = gcds_data01.namevalue(gcds_data01.rowposition,"ATCODE");
			gcds_print01.namevalue(i,"ATKORNAM") = gcds_data01.namevalue(gcds_data01.rowposition,"ATKORNAM");
			
		}

			gcds_print01.namevalue(i,"CURDT") = "������� : " + g_date;
			gcds_print01.namevalue(i,"CURTM") = "��½ð� : " + g_time;
			gcds_print01.namevalue(i,"KISU1")		= gcem_datefr.text + gcem_dateto.text;

			gcrp_print1.preview();
	}
	
}


/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

//  alert("�������Դϴ�.");
//  return;

	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030016_s1?v_str1="+gclx_fdcode.bindcolval
																									 +"&v_str2="+gcem_datefr.text
																									 +"&v_str3="+gcem_dateto.text
																									 +"&v_str4="+txt_atcode_fr.value
																									 +"&v_str5="+txt_atcode_to.value	
																									 +"&v_str6="+gclx_refcd.bindcolval;		
	gcds_print1.Reset();
	
}
	
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("��������","",2);

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
  
	//����
	gcem_datefr.text = gs_date2+"01"; //���
	gcem_dateto.text = gs_date;
	
	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
}

/******************************************************************************
	Description : ��� - Header Set
******************************************************************************/
function ln_PrintHeader() {
		if(gcds_print2.countrow<1){

			var s_temp="GUBUN:STRING,FSREFVAL:STRING,COSTNM:STRING,ATCODE:STRING,ATKORNAM:STRING," 
					     + "PRTSEQ:STRING,SSDAT:STRING,SSNBR:STRING,FSSEQ:STRING,FSNBR:STRING,FSDAT:STRING,"
							 + "DEAMT:DECIMAL,CRAMT:DECIMAL,JANAMT:DECMAL,REMARK:STRING,"
							 + "VEND_CD:STRING,VEND_NM:STRING,"
							 + "KISU1:STRING,CURDT:STRING,CURTM:STRING,ATCODE2:STRING,ATCODENAME:STRING";
		 gcds_print2.SetDataHeader(s_temp);
	}
}

/***********************************************************************************************
	Description : ����Ʈ �÷� �����ϱ�
	parameter   : 
**********************************************************************************************/
function ln_Sum(){

  /***
	for(i=1;i<=gcds_print1.countrow;i++){
		gcds_print2.addrow();
		gcds_print2.namevalue(i,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
		gcds_print2.namevalue(i,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
		gcds_print2.namevalue(i,"COCODE")=gcds_print1.namevalue(i,"COCODE");
		gcds_print2.namevalue(i,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
		gcds_print2.namevalue(i,"REMARK")=gcds_print1.namevalue(i,"REMARK");
		gcds_print2.namevalue(i,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
		//gcds_print2.namevalue(i,"FSREFVAL")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print1.namevalue(i,"FSREFVAL")),"CDNAM");
		gcds_print2.namevalue(i,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
		gcds_print2.namevalue(i,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
		gcds_print2.namevalue(i,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
		gcds_print2.namevalue(i,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
		gcds_print2.namevalue(i,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
		gcds_print2.namevalue(i,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
		gcds_print2.namevalue(i,"DEAMT")=gcds_print1.namevalue(i,"DEAMT");
		gcds_print2.namevalue(i,"CRAMT")=gcds_print1.namevalue(i,"CRAMT");
		gcds_print2.namevalue(i,"JANAMT")=gcds_print1.namevalue(i,"JANAMT");
		gcds_print2.namevalue(i,"FSDAT")=gcds_print1.namevalue(i,"FSDAT");
		gcds_print2.namevalue(i,"FSNBR")=gcds_print1.namevalue(i,"FSNBR");

		gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
	//gcds_print2.namevalue(1,"FDCODENM2") = gclx_fsrefcd.text
	//gcds_print2.namevalue(1,"CURDT")		= gcem_actdat_fr.text + gcem_actdat_to.text;
		gcds_print2.namevalue(1,"CURDT2")		= gs_date;

	}
  **/
	//�׸��忡 ���
  var strno="";
  var dblDEMMSum=0;  //��������
	var dblCRMMSum=0;  //�뺯����
	var dblDEATSum=0; //���������� ����
	var dblCRATSum=0; //�뺯������ ����
	var dblJanSum=0;  //�ܾ׺� ��
  var dblrealrow=0; //�ǵ���Ÿ

	//����Ÿ�� ����
	//ln_SetDataHeader("01");
	
	//���� ����
  for(i=1;i<=gcds_print1.countrow;i++){

		if(gcds_print1.namevalue(i,"GUBUN")=="A"){ //�����̿�
       dblJanSum=0; 
			 dblDEATSum=0;
			 dblCRATSum=0;
       dblJanSum=gcds_print1.namevalue(i,"JANAMT");
			 //����
			 dblDEATSum = gcds_print1.namevalue(i,"DEAMT");
			 dblCRATSum = gcds_print1.namevalue(i,"CRAMT");
       gcds_print1.namevalue(i,"SSDAT")="";
		}else if(gcds_print1.namevalue(i,"GUBUN")=="M"){       //����
		   gcds_print1.namevalue(i,"SSDAT") = "";
       gcds_print1.namevalue(i,"ATCODE")="";
       gcds_print1.namevalue(i,"DEAMT") = dblDEMMSum;
			 gcds_print1.namevalue(i,"CRAMT") = dblCRMMSum;

			  //�����ܾ� �� ���
			 if(gcds_print1.namevalue(i,"ATDECR")=="1"){      //��������
					gcds_print1.namevalue(i,"JANAMT") = gcds_print1.namevalue(i,"DEAMT") - gcds_print1.namevalue(i,"CRAMT");
			 }else if(gcds_print1.namevalue(i,"ATDECR")=="2"){//�뺯����
					gcds_print1.namevalue(i,"JANAMT") = gcds_print1.namevalue(i,"CRAMT") -  gcds_print1.namevalue(i,"DEAMT");
			 }
       
			 //���� = �����̿� + ����
			 dblDEATSum = dblDEATSum +dblDEMMSum;
       dblCRATSum = dblCRATSum +dblCRMMSum;
       dblDEMMSum=0;
       dblCRMMSum=0;
		}else if(gcds_print1.namevalue(i,"GUBUN")=="T"){ //����
		   gcds_print1.namevalue(i,"SSDAT") = "";
       gcds_print1.namevalue(i,"ATCODE")="";
		   gcds_print1.namevalue(i,"DEAMT") = dblDEATSum;
			 gcds_print1.namevalue(i,"CRAMT") = dblCRATSum;
			 //�����ܾ�
			 gcds_print1.namevalue(i,"JANAMT") = dblJanSum;
		}else if(gcds_print1.namevalue(i,"GUBUN")=="B"){//�ǵ���Ÿ
		   if(gcds_print1.namevalue(i,"ATDECR")=="1"){      //��������
					dblJanSum = dblJanSum + gcds_print1.namevalue(i,"DEAMT")-gcds_data01.namevalue(i,"CRAMT");
	     }else if(gcds_print1.namevalue(i,"ATDECR")=="2"){//�뺯����
					dblJanSum = dblJanSum + gcds_print1.namevalue(i,"CRAMT")-gcds_data01.namevalue(i,"DEAMT");
			 }
			 
			 //���贩��
			 dblDEMMSum+=gcds_print1.namevalue(i,"DEAMT");
			 dblCRMMSum+=gcds_print1.namevalue(i,"CRAMT");

			 //����
			 gcds_print1.namevalue(i,"JANAMT") = dblJanSum;
       dblrealrow+=1;
		}

		gcds_print2.addrow();
		gcds_print2.namevalue(i,"FDCODE")=gcds_print1.namevalue(i,"FDCODE");
		gcds_print2.namevalue(i,"ATCODE")=gcds_print1.namevalue(i,"ATCODE");
		gcds_print2.namevalue(i,"COCODE")=gcds_print1.namevalue(i,"COCODE");
		gcds_print2.namevalue(i,"DIVCD")=gcds_print1.namevalue(i,"DIVCD");
		gcds_print2.namevalue(i,"REMARK")=gcds_print1.namevalue(i,"REMARK");
		gcds_print2.namevalue(i,"FSREFCD")=gcds_print1.namevalue(i,"FSREFCD");
		//gcds_print2.namevalue(i,"FSREFVAL")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print1.namevalue(i,"FSREFVAL")),"CDNAM");
		gcds_print2.namevalue(i,"ATKORNAM")=gcds_print1.namevalue(i,"ATKORNAM");
		gcds_print2.namevalue(i,"FSREFNM")=gcds_print1.namevalue(i,"FSREFNM");
		gcds_print2.namevalue(i,"CDNAM")=gcds_print1.namevalue(i,"CDNAM");
		gcds_print2.namevalue(i,"BEVAL")=gcds_print1.namevalue(i,"BEVAL");
		gcds_print2.namevalue(i,"SSNBR1")=gcds_print1.namevalue(i,"SSNBR1");
		gcds_print2.namevalue(i,"VENDNM")=gcds_print1.namevalue(i,"VENDNM");
		gcds_print2.namevalue(i,"DEAMT")=gcds_print1.namevalue(i,"DEAMT");
		gcds_print2.namevalue(i,"CRAMT")=gcds_print1.namevalue(i,"CRAMT");
		gcds_print2.namevalue(i,"JANAMT")=gcds_print1.namevalue(i,"JANAMT");
		gcds_print2.namevalue(i,"FSDAT")=gcds_print1.namevalue(i,"FSDAT");
		gcds_print2.namevalue(i,"FSNBR")=gcds_print1.namevalue(i,"FSNBR");
		gcds_print2.namevalue(i,"SSDAT")=gcds_print1.namevalue(i,"SSDAT");
		gcds_print2.namevalue(i,"SSNBR")=gcds_print1.namevalue(i,"SSNBR");

		gcds_print2.namevalue(1,"FDCODENM") = gclx_fdcode.text;
		gcds_print2.namevalue(i,"ATCODE2")=gcds_print1.namevalue(i,"ATCODE2");

	}
  
		gcds_print2.namevalue(1,"CURDT") = g_date;
		gcds_print2.namevalue(1,"CURTM") = g_time;

		gcds_print2.namevalue(1,"KISU1")		= gcem_datefr.text + gcem_dateto.text;
		if(txt_atkornam_fr.value==""){
      gcds_print2.namevalue(1,"ATCODENAME")= "";
		}else{
			gcds_print2.namevalue(1,"ATCODENAME")= "�����ڵ� : "+txt_atkornam_fr.value+"( "+txt_atcode_fr.value+" )" +"  ~  "+txt_atkornam_to.value+"( "+txt_atcode_to.value+" )";
		}


}
/******************************************************************************
	Description : �����˾�
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
		var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='ATUSEYN';
	if(p=="fr"){
		 //if(event.keyCode!=113&&event.keyCode!=13) return;
     arrParam[1]=txt_atkornam_fr.value;
	}else if(p=="to"){
	   //if(event.keyCode!=113&&event.keyCode!=13) return;
     arrParam[1]=txt_atkornam_to.value;
	}

	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr.value = arrParam[0];
				txt_atkornam_fr.value = arrParam[1];
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }else if(p=="to"){
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }
	}else{
		 if(p=="fr") {
				txt_atcode_fr.value = "";
				txt_atkornam_fr.value = "";
				txt_atcode_to.value = "";
				txt_atkornam_to.value = "";
		 }else if(p=="to"){
				txt_atcode_to.text = "";
				txt_atkornam_to.value = "";					
		 }
	}
}

/***********************************************************************************************
	Description : ��ǥ ã��
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_Popup2(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:610px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   :  
******************************************************************************/
function ln_Data_Reset(){

	//�׸��忡 ���
  var strno="";
  var dblDEMMSum=0;  //��������
	var dblCRMMSum=0;  //�뺯����
	var dblDEATSum=0; //���������� ����
	var dblCRATSum=0; //�뺯������ ����
	var dblJanSum=0;  //�ܾ׺� ��
  var dblrealrow=0; //�ǵ���Ÿ

	//����Ÿ�� ����
	//ln_SetDataHeader("01");
	
	//���� ����
  for(i=1;i<=gcds_data01.countrow;i++){

		if(gcds_data01.namevalue(i,"GUBUN")=="A"){ //�����̿�
       dblJanSum=0; 
			 dblDEATSum=0;
			 dblCRATSum=0;
       dblJanSum=gcds_data01.namevalue(i,"JANAMT");
			 //����
			 dblDEATSum = gcds_data01.namevalue(i,"DEAMT");
			 dblCRATSum = gcds_data01.namevalue(i,"CRAMT");
       gcds_data01.namevalue(i,"SSDAT")="";
		}else if(gcds_data01.namevalue(i,"GUBUN")=="M"){       //����
		   gcds_data01.namevalue(i,"SSDAT") = "";
       gcds_data01.namevalue(i,"ATCODE")="";
       gcds_data01.namevalue(i,"DEAMT") = dblDEMMSum;
			 gcds_data01.namevalue(i,"CRAMT") = dblCRMMSum;

			  //�����ܾ� �� ���
			 if(gcds_data01.namevalue(i,"ATDECR")=="1"){      //��������
					gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"DEAMT") - gcds_data01.namevalue(i,"CRAMT");
			 }else if(gcds_data01.namevalue(i,"ATDECR")=="2"){//�뺯����
					gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"CRAMT") -  gcds_data01.namevalue(i,"DEAMT");
			 }
       
			 //���� = �����̿� + ����
			 dblDEATSum = dblDEATSum +dblDEMMSum;
       dblCRATSum = dblCRATSum +dblCRMMSum;
       dblDEMMSum=0;
       dblCRMMSum=0;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="T"){ //����
		   gcds_data01.namevalue(i,"SSDAT") = "";
       gcds_data01.namevalue(i,"ATCODE")="";
		   gcds_data01.namevalue(i,"DEAMT") = dblDEATSum;
			 gcds_data01.namevalue(i,"CRAMT") = dblCRATSum;
			 //�����ܾ�
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
		}else if(gcds_data01.namevalue(i,"GUBUN")=="B"){//�ǵ���Ÿ
		   if(gcds_data01.namevalue(i,"ATDECR")=="1"){      //��������
					dblJanSum = dblJanSum + gcds_data01.namevalue(i,"DEAMT")-gcds_data01.namevalue(i,"CRAMT");
	     }else if(gcds_data01.namevalue(i,"ATDECR")=="2"){//�뺯����
					dblJanSum = dblJanSum + gcds_data01.namevalue(i,"CRAMT")-gcds_data01.namevalue(i,"DEAMT");
			 }
			 
			 //���贩��
			 dblDEMMSum+=gcds_data01.namevalue(i,"DEAMT");
			 dblCRMMSum+=gcds_data01.namevalue(i,"CRAMT");

			 //����
			 gcds_data01.namevalue(i,"JANAMT") = dblJanSum;
       dblrealrow+=1;
		}
	}
  
  ft_cnt03.innerText = "��ȸ�Ǽ� : " + dblrealrow + " ��";
  gcgd_disp01.DataID = "gcds_data01";
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ȸ  -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����  -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--����Ʈ  -->
<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
    ln_Data_Reset()
	}
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_print2.ClearData();
	ln_PrintHeader();
	ln_Sum();
	gcrp_print.preview(); 

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	var row = gcds_data01.rowposition;
	var p_fcod = gcds_data01.namevalue(row,"FDCODE");
	var p_fsdt = gcds_data01.namevalue(row,"FSDAT");
	var p_fnbr = gcds_data01.namevalue(row,"FSNBR");
	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//��ǥ Popup
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030016_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" width="685" align="right" >&nbsp;
			<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
			<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ----------------------->
<table cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="3" style="position:relative;left:3px;width:877px;border:0 solid #708090;">
			<tr>
				<td class="tab15" style="height:30px;width:80px;" bgcolor="#eeeeee" align =center>�����ڵ�</td>
				<td class="tab18" style="width:190px"><nobr>
					<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;">
						<param name=ComboDataID			value="gcds_fdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				
				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab18" style="height:30px;width:250px;" >&nbsp;<nobr>
					<comment id="__NSID__"><object  id=gcem_datefr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:-3px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		    value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				  <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_datefr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
					~&nbsp;
					<comment id="__NSID__"><object  id=gcem_dateto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative;left:-1px;top:3px; width:70px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_dateto', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
				</td>

				<td class="tab18" width="80px" bgcolor="#eeeeee" align =center>�����׸񰹼�</td>
				<td class="tab18" style="height:30px;width:120px;" >&nbsp;<nobr>
          <comment id="__NSID__"><object  id=gclx_refcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:-3px;top:2px;width:60px;">
						<param name=CBData  value="2^2��,3^3��,4^4��,5^5��,6^6��,7^7��,8^8��,9^9��">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				    value=false>
						<param name=ListExprFormat	value="FDNAME^0^50">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr> 
 
				<!-- 	<comment id="__NSID__">
					  <object id=LuxeCombo_ID classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=20 width=60>
							<param name=CBData  value="2^2��,3^3��,4^4��,5^5��,6^6��,7^7��,8^8��,9^9��">
					    <param name=CBDataColumns	  value="CNT,CNTNM">
						  <param name=SearchColumn		value="CNTNM">
						  <param name=Sort				    value=false>
						  <param name=ListExprFormat	value="CNTNM^0^110">
						  <param name=BindColumn			value="FDCODE">
            </object>
					</comment><script>__ws__(__NSID__);</script>  -->
				</td>
				
			</tr>
			<tr>
        <td class="tab17" style="height:25px;width:80px;" bgcolor="#eeeeee" align =center>�����ڵ�</td>
				<td class="tab19" width="690px" colspan=9>
				  <nobr>
					<input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('fr');">
					<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					&nbsp;&nbsp;&nbsp;~&nbsp;
					<input id="txt_atkornam_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:250px;height:20px;" maxlength="36" >
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Popup_Atcode('to');">
					<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6" >				
					</nobr>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>  

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:877px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:3px;width:875px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<param name=ColSizing     value="true">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
							  <FC>Name='�����ڵ�'	  ID=ATCODE   HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  sort=false </FC>
								<FC>Name='��������'	  ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=left    sort=false </FC>
								<FC>Name='��ǥ����'	  ID=SSDAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  sort=false </FC>
								<FC>Name='��ȣ'	      ID=SSNBR    HeadAlign=Center HeadBgColor=#B9D4DC Width=47  align=center  sort=false </FC>
                <FC>Name='����'	      ID=FSNUM    HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center  sort=false </FC>
								<C>Name='��������'	  ID=FSDAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=center  sort=false show=false</C>
								<C>Name='��ȣ'	      ID=FSNBR    HeadAlign=Center HeadBgColor=#B9D4DC Width=47  align=left    sort=false show=false</C>
								<C> Name='����'	      ID=DEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right color =#0000FF</C>
								<C> Name='�뺯'	      ID=CRAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right color =#FF0000</C>
								<C> Name='�ܾ�'	      ID=JANAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right </C>
								<C> Name='����'	      ID=REMARK   HeadAlign=Center HeadBgColor=#B9D4DC Width=285 align=left     sort=false</C>
								<C> Name='�ŷ�ó�ڵ�'	ID=FSREFVAL02   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�ŷ�ó��'	  ID=FSRVALNM02   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�μ�'	      ID=FSREFVAL01   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�μ���'	    ID=FSRVALNM01   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�3'	ID=FSREFVAL03   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�3'	ID=FSRVALNM03   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�4'	ID=FSREFVAL04   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�4'	ID=FSRVALNM04   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�5'	ID=FSREFVAL05   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�5'	ID=FSRVALNM05   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�6'	ID=FSREFVAL06   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�6'	ID=FSRVALNM06   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�7'	ID=FSREFVAL07   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�7'	ID=FSRVALNM07   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�8'	ID=FSREFVAL08   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�8'	ID=FSRVALNM08   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
								<C> Name='�����׸�9'	ID=FSREFVAL09   HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left sort=false</C>
								<C> Name='�����׸�9'	ID=FSRVALNM09   HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left sort=false</C>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>
		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N 
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
 	<param name="MasterDataID"			value="gcds_print2">
	<param name="DetailDataID"			value="gcds_print2">
	<param name="PaperSize"					value="A4">
 <param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false"> 
	<param name="LandScape"					value="true">
	<param name="PrintSetupDlgFlag" value="true">
<!-- 	<param name="SuppressColumns"   value="2:pageskip,COSTNM;1:ATKORNAM"> 
	<param name="MasterDataID"			    value="gcds_temp01">
	<param name="DetailDataID"			    value="gcds_temp01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true"> -->
<!-- 	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false"> -->

	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=368 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1095 ,top=34 ,right=2013 ,bottom=111 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1087 ,top=24 ,right=1998 ,bottom=103 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='������ ��������' ,left=1090 ,top=26 ,right=1992 ,bottom=90 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=172 ,top=291 ,right=2826 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=2365 ,top=233 ,right=2826 ,bottom=280 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( ȸ������ :' ,left=1069 ,top=119 ,right=1336 ,bottom=167 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')' ,left=1947 ,top=119 ,right=1995 ,bottom=167 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='KISU1', left=1344, top=119, right=1939, bottom=167 ,mask='XXXX/XX/XX      ~     XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڵ�' ,left=196 ,top=302 ,right=376 ,bottom=355 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ǥ����' ,left=693 ,top=302 ,right=878 ,bottom=355 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ǥ��ȣ' ,left=921 ,top=302 ,right=1090 ,bottom=355 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1389 ,top=302 ,right=1680 ,bottom=355 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1691 ,top=302 ,right=2013 ,bottom=355 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=2021 ,top=302 ,right=2786 ,bottom=355 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1095 ,top=302 ,right=1376 ,bottom=355 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='������' ,left=397 ,top=302 ,right=638 ,bottom=355 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=172 ,top=368 ,right=2823 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATCODENAME', left=193, top=233, right=1439, bottom=280, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='ATCODE', left=188, top=13, right=389, bottom=58, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSNBR', left=923, top=13, right=1080, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=1090, top=13, right=1381, bottom=58, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=1693, top=13, right=2016, bottom=58, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=400, top=13, right=677, bottom=58, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSDAT', left=683, top=13, right=889, bottom=58, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1389, top=13, right=1680, bottom=58, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=2029, top=13, right=2810, bottom=58, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1852 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2421 ,top=3 ,right=2831 ,bottom=87</I>
	<L> left=172 ,top=0 ,right=2831 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURTM', left=593, top=8, right=992, bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CURDT', left=196, top=8, right=598, bottom=53, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 