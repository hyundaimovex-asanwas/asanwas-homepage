<%@ page language="java" contentType="text/html;charset=KSC5601" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
//get_cookdata();

var gs_date      = gcurdate.substring(0,4) + gcurdate.substring(5,7); //���
var gs_date1    = gcurdate.substring(0,4) + "01"; //����
var gs_date2    = gcurdate.substring(0,4) + gcurdate.substring(5,7)+gcurdate.substring(8,10);
var gs_userid   = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd  = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode  = gfdcode;
var gs_cocode = gcocode;
var gs_fsstat = "";
var gs_cntmsg = 0;
var gs_tolcnt = 0;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	ln_DispChk(0);
	ln_Before();

	gcem_bf_yyyymm.text=gs_date;
	gcem_af_yyyymm.text=gs_date;
}

/******************************************************************************
	Description : ��ȸ
	parameter   : p - 01:��ǥ ��ȸ1
	                  02:��ǥ ��ȸ1 Ŭ��
										03:��ǥ ��ȸ2
******************************************************************************/
function ln_Query(p){

	if (p=='01'){  //��ǥ��ȸ����
	var str11 = gcem_fsdat_fr.text+"01";         //ó���Ⱓ from
	//var str111 = shiftTime(str11,0,1,-1);
	var str12 = gcem_fsdat_to.text+"01";         //ó���Ⱓ to
	//var str121 = shiftTime(str12,0,1,-1);
    var str121 =gcem_fsdat_to.text+"31"; 
	var str13 = gclx_sign.bindcolval;		    //��������
	var str14 = gclx_fdcode.BindColVal;     //�����ڵ�
	var str15 = gclx_fsdat.BindColVal;      //��������
	
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s1"+"?v_str1="+str11+"&v_str2="+str121+"&v_str3="+str13+"&v_str4="+str14+"&v_str5="+str15;
	//prompt("01gcds_data1::",gcds_data1.DataID );
	gcds_data1.Reset();

	}else if (p=='02'){  //��ǥ�Է´���Ŭ������
        var row = gcds_data1.rowposition; 
        var str21 = gcds_data1.namevalue(row,"FDCODE"); //�����ڵ�
		var str22 = gcds_data1.namevalue(row,"FSDAT2").substring(0,9); //��ǥ����
		var str23 = gcds_data1.namevalue(row,"FSDAT2").substring(10,16); //��ǥ��ȣ
    
		if(str21==""){
			str21=gclx_fdcode02.bindcolval;
		}

		if(str22==""){
			str22=gcem_fs02.text+gcem_fsdat02.text;
		}

		if(str23==""){
			str23=gcem_fsnbr02.text;
		}

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s2"+"?v_str1="+str21+"&v_str2="+str22+"&v_str3="+str23;;
		gcds_data2.Reset();
	}else if (p=='03'){  //��ǥ�Է���ȸ����
		var str31 = gclx_fdcode02.bindcolval;
		var str32 = gcem_fs02.text + gcem_fsdat02.text;
		var str33 = gcem_fsnbr02.text;
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s2"+"?v_str1="+str31+"&v_str2="+str32+"&v_str3="+str33;
		gcds_data2.Reset();
	}
}

/*****************************************************************
	Description : ��ǥ��ȣ ã��
	parameter   :
*****************************************************************/
function ln_Find_Slipno(){
    
		var fsdat02 = gcem_fs02.text+gcem_fsdat02.text; 	
        gctr_slipno.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t4f?";
		gctr_slipno.Parameters = "v_str1="+gclx_fdcode02.BindColVal+",v_str2="+fsdat02+",v_str3="+gclx_fdcode02.BindColVal+",v_str4="+gs_userid+",v_str5="+gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10)+",v_str6=U";
		gctr_slipno.post();
		
		
		

}

/*********************************************************************
	Description : �����ڵ� ã��
	parameter   :
*********************************************************************/
function ln_Find_Divcd(){

		gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;
		gcds_divcd.Reset();

}

/********************************************************************************************
	Description : ��ǥ �űԵ��
	parameter   :
*********************************************************************************************/
function ln_Add(p){
  
	if (p=='01'){ //��ǥ��ȸ���� ���

		ln_DispChk(1);
		gcds_data1.clearall();
		ln_SetDataHeader("MASTER");
		gcds_data1.addrow();
		gcds_data2.clearall();//�׸���
		ln_SetDataHeader("DETAIL");
		gcds_data2.addrow();
		ln_Data();
		ln_Find_Slipno();//��ǥ��ȣã��
		//ln_Data1();//Master�� Detail�����ͼ� ����
		gcgd_disp02.setcolumn("ATKORNAM");
	  	gcem_wrdt02.text = gs_date2;
	
	}else if(p=='02'){//��ǥ�Է¿��� ��Ϲ�ư��
		alert("����");

		gcds_data1.clearall();
		ln_SetDataHeader("MASTER");
		gcds_data1.addrow();
		gcds_data2.clearall();//�׸���
		ln_SetDataHeader("DETAIL");
		gcds_data2.addrow();
		ln_Data();
		ln_Find_Slipno();//��ǥ��ȣã��
		//ln_Data1();//Master�� Detail�����ͼ� ����
		gcgd_disp02.setcolumn("ATKORNAM");

	}else if(p=='99'){//���߰���ư��
		//detail �����ͼ�(�����̸Ӹ�Ű)
		if (ln_Status()){//�������̳� �ϷῩ��
			gcds_data2.addrow();
			gcgd_disp02.setcolumn("ATKORNAM");
			if(gcds_data2.countrow<2){
				gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")="00001";
				gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")="001";
			}else {
				var max1=0;
				var max2="";
				for(i=1;i<=gcds_data2.countrow;i++){
					if(Number(gcds_data2.namevalue(i,"FSSEQ"))>max1)
						//max1=Number(gcds_data2.namevalue(i,"FSSEQ"));
						max1 = Number(gcds_data2.Max(4,0,0));
				}
				max1++;
				if(max1<10) max2 = "0000"+max1;
				else if(max1>=10 && max1<100) max2 = "000"+max1;
				else if(max1>=100 && max1<1000) max2 = "00"+max1;
				else if(max1>=1000 && max1<10000) max2 = "0"+max1;
				else max2 = "" +max1;
				gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")=max2;
			}

			gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE") = gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR");
			if(gcds_data2.countrow>=2) {
				gcds_data2.namevalue(gcds_data2.rowposition,"REMARK") = gcds_data2.namevalue(gcds_data2.rowposition-1,"REMARK");
			}
			gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
			gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;
      //��������
			gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")= ln_Fsnum_Find();
		}
	}
}

/******************************************************************************
	Description : ����
	parameter   :
******************************************************************************/
function ln_Save(p0){
	if(p0 == "01") {//������� �����û��
		if(gcds_data1.IsUpdated){
			if (confirm("�����Ͻðڽ��ϱ�?1")){
				gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
				
				prompt('',gcds_data1.text);
				
				gctr_data1.post();
				ln_Query("01");
			}
		}
	}else if(p0 == "02") {//��ǥ��Ͽ��� ����
		ln_Column();//Master�� Detail�����ͼ�
		if (gcds_data1.IsUpdated||gcds_data2.IsUpdated){
			if(ln_Chk()){//��ȿ�� ���̸�
				if (confirm("�����Ͻðڽ��ϱ�?0")){
				  //�����ڵ� luxe_combo�� �����ϰ� ��.
					ln_fdcode();
					gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
					//prompt('gcds_data1',gcds_data1.text);
					//prompt('gcds_data2',gcds_data2.text);
					gctr_data01.post();
					ln_Query("03");
				}
			}
		}
	}else if(p0 == "03") {//��ǥ��Ͽ��� ��������
		if(gcds_data1.IsUpdated) {
			if (confirm("�����Ͻðڽ��ϱ�?")) {
				//gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
				//gctr_data1.post();
				//gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t2";
				//gctr_data1.post();
				//ln_Query("03");
			}
		}
	}
}


/******************************************************************************
	Description : �����ڵ� ����� �����ϰ� ��.
	parameter   :
******************************************************************************/
function ln_fdcode(){
	for(i=1;i<=gcds_data2.countrow;i++){
	  if(gcds_data2.SysStatus(i)==1){ //insert
			gcds_data2.namevalue(i,"FDCODE") = gclx_fdcode02.bindcolval;
		}
	}
}

/******************************************************************************
	Description : ����
	parameter   :
******************************************************************************/
function ln_Delete(p){
	if(p=='02'){ //��ǥ����� ��ǥ������ư
		if(!ln_Status()) return;

    if (confirm("�����Ͻðڽ��ϱ�?")){	
			gcds_data2.deleteall();
			gcds_mst.clearAll();
			ln_SetDataHeader("DELETE");
      		gcds_mst.addrow();
			gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
      		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcem_fs02.text+gcem_fsdat02.text;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcem_fsnbr02.text;
			gcds_mst.UserStatus(gcds_mst.rowposition)=2;
      
			gctr_delete.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
			gctr_delete.post();
		}
	}else if(p=='dis'){  //��ǥ������ �������ư
	  if(ln_Status()){   //�������̳� �ϷῩ��
			gcds_data2.deleterow(gcds_data2.rowposition);

			//���� ������ �缳����
			ln_Fsnum_Reset(gcds_data2.rowposition,"02");
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Approval(e){
  	gcds_temp01.ClearData();
	var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ACTYYMM:STRING";
	gcds_temp01.SetDataHeader(s_temp);

	gs_cntmsg = 1;
	gs_tolcnt = 0;

	if(e=="01"){
		if(gcds_data1.countrow>0){
			if (!gcds_data1.IsUpdated) {
				alert("���õ� ������ �����ϴ�."); 
				return false;
			}
				
			var tolcnt = 0;
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")=="N"){
					tolcnt++;
				}
			}

			gs_tolcnt=tolcnt;
			
			//var g_msg = "F";
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && (gcds_data1.namevalue(i,"FSSTAT")=="N"||gcds_data1.namevalue(i,"FSSTAT")=="C")){
					g_msg="T";
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gcds_data1.namevalue(i,"FDCODE");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcds_data1.namevalue(i,"FSDAT");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcds_data1.namevalue(i,"FSNBR");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")  = gcds_data1.namevalue(i,"ACTDAT");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTYYMM") = gcds_data1.namevalue(i,"ACTDAT").substring(0,6);
							
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")==0 && gcds_data1.namevalue(i,"FSSTAT")=="N"){
					alert("�ݾ��� '0'�� ������ ������ �� �����ϴ�. ");
					gcds_temp01.rowposition = i ; 
					return false;
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")!="N"){
					//alert("�������� �Ǹ� ���簡���մϴ�.");
					///return false;
				}
			}//for

			if(confirm("���� �Ͻðڽ��ϱ�?")){
				gctr_data2.Keyvalue = "a040010_t3(I:USER=gcds_temp01)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t3";
				gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
				gctr_data2.post();
				++gs_cntmsg;
				ln_Query('01');
				gcds_temp01.ClearAll();
		  	}else{
				gcds_temp01.ClearAll();
			}
		}else alert("������ ������ �����ϴ�.");
	}else if(e=="02"){
		if(gcds_data2.countrow>1){
			gcds_temp01.ClearData();
			gs_tolcnt=1;
			gs_cntmsg=1;
			if((gclx_fsstat02.bindcolval=="N"||gclx_fsstat02.bindcolval=="C") && gcem_fsamt02.text!=0){
				if(confirm("���� �Ͻðڽ��ϱ�?")){
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gclx_fdcode02.bindcolval;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcem_fs02.text+gcem_fsdat02.text;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcem_fsnbr02.text;
					
					gctr_data2.Keyvalue = "a040010_t3(I:USER=gcds_temp01)";
					prompt("����2:gcds_temp01:",gcds_temp01.text);
					gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t3";
					gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
					gctr_data2.post();
					ln_Query('02');
					ln_Query('01');
				}
			}else if (gclx_fsstat02.bindcolval=="N" && gcem_fsamt02.text==0){
				alert("�ݾ��� '0'�� ������ ������ �� �����ϴ�. ");
				return false;
			}else if (gclx_fsstat02.bindcolval!="N" && gcem_fsamt02.text!=0){
				//alert("�������� �Ǹ� ���簡���մϴ�.");
				//return false;
			}
		}else alert("������ ������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : �������
******************************************************************************/
function ln_AppCancel(e){
  gcds_temp01.ClearAll();
	var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ACTYYMM:STRING";
	gcds_temp01.SetDataHeader(s_temp);
	if(e=="01"){
		if(gcds_data1.countrow>0){
			if (!gcds_data1.IsUpdated) {
				alert("���õ� ������ �����ϴ�."); 
				return false;
			}
			
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")=="Y"){
						gcds_temp01.AddRow();
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gcds_data1.namevalue(i,"FDCODE");
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcds_data1.namevalue(i,"FSDAT");
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcds_data1.namevalue(i,"FSNBR");
					
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSSTAT")!="Y"){
					alert("����Ϸ��� �Ǹ� ������� �����մϴ�.");
					gcds_data1.rowposition = i;
					return false;
				}
			}//for

			if(confirm("������� �Ͻðڽ��ϱ�?")){
				gctr_data2.Keyvalue = "a040010_t4(I:USER=gcds_temp01)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t4";
				gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
				gctr_data2.post();
				ln_Query('01');
				gcds_temp01.ClearAll();
			}else{
				gcds_temp01.ClearAll();
			}
		}else alert("��������� ������ �����ϴ�.");
	}else if(e=="02"){
		if(gcds_data2.countrow>1){
			gcds_temp01.ClearData();
			if(gclx_fsstat02.bindcolval=="Y"){
				if(confirm("������� �Ͻðڽ��ϱ�?")){
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gclx_fdcode02.bindcolval;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcem_fs02.text+gcem_fsdat02.text;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcem_fsnbr02.text;
					
					gctr_data2.Keyvalue = "a040010_t4(I:USER=gcds_temp01)";
					gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t4";
					gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
					//prompt("gcds_temp01::",gcds_temp01.text);
					gctr_data2.post();
					ln_Query('02');
					ln_Query('01');
					gcds_temp01.ClearAll();
				}
			}else if (gclx_fsstat02.bindcolval!="Y"){
				alert("����Ϸ��� �Ǹ� ������� �����մϴ�.");
				return false;
			}
		}else alert("��������� ������ �����ϴ�.");	
	}
}

/******************************************************************************
	Description : ��������
******************************************************************************/
function ln_HighTotal(e,e1){
	var strfdcode="";
	if(gclx_fdcode.bindcolval==""){
		strfdcode = "A"; 
	}else{
		strfdcode = gclx_fdcode.bindcolval;
	}

	if(e=="01"){
		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}
		
		if(gcem_fsdat_fr.text != gcem_fsdat_to.text){
			alert("ó���Ⱓ�� 1���������� ������ �ֽʽÿ�. \n\n��) '2006/01~2006/01'");
			return false;
		}
    	gcds_upatcode.addrow();
    	gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
    	gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t3?";
		gctr_upatcode.Parameters = "v_str1="+gcem_fsdat_fr.text+",v_str2="+strfdcode+",v_str3="+gusrid;
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
	}else if(e=="02"){
		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}
		
		if(gcem_actdat02.text == ""){
			alert("ȸ������ �Է��Ͻʽÿ�");
			return false;
		}

    //alert("gcem_actdat02::"+gcem_actdat02.text);

    	gcds_upatcode.addrow();
   	 	gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
    	gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t3?";
		gctr_upatcode.Parameters = "v_str1="+gcem_actdat02.text+",v_str2="+strfdcode+",v_str3="+gusrid;
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
	}
}

/******************************************************************************
	Description : ���
	parameter   : 
******************************************************************************/
function ln_Print(){
		
}

/******************************************************************************
	Description : ����
	parameter   : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp02.GridToExcel("�����а�","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : ����ȸ
******************************************************************************/
function ln_Before() {

	gcem_fsdat_fr.text	= gs_date;	    //��꼭�Ⱓ from(����)
	gcem_fsdat_to.text	= gs_date;			//��꼭�Ⱓ to(���)
	gclx_sign.bindcolval = ""; //��������

	gclx_fsstat02.bindcolval = ""; //��ǥ����
	txt_deptnm02.value = gs_deptnm; //���μ�
	txt_empnmk02.value = gs_usernm; //�����
	gcem_actdat02.text  = gs_date; //ȸ���

    //�����ڵ�1
	gcds_fdcode1.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_fdcode1.Reset();

	//��������
	gcds_fsdat.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=1155";
	gcds_fsdat.Reset();

    //�����ڵ�2
	gcds_fdcode2.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_fdcode2.Reset();

	//ln_Find_Divcd();//�����ڵ�
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;
	gcds_divcd.Reset();

}


/******************************************************************************
	Description : TextBox ��
	parameter   : 
******************************************************************************/
function ln_Data(){
	
	gclx_fdcode02.bindcolval = gs_fdcode;
	//if(gf_Dept_Enable(gs_deptcd)) {
	gcem_fs02.text = "A";
	//}

	gcem_fsdat02.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcem_fsnbr02.text = "000000";


}

/******************************************************************************
	Description : Master�� Detail Dataset��
	parameter   : 
******************************************************************************/
function ln_Data1(){

	//Master
	//gclx_fdcode02.bindcolval = gs_fdcode;
	gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE") = gclx_fdcode02.bindcolval;
	//if(gf_Dept_Enable(gs_deptcd)) {
		//gcem_fs02.text = "A";
	//}
	//gcem_fsdat02.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT") = gcem_fs02.text + gcem_fsdat02.text;
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
	gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR") = gcem_fsnbr02.text;
	gcds_data1.namevalue(gcds_data1.rowposition,"FSKND") = "";
	gcds_data1.namevalue(gcds_data1.rowposition,"FSWRTDAT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"COCODE") = gs_cocode;
	gcds_data1.namevalue(gcds_data1.rowposition,"DEPTCD") = gs_deptcd;
	gcds_data1.namevalue(gcds_data1.rowposition,"EMPNO") = gs_userid;
	gcds_data1.namevalue(gcds_data1.rowposition,"DIVCD") = gcds_divcd.namevalue(1,"DIVCD");
	gcds_data1.namevalue(gcds_data1.rowposition,"FSVAT") = 0;
	
	gcds_data1.namevalue(gcds_data1.rowposition,"SGNDAT") = "";
	gclx_fsstat02.bindcolval="N";
	gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT") = gclx_fsstat02.bindcolval;
	gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT") = shiftTime(gcem_actdat02.text+"01",0,1,-1);
	gcds_data1.namevalue(gcds_data1.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"WRID") = gs_userid;
	gcds_data1.namevalue(gcds_data1.rowposition,"UPDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"UPID") = gs_userid;
	
	//Detail
	gcgd_disp02.setcolumn("ATKORNAM");
	gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE") = gclx_fdcode02.bindcolval;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcem_fs02.text + gcem_fsdat02.text;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcem_fsnbr02.text;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ") = "00001";
	
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFSEQ01") = "01";
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFCD01") = "0030";
	//FSREFVAL01
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFNM01") = "�����ڵ�";
	gcds_data2.namevalue(gcds_data2.rowposition,"FSRVALNM01") = "����";
	gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;

	gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM") = "001";

}

/******************************************************************************
	Description : Detail Dataset��
	parameter   : 
******************************************************************************/
function ln_Data2(){

}

/******************************************************************************
	Description : üũ
	parameter   : p1-����
******************************************************************************/
function ln_Chk(){

	var de = 0, cr = 0;
	var row = gcds_data2.countrow;

	if(ln_Trim(gcem_fs02.text)=="") {
		alert("��ǥ��ȣ�� �Է��Ͻʽÿ�.");
		return false;
	}
	if(ln_Trim(gcem_fsdat02.text)=="") {
		alert("��ǥ��ȣ�� �Է��Ͻʽÿ�.");
		return false;
	}
	if(ln_Trim(gcem_fsnbr02.text)=="") {
		alert("��ǥ��ȣ�� �Է��Ͻʽÿ�.");
		return false;
	}

	for(i=1;i<=row;i++) {
		de+=gcds_data2.namevalue(i,"CHAAMT");
		cr+=gcds_data2.namevalue(i,"DAEAMT");
	}
	if(de!=cr){
		alert("�����հ�� �뺯�հ谡 ���� �ʽ��ϴ�.");
		return false;
	}

	return true;

}

/******************************************************************************
	Description : �������̳� �ϷῩ��
	prameter    :  
******************************************************************************/
function ln_Status(){

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("����Ϸ�?�ų� �������� ��ǥ�Դϴ�."); 
		return false;
	}
		return true;
}

/******************************************************************************
	Description : ����, �뺯�� ���並 Master��
	parameter   :
******************************************************************************/
function ln_Column(){

	var sum = 0;
	var detot = 0;
	var crtot = 0;

	for(i=1;i<=gcds_data2.countrow;i++) {
		sum+=gcds_data2.namevalue(i,"CHAAMT");
		detot+=gcds_data2.namevalue(i,"CHAAMT");
		crtot+=gcds_data2.namevalue(i,"DAEAMT");
		if(gcds_data2.namevalue(i,"CHAAMT") != 0 && gcds_data2.namevalue(i,"DAEAMT") == 0) {
			gcds_data2.namevalue(i,"ATDECR") = "1";
			gcds_data2.namevalue(i,"FSAMT") = gcds_data2.namevalue(i,"CHAAMT");
		}
		else if(gcds_data2.namevalue(i,"CHAAMT") == 0 && gcds_data2.namevalue(i,"DAEAMT") != 0) {
			gcds_data2.namevalue(i,"ATDECR") = "2";
			gcds_data2.namevalue(i,"FSAMT") = gcds_data2.namevalue(i,"DAEAMT");
		}	
	}
	gcem_fsamt02.text = sum;
	gcds_data1.namevalue(gcds_data1.rowposition,"FSAMT") = gcem_fsamt02.text;
	gcds_data1.namevalue(gcds_data1.rowposition,"DETOT") = detot;
	gcds_data1.namevalue(gcds_data1.rowposition,"CRTOT") = crtot;
	gcem_remark02.text = gcds_data2.namevalue(1,"REMARK");
	gcds_data1.namevalue(gcds_data1.rowposition,"REMARK") = gcem_remark02.text;

	gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT") = gcem_actdat02.text+"30";
}

/******************************************************************************
	Description : ������
	parameter   :
******************************************************************************/
function ln_Confirm_Ready(){

	for(i=1;i<=gcds_data1.countrow;i++) {
		if(gcds_data1.namevalue(i,"SELECT2")=="T"&&gcds_data1.namevalue(i,"FSSTAT")=="R")
			gcds_data1.namevalue(i,"FSSTAT")="N";
	}
	ln_Save("01");//��������

}

/******************************************************************************
	Description : �����û
	parameter   :
******************************************************************************/
function ln_Confirm_Request(){

	for(i=1;i<=gcds_data1.countrow;i++) {
		if(gcds_data1.namevalue(i,"SELECT2")=="T"&&gcds_data1.namevalue(i,"FSSTAT")=="N")
			gcds_data1.namevalue(i,"FSSTAT")="R";
	}
	ln_Save("01");//��������

}

/******************************************************************************
	Description : �����û
	parameter   :
******************************************************************************/
/**
function ln_Confirm_Request1(){

	if (confirm("���� �Ͻðڽ��ϱ�?")) {
		if(gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT")=="N") {
			gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT")="R";
			ln_Save("03");//��������
		}
	}

}
********/



/******************************************************************************
	Description : ����� ����
	parameter   :  p - ������ ���
******************************************************************************/
function ln_Confirm_Save(p){
		var row1 = gcds_data01.rowposition;
		var row2 = gcds_data01_2.rowposition;
		var strfdcode="";
		var strfsdat="";
		var strfsnbr="";
		var strempno="";
		var strtogb="03" //�����ϰ��� 02 �� �����ؾ���.

		if((gcds_data01_2.namevalue(row2,"FDCODE"))==""||(gcds_data01_2.namevalue(row2,"FDCODE"))==undefined){
			strfdcode = gcds_data01.namevalue(row1,"FDCODE");
		}else{
			strfdcode = gcds_data01_2.namevalue(row2,"FDCODE");
		}

		if(gcds_data01_2.namevalue(row2,"FSDAT")==""||gcds_data01_2.namevalue(row2,"FSDAT")==undefined){
			strfsdat = gcds_data01.namevalue(row1,"FSDAT");
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
			strempno = gcds_data01_2.namevalue(row2,"FSNBR");
		}

		gcds_confirm.clearall();
		ln_SetDataHeader("CONFIRM");
    	gcds_confirm.addrow();
    	gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=strfdcode; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=strfsdat;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=strfsnbr;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //������
		gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= strempno;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="04"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =strtogb; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

		if (confirm("�����Ͻðڽ��ϱ�?")){	
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6";
			gctr_data06.post();
    }
}

/******************************************************************************
	Description : �Ϲ����� �˾� �׽�Ʈ
	parameter   : 
******************************************************************************/
function ln_Popup_Proof(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="01";
	arrParam[1]="A20060324";
	arrParam[2]="900001";
	arrParam[3]="005";

	strURL = "./com_proof.jsp";
	strPos = "dialogWidth:615px;dialogHeight:375px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
	}
	else {
		alert("�˻������ �����ϴ�.");
	}
}

/******************************************************************************
	Description : �����а� �˾� �׽�Ʈ
	parameter   : 
******************************************************************************/
function ln_A040010_Popup(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="01";
	arrParam[1]="A20060324";
	arrParam[2]="900001";

	strURL = "./a040010_popup.jsp";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

}

/******************************************************************************
	Description : ������ Data�� ���� DataSetHead ����
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p1){

	if(p1=="MASTER"){ //Master
		var s_fslipmst = "FDCODE:STRING,FS1:STRING,FSDAT:STRING,FSDAT1:STRING,FSNBR:STRING,FSDAT2:STRING,FSKND:STRING,FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSVAT:DECIMAL,FSAMT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_data1.SetDataHeader(s_fslipmst);
	}else if(p1=="DETAIL"){ //Detail
		var s_fslipdtl1 = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,FSAMT:DECIMAL,REMARK:STRING,FSREFSEQ01:STRING,FSREFCD01:STRING,FSREFVAL01:STRING,FSREFVAL:STRING,FSREFNM01:STRING,FSRVALNM01:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,FSNUM:STRING";
		gcds_data2.SetDataHeader(s_fslipdtl1);
	}	else if(p1=="DELETE"){ //Master
		var s_fslipmst = "FDCODE:STRING,FS1:STRING,FSDAT:STRING,FSDAT1:STRING,FSNBR:STRING,FSDAT2:STRING,FSKND:STRING,FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSVAT:DECIMAL,FSAMT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING";
		gcds_mst.SetDataHeader(s_fslipmst);
	}


}

/******************************************************************************
	Description : �޷�
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

	if(gclx_fsstat02.bindcolval=="Y"||gclx_fsstat02.bindcolval=="R"||gclx_fsstat02.bindcolval=="C"){
		alert("����Ϸ�?�ų� �������� ��ǥ�Դϴ�.");
	}else{
		__GetCallCalendar('gcem_actdat02', 'Text');
	}

}

/******************************************************************************
	Description : �հ��ܾ� Sum ���
******************************************************************************/
function ln_Sum(){

}

/******************************************************************************
	Description : �ݱ�
	parameter   : 
******************************************************************************/
function ln_Close(p){
	
	ln_DispChk(0);

}

/******************************************************************************
	Description : ��ǥ��ȸ/��ǥ�Է�
	prameter    : 0-��ǥ��ȸ, 1-��ǥ�Է�
******************************************************************************/
function ln_DispChk(index){

  var div_cm = new Array("div_disp1","div_disp2");

	for(var i=0;i<=1;i++)	{
		if(i==index) eval("document.all."+div_cm[i]+".style.display='block';");
		else eval("document.all."+div_cm[i]+".style.display='none';");
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
	Description : ��������
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 

} 


/******************************************************************************
	Description : ���� ����Ÿ �ϰ� ����
******************************************************************************/
function ln_Batch_Copy(){
  
	if(gclx_fdcode.bindcolval==""){
		alert("������ �����Ͻʽÿ�.");
		return;
	}

	gcds_batch_copy.ClearData();
	var s_temp = "FDCODE:STRING,BFYYYYMM:STRING,AFYYYYMM:STRING,WRDT:STRING,WRID:STRING";
	gcds_batch_copy.SetDataHeader(s_temp);

	if(confirm("���� ����Ÿ�� �ϰ� ���� �Ͻðڽ��ϱ�?")){
	  	gcds_batch_copy.addrow();
    	gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"FDCODE")= gclx_fdcode.bindcolval; 
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"BFYYYYMM")=gcem_bf_yyyymm.text;  //�����
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"AFYYYYMM")=gcem_af_yyyymm.text;  //������
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"WRDT")=gs_date2;                 //��������
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"WRID")=gs_userid;                //�����
	 
		gctr_batch_copy.Keyvalue = "a040010_t5(I:USER=gcds_batch_copy)";
		gctr_batch_copy.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t5";
		//prompt(this,gcds_batch_copy.text );
		gctr_batch_copy.post();
	}
}

/******************************************************************************
	Description : �����
	parameter   : 
******************************************************************************/
function ln_Insert(){
  	var insertrow=0;
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;

	if(!ln_Status())return;
	
	insertrow = gcds_data2.rowposition + 1 ; 

	if(gcds_data2.rowposition>0){
		gcds_data2.Insertrow(insertrow);
		//��������
		gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")= ln_Fsnum_Find();
		//���� ������ �缳����
    
		alert("gcds_data2.rowposition::"+gcds_data2.rowposition);
		ln_Fsnum_Reset(gcds_data2.rowposition,"01");
	}
	ln_Data_Fdcode_Fsdat_Fsnbr();
}


/******************************************************************************
	Description : ��ǥ��� - ���� ã��
	parameter   : 
******************************************************************************/
function ln_Fsnum_Find(){
  	var ifsnum=0;
	_out:
	for(k=1;k<=gcds_data2.countrow;k++){
		if(gcds_data2.namevalue(k,"FSNUM")==""){
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
	//alert("ipo::"+ipo);
	for(k=ipo;k<=gcds_data2.countrow;k++){
		gcds_data2.namevalue(k,"FSNUM") = ln_Seqno_Format(Number(k),3);
	}
}


/************************************************************************************************************
	Description : Ű�� �ڵ� ����
	parameter   :    
*************************************************************************************************************/
function ln_Data_Fdcode_Fsdat_Fsnbr(){
  	var intseq =0;
  
	intseq = Number(gcds_data2.Max(4,0,0))+1;

	//alert(" hid_fsseq.value:1:"+ hid_fsseq.value);
	gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")= ln_Seqno_Format(intseq,5);

	gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE")= gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
	gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT");
	gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR");
	if(gcds_data2.countrow>=2) {
		gcds_data2.namevalue(gcds_data2.rowposition,"REMARK") = gcds_data2.namevalue(gcds_data2.rowposition-1,"REMARK");
	}
	gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- �׸���1 -->
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �׸���2 -->
<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- ��ǥ Master ��ȸ -->
<comment id="__NSID__"><object  id=gcds_data01_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �����ڵ�1 -->
<comment id="__NSID__"><object  id="gcds_fdcode1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �����ڵ�2 -->
<comment id="__NSID__"><object  id="gcds_fdcode2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �������� -->
<comment id="__NSID__"><object  id="gcds_fsdat" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- ��ǥ��ȣ -->
<comment id="__NSID__"><object  id="gcds_slipno" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �����ڵ� -->
<comment id="__NSID__"><object  id="gcds_divcd" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- ���� -->
<comment id="__NSID__"><object  id="gcds_confirm" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcds_temp01" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_upatcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- �����ܾװ��� ���ν��� -->
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_batch_copy classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- �����ܾװ��� ���ν��� -->
</object></comment><script>__ws__(__NSID__);</script> 



<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- ������ǥ ������ ��ǥ mst-->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ��ȣ ���� -->
<comment id="__NSID__"><object  id=gctr_slipno classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t4f(O:USER=gcds_slipno)">   
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"          value="a040010_t1(I:USER=gcds_data1)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �Է�/���� -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t1(I:USER=gcds_data1,I:USER2=gcds_data2)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!-- �Է�/���� -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- �����ܾװ��� ���ν��� -->
<comment id="__NSID__"><object  id=gctr_upatcode classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"          value="comm_upatcode_t1(I:USER=gcds_upatcode)">   
</object></comment><script>__ws__(__NSID__);</script> 


<!-- �������� -->
<comment id="__NSID__"><object  id=gctr_batch_copy classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t5(I:USER=gcds_batch_copy)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ���� -->
<comment id="__NSID__"><object  id=gctr_delete classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t1(I:USER=gcds_mst,I:USER2=gcds_data2)">   
</object></comment><script>__ws__(__NSID__);</script> 



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
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script><!-- �׸��� 1 -->

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt2.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		gclx_fsstat02.bindcolval = gs_fsstat;
		alert("�˻��� �����Ͱ� �����ϴ�.");
	}
</script><!-- �׸��� 2 -->

<script language="javascript" for="gcds_fdcode1" event="onloadCompleted(row,colid)">
	gcds_fdcode1.InsertRow(1);
	gcds_fdcode1.NameValue(1,"FDCODE")="";
	gcds_fdcode1.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script><!-- �����ڵ�1 -->

<script language="javascript" for="gcds_fdcode2" event="onloadCompleted(row,colid)">
	gcds_fdcode2.InsertRow(1);
	gcds_fdcode2.NameValue(1,"FDCODE")="";
	gcds_fdcode2.NameValue(1,"FDNAME")="��ü";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode02.index=2;
	}else{
		gclx_fdcode02.bindcolval=gs_fdcode;
	}
</script><!-- �����ڵ�2 -->

<script language="javascript" for="gcds_fsdat" event="onloadCompleted(row,colid)">
	gcds_fsdat.insertrow(1);
	gcds_fsdat.namevalue(1,"CDCODE") = "";
	gcds_fsdat.namevalue(1,"CDNAM") = "��ü";
	gclx_fsdat.index = 0;
</script><!-- �������� -->

<script language="javascript" for="gcds_divcd" event="onloadCompleted(row,colid)">
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	if(row<1) {
		if(colid=="SELECT2") {
			for(i=1;i<=gcds_data1.countrow;i++) {
				gcds_data1.namevalue(i,"SELECT2") = "T";
			}
		}
		else
			return;
	}
	else {
		ln_DispChk(1);
		gs_fsstat=gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT");
		gcem_actdat02.text = gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT");
		gcem_wrdt02.text = gcds_data1.namevalue(gcds_data1.rowposition,"UPDT");

		ln_Query('02');
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=Onclick(row,colid)>
	if(row<1) return;
	if(gcds_data1.namevalue(row,"SELECT2") == "T"&&colid=="SELECT2")
		gcds_data1.namevalue(row,"SELECT2") = "F";
	else if(gcds_data1.namevalue(row,"SELECT2") == "F"&&colid=="SELECT2")
		gcds_data1.namevalue(row,"SELECT2") = "T";
</script>

<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	var arrParam1	= new Array();
	var arrParam2 = new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam1[0]="";
	arrParam1[1]="";
	arrParam2[0]="0030";
	arrParam2[1]="";

	if(colid == "ATKORNAM") {
		strURL = "./actcode_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam1,strPos);
    
		if (arrResult != null) {
			arrParam1 = arrResult.split(";");
			gcds_data2.namevalue(gcds_data2.rowposition,"ATCODE") = arrParam1[0];
			gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM") = arrParam1[1];
		} else {
		}
	}else if(colid == "FSREFVAL") {
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam2,strPos);
    
		if (arrResult != null) {
			arrParam2 = arrResult.split(";");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL01") = arrParam2[0];
			gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL") = arrParam2[1];
		} else {
		}
	}
			
</script>

<script language="javascript"  for=gcgd_disp02 event=OnExit(row,colid,olddata)>
	
	if(gcds_data2.namevalue(row,"CHAAMT") != 0 && gcds_data2.namevalue(row,"DAEAMT") != 0)
		alert("������ �뺯 �ݾ��� Ȯ���Ͻʽÿ�.");
	ln_Column();

</script>

<script language=JavaScript for=gclx_sign event=onSelChange()>
	//alert("");
</script>

<script language=JavaScript for=gcgd_disp02 event=onkeypress(key)>

	var arrParam1	= new Array();
	var arrParam2 = new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam1[0]="";
	arrParam1[1]="";
	arrParam2[0]="0030";
	arrParam2[1]="";

	if(key!=113) return;

	if(gcds_data2.countrow >= 1) {
		if(gcgd_disp02.getcolumn() == "ATKORNAM") {
			gcgd_disp02.setcolumn("FSREFVAL");
			gcgd_disp02.setcolumn("ATKORNAM");
			strURL = "./actcode_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrParam1[0] = gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM");
			arrResult = showModalDialog(strURL,arrParam1,strPos);
			if (arrResult != null) {
				arrParam1 = arrResult.split(";");
				gcds_data2.namevalue(gcds_data2.rowposition,"ATCODE") = arrParam1[0];
				gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM") = arrParam1[1];
			} else {
			}
			gcgd_disp02.setcolumn("FSREFVAL");
			gcgd_disp02.setcolumn("ATKORNAM");
		}else if(gcgd_disp02.getcolumn() == "FSREFVAL") {
			gcgd_disp02.setcolumn("ATKORNAM");
			gcgd_disp02.setcolumn("FSREFVAL");
			strURL = "./commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrParam2[1] = gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL");
			arrResult = showModalDialog(strURL,arrParam2,strPos);
			if (arrResult != null) {
				arrParam2 = arrResult.split(";");
				gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL01") = arrParam2[0];
				gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL") = arrParam2[1];
			} else {
			}
			gcgd_disp02.setcolumn("ATKORNAM");
			gcgd_disp02.setcolumn("FSREFVAL");
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_slipno event=OnSuccess()>
		ln_Data1();
</script>

<script language="javascript" for="gctr_slipno" event="onfail()">
    alert("Error Code : " + gctr_slipno.ErrorCode + "\n" + "Error Message : " + gctr_slipno.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script><!-- �Է�/���� -->


<script language="javascript" for="gctr_data01" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script><!-- �Է�/���� -->

<script language="javascript" for="gctr_data01" event="onfail()">
    alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script><!-- �Է�/���� -->

<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script><!-- ���� -->

<script language="javascript" for="gctr_data06" event="onfail()">
    alert("Error Code : " + gctr_data06.ErrorCode + "\n" + "Error Message : " + gctr_data06.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script><!-- ���� -->

<script language="javascript" for="gctr_data2" event="onsuccess()">
    alter("gs_tolcnt"+gs_tolcnt+"gs_cntmsg"+gs_cntmsg);

	if(gs_tolcnt==gs_cntmsg) alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_data2" event="onfail()">
    alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_upatcode" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_upatcode" event="onfail()">
	alert("Error Code : " + gctr_upatcode.ErrorCode + "\n" + "Error Message : " + gctr_upatcode.ErrorMsg + "\n");
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
</script>

<script language="javascript" for="gctr_batch_copy" event="onfail()">
	alert("Error Code : " + gctr_batch_copy.ErrorCode + "\n" + "Error Message : " + gctr_batch_copy.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_delete" event="onsuccess()">
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
</script>

<script language="javascript" for="gctr_delete" event="onfail()">
	alert("Error Code : " + gctr_delete.ErrorCode + "\n" + "Error Message : " + gctr_delete.ErrorMsg + "\n");
</script>



</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>



<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a040010_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
						<img src="../../Common/img/btn/com_b_sanctionsby.gif"	    style="cursor:hand" onClick="ln_Confirm_Ready('01')" >
						<img src="../../Common/img/btn/com_b_hitotal.gif"			style="cursor:hand" onclick="ln_HighTotal('01')">
						<img src="../../Common/img/btn/com_b_result.gif"			style="cursor:hand" onclick="ln_Approval('01')">
						<img src="../../Common/img/btn/com_b_sanctioncal.gif"	    style="cursor:hand" onclick="ln_AppCancel('01')">
						<img src="../../Common/img/btn/com_b_insert.gif"			style="cursor:hand" onClick="ln_Add('01')" >
						<img src="../../Common/img/btn/com_b_query.gif"				style="cursor:hand" onclick="ln_Query('01')">
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>ó���Ⱓ</nobr></td>
								<td class="tab18" align=center><nobr>
									<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										~&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

               					<td style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>��������</nobr></td>
								<td class="tab18" align=center><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gclx_sign classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:0px;font-size:12px;width:80px;">
											<param name=CBData         value="^��ü,N^������,R^�����û,Y^����Ϸ�,B^�ݼ�,C^�������">
											<param name=CBDataColumns	 value="FSCODE,FSSTAT">
											<param name=SearchColumn	 value=FSSTAT>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FSSTAT">								
											<param name=BindColumn		 value="FSCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td> 

								<td style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>�����ڵ�</nobr></td>
								<td class="tab18" align=center><nobr>
									<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:0px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_fdcode1">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

								<td style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>��������</nobr></td>
								<td class="tab18" width="320" align=left><nobr>
									<comment id="__NSID__"><object  id=gclx_fsdat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:0px;font-size:12px;width:80px;">
											<param name=ComboDataID  value="gcds_fsdat">
											<param name=CBDataColumns	 value="CDCODE,CDNAM">
											<param name=SearchColumn	 value="CDNAM">
											<param name=Sort			     value="false">
											<param name=ListExprFormat value="CDNAM">								
											<param name=BindColumn		 value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
							</tr>
					 </table>

					</td>
				</tr> 
				<tr>
					<td width="876px"  class="tab15" align="right" >
					<nobr>				
						<font style="position:relative;top:-4px;left:0px">[����Ÿ �ϰ� ����]>>>>[������]</font>&nbsp;
						<comment id="__NSID__">&nbsp;
								<object  id=gcem_bf_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="####/##">
													<param name=Format        value="YYYY/MM">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> 
						<font style="position:relative;top:-4px;left:0px">==>[�����]</font>
							
							<comment id="__NSID__">&nbsp;
								<object  id=gcem_af_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="####/##">
													<param name=Format        value="YYYY/MM">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> &nbsp;
							<img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;left:0px" onClick="ln_Batch_Copy()">
						</nobr>
					</td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:420px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data1">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value="1">
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="false">
								<PARAM NAME="Format"			VALUE="
								<C> Name='����'		ID=SELECT2	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=50	  align=center  EditStyle=CheckBox</C> 
								<C> Name='��������'		ID=FDCODE 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center	 sort=true  EditStyle=Lookup Data='gcds_fdcode1:FDCODE:FDNAME'</C> 
								<C> Name='��������'		ID=FS1 	     HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center	 sort=true  EditStyle=Lookup Data='gcds_fsdat:CDCODE:CDNAM'</C> 
								<C> Name='��ǥ��ȣ'		ID=FSDAT2 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=110	  align=center sort=true </C> 
								<C> Name='����'			  ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=350	  align=left	 sort=true  SumText='��   ��'</C> 
								<C> Name='�ݾ�'		  	ID=FSAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=110	  align=right  sort=true  SumText=@sum</C> 
								<C> Name='���翩��'		ID=FSSTAT 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=77	  align=center	 sort=true  EditStyle=Combo Data='N:������,R:�����û,Y:����Ϸ�,B:�ݼ�,C:�������' </C> 
								">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>		

<!--------- ��ǥ�Է� ----------->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a040010_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="../../Common/img/btn/com_b_exit.gif"  style="cursor:hand" onclick="ln_Close('02')">
						<img src="../../Common/img/btn/com_b_hitotal.gif"  style="cursor:hand" onclick="ln_HighTotal('02')">
						<!-- <img src="../../common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('02')"> --><!-- ��� -->
					 	<!--img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()"--><!--��û-->
					 	<img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Approval('02')"><!--����-->
						<img src="../../Common/img/btn/com_b_sanctioncal.gif"	style="cursor:hand" onclick="ln_AppCancel('02')">
						<img src="../../Common/img/btn/com_btn_slipdel.gif"	style="cursor:hand" onClick="ln_Delete('02')" ><!--��ǥ����-->
						<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand" onclick="ln_Add('02')"><!--���-->
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('02')"><!--����-->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onClick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03');"><!--��ȸ-->
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;��ǥ��ȣ</nobr></td>
								<td class="tab18" style="width:160px;"><nobr>&nbsp;
                  					<comment id="__NSID__"><object  id=gcem_fs02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:17px;height:20px;position:relative;left:-3px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_fsdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:-3px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:46px;height:20px;position:relative;left:-3px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
                				<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;��ǥ����&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;	
									<comment id="__NSID__"><object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:80px;">
											<param name=CBData         value="^��ü,N^������,R^�����û,Y^����Ϸ�,B^�ݼ�,C^�������">
											<param name=CBDataColumns	 value="FSCODE,FSSTAT">
											<param name=SearchColumn	 value=FSSTAT>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FSSTAT">								
											<param name=BindColumn		 value="FSCODE">
											<param name=enable         value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr> 
								</td>
                
                				<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;���μ�&nbsp;</nobr></td>
								<td class="tab18" style="width:120px;"><nobr>&nbsp;	
									<input id="txt_deptcd02" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true"> 
									<input id="txt_deptnm02" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7"  readOnly="true"></nobr>	
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;�����&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;
								 <input id="txt_empno02" type="hidden" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true">
								 <input id="txt_empnmk02" type="text" class="txtbox"   style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7" readOnly="true">
									</nobr>
								</td>
							</tr>
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;����</nobr></td>
								<td class="tab19" style="width:160px;" ><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:145px;">
											<param name=ComboDataID    value="gcds_fdcode2">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value="FDNAME">
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME^0^150">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>
								
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;ȸ���&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;left:-3px;top:2px;width:55px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM">
											<param name=PromptChar	  value="_">
											</object></comment><script>__ws__(__NSID__);</script> 
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat02', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_A040010_Popup()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											</nobr>
								</td>
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ݾ�&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;" ><nobr>&nbsp;	
									<comment id="__NSID__"><object  id=gcem_fsamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-4px;top:3px">				
											<param name=Text					value="0">
											<param name=Border        value=true>
									    	<param name=Alignment     value=2>
						                    <param name=Numeric       value="true">
						                    <param name=IsComma       value=true>
											<param name=MaxLength     value=12>
											<param name=BackColor     value="#CCCCCC">
                      						<param name=ReadOnlyBackColor   value="#D7D7D7">
											<param name=InheritColor  value=false>
											<param name=ReadOnly      value=true>
									</object></comment><script>__ws__(__NSID__);</script> 
									<input id="txt_atkornam" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"> 
									</nobr>	
								</td>

								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;�ۼ�����&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_wrdt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;left:-3px;top:2px;width:75px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
											<param name=ReadOnly      value=true>
											</object></comment><script>__ws__(__NSID__);</script> 
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat02', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"> -->
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_A040010_Popup()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											</nobr>
								</td>
							</tr>
              
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;����</nobr></td>
								<td colspan=7 class="tab19" style="width:795px;" ><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_remark02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:788px;height:20px;position:relative;left:-3px;top:3px">				
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=ReadOnlyBackColor   value="#D7D7D7">
										<param name=InheritColor  value=false>
										<param name=ReadOnly      value=true>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
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
             				<tr>			
							  <td colspan=5 color="#0000FF"></td>
								<td width="240px" align=right colspan=2 >
								  <img src="../../Common/img/btn/com_b_rowdel.gif"	       style="cursor:hand;position:relative;left:125px" onClick="ln_Delete('dis')">
									<img src="../../Common/img/btn/com_b_rowadd.gif"         style="cursor:hand;position:relative;left:125px" onclick="ln_Add('99')">
									<img src="../../Common/img/btn/com_btn_insert_add.gif"   style="cursor:hand;position:relative;left:125px" onclick="ln_Insert()">
								</td>
							</tr>
							<tr>
								<td width=77px></td>	
								<td width=165px></td>	
								<td width=89px></td>	
								<td width=89px></td>	
								<td width=98px></td>	
								<td width=275px></td>	
								<td width=100px></td>
							</tr>	
							
				 			<tr>
								<td colspan=7>
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:0px">
								<tr>
								<td style="width:280" ALIGN=LEFT VALIGN=TOP>
								<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
							  style="position:relative;left:0px;width:875px; height:355px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data2">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value="1">
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="true">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='����'		    ID=FSNUM  	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=40	  align=center	 </C> 
								<C> Name='�����ڵ�'		ID=ATCODE 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center sort=true</C> 
								<C> Name='������'		    ID=ATKORNAM  HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=160  align=left	 sort=true EditStyle=Popup sumtext='�� ��'</C> 
								<C> Name='�����ݾ�'		ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=100	align=right	 sort=true color=blue SumText=@sum sumcolor=blue</C> 
								<C> Name='�뺯�ݾ�'		ID=DAEAMT	   HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=100	align=right  sort=true color=red  SumText=@sum sumcolor=red</C> 
								<C> Name='����'			ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=175	align=left	 sort=true</C> 
								<C> Name='�����ڵ�'	    ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=200	align=left	 sort=true EditStyle=Popup</C> 
								">
								</object></comment><script>__ws__(__NSID__);</script> 
								<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;">��ȸ�Ǽ� :</font>
								</fieldset>
								</td>
								</tr>
								</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    </td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!-- ��ǥ��� MASTER-->
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='
		<C>Col=FDCODE              Ctrl=gclx_fdcode02            Param=bindcolval</C>
		<C>Col=FS1                 Ctrl=gcem_fs02                Param=text</C>
		<C>Col=FSDAT1              Ctrl=gcem_fsdat02             Param=text</C>
		<C>Col=FSNBR               Ctrl=gcem_fsnbr02             Param=text</C>
		<C>Col=REMARK              Ctrl=gcem_remark02            Param=text</C>
		<C>Col=FSAMT               Ctrl=gcem_fsamt02             Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- ��ǥ��� MASTER ��ȸ-->
<comment id="__NSID__"><object  id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value='  
		<C>Col=FSSTAT              Ctrl=gclx_fsstat02            Param=bindcolval</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--	L O A D I N G  B A R   D E F I N I T I O N -->


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
