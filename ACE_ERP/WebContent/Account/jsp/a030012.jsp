<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ������-�����׸񺰿���	(�Ѱ�/����)
+ ���α׷� ID	:  a030012.html
+ �� �� �� ��	:  �����׸񺰿��� ��ȸ �� ��� 
+ ��   ��  ��:   �Ϲμ� 
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ���� �� ȭ�� ����   
+ ��   ��  �� :  ������ 
+ �� �� �� �� :  2006.03.18
-----------------------------------------------------------------------------
+ �� �� �� �� :	����Ʈ
+ ��   ��  �� : �� �� �� 
+ �� �� �� �� : 2006.03.23
-----------------------------------------------------------------------------
+ �� �� �� �� :	���� ����
+ ��   ��  �� : ������
+ �� �� �� �� : 2006.09.30
-----------------------------------------------------------------------------
+ �� �� �� ��	:  a030012_s1,a030012_s2
------------------------------------------------------------------------------
+ �� �� �� ��  :	�������� ���� �� ��¹� �ۼ�  
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.10
------------------------------------------------------------------------------
+ �� �� �� ��  :	�����׸� �������� �˾��� ����������� �ٷ� ��ǥ�� ��. 
+ ��   ��  ��  :  ������
+ �� �� �� ��  :  2007.05.17
------------------------------------------------------------------------------
+ �� �� �� ��  :	 ���� �ǿ��� �����׸�1�� ��ü��ȸ �߰� ( ��ü �ϰ�� �׸� �Է� ���ܽ�Ŵ ) 
+ ��   ��  ��  :  ������
+ �� �� �� ��  : 2016.06.13
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����׸񺰿���</title>

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
//get_cookdata();


var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
//var gs_date01 = gcurdate.substring(0,4) + "/" +gcurdate.substring(5,7) + "." +gcurdate.substring(8,10);

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptnm = gdeptnm;
var gs_deptcd = gdeptcd;
var gstr_fsdat="";

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	//ln_DispChk(0);	
	ln_Before();
			
	 gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
     gcds_dept.Reset();
     if(gclx_sfdcode.Enable==true)
      gclx_sfdcode.BindColVal = gs_fdcode;			
	}
	
	
    chkbox_fsrefcd_1.checked = false;

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(s){

	if(s=="01") {
	  if(!ln_Chk('gcem_atkornam_fr01')) return;
  	  var str1 = gclx_sfdcode.BindColVal;       //	�����ڵ�
	  var str2 = gcem_staxdatfr.text;	          //  �Ⱓfrom 
	  var str3 = gcem_staxdatto.text;           //  �Ⱓto	
	  var str4 = gcem_atcode_fr01.text;					//  ��������
	  var str5 = gclx_fsrefcd.BindColVal;				//  �����׸�1  
 	  var str6 = gclx_fsrefcd2.BindColVal;			//  �����׸�2 
	  var str7 = gclx_fsrefcd3.BindColVal;			//  �����׸�3 

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s1?v_str1="+str1
																													+ "&v_str2="+str2
																													+ "&v_str3="+str3										
																													+ "&v_str4="+str4
																													+ "&v_str5="+str5
																													+ "&v_str6="+str6
																													+ "&v_str7="+str7;
    //  prompt("",  gcds_data1.DataID);
		gcds_data1.Reset();
	
	//	}
		
	}else if(s=="02") {
		
    	if(!ln_Chk('gcem_atcode_fr012')) return;
		if(!ln_Chk1('gclx_fsrefcd_1')) return;
		
		//�����׸� 1 �� ��츸 üũ
		var str10 = "";
		
	    if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal==""&&gclx_fsrefcd_3.BindColVal==""){
	    	
	    	if(chkbox_fsrefcd_1.checked==true){ //��ü �̼��ýø� üũ
	    		str10 ="Y";
	    	}else{
	    		if(!ln_Chk1('gcem_vend_fr')) return;
		  		if(!ln_Chk1('gcem_vend_to')) return;
	    	}
	    }else{
	    	if(!ln_Chk1('gcem_vend_fr')) return;
	  		if(!ln_Chk1('gcem_vend_to')) return;
	    }
		
		var str1 = gclx_sfdcode2.BindColVal;   // �����ڵ�
		var str2 = gcem_staxdatfr2.text;       // �Ⱓfrom
		var str3 = gcem_staxdatto2.text;       // �Ⱓto		

		var str4 = gcem_atcode_fr012.text;     // ��������
	    var str5 = gclx_fsrefcd_1.BindColVal;  // �����׸�1
	    var str6 = gclx_fsrefcd_2.BindColVal;  // �����׸�2
	    var str7 = gclx_fsrefcd_3.BindColVal;  // �����׸�3
  
		var str8 = gcem_vend_fr.text;			//�����׸�1 from
		var str9 = gcem_vend_to.text;			//�����׸�1 to
		

		gcds_temp01.clearall();

		// �����׸� 3��
    	if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal!=""){
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s3?v_str1="+str1
																				+ "&v_str2="+str2
																				+ "&v_str3="+str3
																				+ "&v_str4="+str4
																				+ "&v_str5="+str5
																				+ "&v_str6="+str6
																				+ "&v_str7="+str7
																				+ "&v_str8="+str8								
																				+ "&v_str9="+str9;
			//prompt("",  gcds_data2.DataID);
			gcds_data2.Reset();
		// �����׸� 2��
    	}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal==""){
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s4?v_str1="+str1
																				+ "&v_str2="+str2
																				+ "&v_str3="+str3
																				+ "&v_str4="+str4
																				+ "&v_str5="+str5
																				+ "&v_str6="+str6
																				+ "&v_str7="+str7
																				+ "&v_str8="+str8								
																				+ "&v_str9="+str9;
			//prompt("a030012_s4",  gcds_data2.DataID);
			gcds_data2.Reset();
    	// �����׸� 1��
		}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal==""&&gclx_fsrefcd_3.BindColVal==""){
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s5?v_str1="+str1
																				+ "&v_str2="+str2
																				+ "&v_str3="+str3
																				+ "&v_str4="+str4
																				+ "&v_str5="+str5
																				+ "&v_str6="+str6
																				+ "&v_str7="+str7
																				+ "&v_str8="+str8								
																				+ "&v_str9="+str9
																				+ "&v_str10="+str10;
			//prompt("a030012_s5",  gcds_data2.DataID);
			gcds_data2.Reset();
		}
	}
}

/******************************************************************************
	Description : ���(����)
******************************************************************************/
function ln_Print02(){

	if (gcds_temp01.countrow<1) {
		alert("����Ͻ� ������ �����ϴ�");
	} else {
			gcds_print01.ClearData();
			
			var ls_temp = "FDCODE:STRING,ATCODE:STRING,COCODE:STRING,FSREFVAL1:STRING,CUDATE:STRING,"
											 + "FSREFVAL02:STRING,FSREFVAL03:STRING,ATKORNAM:STRING,CDNAM1:STRING,JANAMT:DECIMAL,"
											 + "BEVAL:DECIMAL,DEAMT:DECIAML,CRAMT:DECIAML,SLPVAL:DECIMAL,SSDANBR:STRING,"
											 + "FDCODENM:STRING,FDCODENM2:STRING,CURDT:STRING,REMARK:STRING,CDNAM2:STRING,FSREFVAL2:STRING";
			gcds_print01.SetDataHeader(ls_temp); //������(����)
			gcds_print02.SetDataHeader(ls_temp); //������(�Ķ�)

			gcds_print02.Addrow();					
		
			gcds_print02.namevalue(1,"ATCODE")   = gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE");
			gcds_print02.namevalue(1,"ATKORNAM") = gcds_temp01.namevalue(gcds_temp01.rowposition,"ATKORNAM");
			gcds_print02.namevalue(1,"CUDATE")	 = gcem_staxdatfr2.text +  gcem_staxdatto2.text;
			gcds_print02.namevalue(1,"CURDT")		 = gs_date;
			gcds_print02.namevalue(1,"FDCODENM") = gclx_sfdcode2.text;
			//gcrp_print2.preview();	2006-11-03


//	if (gcds_temp01.namevalue(gcds_temp01.rowposition,"CERKIND")=="1") gcrp_print2.preview();				//�����׸�1

	if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal!=""){
			gcrp_print4.preview();	//�����׸�3
		}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal==""){
      gcrp_print3.preview();	//�����׸�2
//		}
		}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal==""&&gclx_fsrefcd_3.BindColVal==""){
      gcrp_print2.preview();	//�����׸�1

}
	}
}

/***********************************************************************************************
	Description : ����Ʈ �÷� �����ϱ�
	parameter   : 
**********************************************************************************************/
function ln_Sum1(){
	for(i=1;i<=gcds_print11.countrow;i++){
	gcds_print12.addrow();
	gcds_print12.namevalue(i,"FDCODE")=gcds_print11.namevalue(i,"FDCODE");
	gcds_print12.namevalue(i,"ATCODE")=gcds_print11.namevalue(i,"ATCODE");


	if (gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL01")) >= 1)gcds_print12.namevalue(i,"FSREFVAL01")=gcds_fsrefcd2.namevalue(gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL01")),"CDNAM");
	if (gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL02")) >= 1)gcds_print12.namevalue(i,"FSREFVAL02")=gcds_fsrefcd3.namevalue(gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL02")),"CDNAM");
	if (gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL03")) >= 1)gcds_print12.namevalue(i,"FSREFVAL03")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL03")),"CDNAM");	

	
	gcds_print12.namevalue(i,"BEVAL")=gcds_print11.namevalue(i,"BEVAL");
	gcds_print12.namevalue(i,"FSREFNM01")=gcds_print11.namevalue(i,"FSREFNM01");
	gcds_print12.namevalue(i,"FSREFNM02")=gcds_print11.namevalue(i,"FSREFNM02");
	gcds_print12.namevalue(i,"FSREFNM03")=gcds_print11.namevalue(i,"FSREFNM03");	
	gcds_print12.namevalue(i,"DEAMT")=gcds_print11.namevalue(i,"DEAMT");
	gcds_print12.namevalue(i,"CRAMT")=gcds_print11.namevalue(i,"CRAMT");
	gcds_print12.namevalue(i,"SLPVAL")=gcds_print11.namevalue(i,"SLPVAL");

	//[�̼���:�ڵ��߰� START]---------------------------------------------------------------------
	gcds_print12.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
	gcds_print12.namevalue(1,"FDCODENM2") = gcem_atkornam_fr01.text;
	gcds_print12.namevalue(1,"CURDT")		= gcem_staxdatfr.text + gcem_staxdatto.text;
	gcds_print12.namevalue(1,"CURDT2")		= gs_date;
	//[�̼���:�ڵ��߰� END]-----------------------------------------------------------------------
	}
}

/******************************************************************************************
	Description : ����Ʈ
******************************************************************************************/
function ln_Print(s){

	if(s=="01") {
	  if(!ln_Chk('gcem_atkornam_fr01')) return;
		var str1 = gclx_sfdcode.BindColVal;       //	�����ڵ�
		var str2 = gcem_staxdatfr.text;	          //  �Ⱓfrom 
		var str3 = gcem_staxdatto.text;           //  �Ⱓto	
		var str4 = gcem_atcode_fr01.text;					//  ��������
	    var str5 = gclx_fsrefcd.BindColVal;				//  �����׸�1  
 	    var str6 = gclx_fsrefcd2.BindColVal;			//  �����׸�2 
	    var str7 = gclx_fsrefcd3.BindColVal;			//  �����׸�3 

   // if( str1 !="" && str5 !="" &&  str6 != "" && str7 != ""){
		gcds_print11.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s1?v_str1="+str1
																													+ "&v_str2="+str2
																													+ "&v_str3="+str3										
																													+ "&v_str4="+str4
																													+ "&v_str5="+str5
																													+ "&v_str6="+str6
																													+ "&v_str7="+str7;
     // prompt("",  gcds_data1.DataID);
		gcds_print11.Reset();
	
	//	}
		
	}else if(s=="02") {
	  alert("�������Դϴ�.");
		return;
    if(!ln_Chk('gcem_atkornam_fr012')) return;
		if(!ln_Chk1('gcem_vend_fr')) return;
		if(!ln_Chk1('gcem_vend_to')) return;
		var str1 = gclx_sfdcode2.BindColVal;   // �����ڵ�
		var str2 = gcem_staxdatfr2.text;       // �Ⱓfrom
		var str3 = gcem_staxdatto2.text;       // �Ⱓto		

		var str4 = gcem_atcode_fr012.text;     // ��������
    var str5 = gclx_fsrefcd_1.BindColVal;  // �����׸�1
    var str6 = gclx_fsrefcd_2.BindColVal;  // �����׸�2
    var str7 = gclx_fsrefcd_3.BindColVal;  // �����׸�3
  
	  var str8 = gcem_vend_fr.text;					//�����׸�1 from
	  var str9 = gcem_vend_to.text;					//�����׸�1 to

		gcds_print21.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030012_s2?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+str3
												+ "&v_str4="+str4
												+ "&v_str5="+str5
												+ "&v_str6="+str6
												+ "&v_str7="+str7
												+ "&v_str8="+str8								
												+ "&v_str9="+str9;

      //prompt("",  gcds_data2.DataID);
		gcds_print21.Reset();
		
	}
}

/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(p2,p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
  arrParam[0]='ATUSEYN';
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (result != null) {
				arrResult = result.split(";");

			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrResult[0];
					gcem_atkornam_fr01.text = arrResult[1];
				
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrResult[0];
					txt_atkornam_to01.value = arrResult[1];
						    
			 }

			gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp.Reset();

			gcds_temp2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp2.Reset();

			gcds_temp3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp3.Reset();

		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				gcem_atkornam_fr01.text ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}

	}else if(p=="02"){

		if (result != null) {
				arrResult = result.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr012.text = arrResult[0];
					gcem_atkornam_fr012.text = arrResult[1];
					
			 }else if(p2=="to"){
					gcem_atcode_to012.text = arrResult[0];
					txt_atkornam_to012.value = arrResult[1];
					
			 }

			gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp.Reset();

			gcds_temp2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp2.Reset();

			gcds_temp3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp3.Reset();

			
			gcds_temp4.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp4.Reset();

		} else {
		  	
			if(p2=="fr") {
				gcem_atcode_fr012.text = "";
				gcem_atkornam_fr012.text = "";
			}else if(p2=="to"){
				gcem_atcode_fr012.text = "";
				gcem_atkornam_fr012.text = "";
			}
		}
	}
}

/******************************************************************************
	Description : �ŷ�ó ã�� ==> �ŷ�ó�� �ƴ� �Ϲ� �����׸����� �����.
******************************************************************************/
function Popup(p){             
  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//alert("gclx_fsrefcd_1:"+gclx_fsrefcd_1.bindcolval);
	if(gclx_fsrefcd_1.bindcolval=="0020"){//�μ��ڵ峪 �ŷ�ó
		strURL = "./gczm_vender_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    }else if(gclx_fsrefcd_1.bindcolval=="0002"){
		strURL = "./hcdept_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
	    arrParam[0] = gclx_fsrefcd_1.bindcolval;
		arrParam[1] = "";
		arrParam[2] = "";
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}
	
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		 if(p=="fr") {
				 gcem_vend_fr.text = arrResult[0];
				 txt_vend_fr.value = arrResult[1];

				 gcem_vend_to.text = arrResult[0];
				 txt_vend_to.value = arrResult[1];
		 }else if(p=="to"){
				gcem_vend_to.text = arrResult[0];
				txt_vend_to.value = arrResult[1];
				
			}
	} else {
		if(p=="fr") {
			gcem_vend_fr.text = "";
			txt_vend_fr.value = "";
		}else if(p=="to"){
			gcem_vend_to.text = "";
			txt_vend_to.value = "";
		}
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

/******************************************************************************
	Description : ���
******************************************************************************/
//function ln_Print(){

//}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){

  if(e=="01") {
//	gcgd_disp01.runexcel("�����׸񺰿���");
    gcgd_disp01.GridToExcel("�����׸񺰿���","",2);
	}
	else if(e=="02") {
	//gcgd_disp02.runexcel("�����׸񺰿���");
    gcgd_disp02.GridToExcel("�����׸񺰿���","",2);
	}

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){

	gcem_staxdatfr.text  = gs_date2 + "01";
    gcem_staxdatfr2.text = gs_date2 + "01";
	gcem_staxdatto.text  = gs_date;
	gcem_staxdatto2.text = gs_date;

	//�����ڵ�[�˻�]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();
	
	//�����׸�[�˻�]
    gcds_fsrefcd_1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
  	gcds_fsrefcd_1.Reset();

	//gcds_scccode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendcode_s1?v_str1="; 
	//gcds_scccode.Reset();
}

/***********************************************************************************************
	Description : [�Ѱ�] 
	parameter   : fcod - �����ڵ�, atcod - �����ڵ�, frdt - �˻�����(from), todt - �˻�����(to)
**********************************************************************************************/
function ln_Popup2(fcod,atcod,frdt,todt){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-�Ϻ��ڵ�, 1-�����׸�
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
		  eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}


/******************************************************************************
	Description :  �����׸� ã��
	parameter    : p  - 01 �Ѱ�,  02 ����
	               p2 - ����    ( fr, to)
	               obj - object�� 
******************************************************************************/
function ln_Onblur(p,p2,obj){
  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
  
	if(event.keyCode!=113) return;
  arrParam[0]='ATUSEYN';
	arrParam[1]=eval(obj).text;
	
	strURL = "./actcode_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if(p=="01"){
		if (result != null) {
				arrResult = result.split(";");

			 if(p2=="fr") {
					gcem_atcode_fr01.text = arrResult[0];
					gcem_atkornam_fr01.text = arrResult[1];
				
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrResult[0];
					txt_atkornam_to01.value = arrResult[1];
						    
			 }

			gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp.Reset();

			gcds_temp2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp2.Reset();

			gcds_temp3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp3.Reset();

		} else {
			if(p2=="fr") {
				gcem_atcode_fr01.text = "";
				gcem_atkornam_fr01.text ="";
			}else if(p2=="to"){
				gcem_atcode_to01.text = "";
				txt_atkornam_to01.value = "";
			}
		}

	}else if(p=="02"){

		if (result != null) {
				arrResult = result.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr012.text = arrResult[0];
					gcem_atkornam_fr012.text = arrResult[1];
					
			 }else if(p2=="to"){
					gcem_atcode_to012.text = arrResult[0];
					txt_atkornam_to012.value = arrResult[1];
					
			 }

			gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp.Reset();

			gcds_temp2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp2.Reset();

			gcds_temp3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+arrResult[0];	
			gcds_temp3.Reset();
		} else {
		  	
			if(p2=="fr") {
				gcem_atcode_fr012.text = "";
				gcem_atkornam_fr012.text = "";
			}else if(p2=="to"){
				gcem_atcode_fr012.text = "";
				gcem_atkornam_fr012.text = "";
			}
		}
	}
}


function ln_Chk(obj){
	
	if (eval(obj).text=="") {
			alert("���������� �����Ͻʽÿ�") ;
			eval(obj).Focus();
			return false;
	}
	
	return true;
}

function ln_Chk1(obj){
	
	if (eval(obj).text=="") {
		alert("�����׸��� �����Ͻʽÿ�") ;
		eval(obj).Focus();
		return false;
	}
	
	return true;
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
******************************************************************************/
function ln_SetDataHeader1(){

		if (gcds_print12.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,COCODE:STRING,FSREFVAL01:STRING,";
			s_temp+="FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,";
			s_temp+="BEVAL:DECIMAL,DEAMT:DECIAML,CRAMT:DECIAML,SLPVAL:DECIMAL,";
			s_temp+="FDCODENM:STRING,FDCODENM2:STRING,CURDT:STRING,CURDT2:STRING";
			gcds_print12.SetDataHeader(s_temp);
		}
	}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
******************************************************************************/
function ln_SetDataHeader2(){

		if (gcds_print22.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,COCODE:STRING,FSREFVAL01:STRING,";
			s_temp+="FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,";
			s_temp+="BEVAL:DECIMAL,DEAMT:DECIAML,CRAMT:DECIAML,SLPVAL:DECIMAL,";
			s_temp+="FDCODENM:STRING,FDCODENM2:STRING,CURDT:STRING,CURDT2:STRING";
			gcds_print22.SetDataHeader(s_temp);
		}
	}


/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
******************************************************************************/
function ln_SetDataHeader(){

		if (gcds_temp01.countrow<1){
			var s_temp = "GUBUN:STRING,FDCODE:STRING,ATCODE:STRING,ATKORNAM:STRING,FSREFVAL1:STRING,";
		    	s_temp+= "CDNAM1:STRING,FSREFVAL2:STRING,CDNAM2:STRING,FSREFVAL3:STRING,CDNAM3:STRING,";
					s_temp+= "ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,";
			    s_temp+= "BEVAL:DECIMAL,DEAMT:DECIAML,CRAMT:DECIAML,JANAMT:DECIMAL,FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,";
			    s_temp+= "SSDAT:STRING,SSNBR:STRING,SSDANBR:STRING,REMARK:STRING";
			gcds_temp01.SetDataHeader(s_temp);
		}
	}
/***********************************************************************************************
	Description : ����Ʈ �÷� �����ϱ�
	parameter   : 
**********************************************************************************************/
/*function ln_Sum1(){
	for(i=1;i<=gcds_print11.countrow;i++){
	gcds_print12.addrow();
	gcds_print12.namevalue(i,"FDCODE")=gcds_print11.namevalue(i,"FDCODE");
	gcds_print12.namevalue(i,"ATCODE")=gcds_print11.namevalue(i,"ATCODE");

	if (gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL01")) >= 1)gcds_print12.namevalue(i,"FSREFVAL01")=gcds_fsrefcd2.namevalue(gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL01")),"CDNAM");
	if (gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL02")) >= 1)gcds_print12.namevalue(i,"FSREFVAL02")=gcds_fsrefcd3.namevalue(gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL02")),"CDNAM");
	if (gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL03")) >= 1)gcds_print12.namevalue(i,"FSREFVAL03")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print11.namevalue(i,"FSREFVAL03")),"CDNAM");	
	gcds_print12.namevalue(i,"BEVAL")=gcds_print11.namevalue(i,"BEVAL");
	gcds_print12.namevalue(i,"DEAMT")=gcds_print11.namevalue(i,"DEAMT");
	gcds_print12.namevalue(i,"CRAMT")=gcds_print11.namevalue(i,"CRAMT");
	gcds_print12.namevalue(i,"SLPVAL")=gcds_print11.namevalue(i,"SLPVAL");

	//[�̼���:�ڵ��߰� START]---------------------------------------------------------------------
	gcds_print12.namevalue(1,"FDCODENM") = gclx_sfdcode.text;
	gcds_print12.namevalue(1,"FDCODENM2") = gcem_atkornam_fr01.text;
	gcds_print12.namevalue(1,"CURDT")		= gcem_staxdatfr.text + gcem_staxdatto.text;
	gcds_print12.namevalue(1,"CURDT2")		= gs_date;
	//[�̼���:�ڵ��߰� END]-----------------------------------------------------------------------
	}
}
*/
/***********************************************************************************************
	Description : ����Ʈ �÷� �����ϱ�
	parameter   : 
**********************************************************************************************/
function ln_Sum2(){
	for(i=1;i<=gcds_print21.countrow;i++){
	gcds_print22.addrow();
	gcds_print22.namevalue(i,"FDCODE")=gcds_print21.namevalue(i,"FDCODE");
	gcds_print22.namevalue(i,"ATCODE")=gcds_print21.namevalue(i,"ATCODE");

	if (gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL01")) >= 1)gcds_print22.namevalue(i,"FSREFVAL01")=gcds_fsrefcd2.namevalue(gcds_fsrefcd2.valuerow(gcds_fsrefcd2.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL01")),"CDNAM");
	if (gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL02")) >= 1)gcds_print22.namevalue(i,"FSREFVAL02")=gcds_fsrefcd3.namevalue(gcds_fsrefcd3.valuerow(gcds_fsrefcd3.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL02")),"CDNAM");
	if (gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL03")) >= 1)gcds_print22.namevalue(i,"FSREFVAL03")=gcds_fsrefcd4.namevalue(gcds_fsrefcd4.valuerow(gcds_fsrefcd4.columnindex("CDCODE"),gcds_print21.namevalue(i,"FSREFVAL03")),"CDNAM");	
	gcds_print22.namevalue(i,"BEVAL")=gcds_print21.namevalue(i,"BEVAL");
	gcds_print22.namevalue(i,"DEAMT")=gcds_print21.namevalue(i,"DEAMT");
	gcds_print22.namevalue(i,"CRAMT")=gcds_print21.namevalue(i,"CRAMT");
	gcds_print22.namevalue(i,"SLPVAL")=gcds_print21.namevalue(i,"SLPVAL");

	//[�̼���:�ڵ��߰� START]---------------------------------------------------------------------
	gcds_print22.namevalue(1,"FDCODENM") = gclx_sfdcode2.text;
	gcds_print22.namevalue(1,"FDCODENM2") = gcem_atkornam_fr012.text;
	gcds_print22.namevalue(1,"CURDT")		= gcem_staxdatfr2.text + gcem_staxdatto2.text;
	gcds_print22.namevalue(1,"CURDT2")		= gs_date;
	//[�̼���:�ڵ��߰� END]-----------------------------------------------------------------------
	}
}

/***********************************************************************************************
	Description : �����׸� �������� �˾� - [�Ѱ�]
	parameter   : fcod-�����ڵ�, atcod-�����ڵ�, frdt-�˻�����(from), todt-�˻�����(to)
	parameter   : refcd1-�����׸��ڵ�, refva1-�����׸�, arrParam[10] - �����׸񱸺�[����]
	�ڵ� ����   : �̼��� - 2006/03/30
**********************************************************************************************/
function ln_Popup5(fcod,atcod,frdt,todt,refcd1,refva1,refcd2,refva2,refcd3,refva3){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam[0] = fcod;			
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;
	arrParam[4] = refcd1;
	arrParam[5] = refva1;
	arrParam[6] = refcd2;
	arrParam[7] = refva2;
	arrParam[8] = refcd3;
	arrParam[9] = refva3;
	arrParam[10] = "B";
	if(refcd1!=''&&refcd2==''&&refcd3==''){
		arrParam[11] = '1';
	}else if(refcd1!='' && refcd2!=''&&refcd3=='') {
		arrParam[11] = '2';
	}else if(refcd1!='' && refcd2!='' && refcd3!='') {
		arrParam[11] = '3';
	}

	strURL = "./mtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:545px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : �����׸� �������� �˾� - [����]
	parameter   : fcod-�����ڵ�, atcod-�����ڵ�, frdt-�˻�����(from), todt-�˻�����(to)
	parameter   : refcd[1~3]-�����׸��ڵ�, refva[1~3]-�����׸�, arrParam[10] - �����׸񱸺�[����]
	�ڵ� ����   : �̼��� - 2006/03/30
**********************************************************************************************/
function ln_Popup6(fcod,atcod,frdt,todt,refcd1,refva1,refcd2,refva2,refcd3,refva3){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;			
	arrParam[1] = atcod;
	arrParam[2] = frdt;
	arrParam[3] = todt;
	arrParam[4] = refcd1;
	arrParam[5] = refva1;
	arrParam[6] = refcd2;
	arrParam[7] = refva2;
	arrParam[8] = refcd3;
	arrParam[9] = refva3;
	arrParam[10] = "B";
	if(refcd1!=''&&refcd2==''&&refcd3==''){
		arrParam[11] = '1';
	}else if(refcd1!='' && refcd2!=''&&refcd3=='') {
		arrParam[11] = '2';
	}else if(refcd1!='' && refcd2!='' && refcd3!='') {
		arrParam[11] = '3';
	}

	strURL = "./mtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:545px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   : gcds_disp01 -> gcds_temp01
	            : �����׸� 3
******************************************************************************/
function ln_Data_Reset3(){

	var dblbeval =0 ; //�����̿�
	var dbldeamt =0 ; //����
	var dblcramt =0 ; //�뺯
	var dbljanamt=0;  //�ܾ�

	var dblbeval_d =0 ; //�Ұ�1 �����̿�
	var dbldeamt_d =0 ; //�Ұ�1 ����
	var dblcramt_d =0 ; //�Ұ�1 �뺯
	var dbljanamt_d=0;  //�Ұ�1 �ܾ�

	var dblbeval_e =0 ; //�Ұ�2 �����̿�
	var dbldeamt_e =0 ; //�Ұ�2 ����
	var dblcramt_e =0 ; //�Ұ�2 �뺯
	var dbljanamt_e=0;  //�Ұ�2 �ܾ�

	var dblbeval_m =0 ; //�ŷ�ó�� �����̿�
	var dbldeamt_m =0 ; //�ŷ�ó�� ����
	var dblcramt_m =0 ; //�ŷ�ó�� �뺯
	var dbljanamt_m=0;  //�ŷ�ó�� �ܾ�

	var dblbeval_t =0 ; //��ü�� �����̿�
	var dbldeamt_t =0 ; //��ü�� ����
	var dblcramt_t =0 ; //��ü�� �뺯
	var dbljanamt_t=0;  //��ü�� �ܾ�

	gcgd_disp02.DataID="";

	//����Ÿ�� ����
	ln_SetDataHeader();

    for(i=1;i<=gcds_data2.countrow;i++){
		gcds_temp01.addrow();
		gcds_temp01.namevalue(gcds_temp01.rowposition,"GUBUN")=gcds_data2.namevalue(i,"GUBUN");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")=gcds_data2.namevalue(i,"FDCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE")=gcds_data2.namevalue(i,"ATCODE");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"ATKORNAM")=gcds_data2.namevalue(i,"ATKORNAM");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL1")=gcds_data2.namevalue(i,"FSREFVAL01");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1")=gcds_data2.namevalue(i,"CDNAM1");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL2")=gcds_data2.namevalue(i,"FSREFVAL02");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2")=gcds_data2.namevalue(i,"CDNAM2");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL3")=gcds_data2.namevalue(i,"FSREFVAL03");
        gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM3")=gcds_data2.namevalue(i,"CDNAM3");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")=gcds_data2.namevalue(i,"ACTDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"COCODE")=gcds_data2.namevalue(i,"COCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")=gcds_data2.namevalue(i,"FSDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")=gcds_data2.namevalue(i,"FSNBR");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSSEQ")=gcds_data2.namevalue(i,"FSSEQ");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"REMARK")=gcds_data2.namevalue(i,"REMARK");
																						

		if(gcds_data2.namevalue(i,"GUBUN")=="B"){       //�����̿� ��
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = "�����̿�";
		  if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"BEVAL");
				dbldeamt = gcds_data2.namevalue(i,"BEVAL");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"BEVAL");
				dblcramt = gcds_data2.namevalue(i,"BEVAL");
			}
			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = gcds_data2.namevalue(i,"BEVAL");
			//�ܾװ���� ����.
			dblbeval = dblbeval + gcds_data2.namevalue(i,"BEVAL");

        }else if(gcds_data2.namevalue(i,"GUBUN")=="C"){ //��������Ÿ

		    gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = gcds_data2.namevalue(i,"SSDANBR");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"DEAMT");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"CRAMT");
			//�Ұ赥��Ÿ ����
			dbldeamt_d=dbldeamt_d+gcds_data2.namevalue(i,"DEAMT");
			dblcramt_d=dblcramt_d+gcds_data2.namevalue(i,"CRAMT");

			//�ܾװ�� 
			if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				dblbeval=dblbeval + gcds_data2.namevalue(i,"DEAMT")- gcds_data2.namevalue(i,"CRAMT");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
                dblbeval=dblbeval - gcds_data2.namevalue(i,"DEAMT")+gcds_data2.namevalue(i,"CRAMT");
			}
			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = dblbeval;

		}else if(gcds_data2.namevalue(i,"GUBUN")=="D"){ //�Ұ� 1
		  //gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") =""
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM3") = "�Ұ�";
		    gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_d+dbldeamt; //2007.12.3 dbldeamt �߰�  
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_d+dblcramt; //2007.12.3 dblcramt �߰�  
			//gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_d; 
      
			//�Ұ�2����Ÿ ����
			dbldeamt_e = dbldeamt_e + dbldeamt_d+dbldeamt;
			dblcramt_e = dblcramt_e + dblcramt_d+dblcramt;
			dblbeval_e = dblbeval_e + dblbeval_d;

			//�ܾװ��
			if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT");
			}else if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT");
			}
			//ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
			
			dblbeval=0;
			dbldeamt=0;
			dblcramt=0;
            dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
        }else if(gcds_data2.namevalue(i,"GUBUN")=="E"){ //�Ұ� 2
		  //gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") =""
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "��";
            gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_e;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_e;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_e; 

            //�ŷ�ó�� ����Ÿ ����
		    dbldeamt_m = dbldeamt_m + dbldeamt_e;
			dblcramt_m = dblcramt_m + dblcramt_e;
			dblbeval_m = dblbeval_m + dblbeval_e; 

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
      
			dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
            dbldeamt_e=0; 
			dblcramt_e=0; 
			dblbeval_e=0; 

		}else if(gcds_data2.namevalue(i,"GUBUN")=="M"){ //�ŷ�ó ��
		 // gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") =""
		    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "�Ѱ�";
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "";
		    gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_m;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_m;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_m; 
			
			//��ü��
			dbldeamt_t = dbldeamt_t + dbldeamt_m ; 
	        dblcramt_t = dblcramt_t + dblcramt_m ;
			dblbeval_t = dblbeval_t + dblbeval_m; 

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
      
			dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
            dbldeamt_e=0; 
			dblcramt_e=0; 
			dblbeval_e=0; 
			dbldeamt_m =0;
			dblcramt_m =0;
			dblbeval_m =0; 

		}else if(gcds_data2.namevalue(i,"GUBUN")=="T"){ //��ü ��
		  //gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") ="��ü"
            gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "��ü��";
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "";
		    gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_t;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_t;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_t; 

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
			
            dbldeamt_t=0; 
			dblcramt_t=0; 
			dblbeval_t=0; 
		}else{
		
		}	
		//�ܾװ��
	}	

	gcgd_disp02.ColumnProp("CDNAM3", "Show") = "true";
	gcgd_disp02.ColumnProp("CDNAM2", "Show") = "true";

	gcgd_disp02.ColumnProp('CDNAM1','Name')=gclx_fsrefcd_1.text;
	gcgd_disp02.ColumnProp('CDNAM2','Name')=gclx_fsrefcd_2.text;
	gcgd_disp02.ColumnProp('CDNAM3','Name')=gclx_fsrefcd_3.text;
	
    gcgd_disp02.DataID = "gcds_temp01";
}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   : gcds_disp01 -> gcds_temp01
	            : �����׸� 2
******************************************************************************/
function ln_Data_Reset2(){

	var dblbeval =0 ; //�����̿�
	var dbldeamt =0 ; //����
	var dblcramt =0 ; //�뺯
	var dbljanamt=0;  //�ܾ�

	var dblbeval_d =0 ; //�Ұ�1 �����̿�
	var dbldeamt_d =0 ; //�Ұ�1 ����
	var dblcramt_d =0 ; //�Ұ�1 �뺯
	var dbljanamt_d=0;  //�Ұ�1 �ܾ�

	var dblbeval_e =0 ; //�Ұ�2 �����̿�
	var dbldeamt_e =0 ; //�Ұ�2 ����
	var dblcramt_e =0 ; //�Ұ�2 �뺯
	var dbljanamt_e=0;  //�Ұ�2 �ܾ�

	var dblbeval_m =0 ; //�ŷ�ó�� �����̿�
	var dbldeamt_m =0 ; //�ŷ�ó�� ����
	var dblcramt_m =0 ; //�ŷ�ó�� �뺯
	var dbljanamt_m=0;  //�ŷ�ó�� �ܾ�

	var dblbeval_t =0 ; //��ü�� �����̿�
	var dbldeamt_t =0 ; //��ü�� ����
	var dblcramt_t =0 ; //��ü�� �뺯
	var dbljanamt_t=0;  //��ü�� �ܾ�

	gcgd_disp02.DataID="";

	//����Ÿ�� ����
	ln_SetDataHeader();

  for(i=1;i<=gcds_data2.countrow;i++){
		gcds_temp01.addrow();
		gcds_temp01.namevalue(gcds_temp01.rowposition,"GUBUN")=gcds_data2.namevalue(i,"GUBUN");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")=gcds_data2.namevalue(i,"FDCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE")=gcds_data2.namevalue(i,"ATCODE");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"ATKORNAM")=gcds_data2.namevalue(i,"ATKORNAM");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL1")=gcds_data2.namevalue(i,"FSREFVAL01");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1")=gcds_data2.namevalue(i,"CDNAM1");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL2")=gcds_data2.namevalue(i,"FSREFVAL02");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2")=gcds_data2.namevalue(i,"CDNAM2");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL3")=gcds_data2.namevalue(i,"FSREFVAL03");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM3")=gcds_data2.namevalue(i,"CDNAM3");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")=gcds_data2.namevalue(i,"ACTDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"COCODE")=gcds_data2.namevalue(i,"COCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")=gcds_data2.namevalue(i,"FSDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")=gcds_data2.namevalue(i,"FSNBR");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSSEQ")=gcds_data2.namevalue(i,"FSSEQ");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"REMARK")=gcds_data2.namevalue(i,"REMARK");
																						
		if(gcds_data2.namevalue(i,"GUBUN")=="B"){       //�����̿� ��
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = "�����̿�";
			
			if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"BEVAL");
				dbldeamt = gcds_data2.namevalue(i,"BEVAL");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"BEVAL");
				dblcramt = gcds_data2.namevalue(i,"BEVAL");
			}
			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = gcds_data2.namevalue(i,"BEVAL");
			//�ܾװ���� ����.
			dblbeval = dblbeval + gcds_data2.namevalue(i,"BEVAL");

    }else if(gcds_data2.namevalue(i,"GUBUN")=="C"){ //��������Ÿ

		  gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = gcds_data2.namevalue(i,"SSDANBR");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"DEAMT");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"CRAMT");
			//�Ұ赥��Ÿ ����
			dbldeamt_d=dbldeamt_d+gcds_data2.namevalue(i,"DEAMT");
			dblcramt_d=dblcramt_d+gcds_data2.namevalue(i,"CRAMT");

			//�ܾװ�� 
			if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				dblbeval=dblbeval + gcds_data2.namevalue(i,"DEAMT")- gcds_data2.namevalue(i,"CRAMT");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
        dblbeval=dblbeval - gcds_data2.namevalue(i,"DEAMT")+gcds_data2.namevalue(i,"CRAMT");
			}
			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = dblbeval;

		}else if(gcds_data2.namevalue(i,"GUBUN")=="D"){ //�Ұ� 1
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "�Ұ�";
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_d+dbldeamt; //2007.12.3 dbldeamt �߰�  
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_d+dblcramt; //2007.12.3 dblcramt �߰�  
      
			//�Ұ�2����Ÿ ����
			dbldeamt_e = dbldeamt_e + dbldeamt_d + dbldeamt;
			dblcramt_e = dblcramt_e + dblcramt_d + dblcramt;
			//dblbeval_e = dblbeval_e + dblbeval_d;

			//�ܾװ��
			if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT");
			}else if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT");
			}
			//ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
			
			dblbeval=0;
			dbldeamt=0;
      dblcramt=0;
      dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
    }else if(gcds_data2.namevalue(i,"GUBUN")=="M"){ //�Ұ� 2
		  //gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") =""
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "��";
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "";
      gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_e;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_e;
			//gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_e; 

      //�ŷ�ó�� ����Ÿ ����
		  dbldeamt_m = dbldeamt_m + dbldeamt_e;
			dblcramt_m = dblcramt_m + dblcramt_e;
			dblbeval_m = dblbeval_m + dblbeval_e; 

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
      
			dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
      dbldeamt_e=0; 
			dblcramt_e=0; 
			dblbeval_e=0; 

		}else if(gcds_data2.namevalue(i,"GUBUN")=="T"){ //�ŷ�ó ��
		 // gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT") =""
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "�Ѱ�";
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2") = "";
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_m;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_m;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL") = dblbeval_m; 
			
			//��ü��
			dbldeamt_t = dbldeamt_t + dbldeamt_m; 
	    dblcramt_t = dblcramt_t + dblcramt_m;
			dblbeval_t = dblbeval_t + dblbeval_m; 

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
      
			dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
      dbldeamt_e=0; 
			dblcramt_e=0; 
			dblbeval_e=0; 
			dbldeamt_m =0;
			dblcramt_m =0;
			dblbeval_m =0; 
	    
		}else{
			
		}	
		//�ܾװ��
	}	
   
	gcgd_disp02.ColumnProp("CDNAM3", "Show") = "false";
	gcgd_disp02.ColumnProp("CDNAM2", "Show") = "true";

  gcgd_disp02.ColumnProp('CDNAM1','Name')=gclx_fsrefcd_1.text;
	gcgd_disp02.ColumnProp('CDNAM2','Name')=gclx_fsrefcd_2.text;
	
  gcgd_disp02.DataID = "gcds_temp01";
}


/******************************************************************************
	Description : ��ȸ�� ����Ÿ�� ������ �ٽ� ������.
	parameter   : gcds_disp01 -> gcds_temp01
	            : �����׸� 1
******************************************************************************/
function ln_Data_Reset1(){

	var dblbeval =0 ; //�����̿�
	var dbldeamt =0 ; //����
	var dblcramt =0 ; //�뺯
	var dbljanamt=0;  //�ܾ�

	var dblbeval_d =0 ; //�Ұ�1 �����̿�
	var dbldeamt_d =0 ; //�Ұ�1 ����
	var dblcramt_d =0 ; //�Ұ�1 �뺯
	var dbljanamt_d=0;  //�Ұ�1 �ܾ�

	var dblbeval_e =0 ; //�Ұ�2 �����̿�
	var dbldeamt_e =0 ; //�Ұ�2 ����
	var dblcramt_e =0 ; //�Ұ�2 �뺯
	var dbljanamt_e=0;  //�Ұ�2 �ܾ�

	var dblbeval_m =0 ; //�ŷ�ó�� �����̿�
	var dbldeamt_m =0 ; //�ŷ�ó�� ����
	var dblcramt_m =0 ; //�ŷ�ó�� �뺯
	var dbljanamt_m=0;  //�ŷ�ó�� �ܾ�

	var dblbeval_t =0 ; //��ü�� �����̿�
	var dbldeamt_t =0 ; //��ü�� ����
	var dblcramt_t =0 ; //��ü�� �뺯
	var dbljanamt_t=0;  //��ü�� �ܾ�

	gcgd_disp02.DataID="";

	//����Ÿ�� ����
	ln_SetDataHeader();

  for(i=1;i<=gcds_data2.countrow;i++){
		gcds_temp01.addrow();
		gcds_temp01.namevalue(gcds_temp01.rowposition,"GUBUN")=gcds_data2.namevalue(i,"GUBUN");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")=gcds_data2.namevalue(i,"FDCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ATCODE")=gcds_data2.namevalue(i,"ATCODE");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"ATKORNAM")=gcds_data2.namevalue(i,"ATKORNAM");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL1")=gcds_data2.namevalue(i,"FSREFVAL01");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1")=gcds_data2.namevalue(i,"CDNAM1");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL2")=gcds_data2.namevalue(i,"FSREFVAL02");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM2")=gcds_data2.namevalue(i,"CDNAM2");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL3")=gcds_data2.namevalue(i,"FSREFVAL03");
    gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM3")=gcds_data2.namevalue(i,"CDNAM3");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")=gcds_data2.namevalue(i,"ACTDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"COCODE")=gcds_data2.namevalue(i,"COCODE");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")=gcds_data2.namevalue(i,"FSDAT");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")=gcds_data2.namevalue(i,"FSNBR");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSSEQ")=gcds_data2.namevalue(i,"FSSEQ");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"REMARK")=gcds_data2.namevalue(i,"REMARK");
		gcds_temp01.namevalue(gcds_temp01.rowposition,"FSREFVAL1")=gcds_data2.namevalue(i,"FSREFVAL01");
			
		if(gcds_data2.namevalue(i,"GUBUN")=="B"){       //�����̿� ��(�����̿��ݾ��� ���뱸�п� ���� �����뺯�� �ִ´�)
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = "�����̿�";
      
			if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"BEVAL");
				dbldeamt = gcds_data2.namevalue(i,"BEVAL");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"BEVAL");
				dblcramt = gcds_data2.namevalue(i,"BEVAL");
			}

			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = gcds_data2.namevalue(i,"BEVAL");
			
			//�ܾװ���� ����.
			dblbeval = dblbeval + gcds_data2.namevalue(i,"BEVAL");
			
    }else if(gcds_data2.namevalue(i,"GUBUN")=="C"){ //��������Ÿ
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"SSDANBR") = gcds_data2.namevalue(i,"SSDANBR");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = gcds_data2.namevalue(i,"DEAMT");
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = gcds_data2.namevalue(i,"CRAMT");
			
			//�Ұ赥��Ÿ ����
			dbldeamt_d=dbldeamt_d+gcds_data2.namevalue(i,"DEAMT");
			dblcramt_d=dblcramt_d+gcds_data2.namevalue(i,"CRAMT");

			//�ܾװ�� 
			if(gcds_data2.namevalue(i,"ATDECR")=="1"){
				dblbeval=dblbeval+gcds_data2.namevalue(i,"DEAMT")-gcds_data2.namevalue(i,"CRAMT");
			}else if(gcds_data2.namevalue(i,"ATDECR")=="2"){
        dblbeval=dblbeval-gcds_data2.namevalue(i,"DEAMT")+gcds_data2.namevalue(i,"CRAMT");
			}
			gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT") = dblbeval;

		}else if(gcds_data2.namevalue(i,"GUBUN")=="D"){ //�Ұ� 1
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "�Ұ�";
		  gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_d+dbldeamt; //2007.12.3 dbldeamt �߰�  
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_d+dblcramt; //2007.12.3 dblcramt �߰�  
      
			//�Ұ�2����Ÿ ����
			dbldeamt_e = dbldeamt_e + dbldeamt_d + dbldeamt;
			dblcramt_e = dblcramt_e + dblcramt_d + dblcramt;
			////&&dblbeval_e = dblbeval_e + dblbeval_d;
			//�ܾװ��
			if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="1"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT");
			}else if(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR")=="2"){
				gcds_temp01.namevalue(gcds_temp01.rowposition,"JANAMT")=gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT")-gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT");
			}
			//ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
			
			dbldeamt=0;
			dblcramt=0;
			dblbeval=0;
      dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
    }else if(gcds_data2.namevalue(i,"GUBUN")=="T"){ //�Ұ� 2
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CDNAM1") = "��";
      gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT") = dbldeamt_e;
			gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT") = dblcramt_e;

      //�ŷ�ó�� ����Ÿ ����
		  dbldeamt_m = dbldeamt_m + dbldeamt_e;
			dblcramt_m = dblcramt_m + dblcramt_e;

			//�ܾװ��
			ln_Cal_Janamt(gcds_temp01.rowposition,gcds_data2.namevalue(i,"ATDECR"),gcds_temp01.namevalue(gcds_temp01.rowposition,"BEVAL"),gcds_temp01.namevalue(gcds_temp01.rowposition,"DEAMT"),gcds_temp01.namevalue(gcds_temp01.rowposition,"CRAMT"));
      
			dbldeamt_d=0;
			dblcramt_d=0;
			dblbeval_d=0; 
      dbldeamt_e=0; 
			dblcramt_e=0; 
			dblbeval_e=0; 
		}else{
			
		}	
	}	

	gcgd_disp02.ColumnProp("CDNAM3", "Show") = "false";
	gcgd_disp02.ColumnProp("CDNAM2", "Show") = "false";
	gcgd_disp02.ColumnProp('CDNAM1','Name')=gclx_fsrefcd_1.text;

  gcgd_disp02.DataID = "gcds_temp01";
}

/******************************************************************************
	Description : �ܾװ��
	parameter   : s_row,
	              s_atdecr,
								d_beval,
								d_deamt,
******************************************************************************/
function ln_Cal_Janamt(s_row, s_atdecr, d_beval, d_deamt, d_cramt){

		if(s_atdecr=="1"){
			gcds_temp01.namevalue(s_row,"JANAMT")=d_beval+d_deamt-d_cramt; 																										
		}else if(s_atdecr=="2"){
			gcds_temp01.namevalue(s_row,"JANAMT")=d_beval-d_deamt+d_cramt; 																												 
		}

}

/***********************************************************************************************
	Description : ��ǥ ã��
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_Slipno_Popup(fcod,fsdt,fnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod;
	arrParam[1] = fsdt;
	arrParam[2] = fnbr;

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:580px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030022_t1(I:USER=gcds_data1)"> 
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--�޺�-->

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--����Ʈ-->

<comment id="__NSID__"><object  id=gcds_print02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--����Ʈ-->


<comment id="__NSID__"><object  id=gcds_print11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--����Ʈ-->

<comment id="__NSID__"><object  id=gcds_print12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print21 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print22 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �ŷ�ó�ڵ�-->
<comment id="__NSID__"><object  id="gcds_scccode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ� -->
<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����׸� -->
<!--
<comment id="__NSID__"><object  id="gcds_fsrefcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
-->
<comment id="__NSID__"><object  id="gcds_fsrefcd_1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--�޺�-->

<comment id="__NSID__"><object  id="gcds_fsrefcd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--���-->

<comment id="__NSID__"><object  id="gcds_fsrefcd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_fsrefcd4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_temp01" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
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
  
	//gcgd_disp01.ColumnProp("FSREFVAL01", "SubsumExpr");
	if (row <1) {
	alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	  if(gclx_fsrefcd.BindColVal!=""&&gclx_fsrefcd2.BindColVal!=""&&gclx_fsrefcd3.BindColVal!=""){
			gcgd_disp01.ColumnProp("FSREFNM03", "Show") = "true";
			gcgd_disp01.ColumnProp("FSREFNM02", "Show") = "true";

			gcgd_disp01.ColumnProp('FSREFNM01','Name')=gclx_fsrefcd.text;
			gcgd_disp01.ColumnProp('FSREFNM02','Name')=gclx_fsrefcd2.text;
			gcgd_disp01.ColumnProp('FSREFNM03','Name')=gclx_fsrefcd3.text;
		}else if(gclx_fsrefcd.BindColVal!=""&&gclx_fsrefcd2.BindColVal!=""&&gclx_fsrefcd3.BindColVal==""){
			gcgd_disp01.ColumnProp("FSREFNM03", "Show") = "true";
			gcgd_disp01.ColumnProp("FSREFNM02", "Show") = "true";

			gcgd_disp01.ColumnProp('FSREFNM01','Name')=gclx_fsrefcd.text;
			gcgd_disp01.ColumnProp('FSREFNM02','Name')=gclx_fsrefcd2.text;
		}else if(gclx_fsrefcd.BindColVal!=""&&gclx_fsrefcd2.BindColVal==""&&gclx_fsrefcd3.BindColVal==""){
      gcgd_disp01.ColumnProp("FSREFNM03", "Show") = "true";
      gcgd_disp01.ColumnProp("FSREFNM02", "Show") = "true";
      gcgd_disp01.ColumnProp('FSREFNM01','Name')=gclx_fsrefcd.text;
		}
  }
</script>
<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{ 
	  if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal!=""){
			ln_Data_Reset3();
		}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal!=""&&gclx_fsrefcd_3.BindColVal==""){
      ln_Data_Reset2();
		}else if(gclx_fsrefcd_1.BindColVal!=""&&gclx_fsrefcd_2.BindColVal==""&&gclx_fsrefcd_3.BindColVal==""){
      ln_Data_Reset1();
		}
	}
</script>

<!-- �����ڵ� -->
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


<!-- �����׸� -->
<script language="javascript" for="gcds_temp" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gclx_fsrefcd.ComboDataID="";
	gcds_temp.InsertRow(1);
	gcds_temp.NameValue(1,"CDCODE")="";
	gcds_temp.NameValue(1,"CDNAM")="";
	gcds_temp.index=0;
	gclx_fsrefcd.ComboDataID="gcds_temp";
</script>

<script language="javascript" for="gcds_temp2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden"; 

	gclx_fsrefcd2.ComboDataID="";
	gclx_fsrefcd_2.ComboDataID="";
	gcds_temp2.InsertRow(1);
	gcds_temp2.NameValue(1,"CDCODE")="";
	gcds_temp2.NameValue(1,"CDNAM")="";
	gcds_temp2.index=0;
	gclx_fsrefcd2.ComboDataID="gcds_temp2";
	gclx_fsrefcd_2.ComboDataID="gcds_temp2";
	
</script>

<script language="javascript" for="gcds_temp3" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";
	gclx_fsrefcd3.ComboDataID="";
	gclx_fsrefcd_3.ComboDataID="";
	gcds_temp3.InsertRow(1);
	gcds_temp3.NameValue(1,"CDCODE")="";
	gcds_temp3.NameValue(1,"CDNAM")="";
	gcds_temp3.index=0;
	gclx_fsrefcd3.ComboDataID="gcds_temp3";
	gclx_fsrefcd_3.ComboDataID="gcds_temp3";
</script>

<script language="javascript" for="gcds_temp4" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";
	gcds_temp4.index=0;
	gclx_fsrefcd_1.ComboDataID="gcds_temp4";
</script>

<!-- �����׸� -->
<!--
<script language="javascript" for="gcds_fsrefcd_1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";      //���������� �ε��Ǵ°��� hidden����
	gcds_fsrefcd_1.InsertRow(1);
	gcds_fsrefcd_1.NameValue(1,"CDCODE")="";
	gcds_fsrefcd_1.NameValue(1,"CDNAM")="��ü";
	gcds_fsrefcd_1.index=0;
</script>
-->

<script language="javascript" for="gcds_print11" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print11 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_print12.ClearData();
	ln_SetDataHeader1();
	ln_Sum1();
	gcrp_print1.preview(); 
</script>

<script language="javascript" for="gcds_print21" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print21 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	gcds_print22.ClearData();
	ln_SetDataHeader2();
	ln_Sum2();
	gcrp_print2.preview(); 
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

	var p_fcod = gclx_sfdcode.BindColVal;
	var p_acod = gcem_atcode_fr01.text;  		
	var p_frdt = gcem_staxdatfr.text;
	var p_todt = gcem_staxdatto.text;

	ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	/***�ڵ���� : �̼��� **********************************************/
	var fcod	 = gclx_sfdcode.bindcolval;									//�����ڵ�
	var atcod	 = gcds_data1.namevalue(row,"ATCODE");			//�����ڵ�
	var frdt	 = gcem_staxdatfr.text;											//�˻����� fr
	var todt	 = gcem_staxdatto.text;											//�˻����� to
	var refcd1 = gclx_fsrefcd.bindcolval;									//�����׸�1 �ڵ�
	var refva1 = gcds_data1.namevalue(row,"FSREFVAL01");	//�����׸�1 ��
	var refcd2 = gclx_fsrefcd2.bindcolval;								//�����׸�2 �ڵ�
	var refva2 = gcds_data1.namevalue(row,"FSREFVAL02");	//�����׸�2 ��
	var refcd3 = gclx_fsrefcd3.bindcolval;								//�����׸�3 �ڵ�
	var refva3 = gcds_data1.namevalue(row,"FSREFVAL03");	//�����׸�3 ��
	ln_Popup5(fcod,atcod,frdt,todt,refcd1,refva1,refcd2,refva2,refcd3,refva3);	//�����׸� �˾�[�Ѱ�]
	/***�ڵ���� : �̼��� **********************************************/
</script>

<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	/***�ڵ���� : �̼��� **********************************************/
	var fcod	 = gclx_sfdcode2.bindcolval;								//�����ڵ�
	var atcod	 = gcds_data2.namevalue(row,"ATCODE");			//�����ڵ�
	var frdt	 = gcem_staxdatfr2.text;										//�˻����� fr
	var todt	 = gcem_staxdatto2.text;										//�˻����� to
	var refcd1 = gclx_fsrefcd_1.bindcolval;								//�����׸�1 �ڵ�
	var refva1 = gcds_data2.namevalue(row,"FSREFVAL01");	//�����׸�1 ��
	var refcd2 = gclx_fsrefcd_2.bindcolval;								//�����׸�2 �ڵ�
	var refva2 = gcds_data2.namevalue(row,"FSREFVAL02");	//�����׸�2 ��
	var refcd3 = gclx_fsrefcd_3.bindcolval;								//�����׸�3 �ڵ�
	var refva3 = gcds_data2.namevalue(row,"FSREFVAL03");	//�����׸�3 ��

  ///2007.05.17. ������ ����.==> �˾��� �������忡�� ��ǥ��ȸ�� ������. 
	///ln_Popup6(fcod,atcod,frdt,todt,refcd1,refva1,refcd2,refva2,refcd3,refva3);	//�����׸� �˾�[����]

	ln_Slipno_Popup(gcds_data2.namevalue(row,"FDCODE"),gcds_data2.namevalue(row,"FSDAT"),gcds_data2.namevalue(row,"FSNBR"));

	/***�ڵ���� : �̼��� **********************************************/
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S    �Ѱ�
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_fsrefcd event=OnSelChange()>
	gcgd_disp01.ColumnProp('FSREFVAL01','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL01','Data')="gcds_fsrefcd2:CDCODE:CDNAM";
	gcds_fsrefcd2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd.bindcolval;
	gcds_fsrefcd2.Reset();
</script>

<!--///////////////////////////////////////////////////////////////////////////////-->
<script language=JavaScript for=gclx_fsrefcd2 event=OnSelChange()>
	gcgd_disp01.ColumnProp('FSREFVAL02','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL02','Data')="gcds_fsrefcd3:CDCODE:CDNAM";
	gcds_fsrefcd3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd2.bindcolval;
	gcds_fsrefcd3.Reset();
</script>
<!--///////////////////////////////////////////////////////////////////////////////-->
<script language=JavaScript for=gclx_fsrefcd3 event=OnSelChange()>
	gcgd_disp01.ColumnProp('FSREFVAL03','EditStyle')="Lookup";
	gcgd_disp01.ColumnProp('FSREFVAL03','Data')="gcds_fsrefcd4:CDCODE:CDNAM";
	gcds_fsrefcd4.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd3.bindcolval;
	gcds_fsrefcd4.Reset();
</script>

<script language="javascript" for="gcds_fsrefcd2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_fsrefcd2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_fsrefcd3" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_fsrefcd3" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_fsrefcd4" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_fsrefcd4" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S   ����
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gclx_fsrefcd_1 event=OnSelChange()>
  

	gcgd_disp02.ColumnProp('FSREFVAL01','EditStyle')="Lookup";
	gcgd_disp02.ColumnProp('FSREFVAL01','Data')="gcds_fsrefcd2:CDCODE:CDNAM";
	gcds_fsrefcd2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd_1.bindcolval;
	gcds_fsrefcd2.Reset();
  gcem_vend_fr.text="";
	txt_vend_fr.text="";
  gcem_vend_to.text="";
	txt_vend_to.text="";

</script>
<!--///////////////////////////////////////////////////////////////////////////////-->
<script language=JavaScript for=gclx_fsrefcd_2 event=OnSelChange()>
	gcgd_disp02.ColumnProp('FSREFVAL02','EditStyle')="Lookup";
	gcgd_disp02.ColumnProp('FSREFVAL02','Data')="gcds_fsrefcd3:CDCODE:CDNAM";
	gcds_fsrefcd3.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd_2.bindcolval;
	gcds_fsrefcd3.Reset();
</script>
<!--///////////////////////////////////////////////////////////////////////////////-->
<script language=JavaScript for=gclx_fsrefcd_3 event=OnSelChange()>

	gcgd_disp02.ColumnProp('FSREFVAL03','EditStyle')="Lookup";
	gcgd_disp02.ColumnProp('FSREFVAL03','Data')="gcds_fsrefcd4:CDCODE:CDNAM";
	gcds_fsrefcd4.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd_3.bindcolval;
	gcds_fsrefcd4.Reset();


</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- �ܾ� -->
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	//ln_DispChk((index-1));
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
<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030012_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
						  <PARAM NAME="BackColor"					VALUE="#cccccc">
   					      <PARAM NAME="titleHeight"		VALUE="20px">
						  <PARAM NAME="DisableBackColor"	 VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
							   	<T>divid=div_1		title=�Ѱ�</T>									
							    <T>divid=div_2		title=����</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>
<!-- �Ѱ�===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:158px;left:18px;height:465px;width:878px;bacground-color:#708090"></fieldset>
<div id="div_1" style="position:absolute;;top:160px;left:168px;height:485px;width:870px;" >
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;">
			<tr>
<!---------------------------------�Ѱ�---�����ڵ�--------------------------------------------------------->
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;font-size:12px;width:130px;">
								<param name=ComboDataID			value="gcds_sfdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value=FDNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	    value="FDNAME^0^140">
								<param name=BindColumn			value=FDCODE>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">��������</td>
				<td class="tab22" width="199px"><nobr>
                   <comment id="__NSID__"><object  id=gcem_atkornam_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:2px;" onkeydown="ln_Onblur('01','fr','gcem_atkornam_fr01')";">
			            <param name=Text		  value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Popup('fr','01');">
					<comment id="__NSID__"><object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:2px;">
			            <param name=Text		  value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					</nobr>
				</td>			
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('01')">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('01')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
				</td>
			</tr>
<!----------------------------------�Ѱ�---�Ⱓ------------------------------------------------->
			<tr>
	            <td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" width="200px"> <nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~					
					<comment id="__NSID__">
					  <object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F   style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					  </object>
					 </comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>        

				</td>
				<td class="tab22" width="0px">&nbsp;</td>
				<td class="tab22" align=right colspan="6">&nbsp;</td>
			</tr>
<!------------------------------�Ѱ�----�����׸�---------------------------------------------------->			
			<tr> 				
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�����׸�1</td>	
				<td class="tab12" style="height:30px;width:150px;" >
					<nobr>
						<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:150px;">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^200">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
				</td>

				<td class="tab12" width="80px" bgcolor="#eeeeee">�����׸�2</td>
				<td  class="tab12" style="height:30px;width:150px;" ><nobr>
						<comment id="__NSID__"><object  id=gclx_fsrefcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:150px;">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort            value="false">
							<param name=ListExprFormat	value="CDNAM^0^200">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
				</td>
      
				<td class="tab12" width="80px" bgcolor="#eeeeee">�����׸�3</td>
				<td  style="height:30px;width:150px;border-top-width:0px;border-left-width:0px;"><nobr>
						<comment id="__NSID__"><object  id=gclx_fsrefcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:150px;">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort            value="false">
							<param name=ListExprFormat	value="CDNAM^0^200">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
				</td>
				
<!--------------------------------------------------------------------------------------------------------------->
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-155px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px;height:340px; border:1 solid #708090;" viewastext>
						<PARAM NAME="DataID"			      VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		      VALUE="0">
						<PARAM NAME="BorderStyle"       VALUE="0">
						<PARAM NAME="Fillarea"		      VALUE="true">
						<Param Name="Editable"          value="false"> 
			            <PARAM NAME="viewSummary"       VALUE="1">						
					    <PARAM NAME="ColSizing"		      VALUE="true">
					    <PARAM NAME="SortView"		      VALUE="left">
						<PARAM NAME="Format"			      VALUE="
							<C> Name='�����׸�1'  ID=FSREFVAL01   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=80	align=center show=false</C>
							<C> Name='�����׸�1'  ID=FSREFNM01   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=110	align=left show=true</C>
							<C> Name='�����׸�2'  ID=FSREFVAL02	 SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=80	align=center show=false</C> 
							<C> Name='�����׸�2'  ID=FSREFNM02	 SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=110	align=left show=true</C> 
							<C> Name='�����׸�3'  ID=FSREFVAL03   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=80	align=center show=false SumText=�հ�</C> 
							<C> Name='�����׸�3'  ID=FSREFNM03   SumBgColor=#C3D0DB  HeadBgColor=#B9D4DC bgcolor=#ffffff	width=110	align=left show=true SumText=�հ�</C> 
								<C> Name='�����̿�'	  ID=BEVAL		SumText=@sum SumBgColor=#C3D0DB  HeadAlign=Center		HeadBgColor=#B9D4DC Width=125	align=right sumtext=@sum</C>
							<C> Name='����'				ID=DEAMT		SumText=@sum				SumBgColor=#C3D0DB  HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right</C> 
							<C> Name='�뺯'				ID=CRAMT		SumText=@sum				SumBgColor=#C3D0DB  HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right</C> 
							<C> Name='�ܾ�'				ID=SLPVAL		SumText=@sum				SumBgColor=#C3D0DB  HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=right</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table>
		</td> 
	</tr> 
</table> 
</div>
<!-- ���� ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:158px;left:18px;height:465px;width:878px;bacground-color:#708090"></fieldset>
<div id="div_2" style="position:absolute;;top:160px;left:168px;height:485px;width:870px;" >
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" >
<tr>
  <td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;font-size:12px;width:130px;">
								<param name=ComboDataID			value="gcds_sfdcode">
								<param name=CBDataColumns		value="FDCODE, FDNAME">
								<param name=SearchColumn		value=FDNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="FDNAME^0^140">
								<param name=BindColumn			value=FDCODE>
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">��������</td>
				<td class="tab22" width="199px"><nobr>
					
					<comment id="__NSID__"><object  id=gcem_atkornam_fr012 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:5px;top:2px;" onkeydown="ln_Onblur('02','fr','gcem_atkornam_fr012')";">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=GeneralEdit   value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:5px;top:0px" align=center onclick="ln_Popup('fr','02');">
					<comment id="__NSID__"><object  id=gcem_atcode_fr012 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:2px;">
			      <param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					
					</nobr>
				</td>			
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print02()">
					<img src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('02')">
				</td>
			</tr>
<!-------------------------------------����---�Ⱓ------------------------------------------------->
			<tr>
	           <td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" width="200px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~					
					<comment id="__NSID__"><object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>        
				</td>
				<td class="tab22" width="0px">&nbsp;</td>
				<td class="tab22" align=right colspan="6">&nbsp;</td>
			</tr>
<!---------------------------����-------�����׸�1----����------------------------------------------------>			
			<tr> 				
				<td class="tab20" style="height:30px;width:80px;" bgcolor="#eeeeee">&nbsp;&nbsp;&nbsp;�����׸�1</td>	
				<td class="tab20" style="height:30px;border-right-width:0px;" colspan=7>
				        <comment id="__NSID__">
				         <object  id=gclx_fsrefcd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69	 style="position:relative;left:5px;top:4px;font-size:12px;width:130px;">
								<param name=CBDataColumns		value="CDCODE, CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	   value="CDNAM^0^140">
								<param name=BindColumn			value=CDCODE>
						</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;

					     <comment id="__NSID__">
					       <object  id=gcem_vend_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:74px;height:20px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					   	    <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�˻��մϴ�" style="cursor:hand;position:relative;left:6px;top:3px" align=center onclick="Popup('fr');">
							<input id="txt_vend_fr" type="text" class="txtbox"  style= "position:relative;left:4px;top:-2px;width:150px; height:20px;" maxlength="36" disabled> &nbsp; ~ &nbsp;
							<comment id="__NSID__">
							<object  id=gcem_vend_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:74px;height:20px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="#############">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						    <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�˻��մϴ�" style="cursor:hand;position:relative;left:6px;top:3px" align=center onclick="Popup('to');">
							<input id="txt_vend_to" type="text" class="txtbox"  style= "position:relative;left:4px;top:-2px;width:150px; height:20px;" maxlength="36"  disabled>
							&nbsp;&nbsp;
						    <font color="blue" style="position:relative;top:-1px;left:0px"><strong>��ü</strong></font>&nbsp;
                            <input type=checkbox  id=chkbox_fsrefcd_1  style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC";>&nbsp;&nbsp;
						
				</td>
			</tr>
<!------------------------------����----�����׸�2/3-----�Ʒ�----------------------------------------------->			
			<tr> 				
				<td class="tab12" style="height:30px;width:80px;" bgcolor="#eeeeee">�����׸�2</td>	
				<td class="tab12" style="height:30px;width:130px;" colspan=1>
						<comment id="__NSID__"><object  id=gclx_fsrefcd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:4px;top:0px;font-size:12px;width:130px;">
								<!-- <param name=ComboDataID			value="gcds_temp2"> -->
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value=CDNAM>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="CDNAM^0^200">
								<param name=BindColumn			value=CDCODE>
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
        
				<td class="tab12" width="80px" bgcolor="#eeeeee">�����׸�3</td>
				<td class="tab12" style="height:30px;width:px;border-right-width:0px;"colspan=5>
				      
						<comment id="__NSID__"><object  id=gclx_fsrefcd_3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:-140px;top:0px;font-size:12px;width:150px;">
							<!-- <param name=ComboDataID			value="gcds_temp3"> -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort            value="false">
							<param name=ListExprFormat	value="CDNAM^0^200">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
				</td>
<!--------------------------------------------------------------------------------------------------------------->
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-155px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
          <comment id="__NSID__"><object  id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:8px;width:864px; height:309px; border:1 solid #708090;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_temp01">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ColSizing"		VALUE="true">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�����׸�1'	ID=FSREFVAL1  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false  show=false </C> 
								<C> Name='�����׸�1'	ID=CDNAM1 HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left sort=false  suppress=3</C> 
								<C> Name='�����׸�2'	ID=FSREFVAL2 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false  suppress=5 show=false</C> 			
								<C> Name='�����׸�2'	ID=CDNAM2 HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left sort=false  suppress=2</C> 
								<C> Name='�����׸�3'	ID=FSREFVAL3 HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center sort=false  suppress=4 show=false</C> 					
								<C> Name='�����׸�3'	ID=CDNAM3 HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left sort=false  suppress=1</C> 
								<C> Name='��ǥ��ȣ '	ID=SSDANBR HeadAlign=Center HeadBgColor=#B9D4DC Width=105 align=left sort=false</C> 
								<C> Name='�̿�'	ID=BEVAL HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right sort=false  show=false</C> 
								<C> Name='����'	ID=DEAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right sort=false</C> 
								<C> Name='�뺯'	ID=CRAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right sort=false</C> 
								<C> Name='�ܾ�'	ID=JANAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right sort=false</C> 
							  <C> Name='���� '	    ID=REMARK HeadAlign=Center HeadBgColor=#B9D4DC Width=340 align=left sort=false</C> 
							">
					</object></comment><script>__ws__(__NSID__);</script>  
					
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
					</fieldset>
					</td>
				</tr>
			</table> 
		</td> 
	</tr>  
</table>
</div>

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print12">
	<param name="DetailDataID"			    value="gcds_print12">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=373 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=111 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=860, top=119, right=2003, bottom=167 ,mask='(  �Ⱓ : XXXX�� XX�� XX��  ~  XXXX�� XX�� XX��  )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� �� �� �� �� �� ��' ,left=1021 ,top=26 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=222 ,top=373 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=220 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�� ��' ,left=2447 ,top=291 ,right=2802 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=2077 ,top=291 ,right=2434 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1709 ,top=291 ,right=2064 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1336 ,top=283 ,right=1336 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=283 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2439 ,top=283 ,right=2439 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2072 ,top=283 ,right=2072 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1704 ,top=283 ,right=1704 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=220 ,top=283 ,right=220 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�����׸�3' ,left=971 ,top=291 ,right=1320 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=955 ,top=283 ,right=955 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=180, right=2805, bottom=228, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����׸�1' ,left=241 ,top=291 ,right=561 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�����̿�' ,left=1339 ,top=291 ,right=1699 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=585 ,top=283 ,right=585 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�����׸�2' ,left=606 ,top=291 ,right=934 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2805 ,bottom=275 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ� :' ,left=230 ,top=180 ,right=431 ,bottom=228 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=447, top=180, right=1294, bottom=228, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�������� :' ,left=230 ,top=228 ,right=431 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM2', left=447, top=228, right=1294, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=51 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=220 ,bottom=50 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<C>id='SLPVAL', left=2447, top=0, right=2802, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2439 ,top=0 ,right=2439 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<C>id='CRAMT', left=2077, top=0, right=2434, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=1709, top=0, right=2064, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=50 </L>
	<L> left=585 ,top=0 ,right=585 ,bottom=50 </L>
	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='BEVAL', left=1339, top=0, right=1699, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=955 ,top=0 ,right=955 ,bottom=50 </L>
	<C>id='FSREFNM03', left=963, top=0, right=1331, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSREFNM02', left=590, top=0, right=950, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSREFNM01', left=225, top=0, right=579, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=LDFooter ,left=0,top=0 ,right=2871 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=220 ,top=0 ,right=220 ,bottom=50 </L>
	<L> left=1336 ,top=0 ,right=1336 ,bottom=50 </L>
	<L> left=220 ,top=50 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=955 ,top=0 ,right=955 ,bottom=50 </L>
	<L> left=585 ,top=0 ,right=585 ,bottom=50 </L>
	<L> left=2072 ,top=0 ,right=2072 ,bottom=50 </L>
	<L> left=1704 ,top=0 ,right=1704 ,bottom=50 </L>
	<S>id='{Sum(DEAMT)}' ,left=1709 ,top=8 ,right=2064 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<T>id='��  ��' ,left=963 ,top=8 ,right=1331 ,bottom=48 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(BEVAL)}' ,left=1339 ,top=8 ,right=1699 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<L> left=2439 ,top=0 ,right=2439 ,bottom=50 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 </L>
	<S>id='{Sum(CRAMT)}' ,left=2077 ,top=8 ,right=2434 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
	<S>id='{Sum(SLPVAL)}' ,left=2447 ,top=8 ,right=2802 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=220 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcrp_print2" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print02">
	<param name="DetailDataID"			    value="gcds_temp01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"       value="2:FSREFVAL1;1:CDNAM1">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=383 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�����׸� ����' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=66 ,top=373 ,right=2810 ,bottom=373 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=64 ,top=283 ,right=2810 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1979 ,top=291 ,right=2365 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1233 ,top=291 ,right=1590 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=865 ,top=291 ,right=1222 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ŷ�ó�ڵ�' ,left=85 ,top=291 ,right=310 ,bottom=365 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ǥ��ȣ' ,left=590 ,top=291 ,right=852 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='Page : #p of #t' ,left=2228 ,top=228 ,right=2651 ,bottom=275 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� :' ,left=736 ,top=228 ,right=931 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ATKORNAM', left=1180, top=228, right=2029, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATCODE', left=942, top=228, right=1164, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='( ȸ������ :' ,left=953 ,top=116 ,right=1196 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1606 ,top=291 ,right=1963 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id=')' ,left=1820 ,top=116 ,right=1865 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=1201, top=116, right=1815, bottom=161 ,mask='XXXX/XX/XX      ~     XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڵ� :' ,left=56 ,top=228 ,right=257 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=273, top=228, right=643, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=42 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{DECODE(FSREFVAL1,9999,,FSREFVAL1)}', left=85, top=0, right=225, bottom=42, align='left', supplevel=2, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CDNAM1', left=230, top=0, right=590, bottom=42, align='left', supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSDANBR', left=587, top=0, right=926, bottom=42, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=897, top=0, right=1222, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1233, top=0, right=1590, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=1603, top=0, right=1958, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1979, top=0, right=2802, bottom=42, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1858 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2278 ,top=3 ,right=2656 ,bottom=85</I>
	<L> left=64 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT', left=85, top=21, right=505, bottom=69, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id="gcrp_print3" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print02">
	<param name="DetailDataID"			    value="gcds_temp01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"       value="3:FSREFVAL2;2:CDNAM1;1:CDNAM2">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=444 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1000 ,top=34 ,right=1842 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=995 ,top=21 ,right=1826 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�����׸� ����' ,left=997 ,top=24 ,right=1823 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=40 ,top=283 ,right=2789 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1953 ,top=291 ,right=2344 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1212 ,top=291 ,right=1569 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=844 ,top=291 ,right=1201 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='Page : #p of #t' ,left=2207 ,top=228 ,right=2625 ,bottom=275 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� :' ,left=736 ,top=228 ,right=931 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ATKORNAM', left=1180, top=228, right=2029, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATCODE', left=942, top=228, right=1164, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='( ȸ������ :' ,left=953 ,top=116 ,right=1196 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1585 ,top=291 ,right=1942 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id=')' ,left=1820 ,top=116 ,right=1865 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=1201, top=116, right=1815, bottom=161 ,mask='XXXX/XX/XX      ~     XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=426 ,right=2789 ,bottom=426 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ��ȣ' ,left=569 ,top=360 ,right=831 ,bottom=413 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ŷ�ó�ڵ�' ,left=64 ,top=360 ,right=288 ,bottom=413 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=508, top=291, right=831, bottom=336, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڵ� :' ,left=56 ,top=228 ,right=257 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=273, top=228, right=643, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=42 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CDNAM2', left=415, top=0, right=595, bottom=42, align='left', supplevel=1, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(FSREFVAL2,9999A,,8888,,FSREFVAL2)}', left=56, top=0, right=185, bottom=42, align='left', supplevel=3, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CDNAM1', left=180, top=0, right=415, bottom=42, align='left', supplevel=2, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSDANBR', left=601, top=0, right=900, bottom=42, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=897, top=0, right=1201, bottom=42, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1212, top=0, right=1569, bottom=42, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=1577, top=0, right=1937, bottom=42, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1953, top=0, right=2778, bottom=42, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2257 ,top=3 ,right=2635 ,bottom=85</I>
	<L> left=40 ,top=0 ,right=2791 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT', left=64, top=21, right=482, bottom=69, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcrp_print4" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_print02">
	<param name="DetailDataID"			    value="gcds_temp01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="PaperSize"							VALUE="A4">	
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"       value="4:FSREFVAL3;3:CDNAM1;2:CDNAM2;1:CDNAM3">
	<PARAM NAME="Format"                VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=444 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1000 ,top=34 ,right=1842 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=995 ,top=21 ,right=1826 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�����׸� ����' ,left=997 ,top=24 ,right=1823 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=40 ,top=283 ,right=2789 ,bottom=283 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1953 ,top=291 ,right=2344 ,bottom=365 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=1212 ,top=291 ,right=1569 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� ��' ,left=844 ,top=291 ,right=1201 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='Page : #p of #t' ,left=2207 ,top=228 ,right=2625 ,bottom=275 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� :' ,left=736 ,top=228 ,right=931 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ATKORNAM', left=1180, top=228, right=2029, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATCODE', left=942, top=228, right=1164, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='( ȸ������ :' ,left=953 ,top=116 ,right=1196 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��' ,left=1585 ,top=291 ,right=1942 ,bottom=365 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id=')' ,left=1820 ,top=116 ,right=1865 ,bottom=161 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CUDATE', left=1201, top=116, right=1815, bottom=161 ,mask='XXXX/XX/XX      ~     XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=426 ,right=2789 ,bottom=426 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��ǥ��ȣ' ,left=569 ,top=360 ,right=831 ,bottom=413 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ŷ�ó�ڵ�' ,left=64 ,top=360 ,right=288 ,bottom=413 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='ATKORNAM', left=508, top=291, right=831, bottom=336, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڵ� :' ,left=56 ,top=228 ,right=257 ,bottom=275 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=273, top=228, right=643, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=39 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='CDNAM3', left=601, top=0, right=778, bottom=40, align='left', supplevel=1, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CDNAM2', left=415, top=0, right=595, bottom=40, align='left', supplevel=2, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DECODE(FSREFVAL3,9999A,,8888,,7777,,FSREFVAL3)}', left=56, top=0, right=185, bottom=40, align='left', supplevel=4, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CDNAM1', left=180, top=0, right=415, bottom=40, align='left', supplevel=3, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SSDANBR', left=725, top=0, right=1024, bottom=40, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=1035, top=0, right=1339, bottom=40, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1344, top=0, right=1701, bottom=40, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=1707, top=0, right=2064, bottom=40, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=2069, top=0, right=2778, bottom=40, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2257 ,top=3 ,right=2635 ,bottom=85</I>
	<L> left=40 ,top=0 ,right=2791 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT', left=64, top=21, right=482, bottom=69, align='left' ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 