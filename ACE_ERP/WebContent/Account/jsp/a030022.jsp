<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - ��������(�Ϻ�)	
+ ���α׷� ID	:  A030022.html
+ �� �� �� ��	:  �Ϻ����� ��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a030022_s1
-----------------------------------------------------------------------------
+ �� �� �� ��  :	�������� ���� �� ��¹�����  
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.10.
------------------------------------------------------------------------------->
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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_amt01 = 0;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
	ln_SetDataHeader();
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(){
	var str1 = gclx_sfdcode.BindColVal;	
	var str2 = gcem_staxdatfr.text;			
	var str3 = gcem_staxdatto.text;
	var str4 = gcem_atcode_fr01.text;
    var str5 = gcem_atcode_to01.text;
	/*
	var str5 = str2.substring(0,4);
	var str6 = str3.substring(6,8);
	var str7 = "";
	var temp=str2.substring(0,6);

  if(str2.substring(4,6)=="01") {
		str7 = str2.substring(0,6)+"00";
	}else{
		str7 = Number(temp-1)+"31";
	}
	*/
  
	if(str2 != "" && str3 != "" ) {
	  gcgd_disp01.DataID ="";
		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030022_s1?v_str1="+str1
											                                     + "&v_str2="+str2
																													 + "&v_str3="+str3
																													 + "&v_str4="+str4
											                                     + "&v_str5="+str5;

		
		gcds_data1.Reset();

	}else{
		alert("�Ⱓ�� �����Ͻʽÿ�.");
	}
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

/******************************************************************************************
	Description : ��ȸ - ���
******************************************************************************************/
function ln_PrtQuery(){
	gcds_print.ClearData();
	//for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
		var str2 = gcem_staxdatfr.text;				//ȸ��Ⱓfr	
		var str3 = gcem_staxdatto.text;				//ȸ��Ⱓto
		var str4 = gcem_atcode_fr01.text;     //�����ڵ�fr
		var str5 = gcem_atcode_to01.text;     //�����ڵ�to

		/*
		var str5 = str2.substring(0,4);				//�˻��⵵
		var str6 = str3.substring(6,8);				//�˻�����
		var str7 = "";												//�����̿�
		var temp = str2.substring(0,6);

		if (str2.substring(4,6) =="01") {	
			str7 = str2.substring(0,6)+"00";
		}else{
			str7 = Number(temp-1)+"31";
		}
		*/

 
		if(str2 !="" && str3 != "" ) {
			gcds_data2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030022_s1?v_str1="+str1+"&v_str2="+str2
												                                    +"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5;

			gcds_data2.Reset();

		}
	//}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
	ln_PrtQuery();		//�����ȸ
	ln_SetDataHeader();
	gcds_print.addrow();
	//gcds_print.namevalue(1,"ATKORNAM") = txt_curatkornam_to01.value;
	gcds_print.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
	gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
	gcds_print.namevalue(1,"CURDT2")	 = gs_date;

	gcrp_print.preview(); 

}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){

  if(gcds_print.countrow<=0){
		var s_temp = "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING";
		gcds_print.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("��������","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_staxdatfr.text = gs_date2 + "01";
	gcem_staxdatto.text = gs_date;

	//�����ڵ�[�˻�]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();
}

/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(p2,p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";

	if(p2=="fr"){
		arrParam[1]=txt_atkornam_fr01.value;
	}else if(p2=="to"){
		arrParam[1]=txt_atkornam_to01.value;
	}
	
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrParam[0];
					txt_atkornam_fr01.value = arrParam[1];

					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					//ln_CurActcode();	//������� ��ȸ
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					//ln_CurActcode();	//������� ��ȸ
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				txt_atkornam_fr01.value ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}
	}
}

/***********************************************************************************************
	Description : [�Ϻ�] - ��ǥ ã��
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
  for(i=1;i<=gcds_data1.countrow;i++){
       
       // alert("GUBUN::"+gcds_data1.namevalue(i,"GUBUN"));
       
		if(gcds_data1.namevalue(i,"GUBUN")=="A"){ //�����̿�
             dblJanSum=0; 
			 dblDEATSum=0;
			 dblCRATSum=0;
             dblJanSum=gcds_data1.namevalue(i,"SLPVLA");
			 //����
			 dblDEATSum = gcds_data1.namevalue(i,"DETOT");
			 dblCRATSum = gcds_data1.namevalue(i,"CRTOT");
             gcds_data1.namevalue(i,"SSDAT")="";
		}else if(gcds_data1.namevalue(i,"GUBUN")=="M"){       //����
		     gcds_data1.namevalue(i,"ACTDAT") = "";
             gcds_data1.namevalue(i,"ATCODE") = "";
             gcds_data1.namevalue(i,"DETOT") = dblDEMMSum;
			 gcds_data1.namevalue(i,"CRTOT") = dblCRMMSum;

			 //�����ܾ� �� ���
			 if(gcds_data1.namevalue(i,"ATDECR")=="1"){      //��������
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT") - gcds_data1.namevalue(i,"CRTOT") ;
			 }else if(gcds_data1.namevalue(i,"ATDECR")=="2"){//�뺯����
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT") -  gcds_data1.namevalue(i,"DETOT") ;
			 }

			 //���� = �����̿� + ����
			 dblDEATSum = dblDEATSum +dblDEMMSum;
             dblCRATSum = dblCRATSum +dblCRMMSum;
             dblDEMMSum=0;
             dblCRMMSum=0;
		}else if(gcds_data1.namevalue(i,"GUBUN")=="T"){ //����
		    gcds_data1.namevalue(i,"ACTDAT") = "";
            gcds_data1.namevalue(i,"ATCODE")="";
		    gcds_data1.namevalue(i,"DETOT") = dblDEATSum;
			 gcds_data1.namevalue(i,"CRTOT") = dblCRATSum;
			 //�����ܾ�
			 gcds_data1.namevalue(i,"SLPVLA") = dblJanSum;
		}else if(gcds_data1.namevalue(i,"GUBUN")=="B"){//�ǵ���Ÿ
		   if(gcds_data1.namevalue(i,"ATDECR")=="1"){      //��������
					dblJanSum = dblJanSum + gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
	     }else if(gcds_data1.namevalue(i,"ATDECR")=="2"){//�뺯����
					dblJanSum = dblJanSum + gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");
			 }
			 
			 //���贩��
			 dblDEMMSum+=gcds_data1.namevalue(i,"DETOT");
			 dblCRMMSum+=gcds_data1.namevalue(i,"CRTOT");

			 //����
			 gcds_data1.namevalue(i,"SLPVLA") = dblJanSum;
           dblrealrow+=1;
		}
	}
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + dblrealrow + " ��";
  gcgd_disp01.DataID = "gcds_data1";
	
}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   :  
******************************************************************************/
function ln_Data_Reset2(){
  
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
  for(i=1;i<=gcds_data2.countrow;i++){

		if(gcds_data2.namevalue(i,"GUBUN")=="A"){ //�����̿�
       dblJanSum=0; 
			 dblDEATSum=0;
			 dblCRATSum=0;
       dblJanSum=gcds_data2.namevalue(i,"SLPVLA");
			 //����
			 dblDEATSum = gcds_data2.namevalue(i,"DETOT");
			 dblCRATSum = gcds_data2.namevalue(i,"CRTOT");
       gcds_data2.namevalue(i,"SSDAT")="";
		}else if(gcds_data2.namevalue(i,"GUBUN")=="M"){       //����
		   gcds_data2.namevalue(i,"ACTDAT") = "";
       gcds_data2.namevalue(i,"ATCODE") = "";
       gcds_data2.namevalue(i,"DETOT") = dblDEMMSum;
			 gcds_data2.namevalue(i,"CRTOT") = dblCRMMSum;
			 
			 //�����ܾ� �� ���
			 if(gcds_data2.namevalue(i,"ATDECR")=="1"){      //��������
					gcds_data2.namevalue(i,"SLPVLA") = gcds_data2.namevalue(i,"DETOT") - gcds_data2.namevalue(i,"CRTOT");
			 }else if(gcds_data2.namevalue(i,"ATDECR")=="2"){//�뺯����
					gcds_data2.namevalue(i,"SLPVLA") = gcds_data2.namevalue(i,"CRTOT") -  gcds_data2.namevalue(i,"DETOT");
			 }
       
			 //���� = �����̿� + ����
			 dblDEATSum = dblDEATSum +dblDEMMSum;
       dblCRATSum = dblCRATSum +dblCRMMSum;
       dblDEMMSum=0;
       dblCRMMSum=0;
		}else if(gcds_data2.namevalue(i,"GUBUN")=="T"){ //����
		   gcds_data2.namevalue(i,"ACTDAT") = "";
       gcds_data2.namevalue(i,"ATCODE")="";
		   gcds_data2.namevalue(i,"DETOT") = dblDEATSum;
			 gcds_data2.namevalue(i,"CRTOT") = dblCRATSum;
			 //�����ܾ�
			 gcds_data2.namevalue(i,"SLPVLA") = dblJanSum;
		}else if(gcds_data2.namevalue(i,"GUBUN")=="B"){//�ǵ���Ÿ
		   if(gcds_data2.namevalue(i,"ATDECR")=="1"){      //��������
					dblJanSum = dblJanSum + gcds_data2.namevalue(i,"DETOT")-gcds_data2.namevalue(i,"CRTOT");
	     }else if(gcds_data2.namevalue(i,"ATDECR")=="2"){//�뺯����
					dblJanSum = dblJanSum + gcds_data2.namevalue(i,"CRTOT")-gcds_data2.namevalue(i,"DETOT");
			 }
			 
			 //���贩��
			 dblDEMMSum+=gcds_data2.namevalue(i,"DETOT");
			 dblCRMMSum+=gcds_data2.namevalue(i,"CRTOT");

			 //����
			 gcds_data2.namevalue(i,"SLPVLA") = dblJanSum;
       dblrealrow+=1;
		}
	}
  
  //ft_cnt01.innerText = "��ȸ�Ǽ� : " + dblrealrow + " ��";
  //gcgd_disp01.DataID = "gcds_data2";
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
	<!-- <PARAM NAME="SubsumExpr"	VALUE="1:LEVELS,2:ACTDAT"> -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030022_t1(I:USER=gcds_data1)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��"; 
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	  ln_Data_Reset();
		/////ln_Cumulative();	//����
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	
	if(row>0){ 
			ln_Data_Reset2();
	}
</script>

<script language="javascript" for="gcds_temp" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnDblClick()">
	var row = gcds_data1.rowposition;
	var p_fcod = gcds_data1.namevalue(row,"FDCODE");
	var p_fsdt = gcds_data1.namevalue(row,"FSDAT");
	var p_fnbr = gcds_data1.namevalue(row,"FSNBR");
	ln_Popup2(p_fcod,p_fsdt,p_fnbr);	//��ǥ Popup
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data1 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data1 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030022_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
	<tr><td colspan="2" height="1px"></td></tr>
</table>

<table cellpadding="0" cellspacing="0" border="0">
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" width="220px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel()">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query()">
				</td>
			</tr>
			
			<tr> 				
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab23" colspan="8" width="690px">&nbsp;<comment id="__NSID__">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:-2px;left:-7px;width:150px;height:20px;" maxlength="36"  > 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:-8px;top:3px" align=center onclick="ln_Popup('fr','01');">
					<object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>
					~&nbsp;<comment id="__NSID__">
				   	<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:-2px;width:150px;height:20px;" maxlength="36"  >  
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:-3px;top:3px" align=center onclick="ln_Popup('to','01');">
					<object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script>     
					
				
				</td>
				<!-- <td class="tab12" width="60px" align=left>
					<img src="../../common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,-1)">
					<img src="../../common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,1)">
				</td>
				<td class="tab12" width="80px" bgcolor="#eeeeee">�������</td>
				<td width="170px">
					<comment id="__NSID__"><object  id=gcem_curatcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<input id="txt_curatkornam_to01" type="text" class="txtbox"  style= "position:relative;left:8px;top:-2px;width:105px;height:20px;" maxlength="36" ReadOnly>
				</td> -->
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49   
						style="position:relative;left:8px;width:864px;height:379px; border:1 solid #708090;display:block;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<PARAM NAME="ColSizing"		VALUE="true">
						<param name="Editable"    value="false">
						<!-- <PARAM NAME="ViewSummary"	VALUE="1"> -->
						<PARAM NAME="Format"			VALUE="  
						<C> Name='����'			ID=ATCODE    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center SumBgColor=#C3D0DB show=false</C> 
						<C> Name='������'		ID=ATKORNAM  HeadAlign=Center HeadBgColor=#B9D4DC Width=95	align=left SumBgColor=#C3D0DB </C> 
						<C> Name='����'			ID=ACTDAT  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center SumBgColor=#C3D0DB Mask='XXXX/XX/XX'</C> 
						<C> Name='��ǥ��ȣ'	ID=SSNBR   HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center SumBgColor=#C3D0DB </C> 
						<C> Name='����'	    ID=FSNUM   HeadAlign=Center HeadBgColor=#B9D4DC Width=25	align=center show=false SumBgColor=#C3D0DB </C> 
						<C> Name='����'			ID=REMARK  HeadAlign=Center HeadBgColor=#B9D4DC Width=235	align=left	 SumBgColor=#C3D0DB </C> 
						<C> Name='�ŷ�ó�ڵ�'	ID=VEND_CD  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	 SumBgColor=#C3D0DB SumText='' show=false</C>
						<C> Name='�ŷ�ó��'	ID=VENDER  HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	 SumBgColor=#C3D0DB </C>
						<C> Name='����'			ID=DETOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right	 SumBgColor=#C3D0DB color =#0000FF</C> 
						<C> Name='�뺯'			ID=CRTOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right	 SumBgColor=#C3D0DB color =#FF0000</C> 
						<C> Name='�ܾ�'			ID=SLPVLA  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right  SumBgColor=#C3D0DB </C> 
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
					</fieldset><!-- mask={decode(ACTDAT,'�����̿�','XXXX','XXXX/XX/XX')} -->
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
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr01				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to01				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_data2">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATKORNAM;">
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=375 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1101 ,top=34 ,right=1937 ,bottom=111 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1090 ,top=21 ,right=1926 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=934, top=119, right=2077, bottom=167 ,mask='(  ȸ������ : XXXX�� XX�� XX��  ~  XXXX�� XX�� XX��  )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��  ��' ,left=1095 ,top=26 ,right=1921 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=241 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=2447 ,top=291 ,right=2802 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=2077 ,top=291 ,right=2434 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=1709 ,top=291 ,right=2064 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2439 ,top=283 ,right=2439 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=283 ,right=2072 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1704 ,top=283 ,right=1704 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=283 ,right=241 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=447 ,top=283 ,right=447 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=180, right=2805, bottom=228, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2805 ,bottom=280 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=241, top=180, right=1087, bottom=228, align='left' ,mask='��      ��: XXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1310 ,top=283 ,right=1310 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ŷ�ó��' ,left=1315 ,top=291 ,right=1699 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=241, top=228, right=1087, bottom=280, align='left' ,mask='��������: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��' ,left=246 ,top=291 ,right=439 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=373 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ��ȣ' ,left=452 ,top=291 ,right=622 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=643 ,top=291 ,right=1296 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=630 ,top=283 ,right=630 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<C>id='SLPVLA', left=2447, top=0, right=2802, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2439 ,top=0 ,right=2439 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRTOT', left=2077, top=0, right=2434, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETOT', left=1709, top=0, right=2064, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<C>id='VENDER', left=1315, top=0, right=1699, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1310 ,top=0 ,right=1310 ,bottom=50 </L>
	<L> left=447 ,top=0 ,right=447 ,bottom=50 </L>
	<C>id='ACTDAT', left=246, top=0, right=439, bottom=45 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 </L>
	<L> left=241 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='SSNBR', left=458, top=0, right=619, bottom=45, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=643, top=0, right=1296, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=630 ,top=0 ,right=630 ,bottom=50 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=241 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1858 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=241 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
----------------------------------------------------------------------------->

</body>
</jsp>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 