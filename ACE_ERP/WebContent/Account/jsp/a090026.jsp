<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	: �ڻ����- ��ü �� �̵� ��ȸ
+ ���α׷� ID	: A090026.html
+ �� �� �� ��	: ���� �ڻ��� ��ü �� �̵� history�� ��ȸ�ϴ� ȭ���̴�.
+ ��   ��  �� : ������
+ �� �� �� �� : 2011.05.02
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090026_s1,A090026_s2, A090026_s3
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>��ü �� �̵� ��ȸ</title>
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
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;


/******************************************************************************
	Description : ������ �ε�
******************************************************************************/

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
  
	//�Ҽ��ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ߺз�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_aststat.bindcolval= 9; 

	gcem_movdt_fr.text = gs_date2 + "01";	    //�̵�/��ü���� from
	gcem_movdt_to.text = gs_date ; 

 }

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  if(gclx_aststat.BindColVal.bindcolval==""){
		alert("���°��� �������� �ʽ��ϴ�.");
		return;
	}
	
	var str1 = gclx_fdcode.BindColVal;                //����
	var str2 = txt_COSTNM.value;                      //������ 
	var str3 = txt_COSTCD.value;                      //�����ڵ� ( �̵�/��ü �� ) 
	var str4 = gclx_asdivcod.BindColVal;              //�ߺз�
	var str5 = gclx_asdivcod_2.BindColVal;            //�Һз�	
	var str6 = gcem_jasan.text;                       //�ڻ��ڵ�
    var str7 = txt_jasan.value;                       //�ڻ��
	var str8 = gclx_aststat.BindColVal;               //����
    var str9  = txt_BBCOSTNM.value;                   //������ 
	var str10 = txt_BBCOSTCD.value;                   //�����ڵ� ( �̵�/��ü �� ) 
	var str11 = gcem_movdt_fr.text;                   //�̵����� FR
	var str12 = gcem_movdt_to.text;                   //�̵����� TO
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s1"
									   + "?v_str1="+str1
										 + "&v_str2="+str2
									   + "&v_str3="+str3
										 + "&v_str4="+str4 
										 + "&v_str5="+str5
									   + "&v_str6="+str6
										 + "&v_str7="+str7
										 + "&v_str8="+str8
										 + "&v_str9="+str9
									   + "&v_str10="+str10
										 + "&v_str11="+str11
										 + "&v_str12="+str12;
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();
	gcds_code02.ClearAll();
}

/******************************************************************************
	Description : ����ȸ
	Parameter   : �ڻ��ȣ  
******************************************************************************/
function ln_Sub_Query(strAstnbr){

  if(strAstnbr==""){
		alert("�ڻ��ȣ�°� �������� �ʽ��ϴ�.");
		return;
	}

	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s2"
									   + "?v_str1="+strAstnbr;		
	//prompt('',gcds_code02.DataID);
	gcds_code02.Reset();

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

 if(strgb=="01"){         // ��ü �̵� �� 
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_BBCOSTCD.value = ln_Trim(arrParam[0]);
			txt_BBCOSTNM.value = ln_Trim(arrParam[1]); 
		}else{
			txt_BBCOSTCD.value = "";	
			txt_BBCOSTNM.value = "";
		}
	}else if(strgb=="02"){  //��ü �̵� �� 
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
	Description : ��� 
******************************************************************************/
function ln_Print(){
  var strAstnbr ="";
	var strTempAstnbr="";   // ��ü�� ó�� ���� �ڻ��ȣ
	var strUfdcode="";      // ��ü �μ��� ����� �ڻ��ȣ
	var chk=0;

  var strFromdpt=""
	var strTodpt=""
	var strAstgubun="";    //��ü �̵� ����
	
	gcds_report00.ClearAll();
	ln_SetDataHeader();
  gcds_report00.Addrow();
 
  for(var i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")=="T"){
		  chk+=1;
			if(chk==1){
			  strTempAstnbr=gcds_code01.namevalue(i,"ASTNBR");
				strUfdcode = gcds_code01.namevalue(i,"UFDCODE");
				strAstnbr = gcds_code01.namevalue(i,"ASTNBR");
				strAstnbr ="'"+strAstnbr+"'";

			}else{
				strAstnbr = strAstnbr+ ",'"+ gcds_code01.namevalue(i,"ASTNBR")+"'";
			}


			//��ü �ƴѰ��� �����ϴ� ��� 
      //if(gcds_code01.namevalue(i,"ASTSTAT")!=8){
			//	alert("���°� ��ü�� �ƴ� ���� �����մϴ�. Ȯ���Ͻʽÿ�.");
			//	return;
			//}

			//��ü���ε�, ���� �ٸ� �������� ��ü �ϴ� ��� ���� ����ؾ���.
      if(gcds_code01.namevalue(i,"ASTSTAT")==8&&gcds_code01.namevalue(i,"UFDCODE")!=strUfdcode){
				alert("������ �����Ǹ� ��°����մϴ�.");
				return;
			}

		}
	}

	if(chk==0){
		alert("���ÿ� üũ�� ���� �������� �ʽ��ϴ�. Ȯ���Ͻʽÿ�.");
		return;
  }

  //ASTMOVINGN ��ü �۽� - ���� ���� �μ� ã��
  gcds_report0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s5"
									   + "?v_str1="+strTempAstnbr;		
	//prompt('',gcds_report0.DataID);
	gcds_report0.Reset();


  if(gcds_code01.namevalue(1,"ASTGUBUN")=="9"){
		gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "�̵� [";
		gcds_report00.namevalue(gcds_report00.rowposition,"TITLE") = "�ڻ� �̵� ����";
	}else{
		gcds_report00.namevalue(gcds_report00.rowposition,"ASTGUBUN") = "��ü [";
		gcds_report00.namevalue(gcds_report00.rowposition,"TITLE") = "�ڻ� ��ü ����";
	}

	strAstgubun =gcds_code01.namevalue(1,"ASTGUBUN");
  
	strFromdpt= gcds_report0.namevalue(gcds_report0.rowposition,"FDNAME")+":"+ gcds_report0.namevalue(gcds_report0.rowposition,"BUSEDPTNM");
	strTodpt= gcds_report0.namevalue(gcds_report0.rowposition,"AFDNAME")+":"+ gcds_report0.namevalue(gcds_report0.rowposition,"AUSEDPTNM");

	gcds_report00.namevalue(gcds_report00.rowposition,"FDCODE") = strFromdpt+" �� "+strTodpt+" ]";
	gcds_report00.namevalue(gcds_report00.rowposition,"USRNAME") = gusrnm;
  gcds_report00.namevalue(gcds_report00.rowposition,"USEDATE") = gs_date;
	
  gcds_report1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090026_s3"
									    + "?v_str1="+strAstnbr
											+ "&v_str2="+strAstgubun;
	//prompt('',gcds_report1.DataID);
	gcds_report1.Reset();


	gcrp_print.preview();			//�̸�����

}

/******************************************************************************
	Description : ��� DataSet head
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_report00.countrow<1){
		var s_temp = "TITLE:STRING(100),ASTGUBUN:STRING(10),FDCODE:STRING(255),USERID:STRING(10),USRNAME:STRING(10),USEDATE:STRING(10)";
		gcds_report00.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Save(){

  if(!ln_Chk_Save()) return; 

	if(confirm("�ڻ��� ��ü �� �̵� ó���Ͻðڽ��ϱ�?")){
			gctr_code01.KeyValue   =  "Account.a090025_t1(I:USER=gcds_code01)";
			gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090025_t1?";
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
		}
	}
	return true;
}

/******************************************************************************
	Description : �ڻ�Һз� 
******************************************************************************/
function ln_Ast3rd(){
	//�ڻ�Һз�[�˻�]
	if(gclx_asdivcod.BindColVal=='14'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_asdivcod_2.Reset();
	}else if(gclx_asdivcod.BindColVal=='16'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_asdivcod_2.Reset();
	}else{	
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
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
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_aststat classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_report00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
  
  ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

</script>


<script language="javascript" for="gcds_code02" event="OnLoadStarted()">
	ft_cnt02.innerText="����Ÿ ��ȸ���Դϴ�.";
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row,colid)"> 
  ft_cnt02.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
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
	//document.all.LowerFrame.style.visibility="hidden";    
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

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
	ln_Ast3rd();
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>  

	if(row<1) return;
  if(colid=="CHK") return; 
	ln_Sub_Query(gcds_code01.namevalue(row,"ASTNBR"));

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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090026_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_print.gif"	  style="cursor:hand" onClick="ln_Print()">
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

    <td width="80px"   class="tab24"  bgcolor="#eeeeee" align=center>����</td>  
	  <td class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_aststat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<!-- <param name=CBData					value="^��ü,0^����,1^�Ű�,2^���,8^��ü,9^�̵�"> -->
				<param name=CBData					value="8^��ü,9^�̵�">
				<param name=CBDataColumns		value="Code, Parm">
				<param name=SearchColumn		value="Parm">
				<param name=Sort						value="false">
				<param name=ListExprFormat	value="Parm^0^120">
				<param name=BindColumn			value="Code">
				<param name=XPStyle         value=true>
			</OBJECT></comment><script>__ws__(__NSID__);</script> 			
		</td>

		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>��ü/�̵���</td>  
	  <td class="tab24"  >&nbsp;
		
			<comment id="__NSID__">
			<OBJECT id=gcem_movdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_movdt_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_movdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment			value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_movdt_to', 'Text')" style="position:relative;width:20px;left:1px;top:1px;cursor:hand;">		
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
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-1px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4(01)">
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
	 <tr> 
		<td width="80px"  class="tab27" bgcolor="#eeeeee" align=center>����(��)</td>
		<td width="320px" class="tab28" colspan =3 >&nbsp;
			<input id="txt_BBCOSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','01')">
			<input id=txt_BBCOSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>����(��)</td> 
		<td class="tab28" >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
</table>
<table><tr><td height="1px;"> </td></tr></table>


<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:221px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="20">
					<param name="Format"		value=" 
					<C> Name='����'			   ID=CHK     	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center   EditStyle=CheckBox </C>
					<C> Name='�ڻ��ȣ'		 ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center  edit=none Mask='XXX-XXXXX' </C>
					<C> Name='�ڻ��'			 ID=ASTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=left	  edit=none </C>
					<C> Name='�������'		 ID=ASAQSDAT	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center  edit=none Mask='XXXX/XX/XX' </C>
					<C> Name='���ݾ�'    ID=ASTAQAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right   edit=none </C>
					<C> Name='���μ�'		 ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120 	align=left	  edit=none </C>
					<C> Name='�����μ�'		 ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left    edit=none </C>
					<C> Name='����'			   ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left    edit=none </C>
					<C> Name='�����'		   ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none </C>
					<C> Name='����'		     ID=ASTSTAT  	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none EditStyle=Combo Data='0:����,1:�Ű�,2:���,8:��ü'</C>
					<C> Name='�̵�'		     ID=ASTGUBUN 	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none EditStyle=Combo Data='9:�̵�'</C>
					<C> Name='�ۼ���'		   ID=WRNM     	HeadAlign=Center HeadBgColor=#B9D4DC Width=55	  align=center  edit=none </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td><BR></td>
  </tr>
</table>

<table width="858px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr>
		<td> <font size="2" color="blue"> <b> [��ü/�̵� �󼼳���] </b> </font></td>
	</tr>
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			style="position:relative;left:0px;width:858px; height:150px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code02">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="ColSizing"		value="true">
					<param name=TitleHeight   value="30">
					<param name="Format"		  value=" 
					<C> Name='����'	    		   ID=CURROW   	HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=center  Value={CurRow} </C>
					<C> Name='�ڻ��ȣ'			   ID=ASTNBR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center  Mask='XXX-XXXXX' </C>
					<C> Name='�ڻ��'			       ID=ASTNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  </C>
					<C> Name='����' 			       ID=ASTGUBUN	HeadAlign=Center HeadBgColor=#B9D4DC Width=30  	align=left	  EditStyle=Combo Data='0:����,1:�Ű�,2:���,8:��ü,9:�̵�'</C>
					<C> Name='��ü/�̵�\\����'        ID=MOVDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=65  	align=center  EditStyle=Popup Mask='XXXX/XX/XX'</C>
					<C> Name='����'    			   ID=AFDCODE 	HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left	  EditStyle=Combo Data='02:����,03:�ݰ���,04:����'</C>
					<C> Name='���μ�'			   ID=AUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  </C>
					<C> Name='�����μ�'			   ID=AMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left    </C>
					<C> Name='����'			       ID=ACOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left    </C>
					<C> Name='�����' 		       ID=AUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=45	align=left    </C>
					<C> Name='���' 		           ID=MOVNOTE  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=left    </C>
					<C> Name='���μ�'			   ID=BUSEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left	 show=false </C>
					<C> Name='�����μ�'			   ID=BMNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left   show=false </C>
					<C> Name='����'			       ID=BCOSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left   show=false </C>
					<C> Name='�����'		           ID=BUSERNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=left   show=false </C>
					
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
  </tr>
  <tr>
		<td><BR></td>
  </tr>
</table>


<comment id="__NSID__"><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_report00">
	<param name="DetailDataID"      value="gcds_report1"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<param name=NullRecordFlag			value=false>
	<param name="SaveToFileShowButton"value="true">		
<!-- 	<param name="SaveToFileENV"     value='filename=c:\\temp;filetype=jpg;quality=100;bpp=8;ppf=0;pts=all;sizetype=resolution;width=400;height=300'> -->
	<PARAM NAME="Format" VALUE="
<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=170 ,face='Tahoma' ,size=10 ,penwidth=1
	<C>id='TITLE', left=29, top=5, right=2775, bottom=169, face='����', size=18, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=236 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2648 ,top=177 ,right=2648 ,bottom=225 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�����󰢿�' ,left=2529 ,top=175 ,right=2648 ,bottom=225 ,face='����' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ü��' ,left=2654 ,top=175 ,right=2778 ,bottom=225 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ASTGUBUN', left=40, top=56, right=151, bottom=103, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1326 ,top=114 ,right=1326 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�ڻ��' ,left=622 ,top=119 ,right=1323 ,bottom=169 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����μ�' ,left=1331 ,top=175 ,right=1738 ,bottom=225 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1511 ,top=119 ,right=1582 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=1331 ,top=119 ,right=1503 ,bottom=169 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=439 ,top=114 ,right=439 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='�Һз�' ,left=445 ,top=119 ,right=614 ,bottom=169 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ߺз�' ,left=257 ,top=119 ,right=439 ,bottom=169 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=352 ,top=175 ,right=439 ,bottom=225 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڻ�' ,left=257 ,top=175 ,right=344 ,bottom=225 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USRNAME', left=2569, top=11, right=2775, bottom=58, face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='USEDATE', left=2572, top=61, right=2775, bottom=108 ,mask='XXXX.XX.XX', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ۼ�����:' ,left=2402 ,top=61 ,right=2572 ,bottom=108 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �� :' ,left=2402 ,top=11 ,right=2572 ,bottom=58 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FDCODE', left=151, top=56, right=2212, bottom=103, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=2257 ,top=116 ,right=2257 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='���μ�' ,left=1749 ,top=175 ,right=2260 ,bottom=225 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=2265 ,top=175 ,right=2519 ,bottom=225 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2003 ,top=116 ,right=2003 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1585 ,top=114 ,right=1585 ,bottom=169 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1505 ,top=116 ,right=1505 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=347 ,top=175 ,right=347 ,bottom=230 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=616 ,top=114 ,right=616 ,bottom=169 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2521 ,top=116 ,right=2521 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1741 ,top=114 ,right=1741 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=251 ,top=116 ,right=251 ,bottom=233 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=37 ,top=233 ,right=2786 ,bottom=233 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='��������' ,left=2529 ,top=119 ,right=2778 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���󰢾�' ,left=2265 ,top=119 ,right=2519 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���⴩���' ,left=2008 ,top=119 ,right=2257 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ݾ�(��ȭ)' ,left=1749 ,top=119 ,right=1998 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���뿬��' ,left=1593 ,top=119 ,right=1738 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڻ��ȣ' ,left=82 ,top=175 ,right=251 ,bottom=225 ,face='����' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڻ��ȣ' ,left=82 ,top=119 ,right=251 ,bottom=169 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=114 ,right=2783 ,bottom=114 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=40 ,top=5 ,right=677 ,bottom=53 ,align='left', MargineX=3</T>
	<T>id='������(��==>��)' ,left=445 ,top=175 ,right=1323 ,bottom=225 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=79 ,top=119 ,right=79 ,bottom=235 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=79 ,top=169 ,right=2778 ,bottom=172 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='��' ,left=34 ,top=130 ,right=79 ,bottom=180 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=34 ,top=172 ,right=79 ,bottom=222 ,face='Arial' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=106 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=37 ,top=108 ,right=2783 ,bottom=106 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=82 ,top=50 ,right=2781 ,bottom=50 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=251 ,top=0 ,right=251 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=439 ,top=0 ,right=439 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1741 ,top=0 ,right=1741 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2521 ,top=0 ,right=2521 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=347 ,top=53 ,right=347 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=616 ,top=0 ,right=616 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1505 ,top=0 ,right=1505 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1588 ,top=3 ,right=1588 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2003 ,top=3 ,right=2003 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTNBR', left=82, top=0, right=251, bottom=48 ,mask='XXX-XXXXX'</C>
	<C>id='ASTYUSE', left=1593, top=0, right=1738, bottom=48</C>
	<C>id='ABDEPRAMT', left=2006, top=0, right=2254, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACDEPRAMT', left=2260, top=0, right=2514, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='S_ASTNBR', left=82, top=56, right=251, bottom=103 ,mask='XXX-XXXXX'</C>
	<C>id='ASTRMAMT', left=2529, top=0, right=2778, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BUSERNM', left=2260, top=56, right=2514, bottom=103</C>
	<C>id='BUSEDPTNM', left=1749, top=56, right=2257, bottom=103, align='left'</C>
	<L> left=2257 ,top=0 ,right=2257 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='GODDIVNM', left=257, top=56, right=344, bottom=103, align='left'</C>
	<C>id='ASAQSDIVNM', left=352, top=56, right=439, bottom=103, align='left'</C>
	<C>id='AST2NDNM', left=257, top=0, right=439, bottom=48, align='left'</C>
	<C>id='ASTQTY', left=1511, top=0, right=1582, bottom=48</C>
	<C>id='ASAQSDAT', left=1328, top=0, right=1505, bottom=48, align='left' ,mask='XXXX/XX/XX', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BMNGDPTNM', left=1331, top=56, right=1738, bottom=103, align='left'</C>
	<L> left=1326 ,top=0 ,right=1326 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2678 ,top=74 ,right=2678 ,bottom=87 </L>
	<C>id='LASTYM', left=2527, top=56, right=2635, bottom=103 ,mask='XXXX/XX'</C>
	<C>id='MOVDATE', left=2641, top=56, right=2781, bottom=103 ,mask='XXXX/XX/XX'</C>
	<L> left=2638 ,top=53 ,right=2638 ,bottom=101 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='ASTNM', left=622, top=0, right=1323, bottom=48, align='left', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AST3RDNM', left=445, top=0, right=614, bottom=48, align='left'</C>
	<C>id='BCOSTNM', left=445, top=56, right=1323, bottom=103, align='left'</C>
	<L> left=79 ,top=0 ,right=79 ,bottom=106 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=32, top=3, right=77, bottom=101, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ASTAQAMT', left=1749, top=0, right=1998, bottom=48, align='right', face='Tahoma', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1604 ,right=2871 ,bottom=2000 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=34 ,top=58 ,right=2781 ,bottom=238 ,border=true</X>
	<L> left=37 ,top=254 ,right=2783 ,bottom=254 </L>
	<I>id='../../common/img/icon.jpg' ,left=2294 ,top=265 ,right=2786 ,bottom=362</I>
	<T>id='����' ,left=1278 ,top=159 ,right=1371 ,bottom=209 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ҽ�' ,left=114 ,top=71 ,right=815 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1048 ,top=71 ,right=1386 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1394 ,top=58 ,right=1394 ,bottom=238 </L>
	<L> left=818 ,top=58 ,right=818 ,bottom=238 </L>
	<T>id='����' ,left=2201 ,top=71 ,right=2421 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2429 ,top=71 ,right=2768 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=2659 ,top=159 ,right=2752 ,bottom=209 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1405 ,top=58 ,right=1405 ,bottom=238 </L>
	<T>id='��' ,left=40 ,top=175 ,right=106 ,bottom=225 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=40 ,top=127 ,right=106 ,bottom=177 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=40 ,top=79 ,right=106 ,bottom=130 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1413 ,top=175 ,right=1479 ,bottom=225 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1413 ,top=127 ,right=1479 ,bottom=177 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1413 ,top=79 ,right=1479 ,bottom=130 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1484 ,top=58 ,right=1484 ,bottom=238 </L>
	<L> left=1045 ,top=58 ,right=1045 ,bottom=238 </L>
	<L> left=108 ,top=58 ,right=108 ,bottom=238 </L>
	<L> left=2196 ,top=58 ,right=2196 ,bottom=238 </L>
	<L> left=2424 ,top=58 ,right=2424 ,bottom=238 </L>
	<L> left=108 ,top=127 ,right=1394 ,bottom=127 </L>
	<L> left=1484 ,top=127 ,right=2778 ,bottom=127 </L>
	<L> left=37 ,top=5 ,right=2783 ,bottom=5 </L>
	<T>id='�Ҽ�' ,left=1487 ,top=71 ,right=2188 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1741 ,top=8 ,right=1741 ,bottom=58 </L>
	<S>id='{Sum(ASTRMAMT)}' ,left=2529 ,top=11 ,right=2778 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ACDEPRAMT)}' ,left=2260 ,top=11 ,right=2514 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ABDEPRAMT)}' ,left=2006 ,top=11 ,right=2254 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(ASTAQAMT)}' ,left=1749 ,top=11 ,right=1998 ,bottom=56 ,align='right' ,face='Tahoma' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=2521 ,top=5 ,right=2521 ,bottom=56 </L>
	<L> left=2257 ,top=8 ,right=2257 ,bottom=58 </L>
	<L> left=2000 ,top=8 ,right=2000 ,bottom=56 </L>
	<T>id='�հ�' ,left=1331 ,top=11 ,right=1738 ,bottom=56 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=820 ,top=71 ,right=1040 ,bottom=122 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

	">
</OBJECT></comment><script>__ws__(__NSID__);</script>	

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 