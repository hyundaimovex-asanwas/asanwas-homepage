<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  ��ǥ���� - ���(���ο� ȭ�鿡�� ó����)
+ ���α׷� ID	:  A020009.html
+ �� �� �� ��	:  ��ǥ�� �Է�/��ȸ �ϴ� ȭ���̴�
+ ��   ��  �� :  �� �� ��
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� �� :	 
+ ��   ��  �� :
+ �� �� �� �� :
-----------------------------------------------------------------------------
+ �� �� �� ��	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��ǥ���</title>

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
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var g_strbanjae="N"  //��������
var g_taxval=0;         //���ݰ�꼭 �ݾ� �հ�
var g_fsknd="0";       //��ǥ����  0 - ������ǥ, 1- ���ݰ�꼭, 2 - �����ڻ�

var gs_team_user="";
                     //          3 - �ڱ�      6- ����      
var g_add_gubun="";  //�ű԰ǰ� ������ �����ϱ�.(2007.05.11 ������ �߰�)

var g_arrParam	= new Array();

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

    ln_SetDataHeader("01_2");
	gcds_data01_2.addrow();
	
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	
	//prompt('',gcds_dept.DataID );
	gcds_dept.Reset();

	ln_Before();
	
	
	if(gf_USER(gs_deptcd,gcds_dept2)){ // ȸ���� üũ 
		gs_team_user="true";
	}else{
		gs_team_user="false";
	}
	
	
	//2020.01.21 �ӽ�
	if(gs_userid=="asan001"||gs_userid=="asan002"||gs_userid=="asan003"||gs_userid=="asan004"||gs_userid=="asan005"){
		sp3.style.display = "none"; //����
		sp4.style.display = "none"; //����
	}else{
		sp3.style.display = "";  //������ 
		sp4.style.display = "";  //������
	}
	
	
	
	//�渮���úμ��� �������.
	if(gf_empno_Enable(gs_userid,gcds_userid2)){
		gclx_fdcode02.bindcolval=gs_fdcode;
		gs_userid2="true";
		sp0.style.display = "";  //������
		if(gs_fdcode!='02') gclx_fdcode02.Enable=false; 
	}else{
    	gclx_fdcode02.bindcolval=gs_fdcode;
		gclx_fdcode02.Enable=false; 
     	gs_userid2="false";
		sp0.style.display = "none"; //����
			/*
			if(gs_fdcode !='03'){
				gclx_fdcode02.bindcolval=gs_fdcode;
				gclx_fdcode02.Enable=false; 
				gs_userid2="false";
				sp0.style.display = "none"; //����
			}else{
				gclx_fdcode02.bindcolval=gs_fdcode;
				gs_userid2="true";
				sp0.style.display = "";  //������
			}
			*/
	}
	gclx_fdcode02.bindcolval=gs_fdcode;
	gs_userid2="true";
	sp0.style.display = "";  //������
	if(gs_fdcode!='02') gclx_fdcode02.Enable=false; 

	txt_deptnm02.value= fn_trim(gs_deptnm);
	txt_deptcd02.value= gs_deptcd;
	txt_empno02.value=gs_userid;
	txt_empnmk02.value=gs_usernm;

    ln_Add("02",''); 
	ln_Data_Mst_Setting();
	
	
	gclx_fdcode02.Enable=true; 
	
	
	
}

/******************************************************************************
	Description : ��ǥ MST �ʱⰪ ����
	parameter   : 
******************************************************************************/
function ln_Data_Mst_Setting(){
	   
	    //jys 20160229
	    // ���￡�� ������ǥ �ۼ��ϱ� ���� �ӽ÷� ������.  
	    if(gusrid=="2140004"||gusrid=="6180021"||gusrid=="6070001"){
	    	
	    }else{
	      gclx_fdcode02.bindcolval = gs_fdcode;
	    }
	    
		gcem_fs02.text = "A";
		gcem_fsdat02.text=gs_date;
		gcem_fsnbr02.text="000000";
		gclx_fsstat02.bindcolval="N";
		gcem_fswrtdat02.text = gs_date;   //�ۼ�����
		gcem_actdat02.text = gs_date;     //ȸ������
		gcem_fsamt02.text = 0; 


		txt_deptnm02.value=gdeptnm;
		txt_deptcd02.value=gdeptcd;
		txt_empno02.value=gusrid;
		txt_empnmk02.value=gusrnm;
	}

/******************************************************************************
	Description : ��ȸ
	parameter   : 01 - ��ǥ MST ��ȸ 
	

  ����        : ��ǥ DETAIL ��ȸ - ��ǥ��ȣ�� (������ȣ�� 000000 �� ���� ��������+��ǥ��ȣ�θ� ��ȸ��.)
******************************************************************************/
function ln_Query(p){

  ln_Ref_Data_Clear(); //�����׸� ����Ÿ ����
  ln_Ref_Format_Setting();//�ʱ�ȭ

  hid_b_fdcode.value=gclx_fdcode02.bindcolval;
	hid_b_fs.value = gcem_fs02.text; 
	hid_b_fsdat.value=gcem_fsdat02.text; 
	hid_b_fsnbr.value=gcem_fsnbr02.text;
  
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;
	var fsnbr=gcem_fsnbr02.text;
	var ssdat=gcem_ss02.text+gcem_ssdat02.text;
	var ssnbr=gcem_ssnbr02.text;

    if(p=="01"){
		if((fsnbr=="000000"||fn_trim(fsnbr)=="")&&(ssnbr=="000000"||fn_trim(ssnbr)=="")){
			return;
		}
	}else if(p=="03"){
		if((fsnbr=="000000"||fn_trim(fsnbr)=="")&&(ssnbr=="000000"||fn_trim(ssnbr)=="")){
			alert("��ǥ��ȣ �Ǵ� ������ȣ�� �Է��Ͻʽÿ�.");
			return;
		}
	}

	if(fsnbr=="000000"||fn_trim(fsnbr)==""){
    	fsdat="";
		fsnbr="";
	}

	if(ssnbr=="000000"||fn_trim(ssnbr)==""){
    	ssdat="";
		ssnbr="";
	}

	ln_DataSet_Clear(); //��� ����Ÿ �� clear;

	if(p=="01"){
		gcds_data01_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s8?v_str1="+gclx_fdcode02.bindcolval
																							   	     +"&v_str2="+fsdat
																							         +"&v_str3="+fsnbr
																									 +"&v_str4="+ssdat
																									 +"&v_str5="+ssnbr;										
		//prompt("",gcds_data01_2.DataID );																							
		gcds_data01_2.Reset();
	}else if(p=="03"){
		gcds_dtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s7f?v_str1="+gclx_fdcode02.bindcolval
																									 +"&v_str2="+fsdat
																									 +"&v_str3="+fsnbr
																									 +"&v_str4="+ssdat
																									 +"&v_str5="+ssnbr;		
        //prompt("gcds_dtl::",gcds_dtl.DataID);																									 
		gcds_dtl.Reset(); 
	}
}

/************************************************************************************************************
Description : �����ڵ� ã��
parameter   :
*************************************************************************************************************/
/*
function ln_Find_Divcd(){
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;																						
	gcds_divcd.Reset();
	if(gcds_divcd.countrow>0){
		return gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD");
	}else{
		return;
	}
}

/************************************************************************************************************
	Description : ��ǥ �űԵ��
	parameter   :   p  02 : ��ǥ���ȭ�鿡�� ���,  
									   99 : ���߰�
							gubun  TAX : ���ݰ�꼭���� �߰� �ϴ� �׸����� ln_Chk_Addrow�� Ÿ������.

*************************************************************************************************************/
function ln_Add(p,gubun){
  if(p=='02'){
	    ln_DataSet_Clear();
	    ln_Data_Add_Set();
		gcds_dtl.deleteall();
		ln_SetDataHeader("DTL");
		gcds_dtl.Addrow();
		ln_Lock_false();
		ln_Bgt_Amt_Clear();
		ln_MST_Data_Clear();		
		//2014.01.06 jys �߰�
		ln_Data_Mst_Setting();
		//��������
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
		gcem_atkornam02.Focus();
		g_add_gubun = "New";
	}else if(p=='99'){        //���߰� 
    	if(gcds_dtl.rowposition>0){
			if(gubun == "TAX"){
				//ù��°���� �ι�° ���߰� �Ҷ� �μ�,�ŷ�ó,���� ����
				////if(gcds_dtl.countrow==1){
				ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition,'TAX');
				////}
				gcds_dtl.Addrow();
				//��������
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
			}else{
				if(ln_Chk_Addrow()){
					//ù��°���� �ι�° ���߰� �Ҷ� �μ�,�ŷ�ó,���� ����
					if(!ln_Chk_Status('U'))return;
					////if(gcds_dtl.countrow==1){
					ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition,'');
					////}
					gcds_dtl.Addrow();
					//��������
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
				}else{
					return false;
				}
			}
		}
	}

	ln_Data_Fdcode_Fsdat_Fsnbr();
	return true;
}

/******************************************************************************
	Description : Mst Data �ʱⰪ ����
	parameter   : 
******************************************************************************/
function ln_Data_Add_Set(){
	gcem_fs02.text = "A";
	gcem_fsdat02.text=gs_date;
	gcem_fsnbr02.text="000000";
	gclx_fsstat02.bindcolval="N";
	gcem_fswrtdat02.text=gs_date; //�ۼ�����
	gcem_actdat02.text=gs_date;     //ȸ������
	gcem_fsamt02.text = 0 ; 
}
/************************************************************************************************************
	Description : Ű�� �ڵ� ����
	parameter   :    
*************************************************************************************************************/
function ln_Data_Fdcode_Fsdat_Fsnbr(){
  	var t1=0; //gcds_dtl �� max�� 
	var t2=0; //gcds_seq �� max��
  	hid_fdcode.value="";
	hid_fsdat.value ="";
	hid_fsnbr.value="";
	hid_fsseq.value ="";

	hid_fdcode.value = gclx_fdcode02.bindcolval;
  	hid_fsdat.value = gcem_fs02.text+gcem_fsdat02.text;
 	hid_fsnbr.value = gcem_fsnbr02.text;

	if(gcds_dtl.countrow>0){
		t1 = gcds_dtl.Max(4,0,0);
	}

  	if(gcds_fsseq.countrow>0){
		t2 = gcds_fsseq.Max(4,0,0);
	}
  
  	if(t1>=t2){
		hid_fsseq.value = Number(gcds_dtl.Max(4,0,0))+1;
	}else{
    	hid_fsseq.value = Number(gcds_fsseq.Max(4,0,0))+1;
	}

	//alert(" hid_fsseq.value:1:"+ hid_fsseq.value);
	hid_fsseq.value = ln_Seqno_Format(hid_fsseq.value,5)
  //alert(" hid_fsseq.value:2:"+ hid_fsseq.value);

	//alert("hid_fdcode.value::"+hid_fdcode.value);
}

/******************************************************************************
	Description : �����
	parameter   : 
******************************************************************************/
function ln_Insert(){
 	var insertrow=0;
	var strdocumcd="";
	var strdocuval="";
  	var strvendcd="";
	var strvendnm="";
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;
	
	if(!ln_Chk_Status('U'))return;
	
	
	//2015.02.23.JYS ����Խ� ���� �Ȱ�����.. ��繬 CJ ��û
	//������(���ݰ�꼭��ȣ��)�� ������ ��� �����ڵ� �� �������� �����ؼ� ������.
	/*
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")!=""){
	  //ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition);
		strdocumcd=gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD");
		strdocuval=gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL");
		strvendcd=gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02");
		strvendnm=gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02");
	}
	*/
	
	
	insertrow = gcds_dtl.rowposition + 1 ; 
	if(gcds_dtl.rowposition>0){
		gcds_dtl.Insertrow(insertrow);
		//��������
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
		//���� ������ �缳����
		ln_Fsnum_Reset(gcds_dtl.rowposition,"01");
		if(strdocuval!=""){
		  //ln_Paste_Dept_Vend_Reamrk(gcds_dtl.rowposition);
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")=strdocumcd;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")=strdocuval;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")=strvendcd;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")=strvendnm;
			ln_Dtl_Lock(gcds_dtl.rowposition);

			//���ݰ�꼭 ����Ÿ �¿� �߰���.
			ln_Tax_Data_Save(strdocuval, gs_date, gs_userid, fsdat);
		} 
	}
	ln_Data_Fdcode_Fsdat_Fsnbr();
}

/******************************************************************************
	Description : ����
	parameter   : p - 01 : ��ǥ��ü����  mst, detail, �����׸� + (��꼭 Master, ��꼭 Detail)
	                  99 : detail  �� �����׸� ���� + (��꼭 Master, ��꼭 Detail)
										dis: ȭ�鿡���� �����ǰ� ���� DB ������ �ȵ�.
******************************************************************************/
function ln_Delete(p){
  var chkgubun="";
  if(!ln_Chk_Status('U'))return;
	if(p=="dis"){

	  if(!ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
		                        gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
								gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
								gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
			
	  //�������̺� �������� ���� ���
      //��������Ÿ �¿� �����ϴ� ��� ���� �Ұ�,
      		for(m=1;m<=gcds_banjae.countrow;m++){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(m,"BTSSEQ")){
					chkgubun="1";
				}
			}

	      //������ ������.
	        if(chkgubun=="1"){
				alert("�ش� ������ ���������Դϴ�. �������� �� �����Ͻʽÿ�.");
				return;
			}else{
				
				//alert("DOCUVAL::"+gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")+"::");
				if(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")!=""&&gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")!=undefined){
					ln_Tax_Del_Row(gcds_dtl.rowposition); //���ݰ�꼭�� ������ ��� ���ݰ�꼭 �� ��ǥ��ȣ ����
				}

				ln_Data_Dtl_Delete(gcds_dtl.rowposition);		
				ln_Data_Bgt_Delete(gcds_dtl.rowposition);	
				//prompt("gcds_dtl_del::",gcds_dtl_del.text);	

				ln_Fsseq_Temp(gcds_dtl.rowposition);
				gcds_dtl.deleterow(gcds_dtl.rowposition);
				//���� ������ �缳����
				ln_Fsnum_Reset(gcds_dtl.rowposition,"02");
			}
		}else{
		  //�������̺� �����ϴ� ���
			alert("�ش� ������ ���������Դϴ�. ����� �� �� �����ϴ�.");
			return;
		}
	}
}

/******************************************************************************
	Description : ��ü ����
	prameter    :
******************************************************************************/
function ln_Delete_All(){
    var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text; 
	var p3 = gcem_fsnbr02.text;

	if(!ln_Chk_Status('D'))return;

	if(gcem_fsnbr02.text=="000000") return;
	
	if(txt_fsknd02.value>="1"){
		alert("�ڵ���ǥ�� ������ ��ǥ�Դϴ�. ������ �� �����ϴ�.");
		return;
	}

	//�������ΰ�� ���� ���ϰ� ��.
	if(ln_Chk_Del_Banjae(p1,p2,p3)){
		alert("����ó�� ��ǥ�� ������ �� �����ϴ�.");
		return;
	}

	ln_SetDataHeader("MST_DEL");
	gcds_del02.addrow();
	gcds_del02.namevalue(gcds_del02.rowposition,"FDCODE")=p1;
	gcds_del02.namevalue(gcds_del02.rowposition,"FSDAT")=p2;
	gcds_del02.namevalue(gcds_del02.rowposition,"FSNBR")=p3;
	//2017.02.01 ��ǥ ����
	gcds_del02.namevalue(gcds_del02.rowposition,"FSKND")=gcds_data01_2.namevalue(1,"FSKND");
	
	if (gcds_del02.IsUpdated){
	  ln_Del_All_Bgt_find(); //������ �� ������ �����ϴ� �� ã��
	  if(ln_Chk_Tax(p1,p2,p3)){
			if(confirm("���������� �����մϴ�. �����Ͻðڽ��ϱ�?")){	
				gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t2f?";
			  //prompt("gcds_del02",gcds_del02.text);
				gctr_data02.post();
				ln_Add('02','');
			}else{
				gcds_del02.Undo(gcds_del02.rowposition);
				gcds_bgt_del_all.Undo(gcds_bgt_del_all.rowposition);
				return;
			}
	  }else{
			if (confirm("�����Ͻðڽ��ϱ�?")){	
				gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t2f?";
		        //prompt("gcds_del02",gcds_del02.text);
				//prompt("gcds_bgt_del_all",gcds_bgt_del_all.text);
				gctr_data02.post();
				ln_Add('02','');
			}else{
				gcds_del02.Undo(gcds_del02.rowposition);
				gcds_bgt_del_all.Undo(gcds_bgt_del_all.rowposition);
				return;
			}
		}
	}
}

/******************************************************************************
	Description : ���� �� ���԰ǿ� ���� FSSEQ�� MAX���� �����ϱ� ���� �ӽõ���Ÿ��
	parameter   :
******************************************************************************/
function ln_Fsseq_Temp(i){
	ln_SetDataHeader("FSSEQ");
    gcds_fsseq.addrow();
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FDCODE") = gcds_dtl.namevalue(i,"FDCODE");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSDAT")  = gcds_dtl.namevalue(i,"FSDAT");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSNBR")  = gcds_dtl.namevalue(i,"FSNBR");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSSEQ")  = gcds_dtl.namevalue(i,"FSSEQ");
}

/******************************************************************************
	Description : ����
	parameter   :
******************************************************************************/
function ln_Save(){
		
	if(ln_Chk_Save()){
		ln_Data_Mst();
		ln_Data_Dtl(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"COCODE"));
		if (gcds_mst.IsUpdated||gcds_dtl.IsUpdated){
			if (confirm("�����Ͻðڽ��ϱ�?")){	
				gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020009_t1?";
				//prompt("gctr_data01",gctr_data01.Action);
				if(gcds_mst.countrow==0)          gcds_mst.ClearAll();
				if(gcds_dtl_insert.countrow==0)   gcds_dtl_insert.ClearAll();
				if(gcds_dtl_update.countrow==0)   gcds_dtl_update.ClearAll();
				if(gcds_dtl_del.countrow==0)      gcds_dtl_del.ClearAll();
				if(gcds_banjae.countrow==0)       gcds_banjae.ClearAll();
				if(gcds_banjaemst.countrow==0)    gcds_banjaemst.ClearAll();
				if(gcds_tax.countrow==0)          gcds_tax.ClearAll();
				if(gcds_genrst.countrow==0)       gcds_genrst.ClearAll();
				if(gcds_bgt_insert.countrow==0)   gcds_bgt_insert.ClearAll();
				if(gcds_bgt_update.countrow==0)   gcds_bgt_update.ClearAll();
				if(gcds_bgt_del.countrow==0)      gcds_bgt_del.ClearAll();
				if(gcds_fsnum.countrow==0)        gcds_fsnum.ClearAll();
				if(gcds_tax_del_row.countrow==0)  gcds_tax_del_row.ClearAll();

        
				if(gusrid=="6070001"){
					prompt("gcds_mst",gcds_mst.text);
					prompt("gcds_dtl_insert",gcds_dtl_insert.text);
					prompt("gcds_dtl_update",gcds_dtl_update.text);
					prompt("gcds_dtl_del",gcds_dtl_del.text);
					prompt("gcds_banjae",gcds_banjae.text);
					prompt("gcds_banjaemst",gcds_banjaemst.text);
					prompt("gcds_tax",gcds_tax.text);
					prompt("gcds_genrst",gcds_genrst.text);
					prompt("gcds_bgt_insert",gcds_bgt_insert.text);
					prompt("gcds_bgt_update",gcds_bgt_update.text);
					prompt("gcds_bgt_del",gcds_bgt_del.text);
					prompt("gcds_fsnum",gcds_fsnum.text);
					prompt("gcds_tax_del_row",gcds_tax_del_row.text);
				}
			
			    /*
					prompt("gcds_mst",gcds_mst.text);
					prompt("gcds_dtl_insert",gcds_dtl_insert.text);
					prompt("gcds_dtl_update",gcds_dtl_update.text);
					prompt("gcds_dtl_del",gcds_dtl_del.text);
					prompt("gcds_banjae",gcds_banjae.text);
					prompt("gcds_banjaemst",gcds_banjaemst.text);
					prompt("gcds_tax",gcds_tax.text);
					prompt("gcds_genrst",gcds_genrst.text);
					prompt("gcds_bgt_insert",gcds_bgt_insert.text);
					prompt("gcds_bgt_update",gcds_bgt_update.text);
					prompt("gcds_bgt_del",gcds_bgt_del.text);
					prompt("gcds_fsnum",gcds_fsnum.text);
					prompt("gcds_tax_del_row",gcds_tax_del_row.text);
				  */
		    
				gctr_data01.Parameters = "v_str1="+gs_fdcode;
				gctr_data01.post();

				ln_Query('03');
				ln_Query('01');
				g_add_gubun=""; //�ű�,���� ����
			}else{
				gcds_mst.ClearAll();
				gcds_dtl_insert.ClearAll();
				gcds_dtl_update.ClearAll();
				gcds_dtl_del.ClearAll();
				gcds_banjae.ClearAll();
				gcds_banjaemst.ClearAll();
				gcds_tax.ClearAll();
				gcds_bgt_insert.ClearAll();
				gcds_bgt_update.ClearAll();
				gcds_bgt_del.ClearAll();
				gcds_fsnum.ClearAll();
				gcds_tax_del_row.ClearAll();
			}
		}
	}
}

/******************************************************************************
	Description : ��ǥ MST ����
	parameter   :
******************************************************************************/
function ln_Data_Mst(){
	    ln_SetDataHeader("MST");
	    var row = gcds_data01_2.rowposition;
		var strcocode = ln_Cocode(gcds_data01_2.namevalue(row,"COCODE"));
        gcds_mst.addrow();

		gcem_fsamt02.text = gcds_dtl.sum(9,0,0);
	  /** �ű԰ǰ� �������� ������
		gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.OrgNameString(row,"FDCODE");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.OrgNameString(row,"FSDAT1")+gcds_data01_2.OrgNameString(row,"FSDAT2") ;
		gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.OrgNameString(row,"FSNBR");
		**/
		
		//2007.05.11 ������ �ű԰ǰ� �������� ������.   
		/*
		if(g_add_gubun=="New"){ //�ű԰�
			gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.namevalue(row,"FDCODE");
			gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.namevalue(row,"FSDAT1")+gcds_data01_2.namevalue(row,"FSDAT2") ;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.namevalue(row,"FSNBR");
		}else{ //������
      gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.OrgNameString(row,"FDCODE");
			gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.OrgNameString(row,"FSDAT1")+gcds_data01_2.OrgNameString(row,"FSDAT2") ;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.OrgNameString(row,"FSNBR");
		}
		*/

		//2007.05.20 ������ org.������.
		gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.namevalue(row,"FDCODE");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.namevalue(row,"FSDAT1")+gcds_data01_2.namevalue(row,"FSDAT2") ;
		gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.namevalue(row,"FSNBR");
		
		gcds_mst.namevalue(gcds_mst.rowposition,"FSKND")=gcds_data01_2.namevalue(row,"FSKND");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSWRTDAT")=gcds_data01_2.namevalue(row,"FSWRTDAT");

		gcds_mst.namevalue(gcds_mst.rowposition,"COCODE")=strcocode;
		gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD")=gcds_data01_2.namevalue(row,"DEPTCD");
		gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")=gcds_data01_2.namevalue(row,"EMPNO");
		gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")=gcds_data01_2.namevalue(row,"DIVCD");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSAMT")=gcds_data01_2.namevalue(row,"FSAMT");

		gcds_mst.namevalue(gcds_mst.rowposition,"FSVAT")=gcds_data01_2.namevalue(row,"FSVAT");
		gcds_mst.namevalue(gcds_mst.rowposition,"DETOT")=gcds_data01_2.namevalue(row,"DETOT");
		gcds_mst.namevalue(gcds_mst.rowposition,"CRTOT")=gcds_data01_2.namevalue(row,"CRTOT");
		gcds_mst.namevalue(gcds_mst.rowposition,"REMARK")=gcds_data01_2.namevalue(row,"REMARK");
		gcds_mst.namevalue(gcds_mst.rowposition,"SGNDAT")="";  //��������

		gcds_mst.namevalue(gcds_mst.rowposition,"FSSTAT")=gcds_data01_2.namevalue(row,"FSSTAT");
		gcds_mst.namevalue(gcds_mst.rowposition,"ACTDAT")=gcds_data01_2.namevalue(row,"ACTDAT"); //ȸ������
		gcds_mst.namevalue(gcds_mst.rowposition,"WRDT")=gcds_data01_2.namevalue(row,"WRDT");
		gcds_mst.namevalue(gcds_mst.rowposition,"WRID")=gcds_data01_2.namevalue(row,"WRID");
		gcds_mst.namevalue(gcds_mst.rowposition,"UPDT")=gcds_data01_2.namevalue(row,"UPDT");
		gcds_mst.namevalue(gcds_mst.rowposition,"UPID")=gcds_data01_2.namevalue(row,"UPID");
}

/******************************************************************************
	Description : ��ǥ Dtl ����
	parameter   :
******************************************************************************/
function ln_Data_Dtl(strcocode){
  //prompt("gcds_dtl::",gcds_dtl.text);
  //alert("strcocode::"+strcocode);
	for(k=1;k<=gcds_dtl.countrow;k++){
	  //alert("gcds_dtl.count"+ k);
		if(gcds_dtl.namevalue(k,"ATCODE")!=""&&gcds_dtl.namevalue(k,"ATCODE")!=undefined){
			if(gcds_dtl.SysStatus(k)==1){       //Insert
				ln_Data_Dtl_Insert(k);		
				ln_Data_Bgt_Insert(k,strcocode);		
				//prompt("gcds_dtl_insert::",gcds_dtl_insert.text);
			}else if(gcds_dtl.SysStatus(k)==3){ //Update
				ln_Data_Dtl_Update(k);	
				ln_Data_Bgt_Update(k);	
				//prompt("gcds_dtl_update::",gcds_dtl_update.text);	
			}
		}
	}//for
}

/******************************************************************************
	Description : ��ǥ Dtl DATA INSERT 
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Insert(k){

	ln_SetDataHeader("DTL_INSERT"); 
	gcds_dtl_insert.Addrow();
	var row = gcds_dtl_insert.rowposition;

	gcds_dtl_insert.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");
	gcds_dtl_insert.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");
	gcds_dtl_insert.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");
	gcds_dtl_insert.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ");
	gcds_dtl_insert.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");

	gcds_dtl_insert.namevalue(row,"ATDECR")="2";  //���ν������� ������
	gcds_dtl_insert.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");
	gcds_dtl_insert.namevalue(row,"DAEAMT")=gcds_dtl.namevalue(k,"DAEAMT");
	gcds_dtl_insert.namevalue(row,"DOCUMCD")=gcds_dtl.namevalue(k,"DOCUMCD");

	gcds_dtl_insert.namevalue(row,"FSWRKDIV")=gcds_dtl.namevalue(k,"FSWRKDIV");
	gcds_dtl_insert.namevalue(row,"REMARK")=gcds_dtl.namevalue(k,"REMARK");

	//alert("hid_atdeptyn:"+gcds_dtl.namevalue(k,"BANJAEYN")+"hid_atdecr:"+gcds_dtl.namevalue(k,"ATDECR")+"gcem_detot02"+gcds_dtl.namevalue(k,"CHAAMT")+"gcem_crtot02"+gcds_dtl.namevalue(k,"DAEAMT"));
	strBanjae = ln_Banjae_yn(gcds_dtl.namevalue(k,"BANJAEYN"),gcds_dtl.namevalue(k,"ATDECR"),gcds_dtl.namevalue(k,"CHAAMT"),gcds_dtl.namevalue(k,"DAEAMT"));
	
	gcds_dtl_insert.namevalue(row,"BANJAEYN")=strBanjae;
	gcds_dtl_insert.namevalue(row,"DOCUVAL")=gcds_dtl.namevalue(k,"DOCUVAL");
	gcds_dtl_insert.namevalue(row,"FSNUM")=gcds_dtl.namevalue(k,"FSNUM");
	gcds_dtl_insert.namevalue(row,"DIVCD")=gcds_dtl.namevalue(k,"DIVCD");
	gcds_dtl_insert.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");

  	for(i=1;i<=9;i++){
		gcds_dtl_insert.namevalue(row,"FSREFSEQ0"+i)=gcds_dtl.namevalue(k,"FSREFSEQ0"+i);
		gcds_dtl_insert.namevalue(row,"FSREFCD0"+i)=gcds_dtl.namevalue(k,"FSREFCD0"+i);
		gcds_dtl_insert.namevalue(row,"FSREFVAL0"+i)=gcds_dtl.namevalue(k,"FSREFVAL0"+i);
	}
	
	gcds_dtl_insert.namevalue(row,"WRDT")=gs_date;
	gcds_dtl_insert.namevalue(row,"WRID")=gusrid;
	gcds_dtl_insert.namevalue(row,"UPDT")=gs_date;
	gcds_dtl_insert.namevalue(row,"UPID")=gusrid;

}

/******************************************************************************
	Description : ��ǥ Dtl DATA UPDATE 
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Update(){
	
	ln_SetDataHeader("DTL_UPDATE"); 
	gcds_dtl_update.Addrow();
	var row = gcds_dtl_update.rowposition;
	gcds_dtl_update.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");
	gcds_dtl_update.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");
	gcds_dtl_update.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");
	gcds_dtl_update.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");
	gcds_dtl_update.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");

	gcds_dtl_update.namevalue(row,"ATDECR")="2"; //���ν������� ������
	gcds_dtl_update.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");
	gcds_dtl_update.namevalue(row,"DAEAMT")=gcds_dtl.namevalue(k,"DAEAMT");
	gcds_dtl_update.namevalue(row,"DOCUMCD")=gcds_dtl.namevalue(k,"DOCUMCD");
	gcds_dtl_update.namevalue(row,"FSWRKDIV")=gcds_dtl.namevalue(k,"FSWRKDIV");
	gcds_dtl_update.namevalue(row,"REMARK")=gcds_dtl.namevalue(k,"REMARK");
	gcds_dtl_update.namevalue(row,"DOCUVAL")=gcds_dtl.namevalue(k,"DOCUVAL");
	
	//alert("k::"+k+"::"+gcds_dtl.namevalue(k,"FSNUM"));
	gcds_dtl_update.namevalue(row,"FSNUM")=gcds_dtl.namevalue(k,"FSNUM");
	gcds_dtl_update.namevalue(row,"DIVCD")=gcds_dtl.namevalue(k,"DIVCD");
	gcds_dtl_update.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");
	gcds_dtl_update.namevalue(row,"BANJAEYN")=gcds_dtl.namevalue(k,"BANJAEYN");

  	for(i=1;i<=9;i++){
		gcds_dtl_update.namevalue(row,"FSREFSEQ0"+i)=gcds_dtl.namevalue(k,"FSREFSEQ0"+i);
		gcds_dtl_update.namevalue(row,"FSREFCD0"+i)=gcds_dtl.namevalue(k,"FSREFCD0"+i);
		gcds_dtl_update.namevalue(row,"FSREFVAL0"+i)=gcds_dtl.namevalue(k,"FSREFVAL0"+i);
	}

	gcds_dtl_update.namevalue(row,"WRDT")=gs_date;
	gcds_dtl_update.namevalue(row,"WRID")=gs_userid;
	gcds_dtl_update.namevalue(row,"UPDT")=gs_date;
	gcds_dtl_update.namevalue(row,"UPID")=gs_userid;

}

/******************************************************************************
	Description : ��ǥ Dtl DATA Delete
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Delete(k){
  //������ ���� ������ ��� ���� ����. 
	ln_SetDataHeader("DTL_DEL"); 
	gcds_dtl_del.Addrow();
	var row = gcds_dtl_del.rowposition;
	//alert("gcds_del01.rowposition::"+gcds_del01.rowposition);
	gcds_dtl_del.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");
	gcds_dtl_del.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");
	gcds_dtl_del.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");
	gcds_dtl_del.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ"); 
}


/******************************************************************************
	Description : ��ǥ ���� �ű� ���
	parameter   :
******************************************************************************/
function ln_Data_Bgt_Insert(k,strcocode){
	
  //üũ
	//������ �̸鼭 ����μ��� �����ϴ� ���.
  //��������׸�

	var no1 ="";
	var no2 ="";
  	if(gcds_dtl.namevalue(k,"FSWRKDIV")=="02"){ //��������
	  
		no1 = ln_Bgt_DataSet_Dept_find(k);
		no2 = ln_Bgt_DataSet_Type_find(k);

		if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)){

			ln_SetDataHeader("BGT_INSERT");
			gcds_bgt_insert.Addrow();
			var stractdt = gcem_actdat02.text;
			var row = gcds_bgt_insert.rowposition
			gcds_bgt_insert.namevalue(row,"BGTYY")=stractdt.substring(0,4);           //����⵵
			gcds_bgt_insert.namevalue(row,"BGTMM")=stractdt.substring(4,6);           //�����  
			gcds_bgt_insert.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");   //���꺻��
			
			gcds_bgt_insert.namevalue(row,"BGTDPT")=gcds_dtl.namevalue(k,"FSREFVAL"+no1); //����μ�         
			gcds_bgt_insert.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");       //��������         
			gcds_bgt_insert.namevalue(row,"FSREFCD")=gcds_dtl.namevalue(k,"FSREFCD"+no2); //���� �����׸��ڵ�     

			//����μ��� ��������׸��� ��� ������ 00�� ����
			if(gcds_dtl.namevalue(k,"FSREFCD"+no2)=="0003"){
				gcds_bgt_insert.namevalue(row,"SATCODE")="00";	 //����  
			}else{
				gcds_bgt_insert.namevalue(row,"SATCODE")=gcds_dtl.namevalue(k,"FSREFVAL"+no2); //����  
			}

			gcds_bgt_insert.namevalue(row,"BGTMACT")=gcds_dtl.namevalue(k,"FSWRKDIV");   //����Ÿ��  
			gcds_bgt_insert.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");      //�ݾ�          

			//�����Ѱ������� (�̽��� ������)
			gcds_bgt_insert.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");  
			gcds_bgt_insert.namevalue(row,"ACTDAT")=gcem_actdat02.text;   
			gcds_bgt_insert.namevalue(row,"COCODE")=ln_Cocode(strcocode); 
			gcds_bgt_insert.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");   
			gcds_bgt_insert.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");   
			gcds_bgt_insert.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ"); 

			//��������׸���� (�̽��� ������)
			//���� �� ��������׸���� (�̽��� ������)
			for(j=1;j<=9;j++){
				gcds_bgt_insert.namevalue(row,"FSREFCD0"+j)=gcds_dtl.namevalue(k,"FSREFCD0"+j);
				gcds_bgt_insert.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.namevalue(k,"FSREFVAL0"+j);
			}
		}
	}
}

/******************************************************************************
	Description : ��ǥ ���� ���� 
	ref         : 1.����μ��� ����� ���
	              2.����μ��� ����, ������ ����� ���
								3.����μ�, ������ ����, �ݾ��� Ʋ�� ��� 
								���� ���� ���� �ݾ��� �ش� ���꿡�� �����ְ�, 
								���ο� �ݾ��� Insert/Update ��.
	parameter   : k - gcds_dtl�� rowposition
******************************************************************************/
function ln_Data_Bgt_Update(k){

  //����μ��� �����ϸ� addrow();
	var no3 =ln_Bf_Bgt_DataSet_Dept_find(k);   //���� �� ����μ� ��ġã��
	var no4 =ln_Bf_Bgt_DataSet_Type_find(k);   //���� ������ġ ã��

	var no1 =ln_Bgt_DataSet_Dept_find(k);      //���� �� ����μ� ��ġã��
	var no2 =ln_Bgt_DataSet_Type_find(k);      //���� �� ������ġ ã��

	if(((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined))||((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined))){
		//MST�� ���� ==>DETAIL�� ������ ����
		if(gcds_bgt_update.countrow<=0){
			ln_SetDataHeader("BGT_UPDATE");
		}
		gcds_bgt_update.Addrow();
		var stractdt2 = gcem_actdat02.text;
		var row = gcds_bgt_update.rowposition
		
		//������
		if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)&&gcds_dtl.namevalue(k,"FSWRKDIV")=="02"){
			gcds_bgt_update.namevalue(row,"BGTYY")=stractdt2.substring(0,4);              //����⵵
			gcds_bgt_update.namevalue(row,"BGTMM")=stractdt2.substring(4,6);              //�����  
			gcds_bgt_update.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");       //���꺻��         
			gcds_bgt_update.namevalue(row,"BGTDPT")=gcds_dtl.namevalue(k,"FSREFVAL"+no1); //����μ�         
			gcds_bgt_update.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");       //��������         
			gcds_bgt_update.namevalue(row,"FSREFCD")=gcds_dtl.namevalue(k,"FSREFCD"+no2); //�����׸��ڵ�
				
			//����μ��� ��������׸��� ��� ������ 00�� ����
			if(gcds_dtl.namevalue(k,"FSREFCD"+no2)=="0003"){
				gcds_bgt_update.namevalue(row,"SATCODE")="00";	 //����  
			}else{
				gcds_bgt_update.namevalue(row,"SATCODE")=gcds_dtl.namevalue(k,"FSREFVAL"+no2); //����    
			}
			
			gcds_bgt_update.namevalue(row,"BGTMACT")=gcds_dtl.namevalue(k,"FSWRKDIV");   //����Ÿ��  
			gcds_bgt_update.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");      //�ݾ�          

			//�����Ѱ������� (�̽��� ������)
			gcds_bgt_update.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");  
			gcds_bgt_update.namevalue(row,"ACTDAT")=gcem_actdat02.text;   
			gcds_bgt_update.namevalue(row,"COCODE")=ln_Cocode('');
			gcds_bgt_update.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");    
			gcds_bgt_update.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");  
			gcds_bgt_update.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ");  

			//���� �� ��������׸���� (�̽��� ������)
			for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"FSREFCD0"+j)=gcds_dtl.namevalue(k,"FSREFCD0"+j);
				gcds_bgt_update.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.namevalue(k,"FSREFVAL0"+j);
			}
		}else{
			gcds_bgt_update.namevalue(row,"BGTYY")="";    //����⵵
			gcds_bgt_update.namevalue(row,"BGTMM")="";    //�����  
			gcds_bgt_update.namevalue(row,"BGTDIV")="";	  //���꺻��         
			gcds_bgt_update.namevalue(row,"BGTDPT")="";	  //����μ�         
			gcds_bgt_update.namevalue(row,"ATCODE")="";	  //��������         
			gcds_bgt_update.namevalue(row,"FSREFCD")="";	//�����׸��ڵ�     
			gcds_bgt_update.namevalue(row,"SATCODE")="";	//����   
			gcds_bgt_update.namevalue(row,"BGTMACT")="";	//����Ÿ�� 
			gcds_bgt_update.namevalue(row,"CHAAMT")=""; 	//�ݾ�   

			//���� �� ��������׸���� (�̽��� ������)
     		for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"FSREFCD0"+j)="";
				gcds_bgt_update.namevalue(row,"FSREFVAL0"+j)="";
			}
		}
		
		//������
		var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
		if((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined)&&gcds_dtl.OrgNameValue(k,"FSWRKDIV")=="02"){
			gcds_bgt_update.namevalue(row,"BBGTYY")=stractdt3.substring(0,4);                   //����������⵵
			gcds_bgt_update.namevalue(row,"BBGTMM")=stractdt3.substring(4,6);                   //�����������  
			gcds_bgt_update.namevalue(row,"BBGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");         //���������꺻��  
			gcds_bgt_update.namevalue(row,"BBGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no3);   //����������μ�  
			gcds_bgt_update.namevalue(row,"BATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");         //��������������  
			gcds_bgt_update.namevalue(row,"BFSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no4);   //�����������׸��ڵ�  

			//����μ��� ��������׸��� ��� ������ 00�� ����
			if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no4)=="0003"){
				gcds_bgt_update.namevalue(row,"BSATCODE")="00";	 //����  
			}else{
				gcds_bgt_update.namevalue(row,"BSATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no4);    //����������
			}
			
			gcds_bgt_update.namevalue(row,"BBGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");	       //����������Ÿ�� 
			gcds_bgt_update.namevalue(row,"BCHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");            //�������ݾ�  
			gcds_bgt_update.namevalue(row,"BACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT"); //������ ȸ������  

			//�����Ѱ������� (�̽��� ������)
			gcds_bgt_update.namevalue(row,"BFDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");  
			gcds_bgt_update.namevalue(row,"BCOCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE"));
			gcds_bgt_update.namevalue(row,"BFSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");      
			gcds_bgt_update.namevalue(row,"BFSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");    
			gcds_bgt_update.namevalue(row,"BFSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  
			//alert("parent.hid_cocode02.value; "+parent.hid_cocode02.value);

			//���� �� ��������׸���� (�̽��� ������)
      		for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"BFSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
				gcds_bgt_update.namevalue(row,"BFSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
			}
		}else{
			gcds_bgt_update.namevalue(row,"BBGTYY")="";       //����������⵵
			gcds_bgt_update.namevalue(row,"BBGTMM")="";       //�����������  
			gcds_bgt_update.namevalue(row,"BBGTDIV")="";      //���������꺻��  
			gcds_bgt_update.namevalue(row,"BBGTDPT")="";      //����������μ�  
			gcds_bgt_update.namevalue(row,"BATCODE")="";      //��������������  
			gcds_bgt_update.namevalue(row,"BFSREFCD")="";     //�����������׸��ڵ�  
			gcds_bgt_update.namevalue(row,"BSATCODE")="";     //����������
			gcds_bgt_update.namevalue(row,"BBGTMACT")="";	    //����������Ÿ�� 
			gcds_bgt_update.namevalue(row,"BCHAAMT")="";      //�������ݾ�  
			gcds_bgt_update.namevalue(row,"BACTDAT")="";      //������ ȸ������  

			//�����Ѱ������� (�̽��� ������)
			gcds_bgt_update.namevalue(row,"BFDCODE")="";  
			gcds_bgt_update.namevalue(row,"BACTDAT")="";   
			gcds_bgt_update.namevalue(row,"BCOCODE")="";
			gcds_bgt_update.namevalue(row,"BFSDAT")="";   
			gcds_bgt_update.namevalue(row,"BFSNBR")="";   
			gcds_bgt_update.namevalue(row,"BFSSEQ")=""; 

			//���� �� ��������׸���� (�̽��� ������)
			for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"BFSREFCD0"+j)="";
				gcds_bgt_update.namevalue(row,"BFSREFVAL0"+j)="";
			}
		}
	}
}

/******************************************************************************
	Description : ��ǥ ���� ����
	parameter   :
******************************************************************************/
function ln_Data_Bgt_Delete(k){

 //����μ��� �����ϸ� addrow();
	var no3 =ln_Bf_Bgt_DataSet_Dept_find(k);   //���� �� ����μ� ��ġã��
	var no4 =ln_Bf_Bgt_DataSet_Type_find(k);   //���� ������ġ ã��

	if((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined)&&gcds_dtl.OrgNameValue(k,"FSWRKDIV")=="02"){
		//MST�� ���� ==>DETAIL�� ������ ����
		if(gcds_bgt_del.countrow<=0){
			ln_SetDataHeader("BGT_DEL");
		}
		gcds_bgt_del.Addrow();
		var row = gcds_bgt_del.rowposition
		var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
		gcds_bgt_del.namevalue(row,"BGTYY")=stractdt3.substring(0,4);          //����������⵵
		gcds_bgt_del.namevalue(row,"BGTMM")=stractdt3.substring(4,6);          //�����������  
		gcds_bgt_del.namevalue(row,"BGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");          //���������꺻��  
		gcds_bgt_del.namevalue(row,"BGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no3);    //����������μ�  
		gcds_bgt_del.namevalue(row,"ATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");          //��������������  
		gcds_bgt_del.namevalue(row,"FSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no4);    //�����������׸��ڵ� 
		 
		//����μ��� ��������׸��� ��� ������ 00�� ����
		if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no4)=="0003"){
			gcds_bgt_del.namevalue(row,"SATCODE")="00";	 //����  
		}else{
			gcds_bgt_del.namevalue(row,"SATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no4);     //����������
		}
		
		gcds_bgt_del.namevalue(row,"BGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");	        //����������Ÿ�� 
		gcds_bgt_del.namevalue(row,"CHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");             //�������ݾ�  
		gcds_bgt_del.namevalue(row,"ACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");         //������ ȸ������  

		//�����Ѱ������� (�̽��� ������)
		gcds_bgt_del.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");   
		gcds_bgt_del.namevalue(row,"COCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE"));
		gcds_bgt_del.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");      
		gcds_bgt_del.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");    
		gcds_bgt_del.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  

		//���� �� ��������׸���� (�̽��� ������)
		//��������׸����
		
		for(j=1;j<=9;j++){
			gcds_bgt_del.namevalue(row,"FSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
			gcds_bgt_del.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
		}
	}
}


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ��ü��ǥ���� �Լ� (Start :::::::::::::::::::::::  >>>>>>>>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : ��� - ��ü��ǥ
	parameter   : �����ڵ�, ������, �μ���, ������ȣ, ȸ������, �ۼ�����
	����        : �����ڵ�, ������ȣ
******************************************************************************/
function ln_Print(){
  	var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	gcds_print.ClearAll();
	gcds_prttemp1.ClearAll();
	gcds_prttemp2.ClearAll();

	ln_PrtSetDataHeader();
	///////////////ln_PrintQuery(p1,p2,p3);	//��ü��ǥ REPORT��ȸ ==>20061012 ����
	ln_PrintSubQuery()
}

/******************************************************************************
	Description : ��ȸ - ���(head)
  Parameter   : p1-fdcode, p2-fsdat, p3-fsnbr 
	              ������.
******************************************************************************/
/*
function ln_PrintQuery(p1,p2,p3){
	gcds_prttemp1.DataID = "/services/servlet/Account.a020001_s15?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;
	//prompt("",gcds_prttemp1.DataID);
	gcds_prttemp1.Reset();
}
*/

/******************************************************************************
	Description : ��ȸ - ���(detail)
  Parameter   : 
******************************************************************************/
function ln_PrintSubQuery(){
	var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	gcds_prttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s16?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;
	
	//prompt("",gcds_prttemp2.DataID);
	gcds_prttemp2.Reset(); 
}

/******************************************************************************
	Description : ��ȸ - ���(detail)
  Parameter   : p1-fdcode, p2-fsdat, p3-fsnbr 
******************************************************************************/
function ln_PrintSubQuery2(){
  /*==========================================================================*/
	var fdcd01 = gclx_fdcode02.bindcolval;														    //�����ڵ�
	var fdcd02 = gclx_fdcode02.text;																	    //������
	var dept03 = fn_trim(txt_deptnm02.value);													    //�μ�
	var fsnb04 = gcem_fs02.text+gcem_fsdat02.text+"-"+gcem_fsnbr02.text;	//������ȣ
	var arrfsnb = new Array();
	var strgubun=""; //A - ���� ���� ����
  	arrfsnb = fsnb04.split("-");

	if(gcds_data01_2.namevalue(1,"ACTDAT")==undefined){
		var cudt05 = gcds_data01_1.namevalue(1,"ACTDAT");					//ȸ������
	}else{
		var cudt05 = gcds_data01_2.namevalue(1,"ACTDAT");					//ȸ������
	}

	if (gcds_data01_2.namevalue(1,"ACTDAT")==undefined){
		var cudt06 = gcds_data01_1.namevalue(1,"FSWRTDAT");				//�ۼ�����
	}else{
		var cudt06 = gcds_data01_2.namevalue(1,"FSWRTDAT");				//�ۼ�����
	}
	  /*==========================================================================*/
  //alert("���0");
	var cnt = gcds_prttemp2.countrow;
	for(i=1;i<=gcds_prttemp2.countrow;i++){

		gcds_print.ImportData(gcds_prttemp2.ExportData(i,1,false));

    	if(gcds_prttemp2.namevalue(i,"ATCODE")=="1110110"||gcds_prttemp2.namevalue(i,"ATCODE")=="1110120"||gcds_prttemp2.namevalue(i,"ATCODE")=="1110130"){
			strgubun="A";
		}
		
		gcds_print.namevalue(1,"DATA01") = "ȸ����� : "+fdcd01+" "+fdcd02+"����";	//����
		//2011.09.08 ����
		//gcds_print.namevalue(1,"DATA02") = "����μ� : "+dept03;										//�μ�
		gcds_print.namevalue(1,"DATA02") = "���μ� : "+dept03;										//�μ�									//�μ�
		
		/*
		if (gcds_prttemp1.namevalue(1,"COST") != null && gcds_prttemp1.namevalue(1,"COST") != "" ) {
			sv_cost = gcds_prttemp1.namevalue(1,"COST");
		}else{
			sv_cost = gcds_prttemp1.namevalue(1,"DEPTNM3");
		}
		*/
		sv_cost = gcds_prttemp2.namevalue(1,"DEPTNM");
		var s_ssnbr = gcds_print.namevalue(1,"SSNBR");
		//2011.09.08 ����
		//gcds_print.namevalue(1,"DATA03") = "�� �� �� : "+sv_cost;	  //�μ�
		gcds_print.namevalue(1,"DATA03") = "�� �� �� : "+fn_trim(txt_empnmk02.value);	  //�ۼ��ڼ���
		
		gcds_print.namevalue(1,"DATA04") = s_ssnbr;		                  //��ǥ��ȣ
		gcds_print.namevalue(1,"DATA05") = "�Է����� : "+fsnb04.substring(1,16);		//�Է�����
		
		if(gcds_print.namevalue(1,"FSSTAT") == 'Y'){	//��ǥ�Ϸ�
			gcds_print.namevalue(1,"CURDT")	 = cudt05;	//ȸ������
		}else{
			gcds_print.namevalue(1,"CURDT")	 = "        ";	//ȸ������
		}
		gcds_print.namevalue(1,"CURDT2")="";		//�ۼ�����
	}

	if(strgubun=="A"){
		gcds_print.namevalue(1,"PTITLE")="�� (��) ��  ��  ǥ";
	}else{
    	gcds_print.namevalue(1,"PTITLE")="��   ü   ��   ǥ";
	}

  //alert("���1");
	for(j=1;j<=gcds_print.countrow;j++){
		var s_leng1 = gcds_print.namevalue(j,"FOCHAAMT").length;
		var s_leng2 = gcds_print.namevalue(j,"FODAEAMT").length;

    
		if(s_leng1>0){
		  gcds_print.namevalue(j,"FOCHAAMT")= gcds_print.namevalue(j,"FOCHAAMT").substring(0,1)
																				+ gf_setnum2(gcds_print.namevalue(j,"FOCHAAMT").substring(1,s_leng1));
		}else if(s_leng2>0){
			gcds_print.namevalue(j,"FODAEAMT")= gcds_print.namevalue(j,"FODAEAMT").substring(0,1)
																				+ gf_setnum2(gcds_print.namevalue(j,"FODAEAMT").substring(1,s_leng2));
		}
	}

 
	if(fdcd01!="03"){
		gcds_print.namevalue(1,"CHASUM") = "��"+gf_setnum2(gcds_prttemp2.Sum(10,0,cnt));
		gcds_print.namevalue(1,"DAESUM") = "��"+gf_setnum2(gcds_prttemp2.Sum(11,0,cnt));
	}else{
		gcds_print.namevalue(1,"CHASUM") = "��"+gf_setnum2(gcds_prttemp2.Sum(10,0,cnt));
		gcds_print.namevalue(1,"DAESUM") = "��"+gf_setnum2(gcds_prttemp2.Sum(11,0,cnt));
	}	

  	if(fdcd01=="03"){ //�ݰ���
    	gcds_print.namevalue(1,"C1")="��  ��";
		gcds_print.namevalue(1,"C2")="�Ѽ���";
		gcds_print.namevalue(1,"C3")="";
		gcds_print.namevalue(1,"C4")="�����";
		gcds_print.namevalue(1,"C5")="������";
	}else if(fdcd01=="04"){ //����
    	gcds_print.namevalue(1,"C1")="��(��)��";
		gcds_print.namevalue(1,"C2")="�Ѽ���";
		gcds_print.namevalue(1,"C3")="";
		gcds_print.namevalue(1,"C4")="����";
		gcds_print.namevalue(1,"C5")="������";
	}else{ //����, ���� (02, 01)
    	//gcds_print.namevalue(1,"C1")="�μ���";
    	gcds_print.namevalue(1,"C1")="��  ��";
		//gcds_print.namevalue(1,"C2")="��  ��";
		gcds_print.namevalue(1,"C2")="��  ��";
		gcds_print.namevalue(1,"C3")="������";
		//gcds_print.namevalue(1,"C4")="����";
		gcds_print.namevalue(1,"C4")="�����";
		//gcds_print.namevalue(1,"C5")="�渮��";
		//gcds_print.namevalue(1,"C5")="���������";
		gcds_print.namevalue(1,"C5")="�濵������";
	}
  	
  	//������°� ���� ���/�ݼ��� ���   2014.10.07 jys   	
  	if(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSSTAT")=="N"){
  		gcds_print.namevalue(1,"C6")="���� ���� ����� �Դϴ�. ���� ���� ��û �ٶ��ϴ�."; 
  	}else if (gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSSTAT")=="B"){
  		gcds_print.namevalue(1,"C6")="���� ���� �ݼ��� �Դϴ�. ���� ���� ��û �ٶ��ϴ�."; 
  	}else{
  		
  		//2020.05.13
  		gcds_print.namevalue(1,"C6")="";
  		//2018.04.11. �̻�� ��鼭 ����. ��󹫴� ��û��
  		if(gs_userid=="2020013"||gs_userid=="2040046"||gs_userid=="2080031"||gs_userid=="2110014"||gs_userid=="2130002"||gs_userid=="2190020"||gs_userid=="2080012"){
  			gcds_print.namevalue(1,"C7")="����";
  		}
  	}
  	
	gcrp_print.preview();

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ��ü��ǥ���� �Լ� (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : �ڵ� �۾�
******************************************************************************/
function ln_Before() {

  	//��������
	gcds_comfield02.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield02.Reset();


    //�����ڵ�
	gcds_documcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0052"
	//prompt("",gcds_documcd.DataID);
	gcds_documcd.Reset();
	
	
	//�ܻ���Ա� �Ϲݾ�ü üũ 2015.03.05
	gcds_chk1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2230&v_str2="+gs_userid;
	gcds_chk1.Reset();
	
	if(gcds_chk1.countrow>0){
		sp1.style.display = ""; //����
	}else{
		sp1.style.display = "none"; //����
	}

}


/******************************************************************************
	Description : ����� üũ�ڽ��� ��ȯ
	prameter : 
******************************************************************************/
function ln_Chkbox(){

}

/******************************************************************************
	Description : �����ڵ� ã��
	parameter   : p1 - ����,  01-��ǥ�ϰ� ����(���� ==> ��ǥ)
	                          02-����
														03-�����׸� ==>������� ������ ����
														09-��ǥ����
	              p2 - Data, row - grid�� rowposition
******************************************************************************/
function ln_Popup(p1,p2,row){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if ((p1=="01")) {
		strURL = "./commiface_popup.jsp";
		arrParam[0]="";
		strPos = "dialogWidth:878px;dialogHeight:490px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if(result != null){
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];

		}else{
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}

	}else if (p1=="02"){
		

		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN" 
		arrParam[1]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];
		} else {
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}
		
	
	}else if(p1=="03"){
	  /*****
		strURL = "./Slipref_popup.html";
		arrParam[0]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data04.namevalue(row,"FSREFVAL")=arrResult[0];
			gcds_data04.namevalue(row,"FSREFVALNM")=arrResult[1];
		} else {
			gcds_data04.namevalue(row,"FSREFVAL")="";
			gcds_data04.namevalue(row,"FSREFVALNM")="";
		}
		****/
	}else if (p1=="09"){
    	if(gcem_fsnbr02.text=="000000") return;

		strURL = "./slipno_loca_popup.jsp";    
		if(gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE")!=undefined){
			arrParam[0]=gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE"); 
			arrParam[1]=gcds_data01.namevalue(gcds_data01.rowposition,"FSDAT"); 
			arrParam[2]=gcds_data01.namevalue(gcds_data01.rowposition,"FSNBR"); 	
		}else{
			arrParam[0]=gclx_fdcode02.bindcolval; 
			arrParam[1]=gcem_fs02.text+gcem_fsdat02.text; 
			arrParam[2]=gcem_fsnbr02.text; 	
		}

		strPos = "dialogWidth:800px;dialogHeight:425px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
   	/*
		if (result != null) {
		 
		  arrResult = result.split(";");
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FDCODE")=arrResult[0];		
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSDAT")=arrResult[1];
		  gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSNBR")=arrResult[2];

		} else {
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FDCODE")="";	
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSDAT")="";
		  gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSNBR")="";	   
		}
    */

	}
}

/******************************************************************************
	Description : ���� �˾�
	parameter   : 
******************************************************************************/
function ln_Popup_Confirm(){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (gclx_fsstat02.bindcolval!="B"&&gclx_fsstat02.bindcolval!="N"){ //Y-����Ϸ�,C-�������, N-������, R-�����û, B-�ݼ�
		alert("��ǥ���°� �����û �� �� �����ϴ�.");
		return;
	}

	if(!ln_Chk_Confirm()){ //�����û üũ
		alert("��ǥ���°� �����û �� �� �����ϴ�.");
		return;
	}

	strURL = "./confirm_popup_new.jsp";
	strPos = "dialogWidth:330px;dialogHeight:180px;status:no;scroll:no;resizable:no";

	result = showModalDialog(strURL,window,strPos);
	//return result;
	if (result != null) {
		arrResult = result.split(";");
		gcds_confirm.ClearData();
		if (arrResult[1]= "Y" ){ //���������
			ln_Confirm_Save(arrResult[0],arrResult[3],arrResult[4]); //������, ȸ��(����)���� 01 ȸ��, 02����, 03 �ڱ� ,  Y -ȸ������ ����
		}
	}
}

/******************************************************************************
	Description : ����� ����
	parameter   :  p - ������ ���
	               p1 - ȸ��/ ���� / �ڱ�  ���� 01/02/03   
								 p2 - ȸ������ ����� ��ǥ��Ͽ��� ��(Y)
******************************************************************************/
function ln_Confirm_Save(p,p1,p2){
    //alert("p:"+p+":p1:"+p1+":p2::"+p2)
		var row1 = gcds_data01.rowposition;
		var row2 = gcds_data01_2.rowposition;
		var strfdcode="";
		var strfsdat="";
		var strfsnbr="";
		var strempno="";
    	var strtogb="";

		if (p1=="01"){        //ȸ��
			strtogb="03";       //�����ϰ��� 02 �� �����ؾ���.
    	}else if(p1=="02"){   //����
      		strtogb="02";
		}else if(p1=="03"){   //�ڱ�
      		strtogb="06";
		}

		ln_SetDataHeader("CONFIRM");

		//alert("strtogb"+strtogb);

    	if((gcds_data01_2.namevalue(row2,"FDCODE"))==""||(gcds_data01_2.namevalue(row2,"FDCODE"))==undefined){
			strfdcode = gcds_data01.namevalue(row1,"FDCODE");
		}else{
			strfdcode = gcds_data01_2.namevalue(row2,"FDCODE");
		}

		if(gcds_data01_2.namevalue(row2,"FSDAT")==""||gcds_data01_2.namevalue(row2,"FSDAT")==undefined){
			strfsdat = gcds_dtl.namevalue(1,"FSDAT");
		}else{
			strfsdat = gcds_data01_2.namevalue(row2,"FSDAT");
		}

		if(gcds_data01_2.namevalue(row2,"FSNBR")==""||gcds_data01_2.namevalue(row2,"FSNBR")==undefined){
			strfsnbr = gcds_data01.namevalue(row1,"FSNBR");
		}else{
			strfsnbr = gcds_data01_2.namevalue(row2,"FSNBR");
		}

		if(gcds_data01_2.namevalue(row2,"EMPNO")==""||gcds_data01_2.namevalue(row2,"EMPNO")==undefined){
			strempno = txt_empno02.value;
		}else{
			strempno = gcds_data01_2.namevalue(row2,"EMPNO");
		}

    	gcds_confirm.addrow();
    	gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=strfdcode; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=strfsdat;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=strfsnbr;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //������
		gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= strempno;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="01"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =strtogb; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB")=p2; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

		if (confirm("�����û �Ͻðڽ��ϱ�?")){	
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_confirm.text);
			gctr_data06.post();
    	}
}

/******************************************************************************
	Description : Dataset Head ���� - ��ǥ Detail
  parameter   : p - dataset ����
	              02 : ��ǥ Detail ���̺�
                 05 : �����׸� ���̺�
                  01_1 : ��ǥ Master ���̺�
								02_2 : ��ǥ ���� ���̺�(��ǥ��Ͻ� ���)
								key : ȸ����ǥ��ȣ
******************************************************************************/
function ln_SetDataHeader(p){
   
	if(p=="02"){
		if (gcds_data02.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,CHAAMT:DECIAML,"
								 + "ATCODE:STRING,ATKORNAM:STRING,DAEAMT:DECIAML,ATDECR:STRING,REMARK:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data02.SetDataHeader(s_temp);
		}

	}else if(p=="05"){
		if (gcds_data04.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,FSREFSEQ:STRING,"
								 + "FSREFCD:STRING,FSREFVAL:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data04.SetDataHeader(s_temp);
		}
	}else if(p=="01_1"){
		if (gcds_data01_1.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSDAT1:STRING,FSDAT2:STRING,FSNBR:STRING,FSKND:STRING,"
			           + "FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,DEPTNM:STRING,EMPNO:STRING,EMPNMK:STRING,DIVCD:STRING,"
								 + "FSAMT:DECIMAL,FSVAT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,"
								 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,DIVNM:STRING,SSDAT:STRING,SSNBR:STRING,SSDAT1:STRING,SSDAT2:STRING ";

			gcds_data01_1.SetDataHeader(s_temp);
		}
  }else if(p=="01_2"){
		if (gcds_data01_2.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSDAT1:STRING,FSDAT2:STRING,FSNBR:STRING,FSKND:STRING,"
			           + "FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,DEPTNM:STRING,EMPNO:STRING,EMPNMK:STRING,DIVCD:STRING,"
								 + "FSAMT:DECIMAL,FSVAT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,"
								 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,DIVNM:STRING,SSDAT:STRING,SSNBR:STRING,SSDAT1:STRING,SSDAT2:STRING ";

			gcds_data01_2.SetDataHeader(s_temp);
		}
  }else if(p=="CONFIRM"){
		if (gcds_confirm.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,EMPNO:STRING,"
								 + "ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,BIGO:STRING,BGTGB:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_confirm.SetDataHeader(s_temp);
		}

  }else if(p=="MST"){
	  if (gcds_mst.countrow<1){  
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
										 + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
										 + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
										 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_mst.SetDataHeader(s_temp);
		}
  }else if(p=="DTL"){
		if (gcds_dtl.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
								 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
								 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
								 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
								 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
								 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
								 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
								 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
								 + "TYPE01:STRING,TYPE02:STRING,TYPE03:STRING,TYPE04:STRING,TYPE05:STRING,"
								 + "TYPE06:STRING,TYPE07:STRING,TYPE08:STRING,TYPE09:STRING,"
								 + "ARBALDIV01:STRING,ARBALDIV02:STRING,ARBALDIV03:STRING,ARBALDIV04:STRING,ARBALDIV05:STRING,"
								 + "ARBALDIV06:STRING,ARBALDIV07:STRING,ARBALDIV08:STRING,ARBALDIV09:STRING,"
								 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
								 + "BANJAEYN:STRING,FSSTAT:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,"
								 + "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING,CREDGB:STRING";
			gcds_dtl.SetDataHeader(s_temp);
		}
	}else if(p=="DTL_INSERT"){
	  if (gcds_dtl_insert.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
										 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
										 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
										 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
										 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
										 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
										 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
										 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
										 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
										 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
										 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
										 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
										 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
										 + "BANJAEYN:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,BGTDIV:STRING ";
			gcds_dtl_insert.SetDataHeader(s_temp);
		}
	}else if(p=="DTL_UPDATE"){
		if (gcds_dtl_update.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
										 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
										 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
										 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
										 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
										 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
										 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
										 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
										 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
										 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
										 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
										 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
										 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
										 + "BANJAEYN:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,BGTDIV:STRING ";								
			gcds_dtl_update.SetDataHeader(s_temp);
		}
  }else if(p=="DTL_DEL"){
		if (gcds_dtl_del.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING";               
			gcds_dtl_del.SetDataHeader(s_temp);
		}
  }else if(p=="MST_DEL"){
		if (gcds_del02.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSKND:STRING";
			gcds_del02.SetDataHeader(s_temp);
		}
  }else if (p=="BGT_INSERT"){
	  if (gcds_bgt_insert.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL, "
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING, " 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING";
			gcds_bgt_insert.SetDataHeader(s_temp);
		}
	}else if (p=="BGT_UPDATE"){
		if (gcds_bgt_update.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "BBGTYY:STRING,BBGTMM:STRING,BBGTDIV:STRING,BBGTDPT:STRING,BATCODE:STRING,"
								 + "BFSREFCD:STRING,BSATCODE:STRING,BBGTMACT:STRING,BCHAAMT:DECIMAL,"
								 + "BACTDAT:STRING,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING, " 
								 + "BFDCODE:STRING,BCOCODE:STRING,BFSDAT:STRING,BFSNBR:STRING,BFSSEQ:STRING, " 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
								 + "BFSREFCD01:STRING,BFSREFCD02:STRING,BFSREFCD03:STRING,BFSREFCD04:STRING,BFSREFCD05:STRING,"
								 + "BFSREFCD06:STRING,BFSREFCD07:STRING,BFSREFCD08:STRING,BFSREFCD09:STRING,"
								 + "BFSREFVAL01:STRING,BFSREFVAL02:STRING,BFSREFVAL03:STRING,BFSREFVAL04:STRING,BFSREFVAL05:STRING,"
								 + "BFSREFVAL06:STRING,BFSREFVAL07:STRING,BFSREFVAL08:STRING,BFSREFVAL09:STRING";
			gcds_bgt_update.SetDataHeader(s_temp);
		}
	}else if (p=="BGT_DEL"){
		if (gcds_bgt_del.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING," 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING"; 
			gcds_bgt_del.SetDataHeader(s_temp);
		}
	}else if (p=="BGTDTL_DEL_ALL"){
		if (gcds_bgt_del_all.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING," 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING"; 
			gcds_bgt_del_all.SetDataHeader(s_temp);
		}
  }else if(p=="TAX"){
		if (gcds_tax.countrow<1){       
			var s_temp = "TAXNBR:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,UPDT:STRING,UPID:STRING";
			gcds_tax.SetDataHeader(s_temp);
		}
	}else if(p=="TAX_DEL_ROW"){
		if (gcds_tax_del_row.countrow<1){       
			var s_temp = "TAXNBR:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,UPDT:STRING,UPID:STRING";
			gcds_tax_del_row.SetDataHeader(s_temp);
		}
	}else if(p=="FSSEQ"){
		if (gcds_fsseq.countrow<1){       
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING";
			gcds_fsseq.SetDataHeader(s_temp);
		}
	}else if(p=="AUTOMST"){
	   
        if (gcds_automst.countrow<1){
			var s_temp = "FDCODE:STRING,WKNO:STRING,TAMT:DECIAML,REMARK:STRING";
			gcds_automst.SetDataHeader(s_temp);
			 //alert("P::::::"+p);
		}
	}else if(p=="AUTODTL"){
	
	}
}


/******************************************************************************
	Description : Report Head ����
******************************************************************************/
function ln_PrtSetDataHeader(){
	if(gcds_print.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
							 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CURAMT:STRING,CHAAMT:DECIMAL,"
							 + "DAEAMT:DECIMAL,FOCHAAMT:STRING,FODAEAMT:STRING,FSRVALNM011:STRING,FSRVALNM012:STRING,"
							 + "FSRVALNM013:STRING,FSRVALNM014:STRING,FSRVALNM015:STRING,DETITLE:STRING,CURRENCY:STRING,"
							 + "COST:STRING,FSSTAT:STRING,SSNBR:STRING,DOCUVAL:STRING,CURDT:STRING,CURDT2:STRING,PTITLE:STRING,"
							 + "DATA01:STRING,DATA02:STRING,DATA03:STRING,DATA04:STRING,DATA05:STRING,"
							 + "CHASUM:STRING,DAESUM:STRING,C1:STRING,C2:STRING,C3:STRING,C4:STRING,C5:STRING,C6:STRING,C7:STRING";
		gcds_print.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : readonly
	prameter    : p - f : readonly
******************************************************************************/
function ln_Read(p){
 
	if (p=="f"){
		gcem_fsdat02.ReadOnly = "true";
		gcem_fs02.ReadOnly = "true";
		gcem_fsdat02.ReadOnly = "true";
		gcem_fsnbr02.ReadOnly = "true";
		//gclx_fsknd02.Enable = false;
		//gclx_fswrkdiv02.Enable = false;
		txt_empnmk02.ReadOnly = "true";
		
		gcem_fswrtdat02.ReadOnly = "true";
		gcem_actdat02.ReadOnly = "true";
		txt_deptcd02.ReadOnly = "true";
		txt_deptnm02.ReadOnly = "true";
		//gcem_ts02.ReadOnly = "true";
		//gcem_tsdat02.ReadOnly = "true";
		//gcem_tsnbr02.ReadOnly = "true";
		gclx_fsstat02.Enable = false;
		gcem_fsamt02.ReadOnly = "true";
		//gcem_fsvat02.ReadOnly = "true";
		gcem_remark02.ReadOnly = "true";//����
		//gcem_detot02.ReadOnly = "true";
		//gcem_crtot02.ReadOnly = "true";
		//gcem_remark02.ReadOnly = "true";
		img_calendar1.ReadOnly = "true";
	}else if (p=="t"){
		gcem_fsdat02.ReadOnly = "false";
		gcem_fs02.ReadOnly = "false";
		gcem_fsdat02.ReadOnly = "false";
		gcem_fsnbr02.ReadOnly = "false";
		//gclx_fsknd02.Enable = true;
		//gclx_fswrkdiv02.Enable = true;
		txt_empnmk02.ReadOnly = "false";
		
		gcem_fswrtdat02.ReadOnly = "false";
		gcem_actdat02.ReadOnly= "false";
		txt_deptcd02.ReadOnly = "false";
		txt_deptnm02.ReadOnly = "false";
		//gcem_ts02.ReadOnly = "false";
		//gcem_tsdat02.ReadOnly = "false";
		//gcem_tsnbr02.ReadOnly = "false";
		//gclx_fsstat02.Enable = true;
		gcem_fsamt02.ReadOnly = "true";
		//gcem_fsvat02.ReadOnly = "true";
		gcem_remark02.ReadOnly = "true";   //����
		//gcem_detot02.ReadOnly = "true";
		//gcem_crtot02.ReadOnly = "true";
		//gcem_remark02.ReadOnly = "false";
		img_calendar1.ReadOnly = "false";
	}
}

/******************************************************************************
	Description : ln_remark
	prameter    : p - ��
******************************************************************************/
function ln_remark(p){
  gcem_remark02.text=p;
}

/******************************************************************************
	Description : ��ǥ �ű� ��� �� �����ϸ鼭 Ű���� ������.
	prameter    :	p1 - fdcode 
	              p2 - fsdat
								p3 - fsnbr
******************************************************************************/
function ln_key_change(p1,p2,p3){
   ///alert("p1"+p1+"p2"+p2+"p3"+p3);
	 if (p1!='undefined'&&p2!='undefined'&&p3!='undefined'){
		 gclx_fdcode02.bindcolval=p1;
		 gcem_fs02.text=p2.substring(0,1);
		 gcem_fsdat02.text=p2.substring(1,9);
		 gcem_fsnbr02.text=p3;
	 }
}

/******************************************************************************
	Description : �޷�
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
	}else{
		__GetCallCalendar('gcem_actdat02', 'Text');
	}
}


/******************************************************************************
	Description : ����ݾ���ȸ
	prameter    :	    
******************************************************************************/
function ln_BgtFind(){
	
	//alert(""+gcds_dtl.rowposition);
	if(gcds_dtl.rowposition<1){
		alert("����Ÿ�� ������ �ֽʽÿ�.");
		return;
	}

	if(gclx_fswrkdiv02.bindcolval!="02"){
		alert("���� ������� �ƴմϴ�.");
		return;
	}else{
		ln_Bgt_Amt_find(gcds_dtl.rowposition);
	}
	
}

//==========================================================================================================================
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Description : ��ǥ�Է°��� �Լ�
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
//==========================================================================================================================

/******************************************************************************
	Description : �����ڵ� ã��
	parameter   : p1 - �����ڵ� �� ���������� ã��
	              p1 - 01  �����ڵ�,  02 ������
******************************************************************************/
function ln_Popup_Atcode(p1){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 �Ǵ� Enter 
  /////if(!ln_Popup_Chk(i)) return; 
  
	/*
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
		arrParam[1]="A";                               // ȸ��μ�
	}else{
		arrParam[1]=gclx_fdcode02.bindcolval;   // �Ϲݺμ��� ����
	}
	*/
	
	if(p1=="01"){
		arrParam[0]=gcem_atcode02.text;
	}else{
    	arrParam[0]=gcem_atkornam02.text;
	}
	
    arrParam[1]=gclx_fdcode02.bindcolval;
	strURL = "./actcode_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null){
		arrResult = result.split(";");
		ln_Ref_Data_Clear();         //�����׸� Clear();
		ln_Bgt_Amt_Clear();
		//alert("step"+"");
		
		//alert("0000hid_copy_documcd.value:;"+hid_copy_documcd.value);
		ln_Ref_Find(arrResult);     //�����׸�ã��
		ln_Fswrkdiv_Setting();      //����Ÿ�� �ڵ� ����
		
    ///////////////////////////////////////////////////////
		//�����ڵ尡 �����ޱ�(����ī��)�� ��� �ŷ�ó �ڵ�����
		//2007.07.19 2008.02.01
		if(gcem_atcode02.text=="2100520"){
			 txt_vendcd02.value="I12566";
			 gcem_vendnm02.text = "����ī�����";
			 gcem_vendnm02.Enable=false;
       
		}else{
       		gcem_vendnm02.Enable=true; 
		}
		//////////////////////////////////////////////////////

		////////////////////////////////////////////////////// 
        //2009.01.29 ������
		//���θ����ī������� �����׸� LOCK ����
		if(gcem_atcode02.text=="2100525"){
		  //LOCK ���� 
			ln_Ref_Card_Lock("F",gcds_dtl.rowposition);
			txt_vendcd02.value="";
			gcem_vendnm02.text = "";
			hid_lastref.value = 2; //���信�� ENTER�� �� �߰�
		}else{
     // ln_Ref_Card_Lock("T",gcds_dtl.rowposition); 
		}
		////////////////////////////////////////////////////// 
		//2010.04.06 jys  ������üũ - �������� ���Ͱ��� �Է½� ���� üũ
		ln_Chk_Atcode_Amt()
	}
}

/******************************************************************************
	Description : �����׸���
	parameter   : arrResult - return ��
******************************************************************************/
function ln_Ref_Find(arrResult){
     hid_lastref.value=""; //�����������׸�     

	 if(arrResult[0]!=undefined){
			gcem_atcode02.text = arrResult[0];
			gcem_atkornam02.text =arrResult[1];
			
			//++++++++++++++++++++++++++++++++++
			//������ �����׸� Setting
			//++++++++++++++++++++++++++++++++++
            //�μ�
			txt_fsrefcd01.value="0002";
			txt_deptcd02_1.value=arrResult[3];
			
			//�ŷ�ó
			txt_fsrefcd02.value="0020";
			//���ݰ�꼭�� ������ ��� �ŷ�ó�ڵ� �������.
			//2015.02.24. jys ����..�̰� �� �ִ��� �𸣰���.
			/*
			if(hid_docuval.value==""){
				txt_vendcd02.value=arrResult[5];
			}
			*/
			
			eval("txt_type01").value = arrResult[21];
			eval("txt_type02").value = arrResult[22];
			eval("txt_arbaldiv01").value = arrResult[30];
			eval("txt_arbaldiv02").value = arrResult[31];
      
			//�μ�, �ŷ�ó �ΰ����� ���
			hid_lastref.value = 2;
			
			for(k=3;k<=9;k++){
				
			    eval("txt_fsrefcd0"+k).value = arrResult[k+k+1];
				eval("txt_fsrefnm0"+k).value = arrResult[k+k+2];
				eval("txt_type0"+k).value = arrResult[k+20];
				eval("txt_arbaldiv0"+k).value = arrResult[k+29];
				
				//�����׸��ڵ尡 �������� ���� ��� �Է��׸� Lock ����
				//alert("k::"+k+"::txt_fsrefcd"+eval("txt_fsrefcd0"+k).value);
				if(eval("txt_fsrefcd0"+k).value==""){
					eval("gcem_fsrvalnm0"+k).enable = false;
          			eval("txt_fsrefval0"+k).disabled = true;
				}else{
					hid_lastref.value = k;
					eval("gcem_fsrvalnm0"+k).enable = true;
        			eval("txt_fsrefval0"+k).disabled = false;
        			
				}	
				//�����׸񿡼� ��¥Ÿ���� ��� Format ����
				ln_Ref_Date_Money_Format(k);
			}//for
		

			hid_funddiv.value = arrResult[43]; //�ڱݱ���
      		hid_atdecr.value=arrResult[40];    //��������  
			hid_banjaeyn.value = arrResult[39];//����
			hid_atcurtype.value = arrResult[45];//�ݰ��� ��ȭȯ������

      //2007.12.26 ������ �߰�
			hid_banjaeref.value =  arrResult[44];//���������׸�			                                    
			//return ;
	 }else{

	 }
     
     //alert("step2");
     
   //������ �μ�, �ŷ�ó, ������� �ٿ�����.
	 ln_Paste_Dept_Vend_Reamrk(gcds_dtl.rowposition);
}

/******************************************************************************
	Description : �����׸� ã��
	parameter   : p1 - �����׸� ���а�
	              obj - object�� 
******************************************************************************/
function ln_Popup2(p1,obj,strkeycode){

    //alert("p1::"+p1+"obj"+obj+"strkeycode"+strkeycode);
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strposition="";
	var strpo2="";
	var strpo3="";
	var strPopGubun ="";
	var strPo="";// �����׸���ġ
	var divcd="";
	var intp=0; //�����׸� ��ġ

    if(p1=="02_1"){      //�μ�
		arrParam[0] ="0002";
		arrParam[1] = gcem_deptnm02_1.text;
	}else if(p1=="02"){  //�ŷ�ó
    	arrParam[0] = "0020";
		arrParam[1] = gcem_vendnm02.text;
	}else{
		arrParam[0] = eval("txt_fsrefcd"+p1).value;
    	arrParam[1] = eval("gcem_fsrvalnm"+p1).text;
	}

    if(p1!="02_1") {
		strPopGubun = ln_PopGubun('1',p1,'txt_fsrefcd'); //�ڱݰ��� ���� ����
	}
	
	if(p1=="02_1"){     //�μ�
		intp=2;
	}else if(p1=="02"){ //�ŷ�ó
		intp=1;
	}else{
		intp = Number(p1);
	}
	
	//alert("intp::"+intp+":txt_fsrefcd0::"+eval("txt_fsrefcd0"+intp).value +":txt_type0:"+eval("txt_type0"+intp).value);
	//�Է��׸��� ��� return ==>������ȣ�� ����
    if(eval("txt_fsrefcd0"+intp).value!="0967"&&eval("txt_type0"+intp).value=="C"){
		if(eval("gcem_fsrvalnm0"+intp).text!=""){
			ln_Row_Auto_Add(intp,"01");
		}
		return;
	}
	
	
    //2012.02.08 JYS �������� ���� ���߰�, F2ġ�� �˾�ó��
	if(eval("txt_fsrefcd0"+intp).value=="2195"&&strkeycode=="13"){
		if(eval("gcem_fsrvalnm0"+intp).text==""){
			ln_Row_Auto_Add(intp,"01");
		}
		return;
	}
    
	//2015.11.11 JYS �ܻ���Ա� �����ڵ� ���ͽ� ������  �����ָ�
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=="2100110"&&gusrid=="3170009"){
		if(eval("txt_fsrefcd0"+intp).value=="0030"&&strkeycode=="13"){
			if(eval("gcem_fsrvalnm0"+intp).text==""){
				ln_Row_Auto_Add(intp,"01");
			}
			return;
		}
	}
      
	//alert("strPopGubun::"+strPopGubun);
    //�˾�üũ
    if(!ln_Chk_Popup(intp))return; 
	//2007.06.29
	//2008.02.01  ����ī�� �ŷ�ó�� ��� �ؽ�Ʈ�� �Է���.(0029�� ������.)
	if(arrParam[0]=="0020"||arrParam[0]=="0029"){
	//if(arrParam[0]=="0020"){
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="0002"){
	  
		arrParam[2]="A";
		arrParam[3]="";
		arrParam[4]=gclx_fdcode02.bindcolval;

		//2007.10.08.ȸ������ �߰�(�μ� CHGYM ����)
		var stractdat = gcem_actdat02.text;
		arrParam[5]=stractdat.substring(0,6);
		//****************************
		
		//**�������� :: �ݰ��� ���� �μ� �������� ���� ��� ����
		/*
        if(gf_Dept_Enable(gs_deptcd,gcds_name)){ //�����μ�
            arrParam[2]="A";
			arrParam[3]="";
			arrParam[4]=gclx_fdcode02.bindcolval;
		}else{ //�Ϲݺμ�
			divcd = ln_Find_Divcd(); //����ã��
			arrParam[2]="B";
			arrParam[3]=divcd;
			arrParam[4]=gclx_fdcode02.bindcolval;
		}
		*/
    
	    strURL = "./hcdept_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="1160"){ //������
	    arrParam[0]=arrParam[1];
        strURL = "./actcode_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(strPopGubun=="1"&&arrParam[0]=="0967"){ //�˾����� && ������ȣ�ϰ�� ===> �߻�
	    arrParam[1]=hid_funddiv.value;      //�ڱݱ���
		arrParam[2]= "";  //����
		arrParam[3]= "0"; //ó������(0-�̹���)
        arrParam[4]=gclx_fdcode02.bindcolval;          //����
		arrParam[5]=gcem_atcode02.text;                //����
        strURL = "./bill_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    }else if(strPopGubun=="2"&&arrParam[0]=="0967"){ //�˾����� && ������ȣ�ϰ�� ====>����
		if(txt_vendcd02.value==""||gcem_vendnm02.text==""){
			alert("�ŷ�ó�� �Է��Ͻÿ�.");
			return;
	    }
		arrParam[1]=hid_funddiv.value;          //�ڱݱ���
		arrParam[3]= "0";                       //ó������(0-ó����)
		arrParam[4]=gclx_fdcode02.bindcolval;   //����
		arrParam[5]=gcem_atcode02.text;         //�����ڵ�
		arrParam[7]=gcem_atkornam02.text;       //������
		
		if(txt_fsrefcd02.value=="0020"){
		  arrParam[2]= txt_vendcd02.value;     //�ŷ�ó�ڵ�
		  arrParam[6]= gcem_vendnm02.text;     //�ŷ�ó
		}else{
		  arrParam[2]="";
      	  arrParam[6]="";
		}
    	strURL = "./bill_popup_ifrm2.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no"; 
	}else if(arrParam[0]=="0003"){ //����μ�
	  ///alert("step2::"+eval("hid_bgtdiv"+p5).value);
		arrParam[2]=hid_bgtdiv.value;
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="0030"){ //�����ڵ�
	  //^^alert("step2::"+eval("hid_bgtdiv"+p5).value);
		arrParam[2]="";
		/*
		if(gclx_fdcode02.bindcolval=="01"){
			arrParam[2]="02";
		}else{
      		arrParam[2]=gclx_fdcode02.bindcolval;
		}
		*/
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="1133"){ //ī���ȣ
	   arrParam[2]="";
       for(p=3;p<=9;p++){
			if(eval("txt_fsrefcd0"+p).value=="1134"){
				arrParam[2]=eval("txt_fsrefval0"+p).value;
				break;
			}
		}
		strURL = "./commdtil_popup_card.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   
  	//2011.05.09 JYS////////////////////////////////////////////////////////////////////
  	}else if(arrParam[0]=="1135"){ //�ڻ��ڵ��ȣ
	    arrParam[1]=gclx_fdcode02.bindcolval;   //����
		arrParam[2]=gcem_atcode02.text;         //�����ڵ�
		strURL = "./commdtil_popup_astnbr.jsp";
		strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
  	////////////////////////////////////////////////////////////////////////////////////

  	}else{
	 // alert("arrParam[0]:"+arrParam[0]+":arrParam[1]:"+arrParam[1]+"::");
	  if(arrParam[0]=="0997"||arrParam[0]=="0023"||arrParam[0]=="0022")arrParam[2]="A";    //2016.06.10 jys 0023 �߰� 

		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	  }
	  result = showModalDialog(strURL,arrParam,strPos);	

	  if(result != null) {
		arrResult = result.split(";");
    	if(strPopGubun=="1"){        //�ڱݹ߻�
		  //������ȣ
			eval("txt_fsrefval"+p1).value=arrResult[1];
			eval("gcem_fsrvalnm"+p1).text=eval("txt_fsrefval"+p1).value;

			//����
			strPo="";
			strPo=ln_Ref_position_find("0022");
			eval("txt_fsrefval"+strPo).value =arrResult[2];   //�����ڵ�
			eval("gcem_fsrvalnm"+strPo).text =arrResult[3];   //�����
			
			////ln_Ref_lock(strPo,'1');
		}else if(strPopGubun=="2"){  //�ڱ�����
		  
			//�ݾ�üũ1 --���������� ���  �뺯 �ݾ��� �߻��ݾ�(�����ݾ�)�� �����ؾ���.
			//�ݾ�üũ2 --���޾����� ���  ���� �ݾ��� �߻��ݾ�(�뺯�ݾ�)�� �����ؾ���.
			if(hid_funddiv.value=="50"){
				if(gcem_crtot02.text!=arrResult[8]){
					alert("����ݾ��� �߻��ݾװ� �������� �ʽ��ϴ�.");
					////ln_Ref_Fund_Clear("2",p3,p4,p5);
					return ;
				}
			}else if(hid_funddiv.value=="60"){
				if(gcem_detot02.text!=arrResult[9]){
                   alert("����ݾ��� �߻��ݾװ� �������� �ʽ��ϴ�.");
					////ln_Ref_Fund_Clear("2",p3,p4,p5);
					return ;
				}
			}

			//������ȣ
			eval("txt_fsrefval"+p1).value=arrResult[1];
			eval("gcem_fsrvalnm"+p1).text=eval("txt_fsrefval"+p1).value;

			//�ŷ�ó
			//strPo = ln_Ref_position_find(p5,"0020");
			//eval("txt_fsrefval"+strPo).value =arrResult[2];  //�ŷ�ó�ڵ�
			//eval("txt_fsrvalnm"+strPo).value =arrResult[3];  //�ŷ�ó
			//ln_Ref_lock(strPo,'2');

			//����
			strPo="";
			strPo = ln_Ref_position_find("0022");
			eval("txt_fsrefval"+strPo).value =arrResult[6];   //�����ڵ�
			eval("gcem_fsrvalnm"+strPo).text =arrResult[7];   //�����
			//ln_Ref_lock(strPo,'2');

			//�����߻���
			strPo="";
			strPo = ln_Ref_position_find("0968");
			eval("txt_fsrefval"+strPo).value =arrResult[4];   //
			eval("gcem_fsrvalnm"+strPo).text =arrResult[4];   //
			//ln_Ref_lock(strPo,'2');

			//����������
			strPo="";
			strPo = ln_Ref_position_find("0969");
			eval("txt_fsrefval"+strPo).value =arrResult[5];   //
			eval("gcem_fsrvalnm"+strPo).text =arrResult[5];   //
			//ln_Ref_lock(strPo,'2');

			//�ݾ� lock
			////ln_Ref_lock(strPo,'3',i); //�ݾ� lock
		}else{                //�ڱ��̿�
			if(p1=="02_1"){   //�μ�
				eval("txt_deptcd"+p1).value =arrResult[0];
				eval("gcem_deptnm"+p1).text =arrResult[1];
			}else if(p1=="02"){  //�ŷ�ó 
			
				//alert("�ŷ�ó....."+arrResult[7]);
				hid_gredgb.value=arrResult[7];
			
			    //���з� ó�� üũ
			    if(arrResult[7]=="1"||arrResult[7]=="2"){
			    	if(!ln_Bond_Attach_Chk(arrResult[0],gcds_dtl.rowposition)){
			    		//alert("888");
			    		eval("txt_vendcd"+p1).value="";
			    		eval("gcem_vendnm"+p1).text="";
			    		return false;
			    	}else{
			    		//alert("999");
			    	}
			    }
	
				eval("txt_vendcd"+p1).value =arrResult[0];
				eval("gcem_vendnm"+p1).text =arrResult[1];
				//alert("strkeycode:"+strkeycode);
				
				//������ ��� ���� �˾� �ڵ� ����
				if(gs_userid2="true") {
					if(strkeycode==13||strkeycode==113){ //Tab
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")!=""&&gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")!="" ){
							if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")=="0020"){      //�ŷ�ó
								ln_Chk_Banjae_Amt(); //��������üũ
							}
						}
					}
				}

				//2009.01.29. ����ī�� ���� �߰�///////////////////////////////////////////////////////////////////////////////////
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=="2100525"){
				   if (!ln_Card_Data_Setting()){
					   //alert("["+gcem_vendnm02.text+"]�� ���� ���θ����ī�� ������ �������� �ʽ��ϴ�.");
					   alert("���θ����ī�� ������ �������� �ʽ��ϴ�.");
				   }
				}
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			}else{
		        eval("txt_fsrefval"+p1).value =arrResult[0];
		        eval("gcem_fsrvalnm"+p1).text =arrResult[1];
			}
		
			if(arrParam[0]=="0002"){          //�μ�
				hid_divcd.value = arrResult[3]; //����
				
				//����μ� ��ġã��
				var spo=ln_Ref_position_find("0003")
				if(spo!=""&&spo!=undefined){
					if (eval("txt_fsrefcd"+spo).value=="0003"){
							eval("txt_fsrefval"+spo).value = arrResult[4]; //����μ�
							eval("gcem_fsrvalnm"+spo).text = arrResult[5]; //����μ���
							hid_bgtdiv.value =arrResult[6];                //���꺻���ڵ�
					} 
				}
			}else if (arrParam[0]=="0003"){  ////����μ�
				hid_bgtdiv.value =arrResult[2]; //���꺻���ڵ�
				/******�� ���ΰ� 1000�ϰ�� ���°�?
				if(arrResult[2]=="1000"){
				}else{
					hid_bgtdiv.value =arrResult[2]; //���꺻���ڵ�
				}
				************/

				if(hid_bgtcnt.value!=0){         //������� ������ �����ϴ� ���
					
				}else if(hid_bgtcmtype.value!=""&&hid_bgtcnt.value==0){//������� ������ �������� ���� ���
					////ln_Bgt_Amt_find('','','',p5);
				}
			}else{
				 if(hid_type.value=="B"){    //����μ��� �����̸� 
						if(hid_bgtcnt.value!=0){ //��������� ������ �����ϴ� ���
							/////ln_Bgt_Amt_find(p2,p3,p4,p5);       
						}else if(hid_bgtcmtype.value!=""&&hid_bgtcnt.value==0){ //������� ������ �������� ���� ���
							//ln_Bgt_Amt_find('','','',p5);
						}
				 }
			}
		}
    	ln_Row_Auto_Add(intp,"01");
	}else{//Data�� �������� ���� ���
		if(strPopGubun=="1"){        //�ڱݹ߻�
			////ln_Ref_Fund_Clear("1",p3,p4,p5);
		}else if(strPopGubun=="2"){  //�ڱ�����
		  ////ln_Ref_Fund_Clear("2",p3,p4,p5);
		}else{
			if(p1=="02_1"){
				eval("txt_deptcd"+p1).value ="";
				eval("gcem_deptnm"+p1).text ="";
			}else if(p1=="02"){
				eval("txt_vendcd"+p1).value ="";
				eval("gcem_vendnm"+p1).text ="";
			}else{
		        eval("txt_fsrefval"+p1).value ="";
		        eval("gcem_fsrvalnm"+p1).text ="";
			}
			if(arrParam[0]=="0002"){
			  //�μ��� �������� ������
				hid_divcd.value="";
			}
			if(arrParam[0]=="0003"){
			  //�μ��� �������� ������ ���꺻�ε� ����.
				var spo=ln_Ref_position_find("0002");//�μ�
				if(spo!=""&&spo!=undefined){
					if(eval("txt_fsrefval"+spo).value==""){
						 hid_bgtdiv.value ="";
					}
				}else{
					hid_bgtdiv.value ="";
				}
			}
		}
		return;
	}	
}
	
<%
/******************************************************************************
	Description :  ���з� �ŷ�ó üũ 
******************************************************************************/
%>
function ln_Bond_Attach_Chk(strVend_cd,strRow){
	
	if(gcds_dtl.namevalue(strRow,"ATCODE")=="1110310"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110610"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110620"||gcds_dtl.namevalue(strRow,"ATCODE")=="1112110"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1112120"
	  ){
		
		//����<>0  AND �뺯=0  �̸�  BOND_ATTACH_HIS üũ�Ͽ� ������ �ϸ� �ԷºҰ�   		
		if(gcds_dtl.namevalue(strRow,"CHAAMT")!=0&&gcds_dtl.namevalue(strRow,"DAEAMT")==0){
			//ln_Bond_Attach_His(strVend_cd,gs_userid,'20170302');
			if(!ln_Bond_Attach_His(strVend_cd,gs_userid,gs_date)){
				//alert("strRow:::"+strRow);
				gcds_dtl.rowposition = strRow;
				return false;
			}else{
				return true;
			}
		}else if(gcds_dtl.namevalue(strRow,"CHAAMT")==0&&gcds_dtl.namevalue(strRow,"DAEAMT")!=0){
			return true;
		}else{
			alert("�����ݾ� �Ǵ� �뺯�ݾ��� �Է��Ͻʽÿ�. ");
			return false;
		}
	}else if(
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110110"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110120"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110140"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110150"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110160"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110170"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110180"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110190"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110193"
	){
		//����=0  AND �뺯<>0  �̸�  BOND_ATTACH_HIS üũ�Ͽ� ������ �ϸ� �ԷºҰ�
		if(gcds_dtl.namevalue(strRow,"CHAAMT")!=0&&gcds_dtl.namevalue(strRow,"DAEAMT")==0){
			return true;
		}else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0&&gcds_dtl.namevalue(strRow,"DAEAMT")!=0){
			if(!ln_Bond_Attach_His(strVend_cd,gs_userid,gs_date)){
				return false;
			}else{
				return true;
			}
		}else{
			alert("�����ݾ� �Ǵ� �뺯�ݾ��� �Է��Ͻʽÿ�. ");
			return false;
		}
	}else{
		return true;
	}
	
	return false;
}

<%
/******************************************************************************
	Description :  ���з� �ŷ�ó HISTORY  Ȯ��  
******************************************************************************/
%>
function ln_Bond_Attach_His(strVendcd, strEmpno, strDate){
	gcds_bond_attach_his.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s3?v_str1="+strVendcd+"&v_str2="+strEmpno+"&v_str3="+strDate;
	//prompt('',gcds_bond_attach_his.DataID);
	gcds_bond_attach_his.Reset();
	
	//alert("gcds_bond_attach_his::"+gcds_bond_attach_his.namevalue(gcds_bond_attach_his.rowposition,"CNT"));
	if(gcds_bond_attach_his.namevalue(gcds_bond_attach_his.rowposition,"CNT")!=0){
		return true;
	}else{
	    alert("�ش� �ŷ�ó�� [ä��(��)�з�] ��ü�Դϴ�. \n\n �濵������(����3838)���� �����ٶ��ϴ�. ");
		return false;
	}
}

/******************************************************************************
	Description :  Enter �� Row �ڵ� �߰�
	parameter   :  intp - ���� �����׸� ��ġ
	               gubun - 01 
								         02 : ����
******************************************************************************/
function ln_Row_Auto_Add(intp,gubun){
    //alert("ln_Row_Auto_Add::intp:"+intp+"::hid_lastref;"+hid_lastref.value+"gcds_dtl"+gcds_dtl.namevalue(gcds_dtl.rowposition,"LASTREF"));
	//data�� ������ �����׸��� ��� //addrow();
	if(intp!=2){
		if(intp==gcds_dtl.namevalue(gcds_dtl.rowposition,"LASTREF")){
			if(gcds_dtl.countrow ==gcds_dtl.rowposition){
				if(!ln_Add(99,'')){
					return;
				}
			}
			gcem_atkornam02.Focus();
		}
	}else{ //2�� ���� ���信�� Enter ĥ ��츸 ������.
		if(gubun=="02"){
			if(gcds_dtl.countrow ==gcds_dtl.rowposition){
				if(!ln_Add(99,'')){
					return;
				}
			}
			gcem_atkornam02.Focus();
		}
	}
}

/******************************************************************************
	Description :  �ڱݰ��� ���� ����
	parameter   :  gubun ����(üũ��ġ,
	               p1 - �����׸� object
	��     ��   : //���޾��� & ���� =0 �뺯 <>0 (�߻� ==> Popup)
								//���޾��� & ����<>0 �뺯 = 0 (���� ==> Popup)
								//�������� & ���� =0 �뺯 <>0 (���� ==> Popup)
								//�������� & ����<>0 �뺯 = 0 (�߻� ==> �Է�)
******************************************************************************/
function ln_PopGubun(gubun, p1, obj){
 //alert("gubun::"+gubun+"obj::"+obj+":p1:"+p1+"::"+eval(obj+p1).value);
 //alert("hid_funddiv.value::"+hid_funddiv.value);
	var strPopGb="";
	
	if(gubun=="1"){
		if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="60"&& gcem_detot02.text==0 && gcem_crtot02.text!=0){
			strPopGb="1";
		}else if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="60"&& gcem_detot02.text!=0 && gcem_crtot02.text==0){
			strPopGb="2";
		}else if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="50"&& gcem_detot02.text==0 && gcem_crtot02.text!=0){
			strPopGb="2";
		}
	}else if(gubun=="2"){
		if(hid_funddiv.value=="60"&& gcem_detot02.text==0&&gcem_crtot02.text!=0){
			strPopGb="1";
		}else if(hid_funddiv.value=="60"&& gcem_detot02.text!=0&&gcem_crtot02.text==0){
			strPopGb="2";
		}else if(hid_funddiv.value=="50"&& gcem_detot02.text==0&&gcem_crtot02.text!=0){
			strPopGb="2";
		}
	}
	return strPopGb;
}


/******************************************************************************
	Description :  ��ǥMST ����Ÿ Clear();
	parameter   :  
******************************************************************************/
function ln_MST_Data_Clear(){
  gcem_remark02.text="";
  gcem_fsamt02.text=0;
}


/******************************************************************************
	Description :  ��ǥ�Է� ����Ÿ Clear();
	parameter   :  
******************************************************************************/
function ln_Input_Data_Clear(){
	return;
	gcem_fsnum02.text="";
	gcem_atcode02.text="";
	gcem_atkornam02.text="";
	gcem_detot02.text=0;
	gcem_crtot02.text=0;
	gclx_documcd02.bindcolval="";
	gclx_fswrkdiv02.bindcolval="";
	txt_vendcd02.value="";
	gcem_vendnm02.text="";
	txt_deptcd02.value="";
	gcem_deptnm02.text="";
	gcem_remark02_1.text="";

	for(k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).text="";
		eval("txt_fsrefval0"+k).value="";
	}
}

/******************************************************************************
	Description :  �����׸� ����Ÿ Clear();
	parameter   :  
******************************************************************************/
function ln_Ref_Data_Clear(){
	for(k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).text="";
		eval("txt_fsrefval0"+k).value="";
	}
}

/******************************************************************************
	Description : �����׸� �ڱݰ��� clear
	parameter   : gubun - ����
	              p3 - object (i+j ��)
								p4 - object (�� ���а� 1,2,3)
								���� : p2+p3+p4 - �ش� �����׸� �ڵ� �Ǵ� ��Ī
								p5 - i position

******************************************************************************/
function ln_Ref_Fund_Clear(gubun,p3,p4,p5){ 	

	if(gubun=="1"){
		 //������ȣ
		eval("txt_fsrefval"+p3+p4).value="";
		eval("txt_fsrvalnm"+p3+p4).value="";

		 //����
		strPo="";
		strPo = ln_Ref_position_find("0022");
		eval("txt_fsrefval"+strPo).value ="";   //�����ڵ�
		eval("txt_fsrvalnm"+strPo).value ="";   //�����
		ln_Ref_lock(strPo,'1');
	}else if(gubun=="2"){
		//������ȣ
		eval("txt_fsrefval"+p3+p4).value="";
		eval("txt_fsrvalnm"+p3+p4).value="";
		
		//����
		strPo="";
		strPo = ln_Ref_position_find("0022");
		eval("txt_fsrefval"+strPo).value ="";   //�����ڵ�
		eval("txt_fsrvalnm"+strPo).value ="";   //�����
		ln_Ref_lock(strPo,'2');
		//�����߻���
		strPo="";
		strPo = ln_Ref_position_find("0968");
		eval("txt_fsrefval"+strPo).value ="";   //
		eval("txt_fsrvalnm"+strPo).value ="";   //
		ln_Ref_lock(strPo,'2');
		//����������
		strPo="";
		strPo = ln_Ref_position_find("0969");
		eval("txt_fsrefval"+strPo).value ="";   //
		eval("txt_fsrvalnm"+strPo).value ="";   //
		ln_Ref_lock(strPo,'2');
	}
}

/******************************************************************************
	Description : ��ǥ��� - DTL Data Add
	parameter   : 
******************************************************************************/
function ln_Data_Add_DTL(){
   /*
   return;
	 var temp_fsdat="";
	 var temp_seq=0;
  temp_fsdat = gcem_fsdat02.text;

	//gcds_dtl.ClearAll();
	ln_SetDataHeader("DTL"); 
	gcds_dtl.addrow();

	hid_fsdat.value = gcem_fs02.text+gcem_fsdat02.text;
	temp_seq = Number(gcds_data01.Max(4,0,0))
	temp_seq = Number(temp_seq)+1

  gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gs_fdcode;                  //�����ڵ�
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")=hid_fsdat.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")=gcem_fsnbr02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=ln_Seqno_Format(temp_seq,5);
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcem_atcode02.text;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcem_atkornam02.text;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")="2"; //���ν������� ������.
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcem_remark02_1.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcem_detot02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcem_crtot02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ01")=txt_fsrefseq01.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ02")=txt_fsrefseq02.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ03")=txt_fsrefseq03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ04")=txt_fsrefseq04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ05")=txt_fsrefseq05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ06")=txt_fsrefseq06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ07")=txt_fsrefseq07.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ08")=txt_fsrefseq08.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ09")=txt_fsrefseq09.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")=txt_fsrefcd01.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")=txt_fsrefcd02.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")=txt_fsrefcd03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")=txt_fsrefcd04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")=txt_fsrefcd05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")=txt_fsrefcd06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")=txt_fsrefcd07.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")=txt_fsrefcd08.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")=txt_fsrefcd09.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")=txt_deptcd02_1.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")=txt_vendcd02.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")=txt_fsrefval03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")=txt_fsrefval04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")=txt_fsrefval05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")=txt_fsrefval06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")=txt_fsrefval07.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")=txt_fsrefval08.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")=txt_fsrefval09.value;
	*/
  /*
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM04")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM09")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")=;
	*/
	/*
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE01")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE07")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE09")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV08")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV09")=;
	*/
	/*
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"CNT")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")=gclx_documcd02.bindcolval;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMNM")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=gclx_fswrkdiv02.bindcolval;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;	 
	gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date; 
	gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")=;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSTAT")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")=hid_docuval.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=gcem_fsnum02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=txt_deptcd02_1.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"BGTDIV")=hid_divcd.value;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"FUNDDIV")=;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEREF")=;
	
  gcem_fswrtdat02.text=gs_date;  
	*/
}

/******************************************************************************
	Description : ��ǥ��� - ���� ã��
	parameter   : 
******************************************************************************/
function ln_Fsnum_Find(){
  var ifsnum=0;
	_out:
	for(k=1;k<=gcds_dtl.countrow;k++){
		if(gcds_dtl.namevalue(k,"FSNUM")==""){
			ifsnum=k;
			break _out;
		}
	}
	return ln_Seqno_Format(Number(ifsnum),3);
}

/******************************************************************************
	Description : Insert �Ǵ� Delete �� ���� �缳��
	parameter   : ipo - ���� rowposition
	              strGubun - 01: Insert
								           02: Delete
******************************************************************************/
function ln_Fsnum_Reset(ipo,strGubun){
	if(strGubun=="01"){
		ipo=ipo+1;
	}
	for(k=ipo;k<=gcds_dtl.countrow;k++){
		gcds_dtl.namevalue(k,"FSNUM") = ln_Seqno_Format(Number(k),3);
	}
}

/******************************************************************************
	Description : ���ݰ�꼭 �� ��꼭 ���
	parameter   : p0 - position
				        p1 - �����ڵ�
	              p2 - ��������
                p3 - ������ȣ
								p4 - ��ǥ���ȣ
					
				�� ��	:	�������� ( 001-���ݰ�꼭, 002-��꼭)

	���� : 2006.03.02 - ������ ���� ���μ��� �������� �߰���
	       
******************************************************************************/
function ln_Popup_Tax(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strDocumcd="";
	var strDocGB="";
	var p1 = gclx_fdcode02.bindcolval;
    var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	var p4 = "";

	strDocumcd=gclx_documcd02.bindcolval;
	strDocGB=strDocumcd.substring(0,1);

	if(gclx_documcd02.bindcolval==""||gclx_documcd02.bindcolval=="000"){  
		alert("�������� �����Ͻʽÿ�.");
		return;
  }

	if(hid_docuval.value==""){
		arrParam[0]=p1;   //�����ڵ�
		arrParam[1]=p2;   //��������
		arrParam[2]=p3;   //������ȣ
		arrParam[3]=p4;   //��ǥ���ȣ
		
		if(txt_fsrefcd02.value=="0020"){
			arrParam[4]=txt_vendcd02.value;   //�ŷ�ó�ڵ�
			arrParam[5]=gcem_vendnm02.text;   //�ŷ�ó��
		}else{
			arrParam[4]="";   //�ŷ�ó�ڵ�
			arrParam[5]="";   //�ŷ�ó��
		}
	}else{  //���Ը����� ������ȣ ����
	    var strdocuval =hid_docuval.value;
		arrParam[0]=strdocuval.substring(0,1);   //���Ը��ⱸ�� (A-����, B-����)
		arrParam[1]=p1;                          //�����ڵ�
		arrParam[2]=strdocuval.substring(1,11);  //������ȣ
	}
  
	//alert("strDocGB"+strDocGB);
	//��������////////////////////////////// 	
	if(strDocGB=="1"){
		arrParam[6]= gclx_documcd02.bindcolval;  
		arrParam[7]= hid_docuval.value;
    	if(hid_docuval.value==""){
		  //2009.09.10 ���ڼ��ݰ�꼭 ���� 
			//strURL = "./Com_Tax_List1.html";
			strURL = "./com_tax_list1_e.jsp";
			strPos = "dialogWidth:830px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		}else{
	  	    //2009.09.10 ���ڼ��ݰ�꼭 ���� 
			//strURL = "./STaxBill_popup.html";
			//strURL = "./STaxBill_popup_e.html";
			//alert("staxbill_popup_ee");
			//strURL = "./staxbill_popup_ee.jsp";
			
			if(arrParam[7].substring(0,1)=="A"||arrParam[7].substring(0,1)=="C"||arrParam[7].substring(0,1)=="E"||arrParam[7].substring(0,1)=="G"||arrParam[7].substring(0,1)=="I"){
				strURL = "./a040110_view_popup.jsp";
			}else if(arrParam[7].substring(0,1)=="B"||arrParam[7].substring(0,1)=="D"||arrParam[7].substring(0,1)=="F"||arrParam[7].substring(0,1)=="H"||arrParam[7].substring(0,1)=="J"){
				strURL = "./a040120_view_popup.jsp";
			}
			
			strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
						
		}
    }else if(strDocGB=="2"){
		//ln_Popup_Tax2(p0);
		return;
	}
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		var stracnbr="";
  		var cnt = arrResult.length/13 //Dtl row ����
    
		var chasum=0;
		var daesum=0;
		var k=-1;
		var stracnbr =""//��꼭 ��ȣ
		hid_copy_documcd.value="";
		hid_copy_docuval.value="";

		if(gcem_remark02_1.text==""){
			gcem_remark02_1.text=arrResult[k+7]; //����
			gcem_remark02.text=arrResult[k+7]; //����
		}

		for(m=1;m<=cnt;m++){
		  //Detail �׸� �߰�
			if(m==1){
			  //alert("m02::"+m)
			}else{
			  //alert("m03::"+m);
				ln_Add('99','TAX');
			}
		
			chasum+=parseInt(arrResult[k+8]);
			daesum+=parseInt(arrResult[k+9]);
		    //parameter   :  p1 - �����ڵ�,  p2- ������,    p3 -�ŷ�ó�ڵ�,   p4-�ŷ�ó��,  p5 - �μ��ڵ�, 
	        //               p6 - �μ���,    p7- ����,      p8 - ����,        p9-�뺯,      p10 - ��꼭��ȣ, p11 - �����ڵ�
			//               p12 - �����ڵ�
			ln_Refcode_find(arrResult[k+1],arrResult[k+2], arrResult[k+3],arrResult[k+4], arrResult[k+5],
		                    arrResult[k+6],arrResult[k+7], arrResult[k+8],arrResult[k+9], arrResult[k+10], 
											arrResult[k+11],arrResult[k+12],arrResult[k+13]);
			
			//���ϰ�꼭 ��ȣ�� �ѹ��� �ѱ�.
			if(stracnbr!=arrResult[k+10]){
				ln_Tax_Data_Save(arrResult[k+10],gs_date,gs_userid,p2);
			}
			stracnbr = arrResult[k+10];
			ln_lock(m,'1');
      
			 //2008.09.02 ������ - ó�� ���ݰ�꼭 ������ ���� ������ �ŷ�ó ���� �����ϰ� ��.
			if(m==cnt) {
				/**
				txt_vendcd02.disabled=false;
                gcem_vendnm02.Enable=true;	
				**/
				//2010.04.08 jys �����ޱ�(����ī��)�� ��� �ŷ�ó lock��.
				if(gcem_atcode02.text!="2100520"){
					txt_vendcd02.disabled=false;
					gcem_vendnm02.Enable=true;	
				}
			} 
			
			k+=13; //parameter����
		}//for
			g_taxval += Number(chasum);
			g_fsknd = "1";
	}else{
    //eval("txt_fsrefval"+p3+p4).value="";
		//eval("txt_fsrvalnm"+p3+p4).value="";
	}
}

/******************************************************************************
	Description : �����ڵ�� �����׸� ���� ����
	parameter   :  p1 - �����ڵ�, p2- ������,    p3 -�ŷ�ó�ڵ�   p4-�ŷ�ó��   
	               p5 - �μ��ڵ�, p6- �μ���,    p7 - ����,       p8 - ����,     p9-�뺯
								 p10 - ((����)��꼭,�ſ�ī��,���ݼҵ���� : ��ȣ)
								 p11 - ((����)��꼭,�ſ�ī��,���ݼҵ���� : �����ڵ�)
								 p12 - ����, p13 - ��꼭����
******************************************************************************/
function ln_Refcode_find(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13){
	var cnt =0;
	var xcnt=0;
	var j=0;
	var dblcount=0;
	var strfsrefval="";
	var strfsrefvalnm="";
	hid_type.value="";
 
    //alert("DTL"+"p1:"+p1+":p2:"+p2+":p3:"+p3+":p4:"+p4+":p5:"+p5+":p6:"+p6+":p7:"+p7+":p8:"+p8+":p9:"+p9+":p10:"+p10+":p11:"+p11+":p12:"+p12+":p13:"+p13);
	if(p1!=""){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>actcode_s1f?v_str1="+p1+"&v_str2='ATCODE'&v_str3="+gclx_fdcode02.bindcolval;                                               
		//prompt("gcds_code01",gcds_code01.DataID);
		gcds_code01.Reset();
		dblcount = gcds_code01.CountRow;
    
		//2010.03.31
		hid_banjaeyn.value=gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //����
	}else{
	    dblcount =1;
	    hid_banjaeyn.value="";
	}
  
	gcem_atcode02.text=p1;
	gcem_atkornam02.text=p2;
	gcem_remark02_1.text=p7;
	gcem_detot02.text=p8;
	gcem_crtot02.text=p9;
	hid_docuval.value=p10;
	gclx_documcd02.bindcolval=p11;
	
	//2010.03.31 jys ���ݰ�꼭���� ������ ��� ������ ������ �������.
	//hid_banjaeyn.value=gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //����
	
	hid_divcd.value=p12;                                                          //����
	hid_funddiv.value = gcds_code01.namevalue(gcds_code01.rowposition,"FUNDDIV"); //�ڱݱ���

	//^^alert("hid_atdebtyn:::"+eval("hid_atdebtyn"+g_row).value);
	g_strbanjae = gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //��������

	//2007.05.11 ������ �߰� (���ݰ�꼭 ����Ÿ ������ ��� üũ)
	hid_atdecr.value = gcds_code01.namevalue(gcds_code01.rowposition,"ATDECR"); //�������뱸��
	
	for(i=1;i<=dblcount;i++){

	  /**
		//�ŷ�ó & �μ� 
		txt_vendcd02.value=p3;  
		gcem_vendnm02.text=p4;
		**/
		//20061013 ���ݰ�꼭 �����ð�� �μ� ������.
		//2015.02.24 ���ݰ�꼭 �����ð�� �μ� ������
		txt_deptcd02_1.value=p5;
		gcem_deptnm02_1.text=p6;

		//2010.04.08 jys �߰�    	
		if(gcem_atcode02.text=="2100520"){
		  txt_vendcd02.value="I12566";  
		  gcem_vendnm02.text="����ī�����";
		}else{
			//�ŷ�ó & �μ� 
		  txt_vendcd02.value=p3;  
		  gcem_vendnm02.text=p4;
		}

 	    hid_lastref.value = 2;
		//�����׸�������
		for(k=1;k<=9;k++){
			if(gcds_code01.namevalue(i,"CDNAM"+k)!=undefined&&gcds_code01.namevalue(i,"CDNAM"+k)!=""){
				if(k>=3){
					eval("txt_fsrefnm0"+k).value=gcds_code01.namevalue(i,"CDNAM"+k);
					eval("txt_fsrefcd0"+k).value=gcds_code01.namevalue(i,"CDCODE"+k);

					//�����׸񿡼� ��¥Ÿ���� ��� Format ����
					ln_Ref_Date_Money_Format(k);
				}
				eval("txt_type0"+k).value=gcds_code01.namevalue(i,"TYPE"+k);
				eval("txt_arbaldiv0"+k).value=gcds_code01.namevalue(i,"ARBALDIV"+k);
				hid_lastref.value = k;
			}else{
				if(k>=3){
					eval("txt_fsrefnm0"+k).value="";
					eval("txt_fsrefcd0"+k).value="";
				}
				eval("txt_type0"+k).value="";
				eval("txt_arbaldiv0"+k).value="";
			}

			if(eval("txt_type0"+k).value=="B"){ //������ ����Ÿ���̸�
				hid_type.value="B";
			}
		}

		//���������׸� ������ ������ ��� ����
		if(hid_type.value=="B"){
			gclx_fswrkdiv02.bindcolval="02";
		}else{
      		gclx_fswrkdiv02.bindcolval="01";
		}
		
		txt_fsrefcd01.value='0002';
		txt_fsrefcd02.value='0020';
		
		//���ݰ�꼭�� ������ �ְ� �μ������׸�� �ŷ�ó �����׸��� �������
		/****************
		if(p10!=""&&gcds_code01.namevalue(i,"CDCODE1")==undefined&&gcds_code01.namevalue(i,"CDNAM1")==undefined
							&&gcds_code01.namevalue(i,"CDCODE2")==undefined&&gcds_code01.namevalue(i,"CDNAM2")==undefined){
			txt_fsrefcd01.value='0002';
			//eval("txt_fsrefnm"+g_row+j+"1").value='�μ��ڵ�';
			txt_fsrefcd02.value='0020';
			//eval("txt_fsrefnm"+g_row+j+"2").value='�ŷ�ó�ڵ�';
		}
		******************/

		for(k=3;k<=9;k++){
			//��꼭 ���ڰ� �����ϴ� ��� �����׸� SETTING��.
			if(eval("txt_fsrefcd0"+k).value=="1048"||eval("txt_fsrefcd0"+k).value=="0970"){
				eval("txt_fsrefval0"+k).value=p13;
			    eval("gcem_fsrvalnm0"+k).text=p13;
				return;
			}
			
			/////////////////////////////////////////////////////////////////////////////////////////
			//���޺ΰ����� ��� ������������ ������ �ϱ� 2014.05.29.JYS 
			if(p1=="1112300"&&eval("txt_fsrefcd0"+k).value=="0998"){ 
				
				if(p11=="101"){ //���ݰ�꼭 
					strfsrefval= "03"; 
					strfsrefvalnm="���ݰ�꼭";
				}else if(p11=="102"){ //��꼭
					strfsrefval= ""; 
					strfsrefvalnm="";
				}else if(p11=="103"){ //�ſ�ī��(����)
					strfsrefval= "04"; 
					strfsrefvalnm="��Ÿ�ΰ���";
				}else if(p11=="104"){ //���ݿ�����(����)
					strfsrefval= "04"; 
					strfsrefvalnm="��Ÿ�ΰ���";
				}else if(p11=="201"||p11=="202"||p11=="203"){ //�ſ�ī��(�Ұ�)//���ְ���//���̿�����
					strfsrefval= ""; 
					strfsrefvalnm="";		
				}
				//�����ڵ� �ֱ� 
				eval("txt_fsrefval0"+k).value=strfsrefval;
				eval("gcem_fsrvalnm0"+k).text=strfsrefvalnm;
			}		
			
			//�����ΰ����� ��� ������������ ������ �ϱ� 2014.05.29.JYS 
			if(p1=="2101100"&&eval("txt_fsrefcd0"+k).value=="1017"){ 
				
				if(p11=="101"){ //���ݰ�꼭 
					strfsrefval= "03"; 
					strfsrefvalnm="���ݰ�꼭";
				}else{ 
					strfsrefval= ""; 
					strfsrefvalnm="";		
				}
				//�����ڵ� �ֱ� 
				eval("txt_fsrefval0"+k).value=strfsrefval;
				eval("gcem_fsrvalnm0"+k).text=strfsrefvalnm;
			}			
           /////////////////////////////////////////////////////////////////////////////////////////
		}
	}//for
}

/******************************************************************************
	Description :  ���ݰ�꼭 ���̺� ������ȣ UPDATE
	parameter   :  p1 - ��꼭��ȣ, p2 - ���� , p3 - ������ , p4 fsdat
******************************************************************************/
function ln_Tax_Data_Save(p1, p2, p3, p4){
  //alert("p1::"+p1+"::p2::"+ p2+"::p3::"+ p3+"::p4::"+p4);
	//alert("Countrow" + gcds_tax.Countrow);
	if (gcds_tax.Countrow==0){
		ln_SetDataHeader("TAX");
	}
	gcds_tax.AddRow();
  	gcds_tax.namevalue(gcds_tax.rowposition,"TAXNBR")=p1;
	gcds_tax.namevalue(gcds_tax.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
	gcds_tax.namevalue(gcds_tax.rowposition,"FSDAT")=p4;
	gcds_tax.namevalue(gcds_tax.rowposition,"FSNBR")="";
	gcds_tax.namevalue(gcds_tax.rowposition,"UPDT")=p2;
	gcds_tax.namevalue(gcds_tax.rowposition,"UPID")=p3;
} 

/******************************************************************************
	Description : ������� ��꼭 ��ȣ �� ��ǥ ��ȣ ���� 
	parameter   : 
******************************************************************************/
function ln_Tax_Del_Row(row){
	if (gcds_tax_del_row.Countrow==0){
		ln_SetDataHeader("TAX_DEL_ROW");
	}
	gcds_tax_del_row.AddRow();
    gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"TAXNBR")=gcds_dtl.namevalue(row,"DOCUVAL");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FSDAT")=gcds_dtl.namevalue(row,"FSDAT");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FSNBR")=gcds_dtl.namevalue(row,"FSNBR");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"UPDT")="";
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"UPID")="";

} 

/******************************************************************************
	Description :  �ڵ���ǥ�ϰ�� �Էµ� ���� ��� lock���� ǥ����.
	parameter   :  p5 - row : position
******************************************************************************/
function ln_lock(row, gubun){
   
	if(gubun=="1"){ //���ݰ�꼭
		if(gclx_documcd02.bindcolval!=""){
			gclx_documcd02.Enable=false;
		}else{
			gclx_documcd02.Enable=true;
		}

		for( k=1;k<=9;k++){
			if(eval("txt_fsrefcd0"+k).value=="0002"){       //�μ��ϰ�� ���氡��
				txt_deptcd02_1.disabled=false;
        		gcem_deptnm02_1.Enable=true;
			}else if(eval("txt_fsrefcd0"+k).value=="0020"){ //�ŷ�ó�� ��� ����Ÿ�� ������ �����
				if(txt_vendcd02.value!=""){
					if(gcem_atcode02.text=="1112120"){//�������ޱ��� ��츸 �ŷ�ó�� ��������.
					    txt_vendcd02.disabled=false;
					}else{
						txt_vendcd02.disabled=true;
					}
				}else{
					txt_vendcd02.disabled=false;
				}
				if(gcem_vendnm02.text!=""){
				  if(gcem_atcode02.text=="1112120"){//�������ޱ��� ��츸 �ŷ�ó�� ��������.
						gcem_vendnm02.Enable=true;	
					}else{
           			gcem_vendnm02.Enable=false;	
					}
				}else{
					gcem_vendnm02.Enable=true;	
				}
			}else{                                         //�μ��� �ƴҰ�� ����Ÿ�� ������ �����
			  if(k>=3){
					if(eval("txt_fsrefval0"+k).value!=""){
						eval("txt_fsrefval0"+k).disabled=true;
					}else{
						eval("txt_fsrefval0"+k).disabled=false;
					}
						
					if(eval("gcem_fsrvalnm0"+k).text!=""){
						eval("gcem_fsrvalnm0"+k).Enable=false;	
					}else{
						eval("gcem_fsrvalnm0"+k).Enable=true;	
					}
				}
			}
		}//for
	}else{//6����
		if(gcem_atcode02.text!="") {
			gcem_atcode02.Enable=false;
		}else{
			gcem_atcode02.Enable=true;
		}

		if(gcem_atkornam02.text!=""){
			gcem_atkornam02.Enable=false;
		}else{
			gcem_atkornam02.Enable=true;
		}

		if(gcem_detot02.text!="") {
			gcem_detot02.Enable=false;
		}else{
			gcem_detot02.Enable=true;
		}

		if(gcem_crtot02.text!=""){
			gcem_crtot02.Enable=false;
		}else{
			gcem_crtot02.Enable=true;
		}

		if(gclx_documcd02.bindcolval!=""&&gclx_documcd02.bindcolval!="000"){
			gclx_documcd02.Enable=false;
		}else{
			gclx_documcd02.Enable=true;
		}

		if(gcem_remark02_1.text!="") {
			gcem_remark02_1.Enable=false;
		}else{
			gcem_remark02_1.Enable=true;
		}

		if(gclx_fswrkdiv02.bindcolval!=""){
			gclx_fswrkdiv02.enalbe=false;
		}else{
		
		}

		for( k=1;k<=9;j++){
			if(eval("txt_fsrefcd0"+k).value=="0002"){       //�μ��� ��� ����Ÿ�� ������ �����
				if(txt_deptcd02_1.value!=""){
					txt_deptcd02_1.disabled=true;
				}else{
					txt_deptcd02_1.disabled=false;
				}
				if(gcem_deptnm02_1.text!=""){
					gcem_deptnm02_1.Enable=false;	
				}else{
					gcem_deptnm02_1.Enable=true;	
				}
			}else if(eval("txt_fsrefcd0"+k).value=="0020"){ //�ŷ�ó�� ��� ����Ÿ�� ������ �����
				if(txt_vendcd02.value!=""){
					txt_vendcd02.value.disabled=true;
				}else{
					txt_vendcd02.value.disabled=false;
				}
				if(gcem_vendnm02.text!=""){
					gcem_vendnm02.Enable=false;	
				}else{
					gcem_vendnm02.Enable=true;	
				}
			}else{                                         //�μ��� �ƴҰ�� ����Ÿ�� ������ �����
				if(k>=3){
					if(eval("txt_fsrefval0"+k).value!=""){
						eval("txt_fsrefval0"+k).disabled=true;
					}else{
						eval("txt_fsrefval0"+k).disabled=false;
					}

					if(eval("gcem_fsrvalnm0"+k).text!=""){
						eval("gcem_fsrvalnm0"+k).Enable=false;	
					}else{
						eval("gcem_fsrvalnm0"+k).Enable=true;	
					}
				}
			}
		}//for
	}//if gubun
}

/******************************************************************************
	Description : ��ü��ν� Lock ����
******************************************************************************/
function ln_Lock_false(){
 
	gcem_atcode02.Enable=true;
	gcem_atkornam02.Enable=true;
	gcem_detot02.Enable=true;
	gcem_crtot02.Enable=true;
	gclx_documcd02.Enable=true;
	gcem_remark02_1.Enable=true;
	gclx_fswrkdiv02.Enable=false;
	gcem_deptnm02_1.Enable=true;	
	for (k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).Enable=true;	
	}
}
/******************************************************************************
	Description : ����Ÿ�� ����
******************************************************************************/
function ln_Fswrkdiv_Setting(){
		
	var stratcode = gcem_atcode02.text;
	stratcode = stratcode.substring(0,2);
	
	if (stratcode =="43"){ //������� ���� - ����Ÿ�� Ǯ�����. 
		//�ݰ����� ����ó�� 2007.05.19 ������
		if(gclx_fdcode02.bindcolval=="03"||gclx_fdcode02.bindcolval=="04"){
			gclx_fswrkdiv02.enable = false;
		}else{
			gclx_fswrkdiv02.enable = true;
		}
	}else{
    	gclx_fswrkdiv02.enable = false;
	}

	for(f=3;f<=9;f++){
	
		if (eval("txt_fsrefcd0"+f).value=="0003"){	
		    //�ݰ����� ����ó�� 2007.05.19 ������
			if(gclx_fdcode02.bindcolval=="03"||gclx_fdcode02.bindcolval=="04"){
        		gclx_fswrkdiv02.bindcolval="01";
			}else{
				if (stratcode =="43"){ //������� ���� - ����Ÿ�� Ǯ�����. 
					//2015.05.22 jys - ����ȣ �븮 ��û
					gclx_fswrkdiv02.bindcolval="01"; 
				}else{
					gclx_fswrkdiv02.bindcolval="02";	
				}
				
			}
			return;
			break;
		} 
	}
  gclx_fswrkdiv02.bindcolval="01";
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// üũ�׸� (Start:::::::::::::::::::::::>>>>>
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : üũ
	parameter   : p1-����
******************************************************************************/
function ln_Chk(p1){

  if(gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
		return false;
	}

	if (p1=="02"){
		//�����뺯 ���� Ȯ��
		if(gcem_detot02.text!=gcem_crtot02.text){
			alert("�����հ�� �뺯�հ谡 ���� �ʽ��ϴ�.");
			return false;
		}
		return true; 
	}
}
/******************************************************************************
	Description : ����üũ
	parameter   : p1-����
******************************************************************************/
function ln_Chk_Save(){
    var no1="";
	var no2="";
    var stryymmdd="";
    var stryyyy = "";
	var strmm = "";
	var	strbgtdept= "";
	var	strbgtdiv ="";
	var	stratcode ="";
	var dblamt=0;
	var strBanjaechk="";
	var m=0;
	var strDelChk="";

	stryymmdd = gcem_actdat02.text;

	//�ڵ���ǥ üũ///////////////////////////////////////////////////////////////
    //�Ǽ�ERP���� ������ ���� �����Ұ� FSKND ='J' 
    //2015.09.01 
    if(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSKND")=="J") {
    	alert("�ش� ��ǥ�� �Ǽ�ERP���� �ڵ������� ��ǥ�Դϴ�. ���� �Ұ��Դϴ�.");
		return false;
    }
	///////////////////////////////////////////////////////////////////////////

	if(gcds_dtl.countrow<2){
		alert("������ �� �����ϴ�.");
		return false;
	}

	//����üũ
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){ // ȸ��μ� ��ǥ���� üũ
		 ln_Slip_Close_Query();
		 if(gcds_slip_close.namevalue(gcds_slip_close.rowposition,"SLPCLOSE")=="T"){
				alert("��ǥ �Է��� �����Ǿ����ϴ�. Ȯ�� �ٶ��ϴ�.");
				return false;
		 }
	}else{                                    // ������ǥ���� üũ
		 ln_Slip_Close_Query();
		 if(gcds_slip_close.namevalue(gcds_slip_close.rowposition,"WORKCLOSE")=="T"){
				alert("���� ��ǥ �Է��� �����Ǿ����ϴ�. Ȯ�� �ٶ��ϴ�.");
				return false;
		 }
	}

	/*&&&&&&&&&&&&&&
	if(gcds_tax.countrow>0){
		if(g_taxval!=parent.gcem_detot02.text){
			alert("���ݰ�꼭�ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.");
		}
	}
	&&&&&&&&&&&&&&&*/

	//�α����� ����� ����� ����� ���� ������ ���� �� ���� ����.
	//alert("gs_userid!"+gs_userid+"txt_empno02.value)"+txt_empno02.value);
    if(gs_userid!=txt_empno02.value){
		alert("�ۼ��ڿ� �������� �ʽ��ϴ�.");
		return false;
	}else{
		if(gs_userid==""||gs_userid==undefined){
			alert("�ۼ��ڸ� Ȯ���Ͻʽÿ�.");
			return false;
		}
	}

	if(gclx_fdcode02.bindcolval==""){
		alert("������ �����Ͻʽÿ�.");
		return false;
	}

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�� ��ǥ�Դϴ�.");
		return false;
	}

    if(gclx_fsstat02.bindcolval=="R"){
		alert("�����û�� ��ǥ�Դϴ�.");
		return false;
	}

	if(gclx_fsstat02.bindcolval=="C"){
		alert("������ҵ� ��ǥ�Դϴ�.");
		return false;
	}
  
	if(gcem_fs02.text==""||gcem_fsdat02.text==""){
		alert("������ȣ�� Ȯ���Ͻʽÿ�.");
		return false;
	}
	
	//�����뺯 ���� Ȯ��
	if(gcds_dtl.Sum(9,0,0)!=gcds_dtl.Sum(10,0,0)){
		alert("�����հ�� �뺯�հ谡 ���� �ʽ��ϴ�.");
		return false;
	}

  //DataSet �Ǻ��� üũ�ϱ� 
	for(i=1;i<=gcds_dtl.countrow;i++){
    //������ �����ϴ� ���� �����ϰ� �Էµǰ���.
		if(gcds_dtl.namevalue(i,"FSNUM")!=""&&gcds_dtl.namevalue(i,"ATCODE")==""&&gcds_dtl.namevalue(i,"ATKORNAM")==""&&
		   gcds_dtl.namevalue(i,"CHAAMT")==0&&gcds_dtl.namevalue(i,"DAEAMT")==0){
			 //alert("step1");
			 return true;
		}
	  
    /////////////////////////////////////// 
    //�ʼ��׸�üũ
    /////////////////////////////////////// 
		if(gcds_dtl.namevalue(i,"ATCODE")==""){
		  gcds_dtl.rowposition = i;
			alert("�����ڵ带 �Է��Ͻʽÿ�");
			gcem_atcode02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"ATKORNAM")==""){
		  gcds_dtl.rowposition = i;
			alert("�������� �Է��Ͻʽÿ�");
			gcem_atkornam02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"CHAAMT")==0&&gcds_dtl.namevalue(i,"DAEAMT")==0){
			gcds_dtl.rowposition = i;
			alert("�ݾ��� �Է��Ͻʽÿ�");
			gcem_detot02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"CHAAMT")!=0&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
			gcds_dtl.rowposition = i;
			alert("�����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
			gcem_detot02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103"||gcds_dtl.namevalue(i,"DOCUMCD")=="104"){
			if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
				gcds_dtl.rowposition = i;
				alert("������ȣ�� �����ϴ�. Ȯ���Ͻʽÿ�");
				return false;
			}
		}
		
		//2017.03.03.JYS ä��(��)�з� ��ü üũ�����ݿ�
		//alert(i+"::CREDGB::"+gcds_dtl.namevalue(i,"CREDGB")+"::::"+gcds_dtl.namevalue(i,"FSREFVAL02"));
		if(gcds_dtl.namevalue(i,"CREDGB")=="1"||gcds_dtl.namevalue(i,"CREDGB")=="2"){
			if(!ln_Bond_Attach_Chk(gcds_dtl.namevalue(i,"FSREFVAL02"),i)){
				return false;
			}
		}
		
		//2015.02.26 JYS (������ ��û) dhl
		//�ܻ���Ա�, �����ޱ��� �Ϲݾ�ü �� ���� �߻��� ��� ������ �ʼ� - ��꼭 ��ȣ Ȯ��
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		if(chkbox_1.checked==false){
		
			//�ܻ���Ա� �߻���ǥ
			if(gcds_dtl.namevalue(i,"ATCODE")=="2100110"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
		    	m=0;
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="02"){
		        
						if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
							gcds_dtl.rowposition = i;
							alert("�ܻ���Ա� �Ϲݾ�ü�� ������ȣ�� �ʼ��׸�ϴ�.Ȯ���Ͻʽÿ�2");
							return false;
						}
				    }
		    	}
		    }
			
			
			//�����ޱ� �߻���ǥ 
			if(gcds_dtl.namevalue(i,"ATCODE")=="2100510"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
			   	m=0;
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1013"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="008"){
			       
						if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
							gcds_dtl.rowposition = i;
							alert("�����ޱ� �Ϲݾ�ü�� ������ȣ�� �ʼ��׸��Դϴ�. Ȯ���Ͻʽÿ�2");
							return false;
						}
				   }
			   	}
			}
		}
		
	   //2015.09.01. JYS ( �������/������� ��� ����� ���� CLOSS üũ)  �̿��� ////////////////////////
	   if(gcds_dtl.namevalue(i,"ATCODE")=="4331700"){
		   	m=0;
			for(k=3;k<=9;k++){
				if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1103"){
					if(gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="002"){ // ��꼭
						if(gcds_dtl.namevalue(i,"DOCUMCD")!="102"){ //������ ��꼭�� �ƴϸ� üũ 
							alert("�������  ����񱸺��� Ȯ���Ͻʽÿ�1.");
							return false;
						}
					}else if(gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="002"){ // ���ݰ�꼭 
						if(gcds_dtl.namevalue(i,"DOCUMCD")!="101"){ //������ ���ݰ�꼭�� �ƴϸ� üũ 
							alert("�������  ����񱸺��� Ȯ���Ͻʽÿ�2.");
							return false;
						}
					}
				 }
			 }	   	
		}	
	   ///////////////////////////////////////////////////////////////////////////////////////
	   
		
	   //2015.06.22. JYS ( ��ǥ���� ��Ͻ� �ܻ���Ա�, �����ޱ� �Ϲݾ�ü�� ���� ���ϰ� ����.)
	   
	   //���� �������� ���޺ΰ���, �����ΰ����� �ƴѰ��
	   //�ܻ���Ա�, �����ޱ��� �Ϲݾ�ü �� ���� �߻��� �ƴ� ���� ���� �� ������ ��� ������.
	   /**
	   if(gcds_dtl.namevalue(i,"DOCUVAL")!=""){
		   if(gcds_dtl.namevalue(i,"ATCODE")!="1112300"&&gcds_dtl.namevalue(i,"ATCODE")!="2101100"){
			   
			   if(gcds_dtl.namevalue(i,"ATCODE")=="2100510"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
				   
				   m=0;
				   for(k=3;k<=9;k++){
					   if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1013"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="008"){
						   strDelChk="1";
					   }
					   
					   if(strDelChk!="1"){
						   gcds_dtl.namevalue(i,"DOCUVAL")="";
						   gcds_dtl.namevalue(i,"DOCUMCD")="000";
						   strDelChk="";
					   }
				   }	   
				   
			   }else if(gcds_dtl.namevalue(i,"ATCODE")=="2100110"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
				   m=0;
				   for(k=3;k<=9;k++){
					   if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="02"){
						   strDelChk="2";
					   }
					   if(strDelChk!="2"){
						   gcds_dtl.namevalue(i,"DOCUVAL")="";
						   gcds_dtl.namevalue(i,"DOCUMCD")="000";
						   strDelChk="";
					   }
				   }	   
			   }else{
				   gcds_dtl.namevalue(i,"DOCUVAL")="";
				   gcds_dtl.namevalue(i,"DOCUMCD")="000";
			   }
		   
		   }else{
			   
		   }
	   }else{
		   
	   }
	   **/
	   
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
     //�����ΰ����ӽ�20070423
	 /*
    	//������ ���޺ΰ���ġ�� �����ΰ�� ���ݰ�꼭�� ������ ����ȵ�.
		//�뺯�� �Է� �� ���� üũ ����.
		if(gcds_dtl.namevalue(i,"ATCODE")=="1112300"){
		  if(gcds_dtl.namevalue(i,"CHAAMT")!=0){
				if((gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103")&&gcds_dtl.namevalue(i,"DOCUVAL")!=""){
				}else{
					gcds_dtl.rowposition = i;
					alert("�ش������ ���ݰ�꼭�� �����ؾ� �մϴ�.");
					return false;
				}
			}
		}
		//������ �����ΰ���ġ�� �뺯�ΰ�� ���ݰ�꼭�� ������ ����ȵ�.
		//������ �Է� �� ���� üũ ����.



	 if(gcds_dtl.namevalue(i,"ATCODE")=="2101100"){
		  if(gcds_dtl.namevalue(i,"DAEAMT")!=0){
				if((gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103")&&gcds_dtl.namevalue(i,"DOCUVAL")!=""){
				}else{
					gcds_dtl.rowposition = i;
					alert("�ش������ ���ݰ�꼭�� �����ؾ� �մϴ�.");
					return false;
				}
			}
		}
 */
		//�ŷ�ó
		if(gcds_dtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL02")==""||gcds_dtl.namevalue(i,"FSRVALNM02")=="")){
			gcds_dtl.rowposition = i;
			alert("�ŷ�ó�� �ʼ��׸��Դϴ�.");
			gcem_vendnm02.focus(); 
			return false;
		}

		//�μ� 
		if(gcds_dtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL01")==""||gcds_dtl.namevalue(i,"FSRVALNM01")=="")){
			gcds_dtl.rowposition = i;
			alert("�μ��� �ʼ��׸��Դϴ�.");
			gcem_deptnm02_1.focus(); 
			return false;
		}

		//����
		if(gcds_dtl.namevalue(i,"REMARK")==""){
			gcds_dtl.rowposition = i;
			alert("������ �Է��Ͻʽÿ�");
			gcem_remark02_1.focus();
			return false;
		}

		//�����׸�üũ
		m=0;
		for(k=3;k<=9;k++){
			if(gcds_dtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_dtl.namevalue(i,"FSRVALNM0"+k)=="")){
				//�����׸� (FDREFCD)��  ����μ�(0003)�� ���������� 
				//������ �������� ���� �ʼ��׸񿡼� ������(��������ǰ��)
				if(gcds_dtl.namevalue(i,"FSWRKDIV")=="01"){
					no1 = ln_Bgt_DataSet_Dept_find(i);  //����μ� ã��0003
					if(no1==""||no1==undefined){                                 //����μ� ������
						tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
						alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
						m=k;
						gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus(); 
						return false;
					}else{ //����μ� ����� ����μ��� �����ϰ� �ʼ��׸�üũ
						if(gcds_dtl.namevalue(i,"FSREFCD0"+k)!="0003"){
							tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
							m=k;
							alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
							gcds_dtl.rowposition = i;
							eval("gcem_fsrvalnm0"+m).focus(); 
							return false;
						}
					}
				}else{
				  m=k;
					tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
					alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
					gcds_dtl.rowposition = i;
					eval("gcem_fsrvalnm0"+m).focus(); 
					return false;
				}
			}
		}//for k

		//��¥üũ
		var strReturn="";
		m=0;
		for(k=3;k<=9;k++){
		  if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0966"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0968"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0969"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0970"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1044"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1048"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1051"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1052"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1053"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1089"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1098"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1099"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1125"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1126"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1127"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1130"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1206"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1185"){
        
				if(gcds_dtl.namevalue(i,"FSREFCD0"+k)!=""&&gcds_dtl.namevalue(i,"FSREFCD0"+k)!=undefined){
					strReturn= gf_ChkNumber2(gcds_dtl.namevalue(i,"FSREFVAL0"+k));
					if(strReturn==false){
					  m=k;
					  gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus();
						return false;
					}
				}
		   }
		  
		  	 //2012.11.05 JYS ��ȭ �ݾ������� �� ���  �޸��� �Է� �Ұ� ////////////////////////////
			if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1045"){  //��ȭ�ݾ��ϰ��
			    strReturn = gcds_dtl.namevalue(i,"FSREFVAL0"+k);
			    
			    //2016.04.05.jys ��ȯ�ݾ�  �⺻�� �ݿ�
			    if (strReturn=="-"){
			    	alert("��ȭ�ݾ׿��� ���ڸ� �Է��Ͻʽÿ�.");
			    	return false;
			    }else if (fn_trim(strReturn)==""){
			    	alert("��ȭ�ݾ��� �����Դϴ�.");
			        return false;
			    }
			    
			    if(parseInt(strReturn)>=0){
			    	
			    	//2016.09.20 jys ���ݽ������� ����(��ȭ)������ �׻� >0 ��.
			    	if(gcds_dtl.namevalue(i,"ATCODE")=="1110120"&&parseInt(strReturn)==0){
			    		alert("����(��ȭ) ������ ��ȭ�ݾ��� 0 ���� ũ�� �մϴ�.");
			    		return false;
			    	}
			    	
			    }else if(parseInt(strReturn)<0) {

			    }else{
			    	
			    	if(gs_userid=="2110017"){
			    		//alert("::::"+strReturn+"::::");
			    	}
			    	
			    	alert("��ȭ�ݾ��� ���� Ÿ���� �ƴմϴ�. Ȯ�� �ٶ��ϴ�.");
			    	return false;
			    }
			    
			  
				for(var n=0;n<strReturn.length;n++){
					if(strReturn.charAt(n)==","){
					    m=k;
					    gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus();
						alert("��ȭ�ݾ׿� �޸��� �����ϼ���.");
						return false;
					}
				}
			}
			///////////////////////////////////////////////////////////////////////////////////////////
         }//for k                        

		//==================================================================
		//�ݰ����� ��� �����׸��� ��ȭ�ݾ��� ��� üũ��.
		//==================================================================
		//2007.05.09 üũ��� ���� 
	  //���� : �����ڵ� �ϵ��ڵ� ==> ���� : ACTCODE ���̺��� ATCURTYPE�� Y�� ���� üũ��.
		var stratcode=gcds_dtl.namevalue(i,"ATCODE");
		stratcode=stratcode.substring(0,3);
		if(gclx_fdcode02.bindcolval=="03"){
			for(b=3;b<=9;b++){
				//if(gcds_dtl.namevalue(i,"ATCODE")=="1112200"||gcds_dtl.namevalue(i,"ATCODE")=="2101000"||stratcode=="112"||stratcode=="122"||stratcode=="123"){
				if(gcds_dtl.namevalue(i,"ATCURTYPE")=="Y"){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+b)=="1045"){  //��ȭ�ݾ��ϰ��(�ݰ����� ��ȭ�� �ݾ���)
						if((gcds_dtl.namevalue(i,"FSREFVAL0"+b)==""||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="")||
							 (gcds_dtl.namevalue(i,"FSREFVAL0"+b)=="0"||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="0")||
							 (gcds_dtl.namevalue(i,"FSREFVAL0"+b)=="-"||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="-")){
							alert("��ȭ�ݾ׶��� �ݾ��� �Է��Ͻʽÿ�.");
							gcds_dtl.rowposition = i;
							eval("gcem_fsrvalnm0"+b).focus(); 
							return false;
						}else{				  
							if(!gf_ChkNumber3(gcds_dtl.namevalue(i,"FSRVALNM0"+b))){
								gcds_dtl.rowposition = i;
								eval("gcem_fsrvalnm0"+b).focus(); 
								return false;
							}
						}
					}
				}
			}//for
		}//03


		/////////////////////////////////////// 
    //����üũ
    /////////////////////////////////////// 
		//����Ÿ��üũ
		if(gcds_dtl.namevalue(i,"FSWRKDIV")=="02"){
			strbgtdept="";
			strbgtdiv="";
			stratcode="";
			strrefcd="";
			strrefval="";
			dblamt=0;
			no1="";
			no2="";

			no1 = ln_Bgt_DataSet_Dept_find(i);                 //����μ� ã��
			no2 = ln_Bgt_DataSet_Type_find(i);                 //������ġ ã��  
							
			if(no1==""||no1==undefined){
				alert("����μ��� �������� �ʽ��ϴ�.");
				return false;
			}

			if(no2==""||no2==undefined){
				alert("�������� Ÿ���� �������� �ʽ��ϴ�.");
				return false;
			}

			//����μ��� ��������׸��� ��� ������ 00�� ����
			if(gcds_dtl.namevalue(i,"FSREFCD"+no2)=="0003"){
				strrefcd = gcds_dtl.namevalue(i,"FSREFCD"+no2);
				strrefval="00";	                                //����  
			}else{
				strrefcd =gcds_dtl.namevalue(i,"FSREFCD"+no2);
				strrefval=gcds_dtl.namevalue(i,"FSREFVAL"+no2); //����    
			}

			//2007.10.18 ������ �߰�
			//ȸ�����ڸ� ������ ��� DTL����Ÿ ����������.
			gcds_dtl.namevalue(i,"REMARK")=gcds_dtl.namevalue(i,"REMARK")+" ";
			
			strmm = fn_trim(stryymmdd.substring(4,6));
			stryyyy = fn_trim(stryymmdd.substring(0,4));
			strbgtdept= gcds_dtl.namevalue(i,"FSREFVAL"+no1); //����μ�
			strbgtdiv = gcds_dtl.namevalue(i,"BGTDIV");       //���꺻��  
			stratcode = gcds_dtl.namevalue(i,"ATCODE");       //��������   
			dblamt = Number(gcds_dtl.namevalue(i,"CHAAMT"))+Number(gcds_dtl.namevalue(i,"DAEAMT")); 
			
			//2014.07.17.jys - ����� ���� ä���� ��û���� ���� üũ����.
	        /***				
			ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,'02',i);
			
			if(gcds_bgt.countrow>=1){  //
				//alert("JANAMT::"+gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT"));
				if(gcds_dtl.SysStatus(i)==1){ //�ű��Է�
					if(gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT")< dblamt){
						gcds_dtl.rowposition = i;
						alert("�����ܾ��� �� �۽��ϴ�. Ȯ�� �ٶ��ϴ�.");
						return false;
					}
				}else if(gcds_dtl.SysStatus(i)==3){//����
				  //�ܾ�+�������ݾ� < �����ݾ�==>�����Ұ���
					if(gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT")+gcds_dtl.OrgNameValue(i,"CHAAMT")+gcds_dtl.OrgNameValue(i,"DAEAMT")<dblamt){
						gcds_dtl.rowposition = i;
						alert("�����ܾ��� �� �۽��ϴ�. Ȯ�� �ٶ��ϴ�.");
						return false;
					}
				}
			}else{
				gcds_dtl.rowposition=i;
				alert("������ �����ϴ�.");
				ln_Bgt_Amt_Clear();
				return false;
			}
			***/
			
		}//if ����

		////////////////////////////////////////////////// 
        //����üũ
		//����:
		//��ü����� �ش� ������ ���ؼ� �߻��� 
		//�ƴ� ������ ��� ������ �Է����� ������
		//üũ��.

		//�߰� ���� :
		//�������� �����ϰ� ��.

		//�߰� ���� : 2010.06.15 ��繬 GJ ��û 
		//���� �߻��� ��� (-) �ݾ� �ԷºҰ� 

		//����ó�� : ��繬 GJ �� �Է°��� ( ��繬GJ ��û 2011.01.19
        ///////////////////////////////////////////////// 
		//��������Ÿ üũ(���������̸鼭,
		strBanjanChkAmt=0;
		if(gcds_dtl.namevalue(i,"BANJAEYN")=="Y"){ //����
			 
			 if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				 //////////////////////////////////////////////////////////////////
				 //2010.06.15
				 if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //����
						if(gcds_dtl.namevalue(i,"CHAAMT")<0){
							alert("�ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
							gcds_dtl.rowposition = i;
							return false;
						}
				 }else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){ //�뺯
						if(gcds_dtl.namevalue(i,"DAEAMT")<0){
							alert("�ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�. all ");
							gcds_dtl.rowposition = i;
							return false;
						}
				 }
				 //////////////////////////////////////////////////////////////////
			 }
	 

			if(gcds_dtl.namevalue(i,"BANJAEMOD")=="Y"){//������������ ��� ���� ������.
			   //�����ݾװ� ���� �ݾ� ����. 
				 if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //����
					 if(!ln_Banjae_Data_Delete(i,'1')){
								gcds_dtl.rowposition = i;
								return false;
					 };
				 }else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){	
						if(!ln_Banjae_Data_Delete(i,'2')){
						  gcds_dtl.rowposition = i;
							return false;
						}
				 }
			}else{ // �Ϲ� �������� ó���ݾװ� �����ݾ��� ������ ��츸 ���� ������.
				if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //����
					if(gcds_dtl.OrgNameValue(i,"DAEAMT")!=gcds_dtl.namevalue(i,"DAEAMT")){
						if(gcds_dtl.namevalue(i,"DAEAMT")!=0&&gcds_dtl.namevalue(i,"DAEAMT")!=""){
							//���� ���ῡ ������ �������� ������
								for(b=1;b<=gcds_banjae.countrow;b++){
									if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
										strBanjaechk="T";
										break;
									}
								}//for

								if(strBanjaechk!="T"){
									gcds_dtl.rowposition = i;
									alert("���������Դϴ�. Ȯ�� �ٶ��ϴ�.");	
									return false;
								}else{
									strBanjaechk="";
								}
						}
					}else{//�ݾ��� ������ ���(�ű��Է��϶� �Ȱ��� if(gcds_dtl.OrgNameValue(i,"DAEAMT")!=gcds_dtl.namevalue(i,"DAEAMT")){
						//�����ݾװ� ���� �ݾ� ����.
						if(gcds_dtl.SysStatus(i)==1){ //�ű��Է°�
							if(!ln_Banjae_Data_Delete(i,'1')){
								gcds_dtl.rowposition = i;
								return false;
							};
						}
					}
				}else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){
					if(gcds_dtl.OrgNameValue(i,"CHAAMT")!=gcds_dtl.namevalue(i,"CHAAMT")){
						if(gcds_dtl.namevalue(i,"CHAAMT")!=0&&gcds_dtl.namevalue(i,"CHAAMT")!=""){
							//���� ���ῡ ������ �������� ������
							for(b=1;b<=gcds_banjae.countrow;b++){
								if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
									strBanjaechk="T";
									break;
								}
							}
							if(strBanjaechk!="T"){
								gcds_dtl.rowposition = i;
								alert("���������Դϴ�. Ȯ�� �ٶ��ϴ�.");	
								return false;
							}else{
								strBanjaechk="";
							}
						}
					}else{//�ݾ��� ������ ���(�ű��Է��϶� �Ȱ��� //if(gcds_dtl.OrgNameValue(i,"CHAAMT")!=gcds_dtl.namevalue(i,"CHAAMT")){
						//�����ݾװ� ���� �ݾ� ����.
						if(gcds_dtl.SysStatus(i)==1){ //�ű��Է°�
							if(!ln_Banjae_Data_Delete(i,'2')){
								gcds_dtl.rowposition = i;
								return false;
							}
						}
					}
				}
			} //if(gcds_dtl.namevalue(row,"BANJAEMOD")=="Y"){//����������
		}//if(gcds_dtl.namevalue(i,"BANJAEYN")=="Y"){ //����

    //2008.05.17. ������ �߰� ///////////////////////////////////////////////////////////////////////////////////////////////////
		//�����ڵ� : ��������, �ݰ��������� ��� ���μ��� ���籸������ ��� ����ǰ�ǹ�ȣ�� üũ�Ѵ�.
		//��...�ű԰Ǹ� üũ�Ѵ�. �������� ��� �� ������ ����.
		if(gcds_dtl.namevalue(i,"ATCODE")=="1250000"||gcds_dtl.namevalue(i,"ATCODE")=="1260000" ){ //�ݰ������� �������� 
			if(txt_deptcd02.value=="C320" ){ //��ǥ�ۼ��μ��� ������������ ���  ***********************************************���� ���� ���涧���� �ٲ������.
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1241"){ //����ǰ�ǹ�ȣ
					   //alert("i::::"+i+":::::üũ5"+"k::::"+k+"::::::::"+gcds_dtl.namevalue(i,"FSRVALNM0"+k));
						 if(fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))==""||fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))=="-"||fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))=="0"){
								alert("����ǰ�ǹ�ȣ�� �� �Է��ϼž� �մϴ�.");
								gcds_dtl.rowposition = i;
								return false;
						 }else{
						    if(gcds_dtl.SysStatus(i)==1){ //�ű԰Ǹ� üũ
 								  if(!ln_Buy_No_Find(gcds_dtl.namevalue(i,"FDCODE"),gcds_dtl.namevalue(i,"ATCODE"),gcds_dtl.namevalue(i,"FSRVALNM0"+k))){
										 gcds_dtl.rowposition = i;
										 return false;
									}
								}
						 }
					}
				}//for k                     
			}
		}
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //2011.11.21. jys -  �ſ�ī��(����), ���ݿ�����(����) �� ���
		//���޺ΰ���ġ���� ��Ÿ�ΰ����� �ƴϸ� üũ 
		if(gcds_dtl.namevalue(i,"DOCUMCD")=="103"||gcds_dtl.namevalue(i,"DOCUMCD")=="104" ){ 
			for(var x=3;x<=9;x++){
				if(gcds_dtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //���޺ΰ���ġ��
					if(gcds_dtl.namevalue(i,"FSREFVAL0"+x)!="04"){
					    gcds_dtl.rowposition = i;
						alert("�������� �ſ�ī��(����), ���ݿ�����(����)�� ��� ���޺ΰ���ġ�� �׸��� ��Ÿ�ΰ����Դϴ�. ");
						return false;
					}
				}
			}
		}
     //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    //2007.05.11 ������ �߰� : ��ǥ MST�� DTL ��ǥ��ȣ üũ
    var mstfsdat = gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSDAT1")+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSDAT2") ; 
		//alert("FDCODE::"+gcds_dtl.namevalue(i,"FDCODE")+":"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE"));
		//alert("FSDAT::"+gcds_dtl.namevalue(i,"FSDAT")+":"+mstfsdat);
		//alert("FSNBR::"+gcds_dtl.namevalue(i,"FSNBR")+":"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
    if(gcds_dtl.namevalue(i,"FDCODE")==gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")&&
		   gcds_dtl.namevalue(i,"FSDAT")==mstfsdat &&
			 gcds_dtl.namevalue(i,"FSNBR")==gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR")){
		}else{
			alert("������ȣ�� Ʋ���ϴ�.");
			alert("i:::"+i+":::gcds_dtl:::"+gcds_dtl.namevalue(i,"FDCODE")+gcds_dtl.namevalue(i,"FSDAT")+gcds_dtl.namevalue(i,"FSNBR")+":::::mst::"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")+mstfsdat+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
			
			if(gusrid=="6070001"){
				alert("i:::"+i+":::gcds_dtl:::"+gcds_dtl.namevalue(i,"FDCODE")+gcds_dtl.namevalue(i,"FSDAT")+gcds_dtl.namevalue(i,"FSNBR")+":::::mst::"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")+mstfsdat+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
			}

			return false;
		}
	}//for i
	return true;
}

/******************************************************************************
	Description : �˾�üũ
	parameter   : p1-���� �����׸� ��ġ
******************************************************************************/
function ln_Chk_Popup(p1){
	//�������� & ����<>0 & �뺯 = 0 (�߻� ==> �Է�)
	//������ȣ, ���� ������, ���� �߻����� �Է��ؾ���. �˾�����. 
	if(p1>2){
		if(hid_funddiv.value=="50"&& gcem_detot02.text!=0 && gcem_crtot02.text==0){
			if(eval("txt_fsrefcd0"+p1).value=="0967"||eval("txt_fsrefcd0"+p1).value=="0968"||eval("txt_fsrefcd0"+p1).value=="0969"){
				return false;
			}
		}else{

		}
	}

	//�����׸��ڵ尡 ���� ��� return
  if(eval("txt_fsrefcd0"+p1).value=="") return false;

  //������ȣ�̸鼭 �����뺯�� ��� 0�ϰ��� �ݾ��� üũ�ؾ���.
	if(eval("txt_fsrefcd0"+p1).value=="0967"&&gcem_detot02.text==0 && gcem_crtot02.text==0){
		alert("�ݾ��� ���� �Է��Ͻʽÿ�.");
		return false;
	}
	return true;
}

/******************************************************************************
	Description : ���� ���� üũ
	parameter   : 
******************************************************************************/
function ln_Chk_Repay(row){
  if(gcds_dtl.countrow<1||row<1){
		alert("���� �Ͻ� ������ �����Ͻʽÿ�.");
	}

	//�������� üũ - ���� ������ ������. && �ŷ�ó �ʼ� && �����뺯�ݾ� 0 üũ
	if(gcds_dtl.namevalue(row,"ATCODE")==""||gcds_dtl.namevalue(row,"ATKORNAM"=="")){
		alert("������ �������� �ʽ��ϴ�.");
		return false;
	}
	  
	if(gcds_dtl.namevalue(row,"BANJAEYN")!="Y"){
		//�������� ��Ȯ��
		if(!ln_banjae_atcode_find(gcds_dtl.namevalue(row,"ATCODE"))){
			alert("���� ������ ������ �ƴմϴ�.");
			return false;
		}
	}

  /*
	alert("ATDECR::" +gcds_dtl.namevalue(row,"ATDECR"));
	alert("CHAAMT::" +gcds_dtl.namevalue(row,"CHAAMT"));
	alert("DAEAMT::" +gcds_dtl.namevalue(row,"DAEAMT"));
	*/	
	if(gcds_dtl.namevalue(row,"ATDECR")=="1"){  //����
		if(gcds_dtl.namevalue(row,"CHAAMT")!=0){
			alert("���� ������ ������ �����ݾ� �Ұ��Դϴ�.");
			return false;
		}
	}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){  //�뺯
		if(gcds_dtl.namevalue(row,"DAEAMT")!=0){
			alert("���� ������ ������ �뺯�ݾ� �Ұ��Դϴ�.");
			return false;
		} 
	}else{
		if(ln_banjae_atcode_find(gcds_dtl.namevalue(row,"ATCODE"))){
			if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDECR")=="1"){
				if(gcds_dtl.namevalue(row,"CHAAMT")!=0){
					alert("���� ������ ������ �����ݾ� �Ұ��Դϴ�.");
					return false;
				}
			}else if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDECR")=="2"){
				if(gcds_dtl.namevalue(row,"DAEAMT")!=0){
					alert("���� ������ ������ �뺯�ݾ� �Ұ��Դϴ�.");
					return false;
				} 
			}
		}
	}

	//�ŷ�ó Ȯ��
	_out:
	for(k=1;k<=9;k++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0020"){
		   //alert("k:"+k+"row:"+row+":"+gcds_dtl.namevalue(row,"FSREFVAL0"+k)+":"+gcds_dtl.namevalue(row,"FSRVALNM0"+k));
			 if(gcds_dtl.namevalue(row,"FSREFVAL0"+k)==""||gcds_dtl.namevalue(row,"FSRVALNM0"+k)==""){
					alert("�ŷ�ó�� �ʿ��մϴ�.");
					return false;
					break _out;
			 }
		}
	}//k
	
	return true; 
}

/******************************************************************************
	Description : ������ ����üũ
	parameter   : p1 - FDCODE,
	              p2 - FSDAT, 
								p3 - FSNBR
******************************************************************************/
function ln_Chk_Del_Banjae(p1,p2,p3){
	if(p1!=""&&p2!=""&&p3!=""){
		gcds_banjae2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s13?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;	
		//prompt("",gcds_banjae2.DataID);
		gcds_banjae2.Reset();

		if (gcds_banjae2.CountRow>0){  
			return true;
		}else{
			return false; 
		}
	}else{
		return false;
	}
}


/******************************************************************************
	Description : ������� ����üũ --���������� ��츸 üũ��
	parameter   : p1 - FDCODE,
	              p2 - FSDAT, 
								p3 - FSNBR,
								p4 - FSSEQ
******************************************************************************/
function ln_Chk_Row_Del_Banjae(p1,p2,p3,p4){
	if(p1!=""&&p2!=""&&p3!=""&&p4!=""){
		gcds_banjae3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s22?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3+"&v_str4="+p4;	
		//prompt("",gcds_banjae3.DataID);
		gcds_banjae3.Reset();

		if(gcds_banjae3.CountRow>0){  //��������Ÿ�� ����
			return true;
		}else{		
			return false; 
		}
	}else{
		return false;
	}
}


/******************************************************************************
	Description : ��������üũ
	parameter   : p1-����
******************************************************************************/
function ln_Chk_Banjae_Amt(){	

  var row = gcds_dtl.rowposition;
	if(row<1)return;

	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){ //����
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //����
			if(gcds_dtl.namevalue(row,"DAEAMT")!=0&&gcds_dtl.namevalue(row,"DAEAMT")!=""){
				//�ŷ�ó Ȯ��
				if(!ln_Vend_Find(row)) return;
				ln_Popup_Repay();
			}
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){
			if(gcds_dtl.namevalue(row,"CHAAMT")!=0&&gcds_dtl.namevalue(row,"CHAAMT")!=""){
				//�ŷ�ó Ȯ��
				if(!ln_Vend_Find(row)) return;
				ln_Popup_Repay();
			}
		}
	}
}
/******************************************************************************
	Description : ������üũ - �������� ���Ͱ��� �Է½� ���� üũ
	parameter   : 
******************************************************************************/
function ln_Chk_Atcode_Amt(){

	 var temp = gcem_atcode02.text;
	 var str1char = temp.substring(0,1);
	 var str2char = temp.substring(0,2);
	 var str3char = temp.substring(0,3);

	 if(str1char=="4"){ //��� ���Ͱ���
			if(hid_atdecr.value=="1"){ //����
				if(gcem_crtot02.text!=0&&gcem_crtot02.text!=""){
					alert("�ش������ �뺯�� �Է��� �� �����ϴ�.");
					gcem_crtot02.text=0;
					gcem_detot02.focus();
					return;
				}
			}else if(hid_atdecr.value=="2"){//�뺯
				if(gcem_detot02.text!=0&&gcem_detot02.text!=""){
					alert("�ش������ ������ �Է��� �� �����ϴ�.");
					gcem_detot02.text=0;
					gcem_crtot02.focus();
					return;
				}
			}
	 }

	if((gcem_detot02.text!=0)&&(gcem_crtot02.text!=0)){
			alert("�����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
			gcem_detot02.focus();
			return;
	}
}

/******************************************************************************
	Description :  �����û üũ.
	parameter   :  
	��       �� :  ��ǥ��ȣ�� �����鼭, ������ ���̻� ������ ��츸 �����û ������.
	               ��ǥ���°� ������̾���� ��.
******************************************************************************/
function ln_Chk_Confirm(){

	if(gcem_fs02.text!=""&&gcem_fsdat02.text!=""&&gcem_fsnbr02.text!=""){
		if(gcem_fsnbr02.text=="000000"){
			return false;
		}
		if(gcds_dtl.countrow<2){
			return false;
		}
		return true;
	}
}

/******************************************************************************
	Description : ���ݰ�꼭üũ(��ü ������ ������ ������ Ȯ�θ޼���)
	parameter   : 
******************************************************************************/
function ln_Chk_Tax(p1,p2,p3){
	gcds_taxcnt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s14?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;	
	gcds_taxcnt.Reset();

	if(gcds_taxcnt.namevalue(gcds_taxcnt.rowposition,"CNT")>0){  
		return true;
	}else{
		return false; 
	}
}

/******************************************************************************
	Description : ���߰��� üũ
	parameter   : 
******************************************************************************/
function ln_Chk_Addrow(){
  //alert("ln_Chk_Addrow");
  var tempnm ="";
	var strBanjaechk="";
	var no1="";
  //����üũ
	if(gcem_atcode02.text==""){
		alert("�����ڵ带 �Է��Ͻʽÿ�");
    gcem_atcode02.Focus();
		return false;
	}
  
	if(gcem_atkornam02.text==""){
		alert("�������� �Է��Ͻʽÿ�");
    gcem_atkornam02.Focus();
		return false;
	}

  //�ݾ�üũ
	if(gcem_detot02.text==0&&gcem_crtot02.text==0){
		alert("�ݾ��� �Է��Ͻʽÿ�");
        gcem_detot02.Focus();
		return false;
	}

	if(gcem_detot02.text!=0&&gcem_crtot02.text!=0){
		alert("�����ݾװ� �뺯�ݾ��� Ȯ�� �Ͻʽÿ�");
        gcem_detot02.Focus();
		return false;
	}
   
	//����üũ
	if(gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103"||gclx_documcd02.bindcolval=="104"){
		if(hid_docuval.value==""){
			alert("������ȣ�� �����ϴ�. Ȯ���Ͻʽÿ�");
			return false;
		}
	}
//�ӽ÷� �ΰ����Ű� 20070423
 /*
  //������ ���޺ΰ���ġ�� �����ΰ�� ���ݰ�꼭�� ������ ����ȵ�.
  //�뺯�� �Է� �� ���� üũ ����.
	if(gcem_atcode02.text=="1112300"){
		if(gcem_detot02.text!=0){
			if((gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103")&&gclx_documcd02.bindcolval!=""){
			}else{
				alert("�ش������ ���ݰ�꼭�� �����ؾ� �մϴ�.");
				return false;
			}
		}
	}
  //������ �����ΰ���ġ��, �뺯�ΰ�� ���ݰ�꼭�� ������ ����ȵ�.
  //������ �Է� �� ���� üũ ����.

	if(gcem_atcode02.text=="2101100"){
		if(gcem_crtot02.text!=0){
			if((gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103")&&gclx_documcd02.bindcolval!=""){
			}else{
        if(gcem_fsrvalnm03.text=="���ݰ�꼭�̹���"){}
        else{
          alert("�ش������ ���ݰ�꼭�� �����ؾ� �մϴ�.");
          return false;
        }
			}
		}
	}
 */
	 //�ŷ�ó
	if(eval("txt_arbaldiv02").value=="N"&&(txt_vendcd02.value==""||gcem_vendnm02.text=="")){
		//tempnm = eval("txt_fsrefnm02").value;
		alert("�ŷ�ó�� �ʼ��׸��Դϴ�.");
		gcem_vendnm02.focus(); 
		return false;
	}

  //�μ� 
	if(eval("txt_arbaldiv01").value=="N"&&(txt_deptcd02_1.value==""||gcem_deptnm02_1.text=="")){
		//tempnm = eval("txt_fsrefnm01").value;
		alert("�μ��� �ʼ��׸��Դϴ�.");
		gcem_deptnm02_1.focus(); 
		return false;
	}

	//����
	if(gcem_remark02_1.text==""){
		alert("������ �Է��Ͻʽÿ�");
		gcem_remark02_1.focus();
		return false;
	}

  //==================================================================
  //�����׸�üũ
	//==================================================================
	for(k=3;k<=9;k++){
		if(eval("txt_arbaldiv0"+k).value=="N"&&(eval("txt_fsrefval0"+k).value==""||eval("gcem_fsrvalnm0"+k).text=="")){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=="01"){ //������
				no1 = ln_Bgt_DataSet_Dept_find(gcds_dtl.rowposition);        //����μ� ã��0003
				if(no1==""||no1==undefined){                                 //����μ� ������
					tempnm = eval("txt_fsrefnm0"+k).value;
					alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
					eval("gcem_fsrvalnm0"+k).focus(); 
					return false;
				}else{ //����μ� ����� ����μ��� �����ϰ� �ʼ��׸�üũ
					if(eval("txt_fsrefcd0"+k).value!="0003"){
						tempnm = eval("txt_fsrefnm0"+k).value;
						alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
						eval("gcem_fsrvalnm0"+k).focus(); 
						return false;
					}
				}
			}else{	
				tempnm = eval("txt_fsrefnm0"+k).value;
				alert("�����׸� "+tempnm+"�� �ʼ��׸��Դϴ�.");
				eval("gcem_fsrvalnm0"+k).focus(); 
				return false;
			}
		}
	}//for

  //==================================================================
	//�ݰ����� ��� �����׸��� ��ȭ�ݾ��� ��� üũ��.
	//==================================================================
	//2007.05.09 üũ��� ���� 
	//���� : �����ڵ� �ϵ��ڵ� ==> ���� : ACTCODE ���̺��� ATCURTYPE�� Y�� ���� üũ��.
	var stratcode=gcem_atcode02.text;
	stratcode=gcem_atcode02.text.substring(0,3);
	if(gclx_fdcode02.bindcolval=="03"){
		for(b=3;b<=9;b++){
			//if(gcem_atcode02.text=="1112200"||gcem_atcode02.text=="2101000"||stratcode=="112"||stratcode=="122"||stratcode=="123"){
			if(hid_atcurtype.value=="Y"){	
				if(eval("txt_fsrefcd0"+b).value=="1045"){  //��ȭ�ݾ��ϰ��(�ݰ����� ��ȭ�� �ݾ���)
					if((eval("txt_fsrefval0"+b).value==""||eval("gcem_fsrvalnm0"+b).text=="")||
					   (eval("txt_fsrefval0"+b).value=="0"||eval("gcem_fsrvalnm0"+b).text=="0")||
						 (eval("txt_fsrefval0"+b).value=="-"||eval("gcem_fsrvalnm0"+b).text=="-")){
						alert("��ȭ�ݾ׶��� �ݾ��� �Է��Ͻʽÿ�.");
						eval("gcem_fsrvalnm0"+b).focus(); 
				    return false;
					}else{				  
						if(!gf_ChkNumber3(eval("gcem_fsrvalnm0"+b).text)){
						  eval("gcem_fsrvalnm0"+b).focus(); 
							return false;
						}
					}
				}
			}
		}//for
	}
	
	//================================================================== 
	//����üũ
	//==================================================================
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=="02"){
		if(!ln_Bgt_Amt_find(gcds_dtl.rowposition)){
			return false;
		}
	}
  
  //==================================================================
	//����üũ
  //==================================================================
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")=="Y"){ //����
		if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")=="1"){ //����
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")!=0&&gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")!=""){
				//���� ���ῡ ������ �������� ������
				for(b=1;b<=gcds_banjae.countrow;b++){
					if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
						strBanjaechk="T";
						break;
					}
				}

				if(strBanjaechk!="T"){
					alert("���������Դϴ�. Ȯ�� �ٶ��ϴ�.");	
					return false;
				}else{
					strBanjaechk="";
				}
			}

			//2010.06.15 JYS ( ��繬 GJ ��û )
			//2011.01.19 JYS ( ��繬 GJ ��û���� ����ó�� )
			//���� �߻��� (-) �ݾ� �ӷ� �Ұ�
			if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")<0){
					alert("�ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�.");
					gcem_detot02.Focus();
					return false;
				}
			}
		}else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")=="2"){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")!=0&&gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")!=""){
				//���� ���ῡ ������ �������� ������
				for(b=1;b<=gcds_banjae.countrow;b++){
					if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
						strBanjaechk="T";
						break;
					}
				}
				if(strBanjaechk!="T"){
					alert("���������Դϴ�. Ȯ�� �ٶ��ϴ�.");	
					return false;
				}else{
					strBanjaechk="";
				}
			}
			//2010.06.15 JYS ( ��繬 GJ ��û )
			//2011.01.19 JYS ( ��繬 GJ ��û���� ����ó�� )
			//2015.09.24 jys ��繬 CJ -> ����ȯ BJN
			//���� �߻��� (-) �ݾ� �ӷ� �Ұ�
			if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")<0){
					alert("�ش� ���� �߻��� (-) �ݾ� �Է� �Ұ��մϴ�.");
					gcem_crtot02.Focus();
					return false;
				}
			}
		}
	}
	return true;
}


/******************************************************************************
	Description : ����Ϸ� Ȯ��
	prameter    : p- U :��ȸ �� ������    I:�ű��Է½�  , D - 
******************************************************************************/
function ln_Chk_Status(p){
  //alert("Status::" + p);
	if (p=="U"){
		if(gclx_fsstat02.bindcolval=="Y"){
			alert("����Ϸ���� ������ �� �����ϴ�.");
			return false;
		}else{
			return true;
		}
	}else if(p=="I"){
	  //alert("gclx_fsstat02::"+gclx_fsstat02.bindcolval);
		if(gclx_fsstat02.bindcolval=="Y"){
		  alert("����Ϸ���� ������ �� �����ϴ�."); 
			return false;
		}else{
			return true;
		}
	}else if(p=="D"){
	  //alert("gclx_fsstat02::"+gclx_fsstat02.bindcolval);
		if(gclx_fsstat02.bindcolval=="Y"||gclx_fsstat02.bindcolval=="C"||gclx_fsstat02.bindcolval=="R"){
		  alert("��ǥ���°� ������ �� �����ϴ�."); 
			return false;
		}else{
			//�α����� ����� ����� ����� ���� ������ ���� �� ���� ����.
			//alert("gs_userid!"+gs_userid+"txt_empno02.value)"+txt_empno02.value);
			if(gs_userid!=txt_empno02.value){
				alert("�ۼ��ڿ� �������� �ʽ��ϴ�.");
				return false;
			}else{
				if(gs_userid==""||gs_userid==undefined){
					alert("�ۼ��ڸ� Ȯ���Ͻʽÿ�.");
					return false;
				}
			}
			return true;
		}
	}else if(p=="C"){
		if(gclx_fsstat02.bindcolval=="Y"){
		  alert("����Ϸ���� ����� �� �����ϴ�."); 
			return false;
		}else{
			return true;
		}
	}else{
		
	}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// üũ�׸� (End <<<<<<<<<<<<<:::::::::::::::::::::::)
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
	Description : ������ڵ� ����
******************************************************************************/
function ln_Cocode(strcocode){
	if(strcocode==""||strcocode==undefined){
		if(gclx_fdcode02.bindcolval=="01"){
			strcocode="01";
		}else{
			strcocode="02";
		}
	}
	return strcocode;
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ������� �Լ� (Start ::::::::::::::::::::::: >>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : �����׸� ��ġã��
	parameter   : strValue - �����׸�
******************************************************************************/
function ln_Ref_position_find(strValue){
  var strposition="";
	for(f=3;f<=9;f++){
	 if (eval("txt_fsrefcd0"+f).value==strValue){  
			strposition ="0"+f;
			return strposition; 
	 }
	}//for f 
	return strposition; 
}

/******************************************************************************
	Description : ���� ã��
	parameter   : 
******************************************************************************/
function ln_Bgt_Detail_find(){
  var strposition="";
	if(ln_Bgt_position_find()!=""){
		for (g=3;g<=9;g++){
			 if (eval("hid_type"+g).value=="B"){  //���꼼����.
					strposition = g;
					return strposition; 
			 }
		}//for g
	}
	return strposition; 
}

/******************************************************************************
	Description : ����μ� �� ���꺻�� ��ġã��
	parameter   :
******************************************************************************/
function ln_Bgt_position_find(){
  var strposition="";
	for(f=3;f<=9;f++){
		if (eval("txt_fsrefcd0"+f).value=="0003"){
			strposition = "0"+f;
			return strposition; 
		}
	}//for f
	return strposition
}

/******************************************************************************
	Description : ����μ� ��ġã��
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bgt_DataSet_Dept_find(k){
 var strposition="";
 for(j=1;j<=9;j++){
	if(gcds_dtl.namevalue(k,"FSREFCD0"+j)=="0003"){
		strposition = "0"+j;
		return strposition ; 
	}
 }
 return strposition ;
}

/******************************************************************************
	Description : ����μ� ���� ��ġã��
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bgt_DataSet_Type_find(k){
  var strposition="";
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(k,"TYPE0"+j)=="B"){
			strposition = "0"+j;
			return strposition ; 
		}
	}
	return strposition ; 
}


/******************************************************************************
	Description : ������ ����μ� ��ġã��
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bf_Bgt_DataSet_Dept_find(k){
 var strposition="";
 for(j=1;j<=9;j++){
	if(gcds_dtl.OrgNameValue(k,"FSREFCD0"+j)=="0003"){
		strposition = "0"+j;
		return strposition ; 
	}
 }
 return strposition ;
}

/******************************************************************************
	Description : ������ ����μ� ���� ��ġã��
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bf_Bgt_DataSet_Type_find(k){
  var strposition="";
	for(j=1;j<=9;j++){
		if(gcds_dtl.OrgNameValue(k,"TYPE0"+j)=="B"){
			strposition = "0"+j;
			return strposition ; 
		}
	}
	return strposition ; 
}

/******************************************************************************
	Description :  ����ݾ� ��ȸ
	parameter   :  p5 - i ��ġ(������ ��ġ)
******************************************************************************/
function ln_Bgt_Amt_find(p5){

  //alert("ln_Bgt_Amt_find::po::"+p5);
	var stryyyy = gcem_actdat02.text;
	var strmm = fn_trim(stryyyy.substring(4,6));
		 stryyyy = fn_trim(stryyyy.substring(0,4));
	var strbgtdiv="";                                   //���꺻��
	var strbgtdept="";                                  //����μ�
	var stratcode = "";                                 //��������
	var strrefcd= "";                                   //������ �����׸��ڵ�
	var strrefval="";                                   //����
	var strfswrkdiv="";                                 //����Ÿ��
	var no1="";                                         //�����׸� ��ġ	
	var no2="";                                         //����
	no1 = ln_Bgt_DataSet_Dept_find(p5);                 //����μ� ã��
    no2 = ln_Bgt_DataSet_Type_find(p5);                 //������ġ ã��  
	
	//alert("no1:"+no1+"no2:"+no2);
	                   
	if(no1==""||no1==undefined){
		alert("����μ��� �������� �ʽ��ϴ�.");
		return false;
	}

    if(gcds_dtl.namevalue(p5,"CHAAMT")==0||gcds_dtl.namevalue(p5,"CHAAMT")==""){
		alert("�ݾ��� �Է��Ͻʽÿ�.");
		return false;
	}

  //����μ��� ������ ���
	if(no1==no2){//n01 == n02 : ����μ��� ������ ���
		strrefcd = gcds_dtl.namevalue(p5,"FSREFCD"+no1);
		strrefval ="00"
	}else{
		if(no2==""||no2==undefined){
			strrefcd="";
			strrefval="";
		}else{
			strrefcd=gcds_dtl.namevalue(p5,"FSREFCD"+no2);
			strrefval=gcds_dtl.namevalue(p5,"FSREFVAL"+no2);	
		}
	}
  
	strbgtdept= gcds_dtl.namevalue(p5,"FSREFVAL"+no1);	

	if(strbgtdept=="1080"){
		strbgtdiv="1000";
	}else{
    strbgtdiv =gcds_dtl.namevalue(p5,"BGTDIV");
	}
	stratcode =gcds_dtl.namevalue(p5,"ATCODE");

	ln_Bgt_Amt_Clear();
	strfswrkdiv = gcds_dtl.namevalue(p5,"FSWRKDIV");
	//alert("strrefcd:"+strrefcd+"strrefval:"+strrefval);
	if(strfswrkdiv!="02"){
		return false;
	}
	
	return true; 
    //^^alert("����ݾ���ȸ");
    //2014.07.17.jys ����� ���� ä���� ��û ***
    /***
 	//���� �ݾ� ��ȸ
	if(ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,strfswrkdiv,p5)){

		gcem_realbgt.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"REALBGT");
		gcem_results.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"RESULTS");
		gcem_bresults.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"BRESULTS");
		gcem_janamt.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT");
		
		if(gcds_bgt.countrow>0){
			if(Number(gcds_dtl.namevalue(p5,"CHAAMT"))>Number(gcem_janamt.text)){
				alert("�Է��Ͻ� �ݾ��� ���� �ܾױݾ׺��� �����ϴ�.");
				return false;
			}
			return true;
		}else{
		  alert("������ �����ϴ�.");
			ln_Bgt_Amt_Clear();
			return false;
		}
	}else{
	  	alert("������ �����ϴ�.");
		gcem_realbgt.text=0;
		gcem_results.text=0;
		gcem_bresults.text=0;
		gcem_janamt.text=0;
		return false;
	}
    ***/
}

/******************************************************************************
	Description :  ����ݾ� �ʱ�ȭ
	parameter   : 
******************************************************************************/
function ln_Bgt_Amt_Clear(){
	gcem_realbgt.text=0;
	gcem_results.text=0;
	gcem_bresults.text=0;
	gcem_janamt.text=0;
}

/******************************************************************************
	Description :  ������ȸ
	               ����Ÿ����  �μ��� ��Ÿ(05) ����(15) ��� �⿹�� ��ȸ
                 �� �� ��������ȸ
                 ==> 2006.05.15 ���� ����
								 ����μ��� ���꺻���ϰ�� �⿹����ȸ (���꺻��-substring(2,4) = 00
								 ����μ��� ����μ��ϰ�� ��������ȸ
	parameter   :  p5 - i position
******************************************************************************/
function ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,strfswrkdiv,p5){
  //������ȸ
	//alert("ln_Bgt_Query + ������ȸ");
	//alert("strfswrkdiv:"+strfswrkdiv);
	//alert("stryyyy"+stryyyy+"strbgtdiv"+strbgtdiv+"strbgtdept"+strbgtdept+"stratcode"+stratcode+"strrefcd"+strrefcd+"strrefval"+strrefval+"strmm"+strmm+"strfswrkdiv"+strfswrkdiv);

	if(strfswrkdiv=="02"){ //����
		//���� �ݾ� ã��
		//���꺻��
	 if(strbgtdiv==""&&strbgtdept!=""){
		gcds_bgtdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003&v_str2"+strbgtdept;
		gcds_bgtdiv.Reset();
		strbgtdiv = gcds_bgtdiv.namevalue(gcds_bgtdiv.rowposition,"GBCD");
	}


		if(strbgtdept.substring(2,4)=="00"||strbgtdept.substring(2,4)=="10"||strbgtdept=="1080"){  //����, ����
		  if(stryyyy!=""&&strbgtdiv!=""&&strbgtdept!=""&&stratcode!=""&&strrefcd!=""&&strrefcd!=""){
				gcds_bgt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s17?v_str1="+gclx_fdcode02.bindcolval
																											 +"&v_str2="+stryyyy
																											 +"&v_str3="+strbgtdiv
																											 +"&v_str4="+strbgtdept
																											 +"&v_str5="+stratcode
																											 +"&v_str6="+strrefcd
																											 +"&v_str7="+strrefval;
																											 //+"&v_str8="+strfswrkdiv;
				//prompt("yyyy",gcds_bgt.DataID);
				gcds_bgt.Reset();
			}
		}else{
		  if(stryyyy!=""&&strbgtdiv!=""&&strbgtdept!=""&&stratcode!=""&&strrefcd!=""&&strrefcd!=""&&strmm!=""){
				gcds_bgt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s18?v_str1="+gclx_fdcode02.bindcolval
																											 +"&v_str2="+stryyyy
																											 +"&v_str3="+strbgtdiv
																											 +"&v_str4="+strbgtdept
																											 +"&v_str5="+stratcode
																											 +"&v_str6="+strrefcd
																											 +"&v_str7="+strrefval
																											 +"&v_str8="+strmm;
																											 //+"&v_str9="+strfswrkdiv;
				//prompt("yymm",gcds_bgt.DataID);
				gcds_bgt.Reset();
			}
		}
		return true
	}else{ //������
		return false;
	}
}

/******************************************************************************
	Description : ��ǥ ��ü ������ ���� �ݾ� ã��
	prameter    :
******************************************************************************/
function ln_Del_All_Bgt_find(){
	for(t=1;t<=gcds_dtl.countrow;t++){
		if(gcds_dtl.namevalue(t,"FSWRKDIV")=="02"){  //��������
			var no1 = ln_Bgt_DataSet_Dept_find(t);   //����μ� ã��
			var no2 = ln_Bgt_DataSet_Type_find(t);   //������ġ ã��  
			if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)){
			  //alert("no1:"+no1+"no2:"+no2);
				ln_Del_All_Bgt_Data_Add(t,no1,no2);  //���������߰�
			}
		}
	}//for t
}

/******************************************************************************
	Description : ������ ������� ���� Data Set ����
	parameter   : 
******************************************************************************/
function ln_Del_All_Bgt_Data_Add(k,no1,no2){
	if(gcds_bgt_del_all.countrow<=0){
		ln_SetDataHeader("BGTDTL_DEL_ALL");
	}
	gcds_bgt_del_all.Addrow();
	row = gcds_bgt_del_all.rowposition;

	var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
	gcds_bgt_del_all.namevalue(row,"BGTYY")=stractdt3.substring(0,4);          //����������⵵
	gcds_bgt_del_all.namevalue(row,"BGTMM")=stractdt3.substring(4,6);          //�����������  
	gcds_bgt_del_all.namevalue(row,"BGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");//���������꺻��  
	gcds_bgt_del_all.namevalue(row,"BGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no1);   //����������μ�  
	gcds_bgt_del_all.namevalue(row,"ATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");         //��������������  
	gcds_bgt_del_all.namevalue(row,"FSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no2);   //�����������׸��ڵ�  
	
	//����μ��� ��������׸��� ��� ������ 00�� ����
	if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no2)=="0003"){
		gcds_bgt_del_all.namevalue(row,"SATCODE")="00";	 //����  
	}else{
		gcds_bgt_del_all.namevalue(row,"SATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no2);    //����������
  }
		
	gcds_bgt_del_all.namevalue(row,"BGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");		      //����������Ÿ�� 
	gcds_bgt_del_all.namevalue(row,"CHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");             //�������ݾ�  
	gcds_bgt_del_all.namevalue(row,"ACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT"); //������ ȸ������  

	//�����Ѱ������� (�̽��� ������)
	gcds_bgt_del_all.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");   
	gcds_bgt_del_all.namevalue(row,"COCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE")); 
	gcds_bgt_del_all.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");    
	gcds_bgt_del_all.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");     
	gcds_bgt_del_all.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  

  //���� �� ��������׸���� (�̽��� ������)
	//��������׸����
	for(j=1;j<=9;j++){
		gcds_bgt_del_all.namevalue(row,"FSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
		gcds_bgt_del_all.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
	}	
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ������� �Լ� (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
Description : �μ�,�ŷ�ó,��� ���߰��ø��� �ڵ� ������.
              �����ڵ�,���꺻���ڵ�,���������ڵ�, �������а�(�Ϲ���������) 
parameter   : gubun - TAX ���ݰ�꼭���� ������.
******************************************************************************/
function ln_Copy_Dept_Vend_Reamrk(row,gubun){
	var strDocumcd="";
	var strDocGB="";

	hid_copy_remark.value = gcds_dtl.namevalue(row,"REMARK");      //���� ����

	//�Ϲ������� �������� ����.
	strDocumcd="";
	strDocumcd=gcds_dtl.namevalue(row,"DOCUMCD");
	strDocGB=strDocumcd.substring(0,1);
	if(strDocGB=="1"&&gubun=="TAX"){
		if(hid_copy_documcd.value==""){
			hid_copy_documcd.value=gcds_dtl.namevalue(row,"DOCUMCD");   //�������� ����
		}
		if(hid_copy_docuval.value==""){
			hid_copy_docuval.value=gcds_dtl.namevalue(row,"DOCUVAL");   //������ ����
		}
	}else{
		hid_copy_documcd.value="";
		hid_copy_docuval.value="";
	}
	
	for(j=1;j<=9;j++){
		//�μ�
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0002"){
			hid_copy_deptcd.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j); //�μ��ڵ� ����
			hid_copy_deptnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //�μ��� ����
			hid_copy_divcd.value=gcds_dtl.namevalue(row,"DIVCD");        //�����ڵ� ����
		}

		//�ŷ�ó
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			hid_copy_vendcd.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j); //�ŷ�ó�ڵ� ����
			hid_copy_vendnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //�ŷ�ó�� ����
		}

		//����μ�,���꺻��
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0003"){
			hid_copy_bgtdept.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j);   //�μ����ڵ� ����
			hid_copy_bgtdeptnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //�μ����ڵ� ����
			hid_copy_bgtdiv.value=gcds_dtl.namevalue(row,"BGTDIV");         //���꺻���ڵ� ����
		}
	} //for j
}

/******************************************************************************
Description : �μ�,�ŷ�ó,��� ���߰��ø��� �ڵ� ������.
              �����ڵ�,���꺻���ڵ�,���������ڵ�, �������а�(�Ϲ���������) 
parameter   : 
******************************************************************************/
function ln_Paste_Dept_Vend_Reamrk(row){

	gcds_dtl.namevalue(row,"REMARK")= hid_copy_remark.value;
	//�Ϲ������� �������� ����.
	
	//alert("hid_copy_documcd.value:;"+hid_copy_documcd.value);
	var strDocumcd=hid_copy_documcd.value;
	if(strDocumcd!=""){
		var strDocGB=strDocumcd.substring(0,1);
		if(strDocGB="1"){
			gcds_dtl.namevalue(row,"DOCUMCD")=hid_copy_documcd.value;   //�������� ����
			gcds_dtl.namevalue(row,"DOCUVAL")=hid_copy_docuval.value;   //������ ����
		}
	}

	for(j=1;j<=9;j++){
		//�μ�
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0002"){
			gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_deptcd.value; //�μ��ڵ� ����
			gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_deptnm.value; //�μ��� ����
			gcds_dtl.namevalue(row,"DIVCD") = hid_copy_divcd.value;      //�����ڵ� ����
		}

		//�ŷ�ó
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
		    //20061030 - �̰�����û : ���ݰ�꼭 ����� 
		    //2015.03.03. jys ����Խ� �ŷ�ó ��������
		    //alert("hid_docuval.value:"+hid_docuval.value);
		    //if(hid_docuval.value==""){
				gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_vendcd.value; //�ŷ�ó�ڵ� ����
				gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_vendnm.value; //�ŷ�ó�� ����
			//}
		}

		//����μ�,���꺻��
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0003"){
			gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_bgtdept.value;   //�μ����ڵ� ����
			gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_bgtdeptnm.value; //�μ����ڵ� ����
			gcds_dtl.namevalue(row,"BGTDIV")=hid_copy_bgtdiv.value;         //���꺻���ڵ� ����
		}
	} //for j
}

/******************************************************************************
Description : �μ�,�ŷ�ó,���� ������ ����Ÿ �ʱ�ȭ
parameter   : 
******************************************************************************/
function ln_Clear_Dept_Vend_Reamrk(){
	hid_copy_deptcd.value="";
	hid_copy_deptnm.value="";
	hid_copy_divcd.value="";
	hid_copy_vendcd.value="";
	hid_copy_vendnm.value="";
	hid_copy_documcd.value="";
	hid_copy_documnm.value="";
	hid_copy_docuval.value="";
	hid_copy_bgtdept.value="";
	hid_copy_bgtdeptnm.value=""; 
	hid_copy_bgtdiv.value="";
	hid_copy_remark.value="";
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// �������� �Լ� (Start :::::::::::::::::::::::  >>>>>>>>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : ��������
	parameter   : 
	ref         : �������� ������ ���� �����ؾ���.
	              ������ ������ ����� �Ұ���
								���� ������ �������� �˾��� ����� �ݾ� ��Ҹ� �ؾ���.
								���� �����׸� ����
								//�˾��� �ش� ������ ���� ������ ����� ���� ����ϸ鼭
								  ���������� ����Ÿ�� update ��.
******************************************************************************/
function ln_Popup_Repay_Modify(){
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var stratcode="";
	var stratkornam="";
	var strfsrefval="";
	var strfsrvalnm="";
	var strseq="";
	var temprow="";
	var strbanjaeref="";
	var strbanjaerefval=""; //����������
	var strbanjaerefnm="";  //����������Ī
	var chaamt=0;
	var daeamt=0;
	var row = gcds_dtl.rowposition;

	if(!ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
		                        gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
													  gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
													  gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
		
    
		//�Էµ� ����Ÿ ���� ���� �ƴ� ���� �Էµ� ���
		/*
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //����
			if(!ln_Banjae_Data_Delete(row,'1')){
					gcds_dtl.rowposition = row;
					return false;
			};
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){	
			if(!ln_Banjae_Data_Delete(row,'2')){
				gcds_dtl.rowposition = row;
				return false;
			}
		}	
		*/
	}
	 
	if(!ln_Chk_Repay(row)) return;

	stratcode=gcds_dtl.namevalue(row,"ATCODE"); 
	stratkornam =gcds_dtl.namevalue(row,"ATKORNAM"); 
	strseq = gcds_dtl.namevalue(row,"FSSEQ");   
	
	//�ŷ�ó
	_out:
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			 strfsrefval = gcds_dtl.namevalue(row,"FSREFVAL0"+j);
			 strfsrvalnm = gcds_dtl.namevalue(row,"FSRVALNM0"+j);
			 break _out;
		}
	}//j
	//////////////////////////////////////////////////////////////////////

  //�������� �����׸��� ������.
	_out2:
	 for(k=1;k<=9;k++){
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==gcds_dtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = gcds_dtl.namevalue(row,"BANJAEREF");
				 strbanjaerefval = gcds_dtl.namevalue(row,"FSREFVAL0"+k);
				 strbanjaerefnm = gcds_dtl.namevalue(row,"FSRVALNM0"+k);
				 break _out2;
			}
	 }//k	
  
	g_arrParam[0]=stratcode;                         //�����ڵ�
	g_arrParam[1]=stratkornam;                       //������
	g_arrParam[2]=strfsrefval;                       //�ŷ�ó�ڵ�
	g_arrParam[3]=strfsrvalnm;                       //�ŷ�ó��
	g_arrParam[4]=gclx_fdcode02.bindcolval;					 //������ǥ FDCODE
	g_arrParam[5]=gcem_fs02.text+gcem_fsdat02.text;	 //������ǥ FSDAT
	g_arrParam[6]=gcem_fsnbr02.text;						     //������ǥ FSNBR
	g_arrParam[7]=strseq;					                   //��ǥ���ȣ seq
	g_arrParam[8]=strbanjaeref;                      //�������� �����׸� 
	g_arrParam[9]=strbanjaerefval;                   //����������
	g_arrParam[10]=strbanjaerefnm;                   //���������� ��Ī

	strURL = "./commrepay_popup_modify.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	//result = showModalDialog(strURL,arrParam,strPos);
	result = showModalDialog(strURL,window,strPos);

	if(gcds_dtl.namevalue(row,"BANJAEMOD")=="Y"){       //������Ҹ� ���� ���
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){
			gcds_dtl.namevalue(row,"DAEAMT")=0;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){
			gcds_dtl.namevalue(row,"CHAAMT")=0; 
		}
	}

	//////////////////////////////////////////////// 
  //2010.03.15 JYS
	ln_Dtl_Lock(row);
	ln_Dtl_Amt_Lock(row);
	ln_Atcode_Lock(row)
  //2010.03.16 jys : ������� ������ �ʱ�ȭ. 
	gcds_dtl.namevalue(row,"BANJAEMOD")="";
  ////////////////////////////////////////////////
}


/******************************************************************************
	Description : ����ó��
	parameter   : p1 - �����ڵ�
	              p2 - ��������
                p3 - ������ȣ
******************************************************************************/
function ln_Popup_Repay(){
  //alert("��������");
	var result="";
	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var stratcode="";
	var stratkornam="";
	var strfsrefval="";
	var strfsrvalnm="";
	var strseq="";
	var temprow="";
	var strbanjaeref="";
	var strbanjaerefval=""; //����������
	var strbanjaerefnm="";  //����������Ī
	var chaamt=0;
	var daeamt=0;
	var row = gcds_dtl.rowposition;
	var strBanjaechk="";
	
	if(!ln_Chk_Repay(row)) return;

	stratcode=gcds_dtl.namevalue(row,"ATCODE"); 
	stratkornam =gcds_dtl.namevalue(row,"ATKORNAM"); 
	strseq = gcds_dtl.namevalue(row,"FSSEQ"); 
	
	//�ش� ������ ���� �Է°��� ������ ��� �����˾� �� ���.==========================
	if(gcds_dtl.SysStatus(row)==1){//�ű��Է°�
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(row,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
				strBanjaechk="T";
				break;
			}
		}//for

		if(strBanjaechk=="T"){
			gcds_dtl.rowposition = row;
			alert("���������� �ݾ��Դϴ�. �������� �� �����մϴ�.");	
			return false;
		}
  }else{
		//�̹� ������������ �Ǿ� �־ �˾� �ȵ�
		if(ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
			alert("������ ����� �����Դϴ�. Ȯ�ιٶ��ϴ�.");
			return false;
		}
  }
	//====================================================================================
	
	//�ŷ�ó
	_out:
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			 strfsrefval = gcds_dtl.namevalue(row,"FSREFVAL0"+j);
			 strfsrvalnm = gcds_dtl.namevalue(row,"FSRVALNM0"+j);
			 break _out;
		}
	}//j
 
  ////////////////////////////////////////////////////////////////////////////////////

  //�������� �����׸��� ������.
	_out2:
	 for(k=1;k<=9;k++){
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==gcds_dtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = gcds_dtl.namevalue(row,"BANJAEREF");
				 strbanjaerefval = gcds_dtl.namevalue(row,"FSREFVAL0"+k);
				 strbanjaerefnm = gcds_dtl.namevalue(row,"FSRVALNM0"+k);
				 break _out2;
			}
	 }//k	

	g_arrParam[0]=stratcode;                         //�����ڵ�
	g_arrParam[1]=stratkornam;                       //������
	g_arrParam[2]=strfsrefval;                       //�ŷ�ó�ڵ�
	g_arrParam[3]=strfsrvalnm;                       //�ŷ�ó��
	g_arrParam[4]=gclx_fdcode02.bindcolval;					 //������ǥ FDCODE
	g_arrParam[5]=gcem_fs02.text+gcem_fsdat02.text;	 //������ǥ FSDAT
	g_arrParam[6]=gcem_fsnbr02.text;						     //������ǥ FSNBR
	g_arrParam[7]=strseq;					                   //��ǥ���ȣ seq
	g_arrParam[8]=strbanjaeref;                      //�������� �����׸� 
	g_arrParam[9]=strbanjaerefval;                   //����������
	g_arrParam[10]=strbanjaerefnm;                   //���������� ��Ī

	strURL = "./commrepay_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,window,strPos);

	if (result != null) {
		arrResult = result.split(";");
		if(arrResult[0]!=0){         //������ 0�� �ƴ� ��� �뺯 �ݾ�
			gcds_dtl.namevalue(row,"DAEAMT")=arrResult[0];
		}else if(arrResult[1]!=0){   //�뺯�� 0�� �ƴ� ��� ���� �ݾ�
			gcds_dtl.namevalue(row,"CHAAMT")=arrResult[1];
		}

		_out3:
		for(k=1;k<=9;k++) {
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==arrResult[2]){
				 gcds_dtl.namevalue(row,"FSREFVAL0"+k)=arrResult[3];
				 gcds_dtl.namevalue(row,"FSRVALNM0"+k)=arrResult[4];
         //�����׸��� ī���ȣ(1133)�� ��� ������ �ڵ� ������.
				 if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="1133"){
						ln_Card_Kind_Find(arrResult[2],arrResult[4]);
				 }
			}

      //2007.06.28 ����ī�� 
      if(gcds_dtl.namevalue(row,"ATCODE")=="2100520"){  //����ī���ϰ��
				if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0029"){
					gcds_dtl.namevalue(row,"FSREFVAL0"+k)=arrResult[6];
					gcds_dtl.namevalue(row,"FSRVALNM0"+k)=arrResult[8];
				}
			}else{
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD0"+k)==arrResult[5]){ //�������� �Է����� 0020
						gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL0"+k)=arrResult[6];
						gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM0"+k)=arrResult[6];
				}
			}
		}//k		 

		//������ ���䵵 ������
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")= arrResult[7]; //����
		if(gcds_dtl.rowposition==1&&gcem_remark02.text=="")gcem_remark02.text=arrResult[7];
	}else{
		gcds_dtl.namevalue(row,"CHAAMT")=0;
	  gcds_dtl.namevalue(row,"DAEAMT")=0;
		g_strbanjae="N";
	}

	/////////////////////////
  //2010.03.15 JYS
	ln_Dtl_Lock(row);
	ln_Dtl_Amt_Lock(row);
	ln_Atcode_Lock(row);
	/////////////////////////

	//2014.08.05 �̵��� �߰� ////////////////////////////////////////////////////////////////////
	//�����׸� disabled
	//alert(hid_banjaeref.value );
	
	if(hid_banjaeref.value == gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")){ //�����׸�� ���������� ���� ���

  		//gcem_fsrvalnm03.Enable=false;
	
	}	
	
  /*
  //�ݾ�
	i=0;
	chaamt=0;
	daeamt=0;
	for(i=1;i<=g_row;i++){			  
		if(eval("hid_flag"+i+"0").value=="T"){
			if (eval("gcem_chaamt"+i).text=="") eval("gcem_chaamt"+i).text=0;
			if (eval("gcem_daeamt"+i).text=="") eval("gcem_daeamt"+i).text=0;
			chaamt += parseInt(eval("gcem_chaamt"+i).text);
			daeamt += parseInt(eval("gcem_daeamt"+i).text);
		}
	}
	ln_Sum_Amt(chaamt,daeamt);
  */
	//alert("������");
}


/******************************************************************************
	Description : ��������Ȯ��
******************************************************************************/
function ln_banjae_atcode_find(stratcode){
		gcds_banjae_atcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s21?v_str1="+stratcode;																						
		gcds_banjae_atcode.Reset();
    if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDEBTYN")=="Y"){
			return true;  //��������
		}else{
			return false;
		}
}


/******************************************************************************
Description : �������а�
parameter   : p1 - �������а�   p3-�����ݾ�
	            p2 - ��������     p4-�뺯�ݾ�
******************************************************************************/
function ln_Banjae_yn(p1,p2,p3,p4){

	//^^alert("ln_Banjae_yn :: p1"+p1+"p2"+p2+"p3"+p3+"p4"+p4);
	if(p1=="Y"){
		if(p2=="1"&&p3!=0&&p4==0){       //����
			return "Y" ;
		}else if(p2=="2"&&p3==0&&p4!=0){ //�뺯
			return "Y" ;
		}else{
			return p1;
		}
	}else{
		return "N" ;
	}
}

/******************************************************************************
Description : �ű��Է½� ����Ÿ �¿��� ���� ����Ÿ ����(��������, ������������)
parameter   : i - gcds_dtl�� rowposition      
              gubun - 1 : ��������
                      2 : �뺯����
******************************************************************************/
function ln_Banjae_Data_Delete(i,gubun){
  var strBanjanChkAmt = 0; //�����ݾ� 

	if(gubun=="1"){
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){ //�����ݾװ� ����ݾ� ��
				strBanjanChkAmt =strBanjanChkAmt+gcds_banjae.namevalue(b,"BJCRAMT");//�����뺯�ݾ״���_���� ����
			}
		}

		if(strBanjanChkAmt!=gcds_dtl.namevalue(i,"DAEAMT")){ // �����뺯�ݾ��� �հ� �뺯�ݾ��� ��
			alert("�����ݾ��� Ʋ���ϴ�. �������� �� ������ �ٽ� �Ͻʽÿ�.");
			return false;
		}else{
			return true;
		}
		
		//if
	}else if(gubun=="2"){
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){ //�����ݾװ� ����ݾ� ��
				strBanjanChkAmt =strBanjanChkAmt+gcds_banjae.namevalue(b,"BJDEAMT");//���������ݾ״���_���� ����
			}
		}

		if(strBanjanChkAmt!=gcds_dtl.namevalue(i,"CHAAMT")){ // �����뺯�ݾ��� �հ� �뺯�ݾ��� ��
			alert("�����ݾ��� Ʋ���ϴ�. �������� �� ������ �ٽ� �Ͻʽÿ�.");
			return false;
		}else{
			return true;
		}
		//if
	}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// �������� �Լ� (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
Description : �����׸� KillFocus�� �߻�
parameter   : obj - �����׸��� gcem object��
******************************************************************************/
function ln_onblur(obj){
  //alert("obj::"+obj);
  var row = gcds_dtl.rowposition;
	if(obj=="gcem_deptnm02_1"){
		if(gcds_dtl.namevalue(row,"TYPE01")=="C"){
			txt_deptcd02_1.value =gcem_deptnm02_1.text; 	
		}
		if(gcem_deptnm02_1.text==""){
			txt_deptcd02_1.value=""; 
		}
	}else if(obj=="gcem_vendnm02"){
		if(gcds_dtl.namevalue(row,"TYPE02")=="C"){
			txt_vendcd02.value =gcem_vendnm02.text; 	
		}
		if(gcem_vendnm02.text==""){
			txt_vendcd02.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm03"){
		if(gcds_dtl.namevalue(row,"TYPE03")=="C"){
			txt_fsrefval03.value =gcem_fsrvalnm03.text; 	
		}
		if(gcem_fsrvalnm03.text==""){
			txt_fsrefval03.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm04"){
		if(gcds_dtl.namevalue(row,"TYPE04")=="C"){
			txt_fsrefval04.value =gcem_fsrvalnm04.text; 	
		}
		if(gcem_fsrvalnm04.text==""){
			txt_fsrefval04.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm05"){
		if(gcds_dtl.namevalue(row,"TYPE05")=="C"){
			txt_fsrefval05.value =gcem_fsrvalnm05.text; 	
		}
    if(gcem_fsrvalnm05.text==""){
			txt_fsrefval05.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm06"){
	  //alert("TYPE::"+gcds_dtl.namevalue(row,"TYPE06"))
		//alert("row::"+row)
		if(gcds_dtl.namevalue(row,"TYPE06")=="C"){
		  //alert("gcem_fsrvalnm06::"+gcem_fsrvalnm06.text);
			txt_fsrefval06.value =gcem_fsrvalnm06.text; 	
			//alert("txt_fsrefval06::"+txt_fsrefval06.value);
		}
    if(gcem_fsrvalnm06.text==""){
			txt_fsrefval06.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm07"){
		if(gcds_dtl.namevalue(row,"TYPE07")=="C"){
			txt_fsrefval07.value =gcem_fsrvalnm07.text; 	
		}
		if(gcem_fsrvalnm07.text==""){
			txt_fsrefval07.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm08"){
		if(gcds_dtl.namevalue(row,"TYPE08")=="C"){
			txt_fsrefval08.value =gcem_fsrvalnm08.text; 	
		}
		if(gcem_fsrvalnm08.text==""){
			txt_fsrefval08.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm09"){
		if(gcds_dtl.namevalue(row,"TYPE09")=="C"){
			txt_fsrefval09.value =gcem_fsrvalnm09.text; 	
		}
		if(gcem_fsrvalnm09.text==""){
			txt_fsrefval09.value=""; 
		}
	}
}

/******************************************************************************
	Description : �ŷ�ó ã��
	parameter   : p- row
******************************************************************************/
function ln_Vend_Find(row){
	_out:
	for(k=1;k<=9;k++) {
		if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0020"){
			 if(gcds_dtl.namevalue(row,"FSREFVAL0"+k)==""){
					alert("�ŷ�ó�� �ʿ��մϴ�.");
					return false;
					break _out;
			 }				
		}
	}// for k
	return true;
}

/******************************************************************************
	Description : ��� ����Ÿ �� Clear
	parameter   :
******************************************************************************/
function ln_DataSet_Clear(){
  gcds_mst.ClearAll();
	gcds_dtl_insert.ClearAll();
	gcds_dtl_update.ClearAll();
	gcds_dtl_del.ClearAll();
	gcds_banjae.ClearAll();
	gcds_banjaemst.ClearAll();
	gcds_tax.ClearAll();
	gcds_bgt_insert.ClearAll();
	gcds_bgt_update.ClearAll();
	gcds_bgt_del.ClearAll();
	gcds_fsnum.ClearAll();
	gcds_fsseq.ClearAll();
	gcds_del02.ClearAll();
	gcds_bgt_del_all.ClearAll();
	gcds_tax_del_row.ClearAll();
	ln_Clear_Dept_Vend_Reamrk(); //hid �� Clear
}

/******************************************************************************
	Description : ����Ȯ�� ��ȸ
	parameter   :
******************************************************************************/
function ln_Slip_Close_Query(){
    var strdate = gcem_actdat02.text;
		var stryyyy=strdate.substring(0,4);
		var strmm = strdate.substring(4,6);
		var strdd = strdate.substring(6,8);
		gcds_slip_close.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s19?v_str1="+gclx_fdcode02.bindcolval
		                                                       +"&v_str2="+stryyyy
																													 +"&v_str3="+strmm
																													 +"&v_str4="+strdd;
	  //prompt("",gcds_slip_close.DataID);																							
		gcds_slip_close.Reset(); 
}

/******************************************************************************
	Description : �����׸� ��¥, ���� ���� ����
	parameter   :
******************************************************************************/
function ln_Ref_Format_Setting(){
	for(k=3;k<=9;k++){
	   eval("gcem_fsrvalnm0"+k).enable = true;
     eval("txt_fsrefval0"+k).disabled = false;
		 eval("gcem_fsrvalnm0"+k).format = "";
		 eval("gcem_fsrvalnm0"+k).GeneralEdit = "true";
		 eval("gcem_fsrvalnm0"+k).Alignment = 0;
		 eval("gcem_fsrvalnm0"+k).IsComma="false";
	}//for
}

/******************************************************************************
	Description : �����׸� ��¥, ���� ���� ����
	parameter   :
******************************************************************************/
function ln_Ref_Date_Money_Format(k){
	if(eval("txt_fsrefcd0"+k).value=="0966"||eval("txt_fsrefcd0"+k).value=="0968"||eval("txt_fsrefcd0"+k).value=="0969"||
		 eval("txt_fsrefcd0"+k).value=="0970"||eval("txt_fsrefcd0"+k).value=="1044"||eval("txt_fsrefcd0"+k).value=="1048"||
		 eval("txt_fsrefcd0"+k).value=="1051"||eval("txt_fsrefcd0"+k).value=="1052"||eval("txt_fsrefcd0"+k).value=="1053"||
		 eval("txt_fsrefcd0"+k).value=="1089"||eval("txt_fsrefcd0"+k).value=="1098"||eval("txt_fsrefcd0"+k).value=="1099"||
		 eval("txt_fsrefcd0"+k).value=="1125"||eval("txt_fsrefcd0"+k).value=="1126"||eval("txt_fsrefcd0"+k).value=="1127"||
		 eval("txt_fsrefcd0"+k).value=="1130"||eval("txt_fsrefcd0"+k).value=="1206"||eval("txt_fsrefcd0"+k).value=="1185"){
		 if(eval("gcem_fsrvalnm0"+k).text==""){
			 eval("gcem_fsrvalnm0"+k).format = "YYYY-MM-DD";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).Alignment = 1;
		 }
  
	}else if(eval("txt_fsrefcd0"+k).value=="1045"){ //��ȭ�ݾ��� ���
	   
	   if(eval("gcem_fsrvalnm0"+k).text==""||eval("gcem_fsrvalnm0"+k).text=="0"){
		  
		   eval("gcem_fsrvalnm0"+k).Alignment = 2;
		   eval("gcem_fsrvalnm0"+k).IsComma="true";
		   eval("gcem_fsrvalnm0"+k).format = "";
		  
		   
			//2016.04.05 jys  ��ȭ�ݾ��� �ڵ����� 0 ���� 
			if(eval("txt_fsrefcd0"+k).value=="1045"){			
				eval("gcem_fsrvalnm0"+k).text=0;
				eval("txt_fsrefval0"+k).value=0;
			}

			/*
			 eval("gcem_fsrvalnm0"+k).format = "";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).MaxLength = 12;
			 */
		 }

  //2008.05.17 ������ �߰� 
	}else if(eval("txt_fsrefcd0"+k).value=="1241"){ //����ǰ�ǹ�ȣ
	     var temp = eval("gcem_fsrvalnm0"+k).text;
			 eval("gcem_fsrvalnm0"+k).format = "00000000";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).Alignment = 1
       eval("gcem_fsrvalnm0"+k).text=temp;

     
	}else{
	   if(eval("gcem_fsrvalnm0"+k).text==""){
			 eval("gcem_fsrvalnm0"+k).format = "";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "true";
			 eval("gcem_fsrvalnm0"+k).Alignment = 0;
			 eval("gcem_fsrvalnm0"+k).IsComma="false";
		 }
	}
}

/******************************************************************************
	Description : ī���ȣ�� ī������ã��
	parameter   :
******************************************************************************/
function ln_Card_Kind_Find(g_cmtype,scardnum){
	gcds_cardkind.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s4?v_str1="+g_cmtype+"&v_str2="+scardnum+"&v_str3=&v_str4="; 
	//prompt("",gcds_cardkind.DataID);
	gcds_cardkind.Reset();

	if(gcds_cardkind.countrow>0){
		for(j=3;j<=9;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD0"+j)=="1134"){ //ī������
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL0"+j)= gcds_cardkind.namevalue(gcds_cardkind.rowposition,"GBCD");
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM0"+j)= gcds_cardkind.namevalue(gcds_cardkind.rowposition,"BANKNM");
			}
		}
	}
}

/******************************************************************************
	Description : ����ǰ�ǹ�ȣ Ȯ��
	parameter   : fdcode:����, atcode:����, fsrefval:����ǰ�ǹ�ȣ��
	ref         : 2008.05.17 �߰� 
******************************************************************************/
function ln_Buy_No_Find(fdcode,atcode,fsrefval){
	gcds_buyno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_ref_s1?v_str1="+fdcode+"&v_str2="+atcode+"&v_str3="+fsrefval; 
	//prompt(this,gcds_buyno.DataID);
	gcds_buyno.Reset();

	if(gcds_buyno.namevalue(gcds_buyno.rowposition,"CNT")>0){
	  alert("������ ����ǰ�� ��ȣ�� �����մϴ�. Ȯ�� �ٶ��ϴ�.");
		return false;
	}else{
		return true;
	}
}


/******************************************************************************
	Description : ����, �ŷ�ó lock����
	parameter   :
******************************************************************************/
function ln_Dtl_Lock(row){

	//if(hid_docuval.value!=""&&hid_docuval.value!=undefined){
    if(gcds_dtl.namevalue(row,"DOCUVAL")!=""&&gcds_dtl.namevalue(row,"DOCUVAL")!=undefined){
		gclx_documcd02.enable=false;
		if(gcem_atcode02.text=="1112120"){//�������ޱ��� ��츸 �ŷ�ó�� ��������.
			txt_vendcd02.disabled=false;
			gcem_vendnm02.Enable=true;
		}else{
			txt_vendcd02.disabled=true;
			gcem_vendnm02.Enable=false;
		}
	}else{
	  //����ī���� ��� �ŷ�ó lock
		//2008.02.01 ������
		if(gcem_atcode02.text=="2100520"){
			txt_vendcd02.disabled=true;
			gcem_vendnm02.Enable=false;
		}else{
			
			//2010.03.16 JYS �߰� ////////////////////////////////////////////////////////////////////
			//�߻��� ���� �ŷ�ó ��������
			//������ ���� �ŷ�ó �����Ұ�
			//���� ������ ��쵵 �ŷ�ó�� ���� ���� Ȱ��ȭ �ǰ���.
			/*
			gclx_documcd02.enable=true;
			txt_vendcd02.disabled=false;
			gcem_vendnm02.Enable=true;
			*/
			if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
				gclx_documcd02.enable=true;
				//�������� && �뺯!=0 ����
				if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
					if(gcem_vendnm02.text!=""&&txt_vendcd02.value!=""){
						txt_vendcd02.disabled=true;
						gcem_vendnm02.Enable=false;
					}else{
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;		
					}
				//�뺯���� && ����!=0 ����
				}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
					if(gcem_vendnm02.text!=""&&txt_vendcd02.value!=""){
						txt_vendcd02.disabled=true;
						gcem_vendnm02.Enable=false;
					}else{
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;		
					}
				}else if(gcds_dtl.namevalue(row,"DAEAMT")==0&&gcds_dtl.namevalue(row,"CHAAMT")==0){
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;	
				}else{
					//alert("�̰�Ÿ�� �ȵ�..row."+row+":�뺯:"+gcds_dtl.namevalue(row,"DAEAMT")+":����:"+gcds_dtl.namevalue(row,"CHAAMT"));
				}
			}else{
				gclx_documcd02.enable=true;
				txt_vendcd02.disabled=false;
				gcem_vendnm02.Enable=true;
			}
			/////////////////////////////////////////////////////////////////////////////////////////////
		}
	}
}


/******************************************************************************
	Description : ��ǥ ���� ���� 
	parameter   : 
******************************************************************************/
function ln_Slipno_Create(){

    var result="";
	var arrResult	= new Array();
	var strURL="";	
	var strPos="";

	//alert("��ǥ����");
	
	ln_Add('02','') //�ʱ�ȭ ��ü���  
	
	//gcds_automst.AddRow();
	
	strURL = "./autoslip_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:460px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	//result = showModalDialog(strURL,arrParam,strPos);
	result = showModalDialog(strURL,window,strPos);
	
	/*
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE") = gcds_automst.namevalue(gcds_automst.rowposition,"FDCODE");
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSAMT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"DETOT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"CRTOT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"REMARK") =  gcds_automst.namevalue(gcds_automst.rowposition,"REMARK") ;
	*/
	
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master Save��-->
<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--  -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� -->
<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--��ǥMaster ���� -->
<comment id="__NSID__"><object  id=gcds_data01_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--��ǥMaster ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data01_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--�μ��� �����ڵ� ã��-->
<comment id="__NSID__"><object  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ȣ ä���� ���� �ѱ�°� -->
<comment id="__NSID__"><object  id=gcds_input classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ�����û -->
<comment id="__NSID__"><object  id=gcds_confirm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� �μ� üũ -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �α��� ��� üũ  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- DTL_REF ��ȸ -->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF �ű��Է� -->
<comment id="__NSID__"><object  id=gcds_dtl_insert classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF ���� -->
<comment id="__NSID__"><object  id=gcds_dtl_update classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF ���� -->
<comment id="__NSID__"><object  id=gcds_dtl_del classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ� -->
<comment id="__NSID__"><object  id=gcds_documcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--��ǥ ��ü���� -->
<comment id="__NSID__"><object  id=gcds_del02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����׸��ã��-->
<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ڵ�� �����׸� ��������  �ΰ���-->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� - ���Ը�������  -->
<comment id="__NSID__"><object  id=gcds_tax classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������� - �Ϲ�����  -->
<comment id="__NSID__"><object  id=gcds_genrst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������(�������̺�:history) -->
<comment id="__NSID__"><object  id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������(�ܾ���) -->
<comment id="__NSID__"><object  id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ȸ -->
<comment id="__NSID__"><object  id=gcds_bgt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ - ��ǥ��Ͻ� �ݿ� -->
<comment id="__NSID__"><object  id=gcds_bgt_insert classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ - ��ǥ������ �ݿ�-->
<comment id="__NSID__"><object  id=gcds_bgt_update classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ - ��ǥ������ �ݿ�-->
<comment id="__NSID__"><object  id=gcds_bgt_del classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ - �����Ѱ������� �ݿ�-->
<comment id="__NSID__"><object  id=gcds_bgt_geled classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ - ��ǥ ��ü������ �ݿ�-->
<comment id="__NSID__"><object  id=gcds_bgt_del_all classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���� update��-->
<comment id="__NSID__"><object  id=gcds_fsnum classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ��ȣ���� -->
<comment id="__NSID__"><object  id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������ KEY������ : FDCODE, FSDAT, FSNBR, FSSEQ ==> FSSEQ�� MAX���� �������� ���� �ӽ� -->
<comment id="__NSID__"><object  id=gcds_fsseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��������ã��-->
<comment id="__NSID__"><object  id=gcds_banjae_atcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �������ῡ ����Ÿ ã��-->
<comment id="__NSID__"><object  id=gcds_banjae2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������� �������� �� �������� ����Ÿ ã��-->
<comment id="__NSID__"><object  id=gcds_banjae3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���ݰ�꼭 ����Ǽ�  -->
<comment id="__NSID__"><object  id=gcds_taxcnt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ü��ǥ REPORT START -->
<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_prttemp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_prttemp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- ��ü��ǥ REPORT END -->

<!-- ����üũ-->
<comment id="__NSID__"><object  id=gcds_slip_close classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ���꺻��-->
<comment id="__NSID__"><object  id=gcds_bgtdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-- ī���ȣ�� ���� ���� ã��-->
<comment id="__NSID__"><object  id=gcds_cardkind classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ������� ���ݰ�꼭��ȣ �Է�-->
<comment id="__NSID__"><object  id=gcds_tax_del_row classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
  <!-- ����ǰ�ǹ�ȣ �ߺ�ã��-->
  <object  id=gcds_buyno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

	 <!-- �ŷ�ó�� ���θ� ī�� ���� ��ȸ-->
  <object  id=gcds_card classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
   <!-- ��ǥ���� mst -->
  <object  id=gcds_automst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>
  
  	 <!-- ��ǥ���� dtl-->
  <object  id=gcds_autodtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>
  
  <!-- �ܻ���Ա� �Ϲݾ�ü üũ -->
  <object  id=gcds_chk1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
   <!-- ���з� �ŷ�ó ��� üũ -->
  <object  id=gcds_bond_attach_his classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
</comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- �Է�/���� -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020009_t1(I:USER=gcds_mst,I:USER2=gcds_dtl_insert,I:USER3=gcds_dtl_update,I:USER4=gcds_dtl_del,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_tax,I:USER8=gcds_genrst,I:USER9=gcds_bgt_insert,I:USER10=gcds_bgt_update,I:USER11=gcds_bgt_del,I:USER12=gcds_bgt_geled,I:USER13=gcds_fsnum,I:USER15=gcds_tax_del_row,O:USER5=gcds_slipno)">   

</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ü ����  -->
<comment id="__NSID__"><object  id=gctr_data02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t2f(I:USER=gcds_del02,I:USER22=gcds_bgt_del_all)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ����  -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6f(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  

<!-- multi ����  -->
<comment id="__NSID__"><object  id=gctr_data07 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t7(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	//window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.1";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	//window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<script language="javascript" for="gcds_data01_2" event="OnLoadStarted()">
</script>

<script language="javascript" for="gcds_data01_2" event="onloadCompleted(row,colid)">
    
    //alert("gcds_data01_2::row::"+row);
	if (row<1){
	    ln_DataSet_Clear();
		//ln_Data_Mst_Setting();

		gclx_fdcode02.bindcolval=hid_b_fdcode.value;
		gcem_fs02.text=hid_b_fs.value; 
		gcem_fsdat02.text=hid_b_fsdat.value; 
		gcem_fsnbr02.text=hid_b_fsnbr.value;
	}
</script>

<script language="javascript" for="gcds_dtl" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.2";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dtl" event="onloadCompleted(row,colid)">
    //alert("gcds_dtl::row::"+row);
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1){
	    ln_DataSet_Clear();
		//ln_Data_Mst_Setting();
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	if (row>=1){
		gs_deptcd=gcds_dept.namevalue(row,"DEPTCD");
		gs_deptnm=gcds_dept.namevalue(row,"DEPTNM");
	}
</script>

<script language="javascript" for="gcds_divcd" event="onloadCompleted(row,colid)">
		//alert("row::"+row+"::gcds_divcd::"+gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD"));
</script>

<script language=JavaScript for=gcds_documcd event=OnLoadCompleted(rowcnt)>
	gcds_documcd.insertrow(1);
	gcds_documcd.namevalue(1,"CDCODE") = "000";
	gcds_documcd.namevalue(1,"CDNAM") = "";
	gclx_documcd02.index = 0;
</script>

<!-- ��ü��ǥ -->
<script language=JavaScript  for=gcds_prttemp1 event=OnLoadCompleted(rowcount)>
	if(rowcount>=1){
	  ln_PrintSubQuery();
	}
</script>

<script language=JavaScript  for=gcds_prttemp2 event=OnLoadCompleted(rowcount)>
	if(rowcount>=1){
	  document.all.LowerFrame.style.visibility="visible";
	  ln_PrintSubQuery2();
		document.all.LowerFrame.style.visibility="hidden";
	}else{
		alert("����� ������ �����ϴ�.");
	}
</script>

<script language=JavaScript for=gcds_dtl event=OnRowPosChanged(row)>

	//���ݰ�꼭 ��ȣ�� ������ ���� lock�� ������.
	ln_Dtl_Lock(row);

	//�ݾ� lock������.
	ln_Dtl_Amt_Lock(row);

    /////////////////////////
	//2010.03.16 JYS ���� lock����
    ln_Atcode_Lock(row);
    ///////////////////////// 

	////ln_Ref_Format_Setting(row); //�����׸��� ��¥, ���� �׸� ����
	for(k=3;k<=9;k++){
		if(eval("txt_fsrefcd0"+k).value==""){
			eval("gcem_fsrvalnm0"+k).enable = false;
			eval("txt_fsrefval0"+k).disabled = true;
		}else{
			//hid_lastref.value = k;
			eval("gcem_fsrvalnm0"+k).enable = true;
			eval("txt_fsrefval0"+k).disabled = false;
		}	
		ln_Ref_Date_Money_Format(k);
	}

	//2009.01.29 ���θ� ����ī��
	if(gcds_dtl.namevalue(row,"ATCODE")=="2100525"){
    	ln_Ref_Card_Lock("F",row);
	}
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for= gcem_detot02 event=onKillFocus()>
  ln_Chk_Atcode_Amt();
  gcem_fsamt02.text = gcds_dtl.sum(9,0,0);
</script>

<script language=JavaScript for= gcem_crtot02 event=onKillFocus()>
  ln_Chk_Atcode_Amt();
</script>

<script language=JavaScript for= gcem_remark02_1 event=onKillFocus()>
  if(gcds_dtl.rowposition == 1)ln_remark(gcem_remark02_1.text);
</script>

<!-- �μ� / �ŷ�ó / �����׸� -->
<script language=JavaScript for=gcem_deptnm02_1 event=OnKeyUp()>
  ln_onblur("gcem_deptnm02_1");
</script>

<script language=JavaScript for=gcem_vendnm02 event=OnKeyUp()>
  ln_onblur("gcem_vendnm02");
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm03");
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm04");
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm05");
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm06");
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm07");
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm08");
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm09");
</script>

<script language=JavaScript for=gcem_remark02_1 event=onKeyDown(kcode,scode)>
	if(kcode==13){
		if(hid_lastref.value==2){
		  if(gcem_remark02.text=="") ln_remark(gcem_remark02_1.text);
			ln_Row_Auto_Add(hid_lastref.value,"02");
		}else{
			gcem_fsrvalnm03.Focus();
		}
	}
</script> 

<script language=JavaScript for=gcem_atcode02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup_Atcode('01');
</script>

<script language=JavaScript for=gcem_atkornam02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup_Atcode('02');
</script>

<script language=JavaScript for=gcem_deptnm02_1 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('02_1','gcem_deptnm02_1',kcode);
</script>

<script language=JavaScript for=gcem_vendnm02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('02','gcem_vendnm02',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('03','gcem_fsrvalnm03',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('04','gcem_fsrvalnm04',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('05','gcem_fsrvalnm05',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('06','gcem_fsrvalnm06',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
  //2008.07.03 ����ī�� �����ޱ��ΰ��
	if(gcem_atcode02.text=="2100520"){
		if(gcem_fsrvalnm07.Text.length>=9) {
			alert("����ī�� �ŷ�ó���� 8�ڱ��� �Է°����մϴ�.");
      gcem_fsrvalnm07.Text ="";
			gcem_fsrvalnm07.Focus();
  	} 
	}
	if (kcode==13||kcode==113)ln_Popup2('07','gcem_fsrvalnm07',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('08','gcem_fsrvalnm08',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('09','gcem_fsrvalnm09',kcode);
</script>

<script language=JavaScript for=gclx_fswrkdiv02 event=OnSelChange()>
	if(gclx_fswrkdiv02.bindcolval=="01"){ //�������� ��� ����μ� Clear
		for(k=3;k<=9;k++){
			if(eval("txt_fsrefcd0"+k).value=="0003"){
				 eval("gcem_fsrvalnm0"+k).text="";
         		 eval("txt_fsrefval0"+k).value="";
				 break;
			}
		}
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
    var temp="";
    gclx_fdcode02.bindcolval = gcds_slipno.namevalue(gcds_slipno.rowposition,"FDCODE");
	temp = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSDAT");
    gcem_fs02.text = temp.substring(0,1);
	gcem_fsdat02.text = temp.substring(1,9);
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");

	gcds_mst.ClearData();
	gcds_dtl_update.ClearData();
	gcds_dtl_insert.ClearData();
	gcds_dtl_del.ClearData();
	gcds_banjae.ClearData();
</script>


<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	gclx_fsstat02.bindcolval = "R";
	gcds_confirm.ClearData();
</script>

<script language="javascript" for="gctr_data06" event="onfail()">
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
	//alert("Error Code : " + gcds_confirm.ErrorCode + "\n" + "Error Message : " + gcds_confirm.ErrorMsg + "\n");
	gcds_confirm.ClearData();
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-- ��ǥ�Է�=========================================================================================================== -->

			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a020001_1_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<!-- <img src="../../common/img/btn/com_b_exit.gif"  style="cursor:hand" onclick="ln_Cancel('02')"> -->
						<span id=sp4 >
						<img src="../../Common/img/btn/com_b_slipsts.gif"   style="cursor:hand" onclick="ln_Popup('09')">	
						<img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('02')">
					 	<img src="../../Common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()" > 
						<img src="../../Common/img/btn/com_btn_slipdel.gif"	style="cursor:hand" onClick="ln_Delete_All()" >
          <!--  <img src="../../common/img/btn/com_btn_actdel.gif"	style="cursor:hand" onClick="ln_Delete('99')" > -->
						<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand" onclick="ln_Add('02','')">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
						</span>
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03');ln_Query('01')">
					
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��ǥ��ȣ</nobr></td>
								<td class="tab18" style="width:160px;"><nobr>&nbsp;<comment id="__NSID__">
                  <object  id=gcem_ss02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_ssdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_ssnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

                <td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;����</nobr></td>
								<td class="tab18" style="width:160px;" ><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
											<param name=ComboDataID    value="gcds_comfield02">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value="FDNAME">
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME^0^150">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>

                <td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;<comment id="__NSID__">	
									<object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
											<param name=CBData			   value="Y^����Ϸ�,R^�����û,N^������,C^�������,B^�ݼ�">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME^0^110">								
											<param name=BindColumn		 value="CODE">
											<param name=Enable         value=false>

									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr> 
								</td>
                
                <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;���μ�&nbsp;</nobr></td>
								<td class="tab18" style="width:120px;"><nobr>&nbsp;	
									<input id="txt_deptcd02" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true";> 
									<input id="txt_deptnm02" type="text"   class="txtbox" style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7"  readOnly="true";></nobr>	
								</td>
							</tr>

							<tr width="876px"> 
                <td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;������ȣ</nobr></td>
								<td class="tab19" style="width:160px;"><nobr>&nbsp;<comment id="__NSID__">
                  <object  id=gcem_fs02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_fsdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
								
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;ȸ������&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;top:2px;width:70px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
											</object></comment><script>__ws__(__NSID__);</script> 
											<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
											
											<comment id="__NSID__"><object  id=gcem_fswrtdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;top:2px;width:1px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=Visible        value="false">
											<param name=PromptChar	  value="_">
										</object></comment><script>__ws__(__NSID__);</script> 
										<input type=hidden  id=hid_actdat02  value=''>
										<input type=hidden  id=hid_cocode02  value=''>
								</td>
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ݾ�&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;"><nobr>&nbsp;<comment id="__NSID__">	
									<object  id=gcem_fsamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
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

								<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�����&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;"><nobr>&nbsp;
								 <input id="txt_empno02" type="hidden" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true";>
								 <input id="txt_empnmk02" type="text" class="txtbox"   style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7" readOnly="true";>
									</nobr>
								</td>
							</tr>
              
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;����</nobr></td>
								<td colspan=7 class="tab19" style="width:795px;" ><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_remark02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:795px;height:20px;position:relative;left:0px;top:3px">				
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=ReadOnly      value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=ReadOnlyBackColor   value="#D7D7D7">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
									<input id="txt_fsknd02" type="hidden" class="txtbox" style= "width:10px;height:20px;position:relative;left:-4px"  readOnly="true";> 
								</td>
							</tr>
							<tr width="876px"> 
							</tr>
					 </table>
					</td>
				</tr>
				<tr>
					<td>
						<table width=876px cellpadding=0 cellspacing=0 border=0 style=position:relative;left:0px>
             				<tr width=876px  >			
							   <td width="476px" align=left >
							   	<span id=sp1 >
							      <font style="position:relative;top:-4px;left:0px">* �ܻ���Ա�(�Ϲݾ�ü) ���� üũ ����</font>
						          <input type=checkbox  id=chkbox_1  style="width:15px;position:relative;left:0px;top:-5px;color:#CCFFCC";>&nbsp;&nbsp;
		      			        </span> 
							   
							   </td>
							   <td width="460px" align=right > 
								    
								    <!--<img src="../../Common/img/btn/com_b_bgtcon.gif"	 style="cursor:hand;position:" onClick="ln_Slipno_Create()">-->
								
									<img src="../../Common/img/btn/com_b_bgtcon.gif"	 style="cursor:hand;position:" onClick="ln_BgtFind()">
								  <span id=sp0>
									<img src="../../Common/img/btn/com_btn_repay.gif"	 style="cursor:hand;position:" onClick="ln_Popup_Repay()">
									<img src="../../Common/img/btn/com_btn_repay_md.gif"	 style="cursor:hand;position:" onClick="ln_Popup_Repay_Modify()"> 
								  </span>
								  
								  <span id=sp3 >
									<img src="../../Common/img/btn/com_b_rowdel.gif"	 style="cursor:hand;position:" onClick="ln_Delete('dis')">
									<img src="../../Common/img/btn/com_b_rowadd.gif"   style="cursor:hand;position:" onclick="ln_Add('99','')">
									<img src="../../Common/img/btn/com_btn_insert_add.gif"   style="cursor:hand;position:" onclick="ln_Insert()">
								  </span>
								</td>
							</tr>
						</table>
						<table width=876px cellpadding=0 cellspacing=0 border=0 style=position:relative;left:0px>
							<tr>
								<td style="width:280" ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
										style="position:relative;left:-1px;width:875px; height:240px; border:1 solid #708090;display:block;" viewastext>
											<PARAM NAME="DataID"			VALUE="gcds_dtl">
											<PARAM NAME="IndWidth"		VALUE ='0'>
											<PARAM NAME="BorderStyle" VALUE="0">
											<PARAM NAME="Fillarea"		VALUE="true">
											<PARAM NAME="Sortview"		VALUE="left">
											<param name="ViewSummary"	value=1>
											<param name="ColSizing"   value="true">
											<param name="Editable"    value="false">
											<param name="ColSelect"		value=false>
                                            <param name=SelectionColor  value="
												<SC>Type='CurRow',       BgColor='#0660B9',  TextColor='White'</SC>	
												<SC>Type='FocusCurCol',  BgColor='#0660B9',  TextColor='White'</SC>
											">

											<PARAM NAME="Format"			VALUE=" 
											  <FC>Name='����'		   ID=FSNUM 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=26	  align=center   SumBgColor=#C3D0DB </FC> 
												<FC>Name='�����ڵ�'	 ID=ATCODE 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=51   align=left	 edit=none  SumBgColor=#C3D0DB </FC> 
												<FC>Name='������'		 ID=ATKORNAM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left	 edit=none  SumBgColor=#C3D0DB SumText='��   ��'</FC> 
												<FC>Name='�����ݾ�'	 ID=CHAAMT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=right	 edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#0000FF  sumcolor =#0000FF</FC> 
												<FC>Name='�뺯�ݾ�'	 ID=DAEAMT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=right  edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#FF0000  sumcolor =#FF0000</FC> 
												<C> Name='������'	   ID=DOCUMCD 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=left   edit=none  SumBgColor=#C3D0DB SumText='����-�뺯'  EditStyle=Combo Data='000:,101:���ݰ�꼭,102:��꼭,103:�ſ�ī��(����),104:���ݿ�����(����),201:�ſ�ī��(�Ұ�),202:���ְ���,203:���̿�����'</C> 
												<C> Name='����'			 ID=REMARK        HeadAlign=Center HeadBgColor=#B9D4DC Width=205	align=left	 edit=none  SumBgColor=#C3D0DB SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
												<C> Name='����'		   ID=FSWRKDIV 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40	  align=center edit=none  SumBgColor=#C3D0DB EditStyle=Combo Data='01:������,02:����'</C> 
												<C> Name='�ŷ�ó'		 ID=FSRVALNM02 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left   edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�μ�'		   ID=FSRVALNM01 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�3' ID=FSRVALNM03 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�4' ID=FSRVALNM04 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�5' ID=FSRVALNM05 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�6' ID=FSRVALNM06 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�7' ID=FSRVALNM07 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�8' ID=FSRVALNM08	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
												<C> Name='�����׸�9' ID=FSRVALNM09 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   

								</td>
							</tr>
				 			<tr>
								 <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px">
										<tr><td style="height:2px;"> </td></tr>
								 </table>
					
								  <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:24px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab15 ><nobr>����</nobr></td>
												<td style="width:51px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>�����ڵ�</nobr></td>
												<td style="width:170px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;������&nbsp;</nobr></td>
												<td style="width:95px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;�����ݾ�&nbsp;</nobr></td>
												<td style="width:95px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;�뺯�ݾ�&nbsp;</nobr></td>
												<td style="width:125px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;������&nbsp;</nobr></td>
												<!-- <td style="width:355px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;����&nbsp;</nobr></td> -->
												<td style="width:165px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>�ŷ�ó</nobr></td>
												<td style="width:140px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>�μ�</nobr></td>
										</tr>	
										<tr><!--����-->
										<td class="tab15" style="width:24px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsnum02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;top:3px;">				
											<param name=Text					value="">
											<param name=Border        value=false>
										  <param name=Format            value="00">
											<param name=Enable          value=false>
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false> 
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--�����ڵ�-->
										<td class="tab18" style="width:51px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_atcode02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:47px;height:20px;position:relative;top:3px;" tabindex=1>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Numeric       value=false>
											<param name=Format        value="0000000">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--������-->
										<td class="tab18" style="width:170px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_atkornam02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:165px;height:20px;position:relative;top:3px;font-size:12px;ime-mode:active;" tabindex=2>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--����-->
										<td class="tab18" style="width:95px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_detot02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#0000ff;position:relative;top:4px;left:-2px;width:90px;" tabindex=3>				
													<param name=Text					value=0>
													<param name=Border        value=false>
													<param name=Alignment     value=2>
													<param name=Numeric       value="true">
													<param name=IsComma       value=true>
													<param name=MaxLength     value=12>
													<param name=SelectAll     value=true>
													<!-- <param name=BackColor     value="#C3D0DB"> -->
													<param name=ReadOnlyForeColor  value="#0000FF">
													<param name=InheritColor  value=true>
											</object></comment><script>__ws__(__NSID__);</script>
										</td><!--�뺯-->
										<td class="tab18" style="width:95px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object id=gcem_crtot02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="color:#ff0000;position:relative;top:4px;left:-2px;width:90px;" tabindex=4>				
													<param name=Text					value=0>
													<param name=Border        value=false>
													<param name=Alignment     value=2>
													<param name=Numeric       value="true">
													<param name=IsComma       value=true>
													<param name=MaxLength     value=12>
													<param name=SelectAll     value=true>
													<!-- <param name=BackColor     value="#C3D0DB"> -->
													<param name=ReadOnlyForeColor   value="#FF0000">
													<param name=InheritColor  value=true>
											</object></comment><script>__ws__(__NSID__);</script>
										</td><!--����-->
										<td class="tab18" style="width:125px;"><nobr>&nbsp;<comment id="__NSID__">
										<object  id=gclx_documcd02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:-3px;top:2px;font-size:12px;width:105px;">
												<param name=ComboDataID    value="gcds_documcd">
												<param name=CBDataColumns	 value="CDCODE,CDNAM">
												<param name=SearchColumn	 value=FDNAME>
												<param name=Sort			     value=false>
												<param name=ListExprFormat value="CDNAM^0^100">								
												<param name=BindColumn		 value="CDCODE">
										</object></comment><script>__ws__(__NSID__);</script>
										<img src='../img/plus.gif' value='plus2.gif' id=img_plus1  onclick=ln_Popup_Tax() style="position:relative;width:16px;left:-3px;top:0px;cursor:hand;">
										</td>
                    <!--�ŷ�ó--> 
										<td class="tab18" style="width:165px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_vendnm02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:164px;height:20px;position:relative;top:3px;" tabindex=5>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_vendcd02    value=''>
										<input type=hidden  id=txt_fsrefnm02   value='�ŷ�ó'>
										<input type=hidden  id=txt_fsrefcd02   value='0020'>
										<input type=hidden  id=txt_fsrefseq02  value=''>
										<input type=hidden  id=txt_type02      value=''>
										<input type=hidden  id=txt_arbaldiv02  value=''>
										</td>

                     <!--�μ�-->
										<td class="tab18" style="width:140px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_deptnm02_1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:135px;height:20px;position:relative;top:3px;" tabindex=6>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_deptcd02_1   value=''>
										<input type=hidden  id=txt_fsrefnm01    value='�μ�'>
										<input type=hidden  id=txt_fsrefcd01    value='0002'>
										<input type=hidden  id=txt_fsrefseq01   value=''>
										<input type=hidden  id=txt_type01       value=''>
										<input type=hidden  id=txt_arbaldiv01   value=''>
										</td>
									</tr>	
								</table> 

								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:75px;height:20px;text-align:center"  bgcolor="#C3D0DB"  class=tab15 ><nobr>����</nobr></td>
												<td class="tab18" style="width:653px;"><nobr>&nbsp;<comment id="__NSID__">
												 <object  id=gcem_remark02_1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:650px;height:20px;position:relative;top:3px;" tabindex=7>				
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=false>
													<param name=Format        value="">
													<param name=GeneralEdit   value="true">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
												</td>

												<!--����-->
												<td style="width:69px;height:20px;text-align:center"  bgcolor="#C3D0DB"  class=tab18 ><nobr>����</nobr></td>
												<td class="tab18" style="width:70px;"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gclx_fswrkdiv02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:-3px;top:2px;font-size:12px;width:65px;">
														<param name=CBData			   value="01^������,02^����">
														<param name=CBDataColumns	 value="CODE,NAME">
														<param name=SearchColumn	 value=NAME>
														<param name=Sort			     value=false>
														<param name=ListExprFormat value="NAME^0^65">								
														<param name=BindColumn		 value="CODE">
												</object></comment><script>__ws__(__NSID__);</script> 	
												</td>
										</tr>	
								</table> 

								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:116px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab15 ><nobr>
													<input type=text    id=txt_fsrefnm03 value="�����׸�1"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd03 value=''>
													<input type=hidden  id=txt_fsrefseq03 value=''>
													<input type=hidden  id=txt_type03     value=''>
													<input type=hidden  id=txt_arbaldiv03 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm04 value="�����׸�2"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd04 value=''>
													<input type=hidden  id=txt_fsrefseq04 value=''>
													<input type=hidden  id=txt_type04     value=''>
													<input type=hidden  id=txt_arbaldiv04 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm05 value="�����׸�3"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd05 value=''>
													<input type=hidden  id=txt_fsrefseq05 value=''>
													<input type=hidden  id=txt_type05     value=''>
													<input type=hidden  id=txt_arbaldiv05 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm06 value="�����׸�4"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd06 value=''>
													<input type=hidden  id=txt_fsrefseq06 value=''>
													<input type=hidden  id=txt_type06     value=''>
													<input type=hidden  id=txt_arbaldiv06 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm07 value="�����׸�5"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd07 value=''>
													<input type=hidden  id=txt_fsrefseq07 value=''>
													<input type=hidden  id=txt_type07     value=''>
													<input type=hidden  id=txt_arbaldiv07 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm08 value="�����׸�6"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd08 value=''>
													<input type=hidden  id=txt_fsrefseq08 value=''>
													<input type=hidden  id=txt_type08     value=''>
													<input type=hidden  id=txt_arbaldiv08 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm09 value="�����׸�7"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd09 value=''>
													<input type=hidden  id=txt_fsrefseq09 value=''>
													<input type=hidden  id=txt_type09     value=''>
													<input type=hidden  id=txt_arbaldiv09 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_enter value=""  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
												</nobr></td>
										</tr>	
										<tr>
										<td class="tab15" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=8>				
											<param name=Text					value="">
											<param name=Border        value=false>
										  <param name=Format        value="">
											<!-- <param name=PromptChar    value="">	 -->
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval03   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm04   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;left:-2" tabindex=9>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval04   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm05   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=10>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval05   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm06   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=11>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval06   value=''>
										</td>
										
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm07   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=12>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval07   value=''>
										</td>
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm08   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=13>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval08   value=''>
										</td>
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm09   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=14>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval09   value=''>
										
										<input type=hidden  id=hid_atdeptyn     value=''>
										<input type=hidden  id=hid_atdecr       value=''>
										<input type=hidden  id=hid_bgtcmtype    value=''>
										<input type=hidden  id=hid_bgtdiv       value=''><!--���꺻��-->
										<input type=hidden  id=hid_funddiv      value=''>
										<input type=hidden  id=hid_banjaeref    value=''><!--��������-->
										<input type=hidden  id=hid_divcd        value=''><!--�����ڵ�-->
										<input type=hidden  id=hid_type         value=''><!--����Ÿ��-->
										<input type=hidden  id=hid_fdcode       value=''>
										<input type=hidden  id=hid_fsdat        value=''><!--������ȣ9�ڸ�(���а�+YYYYMMDD-->
                    					<input type=hidden  id=hid_fsnbr        value=''>
										<input type=hidden  id=hid_fsseq        value=''>
										<input type=hidden  id=hid_docuval      value=''>
										<input type=hidden  id=hid_cnt          value=0>
										<input type=hidden  id=hid_banjaeyn     value=''>
										<input type=hidden  id=hid_fsstat       value=''>
										<input type=hidden  id=hid_bgtcnt       value=0><!--���꼼��Ǽ�-->
										<input type=hidden  id=hid_lastref      value=0><!--�����׸� ��������-->
										<input type=hidden  id=hid_banjaemod    value=''><!--������������-->
                                        <!--�Է½ø��� �����ؼ� �����.-->
										<input type=hidden  id=hid_copy_deptcd  value=""><!--�μ�����-->
										<input type=hidden  id=hid_copy_deptnm  value=""><!--�μ�����-->
										<input type=hidden  id=hid_copy_divcd   value=""><!--���κ���-->
										<input type=hidden  id=hid_copy_vendcd  value=""><!--�ŷ�ó����-->
										<input type=hidden  id=hid_copy_vendnm  value=""><!--�ŷ�ó����-->
										<input type=hidden  id=hid_copy_documcd value=""><!--�������к���-->
										<input type=hidden  id=hid_copy_documnm value=""><!--�������к���-->
										<input type=hidden  id=hid_copy_docuval value=""><!--����������-->
										<input type=hidden  id=hid_copy_bgtdept value=""><!--����μ�����-->
										<input type=hidden  id=hid_copy_bgtdeptnm value=""><!--����μ�����-->
										<input type=hidden  id=hid_copy_bgtdiv  value=""><!--���꺻�κ���-->
										<input type=hidden  id=hid_copy_remark  value=""><!--���亹��-->
										<!-- <input type=hidden  id=hid_arbaldiv     value=0> --><!--�����׸��ʼ����ñ���-->
										<input type=hidden  id=hid_atcurtype  value=""><!--�ݰ��� ȯ����ȭ����-->
										<input type=hidden  id=hid_gredgb  value="">   <!--ä��(��)�з� �ŷ�óüũ-->
										
										</td>

										<td class="tab18" style="width:96px;" align=center><nobr>
										   <!--����Ÿ�� �������� ���� ��� ���� ����Ÿ ����-->
												<input type=hidden  id=hid_b_fdcode       value=''>
												<input type=hidden  id=hid_b_fs           value=''>
												<input type=hidden  id=hid_b_fsdat        value=''>
											    <input type=hidden  id=hid_b_fsnbr        value=''  style="cursor:hand;position:relative;top:2px;left:3px;" >
										</td>
									</tr>	
								</table> 
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px">
										<tr><td style="height:3px;"> </td></tr>
								</table>
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
									<tr>
										<td style="width:117px;height:20px;"   align=center class=tab15><nobr>&nbsp;����&nbsp;</nobr></td>
										<td style="width:116px;height:16px;"   class=tab18><comment id="__NSID__">
										<object  id=gcem_realbgt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 										
										</td>
										<td style="width:116px;height:16px;"  align=center class=tab18> <nobr>&nbsp;����&nbsp;</nobr></td>
										<td style="width:117px;height:16px;"   class=tab18 ><nobr><comment id="__NSID__">
											<object  id=gcem_results  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
                     						<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										
										</nobr></td>
										<td style="width:97px;height:16px;"  align=center class=tab18><nobr>����(�̽�������)</nobr></td>
										<td style="width:97px;height:16px;"  class=tab18 ><nobr><comment id="__NSID__">
										<object  id=gcem_bresults  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:97px;height:16px; tabindex=-1 >		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
										<td style="width:97px;height:16px;"  align=center class=tab18 ><nobr>&nbsp;�ܾ�&nbsp;</nobr></td>
										<td style="width:95px;height:16px;"  class=tab18><nobr><comment id="__NSID__">
										<object  id=gcem_janamt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:94px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
									</tr>		
							 </table>
							 
							 <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
									<tr>
										<td style="width:119px;height:20px;"  align=center class=tab15> <nobr>&nbsp;������ȣ&nbsp;</nobr></td>
										<td style="height:16px;"   class=tab18 colspan=7><nobr><comment id="__NSID__">&nbsp;
											<object  id=gcem_docuval_xx  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			   value=''> 
											<param name=Border             value=false>
											<param name=Alignment		   value=0>
											<param name=Format             value="#######-####">
                     						<param name=ReadOnly           value=true>
											<param name=InheritColor       value=true>
											<param name=ReadOnlyForeColor  value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
									</tr>		
							 </table>
					</td>
				</tr>  
			</table>
 
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-- ��ǥ��� -->
<!-- ��ǥ��� MASTER ��ȸ �� ������ ���-->
<comment id="__NSID__"><object  id=gcbn_data01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01_2>
	<param name=BindInfo  value='  
	<C>Col=FDCODE	      Ctrl=gclx_fdcode02	      Param=BindColVal</C>
	<C>Col=FSDAT1       Ctrl=gcem_fs02            Param=Text</C>
	<C>Col=FSDAT2       Ctrl=gcem_fsdat02         Param=Text</C>
	<C>Col=FSNBR	      Ctrl=gcem_fsnbr02		      Param=Text</C>
	<C>Col=FSSTAT	      Ctrl=gclx_fsstat02		    Param=BindColVal</C>
	<C>Col=DEPTCD	      Ctrl=txt_deptcd02	        Param=value</C>
    <C>Col=DEPTNM	      Ctrl=txt_deptnm02	        Param=value</C>
	<C>Col=EMPNO        Ctrl=txt_empno02          Param=value</C>
	<C>Col=EMPNMK       Ctrl=txt_empnmk02         Param=value</C>
	<C>Col=FSWRTDAT     Ctrl=gcem_fswrtdat02		  Param=Text</C>
	<C>Col=ACTDAT       Ctrl=gcem_actdat02		    Param=Text</C>
	<C>Col=FSAMT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=DETOT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=CRTOT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=REMARK       Ctrl=gcem_remark02		    Param=Text</C>
	<C>Col=SSDAT1       Ctrl=gcem_ss02            Param=Text</C>
	<C>Col=SSDAT2       Ctrl=gcem_ssdat02         Param=Text</C>
	<C>Col=SSNBR	      Ctrl=gcem_ssnbr02		      Param=Text</C>
	
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<!-- ��ǥ��� DTL ��ȸ-->
<comment id="__NSID__"><object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID          value=gcds_dtl>
	<param name=BindInfo  value='  
	<C>Col=FDCODE         Ctrl=hid_fdcode   	     Param=value</C>
	<C>Col=FSDAT          Ctrl=hid_fsdat           Param=value</C>
    <C>Col=FSNBR          Ctrl=hid_fsnbr           Param=value/C>
	<C>Col=FSSEQ          Ctrl=hid_fsseq           Param=value</C>
	<C>Col=ATCODE         Ctrl=gcem_atcode02       Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02		 Param=Text</C>
	<C>Col=ATDECR         Ctrl=hid_atdecr	         Param=value</C>
	<C>Col=REMARK         Ctrl=gcem_remark02_1     Param=Text</C>
	<C>Col=CHAAMT         Ctrl=gcem_detot02  	     Param=Text</C>
	<C>Col=DAEAMT         Ctrl=gcem_crtot02        Param=Text</C>
	<C>Col=FSREFSEQ01     Ctrl=txt_fsrefseq01      Param=value</C>
	<C>Col=FSREFSEQ02     Ctrl=txt_fsrefseq02      Param=value</C>
	<C>Col=FSREFSEQ03     Ctrl=txt_fsrefseq03      Param=value</C>
	<C>Col=FSREFSEQ04     Ctrl=txt_fsrefseq04      Param=value</C>
	<C>Col=FSREFSEQ05     Ctrl=txt_fsrefseq05	     Param=value</C>
	<C>Col=FSREFSEQ06     Ctrl=txt_fsrefseq06      Param=value</C>
  <C>Col=FSREFSEQ07     Ctrl=txt_fsrefseq07      Param=value</C>
	<C>Col=FSREFSEQ08     Ctrl=txt_fsrefseq08      Param=value</C>
	<C>Col=FSREFSEQ09     Ctrl=txt_fsrefseq09      Param=value</C>
	<C>Col=FSREFCD01      Ctrl=txt_fsrefcd01		   Param=value</C>
	<C>Col=FSREFCD02      Ctrl=txt_fsrefcd02	   	 Param=value</C>
	<C>Col=FSREFCD03      Ctrl=txt_fsrefcd03     	 Param=value</C>
	<C>Col=FSREFCD04      Ctrl=txt_fsrefcd04	   	 Param=value</C>
	<C>Col=FSREFCD05      Ctrl=txt_fsrefcd05     	 Param=value</C>
	<C>Col=FSREFCD06      Ctrl=txt_fsrefcd06     	 Param=value</C>
	<C>Col=FSREFCD07      Ctrl=txt_fsrefcd07     	 Param=value</C>
	<C>Col=FSREFCD08      Ctrl=txt_fsrefcd08     	 Param=value</C>
	<C>Col=FSREFCD09      Ctrl=txt_fsrefcd09     	 Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_deptcd02_1      Param=value</C>
	<C>Col=FSREFVAL02     Ctrl=txt_vendcd02        Param=value</C>
  <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03      Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04      Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05      Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06		   Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	     Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08      Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	     Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01			 Param=value</C>
	<C>Col=FSREFNM02      Ctrl=txt_fsrefnm02			 Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03			 Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04			 Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05			 Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06			 Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07			 Param=value</C>
  <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08			 Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09			 Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_deptnm02_1     Param=Text</C>
	<C>Col=FSRVALNM02     Ctrl=gcem_vendnm02   		 Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	   Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01         Ctrl=txt_type01				   Param=value</C>
	<C>Col=TYPE02         Ctrl=txt_type02				   Param=value</C>
	<C>Col=TYPE03         Ctrl=txt_type03				   Param=value</C>
    <C>Col=TYPE04         Ctrl=txt_type04				   Param=value</C>
	<C>Col=TYPE05         Ctrl=txt_type05				   Param=value</C>
	<C>Col=TYPE06         Ctrl=txt_type06				   Param=value</C>
	<C>Col=TYPE07         Ctrl=txt_type07				   Param=value</C>
	<C>Col=TYPE08         Ctrl=txt_type08				   Param=value</C>
	<C>Col=TYPE09         Ctrl=txt_type09				   Param=value</C>
	<C>Col=ARBALDIV01     Ctrl=txt_arbaldiv01	     Param=value</C>          
	<C>Col=ARBALDIV02     Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV03     Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV04     Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV05     Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV06     Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV07     Ctrl=txt_arbaldiv07	     Param=value</C>
	<C>Col=ARBALDIV08     Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV09     Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT            Ctrl=hid_cnt             Param=value</C>
	<C>Col=DOCUMCD        Ctrl=gclx_documcd02      Param=BindColVal</C>
	<C>Col=FSWRKDIV       Ctrl=gclx_fswrkdiv02	   Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT         Ctrl=hid_fsstat          Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM          Ctrl=gcem_fsnum02	       Param=Text</C>
	<C>Col=DIVCD          Ctrl=hid_divcd           Param=value</C>
    <C>Col=BGTDIV         Ctrl=hid_bgtdiv          Param=value</C>
	<C>Col=FUNDDIV        Ctrl=hid_funddiv         Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF        Ctrl=hid_lastref         Param=value</C>
	<C>Col=BANJAEMOD      Ctrl=hid_banjaemod       Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype       Param=value</C>
	
	<C>Col=DOCUMCD        Ctrl=gcem_documcd_xx     Param=text</C>
	<C>Col=DOCUVAL        Ctrl=gcem_docuval_xx     Param=text</C>
	<C>Col=CREDGB         Ctrl=hid_gredgb          Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - �� ü �� ǥ
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print">
	<param NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"			VALUE="true">
	<PARAM NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="LandScape"					VALUE="true">
	<param name="NullRecordFlag"    value="false">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=455 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1130 ,top=34 ,right=1969 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=2024 ,top=344 ,right=2024 ,bottom=452 </L>
	<L> left=241 ,top=452 ,right=2823 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=2397 ,top=180 ,right=2818 ,bottom=233 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2823 ,top=344 ,right=2823 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='��    ��' ,left=2429 ,top=402 ,right=2815 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��    ��' ,left=2032 ,top=402 ,right=2418 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2421 ,top=344 ,right=2421 ,bottom=452 </L>
	<T>id='��ȭ����' ,left=2032 ,top=349 ,right=2418 ,bottom=394 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��ȭ�뺯' ,left=2429 ,top=349 ,right=2815 ,bottom=394 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1445 ,top=344 ,right=1445 ,bottom=452 </L>
	<T>id='�����׸�' ,left=1159 ,top=402 ,right=1442 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='����' ,left=246 ,top=349 ,right=341 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=344 ,right=241 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=344 ,top=344 ,right=344 ,bottom=452 </L>
	<L> left=344 ,top=397 ,right=2823 ,bottom=397 </L>
	<L> left=241 ,top=344 ,right=2823 ,bottom=344 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='������' ,left=1834 ,top=349 ,right=2021 ,bottom=394 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�μ���/������' ,left=1159 ,top=349 ,right=1442 ,bottom=394 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='CURDT', left=1122, top=291, right=1953, bottom=336 ,mask='ȸ������ :     XXXX   ��   XX   ��   XX   ��', face='����', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����׸�' ,left=1834 ,top=402 ,right=2021 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1154 ,top=344 ,right=1154 ,bottom=452 </L>
	<T>id='����/������' ,left=868 ,top=349 ,right=1151 ,bottom=394 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='��     ��' ,left=349 ,top=402 ,right=1151 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='���������' ,left=349 ,top=349 ,right=863 ,bottom=394 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1828 ,top=344 ,right=1828 ,bottom=452 </L>
	<T>id='�����׸�' ,left=1450 ,top=402 ,right=1826 ,bottom=447 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='�� �� ó' ,left=1450 ,top=349 ,right=1826 ,bottom=394 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='DATA04', left=2514, top=283, right=2823, bottom=336, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�� ǥ �� ȣ :' ,left=2302 ,top=283 ,right=2514 ,bottom=336 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATA01', left=241, top=132, right=1032, bottom=177, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA02', left=241, top=177, right=1032, bottom=230, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA03', left=241, top=230, right=1032, bottom=283, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA05', left=241, top=283, right=1032, bottom=336, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1122 ,top=21 ,right=1955 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='PTITLE', left=1124, top=24, right=1953, bottom=103, face='HY�߰��', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=130 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=344 ,top=58 ,right=2823 ,bottom=58 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<L> left=241 ,top=124 ,right=2823 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=246, top=0, right=341, bottom=122 ,mask='XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2823 ,top=0 ,right=2823 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2421 ,top=0 ,right=2421 ,bottom=124 </L>
	<L> left=344 ,top=0 ,right=344 ,bottom=124 </L>
	<C>id='FODAEAMT', left=2429, top=0, right=2815, bottom=56, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DAEAMT,0,,DAEAMT)}', left=2429, top=61, right=2815, bottom=119, align='right', face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=349, top=66, right=1151, bottom=122, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=349, top=0, right=863, bottom=56, align='left', face='����', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETITLE', left=868, top=0, right=1151, bottom=56, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1154 ,top=0 ,right=1154 ,bottom=124 </L>
	<C>id='FSRVALNM013', left=1159, top=66, right=1442, bottom=122, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM011', left=1159, top=0, right=1442, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1445 ,top=0 ,right=1445 ,bottom=124 </L>
	<C>id='FSRVALNM012', left=1450, top=0, right=1826, bottom=56, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1828 ,top=0 ,right=1828 ,bottom=124 </L>
	<C>id='{decode(CHAAMT,0,,CHAAMT)}', left=2032, top=66, right=2418, bottom=122, align='right', face='����', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FOCHAAMT', left=2032, top=0, right=2418, bottom=56, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2024 ,top=0 ,right=2024 ,bottom=124 </L>
	<C>id='', left=1834, top=66, right=2021, bottom=122, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DOCUVAL', left=1834, top=0, right=2021, bottom=56, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM014', left=1450, top=66, right=1826, bottom=122, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM015', left=1834, top=66, right=2021, bottom=122, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1500 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��    ��' ,left=1482 ,top=16 ,right=1852 ,bottom=77 ,face='����' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=241 ,top=8 ,right=241 ,bottom=82 </L>
	<L> left=2823 ,top=8 ,right=2823 ,bottom=82 </L>
	<T>id='���� :' ,left=246 ,top=16 ,right=558 ,bottom=77 ,face='����' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=241 ,top=8 ,right=2823 ,bottom=8 </L>
	<L> left=1474 ,top=8 ,right=1474 ,bottom=82 </L>
	<L> left=2347 ,top=8 ,right=2347 ,bottom=82 </L>
	<L> left=241 ,top=82 ,right=2823 ,bottom=82 </L>
	<L> left=241 ,top=87 ,right=2823 ,bottom=87 </L>
	<L> left=241 ,top=148 ,right=2823 ,bottom=148 </L>
	<L> left=241 ,top=212 ,right=1320 ,bottom=212 </L>
	<T>id='��  ��' ,left=246 ,top=153 ,right=434 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=445 ,top=153 ,right=664 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=672 ,top=153 ,right=892 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=900 ,top=153 ,right=1087 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=1098 ,top=153 ,right=1315 ,bottom=209 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1884 ,top=8 ,right=1884 ,bottom=82 </L>
	<L> left=241 ,top=400 ,right=2823 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=2447 ,top=402 ,right=2826 ,bottom=484</I>
	<L> left=241 ,top=386 ,right=2823 ,bottom=386 </L>
	<L> left=1090 ,top=151 ,right=1090 ,bottom=386 </L>
	<L> left=1320 ,top=90 ,right=1320 ,bottom=386 </L>
	<L> left=2823 ,top=90 ,right=2823 ,bottom=386 </L>
	<L> left=2580 ,top=90 ,right=2580 ,bottom=386 </L>
	<L> left=2347 ,top=90 ,right=2347 ,bottom=386 </L>
	<L> left=2111 ,top=90 ,right=2111 ,bottom=386 </L>
	<L> left=1884 ,top=90 ,right=1884 ,bottom=386 </L>
	<L> left=1677 ,top=90 ,right=1677 ,bottom=386 </L>
	<L> left=1474 ,top=90 ,right=1474 ,bottom=386 </L>
	<L> left=241 ,top=90 ,right=241 ,bottom=386 </L>
	<L> left=894 ,top=90 ,right=894 ,bottom=386 </L>
	<L> left=667 ,top=90 ,right=667 ,bottom=386 </L>
	<L> left=439 ,top=151 ,right=439 ,bottom=386 </L>
	<C>id='CURDT2', left=246, top=418, right=667, bottom=463, align='left' ,mask='�������: XXXX/XX/XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C4', left=1326, top=153, right=1471, bottom=265, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��  ��' ,left=246 ,top=98 ,right=664 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�' ,left=2604 ,top=98 ,right=2794 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=1326 ,top=98 ,right=1471 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��      ��' ,left=900 ,top=98 ,right=1315 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=672 ,top=98 ,right=892 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='C5', left=1326, top=273, right=1471, bottom=384, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C6', left=1484, top=172, right=2813, bottom=238, align='left', face='����ü', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1320 ,top=267 ,right=2582 ,bottom=267 </L>
	<C>id='C3', left=2368, top=98, right=2559, bottom=143, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C2', left=2135, top=98, right=2326, bottom=143, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C1', left=1902, top=98, right=2093, bottom=143, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��  ��' ,left=1685 ,top=98 ,right=1876 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1482 ,top=98 ,right=1672 ,bottom=143 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DAESUM', left=2368, top=16, right=2818, bottom=77, align='right', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHASUM', left=1892, top=16, right=2342, bottom=77, align='right', face='����', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
    <C>id='C7', left=1902, top=183, right=2093, bottom=228, face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
     
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
