<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �渮ȸ�� - ���������ȸ
+ ���α׷� ID	:  A080006.html
+ �� �� �� ��	:  ������� ��ȸ �� ��� ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a080006_s1
-----------------------------------------------------------------------------
+ �� �� �� �� :	���Ѻ���
+ ��   ��  �� : �̹���
+ �� �� �� �� : 2006.10.31
------------------------------------------------------------------------------>
<html>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>���������ȸ</title>


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
var gs_userid = gusrid;		
var gs_fdcode = gfdcode;	//�����ڵ�
var gs_deptcd = gdeptcd;	//�μ��ڵ�
var gs_deptnm = gdeptnm;	//�μ���
var gs_usrnm  = gusrnm;		//����ڸ�
var gs_vendcd = "";	//������������
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_DispChk(0);
	ln_Before();
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(e){
	if(e=="1") {
		var s_temp = "BGTMM:STRING,FDCODE:STRING,ATCODE:STRING,ATKORNAM:STRING,SATCODE:STRING,SATNM:STRING,DEPTNM:STRING,"
							+ "BASICBGT:DECIMAL,ADDBGT:DECIMAL,CHGABGT:DECIMAL,CHGTBGT:DECIMAL,DEPTBGT:DECIMAL,REALBGT:DECIMAL,RESULTS:DECIMAL,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING,FSREFCD:STRING,TOTRES:DECIMAL";
		gcds_print1.SetDataHeader(s_temp);
	} else if(e=="2") {
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ATCODE:STRING,"
							+ "ATKORNAM:STRING,FSWRKDIV:STRING,SATNM:STRING,COMNM:STRING,REMARK:STRING,"
							+ "DEAMT:DECIMAL,CRAMT:DECIMAL,FSSTAT:STRING,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING";
		gcds_print2.SetDataHeader(s_temp);
	} else if(e=="3") {
		var s_temp = "FDCODE:STRING,BGTYY:STRING,BGTMM:STRINg,BGTDIV:STRINg,BGTDPT:STRING,"
					    + "DEPTNM:STRING,ATCODE:STRING,ATKORNAM:STRING,SATCODE:STRING,SATNM:STRING," 
							+ "INITBGT:DECIMAL,BASICBGT:DECIMAL,ADDBGT:DECIMAL,CHGABGT:DECIMAL,CHGTBGT:DECIMAL,DEPTBGT:DECIMAL,REALBGT:DECIMAL,RESULTS:DECIMAL,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING";
		gcds_print3.SetDataHeader(s_temp);
	} else if(e=="4") {
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ATCODE:STRING,"
							+ "DEPTNM:STRING,COMNM:STRING,FSWRKDIV:STRING,REMARK:STRING,DEAMT:DECIMAL," 
							+ "CRAMT:DECIMAL,FSSTAT:STRING,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING";
		gcds_print4.SetDataHeader(s_temp);
	}else if(e=="5") {  // �߰� ������ 2007-12-20
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ATCODE:STRING,"
							+ "DEPTNM:STRING,COMNM:STRING,FSWRKDIV:STRING,REMARK:STRING,DEAMT:DECIMAL," 
							+ "CRAMT:DECIMAL,FSSTAT:STRING,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING";
		gcds_print5.SetDataHeader(s_temp);
	}else if(e=="6") {  // �߰� ������ 2007-12-20
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ATCODE:STRING,"
							+ "DEPTNM:STRING,COMNM:STRING,FSWRKDIV:STRING,REMARK:STRING,DEAMT:DECIMAL," 
							+ "CRAMT:DECIMAL,FSSTAT:STRING,"
							+ "SFDCODE:STRING,BGTYY:STRING,BGTDIV:STRING,BGTDPT:STRING";
		gcds_print6.SetDataHeader(s_temp);
	}

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(s){
	if(s=="01") {
		var str1  = gclx_sfdcode1.BindColVal;			//�����ڵ� 
		var str2  = gcem_bgtyy1.text;						//����⵵ 
		var str3  = fn_trim(gcem_bgtmm1.text);			//�����fr
		var str4  = fn_trim(gcem_bgtmm1_1.text);		//�����to 
		var str5  = gclx_bgtdiv1.BindColVal;				//��û���� 
		var str6  = gcem_bgtdept1.text;						//��û�μ� 
		var str7  = txt_atcodenm1.value;					//������   
		var str8  = gcem_atcode1.text;						//�����ڵ� 
		var str9  = gclx_satcode1.BindColVal;			//����   
		var str10 = gcem_wongacd1.Text ;		//�����׸��ڵ� --> �߰� �����ڵ�� ... ������ 2007-12-24
		

		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s1"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9
											+ "&v_str10="+str10;
		
		//alert("�������������  :"+str1+"/"+str2+"/"+str3+"/"+str4+"/"+str5+"/"+str6+"/"+str7+"/"+str8+"/"+str9+"/"+str10);
		
		gcds_data1.Reset();

	}else if(s=="02") {
		
		var str1  = gclx_sfdcode2.BindColVal;		//�����ڵ� 
		var str2  = gcem_bgtyy2.text;						//����⵵ 
		var str3  = gcem_bgtmm2.text;						//�����fr
		var str4  = gcem_bgtmm2_1.text;					//�����to 
		var str5  = gclx_bgtdiv2.BindColVal;		//��û���� 
		var str6  = gcem_bgtdept2.text;				//��û�μ� 
		var str7  = txt_atcodenm2.value;				//������   
		var str8  = gcem_atcode2.text;					//�����ڵ� 
		var str9  = gclx_satcode2.BindColVal;		//����   
		var str10 = gcem_wongacd2.Text;				//�����׸��ڵ� ->    ����������������� �׸��� Ŭ���ؼ� ����쿡�� ���� ������..
		var str11 = gclx_bgtgubun2.BindColVal;		//��ǥ���� 

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9
											+ "&v_str10="+str10+"&v_str11="+str11;

		//alert("���������� : "+str1+"/"+str2+"/"+str3+"/"+str4+"/"+str5+"/"+str6+"/"+str7+"/"+str8+"/"+str9+"/"+str10+"/"+str11);						
		gcds_data2.Reset();

	}else if(s=="03") {
		var str1 = gclx_sfdcode3.BindColVal;	//�����ڵ� 
		var str2 = gcem_bgtyy3.text;					//����⵵ 
		var str3 = gcem_bgtmm3.text;					//�����fr
		var str4 = gcem_bgtmm3_1.text;				//�����to
		var str5 = gclx_bgtdiv3.BindColVal;		//��û���� 
		var str6 = gcem_bgtdept3.text;				//��û�μ� 
		var str7 = txt_atcodenm3.value;				//������   
		var str8 = gcem_atcode3.text;					//�����ڵ� 
		var str9 = gclx_satcode3.BindColVal;	//����   
		var str10 = gcem_wongacd3.Text ;		//�����׸��ڵ� --> �߰� �����ڵ�� ... ������ 2007-12-26

		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s3"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9+"&v_str10="+str10;
		//alert("�μ��� �������   : "+str1+"/"+str2+"/"+str3+"/"+str4+"/"+str5+"/"+str6+"/"+str7+"/"+str8+"/"+str9+"/"+str10);
		gcds_data3.Reset();

	}else if(s=="04") {
		var str1  = gclx_sfdcode4.BindColVal;		//�����ڵ� 
		var str2  = gcem_bgtyy4.text;						//����⵵ 
		var str3  = gcem_bgtmm4.text;						//�����fr
		var str4  = gcem_bgtmm4_1.text;					//�����to 
		var str5  = gclx_bgtdiv4.BindColVal;		//��û���� 
		var str6  = gcem_bgtdept4.text;		//��û�μ� 
		var str7  = txt_atcodenm4.value;				//������   
		var str8  = gcem_atcode4.text;					//�����ڵ� 
		var str9  = gclx_satcode4.BindColVal;		//����   
		//var str10 = gclx_fsrefcd4.BindColVal;	  //�����׸��ڵ�
		var str10 = gcem_wongacd4.Text;				//�����׸��ڵ� ->    ����������������� �׸��� Ŭ���ؼ� ����쿡�� ���� ������..
		var str11 = gclx_bgtgubun2.BindColVal;	//��ǥ���� 

		gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s2"
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9
											+ "&v_str10="+str10+"&v_str11="+str11;
		//alert("�μ��� ����    : "+str1+"/"+str2+"/"+str3+"/"+str4+"/"+str5+"/"+str6+"/"+str7+"/"+str8+"/"+str9+"/"+str10+"/"+str11);
		gcds_data4.Reset();

	}else if(s=="05") {  // �߰� ������ 2007-12-20
		var str1 = gclx_sfdcode5.BindColVal;	//�����ڵ� 
		var str2 = gcem_bgtyy5.text;					//����⵵ 
		var str3 = gcem_bgtmm5.text;					//�����fr
		var str4 = gcem_bgtmm5_1.text;				//�����to
		var str5 = gclx_bgtdiv5.BindColVal;		//��û���� 
		var str6 = gcem_bgtdept5.text;		//��û�μ� 
		var str7 = txt_atcodenm5.value;				//������   
		var str8 = gcem_atcode5.text;					//�����ڵ� 
		var str9 = gclx_satcode5.BindColVal;	//����   

		gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s3"   // �����ؾ��� ���� �� ������ ..2007-12-20
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9;
		gcds_data5.Reset();
	}else if(s=="06") {  // �߰� ������ 2007-12-20
		var str1  = gclx_sfdcode6.BindColVal;		//�����ڵ� 
		var str2  = gcem_bgtyy6.text;						//����⵵ 
		var str3  = gcem_bgtmm6.text;						//�����fr
		var str4  = gcem_bgtmm6_1.text;					//�����to 
		var str5  = gclx_bgtdiv6.BindColVal;		//��û���� 
		var str6  = gcem_bgtdept6.text;		//��û�μ� 
		var str7  = txt_atcodenm6.value;				//������   
		var str8  = gcem_atcode6.text;					//�����ڵ� 
		var str9  = gclx_satcode6.BindColVal;		//����   
		var str10 = gclx_fsrefcd6.BindColVal;	  //�����׸��ڵ�
		var str11 = gclx_bgtgubun3.BindColVal;	//��ǥ���� 

		gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s2"    // �����ؾ��� ���� �� ������ ..2007-12-20
											+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
											+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9
											+ "&v_str10="+str10+"&v_str11="+str11;
		gcds_data6.Reset();
	}
}

/******************************************************************************
	Description : ��ȸ(����������)
******************************************************************************/
function ln_Query2(e){   // Search�غ� ��� ������� �ʳ׿�........������. 

	var str1  = gclx_sfdcode2.BindColVal;		//�����ڵ� 
	var str2  = gcem_bgtyy2.text;						//����⵵ 
	var str3  = gcem_bgtmm2.text;						//�����fr
	var str4  = gcem_bgtmm2_1.text;					//�����to 
	var str5  = gclx_bgtdiv2.BindColVal;		//��û���� 
	var str6  = gcem_bgtdept2.text;		//��û�μ� 
	var str7  = txt_atcodenm2.value;				//������   
	var str8  = gcem_atcode2.text;					//�����ڵ� 
	var str9  = gclx_satcode2.BindColVal;		//����   
	var str10 = gclx_fsrefcd2.BindColVal;	  //�����׸��ڵ�
	var str11 = gclx_bgtgubun1.BindColVal;	//��ǥ���� 

	gcds_temp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080006_s2"
										+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+str3
										+ "&v_str4="+str4+"&v_str5="+str5+"&v_str6="+str6
										+ "&v_str7="+str7+"&v_str8="+str8+"&v_str9="+str9
										+ "&v_str10="+str10+"&v_str11="+str11;
	gcds_temp2.Reset();
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
function ln_Print(e){
	if(e=="1") {
		if(gcds_data1.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			gcds_print1.clearall();
			ln_SetDataHeader("1");
			gcds_print1.ImportData(gcds_data1.ExportData(1,gcds_data1.countrow,false));
			if (gcds_print1.countrow>0) {
				for(i=1;i<=gcds_print1.countrow;i++){
				gcds_print1.namevalue(i,"BGTMM")= gcds_data1.namevalue(i,"BGTMM") ; 
				gcds_print1.namevalue(i,"ATKORNAM")= gcds_data1.namevalue(i,"ATKORNAM") ; 
				gcds_print1.namevalue(i,"SATNM")= gcds_data1.namevalue(i,"SATNM") ; 
				gcds_print1.namevalue(i,"DEPTNM")= gcds_data1.namevalue(i,"DEPTNM") ; 
				gcds_print1.namevalue(i,"BASICBGT")= gcds_data1.namevalue(i,"BASICBGT") ; 
				gcds_print1.namevalue(i,"ADDBGT")= gcds_data1.namevalue(i,"ADDBGT") ; 
				gcds_print1.namevalue(i,"CHGABGT")= gcds_data1.namevalue(i,"CHGABGT") ; 
				gcds_print1.namevalue(i,"CHGTBGT")= gcds_data1.namevalue(i,"CHGTBGT") ; 
				gcds_print1.namevalue(i,"DEPTBGT")= gcds_data1.namevalue(i,"DEPTBGT") ; 
				gcds_print1.namevalue(i,"REALBGT")= gcds_data1.namevalue(i,"REALBGT") ; 
				//gcds_print1.namevalue(i,"TOTRES")= gcds_data1.namevalue(i,"TOTRES") ; 
				gcds_print1.namevalue(i,"TOTRES")= gcds_data1.namevalue(i,"TOTRES") ; 
				gcds_print1.namevalue(i,"FSREFCD")= gcds_data1.namevalue(i,"FSREFCD") ;
				
				
				gcds_print1.namevalue(i,"SFDCODE") = gclx_sfdcode1.ValueByColumn("FDCODE",gclx_sfdcode1.ValueOfIndex("FDCODE", gclx_sfdcode1.Index),"FDNAME");
				gcds_print1.namevalue(i,"BGTYY")  = gcem_bgtyy1.text+gcem_bgtmm1.text+gcem_bgtmm1_1.text;
				gcds_print1.namevalue(i,"BGTDIV")  = gclx_bgtdiv1.ValueByColumn("BGTDIVCD",gclx_bgtdiv1.ValueOfIndex("BGTDIVCD", gclx_bgtdiv1.Index),"BGTNAM");
				gcds_print1.namevalue(i,"BGTDPT") = gcem_bgtdept1.text;
				
				}
			}
			gcrp_print1.preview();
		}
	} else if(e=="2") {
		if(gcds_data2.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("2");
			gcds_print2.ImportData(gcds_data2.ExportData(1,gcds_data2.countrow,false));
			if (gcds_print2.countrow>0) {
				for(i=1;i<=gcds_print2.countrow;i++){
					gcds_print2.namevalue(i,"SFDCODE") = gclx_sfdcode2.ValueByColumn("FDCODE",
												gclx_sfdcode2.ValueOfIndex("FDCODE", gclx_sfdcode2.Index),"FDNAME");
					gcds_print2.namevalue(i,"BGTYY")  = gcem_bgtyy2.text+gcem_bgtmm2.text+gcem_bgtmm2_1.text;
					gcds_print2.namevalue(i,"BGTDIV")  = gclx_bgtdiv2.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv2.ValueOfIndex("BGTDIVCD", gclx_bgtdiv2.Index),"BGTNAM");
					gcds_print2.namevalue(i,"BGTDPT") = gcem_bgtdept2.text;//ValueByColumn("BGTDEPT",
//												gclx_bgtdpt2.ValueOfIndex("BGTDEPT", gclx_bgtdpt2.Index),"BGTNAM");
					if(gcds_print2.namevalue(i,"FSSTAT") == "Y")
						gcds_print2.namevalue(i,"FSSTAT") = "����Ϸ�";
					else if(gcds_print2.namevalue(i,"FSSTAT") == "R")
						gcds_print2.namevalue(i,"FSSTAT") = "�����û";
					else if(gcds_print2.namevalue(i,"FSSTAT") == "N")
						gcds_print2.namevalue(i,"FSSTAT") = "������";
					else if(gcds_print2.namevalue(i,"FSSTAT") == "B")
						gcds_print2.namevalue(i,"FSSTAT") = "�ݼ�";
				}
			}
			gcrp_print2.preview();
		}
	} else if(e=="3") {
		if(gcds_data3.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("3");
			gcds_print3.ImportData(gcds_data3.ExportData(1,gcds_data3.countrow,false));
			if (gcds_print3.countrow>0) {
				for(i=1;i<=gcds_print3.countrow;i++){
					gcds_print3.namevalue(i,"SFDCODE") = gclx_sfdcode3.ValueByColumn("FDCODE",
												gclx_sfdcode3.ValueOfIndex("FDCODE", gclx_sfdcode3.Index),"FDNAME");
					gcds_print3.namevalue(i,"BGTYY")  = gcem_bgtyy3.text+gcem_bgtmm3.text+gcem_bgtmm3_1.text;
					gcds_print3.namevalue(i,"BGTDIV")  = gclx_bgtdiv3.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv3.ValueOfIndex("BGTDIVCD", gclx_bgtdiv3.Index),"BGTNAM");
					gcds_print3.namevalue(i,"BGTDPT") = gcem_bgtdept3.text;//ValueByColumn("BGTDEPT",
//												gclx_bgtdpt3.ValueOfIndex("BGTDEPT", gclx_bgtdpt3.Index),"BGTNAM");
				}
			}
			gcrp_print3.preview();
		}
	} else if(e=="4") {
		if(gcds_data4.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("4");
			gcds_print4.ImportData(gcds_data4.ExportData(1,gcds_data4.countrow,false));
			if (gcds_print4.countrow>0) {
				for(i=1;i<=gcds_print4.countrow;i++){
					gcds_print4.namevalue(i,"SFDCODE") = gclx_sfdcode4.ValueByColumn("FDCODE",
												gclx_sfdcode4.ValueOfIndex("FDCODE", gclx_sfdcode4.Index),"FDNAME");
					gcds_print4.namevalue(i,"BGTYY")  = gcem_bgtyy4.text+gcem_bgtmm4.text+gcem_bgtmm4_1.text;
					gcds_print4.namevalue(i,"BGTDIV")  = gclx_bgtdiv4.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv4.ValueOfIndex("BGTDIVCD", gclx_bgtdiv4.Index),"BGTNAM");
					gcds_print4.namevalue(i,"BGTDPT") = gcem_bgtdept4.text;//ValueByColumn("BGTDEPT",
//												gclx_bgtdpt4.ValueOfIndex("BGTDEPT", gclx_bgtdpt4.Index),"BGTNAM");
					if(gcds_print4.namevalue(i,"FSSTAT") == "Y")
						gcds_print4.namevalue(i,"FSSTAT") = "����Ϸ�";
					else if(gcds_print4.namevalue(i,"FSSTAT") == "R")
						gcds_print4.namevalue(i,"FSSTAT") = "�����û";
					else if(gcds_print4.namevalue(i,"FSSTAT") == "N")
						gcds_print4.namevalue(i,"FSSTAT") = "������";
					else if(gcds_print4.namevalue(i,"FSSTAT") == "B")
						gcds_print4.namevalue(i,"FSSTAT") = "�ݼ�";
				}
			}
			gcrp_print4.preview();
		}
	} else if(e=="5") {  // �߰� ������ 2007-12-20
		if(gcds_data5.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("5");
			gcds_print5.ImportData(gcds_data5.ExportData(1,gcds_data5.countrow,false));
			if (gcds_data5.countrow>0) {
				for(i=1;i<=gcds_data5.countrow;i++){
					gcds_data5.namevalue(i,"SFDCODE") = gclx_sfdcode5.ValueByColumn("FDCODE",
												gclx_sfdcode5.ValueOfIndex("FDCODE", gclx_sfdcode5.Index),"FDNAME");
					gcds_data5.namevalue(i,"BGTYY")  = gcem_bgtyy5.text+gcem_bgtmm5.text+gcem_bgtmm5_1.text;
					gcds_data5.namevalue(i,"BGTDIV")  = gclx_bgtdiv5.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv5.ValueOfIndex("BGTDIVCD", gclx_bgtdiv5.Index),"BGTNAM");
					gcds_data5.namevalue(i,"BGTDPT") = gcem_bgtdept5.text;//ValueByColumn("BGTDEPT",
//												gclx_bgtdpt4.ValueOfIndex("BGTDEPT", gclx_bgtdpt4.Index),"BGTNAM");
					if(gcds_data5.namevalue(i,"FSSTAT") == "Y")
						gcds_data5.namevalue(i,"FSSTAT") = "����Ϸ�";
					else if(gcds_data5.namevalue(i,"FSSTAT") == "R")
						gcds_data5.namevalue(i,"FSSTAT") = "�����û";
					else if(gcds_data5.namevalue(i,"FSSTAT") == "N")
						gcds_data5.namevalue(i,"FSSTAT") = "������";
					else if(gcds_data5.namevalue(i,"FSSTAT") == "B")
						gcds_data5.namevalue(i,"FSSTAT") = "�ݼ�";
				}
			}
			gcrp_print5.preview();
		}
	} else if(e=="6") {   // �߰� ������ 2007-12-20
		if(gcds_data6.countrow<1) {
			alert("����� ������ �����ϴ�.");
		}else{
			ln_SetDataHeader("6");
			gcds_print6.ImportData(gcds_data6.ExportData(1,gcds_data6.countrow,false));
			if (gcds_print6.countrow>0) {
				for(i=1;i<=gcds_print6.countrow;i++){
					gcds_print6.namevalue(i,"SFDCODE") = gclx_sfdcode6.ValueByColumn("FDCODE",
												gclx_sfdcode6.ValueOfIndex("FDCODE", gclx_sfdcode6.Index),"FDNAME");
					gcds_print6.namevalue(i,"BGTYY")  = gcem_bgtyy6.text+gcem_bgtmm6.text+gcem_bgtmm6_1.text;
					gcds_print6.namevalue(i,"BGTDIV")  = gclx_bgtdiv6.ValueByColumn("BGTDIVCD",
												gclx_bgtdiv6.ValueOfIndex("BGTDIVCD", gclx_bgtdiv6.Index),"BGTNAM");
					gcds_print6.namevalue(i,"BGTDPT") = gcem_bgtdept6.text;//ValueByColumn("BGTDEPT",
//												gclx_bgtdpt3.ValueOfIndex("BGTDEPT", gclx_bgtdpt3.Index),"BGTNAM");
				}
			}
			gcrp_print6.preview();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
  if(e=="1") {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('�������������');
	}else if(e=="2") {
		if (gcds_data2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp02.RunExcel('����������');
	}else if(e=="3") {
		if (gcds_data3.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp03.RunExcel('�μ����������');
	}else if(e=="4") {
		if (gcds_data4.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp04.RunExcel('�μ�������');

	}else if(e=="5") {  // �߰� ������ 2007-12-20
		if (gcds_data5.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp05.RunExcel('�������������');
	}else if(e=="6") { // �߰� ������ 2007-12-20
		if (gcds_data6.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp06.RunExcel('����������');
	}
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_bgtyy1.text = gs_date3;
	gcem_bgtyy2.text = gs_date3;
	gcem_bgtyy3.text = gs_date3;
	gcem_bgtyy4.text = gs_date3;

	gcem_bgtyy5.text = gs_date3;// �⵵  �߰� ������ 2007-12-20
	gcem_bgtyy6.text = gs_date3;// �⵵  �߰� ������ 2007-12-20



	gcem_bgtmm1.text   = gs_date4;
	gcem_bgtmm1_1.text = gs_date4;
	gcem_bgtmm2.text   = gs_date4;
	gcem_bgtmm2_1.text = gs_date4;
	gcem_bgtmm3.text	 = gs_date4;
	gcem_bgtmm3_1.text = gs_date4;
	gcem_bgtmm4.text   = gs_date4;
	gcem_bgtmm4_1.text = gs_date4;

	gcem_bgtmm5.text   = gs_date4; // ������ ������� : Fr�� �߰� ������ 2007-12-20
	gcem_bgtmm5_1.text = gs_date4;//  ������ ������� : To�� �߰� ������ 2007-12-20 
	gcem_bgtmm6.text   = gs_date4; // ���������� : Fr�� �߰� ������ 2007-12-20
	gcem_bgtmm6_1.text = gs_date4;// ���������� : To�� �߰� ������ 2007-12-20 



	gclx_bgtgubun1.bindcolval="";  //�ּ� ó�� ������ 2007-12-26  
	gclx_bgtgubun2.bindcolval="Y";
	gclx_bgtgubun3.bindcolval="Y";// ����������:��ǥ���� �߰� ������ 2007-12-20



	gclx_satcode1.enable = false;
	gclx_satcode2.enable = false;
	gclx_satcode3.enable = false;
	gclx_satcode4.enable = false;

	gclx_satcode5.enable = false;//�������������;���� �߰� ������ 2007-12-20
	gclx_satcode6.enable = false;//���������� ;���� �߰� ������ 2007-12-20


	if(gs_deptcd==null){	//ȸ�谳����
		gs_deptcd = "C000";
	}

	if(gs_deptcd!="C000"){//����ںμ�
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str3="+gs_deptcd+"&v_str4=Y";
		gcds_deptemp.Reset();
	}else{
		gcds_deptemp.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str3="+gs_deptcd+"&v_str4=N";
		gcds_deptemp.Reset();
	}

	/*1 .������������� �׸� ��ȸ**************************************************/
	
	//�����ڵ�[�˻�]
	gcds_sfdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode1.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv1.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv1.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt1.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt1.Reset();
	}

	//����Ÿ��
	gcds_bgtmact1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138" ;
	gcds_bgtmact1.Reset();
	
	/*2 .���������� �׸� ��ȸ**************************************************/
	//�����ڵ�[�˻�]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv2.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv2.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt2.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt2.Reset();
	}

	//����Ÿ��
	gcds_bgtmact2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138"; 
	gcds_bgtmact2.Reset();

	/*3.�μ���������� �׸� ��ȸ**************************************************/
	//�����ڵ�[�˻�]
	gcds_sfdcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode3.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv3.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv3.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt3.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt3.Reset();
	}

	//����Ÿ��
	gcds_bgtmact3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138"; 
	gcds_bgtmact3.Reset();




	/*4.�μ������� �׸� ��ȸ**************************************************/
	//�����ڵ�[�˻�]
	gcds_sfdcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode4.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv4.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv4.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt4.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt4.Reset();
	}

	//����Ÿ��--> ���������� �ϴܿ��� �ּ�ó�� �߳�..
	gcds_bgtmact4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138"; 
	gcds_bgtmact4.Reset();





	// �߰� �� ���� 1============================================================
	/*5. ������������� �׸� ��ȸ**************************************************/
	//�����ڵ�[�˻�]
	gcds_sfdcode5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode5.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv5.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv5.Reset();
	}
	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt5.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt5.Reset();
	}
	//����Ÿ��.......???1  
	//gcds_bgtmact5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138"; 
	//gcds_bgtmact5.Reset();

	/*6. ���������� �׸� ��ȸ**************************************************/
	//�����ڵ�[�˻�]
	gcds_sfdcode6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode6.Reset();

	if(gs_vendcd!="1200"){//��û����[�˻�]-�Ϲݺμ�
		gcds_bgtdiv6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=Y&v_str4=N";
		gcds_bgtdiv6.Reset();
	}else{	//��û����[�˻�]-������������
		gcds_bgtdiv6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=Y&v_str4=Y";
		gcds_bgtdiv6.Reset();
	}

	if(gs_vendcd!="1200"){//��û�μ�[�˻�]-�Ϲݺμ�
		gcds_bgtdpt6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1="+gs_deptcd.substring(0,1)+"&v_str2=N&v_str4=N";
		gcds_bgtdpt6.Reset();
	}else{	//��û�μ�-������������
		gcds_bgtdpt6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a080001_s3?v_str1=&v_str2=N&v_str4=Y";
		gcds_bgtdpt6.Reset();
	}

	//����Ÿ��......???2
	//gcds_bgtmact6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2138"; 
	//gcds_bgtmact6.Reset();

	// �߰� �� ��1===============================================================



	//���� 1
	gcds_satcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode1.Reset();

	//���� 2
	gcds_satcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode2.Reset();

	//���� 3
	gcds_satcode3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode3.Reset();

	//���� 4
	gcds_satcode4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode4.Reset();

	//���� 5  �߰� ������ 2007-12-20 
	gcds_satcode5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode5.Reset();

	//���� 6 �߰� ������ 2007-12-20
	gcds_satcode6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=x9999";
	gcds_satcode6.Reset();


  gcds_depttemp5_lookup.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2=";
  gcds_depttemp5_lookup.Reset();

}

/******************************************************************************************
	Description : ��ȸ - �����׸� �ڵ� ��ȸ
******************************************************************************************/
function ln_RefQuery(e,e1){
	eval("gcds_fsrefcd"+e1).DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	eval("gcds_fsrefcd"+e1).Reset();
}

/******************************************************************************************
	Description : ��ȸ - �����ڵ� ��ȸ
******************************************************************************************/
function ln_SatQuery(e,e1){
	if(e!="0003"){
		eval("gclx_satcode"+e1).enable = true;
		eval("gcds_satcode"+e1).DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+e;
		eval("gcds_satcode"+e1).Reset();
	}else{
			eval("gclx_satcode"+e1).enable = false;
		/*
			eval("gcds_satcode"+e1).InsertRow(1);
			eval("gcds_satcode"+e1).NameValue(1,"CDCODE")="00";
			eval("gcds_satcode"+e1).NameValue(1,"CDNAM")="00";
		*/
			eval("gclx_satcode"+e1).index = 0;
	}
}

/***********************************************************************************************
	Description : �����ڵ� ã��
	parameter   : p2===> fr, to- �����ڵ� : apr- ���� : up - �������� : down - �����ڵ�
**********************************************************************************************/
function ln_Popup(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	arrParam[1]="B";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="1") {
			gcem_atcode1.text   = arrParam[0];
			txt_atcodenm1.value = arrParam[1];
			ln_RefQuery(arrParam[0],'1');	//�����׸� ��ȸ
		}else if(e=="2") {
			gcem_atcode2.text   = arrParam[0];
			txt_atcodenm2.value = arrParam[1];
			ln_RefQuery(arrParam[0],'2');	//�����׸� ��ȸ
		}else if(e=="3") {
			gcem_atcode3.text   = arrParam[0];
			txt_atcodenm3.value = arrParam[1];
			ln_RefQuery(arrParam[0],'3');	//�����׸� ��ȸ
		}else if(e=="4") {
			gcem_atcode4.text   = arrParam[0];
			txt_atcodenm4.value = arrParam[1];
			ln_RefQuery(arrParam[0],'4');	//�����׸� ��ȸ
		}else if(e=="5") {   // �߰� ������ 2007-12-20
			gcem_atcode5.text   = arrParam[0];
			txt_atcodenm5.value = arrParam[1];
			ln_RefQuery(arrParam[0],'5');	//�����׸� ��ȸ
		}else if(e=="6") {  // �߰� ������ 2007-12-20
			gcem_atcode6.text   = arrParam[0];
			txt_atcodenm6.value = arrParam[1];
			ln_RefQuery(arrParam[0],'6');	//�����׸� ��ȸ
		}
	} else {
		if(e=="1") {
			gcem_atcode1.text = "";
			txt_atcodenm1.value ="";
		}else if(e=="2") {
			gcem_atcode2.text = "";
			txt_atcodenm2.value ="";
		}else if(e=="3") {
			gcem_atcode3.text = "";
			txt_atcodenm3.value ="";
		}else if(e=="4") {
			gcem_atcode4.text = "";
			txt_atcodenm4.value ="";
		}else if(e=="5") {  // �߰� ������ 2007-12-20
			gcem_atcode5.text = "";
			txt_atcodenm5.value ="";
		}else if(e=="6") {  // �߰� ������ 2007-12-20
			gcem_atcode6.text = "";
			txt_atcodenm6.value ="";
		}
	}
}


//ln_Popupwon
function ln_Popupwon(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	 arrParam[0]="0030";//�����ڵ�
	 arrParam[1]="";
	 arrParam[2]="";
	 arrParam[3]="";

	strURL =  "/Account/jsp/commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);



	if (arrResult != null) {
		arrParam = arrResult.split(";");
		if(e=="1") {
			gcem_wonganm1.Text = arrParam[1];
			gcem_wongacd1.Text  = arrParam[0];
		}else if(e=="2") {
			gcem_wonganm2.Text = arrParam[1];
			gcem_wongacd2.Text  = arrParam[0];
		}else if(e=="3") {
			gcem_wonganm3.Text = arrParam[1];
			gcem_wongacd3.Text  = arrParam[0];
		}else if(e=="4") {
			gcem_wonganm4.Text = arrParam[1];
			gcem_wongacd4.Text  = arrParam[0];
		}else if(e=="5") {   
			gcem_wonganm5.Text = arrParam[1];
			gcem_wongacd5.Text  = arrParam[0];
		}else if(e=="6") {  
			gcem_wonganm6.Text = arrParam[1];
			gcem_wongacd6.Text  = arrParam[0];
		}
	} else {
		if(e=="1") {
			gcem_wonganm1.Text = "";
			gcem_wongacd1.Text  = "";
		}else if(e=="2") {
			gcem_wonganm2.Text = "";
			gcem_wongacd2.Text  = "";
		}else if(e=="3") {
			gcem_wonganm3.Text = "";
			gcem_wongacd3.Text  = "";
		}else if(e=="4") {
			gcem_wonganm4.Text = "";
			gcem_wongacd4.Text  = "";
		}else if(e=="5") {  
			gcem_wonganm5.Text = "";
			gcem_wongacd5.Text  = "";
		}else if(e=="6") {  
			gcem_wonganm6.Text = "";
			gcem_wongacd6.Text  = "";
		}
	}
}

/***********************************************************************************************
	Description : ��ǥ��ȸ
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_TaxQuery(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(e=="01") {
		arrParam[0] = gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE");
		arrParam[1] = gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT");
		arrParam[2] = gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else if(e=="02"){
		arrParam[0] = gcds_data4.namevalue(gcds_data4.rowposition,"FDCODE");
		arrParam[1] = gcds_data4.namevalue(gcds_data4.rowposition,"FSDAT");
		arrParam[2] = gcds_data4.namevalue(gcds_data4.rowposition,"FSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}else if(e=="03"){ // �߰� ������ 2007-12-21
		arrParam[0] = gcds_data6.namevalue(gcds_data6.rowposition,"FDCODE");
		arrParam[1] = gcds_data6.namevalue(gcds_data6.rowposition,"FSDAT");
		arrParam[2] = gcds_data6.namevalue(gcds_data6.rowposition,"FSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:595px;dialogTop:150px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-�Ϻ��ڵ�, 1-�����׸�
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5","div_disp6");// �������������& ����������   �߰�
	for(var i=0;i<=5;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}


function ln_Popup1(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam1.text;
	arrParam[1]=gcem_bgtdept1.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam1.text = arrParam[1];
		gcem_bgtdept1.text = arrParam[0];
		gclx_bgtdiv1.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup2(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam2.text;
	arrParam[1]=gcem_bgtdept2.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam2.text = arrParam[1];
		gcem_bgtdept2.text = arrParam[0];
		gclx_bgtdiv2.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}

function ln_Popup3(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam3.text;
	arrParam[1]=gcem_bgtdept3.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam3.text = arrParam[1];
		gcem_bgtdept3.text = arrParam[0];
		gclx_bgtdiv3.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


function ln_Popup4(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam4.text;
	arrParam[1]=gcem_bgtdept4.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam4.text = arrParam[1];
		gcem_bgtdept4.text = arrParam[0];
		gclx_bgtdiv4.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}




function ln_Popup5(){/// �߰� ������ 2007-12-20
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam5.text;
	arrParam[1]=gcem_bgtdept5.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam5.text = arrParam[1];
		gcem_bgtdept5.text = arrParam[0];
		gclx_bgtdiv5.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
	}
}


 
function ln_Popup6(){  // �߰� ������ 2007-12-20
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./hcdept_popup1.jsp";
	arrParam[0]=gcem_bgtnam6.text;
	arrParam[1]=gcem_bgtdept6.text;
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_bgtnam6.text = arrParam[1];
		gcem_bgtdept6.text = arrParam[0];
		gclx_bgtdiv6.bindcolval = arrParam[2];
	} else {
//		gcem_bgtnam.text = "";
//		gcem_bgtdept.text = "";
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

<comment id="__NSID__"><object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- �߰� ������ ������������� -->

<comment id="__NSID__"><object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- �߰� ������ ������ ����  -->



<comment id="__NSID__"><object  id=gcds_sfdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_sfdcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_sfdcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!-- ������������� ;���� -->

<comment id="__NSID__"><object  id=gcds_sfdcode6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!-- ���������� ;���� -->



<comment id="__NSID__"><object  id=gcds_bgtdpt1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdpt4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdpt5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->

<comment id="__NSID__"><object  id=gcds_bgtdpt6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->


<comment id="__NSID__"><object  id=gcds_bgtdiv1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_bgtdiv2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtdiv5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->

<comment id="__NSID__"><object  id=gcds_bgtdiv6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->



<comment id="__NSID__"><object  id=gcds_bgtmact1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtmact2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtmact3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtmact4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_bgtmact5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!--  �߰� ������ 2007-12-21-->

<comment id="__NSID__"><object  id=gcds_bgtmact6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script><!--  �߰� ������ 2007-12-21-->




<comment id="__NSID__"><object  id=gcds_fsrefcd1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- ���� -->

<comment id="__NSID__"><object  id=gcds_fsrefcd2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_fsrefcd5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->

<comment id="__NSID__"><object  id=gcds_fsrefcd6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->



<comment id="__NSID__"><object  id=gcds_satcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_satcode5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->

<comment id="__NSID__"><object  id=gcds_satcode6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰�  -->


<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- ������ ����������� �����ڵ尡 ���� ��� �� ���� ������ �������� �ڵ尡 �Ѿ�鼭 �����ڵ���� ������. -->

<comment id="__NSID__"><object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- ������ ����������� �����ڵ尡 ���� ��� �� ���� ������ �������� �ڵ尡 �Ѿ�鼭 �����ڵ���� ������. -->


<comment id="__NSID__"><object  id=gcds_print1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_print4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰� -->

<comment id="__NSID__"><object  id=gcds_print6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!-- �߰�  -->



<comment id="__NSID__"><object  id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_deptemp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_depttemp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>
<comment id="__NSID__"><object  id=gcds_depttemp5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>


<comment id="__NSID__"><object  id=gcds_depttemp5_lookup classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script><!--  ln_before ������ �μ��������� �׸��忡�� ��û�μ� �ѷ���. -->


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

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

<script language="javascript" for="gcds_data4" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data4" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt04.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<!-- �߰�  -->
<script language="javascript" for="gcds_data5" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data5" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt05.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>


<!-- �߰� -->
<script language="javascript" for="gcds_data6" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	// document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data6" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	// document.all.LowerFrame.style.visibility="hidden";
	ft_cnt06.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) { 
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>



<script language="javascript" for="gcds_sfdcode1" event="onloadCompleted(row,colid)">
	gcds_sfdcode1.InsertRow(1);
	gcds_sfdcode1.NameValue(1,"FDCODE")="";
	gcds_sfdcode1.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode1.index=2;
	}else{
		gclx_sfdcode1.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode2" event="onloadCompleted(row,colid)">
	gcds_sfdcode2.InsertRow(1);
	gcds_sfdcode2.NameValue(1,"FDCODE")="";
	gcds_sfdcode2.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode2.index=2;
	}else{
		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode3" event="onloadCompleted(row,colid)">
	gcds_sfdcode3.InsertRow(1);
	gcds_sfdcode3.NameValue(1,"FDCODE")="";
	gcds_sfdcode3.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode3.index=2;
	}else{
		gclx_sfdcode3.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_sfdcode4" event="onloadCompleted(row,colid)">
	gcds_sfdcode4.InsertRow(1);
	gcds_sfdcode4.NameValue(1,"FDCODE")="";
	gcds_sfdcode4.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode4.index=2;
	}else{
		gclx_sfdcode4.bindcolval=gs_fdcode;
	}
</script>

<!-- �߰� ������  �������������; ����-->
<script language="javascript" for="gcds_sfdcode5" event="onloadCompleted(row,colid)">
	gcds_sfdcode5.InsertRow(1);
	gcds_sfdcode5.NameValue(1,"FDCODE")="";
	gcds_sfdcode5.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gcds_sfdcode5.index=2;
	}else{
		gcds_sfdcode5.bindcolval=gs_fdcode;
	}
</script>

<!-- �߰� ������ ���� ����������; ����-->
<script language="javascript" for="gcds_sfdcode6" event="onloadCompleted(row,colid)">
	gcds_sfdcode6.InsertRow(1);
	gcds_sfdcode6.NameValue(1,"FDCODE")="";
	gcds_sfdcode6.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
		gcds_sfdcode6.index=2;
	}else{
		gcds_sfdcode6.bindcolval=gs_fdcode;
	}
</script>



<script language="javascript" for="gcds_deptemp" event="onloadCompleted(row,colid)">
	gs_vendcd = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	if(gcds_deptemp.countrow>0){

		gcem_bgtnam1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept1.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
		gcem_bgtnam2.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept2.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
		gcem_bgtnam3.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept3.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
		gcem_bgtnam4.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");
		gcem_bgtdept4.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

		gcem_bgtnam5.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");  // �߰�  ������
		gcem_bgtdept5.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");
		gcem_bgtnam6.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTNAM");  // �߰� ������
		gcem_bgtdept6.text = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDEPT");

	}else {
  }
</script>


<script language="javascript" for="gcds_bgtdiv1" event="onloadCompleted(row,colid)">
	gcds_bgtdiv1.InsertRow(1);
	gcds_bgtdiv1.NameValue(1,"GBCD")="";
	gcds_bgtdiv1.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv1.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv1.index = 0;
</script>

<script language="javascript" for="gcds_bgtdiv2" event="onloadCompleted(row,colid)">
	gcds_bgtdiv2.InsertRow(1);
	gcds_bgtdiv2.NameValue(1,"GBCD")="";
	gcds_bgtdiv2.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv2.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv2.index = 0;
</script>

<script language="javascript" for="gcds_bgtdiv3" event="onloadCompleted(row,colid)">
	gcds_bgtdiv3.InsertRow(1);
	gcds_bgtdiv3.NameValue(1,"GBCD")="";
	gcds_bgtdiv3.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv3.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv3.index = 0;
</script>

<script language="javascript" for="gcds_bgtdiv4" event="onloadCompleted(row,colid)">
	gcds_bgtdiv4.InsertRow(1);
	gcds_bgtdiv4.NameValue(1,"GBCD")="";
	gcds_bgtdiv4.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv4.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv4.index = 0;
</script>

<!-- �߰� -->
<script language="javascript" for="gcds_bgtdiv5" event="onloadCompleted(row,colid)">
	gcds_bgtdiv5.InsertRow(1);
	gcds_bgtdiv5.NameValue(1,"GBCD")="";
	gcds_bgtdiv5.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv5.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv5.index = 0;
</script>

<!-- �߰�  -->
<script language="javascript" for="gcds_bgtdiv6" event="onloadCompleted(row,colid)">
	gcds_bgtdiv6.InsertRow(1);
	gcds_bgtdiv6.NameValue(1,"GBCD")="";
	gcds_bgtdiv6.NameValue(1,"CDREMARK")="";
	if(gcds_deptemp.countrow>0){
		gclx_bgtdiv6.bindcolval = gcds_deptemp.namevalue(gcds_deptemp.rowposition,"BGTDIVCD");
	}else gclx_bgtdiv6.index = 0;
</script>




<script language="javascript" for="gcds_fsrefcd1" event="onloadCompleted(row,colid)">
	gclx_fsrefcd1.index = 0;	/*����˻�*/
	var str1 = gcds_fsrefcd1.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'1');
</script>

<script language="javascript" for="gcds_fsrefcd2" event="onloadCompleted(row,colid)">
	gclx_fsrefcd2.index = 0;	/*����˻�*/
	var str1 = gcds_fsrefcd2.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'2');
</script>

<script language="javascript" for="gcds_fsrefcd3" event="onloadCompleted(row,colid)">
	gclx_fsrefcd3.index = 0;	/*����˻�*/
	var str1 = gcds_fsrefcd3.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'3');
</script>

<script language="javascript" for="gcds_fsrefcd4" event="onloadCompleted(row,colid)">
	gclx_fsrefcd4.index = 0;	/*����˻�*/
	var str1 = gcds_fsrefcd4.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'4');
</script>


<script language="javascript" for="gcds_fsrefcd5" event="onloadCompleted(row,colid)">
	gclx_fsrefcd5.index = 0;	/*����˻� �߰� ������ */
	var str1 = gcds_fsrefcd5.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'5');
</script>

<script language="javascript" for="gcds_fsrefcd6" event="onloadCompleted(row,colid)">
	gclx_fsrefcd6.index = 0;	/*����˻� �߰� ������*/
	var str1 = gcds_fsrefcd6.namevalue(row,"CDCODE");
	ln_SatQuery(str1,'6');
</script>




<script language="javascript" for="gcds_satcode1" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode1.enable = false;
/*
		gcds_satcode1.InsertRow(1);
		gcds_satcode1.NameValue(1,"CDCODE")="00";
		gcds_satcode1.NameValue(1,"CDNAM")="00";
*/
		gclx_satcode1.index = 0;
	}else{ 
		gcds_satcode1.InsertRow(1);
		gcds_satcode1.NameValue(1,"CDCODE")="";
		gcds_satcode1.NameValue(1,"CDNAM")="";
		gclx_satcode1.index = 0;
		gclx_satcode1.enable = true;
	}
</script>

<script language="javascript" for="gcds_satcode2" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode2.enable = false;
/*		gcds_satcode2.InsertRow(1);
		gcds_satcode2.NameValue(1,"CDCODE")="00";
		gcds_satcode2.NameValue(1,"CDNAM")="00";
*/		gclx_satcode2.index = 0;
	}else{ 
		gcds_satcode2.InsertRow(1);
		gcds_satcode2.NameValue(1,"CDCODE")="";
		gcds_satcode2.NameValue(1,"CDNAM")="";
		gclx_satcode2.index = 0;
		gclx_satcode2.enable = true;
	}
</script>

<script language="javascript" for="gcds_satcode3" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode3.enable = false;
/*		gcds_satcode3.InsertRow(1);
		gcds_satcode3.NameValue(1,"CDCODE")="00";
		gcds_satcode3.NameValue(1,"CDNAM")="00";
*/		gclx_satcode3.index = 0;
	}else{ 
		gcds_satcode3.InsertRow(1);
		gcds_satcode3.NameValue(1,"CDCODE")="";
		gcds_satcode3.NameValue(1,"CDNAM")="";
		gclx_satcode3.index = 0;
		gclx_satcode3.enable = true;
	}
</script>

<script language="javascript" for="gcds_satcode4" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode4.enable = false;
/*		gcds_satcode4.InsertRow(1);
		gcds_satcode4.NameValue(1,"CDCODE")="00";
		gcds_satcode4.NameValue(1,"CDNAM")="00";
*/		gclx_satcode4.index = 0;
	}else{ 
		gcds_satcode4.InsertRow(1);
		gcds_satcode4.NameValue(1,"CDCODE")="";
		gcds_satcode4.NameValue(1,"CDNAM")="";
		gclx_satcode4.index = 0;
		gclx_satcode4.enable = true;
	}
</script>

<!-- �߰� ������ 2007-12-20 -->
<script language="javascript" for="gcds_satcode5" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode5.enable = false;
		gclx_satcode5.index = 0;
	}else{ 
		gcds_satcode5.InsertRow(1);
		gcds_satcode5.NameValue(1,"CDCODE")="";
		gcds_satcode5.NameValue(1,"CDNAM")="";
		gclx_satcode5.index = 0;
		gclx_satcode5.enable = true;
	}
</script>


<!-- �߰� ������ 2007-12-20 -->
<script language="javascript" for="gcds_satcode6" event="onloadCompleted(row,colid)">
	if(row<1) {	
		gclx_satcode6.enable = false;
		gclx_satcode6.index = 0;
	}else{ 
		gcds_satcode6.InsertRow(1);
		gcds_satcode6.NameValue(1,"CDCODE")="";
		gcds_satcode6.NameValue(1,"CDNAM")="";
		gclx_satcode6.index = 0;
		gclx_satcode6.enable = true;
	}
</script>



<!-- ������ ����������� �����ڵ忡 ���� �ִٸ�  �� ���� ������ ������ ������ ���� �ڵ忡 ���� ���� �ڵ尪�� ������ �ڵ���� �����´�..-->
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	if(row>0) {	
		gcem_wonganm2.Text = gcds_code01.nameValue(1, "CDNAM");
	}
</script>

<!-- ������ ����������� �����ڵ忡 ���� �ִٸ�  �� ���� ������ ������ ������ ���� �ڵ忡 ���� ���� �ڵ尪�� ������ �ڵ���� �����´�..-->
<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)">
	if(row>0) {	
		gcem_wonganm4.Text = gcds_code02.nameValue(1, "CDNAM");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*���������Ѱ�ǥ*/
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	gcte_disp.ActiveIndex=2;	/*����������OPEN*/

  //gclx_sfdcode2.bindcolval  = gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");     //����
  gclx_sfdcode2.bindcolval = gclx_sfdcode1.bindcolval ;

  gcem_bgtyy2.text          = gcds_data1.namevalue(gcds_data1.rowposition,"BGTYY");			//�⵵
  gcem_bgtmm2.text          = gcds_data1.namevalue(gcds_data1.rowposition,"BGTMM");       //�����
  gcem_bgtmm2_1.text        = gcds_data1.namevalue(gcds_data1.rowposition,"BGTMM");     //�����
  gclx_bgtdiv2.bindcolval   = gcds_data1.namevalue(gcds_data1.rowposition,"BGTDIV");      //��û����
  gcem_bgtnam2.Text = gcem_bgtnam1.Text ;																			// ��û�μ� �߰� ������ ������. Inserted by leehyunjin . 2007-12-26
  gcem_bgtdept2.text        = gcds_data1.namevalue(gcds_data1.rowposition,"BGTDPT");     //��û�μ�
  gclx_bgtgubun1.index      = 1;																									//��ǥ����
  gcem_atcode2.text         = gcds_data1.namevalue(gcds_data1.rowposition,"ATCODE");      //��������
  txt_atcodenm2.value       = gcds_data1.namevalue(gcds_data1.rowposition,"ATKORNAM");     //��������
  ln_RefQuery(gcem_atcode2.text,'2');
  gclx_satcode2.bindcolval  = gcds_data1.namevalue(gcds_data1.rowposition,"SATCODE");     //����

/*
	if(gcds_data1.namevalue(gcds_data1.rowposition,"FSREFCD")=="0030" ){ //�մ��ϴ� �����ڵ尡 �׸���� ��Ÿ���ٸ�.	//�����ڵ�
		gcem_wongacd2.Text = gcem_wongacd1.Text  ;									
	}																
*/

if(gcem_wongacd1.Text != ""){  // �����ڵ忡 �ڵ常 �Է����� ���. ���� �ǿ� �����ڵ忡 �´� �����ڵ���� ����ִ´�. 
	gcem_wongacd2.Text = gcem_wongacd1.Text  ;	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_cost_s1?v_str1=0030"
												+"&v_str2="+gcem_wongacd1.Text+"&v_str3="+gcem_wonganm1.Text
												+"&v_str4=C"	+"&v_str5="+"&v_str6=";  
	gcds_code01.Reset();
}


//�����׸� 																 
/*
	gclx_sfdcode2.bindcolval = gcds_data1.namevalue(row,"FDCODE");
	gcem_bgtyy2.text = gcem_bgtyy1.text;
	gcem_bgtmm2.text = gcds_data1.namevalue(row,"BGTMM");
	gclx_bgtdiv2.bindcolval   = gclx_bgtdiv1.bindcolval;	//gcds_data1.namevalue(row,"BGTDIV");
	//gclx_bgtmact2.bindcolval  = gclx_bgtmact1.bindcolval;	//gcds_data1.namevalue(row,"BGTMACT");
	gclx_bgtgubun1.bindcolval = "N";
	gcem_atcode2.text = gcds_data1.namevalue(row,"ATCODE");
	gclx_satcode2.bindcolval = gcds_data1.namevalue(row,"SATCODE");
*/
	ln_Query('02');
</script>

<script language=JavaScript for=gcgd_disp03 event=OnDblClick(row,colid)>
	gcte_disp.ActiveIndex=4;	/*�μ�������OPEN*/


  gclx_sfdcode4.bindcolval = gcds_data3.namevalue(row,"FDCODE")//���� 
  gcem_bgtyy4.text = gcds_data3.namevalue(row,"BGTYY")//�⵵
  gcem_bgtmm4.text = gcds_data3.namevalue(row,"BGTMM")		  // ����� 1
  gcem_bgtmm4_1.text = gcds_data3.namevalue(row,"BGTMM")    //�����
  gclx_bgtdiv4.bindcolval = gcds_data3.namevalue(row,"BGTDIV") //��û���� 
  gcem_bgtnam4.text = gcds_data3.namevalue(row,"DEPTNM")					//��û�μ� �̸� (�̸� ���� ��� ��������?)
  gcem_bgtdept4.text = gcds_data3.namevalue(row,"BGTDPT")					//��û�μ� �ڵ�
  gclx_bgtgubun2.index = 1;																			//��ǥ���� 
  txt_atcodenm4.value = gcds_data3.namevalue(row,"ATKORNAM")				//�������� �̸�
  gcem_atcode4.text = gcds_data3.namevalue(row,"ATCODE")						//�������� �ڵ�
  ln_RefQuery(gcem_atcode4.text,'4');
  gclx_satcode4.bindcolval = gcds_data3.namevalue(row,"SATCODE")//���� 
  gcem_wongacd4.Text = gcem_wongacd3.Text;											//�����ڵ� -> �����ڵ��

	if (gcem_wongacd3.Text!="") {  // ���� �޾Ƽ� �����Ѵٸ�.
			gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_cost_s1?v_str1=0030"
												+"&v_str2="+gcem_wongacd3.Text+"&v_str3="+gcem_wonganm3.Text
												+"&v_str4=C"	+"&v_str5="+"&v_str6="; 
			gcds_code02.Reset();
	}



//	gclx_sfdcode4.bindcolval = gcds_data3.namevalue(row,"FDCODE");
//	gcem_bgtyy4.text = gcem_bgtyy3.text;
//	gcem_bgtmm4.text = gcds_data3.namevalue(row,"BGTMM");
//	gclx_bgtdiv4.bindcolval   = gclx_bgtdiv3.bindcolval;	//gcds_data3.namevalue(row,"BGTDIV");
//	gclx_bgtmact4.bindcolval  = gclx_bgtmact3.bindcolval; //gcds_data3.namevalue(row,"BGTMACT");
//	gclx_bgtgubun2.bindcolval = "N";
//	gcem_atcode4.text = gcds_data3.namevalue(row,"ATCODE");
//	gclx_satcode4.bindcolval = gcds_data3.namevalue(row,"SATCODE");
	ln_Query('04');
</script>



<!-- �߰� ������ 2007-12-20 -->
<script language=JavaScript for=gcgd_disp05 event=OnDblClick(row,colid)>
	gcte_disp.ActiveIndex=6;	/*����������OPEN*/
  gclx_sfdcode6.bindcolval = gcds_data5.namevalue(row,"FDCODE")//���� 
  gcem_bgtyy6.text = gcds_data5.namevalue(row,"BGTYY")//�⵵ 
  gcem_bgtmm6.text = gcds_data5.namevalue(row,"BGTMM")
  gcem_bgtmm6_1.text = gcds_data5.namevalue(row,"BGTMM")//����� 
  gclx_bgtdiv6.bindcolval = gcds_data5.namevalue(row,"BGTDIV")//��û���� 
  gcem_bgtnam6.text = gcds_data5.namevalue(row,"DEPTNM")
  gcem_bgtdept6.text = gcds_data5.namevalue(row,"BGTDPT")//��û�μ� 
  gclx_bgtgubun3.index = 0;//��ǥ���� 
  txt_atcodenm6.value = gcds_data5.namevalue(row,"ATKORNAM")
  gcem_atcode6.text = gcds_data5.namevalue(row,"ATCODE")//�������� 
  ln_RefQuery(gcem_atcode6.text,'6');
  gclx_satcode6.bindcolval = gcds_data5.namevalue(row,"SATCODE")//���� 
 ln_Query('06');
</script>





<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	ln_TaxQuery('01');	//��ǥPopup
</script>

<script language=JavaScript for=gcgd_disp04 event=OnDblClick(row,colid)>
	ln_TaxQuery('02');	//��ǥPopup
</script>

<script language=JavaScript for=gcgd_disp06 event=OnDblClick(row,colid)>
	ln_TaxQuery('03');	//��ǥPopup  �߰� ������ 2007-12-20
</script>

<script language=JavaScript for=gclx_bgtdpt1 event=OnCloseUp()>
	gclx_bgtdiv1.bindcolval = gcds_bgtdpt1.namevalue(gcds_bgtdpt1.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt2 event=OnCloseUp()>
	gclx_bgtdiv2.bindcolval = gcds_bgtdpt2.namevalue(gcds_bgtdpt2.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt3 event=OnCloseUp()>
	gclx_bgtdiv3.bindcolval = gcds_bgtdpt3.namevalue(gcds_bgtdpt3.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt4 event=OnCloseUp()>
	gclx_bgtdiv4.bindcolval = gcds_bgtdpt4.namevalue(gcds_bgtdpt4.rowposition,"BGTDIVCD");
</script>

<script language=JavaScript for=gclx_bgtdpt5 event=OnCloseUp()>
	gclx_bgtdiv5.bindcolval = gcds_bgtdpt5.namevalue(gcds_bgtdpt5.rowposition,"BGTDIVCD");
</script><!-- �߰� -->

<script language=JavaScript for=gclx_bgtdpt6 event=OnCloseUp()>
	gclx_bgtdiv6.bindcolval = gcds_bgtdpt6.namevalue(gcds_bgtdpt6.rowposition,"BGTDIVCD");
</script><!-- �߰�  -->



<script language=JavaScript for=gcem_bgtnam1 event=OnKillFocus()>
  if(gcem_bgtnam1.text!=""){
    gcem_bgtdept1.text = "";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam1.text;
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtdept1.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept1 event=OnKillFocus()>
  if(gcem_bgtdept1.text!=""){
    gcem_bgtnam1.text="";
    gcds_depttemp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept1.text+"&v_str2=";
    gcds_depttemp1.Reset();
  }else{
    gcem_bgtnam1.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam2 event=OnKillFocus()>
  if(gcem_bgtnam2.text!=""){
    gcem_bgtdept2.text = "";
    gcds_depttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam2.text;
    gcds_depttemp2.Reset();
  }else{
    gcem_bgtdept2.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept2 event=OnKillFocus()>
  if(gcem_bgtdept2.text!=""){
    gcem_bgtnam2.text="";
    gcds_depttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept2.text+"&v_str2=";
    gcds_depttemp2.Reset();
  }else{
    gcem_bgtnam2.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam3 event=OnKillFocus()>
  if(gcem_bgtnam3.text!=""){
    gcem_bgtdept3.text = "";
    gcds_depttemp3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam3.text;
    gcds_depttemp3.Reset();
  }else{
    gcem_bgtdept3.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept3 event=OnKillFocus()>
  if(gcem_bgtdept3.text!=""){
    gcem_bgtnam3.text="";
    gcds_depttemp3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept3.text+"&v_str2=";
    gcds_depttemp3.Reset();
  }else{
    gcem_bgtnam3.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtnam4 event=OnKillFocus()>
  if(gcem_bgtnam4.text!=""){
    gcem_bgtdept4.text = "";
    gcds_depttemp4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam4.text;
    gcds_depttemp4.Reset();
  }else{
    gcem_bgtdept4.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept4 event=OnKillFocus()>
  if(gcem_bgtdept4.text!=""){
    gcem_bgtnam4.text="";
    gcds_depttemp4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept4.text+"&v_str2=";
    gcds_depttemp4.Reset();
  }else{
    gcem_bgtnam4.text="";
  }
</script>



<!-- �߰� ������ -->
<script language=JavaScript for=gcem_bgtnam5 event=OnKillFocus()>
  if(gcem_bgtnam5.text!=""){
    gcem_bgtdept5.text = "";
    gcds_depttemp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam5.text;
    gcds_depttemp5.Reset();
  }else{
    gcem_bgtdept5.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept5 event=OnKillFocus()>
  if(gcem_bgtdept5.text!=""){
    gcem_bgtnam5.text="";
    gcds_depttemp5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept5.text+"&v_str2=";
    gcds_depttemp5.Reset();
  }else{
    gcem_bgtnam5.text="";
  }
</script>



<!-- �߰� ������ -->
<script language=JavaScript for=gcem_bgtnam6 event=OnKillFocus()>
  if(gcem_bgtnam6.text!="") {
    gcem_bgtdept6.text = "";
    gcds_depttemp6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1=&v_str2="+gcem_bgtnam6.text;
    gcds_depttemp6.Reset();
  }else{
    gcem_bgtdept6.text="";
  }
</script>
<script language=JavaScript for=gcem_bgtdept6 event=OnKillFocus()>
  if(gcem_bgtdept6.text!=""){
    gcem_bgtnam6.text="";
    gcds_depttemp6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdept_s2?v_str1="+gcem_bgtdept6.text+"&v_str2=";
    gcds_depttemp6.Reset();
  }else{
    gcem_bgtnam6.text="";
  }
</script>




<script language="javascript" for="gcds_depttemp1" event="onloadCompleted(row,colid)">
	if(gcds_depttemp1.countrow>0){
    if(gcds_depttemp1.countrow == '1'){
      gcem_bgtnam1.text = gcds_depttemp1.namevalue(1,"CDNAM");
      gcem_bgtdept1.text = gcds_depttemp1.namevalue(1,"CDCODE");
      gclx_bgtdiv1.bindcolval = gcds_depttemp1.namevalue(1,"GBCD");
    }else{
      ln_Popup1();
    }
	}else{
    gcem_bgtnam1.text = "";
    gcem_bgtdept1.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp2" event="onloadCompleted(row,colid)">
	if(gcds_depttemp2.countrow>0){
    if(gcds_depttemp2.countrow == '1'){
      gcem_bgtnam2.text = gcds_depttemp2.namevalue(1,"CDNAM");
      gcem_bgtdept2.text = gcds_depttemp2.namevalue(1,"CDCODE");
      gclx_bgtdiv2.bindcolval = gcds_depttemp2.namevalue(1,"GBCD");
    }else{
      ln_Popup2();
    }
	}else{
    gcem_bgtnam2.text = "";
    gcem_bgtdept2.text = "";
  }
</script>
<script language="javascript" for="gcds_depttemp3" event="onloadCompleted(row,colid)">
	if(gcds_depttemp3.countrow>0){
    if(gcds_depttemp3.countrow == '1'){
      gcem_bgtnam3.text = gcds_depttemp3.namevalue(1,"CDNAM");
      gcem_bgtdept3.text = gcds_depttemp3.namevalue(1,"CDCODE");
      gclx_bgtdiv3.bindcolval = gcds_depttemp3.namevalue(1,"GBCD");
    }else{
      ln_Popup3();
    }
	}else{
    gcem_bgtnam3.text = "";
    gcem_bgtdept3.text = "";
  }
</script>


<script language="javascript" for="gcds_depttemp4" event="onloadCompleted(row,colid)">
	if(gcds_depttemp4.countrow>0){
    if(gcds_depttemp4.countrow == '1'){
      gcem_bgtnam4.text = gcds_depttemp4.namevalue(1,"CDNAM");
      gcem_bgtdept4.text = gcds_depttemp4.namevalue(1,"CDCODE");
      gclx_bgtdiv4.bindcolval = gcds_depttemp4.namevalue(1,"GBCD");
    }else{
      ln_Popup4();
    }
	}else{
    gcem_bgtnam4.text = "";
    gcem_bgtdept4.text = "";
  }
</script>

<!-- �߰� ������ 2007-12-20  -->
<script language="javascript" for="gcds_depttemp5" event="onloadCompleted(row,colid)">
	if(gcds_depttemp5.countrow>0){
    if(gcds_depttemp5.countrow == '1'){
      gcem_bgtnam5.text = gcds_depttemp5.namevalue(1,"CDNAM");
      gcem_bgtdept5.text = gcds_depttemp5.namevalue(1,"CDCODE");
      gclx_bgtdiv5.bindcolval = gcds_depttemp5.namevalue(1,"GBCD");
    }else{
      ln_Popup5();
    }
	}else{
    gcem_bgtnam5.text = "";
    gcem_bgtdept5.text = "";
  }
</script>

<!-- �߰� ������ 2007-12-20  -->
<script language="javascript" for="gcds_depttemp6" event="onloadCompleted(row,colid)">
	if(gcds_depttemp6.countrow>0){
    if(gcds_depttemp6.countrow == '1'){
      gcem_bgtnam6.text = gcds_depttemp6.namevalue(1,"CDNAM");
      gcem_bgtdept6.text = gcds_depttemp6.namevalue(1,"CDCODE");
      gclx_bgtdiv6.bindcolval = gcds_depttemp6.namevalue(1,"GBCD");
    }else{
      ln_Popup6();
    }
	}else{
    gcem_bgtnam6.text = "";
    gcem_bgtdept6.text = "";
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
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>

<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a080006_head.gif"></td>
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
								<T>divid=div_1		title=�������������</T>									
							  <T>divid=div_2		title=����������</T>
							  <T>divid=div_3		title=�μ����������</T>
							  <T>divid=div_4		title=�μ�������</T>
							  <T>divid=div_5		title=�������������</T>
							  <T>divid=div_6		title=����������</T>
						  ">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- ������������� ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode1">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm1_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv1">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup1()">
          <comment id="__NSID__"><object  id=gcem_bgtdept1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>


<!-- 
					<comment id="__NSID__"><object  id=gclx_bgtdpt1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt1">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
			<tr>
				<!-- <td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����Ÿ��</td>
				<td class="tab23" style="width:70px">
					<comment id="__NSID__"><object  id=gclx_bgtmact1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=ComboDataID			value="gcds_bgtmact1">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^75">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td> -->
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="7">
					<input id=txt_atcodenm1 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:280px;">
					<img name="btn_find1" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('1')">
					<comment id="__NSID__"><object  id=gcem_atcode1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22">
					<comment id="__NSID__"><object  id=gclx_fsrefcd1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd1">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode1"><!-- ���� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^140">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>


			<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('1')">
					<comment id="__NSID__"><object  id=gcem_wongacd1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
					<comment id="__NSID__"><object  id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"  VALUE="true">
							<PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"		VALUE="
						<C> Name='��'					ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='��������'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align=left   SumText='�հ�'	SumBgColor='#C3D0DB'</C> 
						<C> Name='����'				ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align=left   SumText=''			SumBgColor='#C3D0DB' EditStyle='lookup' Data='gcds_satcode1:CDCODE:CDNAM'</C>
						<C> Name='�μ���'			ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=185 align=left   SumText=''	SumBgColor='#C3D0DB'</C> 
						<C> Name='������'			ID=BASICBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�߰�����'		ID=ADDBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�׸�����'		ID=CHGABGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�Ⱓ����'		ID=CHGTBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�μ�����'		ID=DEPTBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='���࿹��'		ID=REALBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�������'		ID=TOTRES			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> show= true , Name='�����ڵ�'		ID=FSREFCD			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�����ڵ尪'		ID=FSREFVAL		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						">

					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('1')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('1')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('01')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- ���������� ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode2">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm2_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv2">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup2()">
          <comment id="__NSID__"><object  id=gcem_bgtdept2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>



<!-- 					<comment id="__NSID__"><object  id=gclx_bgtdpt2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt2">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script> 
 -->				</td>
			</tr>
			<tr>
				<!-- <td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����Ÿ��</td>
				<td class="tab23" style="width:70px">
					<comment id="__NSID__"><object  id=gclx_bgtmact2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=ComboDataID			value="gcds_bgtmact2">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^75">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td> -->
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��ǥ����</td>
				<td class="tab21" style="width:80px">
					<comment id="__NSID__"><object  id=gclx_bgtgubun1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=CBData			value="^ ,Y^����Ϸ�,R^�����û,N^������,B^�ݼ�">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="5">
					<input id=txt_atcodenm2 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:230px;">
					<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('2')">
					<comment id="__NSID__"><object  id=gcem_atcode2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22">
					<comment id="__NSID__"><object  id=gclx_fsrefcd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd2"><!-- �����׸��ڵ� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode2"><!-- ���� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('2')">
					<comment id="__NSID__"><object  id=gcem_wongacd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data2">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
						<F> Name='����'			ID=ACTDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=center SumText='�հ�' SumBgColor='#C3D0DB' mask='XXXX/XX/XX'</F> 
						<F> Name='��������'	ID=ATKORNAM HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left		SumText=''	   SumBgColor='#C3D0DB'</F>
						<C> Name='����'			ID=FSREFVAL		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left		SumText=''	   SumBgColor='#C3D0DB'</C>
						<C> Name='����'			ID=REMARK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left		SumText=''	   SumBgColor='#C3D0DB'</C>
						<C> Name='����'			ID=DEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right  SumText=@sum	 SumBgColor='#C3D0DB'</C>
						<C> Name='�뺯'			ID=CRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right  SumText=@sum	 SumBgColor='#C3D0DB'</C>
						<C> Name='�ŷ�ó'		ID=COMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=150 align=left		SumText=''	   SumBgColor='#C3D0DB'</C>
						<C> Name='��ǥ����'	ID=FSSTAT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=center SumText=''	   SumBgColor='#C3D0DB' EditStyle='combo' Data='Y:����Ϸ�,R:�����û,N:������,B:�ݼ�,C:�������'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
					</fieldset><!-- 
					<C> Name='����'			ID=SATNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left		SumText=''	   SumBgColor='#C3D0DB'</C>
					
					-->
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('2')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('2')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('02')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table> 

<!-- �μ���������� ===========================================================================================================-->
<fieldset id=field3 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp3" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode3">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm3_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv3">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup3()">
          <comment id="__NSID__"><object  id=gcem_bgtdept3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>



<!-- 
					<comment id="__NSID__"><object  id=gclx_bgtdpt3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt3">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
			<tr>
				<!-- <td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����Ÿ��</td>
				<td class="tab23" style="width:70px">
					<comment id="__NSID__"><object  id=gclx_bgtmact3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=ComboDataID			value="gcds_bgtmact3">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^75">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td> -->
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="7">
					<input id=txt_atcodenm3 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:280px;">
					<img name="btn_find3" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('3')">
					<comment id="__NSID__"><object  id=gcem_atcode3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22">
					<comment id="__NSID__"><object  id=gclx_fsrefcd3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd3"><!-- �����׸��ڵ� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode3"><!-- ���� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

				<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('3')">
					<comment id="__NSID__"><object  id=gcem_wongacd3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
					<comment id="__NSID__"><object  id=gcgd_disp03 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data3">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
						<C> Name='��'					ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='��û�μ�'		ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=190 align=left   SumText='�հ�'	SumBgColor='#C3D0DB'</C> 
						<C> Name='��������'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left   SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='����'				ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=left   SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='������'			ID=BASICBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right  SumText=@sum		SumBgColor='#C3D0DB'</C> 
						<C> Name='�߰�����'		ID=ADDBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�׸�����'		ID=CHGABGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�Ⱓ����'		ID=CHGTBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�μ�����'		ID=DEPTBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='���࿹��'		ID=REALBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�������'		ID=TOTRES			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('3')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('3')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('03')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-- �μ������� ===========================================================================================================-->
<fieldset id=field4 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp4" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode4">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm4_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv4">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup4()">
          <comment id="__NSID__"><object  id=gcem_bgtdept4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>


<!-- 
					<comment id="__NSID__"><object  id=gclx_bgtdpt4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdpt4">
						<param name=CBDataColumns		value="BGTDEPT,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^160">
						<param name=BindColumn			value="BGTDEPT">
					</object></comment><script>__ws__(__NSID__);</script>  -->
				</td>
			</tr>
			<tr>
				<!-- <td class="tab12" style="height:30px;width:70px;" bgcolor="#eeeeee">����Ÿ��</td>
				<td class="tab23" style="width:70px">
					<comment id="__NSID__"><object  id=gclx_bgtmact4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=ComboDataID			value="gcds_bgtmact4">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^75">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> -->
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��ǥ����</td>
				<td class="tab21" style="width:80px">
					<comment id="__NSID__"><object  id=gclx_bgtgubun2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=CBData			value="^ ,Y^����Ϸ�,R^�����û,N^������,B^�ݼ�">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="5">
					<input id=txt_atcodenm4 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:230px;">
					<img name="btn_find4" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('4')">
					<comment id="__NSID__"><object  id=gcem_atcode4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" >
					<comment id="__NSID__"><object  id=gclx_fsrefcd4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd4"><!-- �����׸��ڵ� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode4 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode4"><!-- ���� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			
			<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('4')">
					<comment id="__NSID__"><object  id=gcem_wongacd4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
					<comment id="__NSID__"><object  id=gcgd_disp04 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data4">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
<F> Name='����'			ID=ACTDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=center BgColor='#f5f5f5' SumText='�հ�' SumBgColor='#C3D0DB' mask='XXXX/XX/XX'</F> 
<F> Name='��û�μ�'	ID=AA   		HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=left		BgColor='#f5f5f5' SumText=''	   Editstyle=lookup, Data='gcds_depttemp5_lookup:CDCODE:CDNAM', SumBgColor='#C3D0DB'</F>
<C> Name='����'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left		SumText=''				SumBgColor='#C3D0DB'</C>
<C> Name='����'			ID=DEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right  SumText=@sum			SumBgColor='#C3D0DB'</C>
<C> Name='�뺯'			ID=CRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right  SumText=@sum			SumBgColor='#C3D0DB'</C>
<C> Name='�ŷ�ó'		ID=COMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=145 align=left		SumText=''				SumBgColor='#C3D0DB'</C>
<C> Name='��ǥ����'	ID=FSSTAT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=center SumText=''				SumBgColor='#C3D0DB' EditStyle='combo' Data='Y:����Ϸ�,R:�����û,N:������,B:�ݼ�,C:�������'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt04 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"	 style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('4')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('4')">
					<img src="../../Common/img/btn/com_b_query.gif"	 style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('04')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>




<!-- �߰� �� �� -->
<!-- ������������� ===========================================================================================================-->
<fieldset id=field5 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp5" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode5">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm5_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv5">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup5()">
          <comment id="__NSID__"><object  id=gcem_bgtdept5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="7">
					<input id=txt_atcodenm5 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:280px;">
					<img name="btn_find3" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('5')">
					<comment id="__NSID__"><object  id=gcem_atcode5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22">
					<comment id="__NSID__"><object  id=gclx_fsrefcd5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd5"><!-- �����׸��ڵ� DS�߰����� -->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode5 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode5"><!-- ����  DS�߰�����-->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

				<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('5')">
					<comment id="__NSID__"><object  id=gcem_wongacd5 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
					<comment id="__NSID__"><object  id=gcgd_disp05 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data5">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
						<C> Name='��'					ID=BGTMM			HeadAlign=Center HeadBgColor=#B9D4DC Width=30  align=center SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='��û�μ�'		ID=DEPTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=190 align=left   SumText='�հ�'	SumBgColor='#C3D0DB'</C> 
						<C> Name='��������'		ID=ATKORNAM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left   SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='����'				ID=SATNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130 align=left   SumText=''			SumBgColor='#C3D0DB'</C> 
						<C> Name='������'			ID=BASICBGT		HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right  SumText=@sum		SumBgColor='#C3D0DB'</C> 
						<C> Name='�߰�����'		ID=ADDBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�׸�����'		ID=CHGABGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�Ⱓ����'		ID=CHGTBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�μ�����'		ID=DEPTBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='���࿹��'		ID=REALBGT			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						<C> Name='�������'		ID=TOTRES			HeadAlign=Center HeadBgColor=#B9D4DC Width=95 align=right   SumText=@sum	  SumBgColor='#C3D0DB'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt05 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"		style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('5')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('5')">
					<img src="../../Common/img/btn/com_b_query.gif" style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('05')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>

<!-- ���������� ===========================================================================================================-->
<fieldset id=field6 style="position:absolute;top:160px;left:18px;height:470px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp6" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
  <td align="left" colspan=2>
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;width:866px;border:1 solid #708090;">
			<tr>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" style="width:70px"><nobr>
					<comment id="__NSID__"><object  id=gclx_sfdcode6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:70px;height:110px;">
						<param name=ComboDataID			value="gcds_sfdcode6">
						<param name=CBDataColumns		value="FDCODE,FDNAME">
						<param name=SearchColumn		value="FDNAME">
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="FDNAME^0^70">
						<param name=BindColumn			value="FDCODE">
					</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;</nobr>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab21" width="40px">
					<comment id="__NSID__"><object  id=gcem_bgtyy6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:30px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">�����</td>
				<td class="tab21" width="85px">
					<comment id="__NSID__"><object  id=gcem_bgtmm6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>&nbsp;~
					<comment id="__NSID__"><object  id=gcem_bgtmm6_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:2px; width:25px; height:20px;" class="txtbox">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="00">
						<param name=PromptChar	  value="_">
						<param name=Enable				value="true">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û����</td>
				<td class="tab21" width="120px">
					<comment id="__NSID__"><object  id=gclx_bgtdiv6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:200px;">
						<param name=ComboDataID			value="gcds_bgtdiv6">
						<param name=CBDataColumns		value="BGTDIVCD,BGTNAM">
						<param name=SearchColumn		value="BGTNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="BGTNAM^0^100">
						<param name=BindColumn			value="BGTDIVCD">
            <param name=Enable          value="false">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
				<td class="tab11" style="height:25px;width:70px;" bgcolor="#eeeeee">��û�μ�</td>
				<td class="tab22" width="250px">

          <comment id="__NSID__"><object  id=gcem_bgtnam6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="width:100px;height:20px;position:relative;left:5px;top:2px;">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
          <img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popup6()">
          <comment id="__NSID__"><object  id=gcem_bgtdept6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:40px">
            <param name=Text				value="">
            <param name=Alignment		value=0>
            <param name=Border			value=true>
            <param name=Format			value="####">
            <param name=PromptChar	value="_">
            <param name=Enable			value="true">
          </object></comment><script>__ws__(__NSID__);</script>
				</td>
			</tr>
			<tr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��ǥ����</td>
				<td class="tab21" style="width:80px">
					<comment id="__NSID__"><object  id=gclx_bgtgubun3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:70px;">
						<param name=CBData			value="^ ,Y^����Ϸ�,R^�����û,N^������,B^�ݼ�">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��������</td>
				<td class="tab21" colspan="5">
					<input id=txt_atcodenm6 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:230px;">
					<img name="btn_find4" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:3px;cursor:hand"	 onclick="ln_Popup('6')">
					<comment id="__NSID__"><object  id=gcem_atcode6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:3px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
					</object></comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td class="tab11" style="height:30px;width:70px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
				<td class="tab22" >
					<comment id="__NSID__"><object  id=gclx_fsrefcd6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:100px;display:none">
						<param name=ComboDataID			value="gcds_fsrefcd6"><!-- �����׸��ڵ� DS-->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script>
					<comment id="__NSID__"><object  id=gclx_satcode6 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:5px;top:0px;font-size:12px;width:130px;height:200px;">
						<param name=ComboDataID			value="gcds_satcode6"><!-- ����  DS-->
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^130">
						<param name=BindColumn			value="CDCODE">
					</object></comment><script>__ws__(__NSID__);</script> 
				</td>
			</tr>

			
			<tr>
			<td class="tab12" style="height:30px;width:60px;" bgcolor="#eeeeee">�����ڵ�</td>
				<td colspan="9"  style="height:30px;width:400px;">
					 <comment id="__NSID__"><object  id=gcem_wonganm6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:7px;width:250px">		
            <param name=Text					value="">
            <param name=Border        value=true>
            <param name=GeneralEdit   value="true">
            <param name=BackColor     value="#CCCCCC">
            <param name=InheritColor  value=false>
          </object></comment><script>__ws__(__NSID__);</script>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:10px;cursor:hand"	 onclick="ln_Popupwon('6')">
					<comment id="__NSID__"><object  id=gcem_wongacd6 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:7px;width:45px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="true">
					</object></comment><script>__ws__(__NSID__);</script>
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
					<comment id="__NSID__"><object  id=gcgd_disp06 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 
						style="position:relative;left:8px;width:864px; height:347px; border:1 solid #708090;display:block;" viewastext>
							<PARAM NAME="DataID"			VALUE="gcds_data6">
							<PARAM NAME="IndWidth"		VALUE ='0'>
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Sortview"		VALUE="left">
							<PARAM NAME="ViewSummary"	VALUE="1">
							<PARAM NAME="ColSizing"   VALUE="true">
              <PARAM NAME="Editable"    VALUE="false">
							<PARAM NAME="Format"			VALUE="  
<F> Name='����'			ID=ACTDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=center BgColor='#f5f5f5' SumText='�հ�' SumBgColor='#C3D0DB' mask='XXXX/XX/XX'</F> 
<F> Name='��û�μ�'	ID=AA   		HeadAlign=Center HeadBgColor=#B9D4DC Width=175 align=left		BgColor='#f5f5f5' SumText=''	   Editstyle=lookup, Data='gcds_depttemp5_lookup:CDCODE:CDNAM', SumBgColor='#C3D0DB'</F>
<C> Name='����'			ID=REMARK		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 align=left		SumText=''				SumBgColor='#C3D0DB'</C>
<C> Name='����'			ID=DEAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right  SumText=@sum			SumBgColor='#C3D0DB'</C>
<C> Name='�뺯'			ID=CRAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 align=right  SumText=@sum			SumBgColor='#C3D0DB'</C>
<C> Name='�ŷ�ó'		ID=COMNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=145 align=left		SumText=''				SumBgColor='#C3D0DB'</C>
<C> Name='��ǥ����'	ID=FSSTAT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=65  align=center SumText=''				SumBgColor='#C3D0DB' EditStyle='combo' Data='Y:����Ϸ�,R:�����û,N:������,B:�ݼ�,C:�������'</C>
						">
					</object></comment><script>__ws__(__NSID__);</script> 
					<fieldset style="position:relative;left:8px;width:866px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id=ft_cnt06 style="position:relative;top:4px;"></font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td height="1" align="right">
					<img src="../../Common/img/btn/com_b_print.gif"	 style="position:relative;right:5px;top:-523px;cursor:hand" onClick="ln_Print('6')">
					<IMG src="../../Common/img/btn/com_b_excel.gif"   style="position:relative;right:5px;top:-523px;cursor:hand"  onclick="ln_Excel('6')">
					<img src="../../Common/img/btn/com_b_query.gif"	 style="position:relative;right:5px;top:-523px;cursor:hand" onclick="ln_Query('06')">
				</td>
			</tr>
			</table>
		</td> 
	</tr> 
</table>
<!-- ���� �� -->









		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_temp>
	<param name=BindInfo  value='  
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print1">
	<param name="DetailDataID"			value="gcds_print1">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=436 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left' ,mask='XXXX/XX~XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� �� �� �� ��' ,left=1019 ,top=29 ,right=1844 ,bottom=93 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�߰�����' ,left=1630 ,top=378 ,right=1834 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�׸�����' ,left=1849 ,top=378 ,right=2048 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ⱓ����' ,left=2058 ,top=378 ,right=2236 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=1167 ,top=378 ,right=1339 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1408 ,top=378 ,right=1606 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2053 ,top=368 ,right=2053 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1844 ,top=368 ,right=1844 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1622 ,top=370 ,right=1622 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�μ���' ,left=828 ,top=378 ,right=1135 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=524 ,top=378 ,right=775 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=820 ,top=370 ,right=820 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=183 ,top=378 ,right=447 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=479 ,top=373 ,right=479 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2432 ,top=370 ,right=2432 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2609 ,top=370 ,right=2609 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��' ,left=66 ,top=378 ,right=138 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=151 ,top=368 ,right=151 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���࿹��' ,left=2439 ,top=378 ,right=2604 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ�����' ,left=2246 ,top=378 ,right=2424 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1140 ,top=368 ,right=1140 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1365 ,top=368 ,right=1365 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2238 ,top=370 ,right=2238 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�������' ,left=2614 ,top=378 ,right=2797 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=55 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='BASICBGT', left=1408, top=3, right=1606, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSREFCD', left=1167, top=3, right=1339, bottom=45, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=156, top=0, right=476, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=836, top=0, right=1130, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CHGABGT', left=1849, top=3, right=2048, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGTBGT', left=2056, top=3, right=2233, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2053 ,top=0 ,right=2053 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1844 ,top=0 ,right=1844 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1622 ,top=0 ,right=1622 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SATNM', left=489, top=0, right=815, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=479 ,top=0 ,right=479 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=820 ,top=0 ,right=820 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ADDBGT', left=1635, top=3, right=1839, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2609 ,top=0 ,right=2609 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TOTRES', left=2617, top=3, right=2802, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=151 ,top=0 ,right=151 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BGTMM', left=58, top=0, right=148, bottom=48, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REALBGT', left=2442, top=3, right=2606, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTBGT', left=2244, top=3, right=2421, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1140 ,top=0 ,right=1140 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1365 ,top=0 ,right=1365 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2432 ,top=0 ,right=2432 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2238 ,top=0 ,right=2238 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1854 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 
��������.. 
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=437 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left' ,mask='XXXX/XX~XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� �� �� �� ��' ,left=1019 ,top=29 ,right=1844 ,bottom=93 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='���࿹��' ,left=2387 ,top=378 ,right=2588 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߰�����' ,left=1540 ,top=378 ,right=1744 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�׸�����' ,left=1754 ,top=378 ,right=1953 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ⱓ����' ,left=1963 ,top=378 ,right=2167 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ�����' ,left=2178 ,top=378 ,right=2376 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1331 ,top=378 ,right=1529 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1958 ,top=368 ,right=1958 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1749 ,top=368 ,right=1749 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1535 ,top=370 ,right=1535 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�μ���' ,left=918 ,top=378 ,right=1318 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=487 ,top=378 ,right=902 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=910 ,top=370 ,right=910 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��������' ,left=61 ,top=378 ,right=474 ,bottom=426 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=482 ,top=373 ,right=482 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2381 ,top=370 ,right=2381 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1326 ,top=368 ,right=1326 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2172 ,top=373 ,right=2172 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2593 ,top=370 ,right=2593 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���࿹��' ,left=2598 ,top=381 ,right=2799 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='BASICBGT', left=1331, top=3, right=1529, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTBGT', left=2178, top=3, right=2376, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=61, top=0, right=474, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTNM', left=915, top=0, right=1318, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='REALBGT', left=2387, top=3, right=2588, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CHGABGT', left=1754, top=3, right=1953, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGTBGT', left=1963, top=3, right=2167, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2381 ,top=0 ,right=2381 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2172 ,top=0 ,right=2172 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1958 ,top=0 ,right=1958 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1749 ,top=0 ,right=1749 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1535 ,top=0 ,right=1535 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1326 ,top=0 ,right=1326 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SATNM', left=487, top=0, right=902, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=482 ,top=0 ,right=482 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=910 ,top=0 ,right=910 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ADDBGT', left=1540, top=3, right=1744, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2593 ,top=0 ,right=2593 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='RESULTS', left=2596, top=3, right=2799, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1855 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


-->











<comment id="__NSID__"><object  id=gcrp_print2 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print2">
	<param name="DetailDataID"			value="gcds_print2">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="

<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=437 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� ��' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=61 ,top=381 ,right=296 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=315 ,top=381 ,right=799 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=815 ,top=381 ,right=1167 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�����' ,left=2561 ,top=381 ,right=2797 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�ó' ,left=2072 ,top=381 ,right=2545 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2064 ,top=373 ,right=2064 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�뺯' ,left=1820 ,top=381 ,right=2056 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1812 ,top=373 ,right=1812 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1569 ,top=381 ,right=1804 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1561 ,top=376 ,right=1561 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=304 ,top=370 ,right=304 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=807 ,top=370 ,right=807 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1177 ,top=370 ,right=1177 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left' ,mask='XXXX/XX~XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2553 ,top=373 ,right=2553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1185 ,top=381 ,right=1553 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='ACTDAT', left=61, top=0, right=296, bottom=48, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=315, top=0, right=799, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=304 ,top=0 ,right=304 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=807 ,top=0 ,right=807 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2064 ,top=0 ,right=2064 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1812 ,top=0 ,right=1812 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1561 ,top=0 ,right=1561 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1177 ,top=0 ,right=1177 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SATNM', left=815, top=3, right=1167, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1183, top=3, right=1553, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEAMT', left=1569, top=3, right=1804, bottom=48, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1820, top=3, right=2056, bottom=48, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COMNM', left=2072, top=3, right=2545, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSSTAT', left=2561, top=3, right=2797, bottom=48, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1855 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcrp_print3 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print3">
	<param name="DetailDataID"			value="gcds_print3">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=437 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2384 ,top=373 ,right=2384 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û�μ�' ,left=61 ,top=381 ,right=482 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=497 ,top=381 ,right=894 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1961 ,top=373 ,right=1961 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1749 ,top=373 ,right=1749 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1537 ,top=376 ,right=1537 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=489 ,top=370 ,right=489 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1326 ,top=370 ,right=1326 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left' ,mask='XXXX/XX~XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2170 ,top=373 ,right=2170 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=902 ,top=370 ,right=902 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=910 ,top=381 ,right=1318 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� �� �� �� ��' ,left=1019 ,top=29 ,right=1844 ,bottom=93 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='���࿹��' ,left=2389 ,top=381 ,right=2588 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�μ�����' ,left=2175 ,top=381 ,right=2379 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ⱓ����' ,left=1966 ,top=381 ,right=2164 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�׸�����' ,left=1754 ,top=381 ,right=1955 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�߰�����' ,left=1545 ,top=381 ,right=1744 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1331 ,top=381 ,right=1532 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2593 ,top=370 ,right=2593 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�������' ,left=2598 ,top=381 ,right=2797 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='DEPTNM', left=61, top=0, right=482, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='REALBGT', left=2389, top=3, right=2588, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=902 ,top=0 ,right=902 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2384 ,top=0 ,right=2384 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2170 ,top=0 ,right=2170 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1961 ,top=0 ,right=1961 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1749 ,top=0 ,right=1749 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1537 ,top=0 ,right=1537 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1326 ,top=0 ,right=1326 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=489 ,top=0 ,right=489 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ATKORNAM', left=497, top=0, right=894, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SATNM', left=910, top=0, right=1318, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPTBGT', left=2175, top=3, right=2379, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGTBGT', left=1966, top=3, right=2164, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHGABGT', left=1754, top=3, right=1955, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDBGT', left=1545, top=3, right=1741, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BASICBGT', left=1331, top=3, right=1532, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2593 ,top=0 ,right=2593 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='RESULTS', left=2598, top=3, right=2797, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1855 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcrp_print4 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print4">
	<param name="DetailDataID"			value="gcds_print4">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<!-- <param name="SuppressColumns"	value="1:pageskip,ATCODE;"> -->
	<param name="Format"					value="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=437 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='�� �� �� �� ��' ,left=1019 ,top=24 ,right=1844 ,bottom=87 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=53 ,top=437 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=61 ,top=381 ,right=296 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� :' ,left=53 ,top=230 ,right=148 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��û�μ�' ,left=315 ,top=381 ,right=878 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ����' ,left=2561 ,top=381 ,right=2797 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�ó' ,left=1979 ,top=381 ,right=2545 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=894 ,top=381 ,right=1463 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=53 ,top=368 ,right=53 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=304 ,top=370 ,right=304 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=370 ,right=2805 ,bottom=370 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=886 ,top=370 ,right=886 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2805 ,top=373 ,right=2805 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�⵵ :' ,left=53 ,top=283 ,right=148 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SFDCODE', left=159, top=233, right=400, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��û�μ� :' ,left=2260 ,top=283 ,right=2424 ,bottom=328 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='BGTDIV', left=2434, top=233, right=2807, bottom=275, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BGTDPT', left=2434, top=283, right=2807, bottom=328, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2553 ,top=373 ,right=2553 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��û���� :' ,left=2260 ,top=233 ,right=2424 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1722 ,top=373 ,right=1722 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='�뺯' ,left=1730 ,top=381 ,right=1966 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1974 ,top=373 ,right=1974 ,bottom=434 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1479 ,top=381 ,right=1715 ,bottom=429 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1471 ,top=376 ,right=1471 ,bottom=437 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BGTYY', left=159, top=283, right=400, bottom=328, align='left' ,mask='XXXX/XX~XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=53 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='FSSTAT', left=2561, top=3, right=2797, bottom=45, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2805 ,top=0 ,right=2805 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=53 ,top=0 ,right=53 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=304 ,top=0 ,right=304 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2553 ,top=0 ,right=2553 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1974 ,top=0 ,right=1974 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=894, top=3, right=1463, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=886 ,top=0 ,right=886 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='COMNM', left=1979, top=3, right=2545, bottom=45, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=1728, top=3, right=1963, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1722 ,top=0 ,right=1722 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEAMT', left=1479, top=3, right=1715, bottom=45, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1471 ,top=0 ,right=1471 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEPTNM', left=315, top=0, right=878, bottom=48, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACTDAT', left=61, top=0, right=296, bottom=48 ,mask='XXXX/XX/XX', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=53 ,top=0 ,right=2805 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1855 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=56 ,top=0 ,right=2807 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 



<comment id="__NSID__"><object  id=gcrp_print5 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print5">
	<param name="DetailDataID"			value="gcds_print5">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<param name="Format"					value="
">
</object></comment><script>__ws__(__NSID__);</script> 



<comment id="__NSID__"><object  id=gcrp_print6 classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"			value="gcds_print6">
	<param name="DetailDataID"			value="gcds_print6">
	<param name="PaperSize"					value="A4">
	<param name="fixpapersize"			value="true">
	<param name="LandScape"					value="true">
	<param name="printMargine"			value="false">
	<param name="PrintSetupDlgFlag"	value="true">
	<param name="Format"					value="
">
</object></comment><script>__ws__(__NSID__);</script> 







<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 