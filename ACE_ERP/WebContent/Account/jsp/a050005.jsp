<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-----------------------------------------------------------------------------
+ �� �� �� ��	:	ȸ����� - �Ű��ڷ᳻���ޱ�
+ ���α׷� ID	: A050005.HTML
+ �� �� �� ��	: �Ű��ڷ� �����޴� ȭ��.
+ �� �� �� ��	: �̼���
------------------------------------------------------------------------------
+ �� �� �� ��     : �����ޱ� ���� �߰� ( ��ü, ����, ���� ) 
+ �� �� �� ��     : 2018.04.24
+ �� �� �� ��	: a050005_s1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ű��ڷ᳻���ޱ�</title>

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

var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2); + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	ln_Before();
	
	gcrd_taxgb.codevalue="1";
}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){
		
  gcds_data01.ClearData();
  gcds_data02.ClearData();
  gcds_data03.ClearData();
  gcds_data04.ClearData();
  gcds_data05.ClearData();
  gcds_data06.ClearData();
  gcds_data07.ClearData();
		
  gcds_data99.ClearData();
  //JYS. 2011.02.25
	//var str1 = gclx_sfdcode.BindColVal;		//�ͼӳ⵵
	if(gcem_saccyy.text<="2010"){
		var str1 = gclx_sfdcode.BindColVal;	
	}else{
		var str1 = "02" ;		//�����ڵ�
	}

	var str2 = gcem_saccyy.text;					//
	var str3 = gclx_saccyyqt.BindColVal;	//���

	//��ü 
	if(gcrd_taxgb.codevalue=="1"){
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s01?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();//7�����̺� (ȸ������)
	
		gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s03?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data02.Reset();//1�����̺� ���� - ���� �̿� ��
	
		gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s02?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data03.Reset();//3�����̺� ���� - ���� �̿� �հ�  
	
		gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s05?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data04.Reset();//2�����̺� ���� - ���� �̿� ��
		
	    gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s04?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data05.Reset();//4�����̺� ���� - ���� �̿� �հ� 
	
	    gcds_data06.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s06?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data06.Reset();//5�����̺� ���� - ���� �հ� 
	
		gcds_data07.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s07?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data07.Reset();//6�����̺� ���� - ���� �հ� 

	
	}else if (gcrd_taxgb.codevalue=="2"){ 
		//���� 
		
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s01?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();//7�����̺� (ȸ������)
		
		
		gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s03?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data02.Reset();//1�����̺� ���� - ���� �̿� ��
	
		
		gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s02?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data03.Reset();//3�����̺� ���� - ���� �̿� �հ�  
	
		
		gcds_data06.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s06?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data06.Reset();//5�����̺� ���� - ���� �հ� 
	
	}else if (gcrd_taxgb.codevalue=="3") {
	
		//����
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s01?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		//prompt('',gcds_data01.DataID);
		gcds_data01.Reset();//7�����̺� (ȸ������)
		
		
		gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s05?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data04.Reset();//2�����̺� ���� - ���� �̿� ��
		
		gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s04?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data05.Reset();//4�����̺� ���� - ���� �̿� �հ� 
		
		
		gcds_data07.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050005_s07?v_str1="+str1+ "&v_str2="+str2+"&v_str3="+str3;
		gcds_data07.Reset();//6�����̺� ���� - ���� �հ� 

	}

	ln_Display();
	
	gcgd_data01.Dataid = "gcds_data99";
	gcds_data99.resetStatus();

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
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : �ڷ� �����ޱ� ȭ�� display
******************************************************************************/
function ln_Display(){

  for(i=1;i<=gcds_data01.countrow;i++){
    ln_Forward_Batch_Data1(i);
  }

	for(i=1;i<=gcds_data02.CountRow;i++){
    ln_Forward_Batch_Data2(i);
  }

	for(i=1;i<=gcds_data03.countrow;i++){
    ln_Forward_Batch_Data3(i);
  }

	for(i=1;i<=gcds_data04.countrow;i++){
    ln_Forward_Batch_Data4(i);
  }

	for(i=1;i<=gcds_data05.countrow;i++){
    ln_Forward_Batch_Data5(i);
  }

	for(i=1;i<=gcds_data06.countrow;i++){
    ln_Forward_Batch_Data6(i);
  }


  for(i=1;i<=gcds_data07.countrow;i++){
    ln_Forward_Batch_Data7(i);
  }


}

/******************************************************************************
	Description : �����ޱ�
******************************************************************************/
function ln_Download(){
	
	var strFilename="K2218113.834";
	
	if(gcrd_taxgb.codevalue=="1"){        //��ü 
		strFilename
	}else if(gcrd_taxgb.codevalue=="2"){ //���� 
		strFilename = strFilename+"_����";
	}else if(gcrd_taxgb.codevalue=="3"){ //����
		strFilename = strFilename+"_����";
	}
		
		
	if (gcds_data99.countrow<1) {
		alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
	} else {
		
	    if(gclx_sfdcode.BindColVal=="02"){
			  //gcgd_data01.ExportFileEx('K1018510.695',true,1,false);
				gcgd_data01.ExportFileEx(strFilename,true,1,false);
	    }else if(gclx_sfdcode.BindColVal=="01"){
			  gcgd_data01.ExportFileEx(strFilename,true,1,false);
	    }
	}
}

/******************************************************************************
	Description : ǥ��
******************************************************************************/
function ln_Forward_Batch_Data1(i){
  var DISKET = "";
  DISKET+="7";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data01.namevalue(i,"VEND_ID")  ,"10");//�����ڵ�Ϲ�ȣ(����ڹ�ȣ)
  DISKET+=strStr(gcds_data01.namevalue(i,"VEND_NM")  ,"30");//�����ڻ�ȣ
  DISKET+=strStr(gcds_data01.namevalue(i,"VD_DIRECT"),"15");//�����ڼ���
  DISKET+=strStr(gcds_data01.namevalue(i,"ADDRS")    ,"45"); //�����ڻ���������
  DISKET+=strStr(gcds_data01.namevalue(i,"BSNS_CND") ,"17");//�����ھ���
  DISKET+=strStr(gcds_data01.namevalue(i,"BSNS_KND") ,"25");//����������
  DISKET+=intStr(gcds_data01.namevalue(i,"TAXTERM")  ,"12");//�ŷ��Ⱓ
  DISKET+=intStr(gcds_data01.namevalue(i,"WRDT")     ,"6");//�ۼ�����
  DISKET+=strStr(gcds_data01.namevalue(i,"FILLER")   ,"9");//����
  gcds_data99.addrow();
  
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : ���� �����̿� ��
******************************************************************************/
function ln_Forward_Batch_Data2(i){
  var DISKET = "";
  DISKET+="1";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data02.namevalue(i,"VENDID")  ,"10");/*����ڹ�ȣ*/
  DISKET+=intStr(gcds_data02.namevalue(i,"VENDSEQ")  ,"4");/*�Ϸù�ȣ*/
  DISKET+=intStr(gcds_data02.namevalue(i,"VENDIDVS") ,"10"); /*�ŷ��ڵ�Ϲ�ȣ*/
  DISKET+=strStr(gcds_data02.namevalue(i,"VENDNAME")  ,"30"); /*�ŷ��ڻ�ȣ*/
  DISKET+=strStr(gcds_data02.namevalue(i,"BSNSCND")  ,"17");/*�ŷ��ھ���*/
  DISKET+=strStr(gcds_data02.namevalue(i,"BSNSKND")  ,"25");/*�ŷ�������*/
  DISKET+=intStr(gcds_data02.namevalue(i,"SHTCNT")+"","7"); /*���ݰ�꼭�ż�*/
  DISKET+=intStr(gcds_data02.namevalue(i,"BLKCNT")+"" ,"2"); /*������*/
  DISKET+=minorintStr(gcds_data02.namevalue(i,"REQAMT")+"" ,"14");/*���ް���*/
  DISKET+=minorintStr(gcds_data02.namevalue(i,"VATAMT")+"" ,"13");/*����*/
  DISKET+="009001";
//  DISKET+=intStr(gcds_data02.namevalue(i,"WINEGM"),"1"); /*�Ű����ַ��ڵ� 0����*/
//  DISKET+=intStr(gcds_data02.namevalue(i,"WINESM") ,"1"); /*�ַ��ڵ�(�Ҹ�) 0����*/
//  DISKET+=intStr(gcds_data02.namevalue(i,"BOOKNUM") ,"4");/*�ǹ�ȣ 0����*/
//  DISKET+=intStr(gcds_data02.namevalue(i,"TAXATION") ,"3");/*���⼭ �ϴ� 0����*/

  //JYS 2011.02.25
  //if(gclx_sfdcode.BindColVal=="02") DISKET+="101"; //�����̸�
  //else DISKET+="227";
  DISKET+="227";

  DISKET+=strStr(gcds_data02.namevalue(i,"FILLER") ,"28");/*����*/

  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : ���� �����̿� �հ�
******************************************************************************/
function ln_Forward_Batch_Data3(i){
  var DISKET = "";
  DISKET+="3";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data03.namevalue(i,"VENDID")+""  ,"10");/*����ڹ�ȣ*/
  DISKET+=intStr(gcds_data03.namevalue(i,"VENDCNT")+"" ,"7");/*�Ѹ���ó��*/
  DISKET+=intStr(gcds_data03.namevalue(i,"SHTCNT")+""  ,"7");/*�Ѹż�*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"REQAMT")+""  ,"15");/*�Ѱ��ް���*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"VATAMT")+""  ,"14");/*�Ѻΰ�����*/
  DISKET+=intStr(gcds_data03.namevalue(i,"VENDCNT1")+"","7");/*����ڸ���ó��*/
  DISKET+=intStr(gcds_data03.namevalue(i,"SHTCNT1")+"" ,"7");/*����ڸż�*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"REQAMT1")+"" ,"15");/*����ڰ��ް���*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"VATAMT1")+"" ,"14");/*����ںΰ�����*/
  DISKET+=intStr(gcds_data03.namevalue(i,"VENDCNT2")+"","7");/*���θ���ó��*/
  DISKET+=intStr(gcds_data03.namevalue(i,"SHTCNT2")+"" ,"7");/*���θż�*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"REQAMT2")+"" ,"15");/*���ΰ��ް���*/
  DISKET+=minorintStr(gcds_data03.namevalue(i,"VATAMT2")+"" ,"14");/*���κΰ�����*/
  DISKET+=strStr(gcds_data03.namevalue(i,"FILLER")  ,"30");/*����*/

  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : ���� �����̿� ��
******************************************************************************/
function ln_Forward_Batch_Data4(i){
  var DISKET = "";
  DISKET+="2";//ǥ�� �ڷᱸ���ڵ�

  DISKET+=strStr(gcds_data04.namevalue(i,"VENDID"),"10");	/*����ڹ�ȣ*/	
  DISKET+=strStr(gcds_data04.namevalue(i,"VENDSEQ"),"4");	/*�Ϸù�ȣ*/	
  DISKET+=strStr(gcds_data04.namevalue(i,"VENDIDVS"),"10");/*����ڹ�ȣ1*/	
  DISKET+=strStr(gcds_data04.namevalue(i,"VENDNAME"),"30");/*��ȣ*/	
  DISKET+=strStr(gcds_data04.namevalue(i,"BSNSCND"),"17");/*����*/	
  DISKET+=strStr(gcds_data04.namevalue(i,"BSNSKND"),"25");/*����*/	
  DISKET+=intStr(gcds_data04.namevalue(i,"SHTCNT")+"","7");	/*�ż�*/	
  DISKET+=intStr(gcds_data04.namevalue(i,"BLKCNT")+"","2");	/*������*/	
  DISKET+=minorintStr(gcds_data04.namevalue(i,"REQAMT")+"","14");	/*���ް���*/	
  DISKET+=minorintStr(gcds_data04.namevalue(i,"VATAMT")+"","13");	/*�ΰ�����*/	
  DISKET+="009501";
//  DISKET+=strStr(gcds_data04.namevalue(i,"WINEGM"),"1");	/*�ַ�����*/	
//  DISKET+=strStr(gcds_data04.namevalue(i,"WINESM"),"1");	/*�ַ��Ҹ�*/	
//  DISKET+=strStr(gcds_data04.namevalue(i,"BOOKNUM"),"4");	/*�ǹ�ȣ*/	
//  DISKET+=strStr(gcds_data04.namevalue(i,"TAXATION"),"3");/*���⼭*/	
  
	//JYS 2011.02.25
	//if(gclx_sfdcode.BindColVal=="02") DISKET+="101"; //�����̸�
  //else DISKET+="227";
  DISKET+="227";

  DISKET+=strStr(gcds_data04.namevalue(i,"FILLER"),"28");/*����*/	

  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : ���� �����̿� �հ�
******************************************************************************/
function ln_Forward_Batch_Data5(i){
  var DISKET = "";
  DISKET+="4";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data05.namevalue(i,"VENDID")+""  ,"10");/*����ڹ�ȣ*/
  DISKET+=intStr(gcds_data05.namevalue(i,"VENDCNT")+"" ,"7");/*�Ѹ���ó��*/
  DISKET+=intStr(gcds_data05.namevalue(i,"SHTCNT")+""  ,"7");/*�Ѹż�*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"REQAMT")+""  ,"15");/*�Ѱ��ް���*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"VATAMT")+""  ,"14");/*�Ѻΰ�����*/
  DISKET+=intStr(gcds_data05.namevalue(i,"VENDCNT1")+"","7");/*����ڸ���ó��*/
  DISKET+=intStr(gcds_data05.namevalue(i,"SHTCNT1")+"" ,"7");/*����ڸż�*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"REQAMT1")+"" ,"15");/*����ڰ��ް���*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"VATAMT1")+"" ,"14");/*����ںΰ�����*/
  DISKET+=intStr(gcds_data05.namevalue(i,"VENDCNT2")+"","7");/*���θ���ó��*/
  DISKET+=intStr(gcds_data05.namevalue(i,"SHTCNT2")+"" ,"7");/*���θż�*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"REQAMT2")+"" ,"15");/*���ΰ��ް���*/
  DISKET+=minorintStr(gcds_data05.namevalue(i,"VATAMT2")+"" ,"14");/*���κΰ�����*/
  DISKET+=strStr(gcds_data05.namevalue(i,"FILLER")  ,"30");/*����*/
  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}


/******************************************************************************
	Description : ���� ���� �հ�
******************************************************************************/
function ln_Forward_Batch_Data6(i){
  var DISKET = "";
  DISKET+="5";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data06.namevalue(i,"VENDID")+""  ,"10");/*����ڹ�ȣ*/
  DISKET+=intStr(gcds_data06.namevalue(i,"VENDCNT")+"" ,"7");/*�Ѹ���ó��*/
  DISKET+=intStr(gcds_data06.namevalue(i,"SHTCNT")+""  ,"7");/*�Ѹż�*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"REQAMT")+""  ,"15");/*�Ѱ��ް���*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"VATAMT")+""  ,"14");/*�Ѻΰ�����*/
  DISKET+=intStr(gcds_data06.namevalue(i,"VENDCNT1")+"","7");/*����ڸ���ó��*/
  DISKET+=intStr(gcds_data06.namevalue(i,"SHTCNT1")+"" ,"7");/*����ڸż�*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"REQAMT1")+"" ,"15");/*����ڰ��ް���*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"VATAMT1")+"" ,"14");/*����ںΰ�����*/
  DISKET+=intStr(gcds_data06.namevalue(i,"VENDCNT2")+"","7");/*���θ���ó��*/
  DISKET+=intStr(gcds_data06.namevalue(i,"SHTCNT2")+"" ,"7");/*���θż�*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"REQAMT2")+"" ,"15");/*���ΰ��ް���*/
  DISKET+=minorintStr(gcds_data06.namevalue(i,"VATAMT2")+"" ,"14");/*���κΰ�����*/
  DISKET+=strStr(gcds_data06.namevalue(i,"FILLER")  ,"30");/*����*/

  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

/******************************************************************************
	Description : ���� ���� �հ�
******************************************************************************/
function ln_Forward_Batch_Data7(i){
  var DISKET = "";
  DISKET+="6";//ǥ�� �ڷᱸ���ڵ�
  DISKET+=intStr(gcds_data07.namevalue(i,"VENDID")+""  ,"10");/*����ڹ�ȣ*/
  DISKET+=intStr(gcds_data07.namevalue(i,"VENDCNT")+"" ,"7");/*�Ѹ���ó��*/
  DISKET+=intStr(gcds_data07.namevalue(i,"SHTCNT")+""  ,"7");/*�Ѹż�*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"REQAMT")+""  ,"15");/*�Ѱ��ް���*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"VATAMT")+""  ,"14");/*�Ѻΰ�����*/
  DISKET+=intStr(gcds_data07.namevalue(i,"VENDCNT1")+"","7");/*����ڸ���ó��*/
  DISKET+=intStr(gcds_data07.namevalue(i,"SHTCNT1")+"" ,"7");/*����ڸż�*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"REQAMT1")+"" ,"15");/*����ڰ��ް���*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"VATAMT1")+"" ,"14");/*����ںΰ�����*/
  DISKET+=intStr(gcds_data07.namevalue(i,"VENDCNT2")+"","7");/*���θ���ó��*/
  DISKET+=intStr(gcds_data07.namevalue(i,"SHTCNT2")+"" ,"7");/*���θż�*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"REQAMT2")+"" ,"15");/*���ΰ��ް���*/
  DISKET+=minorintStr(gcds_data07.namevalue(i,"VATAMT2")+"" ,"14");/*���κΰ�����*/
  DISKET+=strStr(gcds_data07.namevalue(i,"FILLER")  ,"30");/*����*/

  gcds_data99.addrow();
  gcds_data99.namevalue(gcds_data99.countrow,"DISKET") = DISKET;
}

function strStr(a, b){
  var returnVal = "";
  if(a==null) a = "";
  var alength = calculateBytes(a);
  var tt = calculateBytesStr(a,b);

  if(alength<=b){
    returnVal+=a;
    for(var i=0; i<b-alength; i++){
      returnVal+=" ";
    }
  }else{
    returnVal = tt;
  }
  return returnVal;
}
function intStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var alength=a.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=a;
  return returnVal;
}
function minorintStr(a, b){
  var returnVal="";
  if(a==null) a="";
  var temp = "";  
  var rst = "";
  if(a<0){
    a = strReplace(a, "-", "0");

    for(var k=0; k<a.length; k++){
      temp = a.charAt(k);
      if(k+1==a.length){
        temp=strReplace(temp, "0","}");
        temp=strReplace(temp, "1","J");
        temp=strReplace(temp, "2","K");
        temp=strReplace(temp, "3","L");
        temp=strReplace(temp, "4","M");
        temp=strReplace(temp, "5","N");
        temp=strReplace(temp, "6","O");
        temp=strReplace(temp, "7","P");
        temp=strReplace(temp, "8","Q");
        temp=strReplace(temp, "9","R");
      }
      rst += temp;
    }
  }else{
    rst = a;
  }

  var alength=rst.length;
  if(alength<b){
    for(var i=0; i<b-alength; i++){
      returnVal+="0";
    }
  }
  returnVal+=rst;
  return returnVal;
}
function calculateBytes(szValue){
  var tcount = 0;
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
    }
    else{
      tcount += 1;
    }
  }
  return tcount;
}
function calculateBytesStr(szValue,b){
  var tcount = 0;
  var tstr = "";
  var tmpStr = new String(szValue);
  var temp = tmpStr.length;
  var onechar;
  for ( k=0; k<temp; k++ ){
    onechar = tmpStr.charAt(k);
    if (escape(onechar).length > 4){
      tcount += 2;
      tstr += onechar;
    }
    else{
      tcount += 1;
      tstr += onechar;
    }
    if(tcount==b) break;
  }
  return tstr;
}

function strReplace(str, src, dest) {
  var reg = new RegExp(src, "gi");
  return str.replace(reg, dest);
}


/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
	gcem_saccyy.text = gs_date2;
	gclx_saccyyqt.index = 0;
  gclx_sfdcode.index=0;
	//����[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

  if (gcds_data99.countrow<1){
    var s_temp = "DISKET:STRING";
    gcds_data99.SetDataHeader(s_temp);
  }

}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
 <OBJECT id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
 </OBJECT>

 <OBJECT id=gcds_data06 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
 </OBJECT>

 <OBJECT id=gcds_data07 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
 </OBJECT>

</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_data99 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
  gcgd_data01.Dataid = "gcds_temp";
</script>

<script language="javascript" for="gcds_data01" event="onloadcompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data02" event="onloadcompleted(row,colid)">
</script>

<script language="javascript" for="gcds_data03" event="onloadcompleted(row,colid)">
</script>

<script language="javascript" for="gcds_data04" event="onloadcompleted(row,colid)">
</script>

<script language="javascript" for="gcds_data05" event="onloadcompleted(row,colid)">
</script>
  
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/a050005_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"><nobr>
			<img src="../../Common/img/btn/com_b_down.gif"		style="cursor:hand" onclick="ln_Download()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()"></nobr>&nbsp;
		</td>
  </tr>
  <tr> 
    <td COLSPAN=2>
			<table  cellpadding="0" cellspacing="0" border="0" style='width:876px;border:1 solid #708090'>
        <tr> 
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;��&nbsp;</nobr></td>
					<td class="tab23" style="width:100px;">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:1px;font-size:12px;width:70px;height:200px;">
								<param name=CBData					value="02^����,01^����">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^70">
								<param name=BindColumn			value="CDCODE">
							</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="height:25px;width:100px;" bgcolor="#eeeeee">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab23" width="100px"><comment id="__NSID__">
						<object  id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px; width:35px; height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;��&nbsp;</nobr></td>
					<td class="tab23" style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1�⿹��,2^1��Ȯ��,3^2�⿹��,4^2��Ȯ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					
					
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;&nbsp;&nbsp;&nbsp;��&nbsp;</nobr></td>
					<td style="width:100px;"><nobr>
						<comment id="__NSID__">
							<object id=gcrd_taxgb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:140">
								<param name=Cols	    value="3">
								<param name=Format	value="1^��ü,2^����,3^����">
							</object>
						</comment><script>__ws__(__NSID__);</script></nobr>
					<td>
					
					
					
					<td width="300">&nbsp;</td>
					
					
					
					
				</tr>
			</table>
		</td>
  </tr>
  <tr><td colspan="2" height=3></td></tr>
  <tr> 
    <td colspan="2"><comment id="__NSID__">
			<OBJECT id=gcgd_data01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="width:874px;height:422px;border:1 solid #777777;">
				<PARAM NAME="DataID"			VALUE="gcds_data99">
				<PARAM NAME="Editable"		VALUE="false">
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="ColSelect"		value="false">
				<param name="ColSizing"		value="true">
				<PARAM NAME="Format"			VALUE="  
					<C> Name=''	ID=DISKET	HeadAlign=Center HeadBgColor=#B9D4DC Width=843	align=left</C>
				">
				</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="POSiTION:ABSOLUTE;left:0px;TOP:501px;width:876;height:20px;background-color:#FFFFFF;border:1 solid #708090;border-top-width:0px;text-align:LEFT;"><font id=ft_cnt1 style="position:relative;left:0px;TOP:4px;"></font>
			</fieldset>
    </td>
  </tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 