<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - �Ѱ�������(�Ϻ�)	
+ ���α׷� ID	:  A030011.html
+ �� �� �� ��	:  �Ѱ��� ��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a030011_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ѱ�������</title>

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
var gs_date3 = gcurdate.substring(0,4);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	//ln_DispChk(0);
	ln_Before();
	ln_SetDataHeader();
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1 = gclx_sfdcode1.BindColVal;	
		var str2 = gcem_staxdatfr.text;			
		var str3 = gcem_staxdatto.text;
		var str4 = gcem_curatcode_fr01.text;
		var str5 = str2.substring(0,4);
		var str6 = "";
		var temp=str2.substring(0,6);

		if(str2.substring(4,6)=="01") {
			str6 = str2.substring(0,6)+"00";
		}else{
			str6 = Number(temp-1)+"31";
		}
		
		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s1?v_str1="+str1
												+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4
												+ "&v_str5="+str5+"&v_str6="+str6; 
			gcds_data1.Reset();
		}else{
			alert("�����ڵ带 �����Ͻʽÿ�.");
		}
	}else if(s=="02") {
		var strs1 = gclx_sfdcode2.BindColVal;	
		var strs2 = gcem_staxdatfr2.text;			
		var strs3 = gcem_staxdatto2.text;
		var strs4 = gcem_curatcode_fr02.text;
		var strs5 = strs2.substring(0,4);
		var strs6 = Number(strs2.substring(0,4)-1);
		var strs7 = Number(strs2.substring(4,6)-1);
		var strs8 = "";

		//if (strs2 == gs_date3 + "01") strs5 = Number(strs2.substring(0,4)-1);
		if (strs7<10) {
			if(strs7!=0){
				strs8 = strs5+"0"+strs7;
			}else{
				strs8 = strs5+"01";
			}
		}else if(strs7<=1){
			strs8 = strs5+"12";
		}else {
			strs8 = strs5+strs7;
		}

		if(strs2 != "" && strs3 != "" && strs4 != "") {
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s2?v_str1="+strs1
												+ "&v_str2="+strs2+"&v_str3="+strs3+"&v_str4="+strs4
												+ "&v_str5="+strs8+"&v_str6="+strs8;
			gcds_data2.Reset();
		}else{
			alert("�����ڵ带 �����Ͻʽÿ�.");
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

/******************************************************************************************
	Description : ��ȸ - ���[�Ϻ�]
******************************************************************************************/
function ln_PrtQuery1(){
	gcds_print.ClearData();
	for (var i=1;i<=gcds_temp.countrow;i++) {
		var str1 = gclx_sfdcode1.BindColVal;		//�����ڵ�
		var str2 = gcem_staxdatfr.text;				//ȸ��Ⱓfr	
		var str3 = gcem_staxdatto.text;				//ȸ��Ⱓto
		var str4 = gcds_temp.namevalue(i,"ATCODE");
		var str5 = str2.substring(0,4);				//�˻��⵵
		var str6 = "";												//�����̿�
		var temp = str2.substring(0,6);

		if (str2.substring(4,6) =="01") {	
			str6 = str2.substring(0,6)+"00";
		}else{
			str6 = Number(temp-1)+"31";
		}

		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2_1.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s1?v_str1="+str1+"&v_str2="+str2
												+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6;
			gcds_data2_1.Reset();
		}
	}
}

/******************************************************************************************
	Description : ��ȸ - ���[����]
******************************************************************************************/
function ln_PrtQuery2(){
	gcds_print2.ClearData();
	for (var i=1;i<=gcds_temp2.countrow;i++) {
		var str1 = gclx_sfdcode2.BindColVal;		//�����ڵ�
		var str2 = gcem_staxdatfr2.text;				//ȸ��Ⱓfr	
		var str3 = gcem_staxdatto2.text;				//ȸ��Ⱓto
		var str4 = gcds_temp2.namevalue(i,"ATCODE");
		var str5 = str2.substring(0,4);					//�˻��⵵
		var str6 = Number(str2.substring(0,4)-1);
		var str7 = Number(str2.substring(4,6)-1);
		var str8 = "";													//�����̿�

		//if (str2 == gs_date3 + "01") str5 = Number(str2.substring(0,4)-1);
		if (str7<10) {
			if(str7!=0){
				str8 = str5+"0"+str7;
			}else{
				str8 = str5+"01";
			}
		}else if(str7<=1){
			str8 = str5+"12";
		}else {
			str8 = str5+str7;
		}

		if(str2 != "" && str3 != "" && str4 != "") {
			gcds_data2_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s2?v_str1="+str1+"&v_str2="+str2
												+"&v_str3="+str3+"&v_str4="+str4+"&v_str5="+str8+"&v_str6="+str8;
			gcds_data2_2.Reset();
		}
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(e){
  if(e=="1") {
		ln_PrtQuery1();	//�Ϻ�-���
		if(gcrp_print.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcds_print.namevalue(1,"FDCODENM")  = gclx_sfdcode1.text;
			gcds_print.namevalue(1,"ATKORNAM2") = txt_curatkornam_to01.value;
			gcds_print.namevalue(1,"CURDT2")	  = gs_date;
			var str_fr = gcem_staxdatfr.text;
			var str_to = gcem_staxdatto.text;
			gcds_print.namevalue(1,"CURDT")	 = "(  �Ⱓ : "+str_fr.substring(0,4)+"�� "
																			 + str_fr.substring(4,6)+"�� "+str_fr.substring(6,8)+"��  ~  "
																			 + str_to.substring(0,4)+"�� "+str_to.substring(4,6)+"�� "
																			 + str_to.substring(6,8)+"��  )";
			gcrp_print.preview();
		}
	}else{
		ln_PrtQuery2();	//����-���
		if(gcrp_print2.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcds_print2.namevalue(1,"FDCODENM") = gclx_sfdcode2.text;
			gcds_print2.namevalue(1,"ATKORNAM2") = txt_curatkornam_to02.value;
			gcds_print2.namevalue(1,"CURDT2")	  = gs_date;			
			var str_fr2 = gcem_staxdatfr2.text;
			var str_to2 = gcem_staxdatto2.text;
			gcds_print2.namevalue(1,"CURDT") = "(  �Ⱓ : "+str_fr2.substring(0,4)+"�� "
																			 + str_fr2.substring(4,6)+"��  ~  "
																			 + str_to2.substring(0,4)+"�� "+str_to2.substring(4,6)+"��  )";
			gcrp_print2.preview();
		}
	}
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp1 = "ATDECR:STRING,ATCODE:STRING,ATKORNAM:STRING,ACTDAT:STRING,"
						 + "DETOT:DECIMAL,CRTOT:DECIMAL,SLPVLA:DECIMAL,CUMULTAL:DECIMAL,"
						 + "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING,ATKORNAM2:STRING";
	gcds_print.SetDataHeader(s_temp1);

	var s_temp2 = "ATDECR:STRING,ATCODE:STRING,ATKORNAM:STRING,ACTYYMM:STRING,"
						 + "LEVELS:STRING,DETOT:DECIMAL,CRTOT:DECIMAL,SLPVLA:DECIMAL,"
						 + "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING,ATKORNAM2:STRING";
	gcds_print2.SetDataHeader(s_temp2);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
  if(e=="1") {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	//	else gcgd_disp01.RunExcel('�Ϻ�-�Ѱ�������');
      else  gcgd_disp01.GridToExcel("�Ϻ�-�Ѱ�������","",2);
  
	}else if(e=="2") {
		if (gcds_data2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		//else gcgd_disp02.RunExcel('����-�Ѱ�������');
     else  gcgd_disp02.GridToExcel("����-�Ѱ�������","",2);
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_staxdatfr.text = gs_date2 + "01";
	gcem_staxdatto.text = gs_date;

	gcem_staxdatfr2.text = gs_date3 + "01";
	gcem_staxdatto2.text = gs_date2;

	//�Ϻ�-�����ڵ�[�˻�]
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//����-�����ڵ�[�˻�]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();
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
					ln_CurActcode('01');	//�Ϻ�-������� ��ȸ
			 }else if(p2=="to"){
					gcem_atcode_to01.text = arrParam[0];
					txt_atkornam_to01.value = arrParam[1];
					ln_CurActcode('01');	//�Ϻ�-������� ��ȸ
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
	}else if(p=="02"){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
					gcem_atcode_fr02.text = arrParam[0];
					txt_atkornam_fr02.value = arrParam[1];

					gcem_atcode_to02.text = arrParam[0];
					txt_atkornam_to02.value = arrParam[1];
					ln_CurActcode('02');	//�Ϻ�-������� ��ȸ
			 }else if(p2=="to"){
					gcem_atcode_to02.text = arrParam[0];
					txt_atkornam_to02.value = arrParam[1];
					ln_CurActcode('02');	//�Ϻ�-������� ��ȸ
			 }
		} else {
			if(p2=="fr") {
				gcem_atcode_fr02.text = "";
				txt_atkornam_fr02.value ="";
			}else if(p2=="to"){
				gcem_atcode_to02.text = "";
				txt_atkornam_to02.value = "";
			}
		}
	}
}

/***********************************************************************************************
	Description : [�Ϻ�] - �������� ã��
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
	//�׽�Ʈ��----------------------------------
	arrParam[4] = "A";		//A�� �ٲ������
	arrParam[5] = "0002";	//�����׸�1-�μ��ڵ�
	arrParam[6] = "0002";	//�����׸�2-�μ��ڵ�
	arrParam[7] = "0020";	//�����׸�3-�ŷ�ó
	//�׽�Ʈ��----------------------------------

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:520px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : �Ѱ�������[����] ã��
	parameter   : fcod2 - �����ڵ�, atcod2 - �����ڵ�, frdt2 - �˻�����(from), todt2 - �˻�����(to)
**********************************************************************************************/
function ln_Popup3(fcod2,atcod2,frdt2,todt2){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = fcod2;
	arrParam[1] = atcod2;
	arrParam[2] = frdt2;
	arrParam[3] = todt2;

	strURL = "./dtotalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : ������� ��ȸ
******************************************************************************/
function ln_CurActcode(p){
	if(p=="01") {
		var str1 = gcem_atcode_fr01.text;	
		var str2 = gcem_atcode_to01.text;	
		gcds_temp.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s0?v_str1="+str1+"&v_str2="+str2;
		gcds_temp.Reset();
	}else if(p=="02") {
		var str3 = gcem_atcode_fr02.text;
		var str4 = gcem_atcode_to02.text;
		gcds_temp2.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030011_s0?v_str1="+str3+"&v_str2="+str4;
		gcds_temp2.Reset();
	}
}

/******************************************************************************
	Description : ����-[�Ϻ�]
******************************************************************************/
function ln_Cumulative(){
	var row1 = gcds_data1.rowposition;
	var row  = gcds_data1.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*�ܾװ��*/
		if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//����:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "1" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");
			gcds_data1.namevalue(i,"SLPVLA") = t_33;  //����:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}else if (gcds_data1.namevalue(i,"ATDECR") == "2" && gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	
			gcds_data1.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}

		/*����-����*/			
		if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_data1.namevalue(i,"ACTDAT") = "�����̿�";
		}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*����*/
			if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_data1.namevalue(i,"ACTDAT") = "����";
			/*����*/
			}else if(gcds_data1.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_data1.namevalue(i,"ACTDAT") = "����";
				l_33 = l_33+gcds_data1.namevalue(i,"DETOT");	//��
				r_33 = r_33+gcds_data1.namevalue(i,"CRTOT");	//��
				gcds_data1.namevalue(i,"DETOT") = l_33;
				gcds_data1.namevalue(i,"CRTOT") = r_33;
				if(gcds_data1.namevalue(i,"ATDECR") == "1") {
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//�����ܾ�
				}else{
					gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//�����ܾ�
				}
				if(gcds_data1.namevalue(1,"ACTDAT") == "�����̿�") {
					gcds_data1.namevalue(i,"DETOT") = gcds_data1.namevalue(1,"DETOT")+gcds_data1.namevalue(i,"DETOT");
					gcds_data1.namevalue(i,"CRTOT") = gcds_data1.namevalue(1,"CRTOT")+gcds_data1.namevalue(i,"CRTOT");
					if(gcds_data1.namevalue(i,"ATDECR") == "1") {
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//�����ܾ�
					}else{
						gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(i,"CRTOT")-gcds_data1.namevalue(i,"DETOT");	//�����ܾ�
					}
				}
			}
		}
	}

	ln_CumulNew();	//������

	/*�����̿�*/	
	if (gcds_data1.namevalue(1,"ACTDAT") != "�����̿�") {	//�����̿� 0�϶�
		gcds_data1.InsertRow(1);
		gcds_data1.namevalue(1,"ACTDAT") = "�����̿�";
		gcds_data1.namevalue(1,"ATCODE") = gcds_data1.namevalue(2,"ATCODE");
		gcds_data1.namevalue(1,"DETOT")  = 0;
		gcds_data1.namevalue(1,"CRTOT")  = 0;
		gcds_data1.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : ������
******************************************************************************/
function ln_CumulNew(){
	var v_cnt = 0;
	for(var i=1;i<=gcds_data1.countrow;i++){
		if(gcds_data1.namevalue(i,"ACTDAT")!="�����̿�"&&gcds_data1.namevalue(i,"ACTDAT")!="����"&&gcds_data1.namevalue(i,"ACTDAT")!="����"){
			v_cnt = i-1;
			gcds_data1.namevalue(i,"SLPVLA") = gcds_data1.namevalue(v_cnt,"SLPVLA")+gcds_data1.namevalue(i,"DETOT")-gcds_data1.namevalue(i,"CRTOT");	//�����ܾ�
		}
	}
}

/******************************************************************************
	Description : ���� - ���[�Ϻ�]
******************************************************************************/
function ln_Cumulative2(){
	var row1 = gcds_print.rowposition;
	var row  = gcds_print.countrow;
	var l_33 = 0;
	var r_33 = 0;
	var t_33 = 0;
	for(var i=1;i<=row;i++) {
		/*�ܾװ��*/
		if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "32" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) != "33") {
			t_33 = t_33+gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//����:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "1" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");
			gcds_print.namevalue(i,"SLPVLA") = t_33;  //����:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}else if (gcds_print.namevalue(i,"ATDECR") == "2" && gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			t_33 = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	
			gcds_print.namevalue(i,"SLPVLA") = t_33;	//�뺯:����
		}

		/*����-����*/			
		if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "00") {
			gcds_print.namevalue(i,"ACTDAT") = "�����̿�";
		}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32" || gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33") {
			/*����*/
			if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "32"){
				gcds_print.namevalue(i,"ACTDAT") = "����";
			/*����*/
			}else if(gcds_print.namevalue(i,"ACTDAT").substring(8,10) == "33"){
				gcds_print.namevalue(i,"ACTDAT") = "����";
				l_33 = l_33+gcds_print.namevalue(i,"DETOT");	//��
				r_33 = r_33+gcds_print.namevalue(i,"CRTOT");	//��
				gcds_print.namevalue(i,"DETOT") = l_33;
				gcds_print.namevalue(i,"CRTOT") = r_33;
				if(gcds_print.namevalue(i,"ATDECR") == "1") {
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//�����ܾ�
				}else{
					gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//�����ܾ�
				}
				if(gcds_print.namevalue(1,"ACTDAT") == "�����̿�") {
					gcds_print.namevalue(i,"DETOT") = gcds_print.namevalue(1,"DETOT")+gcds_print.namevalue(i,"DETOT");
					gcds_print.namevalue(i,"CRTOT") = gcds_print.namevalue(1,"CRTOT")+gcds_print.namevalue(i,"CRTOT");
					if(gcds_print.namevalue(i,"ATDECR") == "1") {
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//�����ܾ�
					}else{
						gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(i,"CRTOT")-gcds_print.namevalue(i,"DETOT");	//�����ܾ�
					}
				}
			}
		}
	}

	/*�����̿�*/	
	if (gcds_print.namevalue(1,"ACTDAT") != "�����̿�") {	//�����̿� 0�϶�
		gcds_print.InsertRow(1);
		gcds_print.namevalue(1,"ACTDAT") = "�����̿�";
		gcds_print.namevalue(1,"ATCODE") = gcds_print.namevalue(2,"ATCODE");
		gcds_print.namevalue(1,"DETOT")  = 0;
		gcds_print.namevalue(1,"CRTOT")  = 0;
		gcds_print.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : ������ - ��¹�
******************************************************************************/
function ln_CumulNew2(){
	var v_cnt = 0;
	for(var i=1;i<=gcds_print.countrow;i++){
		if(gcds_print.namevalue(i,"ACTDAT")!="�����̿�"&&gcds_print.namevalue(i,"ACTDAT")!="����"&&gcds_print.namevalue(i,"ACTDAT")!="����"){
			v_cnt = i-1;
			gcds_print.namevalue(i,"SLPVLA") = gcds_print.namevalue(v_cnt,"SLPVLA")+gcds_print.namevalue(i,"DETOT")-gcds_print.namevalue(i,"CRTOT");	//�����ܾ�
		}
	}
}

/******************************************************************************
	Description : ���� - ����
******************************************************************************/
function ln_Cumulative3(){
	var row1 = gcds_data2.rowposition;
	var row  = gcds_data2.countrow;
	var t_33 = 0;
	for(var i=1;i<=gcds_data2.countrow;i++) {	/*����*/
		/*�ܾװ��*/
		if (gcds_data2.namevalue(i,"ATDECR") == "1" && gcds_data2.namevalue(i,"ACTYYMM") !="�հ�") {
			t_33 = t_33+gcds_data2.namevalue(i,"DETOT")-gcds_data2.namevalue(i,"CRTOT");
			gcds_data2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data2.namevalue(i,"ATDECR") == "2" && gcds_data2.namevalue(i,"ACTYYMM") !="�հ�") {
			t_33 = t_33+gcds_data2.namevalue(i,"CRTOT")-gcds_data2.namevalue(i,"DETOT");
			gcds_data2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data2.namevalue(i,"ATDECR") == "1" && gcds_data2.namevalue(i,"ACTYYMM") == "�հ�") {
			t_33 = t_33;
			gcds_data2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_data2.namevalue(i,"ATDECR") == "2" && gcds_data2.namevalue(i,"ACTYYMM") == "�հ�") {
			t_33 = t_33;
			gcds_data2.namevalue(i,"SLPVLA") = t_33;
		}

		/*����-����*/
		if(i==row && gcds_data2.namevalue(1,"ACTYYMM") == "�����̿�") {
			gcds_data2.namevalue(i,"DETOT") = gcds_data2.namevalue(1,"DETOT")+gcds_data2.namevalue(i,"DETOT");
			gcds_data2.namevalue(i,"CRTOT") = gcds_data2.namevalue(1,"CRTOT")+gcds_data2.namevalue(i,"CRTOT");
		}
	}

	/*�����̿�*/
	if (gcds_data2.namevalue(1,"ACTYYMM")!= "�����̿�") {	//�����̿� 0�϶�
		gcds_data2.InsertRow(1);
		gcds_data2.namevalue(1,"ACTYYMM") = "�����̿�";
		gcds_data2.namevalue(1,"ATCODE") = gcds_data2.namevalue(2,"ATCODE");
		gcds_data2.namevalue(1,"DETOT")  = 0;
		gcds_data2.namevalue(1,"CRTOT")  = 0;
		gcds_data2.namevalue(1,"SLPVLA") = 0;
	}
}

/******************************************************************************
	Description : ���� - ���[����]
******************************************************************************/
function ln_Cumulative4(){
	var row1 = gcds_print2.rowposition;
	var row  = gcds_print2.countrow;
	var t_33 = 0;
	for(var i=1;i<=gcds_print2.countrow;i++) {	/*����*/
		/*�ܾװ��*/
		if (gcds_print2.namevalue(i,"ATDECR") == "1" && gcds_print2.namevalue(i,"ACTYYMM") !="�հ�") {
			t_33 = t_33+gcds_print2.namevalue(i,"DETOT")-gcds_print2.namevalue(i,"CRTOT");
			gcds_print2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print2.namevalue(i,"ATDECR") == "2" && gcds_print2.namevalue(i,"ACTYYMM") !="�հ�") {
			t_33 = t_33+gcds_print2.namevalue(i,"CRTOT")-gcds_print2.namevalue(i,"DETOT");
			gcds_print2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print2.namevalue(i,"ATDECR") == "1" && gcds_print2.namevalue(i,"ACTYYMM") == "�հ�") {
			t_33 = t_33;
			gcds_print2.namevalue(i,"SLPVLA") = t_33;
		}else if (gcds_print2.namevalue(i,"ATDECR") == "2" && gcds_print2.namevalue(i,"ACTYYMM") == "�հ�") {
			t_33 = t_33;
			gcds_print2.namevalue(i,"SLPVLA") = t_33;
		}

		/*����-����*/
		if(i==row && gcds_print2.namevalue(1,"ACTYYMM") == "�����̿�") {
			gcds_print2.namevalue(i,"DETOT") = gcds_print2.namevalue(1,"DETOT")+gcds_print2.namevalue(i,"DETOT");
			gcds_print2.namevalue(i,"CRTOT") = gcds_print2.namevalue(1,"CRTOT")+gcds_print2.namevalue(i,"CRTOT");
		}
	}

	/*�����̿�*/
	if (gcds_print2.namevalue(1,"ACTYYMM")!= "�����̿�") {	//�����̿� 0�϶�
		gcds_print2.InsertRow(1);
		gcds_print2.namevalue(1,"ACTYYMM") = "�����̿�";
		gcds_print2.namevalue(1,"ATCODE") = gcds_print2.namevalue(2,"ATCODE");
		gcds_print2.namevalue(1,"DETOT")  = 0;
		gcds_print2.namevalue(1,"CRTOT")  = 0;
		gcds_print2.namevalue(1,"SLPVLA") = 0;
	}
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

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ���[�Ϻ���ȸ] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data2_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ���[������ȸ] -->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

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
		ln_Cumulative();//����
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
		ln_Cumulative3();//����
	}
</script>

<script language="javascript" for="gcds_data2_1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2_1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row>0) {
		if (gcds_print.countrow<1) {
			for(i=1;i<=gcds_data2_1.countrow;i++){
				gcds_print.ImportData(gcds_data2_1.ExportData(i,1,false));
			}
			ln_Cumulative2();	//����
		}else{
			gcds_print.ImportData(gcds_data2_1.ExportData(1,gcds_data2_1.CountRow,false));
			ln_Cumulative2();	//����
		}
	}
</script>

<script language="javascript" for="gcds_data2_2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2_2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row>0) {
		if (gcds_print2.countrow<1) {
			for(i=1;i<=gcds_data2_2.countrow;i++){
				gcds_print2.ImportData(gcds_data2_2.ExportData(i,1,false));
			}
			ln_Cumulative4();	//����
		}else{
			gcds_print2.ImportData(gcds_data2_2.ExportData(1,gcds_data2_2.CountRow,false));
			ln_Cumulative4();	//����
		}
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	//JYS ����
	//ln_DispChk((index-1)); /*�Ϻ�����*/
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	var row1 = gcds_data1.rowposition;
	var p_fcod = gclx_sfdcode1.BindColVal;
	var p_acod = gcem_curatcode_fr01.text;
	var p_frdt = gcds_data1.namevalue(row1, "ACTDAT");
	var p_todt = gcds_data1.namevalue(row1, "ACTDAT");
	var s_01 = gcds_data1.namevalue(row1,"ACTDAT");
	if(s_01.substring(5,10)!="" && s_01.substring(5,10)!="00/00" && s_01.substring(5,10)!="00/32" && s_01.substring(5,10)!="00/33")  {
		ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	//��������[�Ϻ�] Popup
	}
</script>

<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	var p_fcod2 = gclx_sfdcode2.BindColVal;
	var p_acod2 = gcem_curatcode_fr02.text;
	var p_frdt2 = gcds_data2.namevalue(gcds_data2.rowposition,"ACTYYMM")+"01";//gcem_staxdatfr2.text + "01";
	var p_todt2 = gcds_data2.namevalue(gcds_data2.rowposition,"ACTYYMM")+"31";//gcem_staxdatto2.text + "31";
	if(gcds_data2.namevalue(gcds_data2.rowposition,"ACTYYMM")!="�����̿�" &&
	gcds_data2.namevalue(gcds_data2.rowposition,"ACTYYMM")!="�հ�")  {
		ln_Popup3(p_fcod2,p_acod2,p_frdt2,p_todt2);	//�Ѱ�������[�Ϻ�] Popup
	}
</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
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
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030011_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
			<td width="0" align=right>
				<comment id="__NSID__">
				<object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
				<PARAM NAME="BackColor"			VALUE="#cccccc">
				<PARAM NAME="titleHeight"		VALUE="20px">
				<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
				<PARAM NAME="Format"			VALUE="
				<T>divid=div_1		title=�Ϻ�</T>									
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

<!-- �Ϻ����� ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:158px;left:18px;height:485px;width:875px;bacground-color:#708090"></fieldset>
<div id="div_1" style="position:absolute;top:160px;left:168px;height:485px;width:870px;" >
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr><td align="center" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;" >
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__">
					    <object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort				value=false>
						<param name=ListExprFormat	    value="FDNAME^0^110">
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
					<img src="../../Common/img/btn/com_b_print.gif"	  style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('1')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:2px;cursor:hand"  onclick="ln_Excel('1')">	
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
				</td>
			</tr>
			
			<tr> 				
				<td class="tab12" style="height:25px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab23" colspan="5" width="490px">&nbsp;<comment id="__NSID__">
					<object  id=gcem_atcode_fr01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;cursor:hand">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('fr','01');">
					<input id="txt_atkornam_fr01" type="text" class="txtbox"  style= "position:relative;top:-2px;width:130px;height:20px;" maxlength="36"  disabled>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_atcode_to01 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;cursor:hand">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('to','01');">
					<input id="txt_atkornam_to01" type="text" class="txtbox"  style= "position:relative;top:-2px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
				<td class="tab12" width="60px" align=left>
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,-1)">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp.RowPosition=gcds_temp.NextRow(gcds_temp.RowPosition,1)">
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
					<input id="txt_curatkornam_to01" type="text" class="txtbox"  style= "position:relative;left:8px;top:-4px;width:105px;height:20px;" maxlength="36"  disabled>
				</td>
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
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
						style="position:relative;left:8px;width:864px;height:389px; border:1 solid #708090;" viewastext>
						<PARAM NAME="DataID"			VALUE="gcds_data1">
						<PARAM NAME="IndWidth"		VALUE="0">
						<PARAM NAME="BorderStyle" VALUE="0">
						<PARAM NAME="Fillarea"		VALUE="true">
						<param name="Editable"    value="true">
						<!-- <PARAM NAME="ViewSummary"	VALUE="1"> -->
						<PARAM NAME="Format"			VALUE="  
						<C> Name='����'	ID=ACTDAT  HeadAlign=Center HeadBgColor=#B9D4DC Width=158	align=center Edit=None SumText='�հ�' SumBgColor='#C3D0DB'</C> 
						<C> Name='����'	ID=DETOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right	 Edit=None SumText=@sum  SumBgColor='#C3D0DB'</C>
						<C> Name='�뺯'	ID=CRTOT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right	 Edit=None SumText=@sum	 SumBgColor='#C3D0DB'</C> 
						<C> Name='�ܾ�'	ID=SLPVLA	 HeadAlign=Center HeadBgColor=#B9D4DC Width=230	align=right  Edit=None SumText=@sum	 SumBgColor='#C3D0DB'</C> 
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

<!-- �������� ===========================================================================================================-->
<div id="div_2" style="position:absolute;top:160px;left:168px;height:485px;width:875px;" >
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-147px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:80px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab21" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:120px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^110">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:80px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" width="220px">
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~
					<comment id="__NSID__"><object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
						style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					</nobr>
				</td>
				<td class="tab22" width="50px">&nbsp;</td>
				<td class="tab22">&nbsp;</td>
				<td class="tab22" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('2')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"  style="position:relative;right:5px;top:2px;cursor:hand"  onclick="ln_Excel('2')">	
					<img src="../../Common/img/btn/com_b_query.gif"   style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('02')">
				</td>
			</tr>
			
			<tr> 				
				<td class="tab12" style="height:25px;width:79px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab23" colspan="5" width="490px">&nbsp;<comment id="__NSID__">
					<object  id=gcem_atcode_fr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;cursor:hand">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('fr','02');">
					<input id="txt_atkornam_fr02" type="text" class="txtbox"  style= "position:relative;top:-2px;width:130px;height:20px;" maxlength="36"  disabled>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_atcode_to02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:-1px;top:5px;cursor:hand">				
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
						<param name=Enable				value=false>
					</object></comment><script>__ws__(__NSID__);</script>         
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����ڵ带 �˻��մϴ�" style="cursor:hand;position:relative;left:2px;top:1px" align=center onclick="ln_Popup('to','02');">
					<input id="txt_atkornam_to02" type="text" class="txtbox"  style= "position:relative;top:-2px;width:130px;height:20px;" maxlength="36"  disabled>
				</td>
				<td class="tab12" width="60px" align=left>
					<img src="../../Common/img/btn/com_btn_left.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp2.RowPosition=gcds_temp2.NextRow(gcds_temp2.RowPosition,-1)">
					<img src="../../Common/img/btn/com_btn_right.gif"	style="position:relative;top:2px;cursor:hand" onClick="gcds_temp2.RowPosition=gcds_temp2.NextRow(gcds_temp2.RowPosition,1)">
				</td>
				<td class="tab12" width="80px" bgcolor="#eeeeee">�������</td>
				<td width="170px">
					<comment id="__NSID__"><object  id=gcem_curatcode_fr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:5px;top:3px;">		
						<param name=Text					value="">
						<param name=Alignment     value=0>
						<param name=Border        value=true>
						<param name=Numeric       value=false>
						<param name=Format        value="#######">
						<param name=PromptChar    value="">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<input id="txt_curatkornam_to02" type="text" class="txtbox"  style= "position:relative;left:8px;top:-4px;width:105px;height:20px;" maxlength="36"  disabled>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;top:3px;left:-155px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
						style="position:relative;left:8px;width:864px; height:389px; border:1 solid #708090;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data2">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<!-- <PARAM NAME="ViewSummary"	VALUE="1"> -->
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
				<C> Name='����'	ID=ACTYYMM  HeadAlign=Center HeadBgColor=#B9D4DC Width=158 align=center SumText='�հ�' SumBgColor='#C3D0DB'</C> 
				<C> Name='����'	ID=DETOT		HeadAlign=Center HeadBgColor=#B9D4DC Width=230 align=right  SumText=@sum   SumBgColor='#C3D0DB'</C>
				<C> Name='�뺯'	ID=CRTOT		HeadAlign=Center HeadBgColor=#B9D4DC Width=230 align=right  SumText=@sum	 SumBgColor='#C3D0DB'</C> 
				<C> Name='�ܾ�'	ID=SLPVLA		HeadAlign=Center HeadBgColor=#B9D4DC Width=230 align=right  SumText=@sum	 SumBgColor='#C3D0DB'</C> 
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

		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  - �Ϻ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr01				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to01				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N  - ����
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp2>
	<param name=BindInfo  value='  
		<C>Col=ATCODE				Ctrl=gcem_curatcode_fr02				Param=text</C>
		<C>Col=ATKORNAM			Ctrl=txt_curatkornam_to02				Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N - �Ϻ�
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<!-- <param name="NullRecordFlag"   value="true"> -->
	<param name="Format"					value="
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=372 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1100 ,top=34 ,right=1938 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1091 ,top=22 ,right=1925 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=934, top=119, right=2078, bottom=166, face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��  ��  ��' ,left=1094 ,top=25 ,right=1919 ,bottom=87 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=241 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=647 ,top=291 ,right=1347 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=247 ,top=291 ,right=634 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2066 ,top=284 ,right=2066 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1353 ,top=284 ,right=1353 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=284 ,right=241 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=641 ,top=284 ,right=641 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=241, top=181, right=1088, bottom=228, align='left' ,mask='��      ��: XXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM2', left=241, top=228, right=1088, bottom=281, align='left' ,mask='��������: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��' ,left=1359 ,top=291 ,right=2059 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=2072 ,top=291 ,right=2803 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=372 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>
	<C>id='SLPVLA', left=2072, top=0, right=2803, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2066 ,top=0 ,right=2066 ,bottom=50 </L>
	<C>id='CRTOT', left=1359, top=0, right=2059, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1353 ,top=0 ,right=1353 ,bottom=50 </L>
	<C>id='DETOT', left=647, top=0, right=1347, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=641 ,top=0 ,right=641 ,bottom=50 </L>
	<C>id='ACTDAT', left=247, top=0, right=634, bottom=44, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 </L>
	<L> left=241 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=241 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>
	<L> left=72 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N  - ����
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print2">
	<param name="DetailDataID"		value="gcds_print2">
	<param name="PaperSize"				value="A4">
	<param name="LandScape"				value="true">
	<param name="fixpapersize"		value="true">
	<param name="printMargine"		value="false">
	<param name="SuppressColumns"	value="1:pageskip,ATCODE;">
	<!-- <param name="NullRecordFlag"   value="true"> -->
	<param name="Format"					value="
	<B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=372 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1100 ,top=34 ,right=1938 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1091 ,top=22 ,right=1925 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=934, top=119, right=2078, bottom=166, face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��  ��  ��' ,left=1094 ,top=25 ,right=1919 ,bottom=87 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=241 ,top=284 ,right=2809 ,bottom=284 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=247 ,top=291 ,right=634 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2809 ,top=284 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2066 ,top=284 ,right=2066 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1353 ,top=284 ,right=1353 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=284 ,right=241 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=641 ,top=284 ,right=641 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=181, right=2806, bottom=228, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=228 ,right=2806 ,bottom=281 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODENM', left=241, top=181, right=1088, bottom=228, align='left' ,mask='��      ��: XXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM2', left=241, top=228, right=1088, bottom=281, align='left' ,mask='��������: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��' ,left=2072 ,top=291 ,right=2803 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=647 ,top=291 ,right=1347 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��  ��' ,left=1359 ,top=291 ,right=2059 ,bottom=366 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=372 ,right=2809 ,bottom=372 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2869 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2809 ,top=0 ,right=2809 ,bottom=50 </L>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 </L>
	<C>id='ACTYYMM', left=247, top=0, right=634, bottom=44, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=641 ,top=0 ,right=641 ,bottom=50 </L>
	<C>id='DETOT', left=647, top=0, right=1347, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1353 ,top=0 ,right=1353 ,bottom=50 </L>
	<C>id='CRTOT', left=1359, top=0, right=2059, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2066 ,top=0 ,right=2066 ,bottom=50 </L>
	<C>id='SLPVLA', left=2072, top=0, right=2803, bottom=44, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=50 ,right=2809 ,bottom=50 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2869 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=241 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=84</I>
	<L> left=241 ,top=0 ,right=2809 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 