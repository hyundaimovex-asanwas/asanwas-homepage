<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ������-���Ͱ�꼭
+ ���α׷� ID	:  A030010.html
+ �� �� �� ��	:  ���Ͱ�꼭 ��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  �� �� ��(REPORT ����)
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ���Ͱ�꼭 Ȯ���۾�   
+ ��   ��  �� :  ys.jeong
+ �� �� �� �� :  2006.08.19 
-----------------------------------------------------------------------------
+ �� �� �� ��	:	 a030010_s1, a030010_s2
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���Ͱ�꼭</title>

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

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7); //���
var gs_date3 = gcurdate.substring(0,4); //��
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************************
	Description : ��ȸ
******************************************************************************************/
function ln_Query(s){

	if(s=="02") { //���ȸ��
		var str1 = gclx_sfdcode2.bindcolval; //�����ڵ�
		var str2 = gcem_staxdatfr2.text; //���from
		var str3 = gcem_staxdatto2.text; //���to
		//var str4 = gclx_cocode.bindcolval; //�����
		var str4 =""; //�����
		var str5 = gclx_rdept.bindcolval; //����

    	if(chkbox2.checked==false){  //��ȭ������
			if(chkbox_md2.checked==true){//�����а� ����
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s2?v_str1="+str1
													+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5; 
				gcds_data2.Reset();
			}else{ //�����а� ������
				gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s2_n?v_str1="+str1
													+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5; 
				gcds_data2.Reset();
			}
			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //���
		}else{
			if(gclx_sfdcode2.bindcolval==""){ //��ü �׻� ��ȭ�� ��ȸ��.
					if(chkbox_md2.checked==true){  //�����а�����
						gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3?v_str1="+str1
															+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						gcds_data2.Reset();
					}else{  //�����а� ������
						gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						
						gcds_data2.Reset();
					}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //���
			}else if(gclx_sfdcode2.bindcolval=="03"){ //�ݰ���(��ȭ�� ��ȸ)
			  if(chkbox_md2.checked==true){  //�����а�����
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3?v_str1="+str1
														+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
					//prompt("",gcds_data2.DataID);
					gcds_data2.Reset();
				}else{//�����а� ������
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s3_n?v_str1="+str1
														+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
					gcds_data2.Reset();
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //���
			}
		}
	}else if(s=="01") { //����
		
		var str1 = gclx_sfdcode.bindcolval; //�����ڵ�
		var str2 = gcem_staxdatfr.text; //���from
		var str3 = gcem_staxdatto.text; //���to
		//var str4 = gclx_cocode.bindcolval; //�����
		var str4 =""; //�����
		var str5 =""; //gclx_rdept.bindcolval; //����

    	if(chkbox.checked==false){    //��ȭ������
			if(chkbox_cost.checked==false){//�ǰ��񱸺� ���� ==>�ǰ���
				if(chkbox_md.checked==true){//�����а� ����
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("NY",gcds_data1.DataID);
					gcds_data1.Reset();
				}else{ //�����а� ������
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_n?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("NN",gcds_data1.DataID);
					gcds_data1.Reset();
				}
			}else{//�Ǹź�&������ ����
				if(chkbox_md.checked==true){//�����а� ����
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_b?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("KNYB",gcds_data1.DataID);
					gcds_data1.Reset();
				}else{ //�����а� ������
					gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s22_n_b?v_str1="+str1
														+ "&v_str2="+str2+ "&v_str3="+str3+ "&v_str4="+str4+ "&v_str5="+str5; 
					//prompt("KYYB",gcds_data1.DataID);
					gcds_data1.Reset();
				}
			}
			gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
			gcds_staxdatki.Reset(); //���
		}else{
			if(gclx_sfdcode.bindcolval==""){ //��ü �׻� ��ȭ�� ��ȸ��.
					if(chkbox_md.checked==true){  //�����а�����
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23?v_str1="+str1
															+ "&v_str2="+str2 + "&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
            //prompt("AYY",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{  //�����а� ������
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3 + "&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=A";
						//prompt("AYN",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //���
			}else if(gclx_sfdcode.bindcolval=="03"){ //�ݰ���(��ȭ�� ��ȸ)
				if(chkbox_cost.checked==false){//�ǰ��񱸺� ���� ==>�ǰ���
					if(chkbox_md.checked==true){           //�����а�����
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYY",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{//�����а� ������
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYN",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				}else{ //�ǰ��񱸺���==>�Ǹź�&������
					if(chkbox_md.checked==true){           //�����а�����
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_b?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						//prompt("KYYB",gcds_data1.DataID);
						gcds_data1.Reset();
					}else{//�����а� ������
						gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030010_s23_n_b?v_str1="+str1
															+ "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4 + "&v_str5="+str5+ "&v_str6=K";
						prompt("KYNB",gcds_data1.DataID);
						gcds_data1.Reset();
					}
				}
				gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
				gcds_staxdatki.Reset(); //���
			}
		}
	}
}

/*****************************************************************************************
	Description : ���Ͱ�꼭 ���� ����
*****************************************************************************************/

function ln_ManCalCu(){
	var cnt  = gcds_data1.countrow;
	var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
	var str2 = gcem_staxdatto.text; 
	//var str4 = gclx_cocode.BindColVal;			//�����
	var str4 = "";			//�����
	var str5 =""; // gclx_rdept.BindColVal;				//����
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//ȸ����(����)
	var strfr1 = gcem_staxdatfr.text;				//ȸ����(���)
	var strfr2 = Number(strfr1.substring(0,4)-1)+strfr1.substring(4,6);	

	var md_gubun ="";
	var won_gubun="";
	if(chkbox.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  


	for(var i=1;i<=cnt;i++) {	//(��)��
		if (gcds_data1.namevalue(i,"XCOM") != null && gcds_data1.namevalue(i,"XCOM") != "") {
			var temp = gcds_data1.namevalue(i,"XCOM");				//�º�,�캯 ����
			gf_array_val(gcds_name,str1,str2,str4,str5,temp,strfr1,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"XRTTOT") = s_amt;
		}
	}
	///return;
	for(var i=1;i<=cnt;i++) {	//(��)��
		if (gcds_data1.namevalue(i,"YCOM") != null && gcds_data1.namevalue(i,"YCOM") != "") {
			var temp = gcds_data1.namevalue(i,"YCOM");				//�º�,�캯 ����
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strfr2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data1.namevalue(i,"YRTTOT") = s_amt;
		}
	}
}


/*****************************************************************************************
	Description : ���Ͱ�꼭 ��� ����
*****************************************************************************************/
function ln_ManCalCu2(){
   	var cnt  = gcds_data2.countrow;
	var str1 = gclx_sfdcode2.BindColVal;		//�����ڵ�
	var str2 = gcem_staxdatto2.text; 
	//var str4 = gclx_cocode.BindColVal;			//�����
	var str4 = "";			//�����
	var str5 = gclx_rdept.BindColVal;				//����
	var str6 = Number(str2.substring(0,4)-1)+str2.substring(4,6);		//ȸ����(����)
	var strfr1 = gcem_staxdatfr2.text;				//ȸ����(���)
	var strfr2 = Number(strfr1.substring(0,4)-1)+strfr1.substring(4,6);	

	var md_gubun ="";
	var won_gubun="";
	if(chkbox2.checked==false) won_gubun="N";
	else won_gubun="Y";
	if(chkbox_md2.checked==true) md_gubun = "Y";  
	else  md_gubun = "N";  

	for(var i=1;i<=cnt;i++) {	//(��)��
	    
		if (gcds_data2.namevalue(i,"XCOM") != null && gcds_data2.namevalue(i,"XCOM") != "") {

			var temp = gcds_data2.namevalue(i,"XCOM");				//�º�,�캯 ����
			gf_array_val(gcds_name,str1,str2,str4,str5,temp,strfr1,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"XRTTOT") = s_amt;
		}
	}
	///return;
	for(var i=1;i<=cnt;i++) {	//(��)��
		if (gcds_data2.namevalue(i,"YCOM") != null && gcds_data2.namevalue(i,"YCOM") != "") {
			var temp = gcds_data2.namevalue(i,"YCOM");				//�º�,�캯 ����
			gf_array_val(gcds_name,str1,str6,str4,str5,temp,strfr2,md_gubun,won_gubun);
			var s_amt = gcds_name2.namevalue(1,"TOTALVALUE");
			if (s_amt == null || s_amt == "NaN") s_amt = 0;
			gcds_data2.namevalue(i,"YRTTOT") = s_amt;
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
function ln_Print(e){
	if(e=="01") {
	}else if(e=="02"){
		ln_PrintHeader();

			//��¥ �� �ð� ����
		gcds_datetime.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_datetime_s1?"
		gcds_datetime.Reset();

    gcds_time.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030009_s4";
    gcds_time.Reset();

		for(i=1;i<=gcds_data2.countrow;i++){
			gcds_print.ImportData(gcds_data2.ExportData(i,1,false));
			
			var strfr1  = gcem_staxdatfr2.text+"01";	//8��
			var strfr2  = shiftTime(strfr1,-1,0,0);		//7��
			var strto		= gcem_staxdatto2.text+"01";	//to
			
			var strto1	= shiftTime(strto,0,1,-1);		//8��
			var strto2	= shiftTime(strto,-1,1,-1);		//7��
			var ki			= gcds_staxdatki.namevalue(1,"CDCODE");
			var ki1			= Number(gcem_staxdatfr2.text.substring(0,4))-Number(ki)+1;
			var ki2			= Number(gcem_staxdatfr2.text.substring(0,4))-1-Number(ki)+1;

			/*
			gcds_print.namevalue(i,"KISU1")	   = ki1+strfr1.substring(0,4)+strfr1.substring(4,6)+strfr1.substring(6,8)
																				 + strto1.substring(0,4)+strto1.substring(4,6)+strto1.substring(6,8);
			gcds_print.namevalue(i,"KISU2")	   = ki2+strfr2.substring(0,4)+strfr2.substring(4,6)+strfr2.substring(6,8)
																				 + strto2.substring(0,4)+strto2.substring(4,6)+strto2.substring(6,8);;
      */  

      gcds_print.namevalue(i,"KISU1")	   = "��"+ki1+"�� : "+strto1.substring(0,4)+"�� "+strto1.substring(4,6)+"�� "+strto1.substring(6,8)+"�� ����";
			gcds_print.namevalue(i,"KISU2")	   = "��"+ki2+"�� : "+strto2.substring(0,4)+"�� "+strto2.substring(4,6)+"�� "+strto2.substring(6,8)+"�� ����";


			gcds_print.namevalue(i,"CURKISU")  = Number(gcem_staxdatto2.text.substring(0,4))-Number(ki)+1;		//8��
			gcds_print.namevalue(i,"PREKISU")  = Number(gcem_staxdatto2.text.substring(0,4))-1-Number(ki)+1;	//7��
			gcds_print.namevalue(i,"FDCODENM") = "���� : "+gcds_sfdcode2.NameValue(gcds_sfdcode2.rowposition,"FDNAME");
			gcds_print.namevalue(i,"CURDT")	   = gs_date;
			gcds_print.namevalue(i,"CURTM") = gcds_time.namevalue(1,"curtime");
		}
		gcrp_print1.preview();
	}
}

/******************************************************************************
	Description : ��� - Header Set
******************************************************************************/
function ln_PrintHeader() {
	var Theader = "PRTNAM:STRING,PRTSEQ:STRING,XLTTOT:DECIMAL,XRTTOT:DECIMAL,XCOM:STRING,"
							+ "XREAD:STRING,YLTTOT:DECIMAL,YRTTOT:DECIMAL,YCOM:STRING,YREAD:STRING,"
							+ "KISU1:STRING,KISU2:STRING,CURKISU:STRING,PREKISU:STRING,FDCODENM:STRING,"
							+ "CURDT:STRING,CURTM:STRIMG";
	gcds_print.SetDataHeader(Theader);
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="01") {
	//	gcgd_disp01.runexcel("���Ͱ�꼭 ����");
gcgd_disp01.GridToExcel("���Ͱ�꼭 ����","",2);
	}
	else if(e=="02") {
	//	gcgd_disp02.runexcel("���Ͱ�꼭 ���");
gcgd_disp02.GridToExcel("���Ͱ�꼭 ���","",2);
	}

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){

	gcem_staxdatfr2.text = gs_date3+"01"; //���
	gcem_staxdatto2.text = gs_date2;
	gcem_staxdatfr.text = gs_date3+"01"; //���
	gcem_staxdatto.text = gs_date2;

	//���ȸ�����/�����ڵ�
	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//����/�����ڵ�
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	//����/�����
	gcds_cocode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>company_s1?v_str1=";
	gcds_cocode.Reset(); 

	//����/����
	gcds_rdept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?v_str1=";
	gcds_rdept.Reset(); 

	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //���
}

/******************************************************************************
	Description : ��
	prameter    : 0 - ���ȸ�����, 1 - ����
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
	Description : ������ Set
	//������� ����.
******************************************************************************/
function ln_DataSet(){

	var ls_temp1 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML";
	var ls_temp2 = "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	var ls_temp3 = "PRTACT:STRING,PRTNAM:STRING,PRTSEQ:STRING,DECRTOT:DECIAML,"
							 + "PRTACT2:STRING,PRTNAM2:STRING,PRTSEQ2:STRING,DECRTOT2:DECIAML";
	gcds_temp1.SetDataHeader(ls_temp1);
	gcds_temp2.SetDataHeader(ls_temp2);
	gcds_temp3.SetDataHeader(ls_temp3);

	var decnt = 0;
	var crcnt = 0;
	for(var i=1;i<=gcds_data1.countrow;i++){
		var s_prtact = gcds_data1.namevalue(i,"PRTDIV");
		//var s_prtact = gcds_data1.namevalue(i,"PRTACT"); 
		if(s_prtact.substring(0,1) == "1") {	
			decnt++;	//�ڻ�
		}else if (s_prtact.substring(0,1) == "2" || s_prtact.substring(0,1) == "3") {	
			crcnt++;	//��ä & �ں�
		}
	}

	gcds_temp1.ImportData(gcds_data1.ExportData(1, decnt, true));
	gcds_temp3.ImportData(gcds_data1.ExportData(1, decnt, true));
	gcds_temp2.ImportData(gcds_data1.ExportData(Number(decnt+1), crcnt, true));
	
	for(var p2=1;p2<=crcnt;p2++) {
		gcds_temp3.namevalue(p2,"PRTACT2")  =  gcds_temp2.namevalue(p2,"PRTACT2");
		gcds_temp3.namevalue(p2,"PRTNAM2")  =  gcds_temp2.namevalue(p2,"PRTNAM2");
		gcds_temp3.namevalue(p2,"PRTSEQ2")  =  gcds_temp2.namevalue(p2,"PRTSEQ2");
		gcds_temp3.namevalue(p2,"DECRTOT2") =  gcds_temp2.namevalue(p2,"DECRTOT2");
	}
	
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + decnt + " ��";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + crcnt + " ��";
}

/******************************************************************************
	Description : ��¥���
	prameter    : 
******************************************************************************/

/**
 * Time ��Ʈ���� �ڹٽ�ũ��Ʈ Date ��ü�� ��ȯ
 * parameter time: Time ������ String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1��=0,12��=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * �ڹٽ�ũ��Ʈ Date ��ü�� Time ��Ʈ������ ��ȯ
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1��=0,12��=11�̹Ƿ� 1 ����
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * �־��� Time �� y�� m�� d�� ���̳��� Time�� ����
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 ���κ��� 100�� �� Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y���� ����
    date.setMonth(date.getMonth() + m);       //m���� ����
    date.setDate(date.getDate() + d);         //d���� ����

    return toTimeString(date);
}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ��� �迭�� ���
	parameter  : gcds_name //����Ÿ�¸� 
	             fdcode    //�����ڵ�
							 actyymm   //ȸ����
							 atcode    //�����ڵ�
							 cocode    //�����
							 divcd     //����
							 temp      //����
	retun      : ������.
******************************************************************************************/
function gf_array_val1(gcds_name,fdcode, actyymm, cocode, divcd, temp){ 
    alert("gcds_name:"+gcds_name+"/fdcode:"+fdcode+"/actyymm:"+actyymm+"/cocode:"+cocode+"/divcd:"+divcd+"/temp:"+temp);
	var arrcode = new Array();
	var cnt=0;
	var cnt1=0;
	var strData="";
	var result="";
	arrcode[0]="";

	for (i=0;i<temp.length;i++){
		if(temp.charAt(i)==" "){
		}else if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				if(cnt1==0)strData="";
        strData += temp.charAt(i);
				arrcode[cnt]=strData;
			if (cnt1==6) {
					  gf_format_val1(gcds_name,fdcode,actyymm,arrcode[cnt],cocode,divcd);
						arrcode[cnt] = gcds_name.namevalue(1,"TOTALVAL");
						arrcode[cnt] = Math.floor(arrcode[cnt]);
						cnt1=0;
						cnt+=1;
						strData=""
					}else{
						cnt1+=1 ;
			}
		}else{
	      strData="";
				strData = temp.charAt(i);
        arrcode[cnt] =strData;
				cnt1=0;
				cnt+=1;
		}
	}//for
	for(j=0;j<arrcode.length;j++){
    result+=arrcode[j];
  }
	if(temp.length>=8){
		gf_cal_val1(gcds_name2,result);
  }else{
		gcds_name2.ClearAll();
		var s_temp = "TOTALVALUE:STRING"
		gcds_name2.SetDataHeader(s_temp);
		gcds_name2.addrow();
    gcds_name2.namevalue(1,"TOTALVALUE")=result;
	}

}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ���
	parameter  : gcds_name //����Ÿ�¸� 
	             fdcode    //�����ڵ�
							 actyymm   //ȸ����
							 atcode    //�����ڵ�
							 cocode    //�����
							 divcd     //����
	retun      : 
******************************************************************************************/
function gf_format_val1(gcds_name,fdcode, actyymm, atcode, cocode, divcd){ 

		gcds_name.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_func_s1?v_str1="+fdcode
																										 +"&v_str2="+actyymm
																										 +"&v_str3="+atcode
																										 +"&v_str4="+cocode
																										 +"&v_str5="+divcd;
	  gcds_name.Reset();			

}

/******************************************************************************************
 	Descrition : ��������ǥ �ݾ� ���
	parameter  : gcds_name2,      //����Ÿ�¸� 
	             dblvalue         //���� 
	            
	retun      : 
******************************************************************************************/
function gf_cal_val1(gcds_name2, dblvalue){ 

		gcds_name2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_cal_s1?v_str1="+dblvalue;
	  gcds_name2.Reset();

}

/******************************************************************************************
 	Descrition : ���
******************************************************************************************/
function ln_Enable2(p){
	if(p=="t"){
		chkbox2.disabled=false;
	}else if(p=="f"){
	  chkbox2.disabled=true;
		chkbox2.checked=false;
	}
}

/******************************************************************************************
 	Descrition : ����
******************************************************************************************/
function ln_Enable(p){
	if(p=="t"){
		chkbox.disabled=false;
	}else if(p=="f"){
	  chkbox.disabled=true;
		chkbox.checked=false;
	}

  if(gclx_sfdcode.bindcolval=="03"){
		chkbox_cost.disabled=false;
	}else{
		chkbox_cost.disabled=true;
		chkbox_cost.checked=false;
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� -->

<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���� -->

<comment id="__NSID__"><object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� -->

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� -->

<comment id="__NSID__"><object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"		VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� -->

<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_cocode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_rdept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� temp -->

<comment id="__NSID__"><object  id=gcds_name2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!-- ���ȸ����� temp -->

<comment id="__NSID__"><object  id="gcds_staxdatki" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- ��� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_time" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_datetime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ��³�¥ �ð� -->
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
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
		//ln_DataSet(); //gcds_temp��
		ln_ManCalCu();	//���Ͱ�����  ����
	}
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
		ln_ManCalCu2();	//���Ͱ����  ����
	}
</script>

<script language="javascript" for="gcds_name" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_name" event="onloadCompleted(row,colid)">
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_name2" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_name2" event="onloadCompleted(row,colid)">
	document.all.LowerFrame.style.visibility="hidden";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*���ȸ�����*/
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

	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
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

	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable2('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable2('f');
	}
</script>

<!-- <script language="javascript" for="gcds_cocode" event="onloadCompleted(row,colid)">
	gcds_cocode.InsertRow(1);
	gcds_cocode.NameValue(1,"COCODE")="";
	gcds_cocode.NameValue(1,"CONAME")="��ü";
	gclx_cocode.index=1;
</script> -->

<script language="javascript" for="gcds_rdept" event="onloadCompleted(row,colid)">
	gcds_rdept.InsertRow(1);
	gcds_rdept.NameValue(1,"DEPTCD")="";
	gcds_rdept.NameValue(1,"DEPTNM")="��ü";
	gclx_rdept.index=0;
</script>
 
<script language="javascript" for="gcds_staxdatki" event="onloadCompleted(row,colid)">
	var ki = gcds_staxdatki.namevalue(1,"CDCODE");
	var ki1 = Number(gcem_staxdatto2.text.substring(0,4))-Number(ki)+1+"";   //8��
	var ki2 = Number(gcem_staxdatto2.text.substring(0,4))-1-Number(ki)+1+""; //7��
	gcgd_disp02.ColumnProp('GUBUN1','NAME') = "�� " + ki1 + "(��)��";
	gcgd_disp02.ColumnProp('GUBUN2','NAME') = "�� " + ki2 + "(��)��";
	gcgd_disp01.ColumnProp('GUBUN1','NAME') = "�� " + ki1 + "(��)��";
	gcgd_disp01.ColumnProp('GUBUN2','NAME') = "�� " + ki2 + "(��)��";
</script>

<script language=JavaScript for=gclx_sfdcode2 event=OnSelChange()>
	
	if(gclx_sfdcode2.bindcolval==""||gclx_sfdcode2.bindcolval=="03"){
		ln_Enable2('t');
		if(gclx_sfdcode2.bindcolval=="") chkbox2.checked=true;
	}else{
		ln_Enable2('f');
	}
</script>

<script language=JavaScript for=gclx_sfdcode event=OnSelChange()>
	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
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
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030010_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title='���ȸ�����'</T>									
								<T>divid=div_2		title='  �� ��  '</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!------------------------ ���ȸ����� ----------------------->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr> 				
				<td class="tab12" style="height:30px;width:50px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;~&nbsp;<comment id="__NSID__">
					<object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;&nbsp;</nobr>
				</td>
				<!-- <td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">��&nbsp;��&nbsp;��</td>
				<td class="tab23" width="40px"><nobr>
					<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:50px;height:110px;">
						<param name=ComboDataID			value="gcds_cocode">
						<param name=CBDataColumns		value="COCODE,CONAME">
						<param name=SearchColumn		value="CONAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CONAME^0^90">
						<param name=BindColumn			value="COCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td> -->
				<td class="tab12" style="height:25px;width:50px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab23" width="100px"><nobr>
					<comment id="__NSID__"><object  id=gclx_rdept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:100px;height:150px;">
						<param name=ComboDataID			value="gcds_rdept">
						<param name=CBDataColumns		value="DEPTCD,DEPTNM">
						<param name=SearchColumn		value="DEPTNM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="DEPTNM^0^120">
						<param name=BindColumn			value="DEPTCD">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
 
        <td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>�����а�</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��ȭ&nbsp;</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox2  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>
				<td align="right"  colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:-1px;top:2px;cursor:hand" onClick="ln_Print('02')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:-1px;top:2px;cursor:hand" onClick="ln_Excel('02')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:-1px;top:2px;cursor:hand" onclick="ln_Query('02')">&nbsp;
				</td>
			</tr>
		</table>
	</td>
	</tr>
	<tr><td height="2px" colspan =2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP>
					<comment id="__NSID__"><object  id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:8px;width:864px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data2">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='�����ڵ�'	ID=ATCODE HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left show=false</C> 
								<C> Name='��������'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left sort=false</C> 
								<G> Name='�� (��)��'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='�ݾ�'	ID=XLTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C>
									<C> Name='�ݾ�'	ID=XRTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
								<G> Name='�� (��)��'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='�ݾ�'	ID=YLTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
									<C> Name='�ݾ�'	ID=YRTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
					</fieldset>
			</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>


<!----------------- �� �� -------------------->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:485px;width:878px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr><td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td class="tab12" style="width:80px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:80px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="FDNAME^0^80">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab12" style="height:25px;width:60px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab23" width="80px"><nobr>
					<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;~&nbsp;
					<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
					&nbsp;&nbsp;</nobr>
				</td>

				<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>�����а�</nobr></td>
				<td width="35px" class="tab23" ><nobr>&nbsp;
					<input type=checkbox  id=chkbox_md  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��ȭ&nbsp;</nobr></td>
				<td width="35px" class="tab23"><nobr>&nbsp;
					<input type=checkbox  id=chkbox  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>

				<td width="40px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�ǰ��񱸺�&nbsp;</nobr></td>
				<td width="15px"><nobr>&nbsp;
					<input type=checkbox  id=chkbox_cost  style=width:15px;position:relative;left:-4px;top:-1px;>
				</nobr>	
				</td>
				<td width="50px">&nbsp;</td>
				<td>&nbsp;</td>
				<td width="200px" align=right colspan="3">
					<img src="../../Common/img/btn/com_b_print.gif"	style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Print('01')">
					<img src="../../Common/img/btn/com_b_excel.gif"	style="position:relative;right:5px;top:2px;cursor:hand" onClick="ln_Excel('01')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:2px;cursor:hand" onclick="ln_Query('01')">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td height="2px" colspan=2></td></tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
			<tr> 			
				<td style="width:280" ALIGN=LEFT VALIGN=TOP><nobr>
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
						style="position:relative;left:8px;width:864px; height:400px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
              <param name="Editable"    value="false">
							<PARAM NAME="Format"			VALUE="  
								<C> Name='��������'	ID=PRTNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left sort=false</C> 
								<G> Name='�� (��)��'	ID=GUBUN1 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='�ݾ�'	ID=XLTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C>
									<C> Name='�ݾ�'	ID=XRTTOT  HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
								<G> Name='�� (��)��'	ID=GUBUN2 HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='�ݾ�'	ID=YLTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
									<C> Name='�ݾ�'	ID=YRTTOT HeadAlign=Center HeadBgColor=#B9D4DC Width=165 align=right</C> 
								</G>
							">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
					</fieldset>
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
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_datetime">
	<param name="DetailDataID"			value="gcds_print">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"					value="false">
  <param name="PrintSetupDlgFlag" value="true">
	<param name="Format"						value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=494 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� ��' ,left=614 ,top=101 ,right=1437 ,bottom=161 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='KISU2', left=590, top=238, right=1468, bottom=286, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='KISU1', left=590, top=191, right=1468, bottom=241, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=71 ,top=339 ,right=1942 ,bottom=339 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURKISU', left=640, top=352, right=1201, bottom=418 ,mask='�� XX (��)��', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PREKISU', left=1344, top=352, right=1902, bottom=418 ,mask='�� XX (��)��', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FDCODENM', left=71, top=294, right=357, bottom=336, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page :#p of #t' ,left=1508 ,top=294 ,right=1931 ,bottom=336 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=74 ,top=492 ,right=1942 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=423 ,right=1942 ,bottom=423 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=82 ,top=352 ,right=553 ,bottom=487 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=339 ,right=71 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=339 ,right=564 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=339 ,right=1249 ,bottom=495 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�ݾ�' ,left=1344 ,top=437 ,right=1894 ,bottom=484 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ݾ�' ,left=640 ,top=437 ,right=1201 ,bottom=484 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1942 ,top=339 ,right=1942 ,bottom=492 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{decode(XRTTOT,0,,XRTTOT)}', left=918, top=0, right=1244, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(XLTTOT,0,,XLTTOT)}', left=572, top=0, right=902, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(YLTTOT,0,,YLTTOT)}', left=1259, top=3, right=1588, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PRTNAM', left=85, top=5, right=553, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=0 ,right=71 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=564 ,top=0 ,right=564 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1598 ,top=0 ,right=1598 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=0 ,right=1942 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1249 ,top=0 ,right=1249 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(YRTTOT,0,,YRTTOT)}', left=1606, top=0, right=1931, bottom=48, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1942 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2728 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=1558 ,top=3 ,right=1937 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=1945 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����Ͻ� :' ,left=77 ,top=3 ,right=243 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATES', left=249, top=3, right=455, bottom=69, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TIMES', left=460, top=3, right=619, bottom=69, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 