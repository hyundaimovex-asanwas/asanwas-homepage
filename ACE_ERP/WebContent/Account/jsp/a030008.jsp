<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �հ��ܾ׽û�ǥ
+ ���α׷� ID	: A030008
+ �� �� �� ��	: ��ȸ|���
+ �� �� �� ��	: ������
+ �� �� �� ��	: a030008_s1
-----------------------------------------------------------------------------
+ �� �� �� �� :	ȯ������   
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� �� :	�����а� ���� ����
+ ��   ��  �� : ������
+ �� �� �� �� : 2010.04.07
-----------------------------------------------------------------------------
+ �� �� �� �� :	ȯ���ݿ��� �ش�⵵ 00�� ~ ��ȸ������� ������ �ϰ������Ͽ� ȯ���ݿ���.
+ ��   ��  �� : ������
+ �� �� �� �� : 2010.07.13
-----------------------------------------------------------------------------
+ �� �� �� �� :	����������Ȳ �� ���� ��ȸ �����ϰ� ���ν��� ������.
+ ��   ��  �� : ������
+ �� �� �� �� : 2010.08.27
-----------------------------------------------------------------------------
+ �� �� �� �� :	��ȭȯ������(�ս�)�� �ݰ����� ������������ ��ü��. 
+ ��   ��  �� : ������
+ �� �� �� �� : 2013.02.13
-----------------------------------------------------------------------------
+ �� �� �� �� :	DB2->ORACLE ����  
+ ��   ��  �� : ������
+ �� �� �� �� : 2013.11.28
-----------------------------------------------------------------------------

------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�հ��ܾ׽û�ǥ</title>
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

gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;

var chk = 0;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_Before();	//����ȸ
  
	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
	}

	gclx_gubun.index=0;

    beforchk();
}


/******************************************************************************
	Description : �Ѱ������忡 ȯ������ �� ����Ÿ�� �����ϸ� return false
******************************************************************************/
function ln_Chk(){
	gcds_ratechk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_rate_chk_s1"
					 	+ "?v_str1="+gclx_sfdcode.BindColVal+"&v_str2="+gcem_staxdatto.text;
	//prompt("",gcds_ratechk.DataID);
	gcds_ratechk.Reset();

	if(gcds_ratechk.namevalue(gcds_ratechk.rowposition,"CNT")>0){
		return true;
	}else{
		return false;
	}
}

/******************************************************************************
Description : ���̿� üũ (������)
******************************************************************************/
function beforchk(){
  gcds_data0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s0"
                    + "?v_str1="+gcem_staxdatto.text
                    + "&v_str2="+gclx_sfdcode.bindcolval;
  gcds_data0.Reset();
}

/******************************************************************************
	Description : ��ȸ�ø��� �ܾ� ���� ���ν��� ����
******************************************************************************/
function ln_up_Atcode_Create(){


    //=====================================================================
    //2009.05.26 �������踦 ���ν����� ��������. ����� �� �¾ƾ� �ϴµ�...

		var strGb="N"; 

		//�׳� ���ν����� ������......
  	    if(gclx_sfdcode.bindcolval==""){
			alert("������ Ȯ�� �Ͻʽÿ�!");
			return; 
		}

		if(gcem_staxdatto.text==""){
			alert("ȸ������ Ȯ�� �Ͻʽÿ�!");
			return; 
		}
	  
		if (confirm("�������踦 �Ͻðڽ��ϱ�?")){
			strGb="Y";
		}

    	if(strGb=="Y"){
			gcds_upatcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_upsum"
														+ "?v_str1="+gclx_sfdcode.bindcolval
														+ "&v_str2="+gcem_staxdatto.text
														+ "&v_str3="+gs_userid;
			gcds_upatcode2.Reset();

			if(gcds_upatcode2.namevalue(gcds_upatcode2.rowposition,"RETURN")=="Y"){
				alert("�������踦 ���������� ó���Ͽ����ϴ�.");
			}else{
        		alert("�������踦 ���������� ó������ ���Ͽ����ϴ�.");
			}
    	}

		//=======================================================================
}

/******************************************************************************
	Description : ��ȸ�ø��� �ܾ� ���� ���ν��� ����
******************************************************************************/
function ln_up_Atcode_Create_1(){

    //gf_Up_Atcode_Create();
		var strfdcode="";
		if(gclx_sfdcode.bindcolval==""){
      		strfdcode = "A"; 
		}else{
			strfdcode = gclx_sfdcode.bindcolval;
		}

		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}

	    gcds_upatcode.addrow();
	    gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
	    gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t2_1?";
		gctr_upatcode.Parameters = "v_str1="+gcem_staxdatto.text+",v_str2="+strfdcode;
		//prompt("gcds_upatcode",gcds_upatcode.text);
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
}


/******************************************************************************
	Description : ��ȸ�ø��� �ܾ� ���� ���ν��� ����
******************************************************************************/
function ln_up_Atcode_Create_2(){

    //gf_Up_Atcode_Create();
		var strfdcode="";
		if(gclx_sfdcode.bindcolval==""){
      		strfdcode = "A"; 
		}else{
			strfdcode = gclx_sfdcode.bindcolval;
		}

		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}

	    gcds_upatcode.addrow();
	    gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
	    gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t2_2?";
		gctr_upatcode.Parameters = "v_str1="+gcem_staxdatto.text+",v_str2="+strfdcode;
		//prompt("gcds_upatcode",gcds_upatcode.text);
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
}




/******************************************************************************
	Description : �ӽ�......�����а� ���� ����
******************************************************************************/
function ln_up_Atcode_Create999(){

    //gf_Up_Atcode_Create();

		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}
	    gcds_upatcode.addrow();
	    gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
	    gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t3?";
		gctr_upatcode.Parameters = "v_str1="+gcem_staxdatto.text;
		//prompt("gcds_upatcode",gcds_upatcode.text);
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
}



/******************************************************************************
Description : ���̿�
******************************************************************************/
function ln_up_Atcode_Create000(){
  if(gcem_staxdatto.text.substring(0,4)<="2018"){
    alert("2018���� ���̿� �� �� �����ϴ�.");
    return false;
  }

  if(gclx_sfdcode.bindcolval==""){
	alert("���̿��� ������ �ݵ�� �����ؾ��մϴ�.");
	return false;
  }

  //alert("chk:;"+chk);

  if(chk!=0){
    if (confirm("������ ���̿��� �Ǿ��ֽ��ϴ�. �ٽ��Ͻðڽ��ϱ�?")){

      if (gcds_upatcode.countrow<1){
        var s_temp = "FDCODE:STRING";
        gcds_upatcode.SetDataHeader(s_temp);
      }
      gcds_upatcode.addrow();
      gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")=gclx_sfdcode.bindcolval;
      gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t4?";
      gctr_upatcode.Parameters = "v_str1="+gcem_staxdatto.text+",v_str2="+gclx_sfdcode.bindcolval;
      gctr_upatcode.post();																 
      gcds_upatcode.ClearAll();
    }
  }else{

	  if (confirm("���̿� �Ͻðڽ��ϱ�?")){
			if (gcds_upatcode.countrow<1){
				var s_temp = "FDCODE:STRING";
				gcds_upatcode.SetDataHeader(s_temp);
			}
			gcds_upatcode.addrow();
			gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")=gclx_sfdcode.bindcolval;
			gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t4?";
			gctr_upatcode.Parameters = "v_str1="+gcem_staxdatto.text+",v_str2="+gclx_sfdcode.bindcolval;
			gctr_upatcode.post();																 
			gcds_upatcode.ClearAll();
	}
  }
  beforchk();
}


/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query1(){

	var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
	var str2 = gcem_staxdatto.text;			//��꼭�Ⱓ �� ��
/*
  if(ln_Chk()){
    alert("ȯ�� ��ȯ�� ����Ÿ�� �����մϴ�. Ȯ���Ͻʽÿ�");
		return;
	}
*/
	//ln_up_Atcode_Create();

/**
	��ȭ ��üũ
		�����а� ����
		�����а� ������
	��ȭ üũ
		�����а� ����
		�����а� ������
**/

	if(chkbox.checked==false){  // ��ȭ üũ�ڽ� ��üũ
	  if(chkbox_md.checked==true){//�����а� ����
		  /**
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1"
												+ "?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+gclx_gubun.bindcolval;
			gcds_data1.Reset();
			**/
			
			//�����а� ���� �� 
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1_y"
												+ "?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+gclx_gubun.bindcolval;
			gcds_data1.Reset();	

		}else{ //�����а� ������
			gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1_n"
												+ "?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+gclx_gubun.bindcolval;
			gcds_data1.Reset();
		}
	}else{
		if(gclx_sfdcode.bindcolval==""){  //��ü �׻� ��ȭ�� ��ȸ��.
		  if(chkbox_md.checked==true){    //�����а� ����
				/**
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=A";
				gcds_data1.Reset();
                **/
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_y"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=A";
				gcds_data1.Reset();
			}else{ //�����а� ������
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_n"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=A";
				gcds_data1.Reset();
      }
		}else if(gclx_sfdcode.bindcolval=="03"){ //�ݰ���(��ȭ�� ��ȸ)
		  if(chkbox_md.checked==true){    //�����а� ����
		        /**
		        gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=K";        
				gcds_data1.Reset();
				**/
        		gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_y"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=K";        
				gcds_data1.Reset();

			}else{   //�����а� ������
				gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_n"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=K";
				gcds_data1.Reset();
			}
		}
	}
	
	ln_Sum();
}


/******************************************************************************
	Description : �հ��ܾ� Sum ���
******************************************************************************/
function ln_Sum(){
var dblduval=0;
var dbldetot=0;  
var dblcrtot=0;
var dblcrval=0;

	 	if(gclx_gubun.bindcolval=="A"||gclx_gubun.bindcolval=="Y"){ //��ü||������
			//gcgd_data1.DataID = "";
			for (i=1;i<=gcds_data1.Countrow;i++){
				if(gcds_data1.namevalue(i,"ATUSEYN")=="Y"){
					dblduval+=gcds_data1.namevalue(i,"DEVAL");
					dbldetot+=gcds_data1.namevalue(i,"DETOT");
					dblcrtot+=gcds_data1.namevalue(i,"CRTOT");
					dblcrval+=gcds_data1.namevalue(i,"CRVAL");
				}
			}
		}else if(gclx_gubun.bindcolval=="N"){ //�������
			if(chkbox.checked==false){   //üũ�ڽ� ��üũ
			  if(chkbox_md.checked==true){ //�����а� ����
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s3_y"
														+ "?v_str1="+gclx_sfdcode.BindColVal
														+ "&v_str2="+gcem_staxdatto.text;
					//prompt("",gcds_data2.DataID );
					gcds_data2.Reset();
					dblduval=gcds_data2.namevalue(1,"DEVAL");
					dbldetot=gcds_data2.namevalue(1,"DETOT");
					dblcrtot=gcds_data2.namevalue(1,"CRTOT");
					dblcrval=gcds_data2.namevalue(1,"CRVAL");
				}else{                       //�����а�  ������
					gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s3"
														+ "?v_str1="+gclx_sfdcode.BindColVal
														+ "&v_str2="+gcem_staxdatto.text;
					//prompt("",gcds_data2.DataID );
					gcds_data2.Reset();
					dblduval=gcds_data2.namevalue(1,"DEVAL");
					dbldetot=gcds_data2.namevalue(1,"DETOT");
					dblcrtot=gcds_data2.namevalue(1,"CRTOT");
					dblcrval=gcds_data2.namevalue(1,"CRVAL");
				}
			}
		}

		gcgd_data1.ColumnProp('DEVAL','SumText')= gf_setnum(dblduval);
		gcgd_data1.ColumnProp('DEVAL','SumTextAlign') = "right";
		gcgd_data1.ColumnProp('DETOT','SumText')=gf_setnum(dbldetot);
		gcgd_data1.ColumnProp('DETOT','SumTextAlign') = "right";
		gcgd_data1.ColumnProp('CRTOT','SumText')=gf_setnum(dblcrtot);
		gcgd_data1.ColumnProp('CRTOT','SumTextAlign') = "right";
		gcgd_data1.ColumnProp('CRVAL','SumText')=gf_setnum(dblcrval);
		gcgd_data1.ColumnProp('CRVAL','SumTextAlign') = "right";

    //gcgd_data1.DataID = "gcds_data1";
}

/******************************************************************************
	Description : ����Ʈ Sum ���
******************************************************************************/
function ln_Sum1(){
var dblduval=0;
var dbldetot=0;  
var dblcrtot=0;
var dblcrval=0;
 
//gcgd_data1.DataID = "";
	if(gcds_print1.countrow>=1){
		for (i=1;i<=gcds_print1.Countrow;i++){
			if (gcds_print1.namevalue(i,"ATUSEYN")=="Y"){
			  dblduval+=gcds_print1.namevalue(i,"DEVAL");
				dbldetot+=gcds_print1.namevalue(i,"DETOT");
				dblcrtot+=gcds_print1.namevalue(i,"CRTOT");
				dblcrval+=gcds_print1.namevalue(i,"CRVAL");
			}
		}

		gcds_print1.addrow();
		gcds_print1.namevalue(gcds_print1.rowposition,"DEVAL") = dblduval;
		gcds_print1.namevalue(gcds_print1.rowposition,"DETOT") = dbldetot;
		gcds_print1.namevalue(gcds_print1.rowposition,"CRTOT") = dblcrtot;
		gcds_print1.namevalue(gcds_print1.rowposition,"CRVAL") = dblcrval;
		gcds_print1.namevalue(gcds_print1.rowposition,"ATKORNAM") = "�� ��";
 
	    // gcgd_data1.DataID = "gcds_data1";
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

function ln_Print1(){

	var str1 = gclx_sfdcode.BindColVal;	//�����ڵ�
	var str2 = gcem_staxdatto.text;			//��꼭�Ⱓ �� ��

  /*
	gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1"
								     + "?v_str1="+str1+"&v_str2="+str2;
	gcds_print1.Reset();
  */

	//��¥ �� �ð� ����
	gcds_datetime.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_datetime_s1?"
	gcds_datetime.Reset();

	if(chkbox.checked==false){  // ��ȭ üũ�ڽ� ��üũ
	  if(chkbox_md.checked==true){//�����а� ����
			//gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1"
			gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1_y"
												+ "?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+gclx_gubun.bindcolval;
			gcds_print1.Reset();

		}else{ //�����а� ������
			gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s1_n"
												+ "?v_str1="+str1
												+ "&v_str2="+str2
												+ "&v_str3="+gclx_gubun.bindcolval;
			gcds_print1.Reset();
		}
	}else{
		if(gclx_sfdcode.bindcolval==""){  //��ü �׻� ��ȭ�� ��ȸ��.
		  	if(chkbox_md.checked==true){    //�����а� ����
			  //gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2"
				gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_y"
													//+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3=A";
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=A";
				gcds_print1.Reset();
			}else{ //�����а� ������
				gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_n"
				//									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3=A";
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=A";
				gcds_print1.Reset();

      }
		}else if(gclx_sfdcode.bindcolval=="03"){ //�ݰ���(��ȭ�� ��ȸ)
		  if(chkbox_md.checked==true){    //�����а� ����
			  //gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2"
        //gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_y"
				//									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3=K";           
				//gcds_print1.Reset();

				gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_y"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=K"; 
				//prompt('',gcds_print1.DataID);
				gcds_print1.Reset();


			}else{   //�����а� ������
				//gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_n"
				//									+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3=K";
				//gcds_print1.Reset();

				gcds_print1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_s2_n"
													+ "?v_str1="+str1+"&v_str2="+str2+"&v_str3="+gclx_gubun.bindcolval+"&v_str5=K"; 
				gcds_print1.Reset();
			}
		}
	}

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

/******************************************************************************
	Description : ���
******************************************************************************/

function ln_RptFormat1() {

	var ls_for = "";
	var stryyyy = gcem_staxdatto.text.substring(0,4);
	var strmm = gcem_staxdatto.text.substring(4,6);
	var strdd = "01";
	var strlast = shiftTime(stryyyy+strmm+strdd,0,1,-1);
	var yyyy = strlast.substring(0,4);
	var mm   = strlast.substring(4,6);
	var dd   = strlast.substring(6,8);
	var tyyyy = gs_date2.substring(0,4);
	var tmm = gs_date2.substring(4,6);
	var fd = gcds_sfdcode.NameValue(gcds_sfdcode.rowposition,"FDNAME");
	var ki = gcds_staxdatki.namevalue(1,"CDCODE");
	var ki1 = Number(gcem_staxdatto.text.substring(0,4))-Number(ki)+1;

/*
ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=621 ,face='Arial' ,size=10 ,penwidth=1  ";
ls_for += "	<L> left=1888 ,top=441 ,right=1888 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>  ";
ls_for += "	<L> left=1263 ,top=443 ,right=1263 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>  ";
ls_for += "	<L> left=670 ,top=443 ,right=670 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>    ";
ls_for += "	<L> left=355 ,top=534 ,right=355 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>    ";
ls_for += "	<L> left=48 ,top=441 ,right=48 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>      ";
ls_for += "	<L> left=1578 ,top=534 ,right=1578 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>  ";
ls_for += "	<T>id='(ȸ������ : �� "+ki1+"�� "+yyyy+"�� "+mm+"��)' ,left=545 ,top=279 ,right=1405 ,bottom=345 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>    ";
ls_for += "	<T>id='Page : #p of #t' ,left=1460 ,top=384 ,right=1880 ,bottom=431 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>     ";
ls_for += "	<T>id='�ۼ����� : "+tyyyy+"/"+tmm+"' ,left=1478 ,top=335 ,right=1880 ,bottom=382 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>    ";
ls_for += "	<T>id='�� ��' ,left=1403 ,top=450 ,right=1760 ,bottom=525 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>     ";
ls_for += "	<L> left=1263 ,top=532 ,right=1888 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>  ";
ls_for += "	<T>id='�� ��' ,left=1273 ,top=541 ,right=1570 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>     ";
ls_for += "	<T>id='��  ��' ,left=1588 ,top=541 ,right=1878 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>    ";
ls_for += "	<T>id='�� ��' ,left=365 ,top=541 ,right=660 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>       ";
ls_for += "	<T>id='�� ��' ,left=55 ,top=541 ,right=348 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>        ";
ls_for += "	<L> left=45 ,top=621 ,right=1888 ,bottom=621 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>    ";
ls_for += "	<L> left=48 ,top=532 ,right=670 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>     ";
ls_for += "	<T>id='�� ��' ,left=178 ,top=450 ,right=535 ,bottom=525 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>       ";
ls_for += "	<T>id='��������' ,left=675 ,top=497 ,right=1255 ,bottom=572 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>   ";
ls_for += "	<T>id='�����ڵ� : "+fd+"' ,left=55 ,top=384 ,right=390 ,bottom=431 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
ls_for += "	<L> left=45 ,top=441 ,right=1888 ,bottom=441 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>    ";
ls_for += "	<X>left=570 ,top=190 ,right=1405 ,bottom=265 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>   ";
ls_for += "	<X>left=560 ,top=178 ,right=1395 ,bottom=255 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>   ";
ls_for += "	<T>id='�� �� �� �� �� �� ǥ' ,left=563 ,top=180 ,right=1388 ,bottom=244 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>      ";
ls_for += "</B> ";
ls_for += "<B>id=default ,left=0,top=0 ,right=2000 ,bottom=49 ,face='Arial' ,size=10 ,penwidth=1   ";
ls_for += "	<C>id='CRTOT', left=1273, top=0, right=1570, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
ls_for += "	<C>id='DETOT', left=365, top=0, right=660, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C> ";
ls_for += "	<C>id='DEVAL', left=55, top=0, right=348, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>  ";
ls_for += "	<C>id='CRVAL', left=1588, top=0, right=1878, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>           ";
ls_for += "	<L> left=48 ,top=49 ,right=1885 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>      ";
ls_for += "	<L> left=48 ,top=0 ,right=48 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>  ";
ls_for += "	<L> left=355 ,top=0 ,right=355 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>";
ls_for += "	<L> left=670 ,top=0 ,right=670 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>";
ls_for += "	<L> left=1263 ,top=0 ,right=1263 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>     ";
ls_for += "	<L> left=1578 ,top=0 ,right=1578 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>     ";
ls_for += "	<L> left=1888 ,top=0 ,right=1888 ,bottom=49 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>     ";
ls_for += "	<C>id='ATKORNAM', left=675, top=0, right=1255, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>          ";
ls_for += "</B> ";
ls_for += "<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1    ";
ls_for += "	<L> left=48 ,top=0 ,right=1888 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L> ";
ls_for += "</B> ";
ls_for += "<B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1          ";
ls_for += "	<I>id='../../common/img/icon.jpg' ,left=1510 ,top=2 ,right=1888 ,bottom=84</I>  ";
ls_for += "</B> ";
*/
ls_for += "  <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=621 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                             ";
ls_for += "  	<L> left=1889 ,top=442 ,right=1889 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                ";
ls_for += "  	<L> left=1262 ,top=442 ,right=1262 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                ";
ls_for += "  	<L> left=669 ,top=442 ,right=669 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                  ";
ls_for += "  	<L> left=355 ,top=534 ,right=355 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                  ";
ls_for += "  	<L> left=48 ,top=442 ,right=48 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                    ";
ls_for += "  	<L> left=1577 ,top=534 ,right=1577 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                ";
ls_for += "  	<T>id='( �� "+ki1+"�� "+yyyy+"�� "+mm+"�� )' ,left=545 ,top=278 ,right=1405 ,bottom=344 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>       ";
ls_for += "  	<T>id='Page : #p of #t' ,left=1461 ,top=384 ,right=1881 ,bottom=431 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                    ";
ls_for += "  	<T>id='�ۼ����� : "+tyyyy+"/"+tmm+"' ,left=1479 ,top=336 ,right=1881 ,bottom=381 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>       ";
ls_for += "  	<T>id='�� ��' ,left=1402 ,top=450 ,right=1759 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                              ";
ls_for += "  	<L> left=1262 ,top=532 ,right=1889 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                ";
ls_for += "  	<T>id='�� ��' ,left=1273 ,top=540 ,right=1569 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                              ";
ls_for += "  	<T>id='��  ��' ,left=1588 ,top=540 ,right=1879 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                             ";
ls_for += "  	<T>id='�� ��' ,left=365 ,top=540 ,right=659 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                                ";
ls_for += "  	<T>id='�� ��' ,left=56 ,top=540 ,right=349 ,bottom=616 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                                 ";
ls_for += "  	<L> left=45 ,top=622 ,right=1889 ,bottom=622 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                  ";
ls_for += "  	<L> left=48 ,top=532 ,right=669 ,bottom=532 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
ls_for += "  	<T>id='�� ��' ,left=177 ,top=450 ,right=534 ,bottom=524 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                                ";
ls_for += "  	<T>id='��������' ,left=675 ,top=497 ,right=1254 ,bottom=572 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>                                            ";
ls_for += "  	<T>id='�����ڵ� : "+fd+"' ,left=56 ,top=384 ,right=389 ,bottom=431 ,align='left' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                      ";
ls_for += "  	<L> left=45 ,top=442 ,right=1889 ,bottom=442 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                  ";
ls_for += "  	<X>left=569 ,top=191 ,right=1405 ,bottom=265 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for += "  	<X>left=561 ,top=177 ,right=1394 ,bottom=254 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>                                                                                                     ";
ls_for += "  	<T>id='�� �� �� �� �� �� ǥ' ,left=564 ,top=180 ,right=1389 ,bottom=243 ,face='HY�߰���' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>                            ";
ls_for += "  </B>                                                                                                                                                                                                               ";
ls_for += "  <B>id=default ,left=0,top=0 ,right=2000 ,bottom=50 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                              ";
ls_for += "  	<C>id='CRTOT', left=1273, top=0, right=1569, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 ";
ls_for += "  	<C>id='DETOT', left=365, top=0, right=659, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                   ";
ls_for += "  	<C>id='DEVAL', left=56, top=0, right=349, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                    ";
ls_for += "  	<C>id='CRVAL', left=1588, top=0, right=1879, bottom=45, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                 ";
ls_for += "  	<L> left=48 ,top=50 ,right=1884 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>                                                                                                                    ";
ls_for += "  	<L> left=48 ,top=0 ,right=48 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                       ";
ls_for += "  	<L> left=355 ,top=0 ,right=355 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                     ";
ls_for += "  	<L> left=669 ,top=0 ,right=669 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                     ";
ls_for += "  	<L> left=1262 ,top=0 ,right=1262 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
ls_for += "  	<L> left=1577 ,top=0 ,right=1577 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
ls_for += "  	<L> left=1889 ,top=0 ,right=1889 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                   ";
ls_for += "  	<C>id='ATKORNAM', left=675, top=0, right=1254, bottom=45, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                ";
ls_for += "  </B>                                                                                                                                                                                                               ";
ls_for += "  <B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                               ";
ls_for += "  	<L> left=48 ,top=0 ,right=1889 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>                                                                                                                      ";
ls_for += "  </B>                                                                                                                                                                                                               ";
ls_for += "  <B>id=Footer ,left=0 ,top=2727 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1                                                                                                                         ";
ls_for += "  	<I>id='../../common/img/icon.jpg' ,left=1511 ,top=3 ,right=1889 ,bottom=85</I>                                                                                                                                   ";
ls_for += "  	<C>id='TIMES', left=442, top=0, right=601, bottom=66, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
ls_for += "  	<C>id='DATES', left=230, top=0, right=437, bottom=66, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>                                                  ";
ls_for += "  	<T>id='����Ͻ� :' ,left=58 ,top=0 ,right=225 ,bottom=66 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>                                              ";
ls_for += "  </B>                                                                                                                                                                                                               ";
	gcrp_print1.format = ls_for + gcrp_print1.format;
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
//	gcgd_data1.runexcel("�հ��ܾ׽û�ǥ");
    gcgd_data1.GridToExcel("�հ��ܾ׽û�ǥ","",2);
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){ 
	//gclx_sfdcode.BindColVal = "01";					//�����ڵ�
	gcem_staxdatto.text		 = gs_date2;				//��꼭�Ⱓ �� ��

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); //�����ڵ�

	gcds_staxdatki.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2137"; 
	gcds_staxdatki.Reset(); //���

}

/******************************************************************************
	Description : �׸��� ���̱�
******************************************************************************/
function ln_visible_hidden(Obj){
	
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

	strURL = "./totalbal_popup.jsp";
	strPos = "dialogWidth:888px;dialogHeight:515px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}

/***********************************************************************************************
	Description : �Ѱ�������[�Ϻ�] ã��
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


function ln_Enable(p){
	if(p=="t"){
		chkbox.disabled=false;
	}else if(p=="f"){
	  chkbox.disabled=true;
		chkbox.checked=false;
	}
}

/***********************************************************************************************
	Description : ��ȯ����/��ȯ���� �ڵ� �ݿ� 
	parameter   : 
	reference   : �ݵ�� ȯ����ȯ�� ��ȭ�ݾ��� ���� �� ��ȯ����/��ȯ���� ��ȯ�ؾ���.
  	ȯ���ݿ� ���� : 2013.02.13 ��
	��ȯ�������� --> �ݰ��� �������� �뺯
	��ȯ���ռս� --> �ݰ��� �������� ����
  	���￡�� �ݰ��� ������ ��ȯȯ������(�ս�)������ �Է���. 
**********************************************************************************************/
function ln_Exchange(){

	if(gclx_sfdcode.bindcolval!="03"){
		//alert("�ݰ��� ������ ��ȯ����/��ȯ���� �ڵ� �ݿ� �����մϴ�.");
    //alert("�ݰ��� ������ ��ȭȯ��ս�/��ȭȯ�������� �ڵ� �ݿ� �����մϴ�.");
		alert("�ݰ����� ��츸 ��ȭȯ��ս�/��ȭȯ�������� �ݰ����� ������������ �ڵ� �ݿ� �����մϴ�.");
		return; 
	}
  
	if (confirm("�ڵ� �����Ͻðڽ��ϱ�?")){
		if (gcds_exchange.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_exchange.SetDataHeader(s_temp);
		}

		gcds_exchange.addrow();
		gcds_exchange.namevalue(gcds_exchange.rowposition,"FDCODE")=gclx_sfdcode.bindcolval;
		//gctr_exchange.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_t1?";
		gctr_exchange.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a030008_t2?";
		gctr_exchange.Parameters = "v_str1="+gcem_staxdatto.text+",v_str2="+gclx_sfdcode.bindcolval;
		gctr_exchange.post();																 
		gcds_exchange.ClearAll();
	} 
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcds_data0" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcds_data1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- ��������� SUM -->
<comment id="__NSID__"><object  id="gcds_data2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_print1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_sfdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- �����ڵ� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_staxdatki" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- ��� -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
<object  id=gcds_upatcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ܾװ��� ���ν��� -->
</object>

<object  id=gcds_upatcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ܾװ��� ���ν��� �ű� -->
</object>
</comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_ratechk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- ȯ������üũ -->
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
  <!-- ��³�¥ �ð� -->
  <object  id=gcds_datetime classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>

  <!-- ��ȯ����/��ȯ���� ���� -->
	<object  id=gcds_exchange classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<!-- �����ܾװ��� ���ν��� -->
<object  id=gctr_upatcode classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="comm_upatcode_t1(I:USER=gcds_upatcode)"> 
	<param name="TimeOut"     value=2400000>
</object>

<!-- ��ȯ����/��ȯ���� �ڵ����� -->
<object  id=gctr_exchange classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a030008_t1(I:USER=gcds_exchange)"> 
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gclx_sfdcode" event="OnCloseUp()">
	//txt_fdcode.value = gclx_sfdcode.BindColVal;	
</script> -->
<script language=JavaScript  for=gcds_data0 event=OnLoadCompleted(row,colid)>
  chk = gcds_data0.namevalue(1,"CNT");
</script> 

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.0";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data1 event=OnLoadCompleted(row,colid)>
 // ln_Sum(); //�հ��ܾ� Sum ���
 
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script> 

<script language=JavaScript for=gcds_data1 event=onLoadError()>
		//alert("Error Code : " + gcds_data1.ErrorCode+"Message : " + gcds_data1.ErrorMsg );
</script>

<script language="javascript" for="gcds_print1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.1";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_print1 event=OnLoadCompleted(row,colid)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	//if (row<1) {
	//	alert("����Ͻ� ������ �����ϴ�.");
	//}else{
	ln_Sum1();
	ln_RptFormat1();
	gcrp_print1.preview();
	//}
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


<script language=JavaScript for=gclx_sfdcode event=OnSelChange()>
	
	if(gclx_sfdcode.bindcolval==""||gclx_sfdcode.bindcolval=="03"){
		ln_Enable('t');
		if(gclx_sfdcode.bindcolval=="") chkbox.checked=true;
	}else{
		ln_Enable('f');
	}

	if(gclx_sfdcode.bindcolval=="03"){
		sp0.style.display = "";
	}else{
		sp0.style.display = "none";
	}

</script>
<script language="javascript" for="gctr_upatcode" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_upatcode" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
    alert("Error Code : " + gctr_upatcode.ErrorCode + "\n" + "Error Message : " + gctr_upatcode.ErrorMsg + "\n");
</script><!-- ȯ������ -->
<script language=JavaScript for=gcgd_data1 event=OnDblClick(row,colid)>
	var row = gcds_data1.rowposition;
	var p_fcod = gclx_sfdcode.BindColVal;//�����ڵ�
	var p_acod = gcds_data1.namevalue(row,"ATCODE");//�����ڵ�
	var p_frdt = gcem_staxdatto.text.substring(0,4) + "0101";//����1
	var p_todt = gcem_staxdatto.text + "31";//����2
	ln_Popup2(p_fcod,p_acod,p_frdt,p_todt);	//��������[�Ϻ�] Popup
</script>  

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!--  -->
<script language="javascript" for="gctr_exchange" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_exchange" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
  	alert("Error Code : " + gctr_exchange.ErrorCode + "\n" + "Error Message : " + gctr_exchange.ErrorMsg + "\n");
</script>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a030008_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;" height="47">&nbsp;
		    <span id=sp0 style="display:none;"> <!-- ��ȯ����/ ��ȯ���� �ڵ� �ݿ� -->
				<img src="../../Common/img/btn/com_b_cha.gif"  style="cursor:hand" onclick="ln_Exchange()">
			</span>
		    <!--img name="btn_print" src="../../common/img/btn/com_b_banyoung.gif"	style="cursor:hand"	onclick="ln_up_Atcode_Create999()"-->
            <img name="btn_print" src="../../Common/img/btn/com_b_eyuol.gif"	style="cursor:hand"	onclick="ln_up_Atcode_Create000()"  alt="2010�⿡�� 2011������ ���̿��� ȸ������ 2011 �Է� ">
			<!--  <img name="btn_print" src="../../common/img/btn/com_b_hitotal.gif"	style="cursor:hand"	onclick="ln_up_Atcode_Create_1()">   -->
		    <!--  <img name="btn_print" src="../../common/img/btn/com_b_hitotal.gif"	style="cursor:hand"	onclick="ln_up_Atcode_Create_2()">   -->
			<img name="btn_print" src="../../Common/img/btn/com_b_hitotal.gif"	style="cursor:hand"	onclick="ln_up_Atcode_Create()">
			<img name="btn_print" src="../../Common/img/btn/com_b_print.gif"	style="cursor:hand"	onclick="ln_Print1()"> 
		    <img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand" onclick="ln_Excel()">
			<img name="btn_query" src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand" onclick="ln_Query1()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table cellpadding="1" cellspacing="0" border="0" style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�����ڵ�&nbsp;</nobr></td>
					<td width="150px;" class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="FDNAME^0^150">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  
					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;ȸ����&nbsp;</nobr></td>
					<td width="150px"  class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:50px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="####/##">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>

					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;�û�ǥ����&nbsp;</nobr></td>
					<td width="150px;" class="tab23"><nobr>&nbsp;<comment id="__NSID__">
						<object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:3px;width:100px;height:110px;">
							<param name=CBData			    value="A^��ü,Y^������,N^�������">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value=false>
							<param name=ListExprFormat	value="CDNAM^0^150">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;
						</nobr>
					</td>  

					<td width="50px" class="tab12" bgcolor="#eeeeee"><nobr>�����а�</nobr></td>
					<td width="35px" class="tab23" ><nobr>&nbsp;
						<input type=checkbox  id=chkbox_md  style=width:15px;position:relative;left:-4px;top:-1px;>
					</nobr>	
					</td>

					<td width="100px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;��ȭ����&nbsp;</nobr></td>
					<td width="150px"><nobr>&nbsp;
						<input type=checkbox  id=chkbox  style=width:15px;position:relative;top:-1px;>
					</nobr>	
					</td>
         
					<td width=100%>&nbsp;</td>
				</tr>
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="4">
			<table width="875" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:875" class="tab32">
			<comment id="__NSID__"><object  id="gcgd_data1"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
				style="height:420;width:875" >
				<PARAM NAME="DataID"		VALUE="gcds_data1">
				<PARAM NAME="Editable"		VALUE="false">
				<PARAM NAME="BorderStyle"	VALUE="0">
				<param name="Fillarea"		VALUE="true">
				<PARAM NAME="SortView"		VALUE="left">
				<PARAM NAME="ColSizing"		VALUE="false">
				<param name="ViewSummary"	value=1>
				<PARAM NAME="IndWidth"		VALUE="0">
				<PARAM NAME="Format"		VALUE=" 
					<G>Name='����', HeadBgColor=#B9D4DC,HeadAlign=center
					<C>ID=DEVAL,	Name='�ܾ�',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB	</C>
					<C>ID=DETOT,	Name='�հ�' ,width=130,HeadBgColor=#B9D4DC,HeadAlign=center, align=right   SumBgColor=#C3D0DB</C>
					</G>
					<C>ID=ATCODE, Name='�����ڵ�' ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center SumBgColor=#C3D0DB  SumText='��  ��' show=false</C>
					<C>ID=ATKORNAM, Name='��������' ,width=335, HeadBgColor=#B9D4DC,HeadAlign=center, align=left SumBgColor=#C3D0DB  SumText='��  ��'</C>			
					<G>Name='�뺯', HeadBgColor=#B9D4DC,HeadAlign=center
					<C>ID=CRTOT,	Name='�հ�' ,width=130,HeadBgColor=#B9D4DC,HeadAlign=center,	align=right SumBgColor=#C3D0DB</C>
					<C>ID=CRVAL,	Name='�ܾ�',width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=right SumBgColor=#C3D0DB</C>
					</G>
				">
         			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font style="position:relative;top:4px;"></font><font id=ft_cnt1 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D  D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �û�ǥ
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print1 classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_datetime">
	<param NAME="DetailDataID"			VALUE="gcds_print1">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="false">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="NullRecordFlag"		VALUE="true">
	<PARAM NAME="Format" VALUE="

">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 