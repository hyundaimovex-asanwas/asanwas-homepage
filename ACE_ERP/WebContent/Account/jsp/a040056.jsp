
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	���ݰ�꼭����/�ΰ������Ը�����
+ ���α׷� ID	: A040002
+ �� �� �� ��	: ��ȸ|���|���|��ǥ����|��ǥ��ȸ
+ �� �� �� ��	: �̼���
+ �� �� �� ��	: a040002_s1_e,a040002_s2
------------------------------------------------------------------------------
+ �� �� �� ��  :	�˾�â ���� �� �������� ����   
+ ��   ��  ��  :  �̹���
+ �� �� �� ��  :  2006.10
-----------------------------------------------------------------------------
+ �� �� �� �� :	�ΰ������� ���� ���  (  A040002 ==> A040099�� �ӽ� �����)           
+ ��   ��  �� : ��  ��  ��
+ �� �� �� �� : 2008.06.11
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� �� :	�����ڵ� �� ���ڹ��� ���� �ڵ� �߰�    
+ ��   ��  �� : ��  ��  ��
+ �� �� �� �� : 2008.06.11
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� �� :	���ڼ��ݰ�꼭 ���� ���� eBill����    
+ ��   ��  �� : ��  ��  ��
+ �� �� �� �� : 2017.01.25
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� ��     :  2017.04.14 
+ �� �� �� ��     :  �׸��忡 �Աݿ����� �߰� 
+ �� �� �� ��	:
-----------------------------------------------------------------------------
+ �� �� �� ��     :  2017.06.22 
+ �� �� �� ��     : ������� �߰�  
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ΰ������Ը�����</title>

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
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd; //�μ��ڵ�
var gs_deptnm = gdeptnm; //�μ���
var gs_chk = gs_deptcd;
var g_usrnm = gusrnm;
var gs_empno = "";
var g_login	

var gs_empnos="";
var gs_deptcds="";

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	gcte_disp.ActiveIndex=2;
	ln_DispChk(1);
	ln_Before();	//����ȸ

	if(gs_chk==null) gs_chk = "";

}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(e){
		
	ln_QueryChk();

	if (e=="A") {	//��꼭��
		var str1 = gclx_staxiodiv.BindColVal;	//���Ը��ⱸ��
		var str2 = gclx_cocode.BindColVal;		//�����
		var str3 = gcem_staxdatfr.text;			//��꼭�Ⱓ from
		var str4 = gcem_staxdatto.text;			//��꼭�Ⱓ to
		var str5 = gcem_vendcd.text;			//�ŷ�ó�ڵ�
		var str6 = "";		                    //�ͼӱ���
		var str7 = "";		                    //�ΰ�������
		var str8 = gclx_taxprtyn.BindColVal;	//���࿩��
		var str9 = gclx_fsstat.BindColVal;		//��ǥ����
		var str10 = gcem_vendnm.text;			//�ŷ�ó��
		var str11 = gclx_fdcode.BindColVal;		//�����ڵ�
		var str12 = gs_userid;	                //�α���
		var str13 = "";	                        //���а�
		var str17 =gclx_amend_code.BindColVal;	
		var str21 = gclx_ebillgb.BindColVal;
		var str22 = gclx_taxsts.BindColVal;


		if (str1 =="1") {
			str1 = "A";
			str6 = gclx_staxdiv.BindColVal;
			str7 = gclx_staxknd.BindColVal;
		}else if (str1 =="2") {
			str1 = "B";
			str6 = gclx_staxdiv_2.BindColVal;
			str7 = gclx_staxknd_2.BindColVal;
		}

   
       if(hid_login.value=="M"){ //�ΰ��� ������
			str13 = "1";	
		}else{
           str13 = "2";            //�Ϲݻ����	
		}
    
		
       gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee?v_str1="+str1
		                                                                        +"&v_str2="+str2
																				+"&v_str3="+str3+"&v_str4="+str4
																				+"&v_str5="+str5+"&v_str6="+str6
																				+"&v_str7="+str7+"&v_str8="+str8
																				+"&v_str9="+str9+"&v_str10="+str10
																				+"&v_str11="+str11+"&v_str12="+gs_chk
		                                										+"&v_str13="+str12+"&v_str14="+str13
																				+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
																				+"&v_str17="+str17+"&v_str21="+str21
       																			+"&v_str22="+str22;
		gcds_data1.Reset();
		var row  = gcds_data1.rowposition;
		var temp = gcds_temp.rowposition;

	}else if(e=="B") {	//��ǥ��
		var str1 = gclx_staxiodiv2.BindColVal;	    //���Ը��ⱸ��
		var str2 = gclx_cocode2.BindColVal;			//�����
		var str3 = gcem_staxdatfr2.text;			//��꼭�Ⱓ from
		var str4 = gcem_staxdatto2.text;			//��꼭�Ⱓ to
		var str5 = gcem_vendcd2.text;				//�ŷ�ó�ڵ�
		var str6 = "";		                        //�ͼӱ���
		var str7 = "";		                        //�ΰ�������
		var str8 = gclx_taxprtyn2.BindColVal;		//���࿩��
		var str9 = gclx_fsstat2.BindColVal;			//��ǥ����
		var str10 = gcem_vendnm2.text;				//�ŷ�ó��
		var str11 = gclx_fdcode2.BindColVal;		//�����ڵ�
		var str12 = gs_userid;	                    //�α���
		var str17 = gclx_amend_code2.BindColVal;	
		var str21 = gclx_ebillgb2.BindColVal;
		var str22 = gclx_taxsts2.BindColVal;
		
		if (str1 =="1") {       //����
			str1 = "A";
			str6 = gclx_staxdiv2.BindColVal;
			str7 = gclx_staxknd2.BindColVal;
		}else if (str1 =="2") { //����
			str1 = "B";
			str6 = gclx_staxdiv_3.BindColVal;
			str7 = gclx_staxknd2_2.BindColVal;		
  	    }
  
		if(hid_login.value=="M"){ //�ΰ��� ������
			str13 = "1";	
		}else{
           str13 = "2";            //�Ϲݻ����	
		}
    
       gcds_data1_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+"?v_str1="+str1+"&v_str2="+str2
											+"&v_str3="+str3+"&v_str4="+str4
											+"&v_str5="+str5+"&v_str6="+str6
											+"&v_str7="+str7+"&v_str8="+str8
											+"&v_str9="+str9+"&v_str10="+str10
											+"&v_str11="+str11+"&v_str12="+gs_chk
											+"&v_str13="+str12+"&v_str14="+str13
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17+"&v_str21="+str21
      										+"&v_str22="+str22;
		gcds_data1_2.Reset();
	}
}

/******************************************************************************
	Description : ����μ� CHK
******************************************************************************/
function ln_QueryChk(){
	for(var i=1;i<=gcds_temp1.countrow;i++){
		if(gs_deptcd==gcds_temp1.namevalue(i,"DEPTCD")){
			gs_chk="";
		}
	}
}


/******************************************************************************
	Description : ��ȸ - ����(������) ���
******************************************************************************/
function ln_Query2(e){
	if (e=="A") {
		var str1 = gclx_staxiodiv.BindColVal;	//���Ը��ⱸ��
		var str2 = gclx_cocode.BindColVal;			//�����
		var str3 = gcem_staxdatfr.text;				//��꼭�Ⱓ from
		var str4 = gcem_staxdatto.text;				//��꼭�Ⱓ to
		var str5 = gcem_vendcd.text;					//�ŷ�ó�ڵ�
		var str6 = gclx_staxdiv.BindColVal;		//�ͼӱ���
		var str7 = gclx_staxknd.BindColVal;		//�ΰ�������
		var str17 =gclx_amend_code.BindColVal;	

		if (str1 =="1") str1 = "A";       //����
		else if (str1 =="2") str1 = "B";  //����

    /*&&
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_e"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds;
    */
    gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17;
		gcds_data2.Reset(); 
	}else if (e=="B") {
		var str1 = gclx_staxiodiv2.BindColVal;	//���Ը��ⱸ��
		var str2 = gclx_cocode2.BindColVal;			//�����
		var str3 = gcem_staxdatfr2.text;				//��꼭�Ⱓ from
		var str4 = gcem_staxdatto2.text;				//��꼭�Ⱓ to
		var str5 = gcem_vendcd2.text;						//�ŷ�ó�ڵ�
		var str6 = gclx_staxdiv2.BindColVal;		//�ͼӱ���
		var str7 = gclx_staxknd2.BindColVal;		//�ΰ�������
		var str17 =gclx_amend_code2.BindColVal;	

		if (str1 =="1") str1 = "A";
		else if (str1 =="2") str1 = "B";

    /*&&
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_e"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds;
     */

    gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s1_ee"
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4
											+ "&v_str5="+str5+"&v_str6="+str6
											+ "&v_str7="+str7+"&v_str12="+gs_deptcd
											+"&v_str15="+gs_empnos+"&v_str16="+gs_deptcds
											+"&v_str17="+str17;
		gcds_data2.Reset();
	}
	
}

/******************************************************************************
	Description : ��ȸ - ���ݰ�꼭 Detail[��ǥ����]
******************************************************************************/
function ln_Query3(e,p){
	if(e=="A") {
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s2?v_str1="+p;
		gcds_data3.Reset(); 
	}else if(e=="B") {
		gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s2?v_str1="+p;
		gcds_data3.Reset(); 
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
function ln_Save() {
  var chkgb=0;
	for (var i=1;i<=gcds_data1_2.countrow;i++){
		if(gcds_data1_2.namevalue(i,"CHK")=="T"){
			chkgb+=1;
		}
	}
	if(chkgb==0){
	  alert("���� �� �����Ͻʽÿ�.");
		return false;
	}


  gcds_gb_data.clearall();
  ln_SetDataHeader2()
	for(var w=1;w<=gcds_data1_2.countrow;w++){
		if(gcds_data1_2.namevalue(w,"CHK")=="T"){	
			gcds_gb_data.addrow();     
            gcds_gb_data.namevalue(gcds_gb_data.rowposition,"CHK")=gcds_data1_2.namevalue(w,"CHK");
			gcds_gb_data.namevalue(gcds_gb_data.rowposition,"TAXNBR")=gcds_data1_2.namevalue(w,"TAXNBR");
			gcds_gb_data.namevalue(gcds_gb_data.rowposition,"GUBUN")=gcds_data1_2.namevalue(w,"GUBUN");
		}
	}
	gctr_data1.KeyValue   = "Account.a040002_t4(I:USER=gcds_gb_data)";
	gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t4";
	gctr_data1.post();
}

/******************************************************************************
	Description : ����
	2008.06.12  : ������ ���� �Ǻ��� �����Ѵ�. 
	2009.07.10  : 
******************************************************************************/
function ln_Delete(e){
  var strFdcode ="";
	var strFsdat ="";
	var strFsnbr="";
	var str_taxnbr ="";

	if(e=="A"){
		if(gcds_data1.countrow>0){
			for(var w=1;w<=gcds_data1.countrow;w++) {
        strFdcode =fn_trim(gcds_data1.namevalue(w,"FDCODE"));
			  strFsdat = fn_trim(gcds_data1.namevalue(w,"FSDAT"));
			  strFsnbr=fn_trim(gcds_data1.namevalue(w,"FSNBR"));
				str_taxnbr = gcds_data1.namevalue(w,"TAXNBR");
				///alert("strFdcode::::"+strFdcode+"strFsdat::::"+strFsdat+"strFsnbr::::"+strFsnbr);
				if (gcds_data1.namevalue(w,"CHK") == "T" && strFsnbr == "") {	
					
					//if(gs_userid=="6070001"){ 
					//	alert("DTI_STATUS::::"+gcds_data1.namevalue(w,"DTI_STATUS"));
					//}

          //2009.07.10 ����üũ //���Űź�, ���ſϷ�, ������ ��츸 ��������
					if(gcds_data1.namevalue(w,"DTI_STATUS")!="R"&&gcds_data1.namevalue(w,"DTI_STATUS")!="O"&&gcds_data1.namevalue(w,"DTI_STATUS")!=""&&gcds_data1.namevalue(w,"DTI_STATUS")!="W"){
						alert("���°� ���� �Ұ����� ���Դϴ�.");
						return;
					}

					if(confirm("���� �Ͻðڽ��ϱ�?")){	
						gcds_data1.deleterow(w);
						gctr_data1.KeyValue   = "Account.a040002_t1(I:USER=gcds_data1)";
						gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t1";
						gctr_data1.Parameters = "v_str1="+str_taxnbr;
						gctr_data1.post();
						ln_Query('A');
					}
				}else if(gcds_data1.namevalue(w,"CHK") == "T" && (strFsnbr!= ""&& strFsnbr != undefined)) {
					//2008.06.11 �������� ��� ��������� �ǿ� ���� ���ݰ�꼭�� ���� ������.			  
					//��ǥ���� ���� ���ݰ�꼭 ã�Ƽ� ��ǥ��ȣ�� ���ݰ�꼭 ������.
          if(hid_login.value=="M"&&gcds_data1.namevalue(w,"FSSTAT")=="N"){ //�������̰�  ������Ұ�
             
            //������ȣ�� ���� ��� ���� �� �� ����.
						if(strFdcode==""||strFsdat==""||strFsnbr==""){
							alert("������ȣ�� Ȯ���Ͻʽÿ�.");
						}
            if (confirm("������ ���� �Ͻðڽ��ϱ�?")){	
							gcds_data1.deleterow(w);
							gctr_data1.KeyValue   = "Account.a040002_t2(I:USER=gcds_data1)";
							gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t2";
							gctr_data1.Parameters = "v_str1="+str_taxnbr+",v_str2="+strFdcode+",v_str3="+strFsdat+",v_str4="+strFsnbr;
							//prompt('',gcds_data1.text);
							
							gctr_data1.post();
							ln_Query('A');
						}
					}else{
						alert("��ǥ����� ���� ������ �� �����ϴ�.");
						return false;
					}
				}
			}
		}else alert("������ ������ �����ϴ�.");
	}else if(e=="B"){
		if(gcds_data1_2.countrow>0){
			for(var w=1;w<=gcds_data1_2.countrow;w++) {
			  strFsnbr =fn_trim(gcds_data1_2.namevalue(w,"FSNBR"));
				if (gcds_data1_2.namevalue(w,"CHK") == "T" && strFsnbr == "") {	
					var str_taxnbr = gcds_data1_2.namevalue(w,"TAXNBR");
				
          //if(gs_userid=="6070001"){ 
					//	alert("DTI_STATUS::::"+gcds_data1_2.namevalue(w,"DTI_STATUS"));
					//}

					if(gcds_data1_2.namevalue(w,"DTI_STATUS")!="R"&&gcds_data1_2.namevalue(w,"DTI_STATUS")!="O"&&gcds_data1_2.namevalue(w,"DTI_STATUS")!=""&&gcds_data1_2.namevalue(w,"DTI_STATUS")!="W"){
						alert("���°� ���� �Ұ����� ���Դϴ�2.");
						return;
					}

					if (confirm("���� �Ͻðڽ��ϱ�?")){	
						gcds_data1_2.deleterow(w);
						gctr_data1.KeyValue   = "Account.a040002_t1(I:USER=gcds_data1_2)";
						gctr_data1.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_t1";
						gctr_data1.Parameters = "v_str1="+str_taxnbr;
						gctr_data1.post();
						ln_Query('B');
					}
				}else if(gcds_data1_2.namevalue(w,"CHK") == "T" &&(strFsnbr!= ""&& strFsnbr!= undefined)) {
					alert("��ǥ����� ���� ������ �� �����ϴ�.");
					return false;
				}
			}
		}else alert("������ ������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
 
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(e){
	if(e=="A") {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_data1.GridToExcel("���Ը�����(��꼭��)","",2);
	}else if(e=="B") {
		if (gcds_data1_2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_data2.GridToExcel("���Ը�����(��ǥ��)","",2);
	}
}

/******************************************************************************
	Description : ��� - ��꼭��
******************************************************************************/
function ln_Print(){
	ln_SetDataHeader();
	if(gcds_data1.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else{
		for(i=1;i<=gcds_data1.countrow;i++){
			gcds_print.ImportData(gcds_data1.ExportData(i,1,false));
			gcds_print.namevalue(1,"PTITLE")   = "�ΰ������Ը����� - "+gclx_staxiodiv.text;
			gcds_print.namevalue(1,"DATANM")   = "�ΰ������� : "+gclx_staxknd.text+",  �ͼӱ��� : "+gclx_staxdiv.text
			                                   + ",  ��ǥ���� : "+gclx_fsstat.text
			gcds_print.namevalue(1,"FSNBRDT")  = gcds_data1.namevalue(i,"FSDAT")+gcds_data1.namevalue(i,"FSNBR");
			gcds_print.namevalue(1,"FDCODENM") = gclx_fdcode.text;
			gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr.text + gcem_staxdatto.text;
			gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		}
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : ��� - ��ǥ��
******************************************************************************/
function ln_Print2(){
	ln_SetDataHeader();
	if(gcds_data1_2.countrow<1) {
		alert("����� ������ �����ϴ�.");
	}else{
		for(i=1;i<=gcds_data1_2.countrow;i++){
			gcds_print.ImportData(gcds_data1_2.ExportData(i,1,false));
			gcds_print.namevalue(1,"PTITLE")   = "�ΰ������Ը����� - "+gclx_staxiodiv2.text;
			gcds_print.namevalue(1,"DATANM")   = "�ΰ������� : "+gclx_staxknd2.text+",  �ͼӱ��� : "+gclx_staxdiv2.text
			                                   + ",  ��ǥ���� : "+gclx_fsstat2.text
			gcds_print.namevalue(1,"FSNBRDT")  = gcds_data1_2.namevalue(i,"FSDAT")+gcds_data1_2.namevalue(i,"FSNBR");
			gcds_print.namevalue(1,"FDCODENM") = gclx_fdcode2.text;
			gcds_print.namevalue(1,"CURDT")		 = gcem_staxdatfr2.text + gcem_staxdatto2.text;
			gcds_print.namevalue(1,"CURDT2")	 = gs_date;
		}
		gcrp_print.preview();
	}
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_temp = "CHK:STRING,TAXNBR:STRING,COCODE:STRING,TAXIODIV:STRING,"
						 + "TAXDIV:STRING,TAXIODIVNM:STRING,TAXDIVNM:STRING,TAXKND:STRING,"
						 + "TAXKNDNM:STRING,VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,"
						 + "TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,"
						 + "REMARK:STRING,TAXCDNBR:STRING,TAXPRTYN:STRING,FSDAT:STRING,"
						 + "FSNBR:STRING,FSNUM:STRING,TAXCNT:DECIMAL,TAXKIDIV:STRING,"
						 + "VD_DIRECT:STRING,BSNS_CND:STRING,BSNS_KND:STRING,COID:STRING,"
						 + "COSANG:STRING,ADDNM:STRING,FSSTAT:STRING,FDCODE:STRING,"
						 + "DEPTCD:STRING,DEPTNM:STRING,TREECD:STRING,EMPNO:STRING,"
						 + "EMPNMK:STRING,ATCODE:STRING,ATKORNAM:STRING,TAXNBR_R:STRING,"
						 + "FDCODENM:STRING,CURDT:STRING,CURDT2:STRING,PTITLE:STRING,"
						 + "DATANM:STRING";
	gcds_print.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader2(){
	var s_temp = "CHK:STRING,TAXNBR:STRING,GUBUN:STRING";					
	gcds_gb_data.SetDataHeader(s_temp);
}
/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print22(){
	var chk = gcte_disp.ActiveIndex;
	if (chk =="2") {
		if (gclx_staxiodiv2.BindColVal !="") {
			ln_Query2('B');			
			ln_RptFormat2();
		}
	}
}

/******************************************************************************
	Description : ��� - ���ݰ�꼭
******************************************************************************/
function ln_RptFormat2() {

	var ls_for = "";

	ls_for += " <B>id=DHeader ,left=0,top=0 ,right=2869 ,bottom=329 ,face='Arial' ,size=10 ,penwidth=1																																																								";
	ls_for += " <X>left=1088 ,top=34 ,right=1925 ,bottom=109 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>																																													";
	ls_for += " <X>left=1078 ,top=22 ,right=1913 ,bottom=100 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>																																													";
	ls_for += " <T>id='����' ,left=1953 ,top=231 ,right=2759 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='����ڹ�ȣ' ,left=1084 ,top=231 ,right=1366 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>								";
	ls_for += " <T>id='����' ,left=1378 ,top=231 ,right=1941 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='��ǥ��ȣ' ,left=309 ,top=231 ,right=528 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='�ŷ�ó��' ,left=541 ,top=231 ,right=1072 ,bottom=275 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='�ŷ�����' ,left=78 ,top=231 ,right=297 ,bottom=275 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>																		";
	ls_for += " <L> left=63 ,top=219 ,right=2769 ,bottom=219 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>																																																				";
	ls_for += " <T>id='�ͼӱ���' ,left=309 ,top=278 ,right=903 ,bottom=322 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>										";
	ls_for += " <T>id='����' ,left=916 ,top=278 ,right=1072 ,bottom=322 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>												";
	ls_for += " <T>id='�ΰ�������' ,left=1084 ,top=278 ,right=1322 ,bottom=322 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>								";
	ls_for += " <T>id='����' ,left=1378 ,top=278 ,right=1941 ,bottom=322 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='�ݾ�' ,left=1953 ,top=278 ,right=2203 ,bottom=322 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <T>id='�հ�' ,left=2478 ,top=278 ,right=2759 ,bottom=322 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	ls_for += " <L> left=63 ,top=328 ,right=2772 ,bottom=328 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>																																																				";
	ls_for += " <T>id='����' ,left=2216 ,top=278 ,right=2466 ,bottom=322 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>											";
	
	var strfr = gcem_staxdatfr2.text;
	var strto = gcem_staxdatto2.text;
	var syyyy = strfr.substring(0,4);
	var smm   = strfr.substring(4,6);
	var sdd   = strfr.substring(6,8);
	var tyyyy = strto.substring(0,4);
	var tmm   = strto.substring(4,6);
	var tdd   = strto.substring(6,8);
	ls_for += " <C>id='(  �ŷ����� : "+syyyy+"�� "+smm+"�� "+sdd+"��  ~  "+tyyyy+"�� "+tmm+"�� "+tdd+"��  )', left=922, top=119, right=2066, bottom=166 ,mask='(  �ŷ����� : XXXX�� XX�� XX��  ~  XXXX�� XX�� XX��  )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
	
	var strio = gclx_staxiodiv2.BindColVal;	//���Ը��ⱸ��
	var strionm = "";
	if (strio =='1')			{	strionm += " �� ��";
	}else if(strio =='2') { strionm += " �� ��";	}
	ls_for += " <T>id='"+strionm+"' ,left=1081 ,top=25 ,right=1906 ,bottom=87 ,face='HY�߰��' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>													";
	ls_for += " </B>																																																																																																";
	ls_for += " <B>id=default ,left=0,top=0 ,right=2869 ,bottom=91 ,face='Arial' ,size=10 ,penwidth=1																																																								";
	ls_for += " <C>id='BSNS_CND', left=1378, top=0, right=1941, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='VEND_ID', left=1084, top=0, right=1366, bottom=44, align='left' ,mask='XXX-XX-XXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>	";
	ls_for += " <C>id='VEND_NM', left=541, top=0, right=1072, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='FSNBR', left=309, top=0, right=528, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>												";
	ls_for += " <C>id='TAXDAT', left=78, top=0, right=297, bottom=44 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXDIVNM', left=309, top=47, right=903, bottom=91, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='REMARK', left=1378, top=47, right=1941, bottom=91, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>										";
	ls_for += " <C>id='TAXSUM', left=1953, top=47, right=2203, bottom=91, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXVATAMT', left=2216, top=47, right=2466, bottom=91, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>								";
	ls_for += " <C>id='BSNS_KND', left=1953, top=0, right=2759, bottom=44, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXTOT', left=2478, top=47, right=2759, bottom=91, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXKNDNM', left=1084, top=47, right=1322, bottom=91, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>									";
	ls_for += " <C>id='TAXIODIVNM', left=916, top=47, right=1072, bottom=91, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>								";
	ls_for += " </B>																																																																																																";
	ls_for += " <B>id=Footer ,left=0 ,top=1856 ,right=2869 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1																																																					";
	ls_for += " <L> left=63 ,top=0 ,right=2769 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>																																																					";
	ls_for += " <I>id='../../common/img/icon.jpg' ,left=2413 ,top=3 ,right=2791 ,bottom=84</I>																																																											";
	ls_for += " </B>																																																																																																";

	gcrp_print.format = ls_for + gcrp_print.format;

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 
	gclx_fsstat.index = 0;
	gclx_fsstat2.index = 0;

	gclx_amend_code.index = 0;
	gclx_amend_code2.index = 0;

	if(gs_userid=="6070001" || gs_userid=="2020009"){
		sp0.style.display = "";
	}else{
		sp0.style.display = "none";
	}

  
  /******************************
	//2009.09.03. ���Ѱ��� �߰��� ����.
	//login�ڿ� �ΰ��� ������Ȯ��
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gs_userid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
	}else{
		hid_login.value="";
	}
	******************************/

	//��꼭��
	gclx_cocode.BindColVal		= "02";							//�����
	gcem_staxdatfr.text			= gs_date2 + "01";	//��꼭�Ⱓ from
	gcem_staxdatto.text			= gs_date;					//��꼭�Ⱓ to
	//��ǥ��
	gclx_cocode2.BindColVal	= "02";							//�����
	gcem_staxdatfr2.text		= gs_date2 + "01";	//��꼭�Ⱓ from
	gcem_staxdatto2.text		= gs_date;					//��꼭�Ⱓ to

	//�����ڵ�
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//�ŷ�ó�ڵ�[�˻�]  
	//gcds_vendcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>vendcode_s1?v_str1="; 
	//gcds_vendcd.Reset();
	
	//�ͼӱ���[����]
	gcds_staxdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	gcds_staxdiv.Reset();

	//�ͼӱ���[����]
	gcds_staxdiv2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1215"; 
	gcds_staxdiv2.Reset();

	//�ΰ�������[����]
	gcds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_staxknd.Reset();

	//�ΰ�������[����]
	gcds_staxknd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_staxknd2.Reset();

	//����
	gcds_deptprt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>hcdeptprt_s1?"; 
	gcds_deptprt.Reset();

	//����μ� chk
	gcds_temp1.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040002_s3?v_str1="; 
	gcds_temp1.Reset();

	//������ڵ�[ȸ����]
	gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>confirm_popup_s1?v_str2="+gs_deptcd+"&v_str3="+gs_userid;
	gcds_empno.Reset();


	ln_Authority();
}

/******************************************************************************
	Description : ������ȸ
******************************************************************************/
function ln_Authority(){
	
	//login�ڿ� �ΰ��� ������Ȯ��---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
		gs_empnos="";
		gs_deptcds="";
	}else{
		hid_login.value="";	
	
		//�α������� ����.-----------------------------------------------------------------------
		gcds_right.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0902&v_str3="+gusrid;
		//prompt(this,gcds_right.DataID);
		gcds_right.Reset();

		for(i=1;i<=gcds_right.countrow;i++){
			if(gcds_right.namevalue(i,"CDREMARK")!=""){   // ���κ����� ������.empno
				gs_empnos=gs_empnos+gcds_right.namevalue(i,"CDREMARK")+"','";
			}else if(gcds_right.namevalue(i,"GBCD")!=""){ // �μ������� ������.deptcd
				gs_deptcds=gs_deptcds+gcds_right.namevalue(i,"GBCD")+"','"; 
			}
		}

		//�Ǹ������� �޸��� �����.
		if(gs_empnos.length>1){
			gs_empnos = gs_empnos.substring(0,gs_empnos.length-3);
		}

		if(gs_deptcds.length>1){
			gs_deptcds = gs_deptcds.substring(0,gs_deptcds.length-3);
		}
		//------------------------------------------------------------------------------------
	} 
}

/******************************************************************************
	Description : ã�� - �ŷ�ó�ڵ�
******************************************************************************/
function ln_Popup(p){
  var arrVAT	= new Array(); 
	if(p=="A") {	//��꼭��
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
		}
	}else if(p=="B") {	//��ǥ��
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd2.text  = arrParam[0];
			gcem_vendnm2.text	= arrParam[1];
		} else {
			gcem_vendcd2.text	= "";
			gcem_vendnm2.text	= "";
		}
	}
}

/***********************************************************************************************
	Description : ��ǥ��ȸ
	parameter   : fcod - �����ڵ�, fsdt - ��ǥ����, fnbr - ��ǥ��ȣ
**********************************************************************************************/
function ln_TaxQuery(e){
	if (e=="A") {	//��꼭��
		for(var i=1; i<=gcds_data1.countrow;i++) {
			if(gcds_data1.namevalue(i,"CHK") == "T" && gcds_data1.namevalue(i,"FSNBR") != "") {	
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;

				arrParam[0] = gcds_data1.namevalue(i,"FDCODE");
				arrParam[1] = gcds_data1.namevalue(i,"FSDAT");
				arrParam[2] = gcds_data1.namevalue(i,"FSNBR");

				strURL = "./slipno_popup.jsp";
				strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
			}else if (gcds_data1.namevalue(i,"CHK") == "T" && gcds_data1.namevalue(i,"FSNBR") == "") {
				alert("���� �� ��ǥ�� �����ϴ�.");
			}
		}
	}else if(e=="B") {	//��ǥ��
		for(var i=1; i<=gcds_data1_2.countrow;i++) {
			if(gcds_data1_2.namevalue(i,"CHK") == "T" && gcds_data1_2.namevalue(i,"FSNBR") != "") {	
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;

				arrParam[0] = gcds_data1_2.namevalue(i,"FDCODE");
				arrParam[1] = gcds_data1_2.namevalue(i,"FSDAT");
				arrParam[2] = gcds_data1_2.namevalue(i,"FSNBR");

				strURL = "./slipno_popup.jsp";
				strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
			}else if (gcds_data1_2.namevalue(i,"CHK") == "T" && gcds_data1_2.namevalue(i,"FSNBR") == "") {
				alert("���� �� ��ǥ�� �����ϴ�.");
			}
		}
	}
}

/***********************************************************************************************
	Description : ��ǥ���� - FSLIPMST
**********************************************************************************************/
function ln_TaxIssue(e){
	if (e=="A") {	//��꼭��
		var schk = "F";
		for(var w=1;w<=gcds_data1.countrow;w++) {
			if (gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") == "") {	
				var str_taxnbr = gcds_data1.namevalue(w,"TAXNBR");
				var str_chk = "";
				if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") { 
					str_chk = "A";
				}else if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") { 
					str_chk = "B";
				}
				ln_Query3(str_chk,str_taxnbr);	//���ݰ�꼭 Detail Query
			}else if (gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") != "") {
				alert("��ǥ�� �̹� ����Ǿ����ϴ�.");
			}

			if(gcds_data1.namevalue(w,"CHK") !="F"){
				schk = "T";
			}
		}
		if (schk=="F") alert("���õ� ������ �����ϴ�.");
	}else if(e=="B") {
		var bchk = "F";
		for(var w=1;w<=gcds_data1_2.countrow;w++) {
			if (gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") == "") {	
				var str_taxnbr = gcds_data1_2.namevalue(w,"TAXNBR");
				var str_chk = "";
				if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") { 
					str_chk = "A";
				}else if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") { 
					str_chk = "B";
				}
				ln_Query3(str_chk,str_taxnbr);	//���ݰ�꼭 Detail Query
			}else if (gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") != "") {
				alert("��ǥ�� �̹� ����Ǿ����ϴ�.");
			}

			if(gcds_data1_2.namevalue(w,"CHK") !="F"){
				bchk = "T";
			}
		}
		if (bchk=="F") alert("���õ� ������ �����ϴ�.");
	}
}

/***********************************************************************************************
	Description : ��꼭��-[��ǥ���� - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = ����,					arrParam[2]  = ��ǥ����,
	              arrParam[3]  = ��ǥ��ȣ,		arrParam[4]  = ��ǥ����(N),		arrParam[5]  = �μ�,
	              arrParam[6]  = �μ���,			arrParam[7]  = ����ڻ��,		arrParam[8]  = ����ڸ�,
	              arrParam[9]  = ����,				arrParam[10] = ������ڵ�,		arrParam[11] = ��������,
	              arrParam[12] = DTL�հ�ݾ�
	----------------------------------------------------------------------------------------------
	Description : ��꼭��-[��ǥ���� - FSLIPDTL]
	parameter   : arrParam[0]  = �����ڵ�,		arrParam[1]  = ������,				arrParam[2]  = �ŷ�ó�ڵ�,
	              arrParam[3]  = �ŷ�ó��,		arrParam[4]  = �μ��ڵ�,			arrParam[5]  = �μ���,
	              arrParam[6]  = ����,				arrParam[7]  = �����ݾ�,			arrParam[8]  = �뺯�ݾ�,
	              arrParam[9]  = ���ݰ�꼭��ȣ, 
								arrParam[10] = ������(001:���ݰ�꼭,  002:��꼭,    003:�ſ�ī��,
								                      004:���ݼҵ����,005:���̿�����,006:���ְ���)
								arrParam[11] = �ҼӺ���,		arrParam[12] = ��꼭����
**********************************************************************************************/
function ln_TaxIssue2(){
	for(var w=1; w<=gcds_data1.countrow;w++) {
		if(gcds_data1.namevalue(w,"CHK") == "T" && gcds_data1.namevalue(w,"FSNBR") == "") {	
			
			//�����ڵ�
			var str_tree = gcds_data1.namevalue(w,"DEPTCD");
			var str_deps = "";
			for(var g=1;g<=gcds_deptprt.countrow;g++) {
				var str_dep = gcds_deptprt.namevalue(g,"DEPTCD");
				var str_lel = gcds_deptprt.namevalue(g,"LEVEL");
				var str_tee = gcds_deptprt.namevalue(g,"TREECD");
				if(str_dep.substring(0,1) == str_tree.substring(0,1)) {
					str_deps = gcds_deptprt.namevalue(g,"DEPTCD");
				}
			}

			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;

			/*��ǥ - FSLIPMST*/
			arrParam[0]  = "T";
			arrParam[1]  = gcds_data1.namevalue(w,"FDCODE");	//gclx_fdcode.bindcolval;
			arrParam[2]  = gcds_data1.namevalue(w,"FSDAT");		//gcem_fsdat.text;
			arrParam[3]  = gcds_data1.namevalue(w,"FSNBR");		//gcem_fsnbr.text;
			arrParam[4]  = "N";
			arrParam[5]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
			arrParam[6]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
			arrParam[7]  = gcds_data1.namevalue(w,"EMPNO");		//gclx_empno.bindcolval;
			arrParam[8]  = gcds_data1.namevalue(w,"EMPNMK");	//gclx_empno.text;
			//alert(arrParam[7]);
			//alert(arrParam[8]);
			arrParam[9]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
			arrParam[10] = gcds_data1.namevalue(w,"COCODE");	//gclx_cocode.CodeValue;
			arrParam[11] = gcds_data1.namevalue(w,"TAXKND");	//str_deps;	//str_tree.substring(0,4)+"0000";
			arrParam[12] = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;

			/*��ǥ - FSLIPDTL*/
			var j=1;
			for(var i=1;i<=gcds_data3.countrow;i++) {	
				j = j + 13;
				if(i==1) {
					arrParam[Number(j+1)]  = gcds_data1.namevalue(w,"ATCODE");		//gcem_atcode.text;
					arrParam[Number(j+2)]  = gcds_data1.namevalue(w,"ATKORNAM");	//txt_atkornam.value;
					arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");		//gcem_vendcd.text;
					arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");		//txt_fdcodenm.value;
					arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");		//gclx_dept.bindcolval;
					arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");		//gclx_dept.text;
					arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");		//txt_remark.value;
					if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
						arrParam[Number(j+8)]  = 0;
						arrParam[Number(j+9)]  = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//����->�뺯[2]
					}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
						arrParam[Number(j+8)]  = gcds_data1.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//����->����[1]
						arrParam[Number(j+9)]  = 0;
					}
					arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
					arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
					arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//�߰�-�μ��ڵ�
					arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//�߰�-��꼭����

					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*���ݰ�꼭(detail)-���ް���*/
						j = j + 13;
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";	
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//�߰�
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*�ΰ���ġ��[detail]*/
						j = j + 13;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "1112300";//����-"2101100";
							arrParam[Number(j+2)]  = "���޺ΰ���ġ��";//����-"�����ΰ���ġ��";
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "2101100";//����-"2101200";
							arrParam[Number(j+2)]  = "�����ΰ���ġ��";//����-"�ΰ���ġ��������";
						}
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");			//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");				//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");			//�߰�
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

				}else{
					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*���ݰ�꼭(detail)-���ް���*/
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");		//�߰�
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*�ΰ���ġ��[detail]*/
						j = j + 13;
						if (gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "1112300";//����-"2101100";
							arrParam[Number(j+2)]  = "���޺ΰ���ġ��";//����-"�����ΰ���ġ��";
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "2101100";//����-"2101200";
							arrParam[Number(j+2)]  = "�����ΰ���ġ��";//����-"�ΰ���ġ��������";
						}
						arrParam[Number(j+3)]  = gcds_data1.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1.namevalue(w,"REMARK");	//txt_remark.value;
						if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1.namevalue(w,"TAXNBR");			//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1.namevalue(w,"GBCD");				//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1.namevalue(w,"DEPTCD");			//�߰�
						arrParam[Number(j+13)] = gcds_data1.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}
				}
			}
			
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
			ln_Query();
		}
	}
}

/***********************************************************************************************
	Description : ��ǥ��-[��ǥ���� - FSLIPMST]
	parameter   : arrParam[0]  = "T",					arrParam[1]  = ����,					arrParam[2]  = ��ǥ����,
	              arrParam[3]  = ��ǥ��ȣ,		arrParam[4]  = ��ǥ����(N),		arrParam[5]  = �μ�,
	              arrParam[6]  = �μ���,			arrParam[7]  = ����ڻ��,		arrParam[8]  = ����ڸ�,
	              arrParam[9]  = ����,				arrParam[10] = ������ڵ�,		arrParam[11] = �����ڵ�,
	              arrParam[12] = DTL�հ�ݾ�
	----------------------------------------------------------------------------------------------
	Description : ��ǥ��-[��ǥ���� - FSLIPDTL]
	parameter   : arrParam[0]  = �����ڵ�,		arrParam[1]  = ������,				arrParam[2]  = �ŷ�ó�ڵ�,
	              arrParam[3]  = �ŷ�ó��,		arrParam[4]  = �μ��ڵ�,			arrParam[5]  = �μ���,
	              arrParam[6]  = ����,				arrParam[7]  = �����ݾ�,			arrParam[8]  = �뺯�ݾ�,
	              arrParam[9]  = ���ݰ�꼭��ȣ, 
								arrParam[10] = ������(001:���ݰ�꼭,  002:��꼭,    003:�ſ�ī��,
								                      004:���ݼҵ����,005:���̿�����,006:���ְ���)
								arrParam[11] = �ҼӺ���,		arrParam[12] = ��꼭����
**********************************************************************************************/
function ln_TaxIssue2_2(){
	for(var w=1; w<=gcds_data1_2.countrow;w++) {
		if(gcds_data1_2.namevalue(w,"CHK") == "T" && gcds_data1_2.namevalue(w,"FSNBR") == "") {	
			
			//�����ڵ�
			var str_tree = gcds_data1_2.namevalue(w,"DEPTCD");
			var str_deps = "";
			for(var g=1;g<=gcds_deptprt.countrow;g++) {
				var str_dep = gcds_deptprt.namevalue(g,"DEPTCD");
				var str_lel = gcds_deptprt.namevalue(g,"LEVEL");
				var str_tee = gcds_deptprt.namevalue(g,"TREECD");
				if(str_dep.substring(0,1) == str_tree.substring(0,1)) {
					str_deps = gcds_deptprt.namevalue(g,"DEPTCD");
				}
			}
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;

			/*��ǥ - FSLIPMST*/
			arrParam[0]  = "T";
			arrParam[1]  = gcds_data1_2.namevalue(w,"FDCODE");	//gclx_fdcode.bindcolval;
			arrParam[2]  = gcds_data1_2.namevalue(w,"FSDAT");		//gcem_fsdat.text;
			arrParam[3]  = gcds_data1_2.namevalue(w,"FSNBR");		//gcem_fsnbr.text;
			arrParam[4]  = "N";
			arrParam[5]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
			arrParam[6]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
			arrParam[7]  = gcds_data1_2.namevalue(w,"EMPNO");		//gclx_empno.bindcolval;
			arrParam[8]  = gcds_data1_2.namevalue(w,"EMPNMK");	//gclx_empno.text;
			arrParam[9]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
			arrParam[10] = gcds_data1_2.namevalue(w,"COCODE");	//gclx_cocode.CodeValue;
			arrParam[11] = gcds_data1_2.namevalue(w,"TAXKND");		////str_deps;	//str_tree.substring(0,4)+"0000";
			arrParam[12] = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;

			/*��ǥ - FSLIPDTL*/
			var j=1;
			for(var i=1;i<=gcds_data3.countrow;i++) {	
				j = j + 13;
				if(i==1) {
					arrParam[Number(j+1)]  = gcds_data1_2.namevalue(w,"ATCODE");		//gcem_atcode.text;
					arrParam[Number(j+2)]  = gcds_data1_2.namevalue(w,"ATKORNAM");	//txt_atkornam.value;
					arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");		//gcem_vendcd.text;
					arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");		//txt_fdcodenm.value;
					arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");		//gclx_dept.bindcolval;
					arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");		//gclx_dept.text;
					arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");		//txt_remark.value;
					if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
						arrParam[Number(j+8)]  = 0;
						arrParam[Number(j+9)]  = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//����->�뺯[2]
					}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
						arrParam[Number(j+8)]  = gcds_data1_2.namevalue(w,"TAXTOT");	//gcem_taxtot.text;	//����->����[1]
						arrParam[Number(j+9)]  = 0;
					}
					arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
					arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
					arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//�߰�
					arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//�߰�-��꼭����

					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*���ݰ�꼭(detail)-���ް���*/
						j = j + 13;
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";	
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");	//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");		//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");	//�߰�
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*�ΰ���ġ��[detail]*/
						j = j + 13;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "1112300";//����-"2101100";
							arrParam[Number(j+2)]  = "���޺ΰ���ġ��";//����-"�����ΰ���ġ��";
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "2101100";//����-"2101200";
							arrParam[Number(j+2)]  = "�����ΰ���ġ��";//����-"�ΰ���ġ��������";
						}
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//�߰�
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

				}else{
					if (gcds_data3.namevalue(i,"TAXSUM") != "") {	/*���ݰ�꼭(detail)-���ް���*/
						arrParam[Number(j+1)]  = "";
						arrParam[Number(j+2)]  = "";
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXSUM");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");	//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");		//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");	//�߰�
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}

					if (gcds_data3.namevalue(i,"TAXVATAMT") != "") {	/*�ΰ���ġ��[detail]*/
						j = j + 13;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "1112300";//����-"2101100";
							arrParam[Number(j+2)]  = "���޺ΰ���ġ��";//����-"�����ΰ���ġ��";
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+1)]  = "2101100";//����-"2101200";
							arrParam[Number(j+2)]  = "�����ΰ���ġ��";//����-"�ΰ���ġ��������";
						}
						arrParam[Number(j+3)]  = gcds_data1_2.namevalue(w,"VEND_CD");	//gcem_vendcd.text;
						arrParam[Number(j+4)]  = gcds_data1_2.namevalue(w,"VEND_NM");	//txt_fdcodenm.value;
						arrParam[Number(j+5)]  = gcds_data1_2.namevalue(w,"DEPTCD");	//gclx_dept.bindcolval;
						arrParam[Number(j+6)]  = gcds_data1_2.namevalue(w,"DEPTNM");	//gclx_dept.text;
						arrParam[Number(j+7)]  = gcds_data1_2.namevalue(w,"REMARK");	//txt_remark.value;
						if (gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->�뺯[2] => �����ݾ�
							arrParam[Number(j+9)]  = 0;
						}else if(gcds_data1_2.namevalue(w,"TAXIODIVNM") == "����") {
							arrParam[Number(j+8)]  = 0;
							arrParam[Number(j+9)]  = gcds_data3.namevalue(i,"TAXVATAMT");	//����->����[1] => �뺯�ݾ�
						}
						arrParam[Number(j+10)] = gcds_data1_2.namevalue(w,"TAXNBR");		//gcem_taxnbr.text;
						arrParam[Number(j+11)] = gcds_data1_2.namevalue(w,"GBCD");			//gclx_taxknd.bindcolval;
						arrParam[Number(j+12)] = gcds_data1_2.namevalue(w,"DEPTCD");		//�߰�
						arrParam[Number(j+13)] = gcds_data1_2.namevalue(w,"TAXDAT");		//�߰�-��꼭����
					}
				}
			}
			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
			ln_Query('B');
		}
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 0-����, 1-����
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
			if (i==0) {
				gclx_staxknd.index=0;
				gclx_staxknd_2.index=0;
			}else{
				gclx_staxknd2.index=0;
				gclx_staxknd2_2.index=0;
			}
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
			if (i==1) {
				gclx_staxknd2.index=0;
				gclx_staxknd2_2.index=0;
			}else{
				gclx_staxknd.index=0;
				gclx_staxknd_2.index=0;
			}
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  <PARAM NAME="UseFilter" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data1_2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  <PARAM NAME="UseFilter" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_data3" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ�[�˻�] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_vendcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ŷ�ó�ڵ�[�˻�] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ͼӱ���[����] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdiv2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ͼӱ���[����] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ΰ�������[����] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxknd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �ΰ�������[����] -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_deptprt" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_temp1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_temp" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id="gcds_empno" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �α��� üũ -->
<comment id="__NSID__">
 <object  id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- ���Ѱ��� -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- ���Ѱ��� -->
<object id=gcds_gb_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	if (row<1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data1_2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for="gcds_data1_2" event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt1_2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
	if (row<1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row<1) {
		alert("����Ͻ� ������ �����ϴ�");
	}else{
		gcrp_print.preview();	//����(������) ���
	}
</script>

<script language="javascript" for="gcds_data3" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data3 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (gcds_data3.namevalue(1,"TAXNBR") != null) {
		var chk = gcte_disp.ActiveIndex;
		if (chk =="1") {
			ln_TaxIssue2();		//��꼭�� - ��ǥ������
		}else if (chk =="2") {
			ln_TaxIssue2_2();	//��ǥ��   - ��ǥ������
		}
	}else{
		alert("�����׸��� ��ϵ��� �ʾҽ��ϴ�.");
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); 
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
		gclx_fdcode2.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
		gclx_fdcode2.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_staxdiv" event="onloadCompleted(row,colid)">
	gcds_staxdiv.InsertRow(1);
	gcds_staxdiv.NameValue(1,"CDCODE")="";
	gcds_staxdiv.NameValue(1,"CDNAM")="��ü";
	gclx_staxdiv.index=0;
	gclx_staxdiv2.index=0;
</script>

<script language="javascript" for="gcds_staxdiv2" event="onloadCompleted(row,colid)">
	gcds_staxdiv2.InsertRow(1);
	gcds_staxdiv2.NameValue(1,"CDCODE")="";
	gcds_staxdiv2.NameValue(1,"CDNAM")="��ü";
	gclx_staxdiv_2.index=0;
	gclx_staxdiv_3.index=0;
</script>

<script language="javascript" for="gcds_staxknd" event="onloadCompleted(row,colid)">
	gcds_staxknd.InsertRow(1);
	gcds_staxknd.NameValue(1,"CDCODE")="";
	gcds_staxknd.NameValue(1,"CDNAM")="��ü";
	gclx_staxknd.index=0;
	gclx_staxknd_2.index=0;
	gclx_staxknd2.index=0;
	gclx_staxknd2_2.index=0;
</script>

<script language="javascript" for="gcds_staxknd2" event="onloadCompleted(row,colid)">
	gcds_staxknd2.InsertRow(1);
	gcds_staxknd2.NameValue(1,"CDCODE")="";
	gcds_staxknd2.NameValue(1,"CDNAM")="��ü";
	gclx_staxknd.index=0;
	gclx_staxknd_2.index=0;
	gclx_staxknd2.index=0;
	gclx_staxknd2_2.index=0;
</script>
 
<script language="javascript" for="gcds_staxdiv" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	gcds_staxdiv.InsertRow(1);
	gcds_staxdiv.NameValue(1,"CDCODE")="";
	gcds_staxdiv.NameValue(1,"CDNAM")="��ü";
	gclx_staxdiv.index=0;
	gclx_staxdiv2.index=0;
</script>

<script language="javascript"  for=gcgd_data1 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data1.countrow;i++) {
			if(i != Row) {
				gcds_data1.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_data2 event="OnClick(Row,Colid)">
	if (Colid =="CHK") {
		for (var i=1; i<=gcds_data1_2.countrow;i++) {
			if(i != Row) {
				gcds_data1_2.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>

<script language="javascript"  for=gcgd_data1 event="OnDblClick(Row,Colid)">
    /*
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	arrParam[0] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(0,1);
	arrParam[1] = gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
	arrParam[2] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(1,11);

	//strURL = "./STaxBill_popup_2.jsp";
	//strURL = "./STaxBill_popup_2_ee.jsp";
	strURL = "./staxbill_popup_2_ee_a.jsp";
	strPos = "dialogWidth:888px;dialogHeight:650px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	*/
	
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR").substring(0,1);
	arrParam[0] = gcds_data1.namevalue(gcds_data1.rowposition,"TAXNBR");
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"||strParam=="J"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"||strParam=="K"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
</script>

<script language="javascript"  for=gcgd_data2 event="OnDblClick(Row,Colid)">
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(0,1);

	//arrParam[0] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(0,1);
	//arrParam[1] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"FDCODE");
	//arrParam[2] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR").substring(1,11);
	arrParam[0] = gcds_data1_2.namevalue(gcds_data1_2.rowposition,"TAXNBR");
	//alert("arrParam[0]"+arrParam[0]);

	//strURL = "./STaxBill_popup_2.jsp";
	//strURL = "./STaxBill_popup_2_ee.jsp";
	//strURL = "./staxbill_popup_2_ee_a.jsp";
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

</script>

<script language=JavaScript for="gclx_staxiodiv" event="OnSelChange2()">
	if (gclx_staxiodiv.bindcolval == "1") {	//�ΰ�������[����]
		document.all.gclx_staxknd.style.display='block';
		document.all.gclx_staxknd_2.style.display='none';

		document.all.gclx_staxdiv.style.display='block';
		document.all.gclx_staxdiv_2.style.display='none';
	}else if(gclx_staxiodiv.bindcolval == "2") {
		document.all.gclx_staxknd.style.display='none';
		document.all.gclx_staxknd_2.style.display='block';

		document.all.gclx_staxdiv.style.display='none';
		document.all.gclx_staxdiv_2.style.display='block';
	}
</script>

<script language=JavaScript for="gclx_staxiodiv2" event="OnSelChange2()">
	if (gclx_staxiodiv2.bindcolval == "1") {//�ΰ�������[����]
		document.all.gclx_staxknd2.style.display='block';
		document.all.gclx_staxknd2_2.style.display='none';

		document.all.gclx_staxdiv2.style.display='block';
		document.all.gclx_staxdiv_3.style.display='none';
	}else if(gclx_staxiodiv2.bindcolval == "2") {
		document.all.gclx_staxknd2.style.display='none';
		document.all.gclx_staxknd2_2.style.display='block';

		document.all.gclx_staxdiv2.style.display='none';
		document.all.gclx_staxdiv_3.style.display='block';
	}
</script>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data1" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data1" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data1.ErrorCode + "\n" + "Error Message : " + gctr_data1.ErrorMsg + "\n");
</script>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a040002_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
			<td width="0" align=right>
				<comment id="__NSID__">
				<object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:260px;height:20px;">
					<PARAM NAME="BackColor"		   	  VALUE="#cccccc">
					<PARAM NAME="titleHeight"		  VALUE="20px">
				  	<PARAM NAME="DisableBackColor"	  VALUE="#eeeeee">
				    <PARAM NAME="Format"			  VALUE="
						<T>divid=div_1		title='��꼭��'</T>
						<T>divid=div_2		title='��ǥ��'</T>									
				  ">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
			</td>
		</tr>
	  </table>
	</td>
  </tr>
  <tr><td height=4></td></tr>
</table>

<!-- ��꼭�� ===========================================================================================================-->
<div id="div_disp1" style="border:0 solid #708090;">
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:8px;width:867px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        		<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
              				<param name=Enable              value="true">
							<param name=ListExprFormat	    value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�����&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            			<nobr>
						<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="01^��,02^����,04^ȫ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��꼭�Ⱓ&nbsp;</nobr></td>
					<td width="200px"class="tab21"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;���࿩��&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="^��ü,Y^����,N^�̹���">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�ŷ�ó�ڵ�</nobr></td>
					<td width="170px;" class="tab22" colspan="7"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px" onKeydown="if(event.keyCode==13) ln_Query('A')">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit value="true">
								<param name=PromptChar	value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('A')">
					   	<comment id="__NSID__">
					   		<object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) ln_Query('A')">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text = '';gcem_vendcd.text = '';">
						<!-- ��꼭�� ��ư --------------------------------------------------------------------------------------------------------------------------------------->
						<img name="btn_p1" src="../../Common/img/btn/com_b_taxselect.gif"	style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_TaxQuery('A')"> 
						<!-- <img name="btn_p2" src="../../Common/img/btn/com_b_taxissue.gif"	style="position:relative;top:-59px;left:15px;cursor:hand"	onclick="ln_TaxIssue('A')">  -->
						<img name="btn_p3" src="../../Common/img/btn/com_b_print.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Print()"> 
						<img name="btn_p6" src="../../Common/img/btn/com_b_delete.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Delete('A')"> 
						<img name="btn_p5" src="../../Common/img/btn/com_b_excel.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"	onclick="ln_Excel('A')">
						<img name="btn_q4" src="../../Common/img/btn/com_b_query.gif"		style="position:relative;top:-59px;left:85px;cursor:hand"   onclick="ln_Query('A')"></nobr> 
						<!-- ��꼭�� ��ư --------------------------------------------------------------------------------------------------------------------------------------->
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>���Ը��ⱸ��</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="1^����,2^����">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ΰ�������&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- ���Ա���:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:180px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- ���ⱸ��:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>
					<!-- 2009.12.07 jys �ͼӱ����� ��ȸ ���ǿ��� ���Ƿ� �� ���ֿ� �ʿ��ϸ� �߰���. -->
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӱ���&nbsp;</nobr></td>
					<td width="200px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
								<param name=ComboDataID			value="gcds_staxdiv"><!-- ���� -->
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
								<param name=ComboDataID			value="gcds_staxdiv2"><!-- ���� -->
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDNAM^0^130">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��ǥ����&nbsp;</nobr></td>
					<td width="110px" class="tab22"><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^��ü,Y^����Ϸ�,C^�������,R^�����û,N^������,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
        		<tr> 
					<td width="80px"  class="tab12" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="170px;"  class="tab12"  colspan="3"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_amend_code classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
								<param name=CBData				value="^'��ü',01^��������� ���� ����,02^���ް��� ����,03^ȯ��,04^����� ����,05^�����ſ��� ���� ����,06^������ ���� ���߹߱� ��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDCODE^0^30,CDNAM^0^180">
								<param name=BindColumn			value="CDCODE">
  						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;eBill����&nbsp;</nobr></td>
					<td  class="tab23" ><nobr>
						<comment id="__NSID__">
							<object  id=gclx_ebillgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^��ü,1^����Ʈ��,2^Ʈ������,9^��Ÿ">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;</nobr></td>
					<td>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^��ü,N^���,R^��û,Y^����,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height:355;width:865" viewastext>
              <PARAM NAME="DataID"			VALUE="gcds_data1">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary" VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle" VALUE="0">
							<param name="IndWidth"    value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick"  value="1">
							<PARAM NAME="Format"			VALUE=" 
								<F>ID=CHK,		 Name='����'		 ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' Cursor='hand' SumBgColor=#C3D0DB</F>
								<C>ID=FDNAME, 	 Name='����'		 ,width=40, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=true SumBgColor=#C3D0DB</C>
								<F>ID=TAXDAT,	 Name='��꼭����'	 ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX', BgColor='#f5f5f5' Edit=none sort=true SumText='�հ�'  SumBgColor=#C3D0DB</F>
								<F>ID=TAXNBR_R,	 Name='��ȣ'		 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</F>
								<C>ID=VEND_CD,	 Name='�ŷ�ó�ڵ�'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=Lookup, Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
								<C>ID=VEND_CD,	 Name='�ŷ�ó��'	 ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   EditStyle=Lookup, Data='gcds_vendcd:VEND_CD:VEND_NM' Edit=none sort=true SumBgColor=#C3D0DB show=false</C>
								<C>ID=VEND_NM,	 Name='�ŷ�ó��'	 ,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=VEND_ID,	 Name='����ڹ�ȣ'	 ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXX-XX-XXXXX',Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=REMARK,	 Name='����'		 ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXKNDNM,	 Name='����'	     ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXDIVNM,	 Name='�ͼӱ���'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=TAXSUM,	 Name='���ް���'	 ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXVATAMT, Name='�ΰ�����'	 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXTOT,	 Name='�հ�ݾ�'	 ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none  SumBgColor=#C3D0DB SumText=@sum sort=true</C>
								<C>ID=TAXPRTYN,	 Name='���࿩��'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����,N:�̹���' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=FSSTAT,	 Name='��ǥ����'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����Ϸ�,C:�������,R:�����û,N:������,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=EMPNMK,	 Name='�����'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
								<C>ID=DEPTNM,	 Name='���μ�'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
								<C>ID=DTI_STATUS,Name='����'		 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:��������,A:��������,V:�������û,I:���Ź̽���,C:���Ž���,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),R:���Űź�,O:��ҿϷ�,T:������ź�,W:�������û ���'</C>
								<C>ID=GUBUN,     Name='���౸��'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:���ڹ���,2:�������'</C>
								<C>ID=AMEND_CODE,Name='�����ڵ�'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							    <C>ID=TAXCDNBR,  Name='�ſ�ī���ȣ',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
								<C>ID=EXTCHK,    Name='�ܺι���'	 ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
								<C>ID=DUEDATE,	 Name='�Աݿ�����'	 ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX',  Edit=none SumBgColor=#C3D0DB </C>
								<C>ID=TAXSTS,	 Name='�������'	 ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
								<C>ID=SB_REASON, Name='�ݼۻ���'	 ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center,align=left    Edit=none sort=true SumBgColor=#C3D0DB</C>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:865;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>


<!-- ��ǥ�� ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:498px;width:879px;bacground-color:#708090"></fieldset>
<div id="div_disp2" style="border:0 solid #708090;" >
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:8px;width:867px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort						value=false>
              <param name=Enable          value="true">
							<param name=ListExprFormat	value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�����&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            <nobr>
						<comment id="__NSID__"><object  id=gclx_cocode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="01^��,02^����,04^ȫ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��꼭�Ⱓ&nbsp;</nobr></td>
					<td width="200px"class="tab21"><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto2', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;���࿩��&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^��ü,Y^����,N^�̹���">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>�ŷ�ó�ڵ�</nobr></td>
					<td width="170px;" class="tab22" colspan="7"><nobr>
						<comment id="__NSID__"><object  id=gcem_vendnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup('B')">
						<comment id="__NSID__"><object  id=gcem_vendcd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm2.text = '';gcem_vendcd2.text = '';">
							
							<!-- ��ǥ�� ��ư --------------------------------------------------------------------------------------------------------------------------------------->
							<span id=sp0 style="display:none;">
								<img name="btn_p0_2" src="../../Common/img/btn/com_b_save.gif"	    style="position:relative;top:-59px;left:40px;cursor:hand"	onclick="ln_Save()"> 
							</span>
							
							<img name="btn_p1_2" src="../../Common/img/btn/com_b_taxselect.gif"	    style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_TaxQuery('B')"> 
							<!-- <img name="btn_p2_2" src="../../Common/img/btn/com_b_taxissue.gif"	style="position:relative;top:-59px;left:15px;cursor:hand"	onclick="ln_TaxIssue('B')">  -->
							<img name="btn_p3_2" src="../../Common/img/btn/com_b_print.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Print2()"> 
							<img name="btn_p6_2" src="../../Common/img/btn/com_b_delete.gif"		style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Delete('B')">
							<img name="btn_p5_2" src="../../Common/img/btn/com_b_excel.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"	onclick="ln_Excel('B')"> 
							<img name="btn_q4_2" src="../../Common/img/btn/com_b_query.gif"			style="position:relative;top:-59px;left:45px;cursor:hand"   onclick="ln_Query('B')"></nobr>
							<!-- ��ǥ�� ��ư --------------------------------------------------------------------------------------------------------------------------------------->
					</td>
				</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>���Ը��ⱸ��</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="1^����,2^����">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ΰ�������&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- ���Ա���:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd2_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- ���ⱸ��:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;�ͼӱ���&nbsp;</nobr></td>
					<td width="200px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
							<param name=ComboDataID			value="gcds_staxdiv"><!-- ���� -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
							<param name=ComboDataID			value="gcds_staxdiv2"><!-- ���� -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value="false">
							<param name=ListExprFormat	    value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;��ǥ����&nbsp;</nobr></td>
					<td width="110px" class="tab22"><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^��ü,Y^����Ϸ�,C^�������,R^�����û,N^������,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
        		<tr> 
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>�����ڵ�</nobr></td>
					<td width="370px;"   class="tab23" colspan="3"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_amend_code2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:3px;top:0px;font-size:12px;width:180px;height:200px;">
								<param name=CBData				value="^'��ü',01^��������� ���� ����,02^���ް��� ����,03^ȯ��,04^����� ����,05^�����ſ��� ���� ����,06^������ ���� ���߹߱� ��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=ListExprFormat	    value="CDCODE^0^30,CDNAM^0^180">
								<param name=BindColumn			value="CDCODE">
  						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					
					<td class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;eBill����&nbsp;</nobr></td>
					<td class="tab23">
						<comment id="__NSID__"><object  id=gclx_ebillgb2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^��ü,1^����Ʈ��,2^Ʈ������,9^��Ÿ">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					
					<td  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;</nobr></td>
					<td>
						<comment id="__NSID__">
							<object  id=gclx_taxsts2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^��ü,N^���,R^��û,Y^����,B^�ݼ�">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						
					</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:8px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data2"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:355;width:865" >
              <PARAM NAME="DataID"			VALUE="gcds_data1_2">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary"   VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<param name="IndWidth"      value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick"  value="1">
							<PARAM NAME="Format"			VALUE=" 
							<F>ID=CHK,		 Name='����'		  ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB</F>
							<F>ID=FDNAME, 	 Name='����'		  ,width=40, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=true SumBgColor=#C3D0DB</F>
							<F>ID=FSNUM,	 Name='��ǥ��ȣ'	  ,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='�հ�'  SumBgColor=#C3D0DB</F>
							<C>ID=VEND_CD,	 Name='�ŷ�ó�ڵ�'	  ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
							<C>ID=VEND_NM,	 Name='�ŷ�ó��'	  ,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=VEND_ID,	 Name='����ڹ�ȣ'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXX-XX-XXXXX',Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXSUM,	 Name='���ް���'	  ,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXVATAMT, Name='�ΰ�����'	  ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXTOT,	 Name='�հ�ݾ�'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=REMARK,	 Name='����'		  ,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXKNDNM,	 Name='����'	      ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=GUBUN,     Name='���౸��'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:���ڹ���,2:�������'</C>
							<C>ID=FSSTAT,	 Name='��ǥ����'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����Ϸ�,C:�������,R:�����û,N:������,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
                            <C>ID=DTI_STATUS,Name='����'		  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:��������,A:��������,V:�������û,I:���Ź̽���,C:���Ž���,M:������ҿ�û(���޹޴���),N:������ҿ�û(������),R:���Űź�,O:��ҿϷ�,T:������ź�,W:�������û ���'</C>
							<C>ID=TAXPRTYN,	 Name='���࿩��'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:����,N:�̹���' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=EMPNMK,	 Name='�����'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=DEPTNM,	 Name='���μ�'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=AMEND_CODE,Name='�����ڵ�'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							<C>ID=TAXCDNBR,  Name='�ſ�ī���ȣ' ,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
							<C>ID=TAXDAT,    Name='��꼭����'	  ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,    Name='�ܺι���'    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
							<C>ID=TAXDIVNM,	 Name='�ͼӱ���'	  ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=DUEDATE,	 Name='�Աݿ�����'	  ,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, mask='XXXX/XX/XX', Edit=none  SumBgColor=#C3D0DB</C>
							<C>ID=TAXSTS,	 Name='�������'	  ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:���,R:��û,Y:����,B:�ݼ�' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=SB_REASON, Name='�ݼۻ���'	 ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center,align=left    Edit=none sort=true SumBgColor=#C3D0DB</C>
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:865;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1_2 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</div>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  ID=gcbn_data CLASSID="CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49"> 
	<PARAM NAME=DataID    VALUE=gcds_data1>
	<PARAM NAME=BindInfo  VALUE="
	">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �� �� �� �� �� �� �� ��
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print">
	<param NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"			VALUE="true">
	<PARAM NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="LandScape"					VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
	
	<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=34 ,right=1863 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=21 ,right=1849 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='CURDT', left=860, top=119, right=2003, bottom=167 ,mask='(  �Ⱓ : XXXX�� XX�� XX��  ~  XXXX�� XX�� XX��  )', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PTITLE', left=1019, top=24, right=1844, bottom=87, face='HY�߰��', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=71 ,top=384 ,right=2810 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DATANM', left=71, top=222, right=1357, bottom=275, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='FDCODENM', left=71, top=175, right=918, bottom=222, align='left' ,mask='��      ��: XXXXXXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ͼӱ���' ,left=310 ,top=333 ,right=902 ,bottom=378 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=71 ,top=280 ,right=2810 ,bottom=280 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=280 ,right=71 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=280 ,right=2810 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='CURDT2', left=2384, top=175, right=2807, bottom=222, align='right' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=2384 ,top=222 ,right=2807 ,bottom=275 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�����' ,left=77 ,top=286 ,right=296 ,bottom=378 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ŷ�ó��' ,left=635 ,top=286 ,right=1072 ,bottom=331 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ǥ��ȣ' ,left=310 ,top=286 ,right=622 ,bottom=331 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=915 ,top=333 ,right=1072 ,bottom=378 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����ڹ�ȣ' ,left=1085 ,top=286 ,right=1365 ,bottom=331 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=1378 ,top=286 ,right=1691 ,bottom=331 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=1378 ,top=333 ,right=2016 ,bottom=378 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=1704 ,top=286 ,right=2802 ,bottom=331 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ݾ�' ,left=2027 ,top=333 ,right=2278 ,bottom=378 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ݾ�' ,left=2291 ,top=333 ,right=2540 ,bottom=378 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�ݾ�' ,left=2553 ,top=333 ,right=2802 ,bottom=378 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��꼭����' ,left=1085 ,top=333 ,right=1365 ,bottom=378 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=98 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=71 ,bottom=95 </L>
	<C>id='FSNUM', left=310, top=0, right=622, bottom=45, align='left' ,mask='XXXXXXXXX-XXXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXDIVNM', left=310, top=48, right=902, bottom=90, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXIODIVNM', left=915, top=48, right=1072, bottom=90, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VEND_ID', left=1085, top=0, right=1365, bottom=45, align='left' ,mask='XXX-XX-XXXXX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TAXKNDNM', left=1085, top=48, right=1365, bottom=90, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BSNS_CND', left=1378, top=0, right=1691, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1378, top=48, right=2016, bottom=90, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXTOT', left=2553, top=48, right=2802, bottom=90, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BSNS_KND', left=1704, top=0, right=2802, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXDAT', left=77, top=0, right=296, bottom=90 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=95 </L>
	<L> left=71 ,top=95 ,right=2810 ,bottom=95 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<C>id='VEND_NM', left=635, top=0, right=1072, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXSUM', left=2027, top=48, right=2278, bottom=90, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXVATAMT', left=2291, top=48, right=2540, bottom=90, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2871 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Tahoma' ,size=10 ,penwidth=1
	<S>id='{Sum(TAXTOT)}' ,left=2553 ,top=5 ,right=2805 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=71 ,top=53 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=0 ,right=71 ,bottom=50 </L>
	<L> left=2810 ,top=3 ,right=2810 ,bottom=53 </L>
	<S>id='{Sum(TAXVATAMT)}' ,left=2289 ,top=5 ,right=2540 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(TAXSUM)}' ,left=2027 ,top=5 ,right=2278 ,bottom=48 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<T>id='�հ�' ,left=1704 ,top=5 ,right=2000 ,bottom=50 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=Footer ,left=0 ,top=1857 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2434 ,top=3 ,right=2813 ,bottom=85</I>
	<L> left=71 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>



	">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 