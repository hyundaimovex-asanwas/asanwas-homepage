<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ���� - ��ü �� �̵�ó��		
+ ���α׷� ID	: A090025.html
+ �� �� �� ��	: ���� �ڻ��� ��ü �� �̵� ó���ϴ� ȭ���̴�.
+ ��   ��  �� : ������
+ �� �� �� �� : 2011.04.11
-----------------------------------------------------------------------------
+ �� �� �� �� : ����� üũ ���� ���� ( üũ �ȵȰ��� ��� undo ó�� )
+ ��   ��  �� :  �̵���
+ �� �� �� �� : 2012.06.19
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090025_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��ü �� �̵�ó��</title>
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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4);
var gs_fdcode = gfdcode;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�Ҽ��ڵ�[�˻�]
	gcds_fdcode.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ߺз�[�˻�]
	gcds_asdivcod.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
  
 }

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	var str1 = gclx_fdcode.BindColVal;                //����
	var str2 = txt_COSTNM.value;                      //������
	var str3 = txt_COSTCD.value;                      //�����ڵ�
	var str4 = gclx_asdivcod.BindColVal;              //�ߺз�
	var str5 = gclx_asdivcod_2.BindColVal;            //�Һз�	
	var str6 = gcem_jasan.text;                       //�ڻ��ڵ�
    var str7 = txt_jasan.value;                       //�ڻ��
	
	gcds_code01.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3
										 + "&v_str4="+str4 
										 + "&v_str5="+str5
									   + "&v_str6="+str6
										 + "&v_str7="+str7;
										
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : �ڻ�� �˾�
******************************************************************************/
function ln_Popup4(e){

	if(e=='01'){           //�ڻ�� �˾�â
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;


		arrParam[0]=gclx_asdivcod.bindcolval;
    arrParam[1]=gclx_asdivcod_2.bindcolval;
		
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
	Description : �μ� �˾�
	Parameter   : 01-���μ�,  02-�����μ�
******************************************************************************/
function ln_Popup(e,srow){

  var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

  if(gcds_code01.namevalue(gcds_code01.rowposition,"AFDCODE")==""){
		alert("�������� �Է��Ͻʽÿ�.");
		return;
	}
	
	arrParam[0] = gcds_code01.namevalue(gcds_code01.rowposition,"AFDCODE");

	strURL = "./hcdept_popup4.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

  if(e=='01'){  
		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		gcds_code01.namevalue(srow,"AUSEDPT") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"AUSEDPTNM") = ln_Trim(arrParam[1])
		} else {
			gcds_code01.namevalue(srow,"AUSEDPT") = "";
			gcds_code01.namevalue(srow,"AUSEDPTNM") = "";
		}
  }else if(e=='02'){
		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		gcds_code01.namevalue(srow,"AMNGDPT") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"AMNGDPTNM") = ln_Trim(arrParam[1]); 
		} else {
			gcds_code01.namevalue(srow,"AMNGDPT") = "";
			gcds_code01.namevalue(srow,"AMNGDPTNM") = "";
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

  if(strgb=="01"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcds_code01.namevalue(srow,"ACOSTCD") = ln_Trim(arrParam[0]);
			gcds_code01.namevalue(srow,"ACOSTNM") = ln_Trim(arrParam[1]); 
		}else{
			gcds_code01.namevalue(srow,"ACOSTCD") = "";	
			gcds_code01.namevalue(srow,"ACOSTNM") = "";
		}
	}else if(strgb=="02"){
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
	Description : ������˾�
	Parameter   : 
******************************************************************************/
function ln_Popup3(srow){
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup2.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcds_code01.namevalue(srow,"AUSER") = ln_Trim(arrParam[1]);
		gcds_code01.namevalue(srow,"AUSERNM") = ln_Trim(arrParam[0]); 
	}else{
		gcds_code01.namevalue(srow,"AUSER") = "";	
		gcds_code01.namevalue(srow,"AUSERNM") = "";
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
	Description : ���� 
******************************************************************************/
function ln_Save(){

   if(!ln_Chk_Save()) return; 

	if(confirm("�ڻ��� ��ü �� �̵� ó���Ͻðڽ��ϱ�?")){
			gctr_code01.KeyValue   =  "Account.a090025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_t1?";
			gctr_code01.Parameters =  "v_str1="+gusrid;
			//prompt('',gcds_code01.text);
			gctr_code01.post();
	}
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
function ln_Chk_Save(){
  var str_chk="";

  
  ////////////////////////////////////////////////////////////////////////////
  // �̵� ��ü�� �������� ������ ������ �Ǿ�� ���밡����. 
  ////////////////////////////////////////////////////////////////////////////
	//�� ������ ���� ��� ��ó���� �� ��...
	//������ üũ
    gcds_chk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>astMove_chk_s1"
									+ "?v_str1="+gclx_fdcode.BindColVal+"&v_str2=1";
	gcds_chk.Reset(); 


  /////////////////////////////////////////////////////////////////////////////////


  //üũ�� ���� ��� Ȯ�� 
	STEP1:
	for(i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")=="T"){
        str_chk="1";
				break STEP1;
		}
	}

	if(str_chk!="1"){
		alert("���ÿ� üũ�� �׸��� �������� �ʽ��ϴ�.");
		return false;
	}

	//�ʼ��׸� üũ 
   for(j=1;j<=gcds_code01.countrow;j++){
		if(gcds_code01.namevalue(j,"CHK")=="T"){
            if(gcds_code01.namevalue(j,"ASTGUBUN")==""){
				alert("������ �ʼ��׸��Դϴ�.");
				gcgd_disp01.focus();
				return false;
			}

           if(gcds_code01.namevalue(j,"MOVDATE")==""){
				alert("��ü/�̵����ڴ� �ʼ��׸��Դϴ�.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AFDCODE")==""){
				alert("��ü �� �̵� �� ������ �ʼ��׸��Դϴ�.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AUSEDPTNM")==""){
				alert("��ü �� �̵� �� ���μ��� �ʼ��׸��Դϴ�.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AMNGDPTNM")==""){
				alert("��ü �� �̵� �� �����μ��� �ʼ��׸��Դϴ�.");
				return false;
			}

			if(gcds_code01.namevalue(j,"ACOSTNM")==""){
				alert("��ü �� �̵� �� ������ �ʼ��׸��Դϴ�.");
				return false;
			}

			if(gcds_code01.namevalue(j,"AUSERNM")==""){
				alert("��ü �� �̵� �� ����ڴ� �ʼ��׸��Դϴ�.");
				return false;
			}
			
			
			//�������ڿ� �̵�/��ü���� üũ 
			//2012.04.06.�� JYS 
			//alert("cyymmdd"+gcds_chk.namevalue(1,"CYYMMDD").substring(0,6));
			//alert("MOVDATE"+gcds_code01.namevalue(j,"MOVDATE").substring(0,6));
			
			if ( gcds_chk.namevalue(1,"CYYMMDD").substring(0,6) !=gcds_code01.namevalue(j,"MOVDATE").substring(0,6)){
				alert("�� �۾� �� �̵�/��ü �Ͻʽÿ�.");
				return false;
			}
			

			//��ü�� ��� ������ �����ϸ� ����
           if(gcds_code01.namevalue(j,"ASTGUBUN")=="8"){
				if(gcds_code01.namevalue(j,"FDCODE")==gcds_code01.namevalue(j,"AFDCODE")){
					alert("��ü�� ��� ���� ������ �� �� �����ϴ�.");
					return false;
				}
				
				
		  
			  //��ü���ڴ� ���� �󰢳������ Ŀ�� �մϴ�.
			  //(��..2011.05�� �������� ������ 2011.05���� �ڻ� ��ü ����. 2011.06�� ��ü �ؾ���. )
			  if(gcds_code01.namevalue(j,"ASTYMD")!=""){
			  
					if(gcds_code01.namevalue(j,"ASTYMD")>=gcds_code01.namevalue(j,"MOVDATE")){
						alert("��ü���� �����󰢿����� Ŀ���մϴ�.");
						return false;
					}
			  }
			  
			}
			

           //�̵��� ��� ������ �ٸ��� �ϸ� ����
           if(gcds_code01.namevalue(j,"ASTGUBUN")=="9"){
				if(gcds_code01.namevalue(j,"FDCODE")!=gcds_code01.namevalue(j,"AFDCODE")){
					alert("�̵��� ��� ���� ������ �����մϴ�.");
					return false;
				}
				
			   
				//��ü���ڴ� ���� �󰢳������ Ŀ�� �մϴ�.
			    //(��..2011.05�� �������� ������ 2011.05���� �ڻ� ��ü ����. 2011.06�� ��ü �ؾ���. )
				if(gcds_code01.namevalue(j,"ASTYMD")!=""){
					if(gcds_code01.namevalue(j,"ASTYMD")>=gcds_code01.namevalue(j,"MOVDATE")){
						alert("�̵����� �����󰢿����� Ŀ���մϴ�.");
						return false;
					}
				}
			   
			}
		}else{
			if(gcds_code01.SysStatus(j)==3){
				gcds_code01.Undo(j);
			}
		}
	}//for

	return true;
}

/******************************************************************************
	Description : �ڻ�Һз� 
******************************************************************************/
function ln_Ast3rd(){
	//�ڻ�Һз�[�˻�]
	if(gclx_asdivcod.BindColVal=='14'){
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_asdivcod_2.Reset();
	}else if(gclx_asdivcod.BindColVal=='16'){
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_asdivcod_2.Reset();
	}else{	
		gcds_asdivcod_2.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
		gcds_asdivcod_2.Reset();
	}	
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_code02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- ���� -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!-- �ڻ��ߺз� -->
<object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>

<!-- �ڻ�Һз� -->
<object  id="gcds_asdivcod_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object>


<!--��üũ-->
<object  id="gcds_chk" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090008_t1(I:USER=gcds_code01)">
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
<script language="javascript" for="gcds_asdivcod_2" event="onloadCompleted(row,colid)">
	gcds_asdivcod_2.InsertRow(1);
	gcds_asdivcod_2.NameValue(1,"CDCODE")="";
	gcds_asdivcod_2.NameValue(1,"CDNAM")="";
	gclx_asdivcod_2.index=0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	var str="namevalue("+row+",'MOVDATE')";
	if(row>0){
		if(colid=="MOVDATE"){
			__GetCallCalendar('gcds_code01',str);
		}

		if(colid=="AUSEDPTNM"){ // ���μ�
			ln_Popup('01',row);
		}

		if(colid=="AMNGDPTNM"){ // �����μ�
			ln_Popup('02',row);
		}

		if(colid=="ACOSTNM"){   // �����ڵ�
			ln_Popup2(row,'01');
		}
		
    if(colid=="AUSERNM"){   // �����
			ln_Popup3(row);
		}
	}
</script>

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  
	if(row<1) return;
  if(colid=="CHK"||colid=="ASTGUBUN"||colid=="MOVDATE"||colid=="AFDCODE"||
	   colid=="AUSEDPTNM"||colid=="AMNGDPTNM"||colid=="ACOSTNM"||colid=="AUSERNM") return; 

	var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_code01.NameValue(row,"FDCODE"); //����
	arrParam[1] = gcds_code01.NameValue(row,"ASTNBR"); //�ڻ��ȣ
	arrParam[2] = gcds_code01.NameValue(row,"ASTNM");  //�ڻ��
  //alert("FDCODE::"+arrParam[0]+"::ASTNBR::"+arrParam[1]+"::ASTNM::"+arrParam[2]);
	var strURL = "./a090025_popup.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:450px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
 
  //��ü���� 
	if(row==0&&colid=="CHK"){
    if(gcds_code01.namevalue(1,"CHK")=="T"){
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="T";
			}
    }
	}

</script>


<!-- <script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>

	//�̵��ϰ�� ���� ����.
   alert("Occur OnExit Event :\r" + "<ROW :" + row +">"+ "<Colid :" + colid + ">" + "<Before Data :" + olddata + ">" );
	if(colid=="ASTGUBUN"&&gcds_code01.namevalue(row,"ASTGUBUN")=="9"){
			gcds_code01.namevalue(row,"AFDCODE")=gcds_code01.namevalue(row,"FDCODE");
	}

</script> -->

<script language=JavaScript for=gcds_code01 event=onColumnChanged(row,colid)>
  
	if (colid == "ASTGUBUN" && gcds_code01.namevalue(row,"ASTGUBUN")=="9" ) { //�̵�
		gcds_code01.namevalue(row,"AFDCODE")=gcds_code01.namevalue(row,"FDCODE");
	}else if (colid == "ASTGUBUN" && gcds_code01.namevalue(row,"ASTGUBUN")=="8"){ //��ü
		if(gcds_code01.namevalue(row,"FDCODE")==gcds_code01.namevalue(row,"AFDCODE")){
			gcds_code01.namevalue(row,"AFDCODE")="";
		}
	}

</script>
 



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("�۾��� ���������� �Ϸ�Ǿ����ϴ�.");
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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090025_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_save.gif"	  style="cursor:hand" onClick="ln_Save()">
      <img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">     
		</td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>����</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=ListExprFormat	value="FDNAME^0^120">
				<param name=BindColumn			value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> ������</td>  
	  <td class="tab24"  colspan =4 >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:0px; width:220px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:4px;cursor:hand"	 onclick="ln_Popup2('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:5px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
 <tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>�ߺз�</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE, CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center>�Һз�</td>  
	  <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod_2">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>�ڻ��</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;left:-2px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-4px;cursor:hand"	 onclick="ln_Popup4(01)">
			<comment id="__NSID__">
			<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:50px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format			value="#######">
				<param name=PromptChar	value="_">
				<param name=Enable			value="false">
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script> </nobr>
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>
<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:355px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		value=" 
					<FC>Name='����'	           ID=CHK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	EditStyle=CheckBox  </FC> 
					<C> Name='�ڻ�\\��ȣ'			   ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  edit=none   sort=true </C>
					<C> Name='�ڻ��'			     ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  edit=none  </C>
					<C> Name='�������'		     ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=67  	align=center	edit=none  Mask='XXXX/XX/XX' </C>
					<C> Name='���ݾ�'		     ID=ASTAQAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	  edit=none  sort=true</C>
					<C> Name='����' 			     ID=ASTGUBUN	HeadAlign=Center HeadBgColor=#B9D4DC Width=35  	align=center  EditStyle=Combo Data='8:��ü,9:�̵�'</C>
					<C> Name='��ü/�̵�\\����' ID=MOVDATE		HeadAlign=Center HeadBgColor=#B9D4DC Width=75  	align=center  EditStyle=Popup Mask='XXXX/XX/XX'  sort=true</C>
					<G> Name='��ü �� �̵� ��'              HeadAlign=Center HeadBgColor=#B9D4DC	
					<C> Name='����'			    	 ID=FDCODE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left	  edit=none  EditStyle=Combo Data='02:����,03:�ݰ���,04:����' </C>
					<C> Name='���μ�'				 ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	  edit=none   </C>
					<C> Name='�����μ�'			   ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    edit=none   </C>
					<C> Name='����'			       ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    edit=none   </C>
					<C> Name='�����'		       ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    edit=none   sort=true</C>
					</G>
					<G> Name='��ü �� �̵� ��'	            HeadAlign=Center HeadBgColor=#B9D4DC
					<C> Name='����'				     ID=AFDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	  align=left	  EditStyle=Combo Data='02:����,03:�ݰ���,04:����' </C>
					<C> Name='���μ�'				 ID=AUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left	  EditStyle=Popup </C>
					<C> Name='�����μ�'			   ID=AMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    EditStyle=Popup </C>
					<C> Name='����'			       ID=ACOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left    EditStyle=Popup </C>
					<C> Name='�����' 		     ID=AUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left    EditStyle=Popup  sort=true</C>
    			</G>
					<C> Name='����\\�󰢿�' 	 ID=ASTYMD  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=left    EditStyle=Popup Mask='XXXX/XX'  edit=none</C>

					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
 </tr>
  <tr>
		<td colspan=2><BR>
		  <font size="2" color="red"> *</font> <font size="2" color="blue"><b> [��ü]</b></font> ó���ÿ��� �ݵ�� <font size="2" color="blue"><b>[��ǥ �ۼ�]</b></font>�� �ϼž� �մϴ�. <br> 
		     �ſ� ���� �� �۾��� ���� ���� ��ü �̵� �۾��� �Ϸ��Ͽ� �ֽñ� �ٶ��ϴ�. 
		     ���ǻ��� : ȸ���� ������ DR ( �� 3805 ) ���� ���� �ٶ��ϴ�.            
        </td>
  </tr>
</table>

<!--------BIND------->
<comment id="__NSID__">
  <object  id=gcbn_astmst classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code01>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=ASTNBR     Ctrl=gcem_ASTNBR      Param=text </C>
		<C>Col=CDNAM      Ctrl=gcem_CDNAM       Param=text </C>
		<C>Col=ASAQSDAT   Ctrl=gcem_ASAQSDAT    Param=text </C>
		<C>Col=ASTYUSE    Ctrl=gcem_ASTYUSE     Param=text </C>
		<C>Col=ASTAQAMT   Ctrl=gcem_ASTAQAMT    Param=text </C>
		<C>Col=ABDEPRAMT  Ctrl=gcem_ABDEPRAMT   Param=text </C>
		<C>Col=ACDEPRAMT  Ctrl=gcem_ACDEPRAMT   Param=text </C>
    <C>Col=ASTRMAMT   Ctrl=gcem_ASTRMAMT    Param=text </C>
    <C>Col=ASTAMT     Ctrl=gcem_ASTAMT      Param=text </C>
	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 