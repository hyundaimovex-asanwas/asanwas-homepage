<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ���ݰ��� - �����ڱݽ��� �� ��ȹ
+ ���α׷� ID	:  a400040.jsp
+ �� �� �� ��	:  
+ ��   ��  ��      :  �� �� ��
+ �ۼ� �� ��      :  2016.11.14
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
+ �� �� �� ��     :	         
+ ��   ��  ��      : 
+ �� �� �� ��     : 
+ �� �� �� ��     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�����ڱݽ��� �� ��ȹ</title>

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
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�

var gs_frdt="";
var gs_todt="";
var gs_hf_gb="";  //�ݱⱸ��
var gs_hf_seq=""; //�ݱ⳻����

//����
var gin_reamt=0 ;    //�ԱݼҰ�
var gout_reamt=0 ;   //��ݼҰ�
var ginout_reamt=0 ; //�ڱݰ�������

var g_610_reamt=0 ;  //������ ����
var g_620_reamt=0 ;  //��������


//���ϰ�ȸ
var gin_cuamt=0 ;    //�ԱݼҰ�
var gout_cuamt=0 ;   //��ݼҰ�
var ginout_cuamt=0 ; //�ڱݰ�������

var g_610_cuamt=0 ;  //������ ����
var g_620_cuamt=0 ;  //��������





<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_Before();
}

<%
/******************************************************************************
	Description : ����ȸ
******************************************************************************/
%>
function ln_Before(){
	gcem_dedate.text = gs_date;
	gcem_dedate.text ="20161001";
	gcem_reptdt.text ="20161004";
}

<%
/******************************************************************************************
	Description : ��ȸ ( ���̺� ����� Data ��ȸ )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(gcem_dedate.text==""){
		alert("�ŷ����ڸ� �Է��Ͻʽÿ�.");
		return false;
	}
	
	//����ݳ���
    gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400040_s1?v_str1="+gcem_reptdt.text 
    		                                                              +"&v_str2="+gcem_dedate.text;
    		                                                            
    gcds_data01.Reset();
    
   
    //����ǥ
	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400040_s2?v_str1="+gcem_reptdt.text 
															              +"&v_str2="+gcem_dedate.text;									             
	gcds_data02.Reset();
	
	 //����ǥ
	gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400040_s4?v_str1="+gcem_reptdt.text 
															              +"&v_str2="+gcem_dedate.text;									             
	gcds_data03.Reset();
}
<%
/******************************************************************************************
	Description : ����
******************************************************************************************/
%>
function ln_Save(){
	
	//�������ڸ� �Է��Ͻʽÿ�.
	if(!ln_Chk_Save())return;
	else if (gcds_data02.IsUpdated) {
		if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue   = "Account.a400040_t1(I:USER=gcds_data02,I:USER2=gcds_data01 )";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400040_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			prompt('',gcds_data02.text);
			prompt('',gcds_data01.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}


function ln_Chk_Save(){
	
	for(var i = 1; i<=gcds_data02.countrow; i++){
		
		//�ʼ��׸� üũ 
		if(gcds_data02.namevalue(i,"REPTDT")==""){
			alert("�������ڸ� Ȯ���Ͻʽÿ�.");
			return false;
		}
		
		if(gcds_data02.namevalue(i,"DEDATE")==""){
			alert("�ŷ����ڸ� Ȯ���Ͻʽÿ�.");
			return false;
		}
		
		if(gcds_data02.namevalue(i,"INOUTGB")==""){
			alert("������ Ȯ���Ͻʽÿ�.");
			return false;
		}
		
		if(gcds_data02.namevalue(i,"RSTSEQ")==""){
			alert("������ Ȯ���Ͻʽÿ�.");
			return false;
		}
		
		if(gcds_data02.namevalue(i,"REMARK")==""){
			alert("���並 Ȯ���Ͻʽÿ�.");
			gcgd_disp02.FOCUS();
			return false;
		}
	}
	
	return true;
}

/******************************************************************************************
	Description : ����
*****************************************************************************************/
function ln_Delete(){

}

/*****************************************************************************************
	Description : �߰�
*****************************************************************************************/
function ln_Add(){
 
}

<%
/******************************************************************************
Description : �߰�  (�߰� �Աݳ����� ������ ��� �Ǻ��� �Է°���. )
******************************************************************************/
%>
function ln_AddCnt(){
	
	if(gcds_data02.IsUpdated){
		alert("�̹� �ݿ��Ǿ����ϴ�. ���� �� �ٽ� �Ͻʽÿ�.");
		return false;
	}
	
	
	if(gcds_data01.countrow<1){
		alert("����� ������ �������� �ʽ��ϴ�. ��ȸ �� �ٽ� ���� �Ͻʽÿ�.");
		return false; 
	};
	
	var chkcnt=0;
	for(var k=1; k<=gcds_data01.countrow;k++){
		if(gcds_data01.namevalue(k,"CHKBOX")=="T"){
			chkcnt+=1;
		}
	}
	
	if(chkcnt==0){
		alert("���õ� ���� �������� �ʽ��ϴ�.");
		return false;
	}
	

	if(gcds_data02.countrow<1){
		alert("�Ǻ� �߰� �� ����ǥ�� �����Ǿ�� �����մϴ�.");
		return false;
	}
	
	var strDatagb="";
	var temprow2=0;
	
	//�������� �����ϴ� ���
	for(var i=1;i<=gcds_data01.countrow; i++){	
		if(gcds_data01.namevalue(i,"CHKBOX")=="T"){
			
			//�ش���� ����ǥ�� ���� RSTSEQ�� �����ϴ��� üũ 
			strDatagb="";
			for(var j=1;j<=gcds_data02.countrow;j++){
				if(gcds_data02.namevalue(j,"RSTSEQ")==gcds_data01.namevalue(i,"RSTSEQ")){
					strDatagb="1";
				}
			}
			
			//�����ϸ� ������ ������ ���� ����
			if(strDatagb=="1"){
				for(var j=1;j<=gcds_data02.countrow;j++){
					if(gcds_data02.namevalue(j,"RSTSEQ")==gcds_data01.namevalue(i,"RSTSEQ")){
						strDatagb=="1";
						gcds_data01.namevalue(i,"RESYN") ="Y";
						gcds_data02.namevalue(j,"REAMT") =gcds_data02.namevalue(j,"REAMT")+ gcds_data01.namevalue(i,"REAMT");
					}
				}
			}else{
				
				temprow2=0;
				for(var j=1;j<=gcds_data02.countrow;j++){
					if(gcds_data02.namevalue(j,"RSTSEQ")<=gcds_data01.namevalue(i,"RSTSEQ")){
						temprow2 = j+1;
					}
				}
				
				gcds_data01.namevalue(i,"RESYN") ="Y";
				gcds_data02.Insertrow(temprow2);
				ln_Data02_Setting(gcds_data01.namevalue(i,"REAMT"), temprow2, i);
				
			}
		}
	}
	
	//�Ұ� �� �ڱݰ����� , �����̿�, �����̿� ����
	ln_Calc_Reamt();
	
	ln_Calc_Del_Cuamt();
	
	
    
	//lock�� ������ ��ü������ �ȵǰ� ��. 
	//lock�� ������ ��ü������ ����.
}

<%
/******************************************************************************
Description : �ݿ�
******************************************************************************/
%>
function ln_Total(){
	
	if(gcds_data01.countrow<1){
		alert("����� ������ �������� �ʽ��ϴ�. ��ȸ �� �ٽ� ���� �Ͻʽÿ�.");
		return false; 
	};
	
	//for(var k =1; k<gcds_data01.countrow;k++){
	//	if(gcds_data01.namevalue)	
	//}
	
	
	if(gcds_data02.countrow<1){
		
		//��弳��
		ln_SetDataHeader();
		
		//�����κ�......�߰���.
		//�����̿� ������ ��ȸ �� Addrow()
		gcds_temp1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400040_s3?v_str1="+gcem_dedate.text;													       			
	    gcds_temp1.Reset();
	    
	    //�����̿�
	    gcds_data02.addrow();
	    gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
		gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
	    gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = gcds_temp1.namevalue(gcds_temp1.rowposition,"INOUTGB"); 
	    gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = 1 ; 
	    gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")   = gcds_temp1.namevalue(gcds_temp1.rowposition,"REAMT"); 
	    gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "�����̿�"; 
	    gcds_data02.namevalue(gcds_data02.rowposition,"SEQ") = 1 ;
	    
        
	     alert("step::�����̿�");
	    //����� ������ Sort ��Ŵ 
	    gcds_data01.Sort();
        
	    
	    alert("step::�Ա�");
	    
        //����� ������  �������� Sum
		var intTemp = 0 ; 
		for(var i=1;i<=gcds_data01.countrow; i++){
			
			if(i==1){
				intTemp = gcds_data01.namevalue(i,"REAMT");
			}else if (i>1){
				if(gcds_data01.namevalue(i,"RSTSEQ")==gcds_data01.namevalue(i-1,"RSTSEQ")){
					intTemp+= gcds_data01.namevalue(i,"REAMT");
					
					//��������
					if(i==gcds_data01.countrow){	
						gcds_data02.addrow();
						ln_Data02_Setting(intTemp, gcds_data02.rowposition, i ); 
					}
				}else{
					gcds_data02.addrow();
					ln_Data02_Setting(intTemp, gcds_data02.rowposition, i-1 ); 
					intTemp = gcds_data01.namevalue(i,"REAMT");
					
					//�������� 
					if(i==gcds_data01.countrow){	
						gcds_data02.addrow();
						ln_Data02_Setting(intTemp, gcds_data02.rowposition, i );
					}
				}
			}	
		}
		
		
		
		
		alert("step::�ԱݼҰ�");
		ln_Data02_SubSum_Setting("�Ա�");  //�ԱݼҰ�
		
		
		alert("step::��ݼҰ�");
		ln_Data02_SubSum_Setting("���");  //��ݼҰ�
		
		//������ ���� = �Ա� - ���
		ginout_reamt = gin_reamt - gout_reamt;
		
		
		
		alert("step::�ڱݰ�����");
		gcds_data02.Insertrow(gcds_data02.rowposition+1);
		gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
		gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = "�ڱݰ�����";
		gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "�ڱݰ�����";
		gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
		//gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = gcds_data02.namevalue(gcds_data02.rowposition-1,"RSTSEQ")+100;
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = 600;
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")   = ginout_reamt;  
		
		
		alert("step::��ġ1");
		gcds_data02.Insertrow(gcds_data02.rowposition+1);
		gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
		gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = "��ġ";
		gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "1.������ ����";
		gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = gcds_data02.namevalue(gcds_data02.rowposition-1,"RSTSEQ")+10;
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")   = ginout_reamt;
		
		
		alert("step::��ġ2");
		//�������� �����Ͱ� ������ ��� ó�� �ؾ���. 
		gcds_data02.Insertrow(gcds_data02.rowposition+1);
		gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
		gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = "��ġ";
		gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "2.��������";
		gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = gcds_data02.namevalue(gcds_data02.rowposition-1,"RSTSEQ")+10;
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")   = 0;
		
		
		alert("step::�����̿�");
		gcds_data02.Insertrow(gcds_data02.rowposition+1);
		gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
		gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = "�����̿�";
		gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "�����̿�";
		gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
		//gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = gcds_data02.namevalue(gcds_data02.rowposition-1,"RSTSEQ")+10;
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = 800;
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")   = gcds_temp1.namevalue(gcds_temp1.rowposition,"REAMT")+ ginout_reamt;
		
		gcds_data02.namevalue(1,"CUAMT") = gcds_data02.namevalue(gcds_data02.rowposition,"REAMT");
		gcds_data02.namevalue(gcds_data02.countrow,"CUAMT") = gcds_data02.namevalue(gcds_data02.rowposition,"REAMT");
		
		//�ڱݰ� ������ Addrow
		
		//�����̿��� Addrow
		
		//���� ��ȹ�ݾ��� �߰� ��.
		
		ln_Calc_Plamt();		
		
		
	}else{
		//�Ѱ��̶� ������ ...�Ǻ��� Addrow() �ϰ� �ٸ� �Ұ� �� �Ϳ��̿� �����ʹ� ���� �ؾ���.
		//�Ǻ� �Ұ� ó���ؾ���. 	
	}
	
	
	//�����Ͱ� �� �ǵ� ���� ���� ����� ������ �������� ��ȸ �ؿ�.
	
	// ��ü���� 
	//1.�����̿�
	//2.�Ա� 
	//3.�ԱݼҰ�
	//4.���
	//5.��ݼҰ�
	//6.��ġ
	//7.��ġ�Ұ�
	//8.�����̿�
	
	//�����Ͱ� �����ϴ� ���� ���� �����͸� �ҷ���.
	
	//�Ǻ� �ݿ��� ��.....
	
}


<%
/******************************************************************************
Description : ����ǥ ������ ���� _ ��������ǥ�� ���ϰ�ȹ��  �������ǥ�� ��ȹ�ݾ����� 
******************************************************************************/
%>

function ln_Calc_Plamt(){
		
	alert("gcds_data03.countrow::::"+gcds_data03.countrow);
	//�������� �����ϴ� ���
	for(var i=1;i<=gcds_data03.countrow; i++){	
		
		alert("i::"+i+":RSTSEQ:"+gcds_data03.namevalue(i,"RSTSEQ"));
	
		//�ش���� ����ǥ�� ���� RSTSEQ�� �����ϴ��� üũ 
		strDatagb="";
		for(var j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.namevalue(j,"RSTSEQ")==gcds_data03.namevalue(i,"RSTSEQ")){
				strDatagb="1";
			}
		}
		
		
		alert("strDatagb::"+strDatagb);
		//�����ϸ� ������ ������ ���� ����
		if(strDatagb=="1"){
			for(var j=1;j<=gcds_data02.countrow;j++){
				if(gcds_data02.namevalue(j,"RSTSEQ")==gcds_data03.namevalue(i,"RSTSEQ")){
					strDatagb=="1";
					alert("j:::"+j+"RSTSEQ" + gcds_data02.namevalue(j,"RSTSEQ"))
					gcds_data02.namevalue(j,"PLAMT") =gcds_data03.namevalue(i,"CUAMT");
				}
			}
		//�������� ������ INSERT	
		}else{
			
			temprow2=0;
			for(var j=1;j<=gcds_data02.countrow;j++){
				if(gcds_data02.namevalue(j,"RSTSEQ")<=gcds_data03.namevalue(i,"RSTSEQ")){
					temprow2 = j+1;
				}
			}
			
			gcds_data02.Insertrow(temprow2);
			gcds_data02.namevalue(temprow2,"REPTDT")  = gcem_reptdt.text;
			gcds_data02.namevalue(temprow2,"DEDATE")  = gcem_dedate.text;
			gcds_data02.namevalue(temprow2,"INOUTGB") = gcds_data03.namevalue(i,"INOUTGB");
			gcds_data02.namevalue(temprow2,"REMARK")  = gcds_data03.namevalue(i,"REMARK");
			gcds_data02.namevalue(temprow2,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
			gcds_data02.namevalue(temprow2,"RSTSEQ")  = gcds_data03.namevalue(i,"RSTSEQ"); 
			gcds_data02.namevalue(temprow2,"PLAMT")   = gcds_data03.namevalue(i,"CUAMT"); 
			
		}
	}
}

<%
/******************************************************************************
Description : ����ǥ ������ ����
******************************************************************************/
%>
function ln_Data02_Setting(intReamt, row02, row01){
	
	gcds_data02.namevalue(row02,"REPTDT")  = gcem_reptdt.text;
	gcds_data02.namevalue(row02,"DEDATE")  = gcds_data01.namevalue(row01,"DEDATE"); 
	gcds_data02.namevalue(row02,"INOUTGB") = gcds_data01.namevalue(row01,"INOUTGB");
	gcds_data02.namevalue(row02,"REMARK")  = gcds_data01.namevalue(row01,"REMARK");
	gcds_data02.namevalue(row02,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
	gcds_data02.namevalue(row02,"RSTSEQ")  = gcds_data01.namevalue(row01,"RSTSEQ"); 
	gcds_data02.namevalue(row02,"REAMT")   = intReamt; 
}

<%
/******************************************************************************
Description : ����ǥ ������ ����
******************************************************************************/
%>
function ln_Data02_SubSum_Setting(strInoutgb){
	
	var row_inoutgb=0;
	//�Ա� �Ұ�  addrow()
	for(var i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")==strInoutgb){
			row_inoutgb = i ;
		}
	}
	
	//��ݵ����Ͱ� ���� ��� 
	if(row_inoutgb==0){
		for(var i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"INOUTGB")=="�Ա�"){
				row_inoutgb = i ;
			}
		}
		
		row_inoutgb+=1;
	}
	
	
	
	gcds_data02.Insertrow(row_inoutgb+1);
	gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
	gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text; 
	gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB") = "�Ұ�";
	gcds_data02.namevalue(gcds_data02.rowposition,"REMARK")  = "�Ұ�";
	gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
	//gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = gcds_data02.namevalue(gcds_data02.rowposition-1,"RSTSEQ")+10;
	
	
	if(strInoutgb=="�Ա�"){
		gin_reamt = ln_SubSum_Reamt(strInoutgb);	
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")  = gin_reamt;  
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = 200;
	}else if(strInoutgb=="���"){
		gout_reamt = ln_SubSum_Reamt("���"); 
		gcds_data02.namevalue(gcds_data02.rowposition,"REAMT")  = gout_reamt;  
		gcds_data02.namevalue(gcds_data02.rowposition,"RSTSEQ")  = 400;
	}
}

<%
/******************************************************************************
Description : �Ұ� �ݾ� ����
******************************************************************************/
%>
function ln_SubSum_Reamt(strGB){
	var intReamt=0
	for(var i=1;i<=gcds_data02.countrow;i++){	
		if(gcds_data02.namevalue(i,"INOUTGB")==strGB){
			intReamt += gcds_data02.namevalue(i,"REAMT");
		}
	}
	return intReamt
}

<%
/******************************************************************************
Description : ���ϰ�ȹ �Ұ�  �� �����̿� �ݾ� ����
******************************************************************************/
%>
function ln_SubSum_Cuamt(strGB){
	var intCuamt=0
	for(var i=1;i<=gcds_data02.countrow;i++){	
		if(gcds_data02.namevalue(i,"INOUTGB")==strGB){
			intCuamt += gcds_data02.namevalue(i,"CUAMT");
		}
	}
	return intCuamt
}

<%
/******************************************************************************
Description : ���߰�
******************************************************************************/
%>

function ln_RowAdd(){
	
	//���� ������ Row�� �Ʒ��� ����	
	var strRow = gcds_data02.rowposition;
	gcds_data02.insertRow(gcds_data02.rowposition+1);
	
	gcds_data02.namevalue(gcds_data02.rowposition,"SEQ")     = gcds_data02.MAX(9,0,0)+1; 
	gcds_data02.namevalue(gcds_data02.rowposition,"REPTDT")  = gcem_reptdt.text;
	gcds_data02.namevalue(gcds_data02.rowposition,"DEDATE")  = gcem_dedate.text;

	if(gcds_data02.namevalue(strRow,"INOUTGB")=="�����̿�"||gcds_data02.namevalue(strRow,"INOUTGB")=="�Ա�"){
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB")="�Ա�";
	}else{
		gcds_data02.namevalue(gcds_data02.rowposition,"INOUTGB")="���";
	}
}

<%
/******************************************************************************
Description : �����
******************************************************************************/
%>
function ln_RowDel(){
	
	gcds_data02.DeleteRow(gcds_data02.rowposition);
	ln_Calc_Del_Cuamt();

}


<%
/******************************************************************************
Description : CUAMT �Ұ� �����̿� 
******************************************************************************/
%>
function ln_Calc_Cuamt(row){
	var row_inoutgb = 0;
	//�Ա� �Ұ�  addrow()
	
	gin_cuamt = ln_SubSum_Cuamt("�Ա�");
	gout_cuamt = ln_SubSum_Cuamt("���");
	
	if(gcds_data02.namevalue(row,"INOUTGB")=="�Ա�"){
		for(var i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"INOUTGB")=="�Ա�"){
				row_inoutgb = i ;
			}
		}
		gcds_data02.namevalue(row_inoutgb+1,"CUAMT") = gin_cuamt;
	}else if(gcds_data02.namevalue(row,"INOUTGB")=="���"){
		for(var j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.namevalue(j,"INOUTGB")=="���"){
				row_inoutgb = j ;
			}
		}
		gcds_data02.namevalue(row_inoutgb+1,"CUAMT")   = gout_cuamt;
	}
	
	
	//������ ����
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"RSTSEQ")=="610"){
			row_inoutgb = i ;
		}
	}
	
	g_610_cuamt = gin_cuamt - gout_cuamt;
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = g_610_cuamt;
	
	
	//��������
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"RSTSEQ")=="620"){
			row_inoutgb = i ;
		}
	}
	
    //���� ���������� �����ϴ� ��� �����;���.
	g_620_cuamt=0 ;  //��������
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = g_620_cuamt;
	
	ginout_cuamt = g_610_cuamt + g_620_cuamt;
	
	//�ڱݰ� ����
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"REMARK")=="�ڱݰ�����"){
			row_inoutgb = i ;
		}
	}
	
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = ginout_cuamt;
	
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�����̿�"){
			row_inoutgb = i ;
		}
	}
	
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = gcds_data02.namevalue(1,"CUAMT") + ginout_cuamt;
	
	
}





<%
/******************************************************************************
Description : ������� CUAMT �Ұ� �����̿� �ڱް� ���� ....
******************************************************************************/
%>
function ln_Calc_Del_Cuamt(){
	var row_inoutgb = 0;
	//�Ա� �Ұ�  addrow()

	for(var i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�Ա�"){
			row_inoutgb = i ;
		}
	}
		
	gin_cuamt = ln_SubSum_Cuamt("�Ա�");
	gcds_data02.namevalue(row_inoutgb+1,"CUAMT")   = gin_cuamt;
	
	for(var j=1;j<=gcds_data02.countrow;j++){
		if(gcds_data02.namevalue(j,"INOUTGB")=="���"){
			row_inoutgb = j ;
		}
	}
		
	gout_cuamt = ln_SubSum_Cuamt("���");
	gcds_data02.namevalue(row_inoutgb+1,"CUAMT")   = gout_cuamt;
	
	
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"REMARK")=="�ڱݰ�����"){
			row_inoutgb = i ;
		}
	}
	
	ginout_cuamt = gin_cuamt - gout_cuamt;
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = ginout_cuamt;
	
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�����̿�"){
			row_inoutgb = i ;
		}
	}
	
	gcds_data02.namevalue(row_inoutgb,"CUAMT") = gcds_data02.namevalue(1,"CUAMT") + ginout_cuamt;
}


<%
/******************************************************************************
Description : ReAMT �Ұ� �����̿� �ڱް� ���� ....
******************************************************************************/
%>
function ln_Calc_Reamt(){
	var row_inoutgb = 0;
	//�Ա� �Ұ�  addrow()

	for(var i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�Ա�"){
			row_inoutgb = i ;
		}
	}
		
	gin_reamt = ln_SubSum_Reamt("�Ա�");
	alert("gin_reamt::"+gin_reamt);
	gcds_data02.namevalue(row_inoutgb+1,"REAMT")= gin_reamt;
	
	for(var j=1;j<=gcds_data02.countrow;j++){
		if(gcds_data02.namevalue(j,"INOUTGB")=="���"){
			row_inoutgb = j ;
		}
	}
		
	gout_reamt = ln_SubSum_Reamt("���");
	gcds_data02.namevalue(row_inoutgb+1,"REAMT")   = gout_reamt;
	
	
	
	//������ ����
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"RSTSEQ")=="610"){
			row_inoutgb = i ;
		}
	}
	
	g_610_reamt = gin_reamt - gout_reamt;
	gcds_data02.namevalue(row_inoutgb,"REAMT") = g_610_reamt;
	
	
	//��������
	g_620_reamt=0 ;  
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"RSTSEQ")=="620"){
			row_inoutgb = i ;
		}
	}
	gcds_data02.namevalue(row_inoutgb,"REAMT") = g_620_reamt;
	
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�ڱݰ�����"){
			row_inoutgb = i ;
		}
	}
	
	ginout_reamt = gin_reamt - gout_reamt;
	gcds_data02.namevalue(row_inoutgb,"REAMT") = ginout_reamt;
	
	for( i=1;i<=gcds_data02.countrow;i++){
		if(gcds_data02.namevalue(i,"INOUTGB")=="�����̿�"){
			row_inoutgb = i ;
		}
	}
	
	gcds_data02.namevalue(row_inoutgb,"REAMT") = gcds_data02.namevalue(1,"REAMT") + ginout_reamt;
	
	gcds_data02.namevalue(1,"CUAMT") = gcds_data02.namevalue(row_inoutgb,"REAMT");
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/

<%
/******************************************************************************
	Description : ���� �ٿ�ε�
******************************************************************************/
%>

function ln_Excel(){
	gcgd_disp02.GridToExcel("���ݽ���ǥ","",2);
}


<%
/******************************************************************************
Description : �����ͼ� ��� ����
******************************************************************************/
%>

function ln_SetDataHeader(){
	
	var s_temp="";
	
	gcds_data02.clearAll();

	if (gcds_data02.countrow<1){
	    s_temp="";
		s_temp = "REPTDT:STRING,DEDATE:STRING,INOUTGB:STRING,REMARK:STRING,"
			   + "PLAMT:DECIMAL,REAMT:DECIMAL,CUAMT:DECIMAL,RSTSEQ:DECIMAL,SEQ:DECIMAL,"
			   + "ACCTNO:STRING,WRID:STRING,";
		gcds_data02.SetDataHeader(s_temp);
	}
}


<%
/******************************************************************************
Description : �����ͼ� ��� ����
******************************************************************************/
%>



<%
/******************************************************************************
Description : ���
******************************************************************************/
%>
function ln_Print(){

	gcrp_print.preview();
}


<%
/******************************************************************************
Description : ����
******************************************************************************/
%>
function ln_Finish(){
	/*
	ln_SetDataHeader2();
		
	if(gcds_data01.namevalue(1,"DEDATE")==gcem_dedate.text){
		gcds_closeyn.addrow();
		gcds_closeyn.namevalue(gcds_closeyn.rowposition,"DEDATE")=gcds_data01.namevalue(1,"DEDATE");
	}else{
		alert("�ŷ����ڸ� Ȯ���Ͻʽÿ�.");
		return false;
	}
	
	if (gcds_closeyn.IsUpdated) {
		if (confirm("���� �Ͻðڽ��ϱ�?")){	
			gctr_data.KeyValue   = "Account.a400030_t2(I:USER=gcds_closeyn)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400030_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			prompt('',gcds_closeyn.text);
			gctr_data.post();
			ln_Query();			
		}else{
			gcds_closeyn.undoAll();
		}	
	}
	*/
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--����ݳ��� -->
<object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+RSTSEQ">
	
</object>

<!--����ǥ -->
<object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+RSTSEQ">
</object>


<!--���� ����ǥ�� ���ϰ�ȹ -->
<object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+RSTSEQ">
</object>

<!--�����̿� -->
<object  id=gcds_temp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_temp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_temp3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


<object  id=gcds_temp4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcds_data01 event=OnLoadCompleted(rowcnt)>
	for (var i =1; i<=rowcnt; i++) {
		if(gcds_data01.namevalue(i,"RESYN")=="Y"){
			//gcds_data01.namevalue(i,"CHKBOX")="T";
		}
	}
	
</script>
 

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=gcgd_disp02 event=OnExit(row,colid,olddata)>
    //���ϰ�ȹ�� ���� ���
	if(colid ="CUAMT"){
		ln_Calc_Cuamt(row);
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(Row,Colid)>
	
	if(Colid=="CHKBOX"){
		
		if(Row<1){
			if(gcds_data01.namevalue(1,"CHKBOX")=="T"){
				for( i=1; i<=gcds_data01.countrow;i++){
					gcds_data01.namevalue(i,"CHKBOX") = "F";
					gcds_data01.namevalue(i,"RESYN") = "N";
				}
			}else{
				for( i=1; i<=gcds_data01.countrow;i++){
					gcds_data01.namevalue(i,"CHKBOX") = "T";
					gcds_data01.namevalue(i,"RESYN") = "Y";
				}
			}
		}
	}
   

</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("������ ������ ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("������ ������ ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<!-- <img src="../../Common/img/btn/com_b_print.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Print('01')"> -->
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_finish.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Finish()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Print()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>��������</nobr></td>
					<td class="tab24" style="width:300px"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_reptdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reptdt', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						</nobr>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>�ŷ�����</nobr></td>
					<td class="tab24"><nobr>
						<comment id="__NSID__">
							<object  id=gcem_dedate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_dedate', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
						</nobr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
    <tr>
		<td ALIGN=CENTER>
			<table width="1000px" cellpadding="1" cellspacing="0" border="0">   
				<tr>
					<td style="width:400;" align=left valign=top>	
						<table>
							<tr>
								<td><font size="2" color="blue" ><strong> [����ݳ���] </strong></font></td>
							    <td align = right>
							    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:0px;" onclick="ln_Total()">
							        <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_add.gif"		style="cursor:hand;position:relative;top:0px;" onclick="ln_AddCnt()">
							    </td>
							</tr>
							<tr> 			
								<td style="width:398" ALIGN=LEFT VALIGN=TOP colspan =2>
									<comment id="__NSID__">
									<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:398px;HEIGHT:460px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
										<PARAM NAME="DataID"        VALUE="gcds_data01">
										<PARAM NAME="Editable"		VALUE="true">
										<PARAM NAME="BorderStyle"	VALUE="0">
										<PARAM NAME="IndWidth"		VALUE="0">
										<PARAM NAME="ColSizing"		VALUE="true">
										<param NAME="Fillarea"      VALUE="true">
										<param name="SortView"      value="Left">
										<param name=UsingOneClick   value="1">
										<PARAM NAME="Format"        VALUE="  
										    <C> Name='����'      ID=CHKBOX	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  EditStyle=CheckBox  edit={Decode(RESYN,'Y',none,'N','','')}</C>
										    <C> Name='����'      ID=RESYN	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'   </C>
											<C> Name='����'      ID=INOUTGB	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  edit=none</C>
											<C> Name='����'      ID=RSTSEQ           HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=right  	SumBgColor='#C3D0DB'  bgcolor=yellow</C>
											<C> Name='����'      ID=REMARK           HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	    align=left  	SumBgColor='#C3D0DB'  bgcolor=yellow</C>
											<C> Name='���¹�ȣ'   ID=ACCTNO	        HeadAlign=Center HeadBgColor=#B9D4DC Width=103	    align=center  	SumBgColor='#C3D0DB'  edit=none </C>
											<C> Name='����'   	ID=REAMT		    HeadAlign=Center HeadBgColor=#B9D4DC Width=85   	align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum</C>
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset style="position:relative;left:5px;width:400px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
									&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
									</fieldset>
								</td>
						     </tr>
						 </table>
					</td>
				    <td>
				    	<table>	  
							<tr>
								<td><font size="2" color="blue" ><strong>[����ǥ]</strong></font></td>
								<td align = right><img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:53px;" onclick="ln_RowAdd()"></td>
								<td align = right><img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:53px;" onclick="ln_RowDel()"></td>
							</tr>
							<tr> 			
								<td style="width:590" ALIGN=LEFT VALIGN=TOP colspan=2>
								<comment id="__NSID__">
									<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:588px;HEIGHT:460px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
										<PARAM NAME="DataID"        VALUE="gcds_data02">
										<PARAM NAME="Editable"		VALUE="true">
										<PARAM NAME="BorderStyle"	VALUE="0">
										<PARAM NAME="IndWidth"		VALUE="0">
										<PARAM NAME="ColSizing"		VALUE="true">
										<param NAME="Fillarea"      VALUE="true">
										<param name="SortView"      value="Left">
										<PARAM NAME="Format"        VALUE="  
										    <C> Name='����'      ID=SEQ  	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  edit=none </C>
										    <C> Name='��������'   ID=REPTDT	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' show=false</C>
										    <C> Name='�ŷ�����'   ID=DEDATE	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' show=false</C>
											<C> Name='���¹�ȣ'   ID=ACCTNO	        HeadAlign=Center HeadBgColor=#B9D4DC Width=110	    align=center  	SumBgColor='#C3D0DB'  edit=none  show =false</C>
											<C> Name='����'      ID=INOUTGB	        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66','�����̿�','green', 'yellow')} EditStyle=Combo Data='�Ա�:�Ա�,���:���' </C>
											<C> Name='����'      ID=RSTSEQ	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', 'yellow')} </C>
											<C> Name='����'      ID=REMARK           HeadAlign=Center HeadBgColor=#B9D4DC Width=150 	    align=left  	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', 'yellow')}</C>
											<C> Name='��ȹ'	    ID=PLAMT	        HeadAlign=Center HeadBgColor=#B9D4DC Width=100	   	align=right	    SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', )}  edit=none </C>    
											<C> Name='����'   	ID=REAMT		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100   	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', )}  edit=none </C>
											<C> Name='���ϰ�ȹ'	ID=CUAMT    	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=right 	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', 'yellow')} </C>
											<C> Name='���'	    ID=REMARK2 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  bgcolor={Decode(INOUTGB,'�Ұ�','#FFCC66','�ڱݰ�����','#FFCC66', 'yellow')}  edit=none </C>
										">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset style="position:relative;left:5px;width:590px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
									&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
									</fieldset>
								</td>
							</tr>
						</table>
				  	</td>	
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_data02">
	<param name="DetailDataID"			    value="gcds_data02">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                    VALUE="
	
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=437 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=987 ,top=140 ,right=1921 ,bottom=418 ,border=true ,penstyle=solid ,penwidth=2</X>
	<X>left=987 ,top=71 ,right=1921 ,bottom=138 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='������' ,left=1691 ,top=355 ,right=1791 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1217 ,top=138 ,right=1217 ,bottom=415 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=990 ,top=140 ,right=1214 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1222 ,top=140 ,right=1447 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=1455 ,top=140 ,right=1680 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1453 ,top=138 ,right=1453 ,bottom=415 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1093 ,top=352 ,right=1069 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1569 ,top=352 ,right=1545 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1334 ,top=349 ,right=1310 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���' ,left=997 ,top=355 ,right=1072 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1101 ,top=355 ,right=1207 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1233 ,top=355 ,right=1307 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������' ,left=1336 ,top=355 ,right=1442 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1466 ,top=355 ,right=1540 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڱݽ��� �� ��ȹ' ,left=82 ,top=153 ,right=929 ,bottom=262 ,face='����' ,size=24 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='REPTDT', left=85, top=275, right=926, bottom=341 ,mask='( XXXXҴ XX�� XX�� )', face='Tahoma', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1685 ,top=138 ,right=1685 ,bottom=415 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��  ��' ,left=1691 ,top=140 ,right=1916 ,bottom=193 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1918 ,top=193 ,right=984 ,bottom=196 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=984 ,top=344 ,right=1918 ,bottom=344 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1569 ,top=355 ,right=1675 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�豹ȯ' ,left=1810 ,top=355 ,right=1916 ,bottom=407 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1810 ,top=352 ,right=1786 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��          ��          ��' ,left=1013 ,top=79 ,right=1894 ,bottom=132 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=217 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=148 ,right=1931 ,bottom=148 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='���' ,left=1598 ,top=161 ,right=1921 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=45 ,top=148 ,right=45 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=217 ,top=148 ,right=217 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=786 ,top=148 ,right=786 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=148 ,right=1931 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1580 ,top=148 ,right=1580 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=53 ,top=161 ,right=209 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=233 ,top=161 ,right=773 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ȹ' ,left=802 ,top=161 ,right=1042 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1058 ,top=151 ,right=1058 ,bottom=204 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='����' ,left=1069 ,top=161 ,right=1310 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='���ϰ�ȹ' ,left=1328 ,top=161 ,right=1569 ,bottom=198 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=51 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=45 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=786 ,top=0 ,right=786 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=48 ,top=0 ,right=407 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=1580 ,top=0 ,right=1580 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=407 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='INOUTGB', left=53, top=5, right=209, bottom=42, supplevel=1, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=217 ,top=0 ,right=217 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=225, top=5, right=773, bottom=42, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(PLAMT,0,,PLAMT)}', left=802, top=5, right=1045, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1058 ,top=0 ,right=1058 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{decode(CUAMT,0,,CUAMT)}', left=1331, top=5, right=1574, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(REAMT,0,,REAMT)}', left=1069, top=5, right=1312, bottom=42, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=42 ,top=0 ,right=1929 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
