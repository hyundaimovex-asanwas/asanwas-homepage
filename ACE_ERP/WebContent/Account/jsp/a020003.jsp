<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - ����
+ ���α׷� ID	:  A020003.html
+ �� �� �� ��	:  ��������
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2006.02.23
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ������ǥ��ȸ,������ǥ��,������ǥ��ȸ �߰� 
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� :  2006.04.06
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ����ó��, ������ȸ, ������ǥ��ȸ, ������ǥ��, ������Ȳ��ȸ ����
+ ��   ��  �� :  ������
+ �� �� �� �� :  2006.05.01
-----------------------------------------------------------------------------
+ �� �� �� �� :	 ���ó�� �ݿ�
+ ��   ��  �� :  ������
+ �� �� �� �� :  2006.06.28
-----------------------------------------------------------------------------
+ �� �� �� �� :	 1. ������ư�߰�(������ȸ)
+ ��   ��  �� :  ��  ��  ��
+ �� �� �� �� :  2007.06.13
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html> 
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>����ó��</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;

var custcd = "";
var vendcd = "";
var gdbldeamt=0;
var gdblcramt=0;
var gstrGubun="";  //T-���ո� ����

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
     ln_DispChk(0);

	gcem_actdat_fr.text = "19900101";
	gcem_actdat_to.text = gs_date;
  //gcem_actdat03_fr.text = gcurdate.substring(0,4) + "0101";
	gcem_actdat03_fr.text = "19900101";
	gcem_actdat03_to.text = gs_date;
  //gcem_actdat05_fr.text = gcurdate.substring(0,4) +"0101";
	gcem_actdat05_fr.text = "19900101";
	gcem_actdat05_to.text = gs_date;
	gcra_gubun.codevalue="N";
    ln_Before();

	//�ӽ�-----------------
	gclx_fdcode.bindcolval ="02";
    gclx_fdcode03.bindcolval ="02";
	 gclx_fdcode05.bindcolval ="02";
	
	//-------------------
}

/******************************************************************************
	Description : ��ȸ (��ǥ�ۼ�)
	            : ���� : �ʼ�              
                �ŷ�ó : ���þ��ϸ� ��ü �ŷ�ó�� ��� ��ȸ��.
								�����׸� : �ŷ�ó ���ý� ==>  �ش�ŷ�ó�� �ش� �����׸� ��ȸ
								           �ŷ�ó ���þ��� �� ==> ���ŷ�ó�� �����׸� ��ȸ
******************************************************************************/
function ln_Query(){
  gstrGubun="";
	var strCustcd="";
	var date_fr="";
	var date_to="";
	var fsrefcd2="";

  if(ln_Chk('01')){
	  if(txt_custcd_fr.value==""){
			strCustcd="All";  //��� �ŷ�ó ��ȸ
		}else{
			strCustcd =txt_custcd_fr.value;
		}

    //����üũ :::  �ŷ�ó�� �����ϰ�, �����׸� from, to�� �����ؾ߸� ����
		if(txt_custcd_fr.value!=""&&txt_custnm_fr.value!=""){
			if(gclx_fsrefcd.bindcolval!=""&&txt_fsrefcd_fr.value!=""&&txt_fsrefcd_to.value!=""){
				if(txt_fsrefcd_fr.value==txt_fsrefcd_to.value){
					gstrGubun="T";
				}
			}
		}

   //�������� ��� �������ڷ� ��ȸ ������.
	 if(txt_atcode_fr.value=="2101300"){
			date_fr=gcem_date_fr.text;
			date_to=gcem_date_to.text;
			if(gcem_date_fr.text!=""&&gcem_date_to.text!=""){
				fsrefcd2="1125";
			}else{
				fsrefcd2="";
			}
		}

    //gcgd_data01.DataID ="";
		gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s1?v_str1="+gclx_fdcode.bindcolval //����       
																										+"&v_str2="+gcem_actdat_fr.text			//ó���ⰣFR 
																										+"&v_str3="+gcem_actdat_to.text			//ó���ⰣTO 
																										+"&v_str4="+gcra_gubun.codevalue		//����       
																										+"&v_str5="+strCustcd			          //�ŷ�óFR   
																										+"&v_str6="+txt_atcode_fr.value     //��������FR 
																										+"&v_str7="+gclx_fsrefcd.bindcolval  //�����׸� 
																										+"&v_str8="+txt_fsrefcd_fr.value     //�����׸�FR  
																										+"&v_str9="+txt_fsrefcd_to.value     //�����׸�FR   
																										+"&v_str10="+date_fr                 //from ����          
																										+"&v_str11="+date_to                 //to ����            
																										+"&v_str12="+fsrefcd2;               //�����׸�2   
	  //prompt("gcds_data01",gcds_data01.DataID);
	  gcds_data01.Reset();

	}
}     

/******************************************************************************
	Description : �ܾװ� dtl �ݾ� üũ
******************************************************************************/               
function ln_Banjae_Amt_Chk(){
  var dblChaamt=0;
	var dblDaeamt=0;
	for(i=1;i<=gcds_data01.countrow;i++){
	  dblDaeamt=0;
		dblChaamt=0;
			for(k=1;k<=gcds_banjae.countrow;k++){
				if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(k,"FDCODE")&&
					 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(k,"TSDAT")&&
					 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(k,"TSNBR")&&
					 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(k,"TSSEQ")){
          
					 if(gcds_data01.namevalue(i,"DAEAMT")==0){       //�����߻�
							dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT");
					 }else if(gcds_data01.namevalue(i,"CHAAMT")==0){ //�뺯�߻�
							dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT"); 
					 }else{ //���� �뺯 �Ѵ� 0 �� �ƴ� ���
							if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){      //������ ū ��� �����߻�
								 dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT");
							}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){//�뺯�� ū ��� �뺯�߻�
								 dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT"); 
							}
					 }
				}//if
			}// k for
		
		if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"CHAAMT")-dblDaeamt;
		}else if(gcds_data01.namevalue(i,"CHAAMT")==0) {
			gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"DAEAMT")-dblChaamt;
		}else{
			if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){      //������ ū ���
				 gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")-dblDaeamt;
			}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){//�뺯�� ū ���
				 gcds_data01.namevalue(i,"JANAMT") = gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")-dblChaamt;
			}
		}
	}// i for 
}

/******************************************************************************
	Description : �ܾװ� gcds_banjae �ݾ� üũ Row���� Retrun;
	Parameter   : i - ���������� row
	              gubun - return �� ����
******************************************************************************/               
function ln_Dtl_Amt_Chk_Return(i,gubun){
	var dblChaamt=0;
	var dblDaeamt=0;

	///alert("ln_Dtl_Amt_Chk_Return");
	for(k=1;k<=gcds_banjae.countrow;k++){
		if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(k,"FDCODE")&&
			 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(k,"TSDAT")&&
			 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(k,"TSNBR")&&
			 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(k,"TSSEQ")){
        
			 if(gcds_data01.namevalue(i,"DAEAMT")==0){ 
					dblDaeamt += gcds_banjae.namevalue(k,"BJCRAMT"); 
			 }else if(gcds_data01.namevalue(i,"CHAAMT")==0){
					dblChaamt+= gcds_banjae.namevalue(k,"BJDEAMT");
			 }else{
					if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
             //dblDaeamt=dblDaeamt+gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")+gcds_banjae.namevalue(k,"BJDEAMT");
						 dblDaeamt=dblDaeamt+gcds_banjae.namevalue(k,"BJCRAMT");
					}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
             //dblChaamt=dblChaamt+gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")+gcds_banjae.namevalue(k,"BJCRAMT");
						 dblChaamt=dblChaamt+gcds_banjae.namevalue(k,"BJDEAMT");
					}
			 }
		}//if
	}// k for
			
	if(gcds_data01.namevalue(i,"DAEAMT")==0){
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-dblDaeamt;
	}else if(gcds_data01.namevalue(i,"CHAAMT")==0){
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-dblChaamt;
	}else{
		if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
      gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")-dblDaeamt;
		}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
			gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")-dblChaamt;
		}
	}

	if(gubun=="2"){
		return dblDaeamt+dblChaamt;
	}else{
		return gcds_data01.namevalue(i,"JANAMT");
	}
}

/******************************************************************************
	Description : �ܾ� ���� ����
	prameter    : p1 - 01 �����ݾ׸� ����
	                   02 �뺯�ݾ׸� ����
******************************************************************************/
function ln_Amt_Chk(p1,i){
  var tempbjdeamt=0;
	var tempbjcramt=0;
	if(gcds_banjae.countrow>0){
		for(j=1;j<=gcds_banjae.countrow;j++){
			if(gcds_data01.namevalue(i,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_data01.namevalue(i,"FSDAT")==gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_data01.namevalue(i,"FSNBR")==gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_data01.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(j,"TSSEQ")){
				 
				 if(p1=="02") {
					 tempbjdeamt += gcds_banjae.namevalue(j,"BJDEAMT");
				 }else if(p1=="01") {
					 tempbjcramt += gcds_banjae.namevalue(j,"BJCRAMT");
				 }
			}
		}//for j
	}//if
  if (p1=="02"){
		return  tempbjdeamt; 
	}else if(p1=="01"){
		return  tempbjcramt; 
	}
}



/******************************************************************************
	Description : ����������ȸ
******************************************************************************/               
function ln_Query2(p1,p2,p3,p4,p5,p6,p7,p8){

   if(p7==""&&p8==""){
			p7="0002";
	 }
	 gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s2?v_str1="+p1    //����    
																										+"&v_str2="+p2		//��������
																										+"&v_str3="+p3		//������ȣ
																										+"&v_str4="+p4		//�������ȣ    
																										+"&v_str5="+p5		//����    
																										+"&v_str6="+p6  	//�ŷ�ó  
																										+"&v_str7="+p7		//�����׸�    
																										+"&v_str8="+p8;		//�����׸�  
	/// prompt("",gcds_data02.DataID);																								
	 gcds_data02.Reset();

}	

/******************************************************************************
	Description : ������ǥ��ȸ
******************************************************************************/               
function ln_Query3(){

	 gcds_data03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s3?v_str1="+gcem_actdat03_fr.text    //ȸ������ FR   
																										+"&v_str2="+gcem_actdat03_to.text		 //ȸ������ TO		
																										+"&v_str3="+gclx_fsstat03.bindcolval		  //����
																										+"&v_str4="+gclx_fdcode03.bindcolval		//����    
																										+"&v_str5="+txt_remark03.value;		      //����  
																										
	 //prompt("",gcds_data03.DataID);																								
	 gcds_data03.Reset();															
																										
}	

/******************************************************************************
	Description : ������ǥ��
******************************************************************************/               
function ln_Query4(p1,p2,p3){

	 gcds_data04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4?v_str1="+p1    //����    
																										+"&v_str2="+p2		//������ǥ����
																										+"&v_str3="+p3;		//������ǥ��ȣ
	 //prompt("",gcds_data04.DataID);																								
	 gcds_data04.Reset();
   gcds_data04_2.ClearAll();
}	

/******************************************************************************
	Description : ������ǥ�� - ����ǥ ã��
******************************************************************************/               
function ln_Query4_2(p1,p2,p3,p4){

	 gcds_data04_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4_2?v_str1="+p1    //����    
																									     	+"&v_str2="+p2		//����ǥ��������
																										    +"&v_str3="+p3    //����ǥ������ȣ 
																												+"&v_str4="+p4;		//����ǥ�������ȣ
	 //prompt("",gcds_data04_2.DataID);																								
	 gcds_data04_2.Reset();

}	


/******************************************************************************
	Description : ������Ȳ��ȸ
******************************************************************************/               
function ln_Query5(){
  var strCustcd="";
	if(txt_custcd05_fr.value==""){
		strCustcd="All";  //��� �ŷ�ó ��ȸ
	}else{
		strCustcd =txt_custcd05_fr.value;
	}
   /*
	 gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s5?v_str1="+gclx_fdcode05.bindcolval //����         
																										+"&v_str2="+gcem_actdat05_fr.text		 //ȸ������FR   
																										+"&v_str3="+gcem_actdat05_to.text		 //ȸ������TO   
																										+"&v_str4="+gclx_fsstat05.bindcolval //��ǥ����     
																										+"&v_str5="+txt_atcode05_fr.value		 //��������     
																										+"&v_str6="+txt_fsrefcd05_fr.value	 //�����׸� FR  
																										+"&v_str7="+txt_fsrefcd05_to.value 	 //�����׸� TO 
																										+"&v_str8="+gclx_fsrefcd05.bindcolval; //�����׸��ڵ�
																									
	 //prompt("",gcds_data05.DataID);																								
	 gcds_data05.Reset();
   */
	// alert("gstrGubun"+gstrGubun);
	gcds_data05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s5?v_str1="+gclx_fdcode05.bindcolval //����       
																									+"&v_str2="+gcem_actdat05_fr.text			//ó���ⰣFR 
																									+"&v_str3="+gcem_actdat05_to.text			//ó���ⰣTO 
																									+"&v_str4="+gclx_gubun05.bindcolval		//����       
																									+"&v_str5="+strCustcd			             //�ŷ�óFR   
																									+"&v_str6="+txt_atcode05_fr.value     //��������FR 
																									+"&v_str7="+gclx_fsrefcd05.bindcolval  //�����׸� 
																									+"&v_str8="+txt_fsrefcd05_fr.value     //�����׸�FR  
																									+"&v_str9="+txt_fsrefcd05_to.value;    //�����׸�FR   
	////^^alert("gcds_data05",gcds_data05.DataID);
	gcds_data05.Reset();
	gcds_data05_2.ClearAll();
}	

/******************************************************************************
	Description : ������Ȳ��ȸ - ����ǥ ã��
******************************************************************************/               
function ln_Query5_2(p1,p2,p3,p4,p5,p6,p7,p8){
	/*
	 gcds_data05_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s4_2?v_str1="+p1    //����    
																									     	+"&v_str2="+p2		//����ǥ��������
																										    +"&v_str3="+p3    //����ǥ������ȣ 
																												+"&v_str4="+p4;		//����ǥ�������ȣ
	 //^^alert("gcds_data05_2",gcds_data05_2.DataID);																								
	 gcds_data05_2.Reset();
*/
	  if(p7==""&&p8==""){
			p7="0002";
	 }

	 gcds_data05_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s2?v_str1="+p1    //����    
																										+"&v_str2="+p2		//��������
																										+"&v_str3="+p3		//������ȣ
																										+"&v_str4="+p4		//�������ȣ    
																										+"&v_str5="+p5		//����    
																										+"&v_str6="+p6  	//�ŷ�ó  
																										+"&v_str7="+p7		//�����׸�    
																										+"&v_str8="+p8;		//�����׸�  
	 ////^^alert("gcds_data05_2",gcds_data05_2.DataID);																								
	 gcds_data05_2.Reset();
}	

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : üũ
	Parameter   : p1  - 01 : �ʼ��׸�üũ (��ȸ��)
	                    02 : �������� ������ üũ
											03 : �Ǻ� �� ���� ������
******************************************************************************/
function ln_Chk(p1){

  if(p1=="01"){
		if(gclx_fdcode.bindcolval==""){
			alert("������ �ʼ��׸��Դϴ�.")
			return false;
		}

		if(gcem_actdat_fr.text==""||gcem_actdat_to.text==""){
			alert("�Ⱓ�� �ʼ��׸��Դϴ�.")
			return false;
		}

    if(txt_atcodenm_fr.value==""||txt_atcode_fr.value==""){
			alert("���������� �ʼ��׸��Դϴ�.")
			return false;
		}

/*
    if(txt_custnm_fr.value==""||txt_custcd_fr.value==""||txt_custnm_to.value==""||txt_custcd_to.value==""){
			alert("�ŷ�ó�� �ʼ��׸��Դϴ�.")
			return false;
		}
*/

	}else if(p1=="02"){
	  //^^alert("aaa");
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
			  //^^alert("true");
				return true;
			}
		}
		alert("���õ� �׸��� �����ϴ�.");
    return false;

	}else if(p1=="03"){
		if(gcds_data01.sum(16,0,0)==0 || gcds_data01.sum(16,0,0)==""){ //BANJAEAMT
			alert("�����ݾ��� �������� �ʽ��ϴ�.");
			return false;
		}
  }
	return true;
}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before(){
  gcds_comfield.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield.Reset();//��������

	gcds_comfield02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield02.Reset();

	gcds_comfield03.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield03.Reset();

	gcds_comfield04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield04.Reset();

	gcds_comfield05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_comfield05.Reset();

	//���ΰ˻�
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_divcd_s1?";  
	////^^alert("gcds_divcd.DataID",gcds_divcd.DataID);
	gcds_divcd.Reset();

	//�����׸�[�˻�]
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
	gcds_fsrefcd.Reset();

	//�����׸�5[�˻�]
	gcds_fsrefcd05.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050";  
	gcds_fsrefcd05.Reset();

}
/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){
	
}


/******************************************************************************
	Description : ���� - ������ȣ�� �������� ��������Ÿ�� ������.
******************************************************************************/
function ln_Delete3(){
  var row = gcds_data03.rowposition;
	if(row<1){
		alert("�׸��� �����Ͻʽÿ�");
	}

	if(gcds_data03.namevalue(row,"FSSTAT")=="N"||gcds_data03.namevalue(row,"FSSTAT")=="B"){
		gcds_del03.clearall();
		ln_SetDataHeader("DTL_03"); 
		gcds_del03.addrow();
		gcds_del03.namevalue(gcds_del03.rowposition,"FDCODE")=gcds_data03.namevalue(row,"FDCODE");
		gcds_del03.namevalue(gcds_del03.rowposition,"BTSDAT")=gcds_data03.namevalue(row,"BTSDAT");
		gcds_del03.namevalue(gcds_del03.rowposition,"BTSNBR")=gcds_data03.namevalue(row,"BTSNBR");
		gcds_del03.namevalue(gcds_del03.rowposition,"TSDAT")="";
		gcds_del03.namevalue(gcds_del03.rowposition,"TSNBR")="";
		gcds_del03.namevalue(gcds_del03.rowposition,"TSSEQ")="";

		if(confirm("�����Ͻðڽ��ϱ�?")){	
			gctr_data03.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_t3?";
			//prompt("gcds_del03",gcds_del03.text);
			gctr_data03.post();
		}	
	}else{
		alert("��ǥ���°� �������� �ƴմϴ�.");
	}
}


/******************************************************************************
	Description : �����ͼ»���
******************************************************************************/
function ln_Row_Del(){
  var dbl_janamt_back = 0;
  
	//�����������̺� ����
	//alert("gcds_banjae.countrow"+gcds_banjae.countrow);
	//alert("ln_Row_Del  SEQ:::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ"));

	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")!="0"){ //����
	  //����ǥ�ܾ׺���
		for(k=1;k<=gcds_data01.countrow;k++){
			for(j=1;j<=gcds_banjae.countrow;j++){
				dbl_janamt_back=0;
				//alert("k::"+k+"::j::"+j);
				////^^alert("gcds_banjae",gcds_banjae.text);
				////^^alert("gcds_dtl",gcds_dtl.text);
				//alert("SEQ::"+gcds_banjae.namevalue(j,"SEQ")+"::gcds_dtl::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ"));
				if(gcds_banjae.namevalue(j,"SEQ")==gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")){
					if(gcds_banjae.namevalue(j,"BJCRAMT")==0){
						dbl_janamt_back += gcds_banjae.namevalue(j,"BJDEAMT");
					}else if(gcds_banjae.namevalue(j,"BJDEAMT")==0){
						dbl_janamt_back += gcds_banjae.namevalue(j,"BJCRAMT");
					}
					
				//	alert("FDCODE"+gcds_banjae.namevalue(j,"FDCODE")+"::gcds_data01::"+gcds_data01.namevalue(k,"FDCODE"));
				//	alert("TSDAT"+gcds_banjae.namevalue(j,"TSDAT")+"::FSDAT::"+gcds_data01.namevalue(k,"FSDAT"));
				//	alert("TSNBR"+gcds_banjae.namevalue(j,"TSNBR")+"::FSNBR::"+gcds_data01.namevalue(k,"FSNBR"));
				//	alert("TSSEQ"+gcds_banjae.namevalue(j,"TSSEQ")+"::FSSEQ::"+gcds_data01.namevalue(k,"FSSEQ"));
					if(gcds_banjae.namevalue(j,"FDCODE")==gcds_data01.namevalue(k,"FDCODE")&&
						 gcds_banjae.namevalue(j,"TSDAT")==gcds_data01.namevalue(k,"FSDAT")&&
						 gcds_banjae.namevalue(j,"TSNBR")==gcds_data01.namevalue(k,"FSNBR")&&
						 gcds_banjae.namevalue(j,"TSSEQ")==gcds_data01.namevalue(k,"FSSEQ")){

						//alert("k:"+k+":j:"+j+":dbl_janamt_back:"+dbl_janamt_back+":JANAMT:"+gcds_data01.namevalue(k,"JANAMT") );
						//��������ȣ�� ���� ��� �ܾ׿� ������
						gcds_data01.namevalue(k,"JANAMT") += dbl_janamt_back;
						gcds_data01.namevalue(k,"CHK")="F";
						//gcds_data01.namevalue(k,"BANJAEAMT")-= dbl_janamt_back;
					}
					//gcds_banjae.DeleteRow(j);
				}
			}//for j
		} //for k
    
	
		/*
		 //^^alert("gcds_dtl",gcds_dtl.text);
		 //^^alert("gcds_banjae",gcds_banjae.text);
		 //^^alert("gcds_banjaemst",gcds_banjaemst.text);
    */
     //����MST ����Ÿ�� ����
		 //dtl�� ������ǥ == banjae�� ������ǥ && 
		 //banjae�� ����ǥ == banjaemst�� ����ǥ�� ã�Ƽ� Delete 
		for(j=1;j<=gcds_banjae.countrow;j++){
			for(k=1;k<=gcds_banjaemst.countrow;k++){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				   gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")==gcds_banjae.namevalue(j,"BTSDAT")&&
          			 gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")==gcds_banjae.namevalue(j,"BTSNBR")&&
					 gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(j,"BTSSEQ")){    

						if(gcds_banjae.namevalue(j,"FDCODE")==gcds_banjaemst.namevalue(k,"FDCODE")&&
							 gcds_banjae.namevalue(j,"TSDAT")==gcds_banjaemst.namevalue(k,"TSDAT")&&
							 gcds_banjae.namevalue(j,"TSNBR")==gcds_banjaemst.namevalue(k,"TSNBR")&&
							 gcds_banjae.namevalue(j,"TSSEQ")==gcds_banjaemst.namevalue(k,"TSSEQ")){

							if(gcds_banjae.namevalue(j,"BJCRAMT")==0){       //���� �뺯�� 0�ΰ��
								if(gcds_banjae.namevalue(j,"BJDEAMT")==gcds_banjaemst.namevalue(k,"DEAMT")){  
								  //alert("delete_deamt");
									gcds_banjaemst.DeleteRow(k);
								}else{
								  //alert("delete_deamt--");
									gcds_banjaemst.namevalue(k,"DEAMT") -= gcds_banjae.namevalue(j,"BJCRAMT");
								}
							}else if(gcds_banjae.namevalue(j,"BJDEAMT")==0){ //���� ������ 0�ΰ��
								if(gcds_banjae.namevalue(j,"BJCRAMT")==gcds_banjaemst.namevalue(k,"CRAMT")){  
								  //alert("delete_cramt");
									gcds_banjaemst.DeleteRow(k);
								}else{
								 //  alert("delete_cramt--");
									gcds_banjaemst.namevalue(k,"CRAMT") -= gcds_banjae.namevalue(j,"BJDEAMT");
								}
							}
						}//if
				}//if
			}//for k
		}//for j

    ////��������Ÿ�� ����
		var dblcnt = gcds_banjae.countrow;
		for(j=dblcnt;j>=1;j--){
			if(gcds_banjae.namevalue(j,"SEQ")==gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")){
				 gcds_banjae.DeleteRow(j);
			}
		}
  }else{//�Ǻ�
	  if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==0){
			dbl_janamt_back = gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT");
	  }else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0){
			dbl_janamt_back = gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT");
		}

		//����ǥ �ܾ� ����
		for(k=1;k<=gcds_data01.countrow;k++){
		  /*  
        alert("FDCODE"+gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")+"::gcds_data01::"+gcds_data01.namevalue(k,"FDCODE"));
				alert("TSDAT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")+"::FSDAT::"+gcds_data01.namevalue(k,"FSDAT"));
				alert("TSNBR"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")+"::FSNBR::"+gcds_data01.namevalue(k,"FSNBR"));
				alert("TSSEQ"+gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")+"::FSSEQ::"+gcds_data01.namevalue(k,"FSSEQ"));
       */ 
				
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_data01.namevalue(k,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_data01.namevalue(k,"FSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_data01.namevalue(k,"FSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_data01.namevalue(k,"FSSEQ")){

				 //alert("K::"+ k+"::gcds_dtl.rowposition::"+gcds_dtl.rowposition);
				 //alert("dbl_janamt_back::"+dbl_janamt_back);
        
				 gcds_data01.namevalue(k,"JANAMT")+=dbl_janamt_back;
				 gcds_data01.namevalue(k,"CHK")="F";
			}
    }

    //��������Ÿ�� ����
		for(j=1;j<=gcds_banjae.countrow;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_banjae.namevalue(j,"TSSEQ")){
         gcds_banjae.DeleteRow(j);
			}
		}

    //����MST ����Ÿ�� ����
		for(j=1;j<=gcds_banjaemst.countrow;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")==gcds_banjaemst.namevalue(j,"FDCODE")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")==gcds_banjaemst.namevalue(j,"TSDAT")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")==gcds_banjaemst.namevalue(j,"TSNBR")&&
				 gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")==gcds_banjaemst.namevalue(j,"TSSEQ")){
				 
				 //alert("banjaemst j:"+j);
				 //alert("CHAAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT"));
				 //alert("DAEAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
				 if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==0){       //�뺯�� 0�ΰ��
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==gcds_banjaemst.namevalue(j,"DEAMT")){  
							gcds_banjaemst.DeleteRow(j);
						}else{
							gcds_banjaemst.namevalue(j,"DEAMT") -= gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT");
						}
				 }else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0){ //������ 0�ΰ��
            //alert("CHAAMT==0");
            //alert("DAEAMT"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
						//alert("CRAMT::"+gcds_banjaemst.namevalue(j,"CRAMT"));
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")==gcds_banjaemst.namevalue(j,"CRAMT")){
							gcds_banjaemst.DeleteRow(j);
						}else{
							gcds_banjaemst.namevalue(j,"CRAMT") -= gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT");
						}
			 	 }
			}
		}
	}

	//alert("dbl_janamt_back::" + dbl_janamt_back);
	gcds_dtl.DeleteRow(gcds_dtl.rowposition);
	////^^alert("gcds_banjae.text",gcds_banjae.text);	
}


/******************************************************************************
	Description : �� �߰� 
******************************************************************************/
function ln_Row_Add(){
  var tempcnt = 0;
	tempcnt = gcds_dtl.Countrow;
	gcds_dtl.Addrow();	
	ln_Data_Dtl_B('01',tempcnt);
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
	gcgd_data01.GridToExcel("����","",2);
}


function ln_Excel2(){
	gcgd_disp02.GridToExcel("����������ȸ","",2);
}


function ln_Excel3(){

}

function ln_Excel4(){
	gcgd_disp04.GridToExcel("������ǥ��","",2);
}

function ln_Excel5(){
	 gcgd_disp05.RunExcelEx('������Ȳ��ȸ',0, 0);
}

/******************************************************************************
	Description : ��������� ����Ÿ (���� mst ���̺� ������)
******************************************************************************/
/*
function ln_Data_Banjaemst(seq,i,strAtcode, strDeptcd, strVendcd,strFsrefcd, strFsrefval, dblAmt){

	alert("ln_Data_Banjaemst::i"+i+"strAtcode"+strAtcode+"strDeptcd"+strDeptcd+"strVendcd"+strVendcd+"strFsrefcd"+strFsrefcd+"strFsrefval"+strFsrefval+"dblAmt"+dblAmt);

	if(ln_Banjaemst_find()){ //UPDATE
		for(m=1;m<=gcds_banjaemst.countrow;m++){
			if(gcds_banjaemst.namevalue(m,"FDCODE")==gcds_banjae.namevalue(i,"FDCODE")&&
				 gcds_banjaemst.namevalue(m,"TSDAT")==gcds_banjae.namevalue(i,"TSDAT")&&
				 gcds_banjaemst.namevalue(m,"TSNBR")==gcds_banjae.namevalue(i,"TSNBR")&&
				 gcds_banjaemst.namevalue(m,"TSSEQ")==gcds_banjae.namevalue(i,"TSSEQ")){

				 gcds_banjaemst.namevalue(m,"DEAMT")+=gcds_banjae.namevalue(i,"BJDEAMT");
				 gcds_banjaemst.namevalue(m,"CRAMT")+=gcds_banjae.namevalue(i,"BJCRAMT");
			}
		}//for
	}else{ //INSERT
		ln_Data_Banjaemst_Add(seq,i,strAtcode,strDeptcd,strVendcd,strFsrefcd,strFsrefval,dblAmt);
	}
	
}
*/
/******************************************************************************
	Description : ����mst�� ����Ÿ Ȯ��(���� - update, ������ - addrow);
******************************************************************************/
/*
function ln_Banjaemst_find(i){
	for(m=1;m<=gcds_banjaemst.countrow;m++){
		if(gcds_banjaemst.namevalue(m,"FDCODE")==gcds_banjae.namevalue(i,"FDCODE")&&
			 gcds_banjaemst.namevalue(m,"TSDAT")==gcds_banjae.namevalue(i,"TSDAT")&&
			 gcds_banjaemst.namevalue(m,"TSNBR")==gcds_banjae.namevalue(i,"TSNBR")&&
			 gcds_banjaemst.namevalue(m,"TSSEQ")==gcds_banjae.namevalue(i,"TSSEQ")){
			 return true;
		}
	}
	return false;
}
*/
/******************************************************************************
	Description : ����mst�� data �߰�
	Parameter :   seq - ������ ��� �����ϰ� ������ �ǿ� ���� seq  ������ �ʿ���
	              i - 
								strAtcode - �����ڵ�,  strDeptcd - �μ�,  strVendcd - �ŷ�ó
								strFsrefcd - �����׸�  strFsrefval - �����׸�,  strremark - ����
                dblAmt - ���� ����ǥ�� ���ʱݾ�
******************************************************************************/
function ln_Data_Banjaemst_Add(seq,i,dblAmt,dbldeamt,dblcramt,strseq){
  if(gcds_banjaemst.countrow<=0){
		ln_SetDataHeader("04");
	}
	///alert("ln_Data_Banjaemst_Add::::i:"+i+"seq:"+seq+"dblAmt:"+dblAmt+"dbldeamt:"+dbldeamt+"dblcramt:"+dblcramt);
//	alert("ln_Data_Banjaemst_Add::::i:"+i+"seq:"+seq+"strseq"+strseq);
	gcds_banjaemst.addrow();
	//alert("position"+gcds_banjae.rowposition);
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SEQ") = strseq;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSDAT")  = gcds_data01.namevalue(i,"FSDAT");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSNBR")  = gcds_data01.namevalue(i,"FSNBR");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSSEQ")  = gcds_data01.namevalue(i,"FSSEQ");   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"ATCODE") = gcds_data01.namevalue(i,"ATCODE");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEPTCD") = gcds_data01.namevalue(i,"DEPTCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"VENDCD") = gcds_data01.namevalue(i,"VENDCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFCD")= gcds_data01.namevalue(i,"FSREFCD");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFVAL")	= gcds_data01.namevalue(i,"FSREFVAL");
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEAMT") = dbldeamt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"CRAMT") = dblcramt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"STATUS")= "";//����� �ݾ�üũ�ؼ� �����뺯 ������� 1-�Ϸ� �ٸ���� 0-����������
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSDAT") = gcds_data01.namevalue(i,"SSDAT");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSNBR") = gcds_data01.namevalue(i,"SSNBR");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSNUM") = gcds_data01.namevalue(i,"FSNUM");  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK")= gcds_data01.namevalue(i,"REMARK"); 
	//alert("gcds_banjaemstREMARK::"+gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK"));
 // alert("gcds_data01REMARK::"+gcds_data01.namevalue(i,"REMARK"));
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRDT") = gs_date;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRID") = gs_userid;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPDT") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPID") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"AMT")=dblAmt;
	
}
/******************************************************************************
	Description : ��������� ����Ÿ (���� �������̺� ������)
  Parameter   : seq ='' �Ǻ�	
	              seq!='' ����
******************************************************************************/
function ln_Data_Banjaerel(seq){
 // alert("ln_Data_Banjaerel :::: seq::"+seq);
	//alert("ln_Data_Banjaerel::�Ǻ�")
	
	var strFtstat ="Y";
	var dblSum=0;
	var dblTotal=0;
	var dblTemp=0;
	var dblAmt=0;        //���� mst�� insert�� ����ǥ�� �ݾ�
	var dbldeamt=0;
	var dblcramt=0;
	gs_banjaeyn="0";

  if(!ln_Chk('03')){
		return 
	}
 
	//^^alert("ln_Data_Banjaerel.countrow::"+gcds_banjae.countrow);
	if(gcds_banjae.countrow<=0){
		ln_SetDataHeader("03");
	}
  
  for (i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"&& gcds_data01.namevalue(i,"BANJAEAMT")!=0){ //üũ�� �׸�&&�����ݾ��� 0�� �ƴѰ��
			
			strseq = gcds_dtl.countrow + 1;  
			strseq = ln_Seqno_Format(strseq,5); 
			//alert("22gcds_dtl.countrow"+gcds_dtl.countrow);

			if(seq!=0 && seq!=""){ //����
			  //alert("����");
			}else{                 //�Ǻ�
				//alert("�Ǻ�");
				ln_Data_Dtl('01',i,strseq);
			}

			//alert(seq+"seq::"+"strseq::::"+strseq);
		  gcds_banjae.addrow();
			//alert("position"+gcds_banjae.rowposition);
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SEQ") = seq;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FTSTAT") = strFtstat;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSDAT")  = gcds_data01.namevalue(i,"FSDAT");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSNBR")  = gcds_data01.namevalue(i,"FSNBR");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSSEQ")  = gcds_data01.namevalue(i,"FSSEQ");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSDAT") = "A"+gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSNBR") = "";     //����� ����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSSEQ") = strseq; //����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BANJAEYN") = gs_banjaeyn; //Y - ����(����ǥ) 0-������ǥ(������), 1-������ǥ(�����Ϸ�), N-������ǥ�ƴ�.
			
			//�ű��߰� 
			//alert("i::"+i+":FSNUM:"+gcds_data01.namevalue(i,"FSNUM"));
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSDAT") = gcds_data01.namevalue(i,"SSDAT");
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSNBR") = gcds_data01.namevalue(i,"SSNBR"); 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FSNUM") = gcds_data01.namevalue(i,"FSNUM");  

			if(gcds_data01.namevalue(i,"CHAAMT")==0){ 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
				dblAmt = gcds_data01.namevalue(i,"DAEAMT");
				dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
				dblcramt=0;
			}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
				dblAmt = gcds_data01.namevalue(i,"CHAAMT");
				dbldeamt=0;
				dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
			}else{
				if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
					//dblAmt = gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT");
					dblAmt = gcds_data01.namevalue(i,"CHAAMT");
					dbldeamt=0;
					dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
				}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
					//dblAmt = gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT");
					dblAmt = gcds_data01.namevalue(i,"DAEAMT");
					dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
					dblcramt=0;
				}
			}

			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSDAT") = ""; //����� ����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNBR") = ""; //����� ���� 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNUM") = ""; //����� ����

			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRID") = gs_userid;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPID") = gs_userid;

      if(seq!=0 && seq!=""){ //����
			}else{  //�Ǻ�
				gcds_data01.namevalue(i,"BANJAEAMT")=0;
			}
			//ln_Data_Banjaemst_Add(seq,i,strAtcode,strDeptcd,strVendcd,strFsrefcd,strFsrefval,dblAmt);
			//alert("DETPCD" +gcds_data01.namevalue(i,"DEPTCD"));
			ln_Data_Banjaemst_Add(seq,i,dblAmt,dbldeamt, dblcramt,strseq);
    }
	}//for
}

/******************************************************************************
	Description : ��������ǥ ��ȸ == > �Ǻ� �Ǵ� �������� ����
	Parameter   : 01 - ���� �Ǻ�
	              02 - ���� ����
******************************************************************************/
function ln_Data_Banjae(p){
	var row=gcds_data01.countrow;
	var strseq="";	

	if(ln_Chk('02')){ 
		if(p=="01"){                 //�Ǻ� 
			if(gcds_mst.countrow<=0){
				ln_Data_Mst();           //MST DATA����
			}
      		ln_Data_Banjaerel('');     //��������&&����MST(��������)
		}else if(p=="02"){           //����
		  //alert("gstrGubun::"+gstrGubun);	
		   if(gstrGubun=="T"||gs_userid=="3170009"){
				if (gcds_mst.countrow<=0){
					ln_Data_Mst();          //MST DATA���� 
				}
			  	strseq = gcds_dtl.countrow + 1;  
				ln_Data_Banjaerel(strseq);  
				strseq = ln_Seqno_Format(strseq,5); 
				ln_Data_Dtl('02','',strseq);     //ȭ����� DTL DATA ����
			}else{
				alert("�ش���� �������� ������ �� �����ϴ�.");
				
			}
		}//if
	}
}

/******************************************************************************
	Description : ��ǥ�ۼ� ��ȸ�� Mst Data ����(��ǥmst)
  parameter   : 
******************************************************************************/
function ln_Data_Mst(){
  //alert("gcds_mst:"+gcds_mst.countrow);
	if(gcds_mst.countrow<=0){
		ln_SetDataHeader("01");
	}
  gcds_mst.Addrow();
  gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE");
	gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")="A"+gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"FSKND")=""; //��ü��ǥ ������ǥ (6 �ڵ���ǥ --slipno_popup���� ����)
	gcds_mst.namevalue(gcds_mst.rowposition,"FSWRTDAT")=gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"COCODE")=gs_cocode;
	gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD")=gs_deptcd;
	gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")=gs_userid;
	gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")=""; //�μ��ڵ�� ����ã��
	gcds_mst.namevalue(gcds_mst.rowposition,"FSAMT")=0;  //DTL�� �ݾ� SUM
	gcds_mst.namevalue(gcds_mst.rowposition,"FSVAT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"DETOT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"CRTOT")=0;
	gcds_mst.namevalue(gcds_mst.rowposition,"REMARK")=gcds_data01.namevalue(gcds_data01.rowposition,"REMARK");
	gcds_mst.namevalue(gcds_mst.rowposition,"SGNDAT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"FSSTAT")="N";
	gcds_mst.namevalue(gcds_mst.rowposition,"SSDAT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"SSNBR")="";
  gcds_mst.namevalue(gcds_mst.rowposition,"WRDT")=gs_userid;
	gcds_mst.namevalue(gcds_mst.rowposition,"WRID")=gs_date;
	gcds_mst.namevalue(gcds_mst.rowposition,"UPDT")="";
	gcds_mst.namevalue(gcds_mst.rowposition,"UPID")="";
}

/******************************************************************************
	Description : ��ǥ�ۼ� - ȭ��� ���̴� �κ�
  parameter   : p1 - ���� (01-�Ǻ�, 02-����)
	              i - row�� ��ġ
******************************************************************************/
function ln_Data_Dtl(p1,i,strseq){
  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}
	//alert("ln_Data_Dtl :: p1"+p1+"i"+i+"strseq"+strseq);
	gcds_dtl.Addrow();
	//����
	if(p1=="01"){  //�Ǻ�
	  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")='';  //
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_data01.namevalue(i,"FDCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //����� ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //����� ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcds_data01.namevalue(i,"ATCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcds_data01.namevalue(i,"ATKORNAM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //ȭ�鿡�� �Է� (������)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //ȭ�鿡�� �Է� (������)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_data01.namevalue(i,"REMARK");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_data01.namevalue(i,"VENDCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_data01.namevalue(i,"VENDNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_data01.namevalue(i,"DEPTCD");
    gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_data01.namevalue(i,"DEPTNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=gcds_data01.namevalue(i,"DIVCD"); //����ã��
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //ȭ�鿡�� �ڵ�����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //������ ����� HIDDEN
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=gcds_data01.namevalue(i,"FSDAT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=gcds_data01.namevalue(i,"FSNBR");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=gcds_data01.namevalue(i,"FSSEQ");
		
    ///alert("BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
		///alert("CHAAMT"+gcds_data01.namevalue(i,"CHAAMT"));
    ///alert("DAEAMT"+gcds_data01.namevalue(i,"DAEAMT"));
		
		if(gcds_data01.namevalue(i,"CHAAMT")==0){
			///alert("1111111BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
		}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;     //������ �뺯�� �ݾ��� �ٲ�
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
			///alert("2222222222BANJAEAMT::"+gcds_data01.namevalue(i,"BANJAEAMT"));
		}else{
		  if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //������ �뺯�� �ݾ��� �ٲ�
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
			}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
			}
		}
   
	  ///alert("rowposition::"+gcds_dtl.rowposition);
		///alert("DAEAMT::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT"));
    ///alert("CHAAMT::"+gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT"));


		//�����׸��ڵ� �߰�(�����������)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=gcds_data01.namevalue(i,"FSREFCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=gcds_data01.namevalue(i,"FSREFVAL");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=gcds_data01.namevalue(i,"FSREFNM");

		//�����׸��ڵ�� ����Ǵ� �ڵ� (��...�����׸��ڵ� : ī���ȣ �ϰ�� ����ī��||��ȯī�� ���� �ڵ尪�� ������.)
		//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=gcds_data01.namevalue(i,"FSREFCD2");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=gcds_data01.namevalue(i,"FSREFVAL2");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=gcds_data01.namevalue(i,"FSREFNM2");

    //�������� ��� ������
		if(gcds_data01.namevalue(i,"ATCODE")=="2101300"){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
			
		}else if(gcds_data01.namevalue(i,"ATCODE")=="2100520"){ //����ī��
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(i,"REFVALNM2");
      
		}else if(gcds_data01.namevalue(i,"ATCODE")=="2100120"){ //�ܻ���Ա�(���޾���)
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(i,"REFCD2");
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(i,"REFVAL2");
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(i,"REFVALNM2");
      		      
		}else{
      		gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")="";
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")="";
			gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")="";
		}


	}else if(p1=="02"){ //���� - �����ݾ� �հ踦 Sum
		var cnt=0; //üũ�Ǽ� Ȯ��
		for(j=1;j<=gcds_data01.countrow;j++){
			if(gcds_data01.namevalue(j,"CHK")=="T") {  
			  cnt+=1;
				//alert("cnt"+cnt);
				//alert("BANJAEAMT::"+gcds_data01.namevalue(j,"BANJAEAMT"));
				if(gcds_data01.namevalue(j,"CHAAMT")==0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"CHAAMT");
				}else if(gcds_data01.namevalue(j,"DAEAMT")==0){
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")+=gcds_data01.namevalue(j,"DAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");
				}else{
					if(gcds_data01.namevalue(j,"CHAAMT")-gcds_data01.namevalue(j,"DAEAMT")>0){
							gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //������ �뺯�� �ݾ��� �ٲ�
							gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")+=gcds_data01.namevalue(j,"BANJAEAMT");
					}else if(gcds_data01.namevalue(j,"CHAAMT")-gcds_data01.namevalue(j,"DAEAMT")<0){
							gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(j,"BANJAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
							gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
					}
				}
				
				//if
				gcds_data01.namevalue(j,"BANJAEAMT")=0;

        //������ �� ù ��°���� �������� �ѱ�.
				if(cnt==1){
				  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=gcds_dtl.countrow; 
				  gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL ����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_data01.namevalue(j,"FDCODE");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";  //����� ����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq; 
					gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcds_data01.namevalue(j,"ATCODE");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcds_data01.namevalue(j,"ATKORNAM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //ȭ�鿡�� �Է� (������)
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //ȭ�鿡�� �Է� (������)
					//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
					//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
					gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_data01.namevalue(j,"REMARK");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_data01.namevalue(j,"VENDCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_data01.namevalue(j,"VENDNM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_data01.namevalue(j,"DEPTCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_data01.namevalue(j,"DEPTNM");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=gcds_data01.namevalue(j,"DIVCD"); //����ã��
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //ȭ�鿡�� �ڵ�����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
					gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

					//�����׸��ڵ� �߰�(�����������)
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=gcds_data01.namevalue(j,"FSREFCD");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=gcds_data01.namevalue(j,"FSREFVAL");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=gcds_data01.namevalue(j,"FSREFNM");
						
					//�����׸��ڵ�� ����Ǵ� �ڵ� (��...�����׸��ڵ� : ī���ȣ �ϰ�� ����ī��||��ȯī�� ���� �ڵ尪�� ������.)
					//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=gcds_data01.namevalue(j,"FSREFCD2");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=gcds_data01.namevalue(j,"FSREFVAL2");
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=gcds_data01.namevalue(j,"FSREFNM2");

					//������//����ī�� �ϰ�� ������
					if(gcds_data01.namevalue(j,"ATCODE")=="2101300"){
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(j,"REFCD2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(j,"REFVAL2");
					}else if(gcds_data01.namevalue(j,"ATCODE")=="2100520"){ //����ī��
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")=gcds_data01.namevalue(j,"REFCD2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")=gcds_data01.namevalue(j,"REFVAL2");
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVALNM2")=gcds_data01.namevalue(j,"REFVALNM2");
					}else{
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFCD2")="";
						gcds_dtl.namevalue(gcds_dtl.rowposition,"REFVAL2")="";
					}
				}	
			}//if
		}//for
	}
}

/******************************************************************************
	Description : ��ǥ�ۼ� - �������κ�
  parameter   : p1 - ���� (01-�Ǻ�
	              i - Addrow ���� ��ġ
******************************************************************************/

function ln_Data_Dtl_B(p1,i){
  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}
 
  var strseq = gcds_dtl.countrow;  
			strseq = ln_Seqno_Format(strseq,5); 
  //����
	if(p1=="01"){
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="B";  //DTL ������
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gcds_dtl.namevalue(i,"FDCODE");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";  //����� ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;  
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";  //ȭ�鿡�� �Է� (������)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //ȭ�鿡�� �̺� (������)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcds_dtl.namevalue(i,"REMARK");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=gcds_dtl.namevalue(i,"VENDCD");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=gcds_dtl.namevalue(i,"VENDNM");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=gcds_dtl.namevalue(i,"DEPTCD");
    gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=gcds_dtl.namevalue(i,"DEPTNM");

		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=ln_Find_Divcd(gcds_dtl.namevalue(i,"DEPTCD"));//����ã��
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=""; //ȭ�鿡�� �ڵ�����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //�ݾ��� �Է°����ϰ� ��.
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  //������ �뺯�� �ݾ��� �ٲ�
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;

		/*
		if(gcds_data01.namevalue(i,"CHAAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"BANJAEAMT");  //������ �뺯�� �ݾ��� �ٲ�
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"CHAAMT");
		}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"DAEAMT");    //������ �뺯�� �ݾ��� �ٲ�
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"BANJAEAMT");
		}
		*/
	}
}

/************************************************************************************************************
	Description : ����//��迡�� ��� ����Ÿ�� ������ �� �� �ߺ��ؼ� ������ ���� ��츦 üũ��.
	parameter   :
*************************************************************************************************************/
function ln_Chk_Temp_Data(){


}

/************************************************************************************************************
	Description : �����ڵ� ã��
	parameter   :
*************************************************************************************************************/
function ln_Find_Divcd(strdeptcd){
    
		for(i=1;i<=gcds_divcd.countrow;i++){
			if(strdeptcd==gcds_divcd.namevalue(i,"DEPTCD")){
					return gcds_divcd.namevalue(i,"DIVCD");		
			}
		}
}
/******************************************************************************
	Description : ������ȸ- ��ܺκ�
  parameter   :
******************************************************************************/
function ln_Data2(row){
 
	gclx_fdcode02.bindcolval=gcds_data01.namevalue(row,"FDCODE"); 
  gcem_fsdatnbr02.text=gcds_data01.namevalue(row,"SSNBR1");
	gcem_actdat02.text=gcds_data01.namevalue(row,"ACTDAT");
	gclx_fsstat02.bindcolval=gcds_data01.namevalue(row,"FSSTAT");
	txt_atcode02.value=gcds_data01.namevalue(row,"ATCODE");
	gcem_atcodenm02.text=gcds_data01.namevalue(row,"ATKORNAM");
	gcem_chaamt02.text=gcds_data01.namevalue(row,"CHAAMT");
	gcem_daeamt02.text=gcds_data01.namevalue(row,"DAEAMT");
	gcem_janamt02.text=gcds_data01.OrgNameValue(row,"JANAMT");
	txt_remark02.value=gcds_data01.namevalue(row,"REMARK");
  txt_custcd02.value=gcds_data01.namevalue(row,"VENDCD");
  txt_custnm02.value=gcds_data01.namevalue(row,"VENDNM");
	//gcem_chaamt03.text=0;
	//gcem_daeamt03.text=0;
}

/******************************************************************************
	Description : ������ǥ��-��ܺκ�
  parameter   :
******************************************************************************/
function ln_Data4(row){

	gclx_fdcode04.bindcolval=gcds_data03.namevalue(row,"FDCODE"); 
	gcem_bsdatnbr04.text=gcds_data03.namevalue(row,"SSDATNBR"); 
	gcem_btsdatnbr04.text=gcds_data03.namevalue(row,"FSDATNBR"); 
	gclx_fsstat04.bindcolval=gcds_data03.namevalue(row,"FSSTAT");
	txt_remark04.value=gcds_data03.namevalue(row,"REMARK");
	gcem_chaamt04.text=gcds_data03.namevalue(row,"DETOT");
	gcem_daeamt04.text=gcds_data03.namevalue(row,"CRTOT");
 
}

/******************************************************************************
	Description : ������ Data�� ���� DataSetHead ����
  parameter   : p - 01 : ��ǥ mst ����Ÿ��
	                - 02 : ȭ�� display�� ����Ÿ��
									- 03 : ���� ������ dtl ����Ÿ�� (dtl & ref)
									- 04 : ����mst
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=="01"){
		var s_fslipmst = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
									 + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
									 + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
									 + "SGNDAT:STRING,FSSTAT:STRING,SSDAT:STRING,SSNBR:STRING,"
									 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_mst.SetDataHeader(s_fslipmst);
	}else if(p=="02"){
		var s_temp ="CHK:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,"
	             + "ATCODE:STRING,ATKORNAM:STRING,BJATCODE:STRING,BJATKORNAM:STRING,CHAAMT:DECIMAL,"
						   + "DAEAMT:DECIMAL,BANJAEYN:STRING,REMARK:STRING,VENDCD:STRING,VENDNM:STRING,"
						   + "DEPTCD:STRING,DEPTNM:STRING,DIVCD:STRING,FSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,NUMBER:DECIMAL,GUBUN:STRING,SEQ:DECIMAL,"
						   + "TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,FSREFCD:STRING,FSREFVAL:STRING,FSREFNM:STRING,"
						   + "FSREFCD2:STRING,FSREFVAL2:STRING,FSREFNM2:STRING,REFCD2:STRING,REFVAL2:STRING,REFVALNM2:STRING,ATDECR:STRING"; 
		gcds_dtl.SetDataHeader(s_temp);
	}else if(p=="03"){
		var s_temp = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
		           + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,SSDAT:STRING,"
	             + "SSNBR:STRING,FSNUM:STRING,BJDEAMT:DECIMAL,BJCRAMT:DECIMAL,BSDAT:STRING,"
						   + "BSNBR:STRING,BSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:DECIMAL"; 
		gcds_banjae.SetDataHeader(s_temp);
	}else if(p=="04"){
		var s_temp = "FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,ATCODE:STRING,"
		           + "DEPTCD:STRING,VENDCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,DEAMT:DECIMAL,"
	             + "CRAMT:DECIMAL,STATUS:STRING,SSDAT:STRING,SSNBR:STRING,FSNUM:STRING,"
						   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:STRING,AMT:DECIMAL,REMARK:STRING"; 
		gcds_banjaemst.SetDataHeader(s_temp);
  }else if(p=="03"){
		var s_temp = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
		         + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,SSDAT:STRING,"
	           + "SSNBR:STRING,FSNUM:STRING,BJDEAMT:DECIMAL,BJCRAMT:DECIMAL,BSDAT:STRING,"
						 + "BSNBR:STRING,BSNUM:STRING,"
						 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SEQ:DECIMAL"; 
		gcds_check_temp.SetDataHeader(s_temp);

	}else if(p=="DTL_03"){
		if (gcds_del03.countrow<1){ 
			var s_temp = "FDCODE:STRING,BTSDAT:STRING,BTSNBR:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ";               
			gcds_del03.SetDataHeader(s_temp);
		}
  }
}

/***********************************************************************************************
	Description : �����ڵ� �� �ŷ�ó ã��
	parameter   : p1 - ����  p2-����2, p3 -row obj
**********************************************************************************************/
function ln_Popup(p1,p2,p3,obj){ 
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){//��������
		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		arrParam[1]=eval(obj).value;
		arrParam[2]="ATDEBTYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			//alert("GG::"+arrParam[4]);	
			 if(p2=="fr"){
				txt_atcode_fr.value = arrParam[0];
				txt_atcodenm_fr.value = arrParam[1];

				if(txt_atcode_fr.value=="2101300"){
					txt_label.value="�Ա�����";
					gcem_date_fr.enable = true;
          gcem_date_to.enable = true;
          gcem_date_fr.text = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";
					gcem_date_to.text = gs_date;
				}else{
          txt_label.value="";
					gcem_date_fr.text="";
          gcem_date_to.text=""; 
					gcem_date_fr.enable = false;
          gcem_date_to.enable = false;
				}

				//���������� ������ ��� �ŷ�ó�� ���� �����׸� �Է�,
				if(arrParam[4]!=""){
					txt_custcd_fr.value=""; 
					txt_custnm_fr.value="";	
					gclx_fsrefcd.bindcolval = arrParam[4];
					gclx_fsrefcd.Enable=false;
				}else{
					gclx_fsrefcd.bindcolval = arrParam[4];
					gclx_fsrefcd.Enable=false;
				}
      }else if(p2=="05fr"){
				txt_atcode05_fr.value = arrParam[0];
				txt_atcodenm05_fr.value = arrParam[1];

				//���������� ������ ��� �ŷ�ó�� ���� �����׸� �Է�,
				if(arrParam[4]!=""){
					txt_custcd05_fr.value=""; 
					txt_custnm05_fr.value="";	
					gclx_fsrefcd05.bindcolval = arrParam[4];
					gclx_fsrefcd05.Enable=false;
				}else{
					gclx_fsrefcd05.bindcolval = arrParam[4];
					gclx_fsrefcd05.Enable=false;
				}
			}

		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
			  txt_custcd_fr.value=""; 
				txt_custnm_fr.value="";	
				txt_fsrefcd_fr.value = "";
				txt_fsrefnm_fr.value = "";
				txt_fsrefcd_to.value = "";
				txt_fsrefnm_to.value = "";
        gclx_fsrefcd.bindcolval = "";
				gclx_fsrefcd.Enable=false;
			}else if(p2=="05fr") {
			  txt_atcode05_fr.value="";
				txt_atcodenm05_fr.value="";
			  txt_custcd05_fr.value=""; 
				txt_custnm05_fr.value="";	
				txt_fsrefcd05_fr.value = "";
				txt_fsrefnm05_fr.value = "";
				txt_fsrefcd05_to.value = "";
				txt_fsrefnm05_to.value = "";
        gclx_fsrefcd05.bindcolval = "";
				gclx_fsrefcd05.Enable=false;
			}
		}
		
	}else if(p1=="02"){//�ŷ�ó
    arrParam[0]="";
		arrParam[1]=eval(obj).value;
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		//ln_Popup('02','fr','','txt_custnm_fr')

		if (arrResult != null) {
				arrParam = arrResult.split(";");
      
			 if(p2=="fr") {    
			    txt_custcd_fr.value = arrParam[0];
					txt_custnm_fr.value = arrParam[1];
			 }else if(p2=="05fr"){
					txt_custcd05_fr.value = arrParam[0];
					txt_custnm05_fr.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
			  txt_custcd_fr.value="";
				txt_custnm_fr.value ="";
			}else if(p2=="05fr"){
			  txt_custcd05_fr.value="";
				txt_custnm05_fr.value ="";
			}
		}
		custcd="";

	}else if(p1=="03"){//�����׸�
 
		//strURL = "./Commdtil_popup_ifrm.html";
		strURL = "./commdtil_popup_banjae.jsp";
		if(p2=="fr"||p2=="to"){
			arrParam[0]=gclx_fsrefcd.bindcolval;
		}else if(p2=="05fr"||p2=="05to"){
			arrParam[0]=gclx_fsrefcd05.bindcolval;
		}else{
      arrParam[0]="";
		}

		arrParam[1]=eval(obj).value;
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
			    txt_fsrefcd_fr.value = arrParam[0];
					txt_fsrefnm_fr.value = arrParam[1];
					txt_fsrefcd_to.value = arrParam[0];
					txt_fsrefnm_to.value = arrParam[1];
			 }else if(p2=="to"){
			    txt_fsrefcd_to.value = arrParam[0];
				 	txt_fsrefnm_to.value = arrParam[1];
			 }else if(p2=="05fr") {
			    txt_fsrefcd05_fr.value = arrParam[0];
					txt_fsrefnm05_fr.value = arrParam[1];
					txt_fsrefcd05_to.value = arrParam[0];
					txt_fsrefnm05_to.value = arrParam[1];
			 }else if(p2=="05to"){
			    txt_fsrefcd05_to.value = arrParam[0];
				 	txt_fsrefnm05_to.value = arrParam[1];
		   }
		} else {
			if(p2=="fr") {
			  txt_fsrefcd_fr.value="";
				txt_fsrefnm_fr.value ="";
				txt_fsrefcd_to.value="";
				txt_fsrefnm_to.value ="";
			}else if(p2=="to"){
			  txt_fsrefcd_to.value="";
				txt_fsrefnm_to.value = "";
			}else if(p2=="05fr") {
			  txt_fsrefcd05_fr.value="";
				txt_fsrefnm05_fr.value ="";
				txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value ="";
			}else if(p2=="05to"){
			  txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value = "";
			}
		}
		vendcd="";
/*
	}else if(p1=="05"){

		strURL = "./Actcode_popup.html";
		arrParam[0]="ATUSEYN";
		arrParam[1]="";
		arrParam[2]="ATDEBTYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr"){
			    txt_atcode05_fr.value = arrParam[0];
					txt_atcodenm05_fr.value = arrParam[1];
		   }
		} else {
			if(p2=="fr") {
			  txt_atcode05_fr.value="";
				txt_atcodenm05_fr.value="";
			}
		}

	}else if(p1=="06"){

		strURL = "./Commdtil_popup_ifrm.html";
		arrParam[0]=gclx_fsrefcd05.bindcolval;
		arrParam[1]="";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
			    txt_fsrefcd05_fr.value = arrParam[0];
					txt_fsrefnm05_fr.value = arrParam[1];

					if(txt_fsrefcd05_to.value==""&&txt_fsrefnm05_to.value==""){
						txt_fsrefcd05_to.value = arrParam[0];
						txt_fsrefnm05_to.value = arrParam[1];
					}

			 }else if(p2=="to"){
			    txt_fsrefcd05_to.value = arrParam[0];
					txt_fsrefnm05_to.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
			  txt_fsrefcd05_fr.value="";
				txt_fsrefnm05_fr.value ="";
				txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value ="";
			}else if(p2=="to"){
			  txt_fsrefcd05_to.value="";
				txt_fsrefnm05_to.value = "";
			}
		}
	*/
	}else if(p1=="gcgd_dtl"){   //���� ������
		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
				gcds_dtl.namevalue(p3,"ATCODE") = arrParam[0];
				gcds_dtl.namevalue(p3,"ATKORNAM") = arrParam[1];
				gcds_dtl.namevalue(p3,"ATDECR") = arrParam[2];
		}else{
			  gcds_dtl.namevalue(p3,"ATCODE")="";
				gcds_dtl.namevalue(p3,"ATKORNAM")="";
				gcds_dtl.namevalue(p3,"ATDECR") = "";
		}
	}
}


/***********************************************************************************************
	Description :  ��ǥ ã��
	parameter   : strfdcode - �����ڵ�, strfsdat - ��������, strfsnbr - ������ȣ
**********************************************************************************************/
function ln_Popup2(strfdcode,strfsdat,strfsnbr){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = strfdcode;//�����ڵ�
	arrParam[1] = strfsdat;//��������
	arrParam[2] = strfsnbr;//������ȣ

	strURL = "./slipno_popup.jsp";
	strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
}


/***********************************************************************************************
	Description : �����ڵ� �� �ŷ�ó Ŭ����
	parameter   : 
**********************************************************************************************/
function ln_Clear(p1){

	if (p1=="01"){
		txt_custcd_fr.value = "";
		txt_custnm_fr.value = "";
		//txt_custcd_to.value = "";
		//txt_custnm_to.value = "";
		custcd = "";
	}	else if(p1 == "02"){
		txt_fsrefcd_fr.value = "";
		txt_fsrefnm_fr.value = "";
		txt_fsrefcd_to.value = "";
		txt_fsrefnm_to.value = "";
		vendcd = "";
	}	else if(p1 == "06"){
		txt_fsrefcd05_fr.value = "";
		txt_fsrefnm05_fr.value = "";
		txt_fsrefcd05_to.value = "";
		txt_fsrefnm05_to.value = "";
	}
}

/******************************************************************************
	Description : ���� ��ǥ ���� �˾�
	parameter   : p - 01 ��ǥ����
	                  02 ��ǥ��ȸ
******************************************************************************/
function ln_Popup_Slip(p,row){

  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if (p=="01"){
		var dblchaamt = 0; 
		var dbldaeamt = 0;

		if(ln_Chk2()){        //�ݾ�üũ
	 
			//��ǥMST ����Ÿ �ѱ��
			arrParam[0] = "B";   //���� - ����ȭ�鿡�� �Ѿ.
			arrParam[1] = gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE"); 
			arrParam[2] = gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT"); 
			arrParam[3] = gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR");  
			arrParam[4] = gcds_mst.namevalue(gcds_mst.rowposition,"FSKND");  
			arrParam[5] = gcds_mst.namevalue(gcds_mst.rowposition,"COCODE"); 
			arrParam[6] = gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD"); 
			arrParam[7] = gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO");  
			arrParam[8] = gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD");  
			arrParam[13] = gs_usernm;  
			arrParam[17] = gs_deptnm;  

		  //prompt('gcds_banjaemst:;',gcds_banjaemst.text);
	
			/*
			for(int j=1;j<=gcds_dtl.countrow;j++){
				dblchaamt+=gcds_dtl.namevalue(j,"CHAAMT");
				dbldaeamt+=gcds_dtl.namevalue(j,"DAEAMT");
			}*/

			strURL = "./slipno_popup.jsp";
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,window,strPos);

			gcte_disp.ActiveIndex=1;
			ln_Query();
			//dtl, ��������, �������� Clear
			gcds_dtl.ClearData();
			gcds_banjae.ClearData();
			gcds_banjaemst.ClearData();

    }
	}else if(p=="02"){
		arrParam[0] = gcds_banjae.namevalue(row,"FDCODE");
		arrParam[1] = gcds_banjae.namevalue(row,"BTSDAT");
		arrParam[2] = gcds_banjae.namevalue(row,"BTSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
	}
}

/******************************************************************************
	Description : �Ǳ���
	prameter    : 
******************************************************************************/
function ln_DispChk(index){
	
  var div_cm = new Array("div_disp1","div_disp2","div_disp3","div_disp4","div_disp5");
	for(var i=0;i<=4;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}

}

/******************************************************************************
	Description : ��ǥ����� �ݾ�üũ
	prameter    : 
******************************************************************************/
function ln_Chk2(){

    if(gcds_dtl.countrow<=0){
			alert("��ǥ���� ����Ÿ�� �����ϴ�. Ȯ�� �Ͻʽÿ�.");
			return false;
		}
    
		/****
		//2008.06.19 ������ ���� 
    if(gcds_dtl.sum(10,0,gcds_dtl.countrow)==0||gcds_dtl.sum(11,0,gcds_dtl.countrow)==0){
			alert("������ �뺯�� �ݾ��� Ȯ�� �Ͻʽÿ�.");
			return false;
		}
		****/

	  if(gcds_dtl.sum(10,0,gcds_dtl.countrow)!=gcds_dtl.sum(11,0,gcds_dtl.countrow)){
			alert("������ �뺯�� �ݾ��� �ٸ��ϴ�.");
			return false;
		}
    
		return true;
}

/******************************************************************************
	Description : lost focus �� 
	prameter    : p1 - 01 ��ǥ�ۼ�
	                   02 ������ȸ
								p2 - atcode:����
								obj
******************************************************************************/
function ln_Blur(p1,p2,obj){
	if(p1=="01"){
		if(p2=="atcode"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 if (obj=="txt_atcodenm_fr"||obj=="txt_atcodecd_fr"){
					ln_Popup('01','fr','',obj);
			 }else{
					ln_Popup('01','05fr','',obj);
			 }
		}else if(p2=="cust"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 if (obj=="txt_custnm05_fr"||obj=="txt_custcd05_fr"){
					ln_Popup('02','05fr','',obj);			
			 }else{
					ln_Popup('02','fr','',obj);			
		   }
		}else if(p2=="fsref_fr"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 ln_Popup('03','fr','',obj);
		}else if(p2=="fsref_to"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 ln_Popup('03','to','',obj);
	  }else if(p2=="fsref05_fr"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 ln_Popup('03','05fr','',obj);
		}else if(p2=="fsref05_to"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
			 ln_Popup('03','05to','',obj);
		}
	}
}

function ln_Numeric(){
  txt_banjaesum.value=fn_trim(txt_banjaesum.value);
	txt_banjaesum.value=gf_setnum(txt_banjaesum.value);
}


/******************************************************************************
	Description : ���ó��
	prameter    :
******************************************************************************/
function ln_Setoff(){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(!ln_Setoff_Chk()) return;

	strURL = "./comm_setoff_popup.jsp";
	strPos = "dialogWidth:730px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,window,strPos);	

	if(arrResult != null){
	  arrParam = arrResult.split(";");	

    if(arrParam[0]=="02"){ //����
      gstrGubun="T";
		}else{
			gstrGubun="";
		}

		ln_Data_Banjae(arrParam[0]);       //����
		
		ln_Data_Setoff_Add(arrParam,arrParam[0]);   //���(������)

		////prompt("gcds_data01:",gcds_data01.text);
		////prompt("gcds_dtl:",gcds_dtl.text);
		///prompt("gcds_banjae:",gcds_banjae.text);    //banjaerel
		///prompt("gcds_banjaemst:",gcds_banjaemst.text);
	}
  gstrGubun="";
}

/******************************************************************************
	Description : ��赥��Ÿ �߰�
	prameter    : strArray  ==> ��� ����Ÿ �迭
	��       �� :  
******************************************************************************/
function ln_Data_Setoff_Add(strArray,p1){
  var cnt=0;
	var seq=0;
	var strseq=0;

  ///alert("ln_Data_Setoff_Add::strArray::"+strArray+"::p1::"+p1);

	if(gcds_mst.countrow<=0){
		ln_Data_Mst();                //MST DATA����
	}

  seq = gcds_dtl.countrow + 1;  
	cnt = (strArray.length-1)/32

  ///alert("ln_Data_Banjaerel_Setoff");
	ln_Data_Banjaerel_Setoff(seq,strArray,cnt);       //��赥��Ÿ�� �������ῡ ����
	///alert("step3");
	strseq = gcds_dtl.countrow + 1; 
	strseq = ln_Seqno_Format(strseq,5); 

	//alert("step::::");
  ln_Data_Dtl_Setoff(p1,strArray,strseq,seq);	      //��赥��Ÿ�� Dtl�� ����.
	
  
  //prompt("gcds_data01",gcds_data01.text);
	//prompt("gcds_banjaerel",gcds_banjae.text);
	//prompt("gcds_banjaemst",gcds_banjaemst.text);
	//prompt("gcds_dtl",gcds_dtl.text);
}

/******************************************************************************
	Description : ���ó�� üũ
	prameter    :
	��       �� : Ư�������� �ŷ�ó üũ��. 
******************************************************************************/
function ln_Setoff_Chk(){
	var strTemp="";
	var cnt =0;

  if(fn_trim(txt_atcode_fr.value)==""){
		alert("���������� �ʼ��׸��Դϴ�.");
		return false;
	}

  if(txt_atcode_fr.value!="1110310"&&txt_atcode_fr.value!="1110610"&&txt_atcode_fr.value!="2100110"&&txt_atcode_fr.value!="2100510"){
		alert("��� ������ ������ �ƴմϴ�.");
    return false;
	}

	//�ܻ����� || �̼��� || �ܻ���Ա� || �����ޱ�  
	if(txt_atcode_fr.value=="1110310"||txt_atcode_fr.value=="1110610"||txt_atcode_fr.value=="2100110"||txt_atcode_fr.value=="2100510"){
		if(fn_trim(txt_custcd_fr.value)==""){
			alert("�ŷ�ó�� �ʼ��׸��Դϴ�.");
			return false;
		}
	}
	
	/*
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			break;
		}else{
		  alert("����Ÿ�� ���� �Ͻʽÿ�.");
			return false;
		}
	}
  */
  
	for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			strTemp="T"; //üũ�Ȱ��� �����Ұ��
			break;
		}
	}

	if(strTemp!="T") {
		alert("����Ÿ�� ���� �Ͻʽÿ�.");
		return false;
	}

  
	//������ ���� 2�� �̻��� ��� ������.
  for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			cnt+=1;
		}
	}

	if(cnt>1){
		alert("���� 1�Ǹ� �����մϴ�. Ȯ�� �Ͻʽÿ�.");
		cnt=0;
		return false;
	}


	//�����ݾ��� 0 �� ��찡 ������ ��� üũ��
  for(var i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"&&gcds_data01.namevalue(i,"BANJAEAMT")==0){
			alert("��� �ݾ��� 0 �Դϴ�.");
			return false;
		}
	}

	return true;
}

/******************************************************************************
	Description : ��赥��Ÿ�� ��������� ����Ÿ (���� �������̺� ������)
  Parameter   : seq ='' �Ǻ�	
	              seq!='' ����
								strArray ����Ÿ
								cnt = ���ڵ� ����
								
******************************************************************************/
function ln_Data_Banjaerel_Setoff(seq,strArray,cnt){

	//alert("ln_Data_Banjaerel_Setoff::seq::"+seq+"::strArray::"+strArray+"::cnt::"+cnt)
	//prompt('strArray',strArray);

	var strFtstat ="Y";
	var dblTemp=0;
	var dblAmt=0;        //���� mst�� insert�� ����ǥ�� �ݾ�
	var dbldeamt=0;
	var dblcramt=0;
	var s=0; //�迭 ����
	var dbldeamt_Sum=0;  //���������ݾ�
  var dblcramt_Sum=0;  //�뺯�����ݾ�

	gs_banjaeyn="0";

	if(gcds_banjae.countrow<=0){
		ln_SetDataHeader("03");
	}
  
  for(i=0;i<cnt;i++){
			strseq = gcds_dtl.countrow + 1;  
			strseq = ln_Seqno_Format(strseq,5); 
	
		  gcds_banjae.addrow();
			//alert("position"+gcds_banjae.rowposition);
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SEQ") = seq;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FTSTAT") = strFtstat;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FDCODE") = strArray[3+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSDAT")  = strArray[4+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSNBR")  = strArray[5+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"TSSEQ")  = strArray[6+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSDAT") = "A"+gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSNBR") = "";     //����� ����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BTSSEQ") = strseq; //����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BANJAEYN") = gs_banjaeyn; //Y - ����(����ǥ) 0-������ǥ(������), 1-������ǥ(�����Ϸ�), N-������ǥ�ƴ�.
			
			//�ű��߰� 
			//alert("i::"+s+":FSNUM:"+gcds_data01.namevalue(s,"FSNUM"));
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSDAT") = strArray[9+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"SSNBR") = strArray[10+s];
			gcds_banjae.namevalue(gcds_banjae.rowposition,"FSNUM") = strArray[11+s];

			if(strArray[13+s]==0){ //����=0
			  if(Number(strArray[31+s])>=Number(strArray[15+s])){ //strArray[15] �ܾ�
					dblTemp = strArray[15+s];
				}else if(Number(strArray[31+s])<Number(strArray[15+s])){
          dblTemp = strArray[31+s];
				}
        
				dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
        if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
					dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
				}

				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = dblTemp;
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;

				dblAmt = strArray[14+s];
				dbldeamt=dblTemp;
				dblcramt=0;
			}else if(strArray[14+s]==0){ //�뺯=0
			  if(Number(strArray[31+s])>=Number(strArray[15+s])){
					dblTemp = strArray[15+s];
				}else if(Number(strArray[31+s])<Number(strArray[15+s])){
          dblTemp = strArray[31+s];
				}

				dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
        if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
					dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
				}
				///alert("�뺯dblTemp"+dblTemp);
        dblcramt_Sum += dblTemp;
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0; 
				gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = dblTemp;
				
				dblAmt = strArray[13+s];
				dbldeamt=0;
				dblcramt = dblTemp;
			}else{
				if(Number(strArray[13+s])-Number(strArray[14+s])>0){  //����
					if(Number(strArray[31+s])>=Number(strArray[15+s])){ //strArray[15] �ܾ�
						dblTemp = strArray[15+s];
					}else if(Number(strArray[31+s])<Number(strArray[15+s])){
						dblTemp = strArray[31+s];
					}

					dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
					if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
						dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
					}

					///alert("22����dblTemp"+dblTemp);
					Number(dbldeamt_Sum) += Number(dblTemp);
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = 0;
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = dblTemp;
          
					dblAmt = strArray[13+s];
					dbldeamt=0;
					dblcramt = dblTemp;

				}else if(Number(strArray[13+s])-Number(strArray[14+s])<0){ //�뺯
					if(Number(strArray[31+s])>=Number(strArray[15+s])){
						dblTemp = strArray[15+s];
					}else if(Number(strArray[31+s])<Number(strArray[15+s])){
						dblTemp = strArray[31+s];
					}

				  dbldeamt_Sum = Number(dbldeamt_Sum)+Number(dblTemp);
					if(Number(dbldeamt_Sum)-Number(strArray[31+s])>0){
						dblTemp = Number(strArray[31+s])-Number(dbldeamt_Sum)+Number(dblTemp);
					}
					////alert("22�뺯dblTemp"+dblTemp);
					
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJDEAMT") = dblTemp; 
					gcds_banjae.namevalue(gcds_banjae.rowposition,"BJCRAMT") = 0;
					
					dblAmt = strArray[14+s];
					dbldeamt=dblTemp;
					dblcramt=0;
					
				}
			}

			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSDAT") = ""; //����� ����
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNBR") = ""; //����� ���� 
			gcds_banjae.namevalue(gcds_banjae.rowposition,"BSNUM") = ""; //����� ����

			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"WRID") = gs_userid;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPDT") = gs_date;
			gcds_banjae.namevalue(gcds_banjae.rowposition,"UPID") = gs_userid;

			ln_Data_Banjaemst_Add_Setoff(seq,i,dblAmt,dbldeamt, dblcramt,strArray,strseq);

			s+=32; //�迭 ����
	}//for i
}

/******************************************************************************
	Description : ����mst�� data �߰�
	Parameter :   seq - ������ ��� �����ϰ� ������ �ǿ� ���� seq  ������ �ʿ���
	              i - 
								strAtcode -  �����ڵ�,  strDeptcd - �μ�,          strVendcd - �ŷ�ó
								strFsrefcd - �����׸�   strFsrefval - �����׸�,  strremark - ����
                dblAmt - ���� ����ǥ�� ���ʱݾ�
								strseq - BTSSEQ �߰���
******************************************************************************/
function ln_Data_Banjaemst_Add_Setoff(seq,i,dblAmt,dbldeamt,dblcramt,strArray,strseq){
	//alert("ln_Data_Banjaemst_Add_Setoff::"+i);
  if(gcds_banjaemst.countrow<=0){
		ln_SetDataHeader("04");
	}
	
	//alert("dblAmt:"+dblAmt+"dbldeamt:"+dbldeamt+"dblcramt:"+dblcramt);
	gcds_banjaemst.addrow();

	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SEQ") = strseq;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FDCODE") = strArray[3];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSDAT")  = strArray[4];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSNBR")  = strArray[5];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"TSSEQ")  = strArray[6];   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"ATCODE") = strArray[7];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEPTCD") = strArray[16];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"VENDCD") = strArray[18];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFCD")= strArray[20];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSREFVAL")	= strArray[21];
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"DEAMT") = dbldeamt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"CRAMT") = dblcramt;   
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"STATUS")= "";//����� �ݾ�üũ�ؼ� �����뺯 ������� 1-�Ϸ� �ٸ���� 0-����������
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSDAT") = strArray[9];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"SSNBR") = strArray[10];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"FSNUM") = strArray[11];  
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK")= strArray[12]; 
	//alert("gcds_banjaemstREMARK::"+gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"REMARK"));
 // alert("gcds_data01REMARK::"+gcds_data01.namevalue(i,"REMARK"));
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRDT") = gs_date;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"WRID") = gs_userid;
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPDT") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"UPID") = "";
	gcds_banjaemst.namevalue(gcds_banjaemst.rowposition,"AMT")=dblAmt;
}


/******************************************************************************
	Description : ���ó���κ�
  parameter   : p1 - ���� (01-�Ǻ�, 02-����)
	              strArray - �迭��
								strseq 
******************************************************************************/
function ln_Data_Dtl_Setoff(p1,strArray,strseq,seq){
  //alert("ln_Data_Dtl_Setoff::::"+p1);

	///prompt("Array",strArray);

  if(gcds_dtl.countrow<=0){
		ln_SetDataHeader("02");
	}

	gcds_dtl.Addrow();
	//����
	if(p1=="01"){  //�Ǻ�
	  //^^alert("gcds_dtl.rowposition::"+gcds_dtl.rowposition);
	  gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=seq;  //
    gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=strArray[3];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //����� ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //����� ����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=strArray[7];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=strArray[8];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //ȭ�鿡�� �Է� (������)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //ȭ�鿡�� �Է� (������)
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
		//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
		gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=strArray[12];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=strArray[18];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=strArray[19];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=strArray[16];
        gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=strArray[17];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=strArray[24]; //����ã��
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")="";           //ȭ�鿡�� �ڵ�����
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
		gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

    //������ ����� HIDDEN
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=strArray[4];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=strArray[5];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=strArray[6];

		///alert("strArray[13]"+strArray[13]);
		///alert("strArray[14]"+strArray[14]);
		///alert("strArray[31]"+strArray[31]);
		
		if(strArray[13]==0){ //����
			gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=strArray[31];   //������ �뺯 ��ġ����
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
		}else if(strArray[14]==0){ //�뺯
		  gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=strArray[31];
		}else{
			if(Number(strArray[13])-Number(strArray[14])>0){
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;  
			  gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=strArray[31];
			}else if(Number(strArray[13])-Number(strArray[14])<0){
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=strArray[31];   //������ �뺯 ��ġ����
			  gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
			}
		}

		//�����׸��ڵ� �߰�(�����������)
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=strArray[20];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=strArray[21];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=strArray[22];

		//�����׸��ڵ�� ����Ǵ� �ڵ� (��...�����׸��ڵ� : ī���ȣ �ϰ�� ����ī��||��ȯī�� ���� �ڵ尪�� ������.)
		//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=strArray[28];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=strArray[29];
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=strArray[30];

	}else if(p1=="02"){ //���� - �����ݾ� �հ踦 Sum
		var cnt =(strArray.length-1)/32;
		var m=0;
		var tempAmt=0;
		var tempAmtSum=0;

		for(j=1;j<=cnt;j++){
		  
			//������ �� ù ��°���� �������� �ѱ�.
      if(j==1){ 
				if(Number(strArray[13])==0){       //����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=Number(strArray[31]);   //������ �뺯 ��ġ����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
				}else if(Number(strArray[14])==0){ //�뺯
					gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;   //������ �뺯 ��ġ����
					gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=Number(strArray[31]);
				}else{ //���� �뺯 �Ѵ� 0�� �ƴѰ��
					if(Number(strArray[13])>Number(strArray[14])){
						gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=0;          //������ �뺯 ��ġ����
						gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=Number(strArray[31]);
					}else{
						gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=Number(strArray[31]);   //������ �뺯 ��ġ����
						gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=0;
					}
				}

				//^^alert("gcds_dtl.rowposition::"+gcds_dtl.rowposition);
				gcds_dtl.namevalue(gcds_dtl.rowposition,"SEQ")=seq;  //
				gcds_dtl.namevalue(gcds_dtl.rowposition,"GUBUN")="D";  //DTL ����
				gcds_dtl.namevalue(gcds_dtl.rowposition,"CHK")="T";
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=strArray[3];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")="A"+gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")="";       //����� ����
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=strseq;   //����� ����
				gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=strArray[7];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=strArray[8];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATCODE")="";   //ȭ�鿡�� �Է� (������)
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BJATKORNAM")=""; //ȭ�鿡�� �Է� (������)
				//gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcds_data01.namevalue(i,"CHAAMT");
				//gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcds_data01.namevalue(i,"DAEAMT");
				gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")="0";
				gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=strArray[12];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDCD")=strArray[18];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"VENDNM")=strArray[19];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTCD")=strArray[16];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DEPTNM")=strArray[17];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=strArray[24]; //����ã��
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")="";           //ȭ�鿡�� �ڵ�����
				gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date;
				gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;

				//������ ����� HIDDEN
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSDAT")=strArray[4];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSNBR")=strArray[5];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"TSSEQ")=strArray[6];
				

				//�����׸��ڵ� �߰�(�����������)
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD")=strArray[20];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL")=strArray[21];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM")=strArray[22];

				//�����׸��ڵ�� ����Ǵ� �ڵ� (��...�����׸��ڵ� : ī���ȣ �ϰ�� ����ī��||��ȯī�� ���� �ڵ尪�� ������.)
				//alert("FSREFCD2"+gcds_data01.namevalue(i,"FSREFCD2"));
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD2")=strArray[28];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL2")=strArray[29];
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM2")=strArray[30];
			}
		}//for
	}
}

/******************************************************************************
	Description : ������üũ - �������� ���Ͱ��� �Է½� ���� üũ
	parameter   : 2008.06.19 ������ �߰� 
******************************************************************************/
function ln_Chk_Atcode_Amt(row){

	 var temp = gcds_dtl.namevalue(row,"ATCODE");
	 var str1char = temp.substring(0,1);

	 if(str1char=="4"){ //��� ���Ͱ���
			if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //����
				if(gcds_dtl.namevalue(row,"DAEAMT")!=0&&gcds_dtl.namevalue(row,"DAEAMT")!=""){
					alert("�ش������ �뺯�� �Է��� �� �����ϴ�.");
					gcds_dtl.namevalue(row,"DAEAMT")=0;
					//gcds_dtl.namevalue(row,"CHAAMT").focus();
					return;
				}
			}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){//�뺯
				if(gcds_dtl.namevalue(row,"CHAAMT")!=0&&gcds_dtl.namevalue(row,"CHAAMT")!=""){
					alert("�ش������ ������ �Է��� �� �����ϴ�.");
					gcds_dtl.namevalue(row,"CHAAMT")=0;
					//gcds_dtl.namevalue(row,"DAEAMT").focus();
					return;
				}
			}
	 }

	if((gcds_dtl.namevalue(row,"CHAAMT")!=0)&&(gcds_dtl.namevalue(row,"DAEAMT")!=0)){
			alert("�����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
			gcds_dtl.namevalue(row,"DAEAMT")=0;
			return;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ�ۼ� -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥmst -->
<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ȭ��� dtl-->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������-->
<comment id="__NSID__"><object  id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ����mst-->
<comment id="__NSID__"><object  id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ȸ -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ǥ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ǥ�� -->
<comment id="__NSID__"><object  id=gcds_data04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ǥ��- ����ǥ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data04_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_data05_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ����ã�� -->
<comment id="__NSID__"><object  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����������̺�Ǽ� -->
<comment id="__NSID__"><object  id=gcds_data15 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> <!--��������-->

<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--��������-->

<comment id="__NSID__"><object  id=gcds_comfield03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--��������-->

<comment id="__NSID__"><object  id=gcds_comfield04 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--��������-->

<comment id="__NSID__"><object  id=gcds_comfield05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--��������-->

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--�����׸�-->

<comment id="__NSID__"><object  id=gcds_fsrefcd05 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--�����׸�-->

<comment id="__NSID__"><object  id=gcds_fsrefval classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--��ǥ�ۼ� ���-->

<comment id="__NSID__"><object  id=gcds_check_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> <!--����, ���ó���� ó���ݾ��� �ӽ÷� �����ؼ� üũ��.-->

<!-- ������ǥ��ȸ ==>������ư -->
<comment id="__NSID__"><object  id=gcds_del03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<!--param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t5(I:USER=gcds_banjae)"-->   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������Ÿ ���� -->
<comment id="__NSID__"><object  id=gctr_data03 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020003_t3(I:USER=gcds_del03)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!--==========================================================================
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
==========================================================================-->

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data01.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}else{
	 //2007.06.28 �߰��� ����
		if(gcds_data01.namevalue(row,"ATCODE")=="2100520"){ 
			gcgd_data01.ColumnProp("REFVALNM2", "Show") = "true";
			gcgd_data01.ColumnProp("REFVAL2", "Show") = "false";
			gcgd_data01.ColumnProp("REFVALNM2","Name")="����ī��ŷ�ó";
		}else{
			gcgd_data01.ColumnProp("REFVALNM2", "Show") = "false";
			gcgd_data01.ColumnProp("REFVAL2", "Show") = "true";
			gcgd_data01.ColumnProp("REFVALNM2","Name")="�����׸�2";
		}		  
		
		//�����������̺� ����Ÿ�� ������ ���
		if(gcds_dtl.countrow>0){
			//�ܾ� ����
      ln_Banjae_Amt_Chk();
		}//if
	}

  //gcgd_data01.DataID = "gcds_data01";
  gcgd_data01.ViewSummary ="1";
</script>

<!-- 2008.06.19 ������ ���� -->
<script language=JavaScript for=gcds_dtl event=onColumnChanged(row,colid)>
	if (colid == "CHAAMT"||colid == "DAEAMT" ) {
		ln_Chk_Atcode_Amt(row);
  }

</script>



<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ft_cnt02.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">

  ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data02.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>


<script language="javascript" for="gcds_data03" event="OnLoadStarted()">
  document.all.LowerFrame.style.visibility="visible";
	ft_cnt03.innerText="����Ÿ ��ȸ���Դϴ�.";
	
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
  ft_cnt03.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data03.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_data04" event="OnLoadStarted()">
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data04" event="onloadCompleted(row,colid)">
 	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data04.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_data05" event="OnLoadStarted()">
  
	document.all.LowerFrame.style.visibility="visible";

</script>

<script language="javascript" for="gcds_data05" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";

	if(gcds_data05.countrow<=0){
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
	}
</script>

<!-- �����׸� -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
</script>

<!-- �����׸� -->
<script language="javascript" for="gcds_fsrefcd05" event="onloadCompleted(row,colid)">
	gcds_fsrefcd05.InsertRow(1);
	gcds_fsrefcd05.NameValue(1,"CDCODE")="";
	gcds_fsrefcd05.NameValue(1,"CDNAM")="";
	gclx_fsrefcd05.index=0;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode.BindColVal = gfdcode;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_comfield02" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode02.BindColVal = gfdcode;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_comfield03" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode03.BindColVal = gfdcode;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_comfield04" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode04.BindColVal = gfdcode;
</script>

<!-- �������� -->
<script language="javascript" for="gcds_comfield05" event="onloadCompleted(row,colid)">
	//gcds_comfield.InsertRow(1);
	//gcds_comfield.NameValue(1,"FDCODE")="";
	//gcds_comfield.NameValue(1,"FDNAME")="��ü";
	//gclx_sfdcode.index=0;
	if(gfdcode == null) {
		gfdcode="01";
	}
	gclx_fdcode05.BindColVal = gfdcode;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- �����ڵ� -->
<script language="javascript" for="gcte_disp" event="OnSelChanged(index)">
	ln_DispChk((index-1));
</script>

<script language="javascript" for="gcgd_data01" event="OnClick(row,colid)">
  //GUBUN - N:����������    Y:����Ϸ�
  var dbltemp=0;
	if(row<1) {
	  if(row==0 && colid=="CHK"){ //��ü����              
		  if(gcds_data01.namevalue(1,"CHK")=="T"){
				if(gcds_dtl.countrow<=0){
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "F";
							gcds_data01.namevalue(i,"JANAMT") = gcds_data01.OrgNameValue(i,"JANAMT");
							gcds_data01.namevalue(i,"BANJAEAMT")=0;
						}
					}//for
				}else{
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "F";
							dbltemp=ln_Dtl_Amt_Chk_Return(i,'');
							gcds_data01.namevalue(i,"JANAMT")=dbltemp;
							gcds_data01.namevalue(i,"BANJAEAMT")=0;
						}
					}//for
				}
			}else{
				if(gcds_dtl.countrow<=0){
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK")="T";
							gcds_data01.namevalue(i,"BANJAEAMT")=gcds_data01.namevalue(i,"JANAMT");
							gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"JANAMT")-gcds_data01.namevalue(i,"BANJAEAMT");
						}
					}//for
				}else{
					for(i=1;i<=gcds_data01.Countrow;i++){
						if(gcds_data01.namevalue(i,"GUBUN")=="N"){
							gcds_data01.namevalue(i,"CHK") = "T";
							dbltemp=ln_Dtl_Amt_Chk_Return(i,'');
							//alert("dbltemp::"+dbltemp);
							gcds_data01.namevalue(i,"BANJAEAMT")=Number(dbltemp);
							gcds_data01.namevalue(i,"JANAMT")=dbltemp-gcds_data01.namevalue(i,"BANJAEAMT");
						}
					}//for
				}
			}
		}

		gcgd_data01.editable="false";
		return;
	}else{   //��������
		if(colid=="CHK") {
			if(gcds_data01.namevalue(row,"CHK") == "T"){
				if(gcds_dtl.countrow<=0){
					gcds_data01.namevalue(row,"CHK") = "F";
					gcds_data01.namevalue(row,"JANAMT") = gcds_data01.OrgNameValue(row,"JANAMT");
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}else{
					gcds_data01.namevalue(row,"CHK") = "F";
					dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
					gcds_data01.namevalue(row,"JANAMT") =dbltemp;
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}
			}else{
				if(gcds_data01.namevalue(row,"GUBUN")=="N"){
					if(gcds_dtl.countrow<=0){
						gcds_data01.namevalue(row,"CHK") = "T";
						gcds_data01.namevalue(row,"BANJAEAMT")=gcds_data01.namevalue(row,"JANAMT");
						gcds_data01.namevalue(row,"JANAMT")=gcds_data01.namevalue(row,"JANAMT")-gcds_data01.namevalue(row,"BANJAEAMT");
					}else{
						gcds_data01.namevalue(row,"CHK") = "T";
						dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
						gcds_data01.namevalue(row,"BANJAEAMT")=dbltemp;
						gcds_data01.namevalue(row,"JANAMT")=dbltemp-gcds_data01.namevalue(row,"BANJAEAMT");
					}
				}
			}
		}
	}

	if(colid=="BANJAEAMT"&&gcds_data01.namevalue(row,"CHK")=="T") {
		gcgd_data01.editable="true";
	}	else {
		gcgd_data01.editable="false";
	}

  txt_banjaesum.value=""; 
	txt_banjaesum.value = gf_setnum(gcds_data01.Sum(16,0,0));

</script>

<script language=JavaScript for=gcgd_data01 event=OnDblClick(row,colid)>
	 if(colid!="BANJAEAMT"&&colid!="CHK"){
		 ln_Data2(row)
		 ln_Query2(gcds_data01.namevalue(row,"FDCODE"),gcds_data01.namevalue(row,"FSDAT"),  
							 gcds_data01.namevalue(row,"FSNBR"),gcds_data01.namevalue(row,"FSSEQ"),
					     gcds_data01.namevalue(row,"ATCODE"),gcds_data01.namevalue(row,"VENDCD"),
							 gcds_data01.namevalue(row,"FSREFCD"),gcds_data01.namevalue(row,"FSREFVAL"));
		 ln_DispChk(1);
		 gcte_disp.ActiveIndex=2;
	 }
</script>

<script language="javascript" for="gcgd_dtl" event="OnClick(row,colid)">
	if(gcds_dtl.namevalue(row,"GUBUN")=="B"&&(colid=="CHAAMT"||colid=="DAEAMT")){ //��������
		 gcgd_dtl.ColumnProp('CHAAMT','Edit')="RealNumeric";
		 gcgd_dtl.ColumnProp('DAEAMT','Edit')="RealNumeric";
	}else{
		 gcgd_dtl.ColumnProp('CHAAMT','Edit')="None";
		 gcgd_dtl.ColumnProp('DAEAMT','Edit')="None";
	}

	//2008.04.03. ������ �߰�.....���� ���� ��� �߰�
	if(row==0){
		 if(colid =="REMARK"){
				if(txt_atcode_fr.value=="2101300"||txt_atcode_fr.value=="1110310"){ //������, �ܻ�����
					 for(i=2;i<=gcds_dtl.countrow;i++){
							gcds_dtl.namevalue(i,"REMARK") = gcds_dtl.namevalue(1,"REMARK"); 										
					 }
				}
		 }
	 }
</script>

<script language="javascript"  for=gcgd_data01 event=OnExit(row,colid,olddata)>
	
	var dblAmt=0;
	var dblAmt2=0;
	var tempamt=0;
  
	if(colid=="BANJAEAMT"){
		if(gcds_data01.namevalue(row,"CHAAMT")!=0&&gcds_data01.namevalue(row,"DAEAMT")==0){
			tempamt = ln_Amt_Chk("01",row);
			dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT");
		}else if(gcds_data01.namevalue(row,"CHAAMT")==0&&gcds_data01.namevalue(row,"DAEAMT")!=0){
			tempamt = ln_Amt_Chk("02",row);
			dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
		}else{
		  if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")>0){
				dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT");
      }else if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")<0){
        dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
			}
		}

		if(dblAmt <gcds_data01.namevalue(row,"BANJAEAMT")+tempamt) {
			alert("�����ݾ��� �ܾ׺��� Ŭ �� �����ϴ�.");
			gcds_data01.namevalue(row,"BANJAEAMT")=olddata;
		}else{
			gcds_data01.namevalue(row,"JANAMT")=dblAmt-gcds_data01.namevalue(row,"BANJAEAMT")-tempamt;
		}
	}  
</script>


<script language=JavaScript for=gcgd_disp02 event=OnDblClick(row,colid)>
	if(row>0){
		ln_Popup2(gcds_data02.namevalue(row,"FDCODE"),gcds_data02.namevalue(row,"BTSDAT"),gcds_data02.namevalue(row,"BTSNBR") );
	}
</script>

<script language=JavaScript for=gcem_chaamt03 event=OnKillFocus()>
  var temp1 = gcem_chaamt03.text ; 
	var temp2 = gcem_janamt02.text ;
	var temp3 = Number(temp1)-Number(temp2); 
 
  if(gcem_chaamt03.text!=0){
		if(gcem_chaamt02.text!=0 && gcem_daeamt02.text==0 ){ 
			alert("������ �ݾ��� �Է��� �� �����ϴ�.")
			gcem_chaamt03.text=0;
			return;
		}
    if(temp3>0){
			alert("�����ݾ��� �ܱݺ��� Ŭ �� �����ϴ�.");
		}
	}
</script>

<script language=JavaScript for=gcem_daeamt03 event=OnKillFocus()>
  var temp1 = gcem_daeamt03.text ; 
	var temp2 = gcem_janamt02.text ;
	var temp3 = Number(temp1)-Number(temp2); 

  if(gcem_daeamt03.text!=0){
		if(gcem_chaamt02.text ==0 && gcem_daeamt02.text!=0){ 
			alert("�뺯�� �ݾ��� �Է��� �� �����ϴ�.")
			gcem_daeamt03.text=0;
			return;
		}

		if(temp3>0){
			alert("�뺯�ݾ��� �ܱݺ��� Ŭ �� �����ϴ�.");
		}
	}
</script>

<script language=JavaScript for=gclx_fsrefcd event=oncloseup()>
	//�����׸�1[�˻�]
	gcds_fsrefval.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1="+gclx_fsrefcd.bindcolval;  
	gcds_fsrefval.Reset();
</script>


<script language=JavaScript for=gcgd_dtl event=OnPopup(row,colid,data)>
	ln_Popup('gcgd_dtl','',row,'');
</script>

<script language=JavaScript for=gcgd_disp03 event=OnDblClick(row,colid)>
   ln_Data4(row);
	 //������ǥ�� Detailã��
   ln_Query4(gcds_data03.namevalue(row,"FDCODE"),gcds_data03.namevalue(row,"BTSDAT"),gcds_data03.namevalue(row,"BTSNBR"));
	 ln_DispChk(3);
	 gcte_disp.ActiveIndex=4;
</script>

<script language=JavaScript for=gcgd_disp04 event=OnDblClick(row,colid)>
	 //������ǥ�� ����ǥ ã�� (����, ������ǥ����, ������ǥ��ȣ, ������ǥ���ȣ)
   ln_Query4_2(gcds_data04.namevalue(row,"FDCODE"),gcds_data04.namevalue(row,"TSDAT"),gcds_data04.namevalue(row,"TSNBR"),gcds_data04.namevalue(row,"TSSEQ"));
</script>

<script language=JavaScript for=gcgd_disp05 event=OnDblClick(row,colid)>
	 //����ǥ�� ������ǥã�� (����, ����ǥ��������, ����ǥ������ȣ, ����ǥ�������ȣ)
  // ln_Query5_2(gcds_data05.namevalue(row,"FDCODE"),gcds_data05.namevalue(row,"TSDAT"),gcds_data05.namevalue(row,"TSNBR"),gcds_data05.namevalue(row,"TSSEQ"));

   ln_Query5_2(gcds_data05.namevalue(row,"FDCODE"),gcds_data05.namevalue(row,"FSDAT"),  
					  	 gcds_data05.namevalue(row,"FSNBR"),gcds_data05.namevalue(row,"FSSEQ"),
					     '','','','');
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data01 event=OnSuccess()>
	//alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	//gs_save="Y";
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	//alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	//gs_save="N";
</script>

<script language=JavaScript for=gctr_data03 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	//gs_save="Y";
</script>

<script language=JavaScript for=gctr_data03 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	alert("Error Code : " + gctr_data03.ErrorCode + "\n" + "Error Message : " + gctr_data03.ErrorMsg + "\n");
	//gs_save="N";
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020003_head.gif"></td>
		<td width="876px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		</td>
	</tr>
  <tr> 
    <td colspan=2>
      <table width="0" cellpadding="1" cellspacing="0" border="0">
        <tr>
					<td width="0" align=right>
						<comment id="__NSID__"><object  id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 VIEWASTEXT style="width:660px;height:20px;position:relative;right:1px;">
							<PARAM NAME="BackColor"					VALUE="#cccccc">
   					  <PARAM NAME="titleHeight"				VALUE="20px">
						  <PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
						  <PARAM NAME="Format"						VALUE="
								<T>divid=div_1		title='  ��ǥ�ۼ�  '</T>									
							  <T>divid=div_2		title='  ������ȸ  '</T>
								<T>divid=div_3    title='������ǥ��ȸ'</T>
								<T>divid=div_4    title='������ǥ��'</T>
								<T>divid=div_5    title='������Ȳ��ȸ'</T>
							">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>
		</td>
  </tr>
</table>

<!--==1.��ǥ�ۼ� =========================================================================================-->
<table id="div_disp1"  cellpadding="0" cellspacing="0" border="0"  style="dispaly:block;position:relative;left:3px;" >
 <tr>
 <td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" >
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��������</nobr></td>
			<td class="tab18" style="height:30px;width:110px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<!--param name=Enable         value="false"-->
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
				<input id="txt_param"  type="hidden"   style= "width:90px; height:20px;" maxlength="7">
			 </td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;�Ⱓ&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;����&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:220px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcra_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="position:relative;left:0px;top:2px;height:24;width:210;cursor:hand;">
					  <param name=Cols     value="3">								 
						<param name=Format   value="N^������,Y^����Ϸ�">
			  </object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
			<td class="tab18" style="height:30px;width:250px;"  align=right>
       		<img src="../../Common/img/btn/com_b_taxissue.gif" style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Popup_Slip('01','')" >
					<!-- <img src="../../common/img/btn/com_b_print.gif"	   style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" > -->
					<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel()" >
			    <img src="../../Common/img/btn/com_b_query.gif"    style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query()">
			</td>
		</tr>
		<tr>
		  <td width="70px"  height="30px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;��������&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:100px;" colspan=3><nobr>&nbsp;
				<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:260px; height:20px;ime-mode:active;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcodenm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','fr','','txt_atcodenm_fr');">
				<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode_fr')" >
				</nobr>
			</td> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ŷ�ó&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;
				<input id="txt_custnm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:250px; height:20px;" maxlength="36"  onkeydown="ln_Blur('01','cust','txt_custnm_fr')">
				<img src="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;ime-mode:active;" align=center onclick="ln_Popup('02','fr','','txt_custnm_fr');">				
				<input id="txt_custcd_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="13"   onkeydown="ln_Blur('01','cust','txt_custcd_fr')">	
				</nobr>
			</td> 
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;�����׸�&nbsp;</nobr></td>
			<td class="tab19" style="width:100px;height:30px" colspan=6>
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:5px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^180">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefnm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����׸��� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','fr','','txt_fsrefnm_fr');">
				<input id="txt_fsrefcd_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefcd_fr')">~&nbsp;
				<input id="txt_fsrefnm_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_to','txt_fsrefnm_to')">				
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����׸��� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','to','','txt_fsrefnm_to');">
				<input id="txt_fsrefcd_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_to','txt_fsrefcd_to')" >
				<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Clear('02');">
			 <!--  <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Choice('02')">  -->
				</nobr>
			</td> 	
		</tr>

    <tr>
			<td class="tab17" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center >
				<input id="txt_label" type="text"  class="txt41" style= "width:50px;height:20px;position:relative;left:0px;background-color:#eeeeee"  readOnly="true";> 
			</td>
			<td class="tab19" style="height:30px;width:250px;"  colspan=6 ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
		</tr>

		<tr>
			<td height=3  colspan =7> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td width="876px"  class="tab15" align="right">
			<nobr>				
			  <font style="position:relative;top:-4px;left:0px">�����ݾ�</font>&nbsp;
				<input id="txt_banjaesum" type="text"  class="txtbox"  style= "position:relative;top:-1px;left:0px;width:100px; height:20px; text-align:right; color:#0000ff " onBlur="ln_Numeric()" maxlength="15" readOnly=false >
				<img src="../../Common/img/btn/com_b_setoff.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Setoff()">
				<img src="../../Common/img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Row_Del()">
				<img src="../../Common/img/btn/com_b_rowadd.gif"    style="cursor:hand;position:relative;top:3px;left:0px" onclick="ln_Row_Add()">
				<img src="../../Common/img/btn/com_b_ban.gif"		    style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Data_Banjae('01')">
				<img src="../../Common/img/btn/com_b_bantot.gif"		style="cursor:hand;position:relative;top:3px;left:0px" onClick="ln_Data_Banjae('02')">&nbsp;
				</nobr>
		  </td>
		</tr>

		<tr>
			<td height=3  colspan=8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" >
		<tr> 
			<td>                                      
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data01  
				style="position:relative;left:0px;width:875px; height:155px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			 VALUE="gcds_data01">
					<PARAM NAME="IndWidth"		 VALUE ="0">
					<PARAM NAME="BorderStyle"  VALUE="0">
					<PARAM NAME="Fillarea"		 VALUE="true">
					<PARAM NAME="Sortview"		 VALUE="left">
					<param name="ColSizing"    value="true">
					<param name="Editable"     value="false">
					<param name="ViewSummary"	 value=1>
					<PARAM NAME="Format"			 VALUE="           
					<FC> Name='����'		  ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB  editstyle=checkbox</FC> 
					<FC> Name='����'		  ID=GUBUN     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB  editStyle=Combo Data='N:��,Y:�Ϸ�' edit=none </FC> 
					<FC> Name='��ǥ��ȣ'  ID=SSNBR1	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB  edit=none  sumText='�� ��' sort=true</FC> 
					<FC> Name='����'			ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center	 SumBgColor=#C3D0DB  edit=none </FC> 
					<C> Name='����'			  ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	   SumBgColor=#C3D0DB  edit=none  color=#0000FF SumColor=#0000FF  sumText=@sum</C> 
					<C> Name='�뺯'			  ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB  edit=none  color=#FF0000 SumColor=#FF0000  sumText=@sum</C> 
					<C> Name='�ܾ�'			  ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB  edit=none  sort=true</C> 
					<C> Name='�����ݾ�'		ID=BANJAEAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right    SumBgColor=#C3D0DB  edit=RealNumeric bgColor=#ffffcc </C> 
					<C> Name='����'		    ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=left     SumBgColor=#C3D0DB  edit=none </C> 
					<C> Name='�ŷ�ó'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=left     SumBgColor=#C3D0DB  edit=none sort=true</C> 
					<C> Name='�����׸�'		ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=121	  align=left     SumBgColor=#C3D0DB  edit=none  EditStyle=Lookup Data='gcds_fsrefval:CDCODE:CDNAM' sort=true</C> 
					<C> Name='�Է�����'	  ID=REFVAL2 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=left     SumBgColor=#C3D0DB  edit=none  Mask='XXXX/XX/XX'  </C> 
					<C> Name='�����׸�'	  ID=REFVALNM2 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=reft     SumBgColor=#C3D0DB  edit=none  </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_dtl  
				style="position:relative;left:0px;width:875px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_dtl">
					<PARAM NAME="IndWidth"		VALUE ="0">
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<FC> Name='����'		  ID=CHK 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=30	 align=center	 SumBgColor=#C3D0DB edit=none editstyle=checkbox</FC> 
					<FC> Name='����'		  ID=ATKORNAM    HeadAlign=Center HeadBgColor=#B9D4DC Width=170	 align=left	   SumBgColor=#C3D0DB BgColor=#ffffcc  EditStyle=Popup sumText='�� ��' </FC> 
					<C> Name='��������'	  ID=CHAAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=right	 SumBgColor=#C3D0DB BgColor=#ffffcc  color=#0000FF edit=none sumText=@sum</C> 
					<C> Name='�����뺯'		ID=DAEAMT      HeadAlign=Center HeadBgColor=#B9D4DC Width=100	 align=right   SumBgColor=#C3D0DB BgColor=#ffffcc  color=#FF0000 edit=none sumText=@sum</C> 
					<C> Name='���� ��'		  ID=REMARK 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=200	 align=left    SumBgColor=#C3D0DB BgColor=#ffffcc  SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right</C> 
					<C> Name='�ŷ�ó'		  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=130	 align=left    SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='�����׸�'		ID=FSREFNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=121	 align=reft    SumBgColor=#C3D0DB edit=none EditStyle=Lookup Data='gcds_fsrefval:CDCODE:CDNAM'</C> 
					<C> Name='�Է�����'	  ID=REFVAL2 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=reft    SumBgColor=#C3D0DB edit=none  Mask='XXXX/XX/XX'  </C> 
					<C> Name='�μ�'		    ID=DEPTNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=125	 align=left    SumBgColor=#C3D0DB edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

</td>	
</tr>	
</table>

<!--==2.������ȸ =========================================================================================-->
<table id="div_disp2"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��������</nobr></td>
			<td class="tab18" style="height:30px;width:140px;" ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
						<param name=ComboDataID    value="gcds_comfield02">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ��ȣ&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_fsdatnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;ȸ������&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> </nobr> 
			</td> 
			
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:110px;">
						<param name=CBData			   value="Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="NAME^0^150">								
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 

        <img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;left:17px;top:2px;" onClick="ln_Excel2()" > 
				<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;left:17px;top:2px;" onclick="ln_Query2()">
				</nobr> 
			</td>
			
		</tr>
		<tr>   
		  <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;��������&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<input id="txt_atcode02"  type="hidden"   style= "width:90px; height:20px;" maxlength="7">
				<object  id=gcem_atcodenm02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-4px;top:3px">				
						<param name=Text					value="">
						<param name=GeneralEdit   value="true">
						<param name=Border        value=true>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
		  </td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�����ݾ�&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_chaamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�뺯�ݾ�&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:140px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_daeamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ܾ�&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:300px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_janamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:130px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>

		</tr>
		<tr>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;����&nbsp;</nobr></td>
			<td class="tab19" style="width:280px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_remark02" type="text" class="txtbox" readOnly=true  style= "position:relative;top:0px;left:-4px;width:325px; height:20px;background-color:#d7d7d7" maxlength="60" bgColor="#D7D7D7"  >
				</nobr>
			</td>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ŷ�ó&nbsp;</nobr></td>
			<td class="tab19" style="width:300px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_custcd02" type="hidden" class="txtbox"  readOnly=true style= "position:relative;top:0px;left:-4px;width:30px; height:20px;" maxlength="30" >
				<input id="txt_custnm02" type="text" class="txtbox"  readOnly=true   style= "position:relative;top:0px;left:-8px;width:313px; height:20px;background-color:#d7d7d7"  maxlength="60" bgColor="#D7D7D7" >			
				</nobr>
			</td> 	
		</tr>
		<tr>
			<td height=3  colspan =8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
				style="position:relative;left:0px;width:875px; height:344px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data02">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="Editable"    value="false">
					<param name="ColSizing"   value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='��ǥ����'		    ID=FSSTAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center	 SumBgColor=#C3D0DB EditStyle=Combo Data='N:������,R:�����û,Y:����Ϸ�' edit=none </C> 
					<C> Name='������ǥ��ȣ'		ID=SSDATNBR	 HeadAlign=Center HeadBgColor=#B9D4DC Width=102	  align=center	 SumBgColor=#C3D0DB sort=true	edit=none sumText='�� ��' </C> 
					<C> Name='����'		        ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center   SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='����'			      ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	   SumBgColor=#C3D0DB edit=none  SumColor=#0000FF color=#0000FF sumText=@sum </C> 
					<C> Name='�뺯'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right    SumBgColor=#C3D0DB edit=none  SumColor=#FF0000 color=#FF0000 sumText=@sum </C> 
					<C> Name='����'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=245	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='�ŷ�ó'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	sort=true edit=none  </C> 
					<C> Name='�����׸�'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	edit=none  </C> 
					<C> Name='����ī��ŷ�ó' ID=FSREFNM2	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft     SumBgColor=#C3D0DB	edit=none show=false </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==3.������ǥ��ȸ =========================================================================================-->
<table id="div_disp3"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>ȸ������</nobr></td>
			<td class="tab18" style="height:30px;width:290px;" align=left><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat03_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:2px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat03_fr', 'Text')" style="position:relative;width:20px;left:4px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat03_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:2px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat03_to', 'Text')" style="position:relative;width:20px;left:4px;cursor:hand;"></nobr>
			 </td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsstat03 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:110px;">
						<param name=CBData			   value="Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="NAME^0^150">								
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>��������</nobr></td>
			<td class="tab18" style="height:30px;width:190px;"><nobr>&nbsp;
				<comment id="__NSID__"><object  id=gclx_fdcode03 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:70px;">
						<param name=ComboDataID    value="gcds_comfield03">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td> 
			<td class="tab18" style="height;30px;width:220px;"  align=right><nobr>
        	<!-- <img src="../../common/img/btn/com_b_taxselect.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Query3()" > -->
					<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Delete3()" >
			    <img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Print3()">
        	<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel3()" >
			    <img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query3()"></nobr>
			</td>
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;����&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:420px;height:20px" colspan=6><nobr>&nbsp;
				<input id="txt_remark03" type="text" class="txtbox"  style= "position:relative;top:0px;left:-2px;width:410px; height:20px;" maxlength="60" bgColor="#D7D7D7"  >
				</nobr>
			</td> 	
		</tr>
    
		<tr>
			<td height=3  colspan =8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object id=gcgd_disp03  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  
				style="position:relative;left:0px;width:875px; height:374px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data03">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="false">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='����'		        ID=FDNAME	   HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	 SumBgColor=#C3D0DB sort=true	edit=none </C> 
					<C> Name='��ǥ��ȣ'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=center	 SumBgColor=#C3D0DB sort=true  edit=none  sumText='�� ��' </C> 
					<C> Name='����'			      ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=360	  align=left	   SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='�ݾ�'			      ID=FSAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='������ȣ'		    ID=FSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=110	  align=center   SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='��ǥ����'		    ID=FSSTAT    HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=center	 SumBgColor=#C3D0DB EditStyle=Combo Data='Y:����Ϸ�,R:�����û,N:������,C:�������,B:�ݼ�' edit=none </C> 
					">                                                                                                                                                        
				</object></comment><script>__ws__(__NSID__);</script> 
				<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
					&nbsp;<font id=ft_cnt03 style="position:relative;top:4px;"></font>
				</fieldset>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==4.������ǥ�� =========================================================================================-->
<table id="div_disp4"  cellpadding="0" cellspacing="0" border=0 style="display:none">
<tr>
<td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��������</nobr></td>
			<td class="tab18" style="height:30px;width:120px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield04">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="false">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			</td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;&nbsp;��ǥ��ȣ&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_bsdatnbr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				</nobr> 
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center>
				<nobr>&nbsp;&nbsp;������ȣ&nbsp;</nobr>
			</td>
			<td class="tab18" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_btsdatnbr04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Border        value=true>
									<param name=GeneralEdit   value="true">
									<param name=PromptChar    value="_">
									<param name=ReadOnly      value="true">
									<param name=BackColor     value="#CCCCCC">
									<param name=ReadOnlyBackColor   value="#D7D7D7">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				</nobr>
			</td>
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center>
				<nobr>&nbsp;��ǥ����&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:200px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsstat04 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:90px;">
						<param name=CBData         value="Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
						<param name=CBDataColumns	 value="FSCODE,FSSTAT">
						<param name=SearchColumn	 value=FSSTAT>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="FSSTAT^0^150"">								
						<param name=BindColumn		 value="FSCODE">
				</object></comment><script>__ws__(__NSID__);</script> 

				</nobr>
			</td> 
			<td class="tab18" style="height:30px;width:250px;"  align=right>
        	<!-- <img src="../../common/img/btn/com_b_print.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" > -->
			    <!-- <img src="../../common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query()"> -->
					<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel4()" >
			</td>
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center>
				<nobr>&nbsp;&nbsp;����&nbsp;</nobr></td>
			<td class="tab19" style="width:340px;height:30px" colspan=3><nobr>&nbsp;
				<input id="txt_remark04" type="text" class="txtbox" readOnly=true  style= "position:relative;top:0px;left:-4px;width:300px; height:20px;background-color:#d7d7d7" maxlength="30" bgColor="#D7D7D7"  >
			</td>
			
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center >
				<nobr>&nbsp;&nbsp;�����ݾ�&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_chaamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
      <td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center >
				<nobr>&nbsp;&nbsp;�뺯�ݾ�&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;<comment id="__NSID__">	
				<object  id=gcem_daeamt04 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
						<param name=Text					value="">
						<param name=Border        value=true>
						<param name=Alignment     value=2>
						<param name=Numeric       value="true">
						<param name=IsComma       value=true>
						<param name=MaxLength     value=12>
						<param name=ReadOnly      value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=ReadOnlyBackColor   value="#D7D7D7">
						<param name=InheritColor  value=false>
				</object></comment><script>__ws__(__NSID__);</script> </nobr>	
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td height=3  colspan=8> </td>
		</tr>
	</table>

	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp04  
				style="position:relative;left:0px;width:875px; height:194px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data04">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='����'		        ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='��������'		    ID=ATKORNAM	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=left  	 SumBgColor=#C3D0DB sort=true	edit=none sumText='�� ��' </C> 
					<C> Name='����'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none color=#0000FF SumColor=#0000FF sumText=@sum </C> 
					<C> Name='�뺯'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none color=#FF0000 SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='����'			      ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=left     SumBgColor=#C3D0DB edit=none  </C> 
					<C> Name='�ŷ�ó'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=reft     SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='�����׸�'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=140	  align=reft     SumBgColor=#C3D0DB sort=true edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp14  
				style="position:relative;left:0px;width:875px; height:194px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data04_2">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='��ǥ��ȣ'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB edit=none sumText='�� ��'</C> 
					<C> Name='����'		        ID=FSNUM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='����'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	   SumBgColor=#C3D0DB edit=none  color=#0000FF  SumColor=#0000FF sumText=@sum  </C> 
					<C> Name='�뺯'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	   SumBgColor=#C3D0DB edit=none  color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='�ܾ�'			      ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='����'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=264	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='�ŷ�ó'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=150	  align=reft     SumBgColor=#C3D0DB	edit=none  </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>
</td>
</tr>
</table>

<!--==5.������Ȳ��ȸ =========================================================================================-->
<table id="div_disp5"  cellpadding="0" cellspacing="0" border="0"  style="display:none" >
 <tr>
 <td>
	<table width="876px" cellpadding="0" cellspacing="0" border="0"  style="position:relative;left:3px">
		<tr> 
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��������</nobr></td>
			<td class="tab18" style="height:30px;width:110px;" align=center><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fdcode05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_comfield05">
						<param name=CBDataColumns	 value="FDCODE,FDNAME">
						<param name=SearchColumn	 value=FDNAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="FDNAME^0^150">								
						<param name=BindColumn		 value="FDCODE">
				</object></comment><script>__ws__(__NSID__);</script> </nobr>
			 </td>

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;�Ⱓ&nbsp;</nobr></td>
			<td class="tab18" style="height:30px;width:250px;"><nobr>&nbsp;
				<comment id="__NSID__"><object  id=gcem_actdat05_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat05_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;
				 <comment id="__NSID__"><object  id=gcem_actdat05_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat05_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
       
			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;����&nbsp;</nobr></td>
			<td class="tab31" style="height:30px;width:150px;"><nobr>&nbsp;<comment id="__NSID__">
				 <object  id=gclx_gubun05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:-2px;top:2px;font-size:12px;width:90px;">
						<param name=CBData         value="N^������,Y^�̰�Ϸ�,A^��ü">
						<param name=CBDataColumns	 value="CODE,NAME">
						<param name=SearchColumn	 value=NAME>
						<param name=Sort			     value=false>
						<param name=Enable         value="true">
						<param name=ListExprFormat value="NAME^0^150">							
						<param name=BindColumn		 value="CODE">
				</object></comment><script>__ws__(__NSID__);</script> 
       
				</nobr>
			</td> 
			
			<td class="tab18" style="height:30px;width:250px;"  align=right>
        	<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Print()" >
			    	<img src="../../Common/img/btn/com_b_excel.gif"	  style="cursor:hand;position:relative;right:2px;top:2px;" onClick="ln_Excel5()" >
					<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;right:2px;top:2px;" onclick="ln_Query5()">
			</td>
		</tr>
		<tr>
		  <td width="70px"  height="30px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;��������&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:100px;" colspan=3><nobr>&nbsp;
				<input id="txt_atcodenm05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:260px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcodenm05_fr');">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','05fr','','txt_atcodenm05_fr');">
				<input id="txt_atcode05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="36" onkeydown="ln_Blur('01','atcode','txt_atcode05_fr')" >
				<!--input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
				~&nbsp;
				<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:90px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,36);" >
				<img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="���������� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','to');">
				<input id="txt_atcodenm_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" -->
				</nobr>
			</td> 

			<td width="70px" style="height:30px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ŷ�ó&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:150px;" colspan=2><nobr>&nbsp;
				<input id="txt_custnm05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:250px; height:20px;" maxlength="36"  onkeydown="ln_Blur('01','cust','txt_custnm05_fr')">
				<img src="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;ime-mode:active;" align=center onclick="ln_Popup('02','05fr','','txt_custnm05_fr');">				
				<input id="txt_custcd05_fr" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:60px; height:20px;" maxlength="13"   onkeydown="ln_Blur('01','cust','txt_custcd05_fr')">	
				</nobr>
			</td> 
		</tr>
		<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;�����׸�&nbsp;</nobr></td>
			<td class="tab19" style="width:100px;height:30px" colspan=6>
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd05 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:5px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd05">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^150">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm05_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;" maxlength="36" onkeydown="ln_Blur('03','fsref05_fr','txt_fsrefnm05_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����׸��� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','05fr','','txt_fsrefnm05_fr');">
				<input id="txt_fsrefcd05_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="7" onkeydown="ln_Blur('03','fsref05_fr','txt_fsrefcd05_fr');">				
				~&nbsp;
				<input id="txt_fsrefnm05_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:155px; height:20px;" maxlength="36" onkeydown="ln_Blur('03','fsref05_to','txt_fsrefnm05_to');">				
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�����׸��� �˻��մϴ�" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('03','05to','','txt_fsrefnm05_to');">
				<input id="txt_fsrefcd05_to" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:60px; height:20px;" maxlength="7"    onkeydown="ln_Blur('03','fsref05_to','txt_fsrefcd05_to');" >
				<img SRC="../../Common/img/btn/com_b_clear.gif" BORDER="0" style="cursor:hand;position:relative;left:0px;top:0px" align=center onclick="ln_Clear('06');">
			  <!-- <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Slip('01','')"> -->
				</nobr>
			</td> 	
		</tr>
		<tr>
			<td height=3  colspan =7> </td>
		</tr>
	</table>
	<table width="876px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp05  
				style="position:relative;left:0px;width:875px; height:177px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data05">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='��ǥ��ȣ'		 ID=SSNBR1    HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	SumBgColor=#C3D0DB edit=none  sumText='�հ�'</C> 
					<C> Name='����'		     ID=FSNUM     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	    align=center	SumBgColor=#C3D0DB edit=none  </C> 
					<C> Name='����'		     ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  color=#0000FF  SumColor=#0000FF sumText=@sum </C> 
					<C> Name='�뺯'			   ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='�ܾ�'			   ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=right	  SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='����'			   ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=left    SumBgColor=#C3D0DB sort=true edit=none  </C> 
					<C> Name='�ŷ�ó'		   ID=VENDNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft    SumBgColor=#C3D0DB sort=true edit=none </C> 
					<C> Name='�����׸�'		 ID=FSREFNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft    SumBgColor=#C3D0DB sort=true edit=none </C> 
					">

				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
		<tr>
				<!--fieldset style="position:relative;left:0px;width:877px;height:5px;border:0 solid #708090;border-top-width:0px;border-bottom-width:0px;text-align:left;">
					&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
				</fieldset-->
			<td height=5  colspan=8> </td>
		</tr>
		<tr> 
			<td>
				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp5_2  
				style="position:relative;left:0px;width:875px; height:177px; border:1 solid #708090;display:block;" viewastext>
					<PARAM NAME="DataID"			VALUE="gcds_data05_2">
					<PARAM NAME="IndWidth"		VALUE ='0'>
					<PARAM NAME="BorderStyle" VALUE="0">
					<PARAM NAME="Fillarea"		VALUE="true">
					<PARAM NAME="Sortview"		VALUE="left">
					<param name="ColSizing"   value="true">
					<param name="Editable"    value="true">
					<param name="ViewSummary"	value=1>
					<PARAM NAME="Format"			VALUE="              
					<C> Name='��ǥ��ȣ'		    ID=SSDATNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center	 SumBgColor=#C3D0DB edit=none sumText='�� ��'</C> 
					<C> Name='����'		        ID=FSNUM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center	 SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='����'		        ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none   color=#0000FF  SumColor=#0000FF sumText=@sum  </C> 
					<C> Name='�뺯'			      ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right	   SumBgColor=#C3D0DB edit=none   color=#FF0000  SumColor=#FF0000 sumText=@sum </C> 
					<C> Name='�ܾ�'			      ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right    SumBgColor=#C3D0DB edit=none  sumText=@sum </C> 
					<C> Name='����'		        ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=213	  align=reft     SumBgColor=#C3D0DB edit=none </C> 
					<C> Name='�ŷ�ó'		      ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft     SumBgColor=#C3D0DB	edit=none </C> 
					<C> Name='�����׸�'		    ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=reft     SumBgColor=#C3D0DB	edit=none </C> 
					">
				</object></comment><script>__ws__(__NSID__);</script> 
			</td>
		</tr>
	</table>

</td>	
</tr>	
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
