<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �ڻ꺯��		
+ ���α׷� ID	:  A090003.html
+ �� �� �� ��	:  �ڻ꺯���� �ϴ� ȭ���̴�
+ ��   ��  �� :  �̹���
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� �� :  �ڻ꺯�� ȭ�� ��ü���� ����
+ ��   ��  �� :  ������  
+ �� �� �� �� :  2009.10.16
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090003_s1, A090003_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>�ڻ꺯��</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
get_cookdata();
var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);

var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��


	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//�ڻ��ߺз�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";  
	gcds_asdivcod.Reset();

	div2.style.display = "";

	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_sys_fr.bindcolval ="";

	gcrd_gubun.codevalue ="1";

 }

/******************************************************************************
	Description : ��ȸ
	              gcrd_gubun ���а����� ���� �� �������� ���, �Ű�, �ں���������� ��ȸ����
******************************************************************************/
function ln_Query(){
	
	var str1 = gclx_fdcode.BindColVal;            //����
	var str2 = txt_COSTCD.value;									//�����ڵ�
	var str3 = txt_jasan.value;										//�ڻ��
	var str4 = gcem_jasan.text;										//�ڻ��ڵ�
	var str5 = gclx_asdivcod.BindColVal;					//�ڻ��ߺз�
	var str6 = gclx_ascosdiv2_2.BindColVal;				//�ڻ�Һз�
	var str7 = gclx_sys_fr.BindColVal;						//���±���

  if(gcrd_gubun.codevalue=="1"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s1_1?v_str1="+str1+"&v_str2="+str2
																														 + "&v_str3="+str3+"&v_str4="+str4
																														 + "&v_str5="+str5+"&v_str6="+str6
																														 + "&v_str7="+str7;
		//prompt("",gcds_code01.DataID )
		gcds_code01.Reset(); 
	}else if(gcrd_gubun.codevalue=="2"){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s1_2?v_str1="+str1+"&v_str2="+str2
																														 + "&v_str3="+str3+"&v_str4="+str4
																														 + "&v_str5="+str5+"&v_str6="+str6
																														 + "&v_str7="+str7;
		//prompt("",gcds_code01.DataID )
		gcds_code01.Reset(); 
	}

  gcds_code02.ClearAll();


}

/******************************************************************************
	Description : �ڻ꺯�� �� ��ȸ
******************************************************************************/
function ln_Query2(row){

	var str1 = gcds_code01.namevalue(row,"FDCODE"); //����
	var str2 = gcds_code01.namevalue(row,"ATCODE");	//����
	var str3 = gcds_code01.namevalue(row,"AST1ST");	//��1����
	var str4 = gcds_code01.namevalue(row,"AST2ND");	//��2����
	var str5 = gcds_code01.namevalue(row,"AST3RD");	//��3����
	var str6 = gcds_code01.namevalue(row,"ASTSEQ");	//�Ϸù�ȣ

	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_s2?v_str1="+str1+"&v_str2="+str2
									                                       + "&v_str3="+str3+"&v_str4="+str4
									                                       + "&v_str5="+str5+"&v_str6="+str6;
	//prompt("",gcds_code02.DataID )
	gcds_code02.Reset(); 
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

  if(gcds_code01.rowposition<1) {
		alert("������ �ڻ��� ������ �ֽʽÿ�.");
		return false;
	}

	//�ڻ���°� �Ű� �Ǵ� ���� ���� ���̻� ��� ���ϰ� ��.
	for(i=1;i<=gcds_code02.rowposition;i++){
		if(gcds_code02.namevalue(i,"CHGTYPE")=="1"){
			alert("�Ű� ���� �� �̻� �ڻ� ������ �� �����ϴ�.");
			return false;
		}

		if(gcds_code02.namevalue(i,"CHGTYPE")=="2"){
			alert("������ �� �̻� �ڻ� ������ �� �����ϴ�.");
			return false;
		}
	}

	gcds_code02.addrow();
  ln_Lx_Enable(gcds_code02.rowposition);
  gcds_code02.namevalue(gcds_code02.rowposition,"FDCODE")=gcds_code01.namevalue(gcds_code01.rowposition,"FDCODE");
	gcds_code02.namevalue(gcds_code02.rowposition,"ATCODE")=gcds_code01.namevalue(gcds_code01.rowposition,"ATCODE");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST1ST")=gcds_code01.namevalue(gcds_code01.rowposition,"AST1ST");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST2ND")=gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND");
	gcds_code02.namevalue(gcds_code02.rowposition,"AST3RD")=gcds_code01.namevalue(gcds_code01.rowposition,"AST3RD");
	gcds_code02.namevalue(gcds_code02.rowposition,"ASTSEQ")=gcds_code01.namevalue(gcds_code01.rowposition,"ASTSEQ");

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

	if(!ln_Chk()) return;

	if (gcds_code02.IsUpdated ){
		if (confirm("�����Ͻðڽ��ϱ� ?")) {
		  
			if(gclx_chgtype.bindcolval=="3"){ // �ں�������
				gcds_code02.namevalue(gcds_code02.rowposition,"CHGAMT2")=gcem_chgamt2_3.text;  
			}
     
			gctr_code01.KeyValue = "Account.a090023_t3(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_t3";
      		gctr_code01.Parameters="v_str1="+gs_date+",v_str2="+gs_userid;		
 		  //prompt('',gcds_code02.text);
			gctr_code01.post();
		}
	}
}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

	if (gcds_code01.RowStatus(gcds_code01.rowposition) == "1" ){
		gcds_code01.Undo(gcds_code01.RowPosition);
	}else{
		if(gcds_code02.rowposition!=gcds_code02.countrow){
			alert("�����Ǹ� ���� �����մϴ�.");
			return false;
		}

		if(gclx_chgtype.bindcolval==1){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate.text.substring(0,6)){
				alert("�Ű����ڰ� �����󰢿����� ����� ���� �����մϴ�.");
				return false;
			}
    }else if(gclx_chgtype.bindcolval==2){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate_2.text.substring(0,6)){
				alert("������ڰ� �����󰢿����� ����� ���� �����մϴ�.");
				return false;
			}
		}else if(gclx_chgtype.bindcolval==3){
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=gcem_chgdate_3.text.substring(0,6)){
				alert("�ں������� ���ڰ� �����󰢿����� ����� ���� �����մϴ�.");
				return false;
			}
		}
	
		if (confirm("�����Ͻ� ������ �����Ͻðڽ��ϱ�?")){
			gcds_code02.deleterow(gcds_code02.rowposition);
			gctr_code01.KeyValue = "a090023_t3(I:USER=gcds_code02)";
			gctr_code01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090023_t3";
			//prompt('',gcds_code02.text);
			gctr_code01.post();
		}
	}
}


/******************************************************************************
	Description : ����� üũ 
******************************************************************************/
function ln_Chk(){
    var strchgyymm="";

    if(gcds_code02.namevalue(gcds_code02.rowposition,"LOCKGB")=="Y"){
		alert("�ش���� ������ �� �����ϴ�.");
		return false;
	}	

	if(gclx_chgtype.bindcolval==""){
		alert("���������� �����Ͻʽÿ�");
		return false;
	}

	if(gclx_chgtype.bindcolval=="1"){ //�Ű��ϰ��
		if(gcem_chgdate.text==""){ 
			alert("�Ű����ڴ� �ʼ� �׸��Դϴ�.");
			gcem_chgdate.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate.text.substring(0,6);
		}

		if(gcem_chgamt.text==""){ 
			alert("�Ű��ݾ��� �ʼ� �׸��Դϴ�.");
			gcem_chgamt.Focus();
			return false;
		}	

		if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //������ �ƴѰ��
			//��¥ üũ ���� �󰢿��� ���� ���� �ԷºҰ��ϰ� ��. 
			//�������ڴ� ���� �󰢿����� 1���� ũ����.. ( ��, ����� ��� �Է� �Ŀ� �ش���� �������� ��������. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("�Ű����ڴ� ���� �����󰢳������ ũ�� �մϴ�.")
				return false;
			}
			
			//2011.12.29 jys  �Ű����� ��� ������ �Ȱ��� üũ ����.
			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //�Ϸᰡ �ƴѰ�.
				//2011.06.13 JYS �Ű��� ������ ���������� 2���� �̻�Ǹ�, ������ ó���� ���� �ʱ� ������ üũ��	
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("�Ű����� ���� �����󰢿�+1���̾�� �մϴ�.")
					return false;
				}
			}
		}


		//�Ű��� ��� �Ű�ó �ʼ��׸�
		if(txt_relfirm.value==""||txt_relfirmnm.value==""){
			alert("�Ű�ó�� �Է��Ͻʽÿ�.");
			return false;
		}

	}else if(gclx_chgtype.bindcolval=="2"){ //����ϰ��

		if(gcem_chgdate_2.text==""){ 
			alert("������ڴ� �ʼ� �׸��Դϴ�.");
			gcem_chgdate_2.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate_2.text.substring(0,6);
		}

		if(gcem_chgamt_2.text==""){ 
			alert("���ݾ��� �ʼ� �׸��Դϴ�.");
			gcem_chgamt_2.Focus();
			return false;
		}	


        if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //������ �ƴѰ��
			//��¥ üũ ���� �󰢿��� ���� ���� �ԷºҰ��ϰ� ��. 
			//�������ڴ� ���� �󰢿����� 1���� ũ����.. ( ��, ����� ��� �Է� �Ŀ� �ش���� �������� ��������. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("������ڴ� ���� �����󰢳������ ũ�� �մϴ�.")
				return false;
			}
        
            
			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //�Ϸᰡ �ƴѰ�.
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("������ ���� �����󰢿�+1���̾�� �մϴ�.")
					return false;
				}
			}
    	}

		//����� ��� ���ó �ʼ��׸�
		//JYS ���ó �����׸����� ���� ( 2011.06.13 �ÿ�ȸ �� )
		/**
		if(txt_relfirm_2.value==""||txt_relfirmnm_2.value==""){
			alert("���ó�� �Է��Ͻʽÿ�.");
			return false;
		}
		**/

	}else if(gclx_chgtype.bindcolval=="3"){ //�ں��������� ��� 
    
    	if(gcem_chgdate_3.text==""){ 
			alert("�ں������� ���ڴ� �ʼ� �׸��Դϴ�.");
			gcem_chgdate_3.Focus();
			return false;
		}else{
			strchgyymm = gcem_chgdate_3.text.substring(0,6);
		}

		if(gcem_chgamt_3.text==""){ 
			alert("�ں������� �ݾ��� �ʼ� �׸��Դϴ�.");
			gcem_chgamt_3.Focus();
			return false;
		}	


       if(gcds_code01.namevalue(gcds_code01.rowposition,"AST2ND")!="11"){ //������ �ƴѰ��
			//��¥ üũ ���� �󰢿��� ���� ���� �ԷºҰ��ϰ� ��. 
			//�������ڴ� ���� �󰢿����� 1���� ũ����.. ( ��, ����� ��� �Է� �Ŀ� �ش���� �������� ��������. )
			if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")>=strchgyymm){
				alert("�ں������� ���ڴ� ���� �����󰢳������ ũ�� �մϴ�.")
				return false;
			}

			if (gcds_code01.namevalue(gcds_code01.rowposition,"ASTDEPRST")!="1"){   //�Ϸᰡ �ƴѰ�.
				if(ln_SetYYYYMM(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM"))!=strchgyymm){ 
					alert("�ں���������� ���� �����󰢿�+1���̾�� �մϴ�.")
					return false;
				}
			}
		}

    /**
		//�ں��� ������ ��� �ŷ�ó �ʼ��׸�
		if(txt_relfirm_3.value==""||txt_relfirmnm_3.value==""){
			alert("�ŷ�ó�� �Է��Ͻʽÿ�.");
			return false;
		}
		**/
	}
	return true
}


/******************************************************************************
	Description : �ڻ�� �˾�
******************************************************************************/
function ln_Popup(e){

	if(e=='01'){           //�ڻ�� �˾�â
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;
		
		//strURL = "./Atcode_popup_1.jsp";
		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan.value = arrParam[1];  //�ڻ��
			gcem_jasan.text = arrParam[0];  //�ڻ��ڵ�
		} else {
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
	}
}

/******************************************************************************
	Description : ���� �˾�
	Parameter   : srow - grid�� row, strgb - 01: grid,  02:�˻�����
******************************************************************************/
function ln_Popup2(srow,strgb){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="0030";//�����ڵ�
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

 if(strgb=="02"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD.value = ln_Trim(arrParam[0]);
			txt_COSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD.value = "";	
			txt_COSTNM.value = "";
		}
	}
}


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 
/******************************************************************************
	Description : �������� 
******************************************************************************/
function ln_Lx_Enable(row){
  //alert("LOCKGB:::"+gcds_code02.namevalue(row,"LOCKGB"));
	if(gcds_code02.namevalue(row,"LOCKGB")=="Y"){
		gclx_chgtype.enable=false;
	}else{
		gclx_chgtype.enable=true;
	}
}

/******************************************************************************
	Description : ������ �ʱ�ȭ  
******************************************************************************/
function ln_Clear(){
	gcem_chgdate.text="";
  gcem_chgamt.text="";
	gcem_chgamt2.text="";
	gcem_chgamt3.text="";
	txt_relfirm.value="";
   
	gcem_chgdate_2.text="";
  gcem_chgamt_2.text="";
	gcem_chgamt2_2.text="";
	gcem_chgamt3_2.text="";
	txt_relfirm_2.value="";

  gcem_chgdate_3.text="";
  gcem_chgamt_3.text="";
	gcem_chgamt2_3.text="";
	txt_relfirm_3.value="";
}

/******************************************************************************
	Description : �ŷ�ó ã��
	Parameter   : 01 - �Ű�,  02 - ���,  03 - �ں�������  
******************************************************************************/
function ln_Popup4(e){    
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos; 

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if(e=='01'){ 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm.value = arrParam[0];
			txt_relfirmnm.value = arrParam[1];
		} else {
			txt_relfirm.value = "";
			txt_relfirmnm.value = "";
		}
	}else if(e=='02'){                   
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm_2.value = arrParam[0];
			txt_relfirmnm_2.value = arrParam[1];
		} else {
			txt_relfirm_2.value = "";
			txt_relfirmnm_2.value = "";
		}
	}else if(e=='03'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_relfirm_3.value = arrParam[0];		
			txt_relfirmnm_3.value = arrParam[1];
		} else {
			txt_relfirm_3.value = "";		
		  txt_relfirmnm_3.value = "";
		}
	}
}


/******************************************************************************
	Description : �Ķ���� ���� ��� + 1 �� 
	Parameter   : �����󰢳��  
******************************************************************************/
function ln_SetYYYYMM(stryyyymm){

	var strSetYYMM="";
	var strYY = stryyyymm.substring(0,4);
	var strMM = stryyyymm.substring(4,6);

	if( parseInt(strMM)==12) {
    strYY = parseInt(strYY)+1;
		strMM = "01";
		strSetYYMM = strYY+ strMM;
	}else{
    strSetYYMM = parseInt(stryyyymm)+1
	}

  return  strSetYYMM;
}

/******************************************************************************
	Description : �Ķ���� ���� ��� + 1 �� 
	Parameter   : �����󰢳��  
******************************************************************************/
function ln_Excel(){

	gcgd_disp01.GridToExcel("���泻��","",2);
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
	<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<object  id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<object  id=gcds_cancel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</object>

	<!-- ���� -->
	<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</object>

	<!-- �ڻ�з� -->
	<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
		<PARAM NAME="SYNCLOAD" VALUE="false">
	</object>

	<!--�ڻ�Һз�-->
	<OBJECT id="gcds_ascosdiv2_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
		<PARAM NAME="SYNCLOAD" VALUE="true">
	</OBJECT>

	<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gctr_code01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt01.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow<=0)
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	ft_cnt02.innerText="����Ÿ ��ȸ���Դϴ�.";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)"> 
  ln_Lx_Enable(row);
  ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
</script>

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	window.status=" ������ ó�����Դϴ�. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  ������ó���� �Ϸ� �߽��ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<script language="javascript" for="gcds_cancel" event="OnLoadStarted()">
	window.status=" ������ ������Դϴ�. ";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_cancel" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  ��������Ҹ� �Ϸ� �߽��ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<!-- �����з� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="��ü";
	gclx_fdcode.index=0;
</script>

<!-- �ڻ�з� (�˻�)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="��ü";
	gclx_asdivcod.index=0;
</script>

<!-- �ڻ�Һз� (�˻�)-->
<script language="javascript" for="gcds_ascosdiv2_2" event="onloadCompleted(row,colid)">
window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";   
	//document.all.LowerFrame.style.visibility="hidden";  	
  gcds_ascosdiv2_2.InsertRow(1);	
  gcds_ascosdiv2_2.NameValue(1,"CDCODE")="";
	gcds_ascosdiv2_2.NameValue(1,"CDNAM")="";
	gclx_ascosdiv2_2.index=0;	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
if(gclx_asdivcod.BindColVal=='14'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
	gcds_ascosdiv2_2.Reset();
}else if(gclx_asdivcod.BindColVal=='16'){
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
	gcds_ascosdiv2_2.Reset();
}else{
 	//�ڻ�Һз�[�˻�]
	gcds_ascosdiv2_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
	gcds_ascosdiv2_2.Reset();
}	
</script>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<script language="javascript" for="gclx_chgtype" event="OnSelChange2()">

  ln_Clear(); 

	if (gclx_chgtype.bindcolval=="1") {  //���
		//div1.style.display = "";
		div2.style.display = "";
		div3.style.display = "none";
		div4.style.display = "none";
	} else if (gclx_chgtype.bindcolval =="2") { //�Ű�
		//div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "";
		div4.style.display = "none";	

		gcem_chgamt_2.text=gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT");  //���ݾ�
	  gcem_chgamt2_2.text=gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT"); //���ս�
	} else if (gclx_chgtype.bindcolval =="3") { //�ں�������
		//div1.style.display = "none";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "";
	} else {
		//div1.style.display = "";
		div2.style.display = "none";
		div3.style.display = "none";
		div4.style.display = "none";
	}
</script>

<!-- �Ű��� �����ڻ� ó�мս�/ó������ �ڵ���� -->
<script language=JavaScript for=gcem_chgamt event=OnKillFocus()> 
	var ls_chgamt=0;     //�Ű��ݾ�
	var ls_astrmamt=0;   //���� ��������(��ΰ���)
	var ls_chgdiff=0;    //����

	ls_chgamt = gcem_chgamt.Text;
	ls_astrmamt = gcds_code01.namevalue(gcds_code01.rowposition,"ASTRMAMT") ;

	gcem_chgamt2.Text=0;
	gcem_chgamt3.Text=0;
 	
	if( Number(ls_chgamt) > Number(ls_astrmamt)) { // �Ű��ݾ� > ��ΰ��� ���
		ls_chgdiff=(ls_chgamt - ls_astrmamt*1);
		gcem_chgamt3.Text=ls_chgdiff;                // ó������
	} else {
		ls_chgdiff=(ls_astrmamt - ls_chgamt*1);
		gcem_chgamt2.Text=ls_chgdiff;                // ó�мս� 
	}
</script>

<!-- �ں��� ���⿡�� ���ݾ� ��� -->
<script language=JavaScript for=gcem_chgamt_3 event=OnKillFocus()> 

	var ls_chgamt = 0;                  //�ں�������ݾ�
	var ls_astaqamt =0;                 //���� ���ݾ�
	var ls_chgsum=0;                    //�հ�

	ls_chgamt = gcem_chgamt_3.Text;     //�ں�������ݾ�
	ls_astaqamt = gcds_code01.namevalue(gcds_code01.rowposition,"ASTAQAMT") ;
	ls_chgsum=(ls_astaqamt + ls_chgamt*1); //
  gcem_chgamt2_3.Text=ls_chgsum;
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	
	if(row>0) {
		ln_Query2(row);
	}
</script>
 
<script language="javascript"  for=gcgd_disp02 event=OnClick(row,colid)>
	
	if(row>0) {
		ln_Lx_Enable(row);
	}
</script>
 
<script language=JavaScript for=gcds_code01 event=OnRowPosChanged(row)>

	if(row>0) {
	  ln_Query2(row);
		ln_Lx_Enable(row);
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
	ln_Query();
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
	alert("�۾��� ���������� �Ϸ���� ���߽��ϴ�.");
  alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		 <td  background="../../Common/img/com_t_bg.gif"  align=left><img src="../img/a090003_head.gif"></td>
		 <td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		        <img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onclick="ln_Excel()">
				<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr width="860px"> 		
			<td class="tab21" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " style="height:30px;width:80px;" bgcolor="#eeeeee" align="center">��&nbsp;&nbsp;&nbsp;&nbsp;��</td> 	
			<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " width="145px;" >&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
					<param name=ComboDataID          value="gcds_fdcode">
					<param name=CBDataColumns	     value="FDCODE,FDNAME">
					<param name=SearchColumn	     value="FDNAME">
					<param name=Sort			     value=false>
					<param name=ListExprFormat       value="FDNAME^0^150">								
					<param name=BindColumn		     value="FDCODE">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script> 				
			</td> 
			<td width="80px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab21" align=center >&nbsp;���±���</td>
			<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " width="145px;" >&nbsp;
				
				<comment id="__NSID__">
					<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-2px;top:2px;font-size:12px;width:110px;">
						<param name=CBData					value="^��ü,0^����,1^�Ű�,2^���,3^�ں�������">
						<param name=CBDataColumns		value="Code, Parm">
						<param name=SearchColumn		value="Parm">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="Parm^0^110">
						<param name=BindColumn			value="Code">
					</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr> 			
				
				
				<!-- <comment id="__NSID__">
				<OBJECT id=gcem_astnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">	
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="########">
					<param name=PromptChar   	value="_">
				</OBJECT>&nbsp;&nbsp;
				<OBJECT id=gcem_total classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:0px;top:2px;">	
					<param name=Text				value="">
					<param name=Alignment		value=2>
					<param name=Border			value=true>
					<param name=MaxLength   value=4>
					<param name=IsComma	    value=false>
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script>  -->
			</td> 
			<td width="80px"  style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab21" align=center >&nbsp;������</td>
			<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; "  >&nbsp;
				<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','02')">
				<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
			</td>
		</tr>
		<!----------------------------------------------------------------------------------------------------------------->
		<tr width="876px"> 
			<td width="80px" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; "  style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>�ڻ��ߺз�</nobr></td>
			<td class="tab19" style="width:160px;" ><nobr>&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
					<param name=ComboDataID			value="gcds_asdivcod">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort						value=false>
					<param name=ListExprFormat	value="CDNAM^0^130">
					<param name=BindColumn			value="CDCODE">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr>
			</td>					
			<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>�ڻ�Һз�</nobr></td>
			<td class="tab19" style="width:120px;"><nobr>&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_ascosdiv2_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-2px;top:2px;font-size:12px;width:110px;">
					<param name=ComboDataID			value="gcds_ascosdiv2_2">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				value=false>
					<param name=ListExprFormat	value="CDNAM^0^110">
					<param name=BindColumn			value="CDCODE">
				 </OBJECT>
				 </comment><script>__ws__(__NSID__);</script></nobr> 
			 </td>
			 <td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center><nobr>&nbsp;�ڻ��</nobr></td>
			 <td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; "><nobr>&nbsp;
				<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-1px;top:-2px;" MaxLength=30>
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup(01)">
				<comment id="__NSID__">
				<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#######">
					<param name=PromptChar	value="_">
					<param name=Enable			value="false">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script></nobr>						 
			 </td>
		 </tr>  
		 <tr>
		  <td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >����</td>
			<td class="tab28" colspan=5 >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24px;width:240px">
					<param name=Cols	  value="2">
					<param name=Format	value="1^������,2^�󰢹�����(����)">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
		 </tr>
  </table>

<table width="858px" cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;top:3px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01 	style="position:relative;left:0px;width:665px; height:225px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="false"> 
					<param name="Format"		value=" 
					<C> Name='�ڻ��ȣ'			ID=ASTNBR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='�ڻ��'				ID=ASNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=left	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='�������'			ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center	BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} Mask='XXXX/XX/XX'</C>
					<C> Name='���'		    	ID=ASLIFYER		HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='���ݾ�'			ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='���⴩���'	  ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='���󰢾�'	  ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='��������'			ID=ASTRMAMT 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} </C>
					<C> Name='�󰢿�'		    ID=LASTYM   	HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center  BgColor={IF(MODIFYGB='N','#FFCC66','FFFFFF')} Mask='XXXX/XX'</C>
					">
			 </object>
			 </comment><script>__ws__(__NSID__);</script>
			</td>
      <td>
			<comment id="__NSID__">
			 <object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02 	style="position:relative;left:0px;width:190px; height:225px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		value="gcds_code02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="false"> 
					<param name="Format"		value=" 
					<C> Name='����'		    ID=CHGNO  		HeadAlign=Center HeadBgColor=#B9D4DC Width=35	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} </C>
					<C> Name='��������'		ID=CHGDATE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} Mask=XXXX-XX-XX </C>
					<C> Name='�ڻ����'		ID=CHGTYPE		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  BgColor={IF(LOCKGB='Y','#FFCC66','FFFFFF')} EditStyle=Combo		Data='0:����,1:�Ű�,2:���,3:�ں�������' </C>	
					">
			 </object>
			 </comment><script>__ws__(__NSID__);</script>		
		</td>
	</tr>
	<tr>
		<td style="height:20px;" >
			<fieldset style="height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">&nbsp;<font id=ft_cnt01 style="position:relative;top:3px;cursor:hand;"></font></fieldset>
		</td>
    <td style="height:20px;" >
			<fieldset style="height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">&nbsp;<font id=ft_cnt02 style="position:relative;top:3px;cursor:hand;"></font></fieldset>
		</td>
  </tr>
	<tr><td style="height:5px;" colspan=2> </td></tr>
</table>	
	
<table cellpadding="0" cellspacing="0"  width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
		<tr>
			<td style="width:110px;" bgcolor="#FFCC66" align=center class="tab14" >&nbsp;��������&nbsp;</td>
			<td align=left class="tab31">
				<comment id="__NSID__">
				<OBJECT id=gclx_chgtype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 style="position:relative;left:7px;top:0px" class="txtbox" >
					<param name=CBData					value="1^�Ű�,2^���,3^�ں�������">
					<param name=CBDataColumns		value="Code, Parm">
					<param name=SearchColumn		value="Parm">
					<param name=Sort						value="false">
					<param name=ListExprFormat	value="Parm^0^100">
					<param name=BindColumn			value="Code">
				</OBJECT>
				</comment><script>__ws__(__NSID__);</script> 				
			</td>
			<td align=right class="tab31" >
				<img id="btn_Delete08"   src="../../Common/img/btn/com_b_delete.gif"    style="cursor:hand;position:relative;top:2px;" onclick="ln_Delete()">
				<img id="btn_Insert08"   src="../../Common/img/btn/com_b_insert.gif"	  style="cursor:hand;position:relative;top:2px;" onClick="ln_Add()">
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Save()">
			</td>
		</tr>
</table>
		
 <div id=div2 style="display:none"><!-- �Ű� -->
		<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
			<tr>
					<td class="tab11" width="110" bgcolor="#eeeeee">�Ű�����</td>
					<td class="tab21" width="110" height="30px" >
						<comment id="__NSID__">
						<object id=gcem_chgdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
						</object>
						</comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
					</td>
					<td class="tab11" width="110"  height="30px" bgcolor="#eeeeee">�Ű��ݾ�</td>
					<td class="tab21" width="110"  height="30px" >
						<comment id="__NSID__">
						<object id=gcem_chgamt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment					value=2>
								<param name=MaxDecimalPlace		value=0>
								<param name=MaxLength value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">�Ű�ó</td>
					<td class="tab21" height="30px">
						<!-- <input type="text" id=txt_relfirm class="txt21" style="width:230px;" > -->
						<input id="txt_relfirm"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find2('txt_MAKER','03');" readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('01');">
						<input id="txt_relfirmnm" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;"class="txtbox"  maxlength="36" onBlur="bytelength(this,this.value,36);" readOnly>			
					</td>
				</tr>
				<tr>
					<td class="tab11" height="30px" bgcolor="#eeeeee">�����ڻ� ó�мս�</td>
					<td class="tab21" height="30px" width=110>
						<comment id="__NSID__">
						<object id=gcem_chgamt2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment					 value=2>
								<param name=ReadOnlyBackColor  value="#BEF781">
								<param name=ReadOnly           value="true">
								<param name=MaxDecimalPlace		 value=0>
								<param name=MaxLength          value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" height="30px" bgcolor="#eeeeee">�����ڻ� ó������</td>
					<td class="tab21" height="30px" width=110  colspan=3>
						<comment id="__NSID__">
						<object id=gcem_chgamt3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
							style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment					 value=2>
								<param name=ReadOnlyBackColor  value="#BEF781">
								<param name=ReadOnly           value="true">
								<param name=MaxDecimalPlace	 	 value=0>
								<param name=MaxLength value=13>			  										
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</div>
					
		<div id=div3 style="display:none"><!-- ��� -->
			<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
					<tr>
						<td class="tab11" width="110" bgcolor="#eeeeee">�������</td>
						<td class="tab21" width=110   height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgdate_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  	style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
									<param name=Alignment			value=0>
									<param name=Border	      value=true>
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate_2', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td class="tab11" width="110"  bgcolor="#eeeeee">���ݾ�</td>
						<td class="tab21" width="110"  height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								  style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
									<param name=MaxDecimalPlace		 value=0>
									<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
				    </td>				
						<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">���ó</td>
						<td class="tab21" height="30px" >
							<!-- <input type="text" id=txt_relfirm_2 class="txt21" style="width:170px;" > -->
							<input id="txt_relfirm_2"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('02');">
							<input id="txt_relfirmnm_2" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"   readOnly>								
						</td>
		      </tr>
					<tr>
						<td class="tab11" height="30px" bgcolor="#eeeeee">�����ڻ� ���ս�</td>
						<td class="tab21" height="30px" width=110>
							<comment id="__NSID__">
							<object id=gcem_chgamt2_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="3"
								  style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
									<param name=MaxDecimalPlace		 value=0>
									<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script></td>
						<td class="tab11" height="30px" bgcolor="#eeeeee">�����</td>
						<td class="tab21" height="30px" width=180 colspan=3>
							<comment id="__NSID__">
							<object id=gcem_chgamt3_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="2"
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								 <param name=Alignment					value=2>
								 <param name=ReadOnlyBackColor  value="#BEF781">
								 <param name=ReadOnly           value="true">
								 <param name=MaxDecimalPlace		value=0>
								 <param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
					</tr>				
				</table>
			</div>

			<div id=div4 style="display:none"><!-- �ں������� -->
				<table cellpadding="0" cellspacing="0" width="860px" style="position:relative;left:3px;border:0 solid #708090;border-left-width:1px;">
					<tr>
						<td class="tab11" width="110" bgcolor="#eeeeee">�ں������� ����</td>
						<td class="tab21" width=110   height="30px" >
							<comment id="__NSID__"><object id=gcem_chgdate_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:2px; width:70px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</object></comment><script>__ws__(__NSID__);</script>
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_chgdate_3', 'Text')" style="position:relative;width:20px;left:10px;cursor:hand;">
						</td>
						<td class="tab11" width="110" height="30px" bgcolor="#eeeeee">�ں������� �ݾ�</td>
						<td class="tab21" width="110" height="30px" >
							<comment id="__NSID__">
							<object id=gcem_chgamt_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
								<param name=Alignment					value=2>
								<param name=MaxDecimalPlace		value=0>
								<param name=MaxLength value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</td>
						<td class="tab11" width="80" height="30px" bgcolor="#eeeeee">�ŷ�ó</td>
						<td class="tab21" height="30px" >
							<!-- <input type="text" id=txt_relfirm_3 class="txt21" style="width:170px;" > -->
							<input id="txt_relfirm_3"   type=text    style= "position:relative;top:2px;left:4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  readOnly>
							<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('03');">
							<input id="txt_relfirmnm_3" type="text"  style= "position:relative;top:2px;left:4px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"   readOnly>								
						</td>
					</tr>
					<tr>
						<td class="tab11" height="30px" bgcolor="#eeeeee">���ݾ�</td>
						<td class="tab21" height="30px" colspan = 5>
							<comment id="__NSID__">
							<object id=gcem_chgamt2_3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
								style="position:relative; left:8px;top:2px; width:100px; height:20px; font-family:����; font-size:9pt;z-index:2;">
									<param name=Alignment					 value=2>
									<param name=ReadOnlyBackColor  value="#BEF781">
									<param name=ReadOnly           value="true">
 									<param name=MaxDecimalPlace		 value=0>
  							  <param name=MaxLength          value=13>			  										
							</object>
							</comment><script>__ws__(__NSID__);</script>
						</td>
					</tr> 
				</table>
			</div>

</table>
 
<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="DataID" VALUE="gcds_code02">
<PARAM NAME="BindInfo" VALUE="
		<C>Col=CHGTYPE		Ctrl=gclx_chgtype				  Param=BindColVal</C>
		
		<C>Col=CHGDATE			Ctrl=gcem_chgdate				Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt				Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2			  Param=Text</C>
		<C>Col=CHGAMT3		  Ctrl=gcem_chgamt3			  Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm			  Param=value</C>
		<C>Col=RELFIRMNM		Ctrl=txt_relfirmnm		  Param=value</C>

		<C>Col=CHGDATE			Ctrl=gcem_chgdate_2			Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt_2			Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2_2			Param=Text</C>
		<C>Col=CHGAMT3		  Ctrl=gcem_chgamt3_2			Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm_2			Param=value</C>
		<C>Col=RELFIRMNM  	Ctrl=txt_relfirmnm_2	  Param=value</C>

		<C>Col=CHGDATE			Ctrl=gcem_chgdate_3			Param=Text</C>
		<C>Col=CHGAMT			  Ctrl=gcem_chgamt_3			Param=Text</C>
		<C>Col=CHGAMT2		  Ctrl=gcem_chgamt2_3			Param=Text</C>
		<C>Col=RELFIRM			Ctrl=txt_relfirm_3			Param=value</C>
		<C>Col=RELFIRMNM  	Ctrl=txt_relfirmnm_3	  Param=value</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>