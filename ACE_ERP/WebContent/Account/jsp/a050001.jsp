<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ȸ����� - �Ű��ڷ����
+ ���α׷� ID	:  A050001.html
+ �� �� �� ��	:  �Ű��ڷ���� ���� �� ��ȸ ȭ���̴�.
+ ��   ��  �� :  �� �� ��
+ �� �� �� ��	:	 a050001_s1
------------------------------------------------------------------------------
+ ��  ��  ��  :  �� �� ��
+ �� �� �� �� :  2010.03.25
+ �� �� �� �� :  ���ڼ��ݰ�꼭 �������� ���� �����ü format ���� �ݿ�
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�Ű��ڷ����</title>

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
var gs_date4  = gcurdate.substring(2,4);
var gs_date5  = gcurdate.substring(2,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//�����ڵ�
var gs_deptcd = gdeptcd;	//�μ��ڵ�
var gs_deptnm = gdeptnm;	//�μ���
var gs_usrnm  = gusrnm;		//����ڸ�
var temp01=0;	var temp02=0;
var temp03=0;	var temp04=0;
var temp05=0;	var temp06=0;
var temp07=0;	var temp08=0;
var temp09=0;	var temp10=0;	var temp11=0;

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
function ln_Query(e){
	if(e=="01"){  //����
      //JYS 2011.02.25
		 // var str1 = gclx_sfdcode.BindColVal;		//�����ڵ�
       
      if(gcem_saccyy.text<="2010"){
				var str1 = gclx_sfdcode.BindColVal;	
			}else{
				var str1 ="02" ;		//�����ڵ�
			}
			
      var str2 = gcem_saccyy.text;					//����⵵
      var str5 = "A";												//����
      var gisu = gclx_saccyyqt.BindColVal;	//���
      if(gisu=="1"){ 
        str3 = str2+"0101";
        str4 = str2+"0331";
      }else if(gisu=="2"){
        str3 = str2+"0401";
        str4 = str2+"0630";
      }else if(gisu=="3"){
        str3 = str2+"0701";
        str4 = str2+"0930";
      }else if(gisu=="4"){
        str3 = str2+"1001";
        str4 = str2+"1231";
      }
      
			//���ڼ��ݰ�꼭 �̿� �����  (  ���� ���� ���ڼ��ݰ�꼭 �̿� ����к����� ó���� )  ��
			gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s1?v_str1="+str1
                                                                                 +"&v_str2="+str2
																				 +"&v_str3="+str3
																				 +"&v_str4="+str4
																				 +"&v_str5="+str5;
      		gcds_data2.Reset();


			//���ڼ��ݰ�꼭 �̿� ���� ����� �հ� ( 2010.03.31 JYS ) 
			//�ű��ۼ�
			gcds_data4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s3?v_str1="+str1 //����                                                                        
                                                            					+ "&v_str2="+str2	//�⵵                                                                        
																				+ "&v_str3="+str3	//����Ⱓfrom                                                                
																				+ "&v_str4="+str4	//����Ⱓfrom                                                                
																				+ "&v_str5="+str5	//����/���� ����                                                              
																				+ "&v_str6=2" 		//���ڹ��� ���� 2-���ڼ��ݰ�꼭 �̿� ����/����
																				+ "&v_str7="+gisu;//���
      		gcds_data4.Reset();

			//���ڼ��ݰ�꼭 ���� ����� �հ� ( 2010.03.31 JYS ) 
			//�ű��ۼ�
			gcds_data6.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s3?v_str1="+str1 //����                                                                        
                                                                                + "&v_str2="+str2	//�⵵                                                                        
																				+ "&v_str3="+str3	//����Ⱓfrom                                                                
																				+ "&v_str4="+str4	//����Ⱓfrom                                                                
																				+ "&v_str5="+str5	//����/���� ����                                                              
																				+ "&v_str6=1" 		//���ڹ��� ����  1- ���ڼ��ݰ�꼭 ����/���� 
																				+ "&v_str7="+gisu;//���
		    //prompt('',gcds_data5.DataID);
      		gcds_data6.Reset();
			gcds_data6.UserStatus(gcds_data6.RowPosition)=1;

	        gcem_taxtermfr.text = str3;	      //�ŷ��Ⱓfr
	        gcem_taxtermto.text = str4;				//�ŷ��Ⱓto
  	}else if(e=="02"){ // ����
      //JYS 2011.02.25
			//var str1 = gclx_sfdcode2.BindColVal;	//�����ڵ�
      if(gcem_saccyy.text<="2010"){
		 var str1 = gclx_sfdcode.BindColVal;	
	  }else{
		 var str1 = "02" ;		//�����ڵ�
	  }
			
      var str2 = gcem_saccyy2.text;					//����⵵
      var str5 = "B";												//����
      var gisu = gclx_saccyyqt2.BindColVal;	//���
      
      if(gisu=="1"){
        str3 = str2+"0101";
        str4 = str2+"0331";
      }else if(gisu=="2"){
        str3 = str2+"0401";
        str4 = str2+"0630";
      }else if(gisu=="3"){
        str3 = str2+"0701";
        str4 = str2+"0930";
      }else if(gisu=="4"){
        str3 = str2+"1001";
        str4 = str2+"1231";
      }

			//���ڼ��ݰ�꼭 �̿� �����  (  ���� ���� ���ڼ��ݰ�꼭 �̿� ��������� ó���� ) 
      gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s1?v_str1="+str1
                                                           				  + "&v_str2="+str2
																		  + "&v_str3="+str3
																		  + "&v_str4="+str4
																		  + "&v_str5="+str5;
      gcds_data1.Reset();

	  //���ڼ��ݰ�꼭 �̿� ���� ����� �հ� ( 2010.03.29 JYS ) 
	  //�ű��ۼ�
	  gcds_data3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s3?v_str1="+str1 //����                                                                        
	                                                                      + "&v_str2="+str2	//�⵵                                                                        
																		  + "&v_str3="+str3	//����Ⱓfrom                                                                
																		  + "&v_str4="+str4	//����Ⱓfrom                                                                
																		  + "&v_str5="+str5	//����/���� ����                                                              
																		  + "&v_str6=2" 		//���ڹ��� ���� 2-���ڼ��ݰ�꼭 �̿� ����/����
																		  + "&v_str7="+gisu;//���
      gcds_data3.Reset();

	  //���ڼ��ݰ�꼭 ���� ����� �հ� ( 2010.03.29 JYS ) 
	  //�ű��ۼ�
	  gcds_data5.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s3?v_str1="+str1 //����                                                                        
                                                                          + "&v_str2="+str2	//�⵵                                                                        
																	      + "&v_str3="+str3	//����Ⱓfrom                                                                
																		  + "&v_str4="+str4	//����Ⱓfrom                                                                
																		  + "&v_str5="+str5	//����/���� ����                                                              
																		  + "&v_str6=1" 		//���ڹ��� ����  1- ���ڼ��ݰ�꼭 ����/���� 
																		  + "&v_str7="+gisu;//���
		  //prompt('',gcds_data5.DataID);
      gcds_data5.Reset();

	  if(gcds_data5.countrow==0){
	 	ln_Initial();
	  }
		
	  gcds_data5.UserStatus(gcds_data5.RowPosition)=1;



      //������.////////////////////////////////////////////////////////////////////////
			/*
      gcds_temp03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_s2?v_str1="+str1
                        + "&v_str2="+str2+"&v_str3="+str3+"&v_str4="+str4+"&v_str5=B";
      gcds_temp03.Reset();
			*/
			///////////////////////////////////////////////////////////////////////////////////

      gcem_taxtermfr2.text = str3;	//�ŷ��Ⱓfr
      gcem_taxtermto2.text = str4;	//�ŷ��Ⱓto
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

/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_SetDataHeader(){
	var s_tmp2 = "FDCODE:STRING,ACCYY:STRING,ACCYYQT:STRING,SEQNO:STRING,DATADIV:STRING,"
			   + "VENDID:STRING,VENDSEQ:STRING,VENDIDVS:STRING,VENDNAME:STRING,BSNSCND:STRING,"
			   + "BSNSKND:STRING,SHTCNT:DECIMAL,BLKCNT:DECIMAL,REQAMT:DECIMAL,VATAMT:DECIMAL,"
			   + "WINEGM:STRING,WINESM:STRING,BOOKNUM:STRING,TAXATION:STRING,FILLER:STRING,"
			   + "REQAMT4:DECIMAL,VATAMT4:DECIMAL";
	gcds_temp01.SetDataHeader(s_tmp2);
	gcds_temp02.SetDataHeader(s_tmp2);
}


/******************************************************************************
	Description : Head ���� ( �հ� )
******************************************************************************/
function ln_SetDataHeader2(){
  
	var s_tmp  = "FDCODE:STIRNG(2),ACCYY:STIRNG(4),ACCYYQT:STIRNG(1),DATADIV:STIRNG(1),VENDID:STIRNG(10),"
				+ "VENDCNT:DECIMAL(7.0),SHTCNT:DECIMAL(7.0),REQAMT:DECIMAL(15.0),VATAMT:DECIMAL(14.0),VENDCNT1:DECIMAL(7.0),"
				+ "SHTCNT1:DECIMAL(7.0),REQAMT1:DECIMAL(15.0),VATAMT1:DECIMAL(14.0),VENDCNT2:DECIMAL(7.0),SHTCNT2:DECIMAL(7.0),"
				+ "REQAMT2:DECIMAL(15.0),VATAMT2:DECIMAL(14.0),FILLER:STIRNG(30)";
	

	if(gcds_data3.countrow==0){
		gcds_data3.ClearAll();
		gcds_data3.SetDataHeader(s_tmp);  //�����հ� ( ���ڼ��ݰ�꼭 �̿� ) 
	}

  	if(gcds_data4.countrow==0){
		gcds_data4.ClearAll();
		gcds_data4.SetDataHeader(s_tmp);  //�����հ� ( ���ڼ��ݰ�꼭 �̿� ) 
	}
 
	
}


/******************************************************************************************
	Description : ���� DataSet 
******************************************************************************************/
function ln_TempDset1(){
	ln_SetDataHeader();
	ln_SetDataHeader2();
   
  	if(gcds_data2.countrow==0){
		gcds_data4.addRow();
		var row = gcds_data4.rowposition;
		//JYS 2011.02.25
		//gcds_data4.namevalue(row,"FDCODE")   = gclx_sfdcode2.BindColVal; 		//����
		gcds_data4.namevalue(row,"FDCODE")   = "02"; 		//����
		gcds_data4.namevalue(row,"ACCYY")    = gcem_saccyy2.text;		        //�⵵
		gcds_data4.namevalue(row,"ACCYYQT")  = gclx_saccyyqt2.BindColVal;		//���
		gcds_data4.namevalue(row,"DATADIV")  = "4";													//�ڷᱸ�� - �����հ� ���ڼ��ݰ�꼭 �̿�
		if(gclx_sfdcode2.BindColVal == '02'){
		  //JYS 2011.02.25
			//gcds_data4.namevalue(row,"VENDID")   = '1018510695';											//����ڹ�ȣ(������-����)
			gcds_data4.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-����)
		}else{
			gcds_data4.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-��)		
		}
		gcds_data4.namevalue(row,"VENDCNT")= 0;	 //�Ѹ���ó��
		gcds_data4.namevalue(row,"SHTCNT") = 0;	 //�Ѹż�
		gcds_data4.namevalue(row,"REQAMT") = 0;	 //�Ѱ��ް���
		gcds_data4.namevalue(row,"VATAMT") = 0;	 //�Ѻΰ�����
		gcds_data4.namevalue(row,"VENDCNT1")= 0;  //����ڸ���ó�� 
		gcds_data4.namevalue(row,"SHTCNT1") = 0;	 //����ڸż�     )
		gcds_data4.namevalue(row,"REQAMT1") = 0;	 //����ڰ��ް��� )
		gcds_data4.namevalue(row,"VATAMT1") = 0;	 //����ںΰ����� )
		gcds_data4.namevalue(row,"VENDCNT2")= 0;  //���θ���ó�� 
		gcds_data4.namevalue(row,"SHTCNT2") = 0;	 //���θż�     
		gcds_data4.namevalue(row,"REQAMT2") = 0;	 //���ΰ��ް��� 
		gcds_data4.namevalue(row,"VATAMT2") = 0;	 //���κΰ����� 
		gcds_data4.namevalue(row,"FILLER")  = ""; //����
	}else{
	  	gcds_data4.UserStatus(gcds_data4.RowPosition)=1;
		for(var i=1;i<=gcds_data2.countrow;i++){
			gcds_temp01.addRow();
			//JYS 2011.02.25
			//gcds_temp01.namevalue(i,"FDCODE")   = gcds_data2.namevalue(i,"FDCODE");		//����
			gcds_temp01.namevalue(i,"FDCODE")   = "02";		//����
			gcds_temp01.namevalue(i,"ACCYY")    = gcds_data2.namevalue(i,"TAXYY");		//�⵵
			gcds_temp01.namevalue(i,"ACCYYQT")  = gclx_saccyyqt.BindColVal;						//��� ///gcds_data2.namevalue(i,"TAXKIDIV")
			gcds_temp01.namevalue(i,"DATADIV")  = "2";																//�ڷᱸ��
			if(gclx_sfdcode.BindColVal == '02'){
			  //JYS 2011.02.25
        //gcds_temp01.namevalue(i,"VENDID")   = '1018510695';											//����ڹ�ȣ(������-����)
				gcds_temp01.namevalue(i,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-����)
			}else{
				gcds_temp01.namevalue(i,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-��)		
			}
			gcds_temp01.namevalue(i,"VENDIDVS") = gcds_data2.namevalue(i,"VEND_ID");	//����ڹ�ȣ1(���޹޴���)
			gcds_temp01.namevalue(i,"VENDNAME") = gcds_data2.namevalue(i,"VEND_NM");	//��ȣ
			gcds_temp01.namevalue(i,"BSNSCND")  = gcds_data2.namevalue(i,"BSNS_CND");	//����
			gcds_temp01.namevalue(i,"BSNSKND")  = gcds_data2.namevalue(i,"BSNS_KND");	//����
	//		gcds_temp01.namevalue(i,"SHTCNT")   = gcds_data2.namevalue(i,"SHTCNT")		//�ż� //gcds_data2.countrow;								
			gcds_temp01.namevalue(i,"SHTCNT")   = gcds_data2.namevalue(i,"SHTCNT");		//�ż� //gcds_data2.countrow;
			gcds_temp01.namevalue(i,"REQAMT")   = gcds_data2.namevalue(i,"TAXSUM");		//���ް���
			var v_taxsum = String(gcds_data2.namevalue(i,"TAXSUM"));									//������
			if (v_taxsum.length==1&&v_taxsum=="0"){
				gcds_temp01.namevalue(i,"BLKCNT") = 14;																	
			}else{
				gcds_temp01.namevalue(i,"BLKCNT") = 14-v_taxsum.length;
			}
			gcds_temp01.namevalue(i,"VATAMT")   = gcds_data2.namevalue(i,"TAXVATAMT");//�ΰ�����
			gcds_temp01.namevalue(i,"WINEGM")   = ' ';	//�ַ�����
			gcds_temp01.namevalue(i,"WINESM")   = ' ';	//�ַ��Ҹ�
			gcds_temp01.namevalue(i,"BOOKNUM")  = ' ';	//�ǹ�ȣ
			gcds_temp01.namevalue(i,"TAXATION") = ' ';	//���⼭
			gcds_temp01.namevalue(i,"FILLER")   = ' ';	//����
			
			gcds_temp01.namevalue(i,"REQAMT4") = gcds_data2.Sum(20,1,gcds_data2.countrow);	//�հ�(���ް���)
			gcds_temp01.namevalue(i,"VATAMT4") = gcds_data2.Sum(21,1,gcds_data2.countrow);	//�հ�(����)

			/* //table 7
			gcds_temp01.namevalue(i,"VD_DIRECT") = gcds_data2.namevalue(i,"VD_DIRECT");	//��ǥ�ڸ�
			gcds_temp01.namevalue(i,"ADDRS")		 = gcds_data2.namevalue(i,"ADDRESS1");	//������
			gcds_temp01.namevalue(i,"WRDT")			 = gs_date5;								//�ۼ�����

			var v_accyyqt = "";
			if(gclx_saccyyqt.bindcolval=="1") {
				v_accyyqt = gs_date4+"0101"+gs_date4+"0331";
			}else if(gclx_saccyyqt.bindcolval=="2") {
				v_accyyqt = gs_date4+"0401"+gs_date4+"0630";
			}else if(gclx_saccyyqt.bindcolval=="3") {
				v_accyyqt = gs_date4+"0701"+gs_date4+"0930";
			}else if(gclx_saccyyqt.bindcolval=="4") {
				v_accyyqt = gs_date4+"1001"+gs_date4+"1231";
			}
			gcds_temp01.namevalue(i,"TAXTERM")	 = v_accyyqt;	//�ŷ��Ⱓ
			*/
			temp01 += gcds_data2.namevalue(i,"SHTCNT");	
			temp02 += gcds_data2.namevalue(i,"TAXSUM");		
			temp03 += gcds_data2.namevalue(i,"TAXVATAMT");
		}				
	}
	//alert(temp01+"::::"+temp02+"::::"+temp03);
}

/******************************************************************************************
	Description : ���� DataSet
******************************************************************************************/
function ln_TempDset2(){
	ln_SetDataHeader();  //�����
	ln_SetDataHeader2(); //�����հ�
  //alert("gcds_data1.countrow::"+gcds_data1.countrow);
	
  	if(gcds_data1.countrow==0){ // ���� ���ڼ��ݰ�꼭 �̿� ����� ������ 
		gcds_data3.addRow();
		var row = gcds_data3.rowposition;
		//JYS 2011.02.25
		//gcds_data3.namevalue(row,"FDCODE")   = gclx_sfdcode2.BindColVal; 		//����
		gcds_data3.namevalue(row,"FDCODE")   =  "02"; 		//����
		gcds_data3.namevalue(row,"ACCYY")    = gcem_saccyy2.text;		        //�⵵
		gcds_data3.namevalue(row,"ACCYYQT")  = gclx_saccyyqt2.BindColVal;		//���
		gcds_data3.namevalue(row,"DATADIV")  = "3";													//�ڷᱸ�� - �����հ� ���ڼ��ݰ�꼭 �̿�
		if(gclx_sfdcode2.BindColVal == '02'){
			//JYS 2011.02.25
			//gcds_data3.namevalue(row,"VENDID")   = '1018510695';											//����ڹ�ȣ(������-����)
			gcds_data3.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-����)
		}else{
			gcds_data3.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-��)		
		}
		gcds_data3.namevalue(row,"VENDCNT")= 0;	 //�Ѹ���ó��
		gcds_data3.namevalue(row,"SHTCNT") = 0;	 //�Ѹż�
		gcds_data3.namevalue(row,"REQAMT") = 0;	 //�Ѱ��ް���
		gcds_data3.namevalue(row,"VATAMT") = 0;	 //�Ѻΰ�����
		gcds_data3.namevalue(row,"VENDCNT1")= 0;  //����ڸ���ó�� 
		gcds_data3.namevalue(row,"SHTCNT1") = 0;	 //����ڸż�     )
		gcds_data3.namevalue(row,"REQAMT1") = 0;	 //����ڰ��ް��� )
		gcds_data3.namevalue(row,"VATAMT1") = 0;	 //����ںΰ����� )
		gcds_data3.namevalue(row,"VENDCNT2")= 0;  //���θ���ó�� 
		gcds_data3.namevalue(row,"SHTCNT2") = 0;	 //���θż�     
		gcds_data3.namevalue(row,"REQAMT2") = 0;	 //���ΰ��ް��� 
		gcds_data3.namevalue(row,"VATAMT2") = 0;	 //���κΰ����� 
		gcds_data3.namevalue(row,"FILLER")  = ""; //����
		
	}else{ //���� ���ڼ��ݰ�꼭 �̿� ���� ��  ����
	  	gcds_data3.UserStatus(gcds_data3.RowPosition)=1;
		for(var i=1;i<=gcds_data1.countrow;i++){
			gcds_temp02.addRow();
			//JYS 2011.02.25
			//gcds_temp02.namevalue(i,"FDCODE")   = gcds_data1.namevalue(i,"FDCODE");		//����
      		gcds_temp02.namevalue(i,"FDCODE")   = "02";		//����
			gcds_temp02.namevalue(i,"ACCYY")    = gcds_data1.namevalue(i,"TAXYY");		//�⵵
			gcds_temp02.namevalue(i,"ACCYYQT")  = gclx_saccyyqt2.BindColVal;					//���
			gcds_temp02.namevalue(i,"DATADIV")  = "2";																//�ڷᱸ��
			if(gclx_sfdcode2.BindColVal == '02'){
				//JYS 2011.02.25
				//gcds_temp02.namevalue(i,"VENDID")   = '1018510695';											//����ڹ�ȣ(������-����)
        		gcds_temp02.namevalue(i,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-����)
			}else{
				gcds_temp02.namevalue(i,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-��)		
			}
			gcds_temp02.namevalue(i,"VENDIDVS") = gcds_data1.namevalue(i,"VEND_ID");	//����ڹ�ȣ1(���޹޴���)
			gcds_temp02.namevalue(i,"VENDNAME") = gcds_data1.namevalue(i,"VEND_NM");	//��ȣ
			gcds_temp02.namevalue(i,"BSNSCND")  = gcds_data1.namevalue(i,"BSNS_CND");	//����
			gcds_temp02.namevalue(i,"BSNSKND")  = gcds_data1.namevalue(i,"BSNS_KND");	//����
	//		gcds_temp02.namevalue(i,"SHTCNT")   = gcds_data1.countrow;	SHTCNT							//�ż�
			gcds_temp02.namevalue(i,"SHTCNT")   = gcds_data1.namevalue(i,"SHTCNT");			//�ż�
			gcds_temp02.namevalue(i,"REQAMT")   = gcds_data1.namevalue(i,"TAXSUM");		//���ް���
			gcds_temp02.namevalue(i,"VATAMT")   = gcds_data1.namevalue(i,"TAXVATAMT");//�ΰ�����
			var v_taxsum = String(gcds_data1.namevalue(i,"TAXSUM"));									//������
			if (v_taxsum.length==1&&v_taxsum=="0"){
				gcds_temp02.namevalue(i,"BLKCNT") = 14;																	
			}else{
				gcds_temp02.namevalue(i,"BLKCNT") = 14-v_taxsum.length;
			}

			var v_vend = gcds_data1.namevalue(i,"VEND_ID");
			if(v_vend.length=="10"){
				temp04++;		//����ڸ���ó��
				temp05+=gcds_data1.namevalue(i,"SHTCNT");		  //����ڸż�
				temp06+=gcds_data1.namevalue(i,"TAXSUM");			//����ڰ��ް���
				temp07+=gcds_data1.namevalue(i,"TAXVATAMT");	//����ںΰ�����
			}else if (v_vend.length=="13"){
				temp08++;		//���θ���ó��
				temp09+=gcds_data1.namevalue(i,"SHTCNT");		  //���θż�
				temp10+=gcds_data1.namevalue(i,"TAXSUM");			//���ΰ��ް���
				temp11+=gcds_data1.namevalue(i,"TAXVATAMT");	//���κΰ�����
			}
			gcds_temp02.namevalue(i,"WINEGM")   = ' ';	//�ַ�����
			gcds_temp02.namevalue(i,"WINESM")   = ' ';	//�ַ��Ҹ�
			gcds_temp02.namevalue(i,"BOOKNUM")  = ' ';	//�ǹ�ȣ
			gcds_temp02.namevalue(i,"TAXATION") = ' ';	//���⼭
			gcds_temp02.namevalue(i,"FILLER")   = ' ';	//����	
			temp01 += gcds_data1.namevalue(i,"SHTCNT");
			//temp05 += gcds_data1.namevalue(i,"SHTCNT1");
		} //for(var i=1;i<=gcds_data1.countrow;i++){

		//temp01 = gcds_temp03.Sum(2,1,gcds_temp03.countrow);	//�Ѹż�
		//temp02 = gcds_temp03.Sum(3,1,gcds_temp03.countrow);	//�Ѱ��ް���
		temp02 = temp06 + temp10;
		//temp03 = gcds_temp03.Sum(4,1,gcds_temp03.countrow);	//�Ѻΰ�����
		temp03 = temp07 + temp11;
		//temp05 = gcds_temp03.Sum(5,1,gcds_temp03.countrow);	//����ڸż� --> ������� �����ؾ��� 
		//temp09 = gcds_temp03.Sum(6,1,gcds_temp03.countrow);	//���θż�
		
		gcds_temp02.namevalue(i,"REQAMT4") = gcds_data1.Sum(20,1,gcds_data1.countrow);	//�հ�(���ް���)
		gcds_temp02.namevalue(i,"VATAMT4") = gcds_data1.Sum(21,1,gcds_data1.countrow);	//�հ�(����)

		/* //table 7
		gcds_temp02.namevalue(i,"VD_DIRECT") = gcds_data1.namevalue(i,"VD_DIRECT");	//��ǥ�ڸ�
		gcds_temp02.namevalue(i,"ADDRS")		 = gcds_data1.namevalue(i,"ADDRESS1");	//������
		gcds_temp02.namevalue(i,"WRDT")			 = gs_date5;														//�ۼ�����

		var v_accyyqt = "";
		if(gclx_saccyyqt2.bindcolval=="1") {
			v_accyyqt = gs_date4+"0101"+gs_date4+"0331";
		}else if(gclx_saccyyqt2.bindcolval=="2") {
			v_accyyqt = gs_date4+"0401"+gs_date4+"0630";
		}else if(gclx_saccyyqt2.bindcolval=="3") {
			v_accyyqt = gs_date4+"0701"+gs_date4+"0930";
		}else if(gclx_saccyyqt2.bindcolval=="4") {
			v_accyyqt = gs_date4+"1001"+gs_date4+"1231";
		}
		gcds_temp02.namevalue(i,"TAXTERM")	 = v_accyyqt;	//�ŷ��Ⱓ
		*/
	}
}


/******************************************************************************************
	Description : ���� ���� �ʱ�ȭ ( ���ڼ��ݰ�꼭 ���� ������ �������� ���� ��� �ʱⰪ ����)
******************************************************************************************/
function ln_Initial(){
	  gcds_data5.addRow();
		var row = gcds_data5.rowposition;
		//JYS 2011.02.25
		//gcds_data5.namevalue(row,"FDCODE")   = gclx_sfdcode2.BindColVal; 		//����
		gcds_data5.namevalue(row,"FDCODE")   = "02"; 		//����
		gcds_data5.namevalue(row,"ACCYY")    = gcem_saccyy2.text;		        //�⵵
		gcds_data5.namevalue(row,"ACCYYQT")  = gclx_saccyyqt2.BindColVal;		//���
		gcds_data5.namevalue(row,"DATADIV")  = "5";													//�ڷᱸ�� - �����հ� ���ڼ��ݰ�꼭 �̿�
		
		if(gclx_sfdcode2.BindColVal == '02'){
			//JYS 2011.02.25
			//gcds_data5.namevalue(row,"VENDID")   = '1018510695';											//����ڹ�ȣ(������-����)
			gcds_data5.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-����)
		}else{
			gcds_data5.namevalue(row,"VENDID")   = '2218113834';											//����ڹ�ȣ(������-��)		
		}

		gcds_data5.namevalue(row,"VENDCNT")= 0;	 //�Ѹ���ó��
		gcds_data5.namevalue(row,"SHTCNT") = 0;	 //�Ѹż�
		gcds_data5.namevalue(row,"REQAMT") = 0;	 //�Ѱ��ް���
		gcds_data5.namevalue(row,"VATAMT") = 0;	 //�Ѻΰ�����
		gcds_data5.namevalue(row,"VENDCNT1")= 0;  //����ڸ���ó�� 
		gcds_data5.namevalue(row,"SHTCNT1") = 0;	 //����ڸż�     )
		gcds_data5.namevalue(row,"REQAMT1") = 0;	 //����ڰ��ް��� )
		gcds_data5.namevalue(row,"VATAMT1") = 0;	 //����ںΰ����� )
		gcds_data5.namevalue(row,"VENDCNT2")= 0;  //���θ���ó�� 
		gcds_data5.namevalue(row,"SHTCNT2") = 0;	 //���θż�     
		gcds_data5.namevalue(row,"REQAMT2") = 0;	 //���ΰ��ް��� 
		gcds_data5.namevalue(row,"VATAMT2") = 0;	 //���κΰ����� 
		gcds_data5.namevalue(row,"FILLER")  = ""; //����
}


/******************************************************************************************
	Description : ����    01- ����    02-����
******************************************************************************************/
function ln_Create(e){
	if(e=="01"){ //����
		ln_TempDset1();
		if(gcds_temp01.IsUpdated) {	
			if(ln_Chk('01'))
			if (confirm("���� �����͸� ���� �Ͻðڽ��ϱ�?")){	
				gctr_data1.KeyValue = "Account.a050001_t1(I:USER=gcds_temp01,I:USER2=gcds_data4,I:USER3=gcds_data6)";
				gctr_data1.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_t1";
				/*
				gctr_data1.Parameters = "v_str3="+temp01+",v_str4="+temp02+",v_str5="+temp03;
				gctr_data1.post();
				ln_Query('01');
				ln_SetValue();
				*/

				//prompt('gcds_temp01',gcds_temp01.text);
				//prompt('gcds_data4',gcds_data4.text);
				//prompt('gcds_data6',gcds_data6.text);
				gctr_data1.post();
			}
		}else{
			alert("�����Ͻ� ������ �����ϴ�.");
		}
	}else if(e=="02"){ //����

		ln_TempDset2();
		if(gcds_temp02.IsUpdated||gcds_data3.IsUpdated) {	
			//if(ln_Chk('02'))
			if (confirm("���� �����͸� ���� �Ͻðڽ��ϱ�?")){	
				gctr_data2.KeyValue = "Account.a050001_t2(I:USER=gcds_temp02,I:USER2=gcds_data3,I:USER3=gcds_data5)";
				gctr_data2.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a050001_t2";

        //prompt('gcds_temp02',gcds_temp02.text);
				//prompt('gcds_data3',gcds_data3.text);
				//prompt('gcds_data5',gcds_data5.text);


				//Parameters�� �հ����̺� ���� 
        //temp01- temp02- temp03
				//temp04- temp05- temp06
				//temp07- temp08- temp09
				//temp10- temp11- 

        /*
				gctr_data2.Parameters = "v_str1="+temp01+",v_str2="+temp02+",v_str3="+temp03
														  + ",v_str4="+temp04+",v_str5="+temp05+",v_str6="+temp06
														  + ",v_str7="+temp07+",v_str8="+temp08+",v_str9="+temp09
														  + ",v_str10="+temp10+",v_str11="+temp11;

        //prompt('gcds_temp02::',gcds_temp02.text);
				gctr_data2.post();
				ln_Query('02');
				ln_SetValue();
				*/
				/*
				prompt('gcds_temp02',gcds_temp02.text);
				prompt('gcds_data3',gcds_data3.text);
				prompt('gcds_data5',gcds_data5.text);
				*/
				gctr_data2.post();
			}
		}else{
			alert("�����Ͻ� ������ �����ϴ�.");
		}
	}
}

/******************************************************************************
	Description : value set
******************************************************************************/
function ln_SetValue() {
	temp01=0;	temp02=0;	temp03=0;
	temp04=0;	temp05=0;	temp06=0;
	temp07=0;	temp08=0;	temp09=0;
	temp10=0;	temp11=0;
}

/******************************************************************************
	Description : �ʼ��׸� �Է�üũ 
******************************************************************************/
function ln_Chk(e) {
	if(e=="01"){
		if (fn_trim(gcem_vendid.text)==""){
			alert("��Ϲ�ȣ�� �������� �ʽ��ϴ�.");
			return false; 
		}/*
    for(var i=1; i<=gcds_temp01.countRow;i++){
      if(bytelength_1('',gcds_temp01.namevalue(i,"VENDNAME"),'')>30){
        alert('��ȣ���� �� �����Ͱ� �ֽ��ϴ�. \n�Է½� ©���� �Էµ˴ϴ�.'); 
        return true;
      }
    }*/

	}else if(e=="02"){
		if (fn_trim(gcem_vendid2.text)==""){
			alert("��Ϲ�ȣ�� �������� �ʽ��ϴ�.");
			return false; 
		}/*
    for(var i=1; i<=gcds_temp02.countRow;i++){
      if(bytelength_1('',gcds_temp02.namevalue(i,"VENDNAME"),'')>30){
        alert('��ȣ���� �� �����Ͱ� �ֽ��ϴ�. \n�Է½� ©���� �Էµ˴ϴ�.'); 
        return true;
      }
    }*/
	}
	return true;
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
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){
	if(e=="01"){
		if (gcds_data2.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp01.RunExcel('����');
	}else {
		if (gcds_data1.countrow<1) alert("�ٿ�ε��Ͻ� �ڷᰡ �����ϴ�.");
		else gcgd_disp02.RunExcel('����');
	}
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
	/*** ���� **********************************************************/
	gcem_saccyy.text    = gs_date2;	//�⵵
	gclx_saccyyqt.index = 0;				//���
	gcem_wrdt.text		  = gs_date;	//�ۼ�����

  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0101";
    gcem_taxtermto.text = gcem_saccyy.text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0401";
    gcem_taxtermto.text = gcem_saccyy.text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0701";
    gcem_taxtermto.text = gcem_saccyy.text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.text = gcem_saccyy.text+"1001";
    gcem_taxtermto.text = gcem_saccyy.text+"1231";
  }
  gclx_sfdcode.index=0;
  gclx_sfdcode2.index=0;
	//�����ڵ�

	gcds_fdcode1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode1.Reset();

	/*** ���� **********************************************************/
	gcem_saccyy2.text    = gs_date2; //�⵵
	gclx_saccyyqt2.Index = 0;        //���
	gcem_wrdt2.text		   = gs_date;	 //�ۼ�����	
  if(gclx_saccyyqt2.Index=="0"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0101";
    gcem_taxtermto2.text = gcem_saccyy2.text+"0331";
  }else if(gclx_saccyyqt2.Index=="1"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0401";
    gcem_taxtermto2.text = gcem_saccyy2.text+"0630";
  }else if(gclx_saccyyqt2.Index=="2"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0701";
    gcem_taxtermto2.text = gcem_saccyy2+"0930";
  }else if(gclx_saccyyqt2.Index=="3"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"1001";
    gcem_taxtermto2.text = gcem_saccyy2.text+"1231";
  }
	//�����ڵ�
	gcds_fdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode2.Reset();
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
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <!-- ���Ի� / ���ڼ��ݰ�꼭 �̿� ����-->
	<object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	  <PARAM NAME="SyncLoad" VALUE="true">
  </object>
   <!-- �����հ�/ ���� ���ݰ�꼭 �̿� ���� -->
	<object  id=gcds_data4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <PARAM NAME="SyncLoad" VALUE="true">
  </object>

	 <!-- �����հ� ���� ���ݰ�꼭 ����-->
	<object  id=gcds_data6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>

  <!-- �����/ ���� ���ݰ�꼭 �̿� ����  -->
  <object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	  <PARAM NAME="SyncLoad" VALUE="true">
  </object>

  <!-- �����հ�/ ���� ���ݰ�꼭 �̿� ���� -->
	<object  id=gcds_data3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
 </object>

  <!-- �����հ�/ ���� ���ݰ�꼭 ����  -->
  <object  id=gcds_data5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	  <PARAM NAME="SyncLoad" VALUE="true">
  </object>


 

</comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
<object  id=gcds_fdcode1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_fdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	if (row <1) {
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}else{
	}
</script>

<script language="javascript" for="gcds_fdcode1" event="onloadCompleted(row,colid)">
	gcds_fdcode1.InsertRow(1);
	gcds_fdcode1.NameValue(1,"FDCODE")="";
	gcds_fdcode1.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode.index=2;
	}else{
//		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

<script language="javascript" for="gcds_fdcode2" event="onloadCompleted(row,colid)">
	gcds_fdcode2.InsertRow(1);
	gcds_fdcode2.NameValue(1,"FDCODE")="";
	gcds_fdcode2.NameValue(1,"FDNAME")="";
	if(gs_userid=="ACCOUNT"){
//		gclx_sfdcode2.index=2;
	}else{
//		gclx_sfdcode2.bindcolval=gs_fdcode;
	}
</script>
<script language=JavaScript for=gclx_saccyyqt event=OnSelChange()>
  if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="1"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0101";
    gcem_taxtermto.text = gcem_saccyy.text+"0331";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="2"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0401";
    gcem_taxtermto.text = gcem_saccyy.text+"0630";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="3"){
    gcem_taxtermfr.text = gcem_saccyy.text+"0701";
    gcem_taxtermto.text = gcem_saccyy.text+"0930";
  }else if(gclx_saccyyqt.ValueOfIndex("CDCODE", gclx_saccyyqt.Index)=="4"){
    gcem_taxtermfr.text = gcem_saccyy.text+"1001";
    gcem_taxtermto.text = gcem_saccyy.text+"1231";
  }
</script>
<script language=JavaScript for=gclx_saccyyqt2 event=OnSelChange()>
  if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="1"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0101";
    gcem_taxtermto2.text = gcem_saccyy2.text+"0331";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="2"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0401";
    gcem_taxtermto2.text = gcem_saccyy2.text+"0630";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="3"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"0701";
    gcem_taxtermto2.text = gcem_saccyy2.text+"0930";
  }else if(gclx_saccyyqt2.ValueOfIndex("CDCODE", gclx_saccyyqt2.Index)=="4"){
    gcem_taxtermfr2.text = gcem_saccyy2.text+"1001";
    gcem_taxtermto2.text = gcem_saccyy2.text+"1231";
  }
</script>
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1)); /*����*/
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
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");


</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
 <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a050001_head.gif"></td>
    <td background="../../Common/img/com_t_bg.gif" align="right">&nbsp;</td>
	</tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right><comment id="__NSID__">
						<object id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="position:relative;left:0px;width:660px;height:20px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title=����</T>									
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

<!-- ���� ===========================================================================================================-->
<fieldset id=field1 style="position:absolute;top:160px;left:18px;height:480px;width:879px;bacground-color:#708090"></fieldset>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;��&nbsp;��</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
								<param name=CBData					value="02^����,01^��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;��&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1�⿹��,2^1��Ȯ��,3^2�⿹��,4^2��Ȯ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create('01')">
						<img src="../../Common/img/btn/com_b_query.gif"	 style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('01')"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr>
				<td style="position:relative;left:6px"><!-- ���� -->
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��Ϲ�ȣ</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendid classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:85px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=Format			value="000-00-00000">
									<param name=PromptChar	value="_">
									<param name=Enable			value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;ȣ</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��ǥ�ڸ�</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>������ּ�</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_addrs classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_bsnscnd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_bsnsknd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ۼ�����</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_wrdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_wrdt','Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ŷ��Ⱓ</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object id=gcem_taxtermfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="false">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxtermfr', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~<comment id="__NSID__">
								<object id=gcem_taxtermto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="false">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxtermto', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:1px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:304px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data2">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<PARAM NAME="Fillarea"      VALUE="true">
							<PARAM NAME="sortview"      VALUE="left">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='��Ϲ�ȣ'	ID=VEND_ID		HeadAlign=Center HeadBgColor=#B9D4DC Width=93		align=center	SumText='��'	SumBgColor='#C3D0DB' mask='XXX-XX-XXXXX'</C>
								<C> Name='��ȣ'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='�ż�'			ID=SHTCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='������'		ID=BLKCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='���ް���'	ID=TAXSUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB' sort=true</C>
								<C> Name='����'			ID=TAXVATAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='����'			ID=BSNS_CND		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='����'			ID=BSNS_KND		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 
			 
<!-- ���� ===========================================================================================================-->
<fieldset id=field2 style="position:absolute;top:160px;left:18px;height:480px;width:879px;bacground-color:#708090"></fieldset>
	<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style='display:none'>	
	<tr><td height="3px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;��&nbsp;��</nobr></td>
					<td class="tab23" style="width:90px">
						<comment id="__NSID__"><object  id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:80px;height:110px;">
								<param name=CBData					value="02^����,01^��">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
					<td class="tab23" style="width:60px"><comment id="__NSID__">
						<object id=gcem_saccyy2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:5px;top:0px;width:35px;height:20px;" class="txtbox">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY">
							<param name=PromptChar	  value="_">
							<param name=Enable				value="true">
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>&nbsp;��&nbsp;��&nbsp;��&nbsp;</nobr></td>
					<td style="width:100px;"><nobr><comment id="__NSID__">
						<object  id=gclx_saccyyqt2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:2px;width:90px;height:110px;">
							<param name=CBData					value="1^1�⿹��,2^1��Ȯ��,3^2�⿹��,4^2��Ȯ��">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^90">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> &nbsp;</nobr>
					</td>
					<td align="right">&nbsp;<nobr>      
						<img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Create('02')">
						<img src="../../Common/img/btn/com_b_query.gif"	 style="cursor:hand;position:relative;top:2px;right:2px" onClick="ln_Query('02')"> 
						</nobr>
					</td>
				</tr>
			</table>
				</td>
			</tr>
			<tr>
				<td style="position:relative;left:6px"><!-- ���� -->
					<table cellpadding="1" cellspacing="0" border="0" style='width:869px;height:30px;border:1 solid #708090'>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��Ϲ�ȣ</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object id=gcem_vendid2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:85px">
									<param name=Text				value="">
									<param name=Alignment		value=0>
									<param name=Border			value=true>
									<param name=Format			value="000-00-00000">
									<param name=PromptChar	value="_">
									<param name=Enable			value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;ȣ</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_vendnm2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��ǥ�ڸ�</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_vddirect2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>������ּ�</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_addrs2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
							<td class="tab21" style="width:256px"><comment id="__NSID__">
								<object  id=gcem_bsnscnd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:168px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script>
							</td>
							<td class="tab11" style="width:100px;" bgcolor="#eeeeee"><nobr>��&nbsp;&nbsp;&nbsp;&nbsp;��</nobr></td>
							<td class="tab22" style="width:400px;"><nobr><comment id="__NSID__">
								<object  id=gcem_bsnsknd2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:390px;height:20px;position:relative;left:5px;top:0px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
									<param name=Language			value=1>
								</object></comment><script>__ws__(__NSID__);</script></nobr>
							</td>
						</tr>
						<tr>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ۼ�����</nobr></td>
							<td class="tab23" style="width:256px"><comment id="__NSID__">
								<object id=gcem_wrdt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="true">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_wrdt','Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">
							</td>
							<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>�ŷ��Ⱓ</nobr></td>
							<td style="width:400px;"><nobr><comment id="__NSID__">
								<object id=gcem_taxtermfr2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
									style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="false">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxtermfr2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;">&nbsp;~<comment id="__NSID__">
								<object id=gcem_taxtermto2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
										style="position:relative; left:5px;top:2px; width:70px; height:20px;" class="txtbox">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
									<param name=Enable				value="false">
								</object></comment><script>__ws__(__NSID__);</script>
								<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_taxtermto2', 'Text')" style="position:relative;width:20px;left:9px;top:1px;cursor:hand;"></nobr>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER>
				<table width="847" cellpadding="1" cellspacing="0" border="0">
					<tr><td style="width:460;position:relative;top:1px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp02 classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH:867px;HEIGHT:304px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data1">
							<PARAM NAME="Editable"			VALUE="false">
							<PARAM NAME="BorderStyle"		VALUE="0">
							<PARAM NAME="IndWidth"			VALUE="0">
							<PARAM NAME="ColSizing"			VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<PARAM NAME="viewSummary"		VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<C> Name='No.'			ID={CURROW}		HeadAlign=Center HeadBgColor=#B9D4DC Width=40		align=center	SumText=''		SumBgColor='#C3D0DB'</C> 
								<C> Name='��Ϲ�ȣ'	ID=VEND_ID		HeadAlign=Center HeadBgColor=#B9D4DC Width=93		align=center	SumText='��'	SumBgColor='#C3D0DB' mask='XXX-XX-XXXXX'</C>
								<C> Name='��ȣ'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='�ż�'			ID=SHTCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='������'		ID=BLKCNT			HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='���ް���'	ID=TAXSUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='����'			ID=TAXVATAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=90		align=right		SumText=@sum	SumBgColor='#C3D0DB'</C>
								<C> Name='����'			ID=BSNS_CND		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
								<C> Name='����'			ID=BSNS_KND		HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=left		SumText=''		SumBgColor='#C3D0DB'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:869px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt02" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<td>
			</table>			
		</td> 
	</tr> 
</table> 

		</td>
	</tr> 
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [����]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data2>
	<param name=BindInfo		value='  
		<C>Col=VEND_ID			Ctrl=gcem_vendid				Param=text</C>
		<C>Col=VEND_NM			Ctrl=gcem_vendnm				Param=text</C>
		<C>Col=VD_DIRECT	  Ctrl=gcem_vddirect			Param=text</C>
		<C>Col=ADDRESS1		  Ctrl=gcem_addrs				  Param=text</C>
		<C>Col=BSNS_CND		  Ctrl=gcem_bsnscnd				Param=text</C>
		<C>Col=BSNS_KND		  Ctrl=gcem_bsnsknd				Param=text</C>
		<!--C>Col=WRDT				  Ctrl=gcem_wrdt				  Param=text</C-->
		<C>Col=TAXTERMFR	  Ctrl=gcem_taxtermfr			Param=text</C>
		<C>Col=TAXTERMTO	  Ctrl=gcem_taxtermto			Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [����]
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			value=gcds_data1>
	<param name=BindInfo		value='  
		<C>Col=VEND_ID			Ctrl=gcem_vendid2				Param=text</C>
		<C>Col=VEND_NM			Ctrl=gcem_vendnm2				Param=text</C>
		<C>Col=VD_DIRECT	  Ctrl=gcem_vddirect2			Param=text</C>
		<C>Col=ADDRESS1		  Ctrl=gcem_addrs2				Param=text</C>
		<C>Col=BSNS_CND		  Ctrl=gcem_bsnscnd2			Param=text</C>
		<C>Col=BSNS_KND		  Ctrl=gcem_bsnsknd2			Param=text</C>
		<!--C>Col=WRDT			Ctrl=gcem_wrdt2				  Param=text</C-->
		<C>Col=TAXTERMFR	  Ctrl=gcem_taxtermfr2		Param=text</C>
		<C>Col=TAXTERMTO	  Ctrl=gcem_taxtermto2		Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print classid=CLSID:37D13B2F-E5EB-11D2-973D-00104B15E56F>
	<param name="MasterDataID"		value="gcds_print">
	<param name="DetailDataID"		value="gcds_print">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"		value="true">
	<param name="LandScape"				value="false">
	<param name="printMargine"		value="false">
	<param name="NullRecordFlag"  value="true">
	<param name="Format"					value="
	">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 