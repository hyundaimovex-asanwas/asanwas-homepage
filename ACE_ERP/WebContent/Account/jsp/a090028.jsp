<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<!---------------------------------------------------------------------------
+ �� �� �� ��	: �繫ȸ����� - ��ü�󰢵��		
+ ���α׷� ID	: A090008.html
+ �� �� �� ��	: ��ü�� �ڻ��� ������������ ����ϴ� ȭ���̴�.
+ ��   ��  �� : ������
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� �� : 
+ ��   ��  �� : 
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090008_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>A090008</title>
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
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ڻ�з�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();
	gclx_fdcode.bindcolval = gs_fdcode;
	gclx_astdeprst.index=0;

  
 }

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){

  gcem_ASTYM.text="";
  gcem_ASTDAT.text="";
	
	var str1 = gclx_fdcode.BindColVal;                 //�Ҽ�
	var str2 = gclx_asdivcod.BindColVal;              //�ڻ�з�
	var str3 = gcem_jasan.text;                       //�ڻ��ڵ�
  var str4 = txt_jasan.value;                       //�ڻ��
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_s1"
									   + "?v_str1="+str1+"&v_str2="+str2
									   + "&v_str3="+str3+"&v_str4="+str4
										 + "&v_str5="+gclx_astdeprst.bindcolval
										 + "&v_str6="+txt_COSTCD_0.value;
	//prompt('',gcds_code01.DataID);
	gcds_code01.Reset();

	txt_COSTNM.value = "";
}

/******************************************************************************
	Description : ���� ���󰢳�� ã��
	              �ش��������� ������ �󰢳���� DISPLAY ����.
 ******************************************************************************/
function ln_Find_Astym(){
	gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_s2"
								 	   + "?v_str1="+gclx_fdcode.BindColVal;								   
	gcds_code02.Reset();
  gcem_ASTYM2.text = gcds_code02.namevalue(gcds_code02.rowposition,"ASTYM");
  gcem_ASTDAT.text = gs_date;
	gcem_PREVYM.text = gcds_code02.namevalue(gcds_code02.rowposition,"PREVYM");
}

/******************************************************************************
	Description : �ڻ�� �˾�
******************************************************************************/
function ln_Popup3(e){

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
	Description : �ݾװ��
******************************************************************************/
function ln_Calculation(){ 
  //��������
	gcem_ASTRMAMT.text=parseInt(gcem_ASTAQAMT.text)-parseInt(gcem_ABDEPRAMT.text)-parseInt(gcem_ACDEPRAMT.text);

  //�����󰢾� ( ��ü �� �� �������� �����ؼ� �� �����󰢿� ���� )  
  gcem_ASTAMT.text=parseInt(gcem_ABDEPRAMT.text)+parseInt(gcem_ACDEPRAMT.text); 

  //��ȭ ����
	if(gclx_fdcode.bindcolval=="03"){ // �ݰ��� ) 
		//��ȭ �������� 
		gcem_FORMAMT.text=parseInt(gcem_ASTAQAMTY.text)-parseInt(gcem_FOBDAMT.text)-parseInt(gcem_FOCDAMT.text);
		//��ȭ �����󰢾� ( ��ü �� �� �������� �����ؼ� �� �����󰢿� ���� )  
		gcem_FOATAMT.text=parseInt(gcem_FOBDAMT.text)+parseInt(gcem_FOCDAMT.text); 
	}
}


/******************************************************************************
	Description : ���� 
******************************************************************************/
function ln_Save(){

  if(!ln_Chk_Save()) return; 

  gcds_code01.namevalue(gcds_code01.rowposition,"DEPRENDDT") = gcem_ASTYM.text+"01";  

	if(gcds_code01.namevalue(gcds_code01.rowposition,"CHK")=="T"){
		if(confirm("������ ��ü ��� �Ͻðڽ��ϱ�?")){
			gctr_code01.KeyValue   =  "Account.a090028_t1(I:USER=gcds_code01)";
			gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090028_t1?";
			gctr_code01.Parameters =  "v_str1="+gcem_ASTYM.text+",v_str2="+gcem_ASTDAT.text+",v_str3="+gcem_PREVYM.text;
			//prompt('',gcds_code01.text);
			gctr_code01.post();
		}
	}
}

/******************************************************************************
	Description : ����� üũ
******************************************************************************/
function ln_Chk_Save(){

	if(gcds_code01.namevalue(gcds_code01.rowposition,"LASTYM")!=""){
		alert("�̹� ������ ��� ���Դϴ�. ��ü�󰢵�� �� �� �����ϴ�.");
		return false;
	}

	if(gcem_ASTAMT.text==""||gcem_ASTAMT.text==0){
		alert("���⴩��� �Ǵ� ���󰢾��� �ݵ�� �ԷµǾ�� �մϴ�.");
    return false;
	}

	//�ݾ��� ������ ��� ���� �� ��.
  if(gcem_ABDEPRAMT.text==""){
		alert("���⴩��׿� ���ڸ� �Է��Ͻʽÿ�.");
		return false
	}

	if(gcem_ACDEPRAMT.text==""){
		alert("���󰢾׿� ���ڸ� �Է��Ͻʽÿ�.");
		return false	
	}

  //�ݾ��� ������ ��� ���� �� ��.
  if(gcem_ASTYM.text==""){
		alert("�󰢳���� Ȯ���Ͻʽÿ�.");
		return false;
	}

  if(gcem_ASTYM.text==""){
		alert("�󰢳���� Ȯ���Ͻʽÿ�.");
		return false;
	}

  //��ü���󰢳�� ����üũ
	var strym = gcem_ASTYM.text;
	if(strym.length<6){
		alert("�󰢳���� Ȯ���Ͻʽÿ�.");
		return false;
	}


  //��������� ��ü����� ũ���մϴ�.	

	if(gcem_ASAQSDAT.text.substring(0,6)>=gcem_ASTYM.text){
		alert("������ ��ü�� �󰢿��� Ȯ���Ͻʽÿ�.");
		return false;
	}
	

    // 2013.06.17.jys
	//���������� 0 ���� ũ���Ѵ�.
   // if(gcem_ASTRMAMT.text<=0){
   //		alert("���������� 0���� ũ���մϴ�.");
	//	return false;
	//}

	

  //��ü�� �����ڵ� üũ
  if(txt_COSTCD.value==""){
		alert("��ü�� �����ڵ�� �ʼ��׸��Դϴ�.");
		return false;
	}

	//�����

  ////////////////////////////////////////////////////////////////////////////
	//��ȭ üũ
	if(gclx_fdcode.bindcolval=="03"){ // �ݰ��� ��� ) 
			if(gcem_FOATAMT.text==""||gcem_FOATAMT.text==0){  
				alert("��ȭ ���⴩��� �Ǵ� ��ȭ ���󰢾��� �ݵ�� �ԷµǾ�� �մϴ�.");
				return false;
			}

			//�ݾ��� ������ ��� ���� �� ��.
			if(gcem_FOBDAMT.text==""){
				alert("��ȭ ���⴩��׿� ���ڸ� �Է��Ͻʽÿ�.");
				return false
			}

			if(gcem_FOCDAMT.text==""){
				alert("��ȭ ���󰢾׿� ���ڸ� �Է��Ͻʽÿ�.");
				return false	
			}

			//���������� 0 ���� ũ���Ѵ�.
		if(gcem_FORMAMT.text<=0){
			alert("��ȭ ���������� 0���� ũ���մϴ�.");
			return false;
		}
	}
  //////////////////////////////////////////////////////////////////////////


	for(i=1;i<=gcds_code01.countrow;i++){
		if(gcds_code01.namevalue(i,"CHK")!="T"){
				gcds_code01.Undo(i);
		}
	} 


	return true;
}

/******************************************************************************
	Description : ���� �˾�
	Parameter   : srow - , strgb - 01: �Է�,  02:�˻�����
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

  if(strgb=="00"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_COSTCD_0.value = ln_Trim(arrParam[0]);
			txt_COSTNM_0.value = ln_Trim(arrParam[1]); 
		}else{
			txt_COSTCD_0.value = "";	
			txt_COSTNM_0.value = "";
		}
	}else if(strgb=="01"){
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
	Description : �������ÿ� ���� ��ȭ�Է¶� Lock ���� ( �ݰ��� �Է°��� ) 
	Parameter   : 
******************************************************************************/
function ln_Amt_Enable(){
	if(gclx_fdcode.bindcolval!="03"){//�ݰ����� �ƴҰ�� 
	  if(gcem_ASTAQAMTY.text==""){
			 gcem_FOBDAMT.text="";
		   gcem_FOCDAMT.text="";
		}else{
			gcem_FOBDAMT.text=0;
			gcem_FOCDAMT.text=0;
			 //��ȭ �������� 
			gcem_FORMAMT.text=parseInt(gcem_ASTAQAMTY.text)-parseInt(gcem_FOBDAMT.text)-parseInt(gcem_FOCDAMT.text);
			//��ȭ �����󰢾� ( ��ü �� �� �������� �����ؼ� �� �����󰢿� ���� )  
			gcem_FOATAMT.text=parseInt(gcem_FOBDAMT.text)+parseInt(gcem_FOCDAMT.text); 
		}
		gcem_FOBDAMT.ReadOnly="true";
		gcem_FOBDAMT.ReadOnlyBackColor="#ccffcc";
    gcem_FOCDAMT.ReadOnly="true";
		gcem_FOCDAMT.ReadOnlyBackColor="#ccffcc";
	}else{
		gcem_FOBDAMT.ReadOnly="false";
    gcem_FOCDAMT.ReadOnly="false";
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
</comment><script>__ws__(__NSID__);</script>

<!-- ���� -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �ڻ�з� -->
<comment id="__NSID__"><object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

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

	if(gcds_code01.countrow<=0)	alert("��ȸ�� ����Ÿ�� �����ϴ�.");
  else {
		ln_Calculation();
    ln_Find_Astym();
  }
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

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>
	//document.all.LowerFrame.style.visibility="visible";
  
  return;
  /**
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	if(row<1) return;
	var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_code01.NameValue(row,"ASTNUM");
	arrParam[1] = gcds_code01.NameValue(row,"LASTYM");
	var strURL = "./Asetdep_popup2.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	**/
</script>

<script language=JavaScript for=gcds_code01 event=onColumnChanged(row,colid)>
	ln_Calculation();
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
  ln_Calculation();

	if(colid=="CHK"){
    if(gcds_code01.namevalue(row,"CHK")=="T"){
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_code01.countrow ;i++){
				gcds_code01.namevalue(i,"CHK")="F";
			}
			gcds_code01.namevalue(row,"CHK")="T";
    }
		
	}

</script>


<script language="javascript" for="gclx_fdcode" event="OnSelChange2()">
  ln_Amt_Enable();
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->

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
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090008_head.gif">	</td>
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
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> �ڻ�з�</td>  
	  <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=ListExprFormat	value="CDNAM^0^120">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>�ڻ��</td> 
		<td class="tab24" >&nbsp;
			<input id="txt_jasan" type="text" class="txtbox"  style= "width:190px;height:20px;position:relative;left:-2px;top:-2px;" MaxLength=30>
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup3(01)">
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
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >��ϻ���</td>
		<td width="180px" class="tab28"  colspan=3 >&nbsp;
			<comment id="__NSID__">
			 <OBJECT id=gclx_astdeprst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:108px;">
						<param name=CBData					value="1^��ü�󰢹̵��,2^��ü�󰢵��">
						<param name=CBDataColumns		value="Code, Parm">
						<param name=SearchColumn		value="Parm">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="Parm^0^110">
						<param name=BindColumn			value="Code">
					</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> ������</td>  
	  <td class="tab28"  >&nbsp;
			<input id="txt_COSTNM_0" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','00')">
			<input id=txt_COSTCD_0   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>

		<!-- <td width="80px"  class="tab28" bgcolor="#eeeeee" align=center > �ڻ�з�</td>  
	  <td width="120px" class="tab28" >&nbsp;
		</td>
		<td width="80px;"  class="tab28" bgcolor="#eeeeee" align=center >�ڻ��</td> 
		<td class="tab28" >&nbsp;
		</td> -->

	</tr>
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:538px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="true"> 
					<param name=TitleHeight   value="30">
					<param name="Format"		value=" 
					<FC>Name='����'	          ID=CHK   	    HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center	EditStyle=CheckBox  </FC> 
					<FC>Name='�ڻ��ȣ'			  ID=ASTNBR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  edit=none  BgColor=#CCFFCC </FC>
					<FC> Name='�ڻ��'			  ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left	  edit=none  BgColor=#CCFFCC </FC>
					<C> Name='������'				  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left	  edit=none  BgColor=#CCFFCC </C>
					<C> Name='�������'			  ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center  edit=none  BgColor=#CCFFCC Mask='XXXX/XX/XX'</C>
					<C> Name='����\\���'		  ID=ASTYUSE		HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center  edit=none  BgColor=#CCFFCC </C>
					<C> Name='���ݾ�'			  ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	  edit=none  BgColor=#CCFFCC </C>
					<C> Name='���⴩���'	    ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	 </C>
					<C> Name='���󰢾�'	    ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=77  	align=right	 </C>
					<C> Name='��⴩���\\(����+���)' ID=ACDEPRSUM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	 edit=none </C>
					<C> Name='��������'			  ID=ASTRMAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	  edit=none </C>
					<C> Name='�ڻ��ȣ'			  ID=ASTNUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right	show=false</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:540px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>

    <td width="320px">
			<table cellpadding="0" cellspacing="0" border="0" style="width:317px;height:370px;position:relative;left:3px;top:0px;border:1 solid #708090;">
				<tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >�ڻ��ȣ</td>
					<td class="tab22" colspan=3  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTNBR classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
            <param name=Alignment	  	value=0>
						<param name=Border	      value=true>
            <param name=Format			  value="########">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">		
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				<tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >�ڻ��</td>
					<td class="tab22" colspan=3>
					 <comment id="__NSID__">
          	<OBJECT id=gcem_CDNAM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:240px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=GeneralEdit   value="true">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
        <tr>
					<td width="70px" height="25px" class="tab28"  bgcolor="#eeeeee" align=center >�������</td>
					<td width="115px" class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASAQSDAT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td width="49px" height="25px" class="tab27"  bgcolor="#eeeeee" align=center >����<BR>���</td>
					<td width="75px" class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTYUSE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
        
				<tr>
					<td height="25px" class="tab28"  bgcolor="#eeeeee" align=center >���ݾ�</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAQAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px" class="tab27"  bgcolor="#eeeeee" align=center >��ȭ($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAQAMTY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=9>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				 
        <tr>
					<td height="25px" class="tab28"  bgcolor="#eeeeee" align=center >���⴩���</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ABDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px" class="tab27"  bgcolor="#eeeeee" align=center >��ȭ($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOBDAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="0,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				
				<tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >���󰢾�</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ACDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >��ȭ($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOCDAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				 <tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >��������</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >��ȭ($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FOATAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >��������</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_ASTRMAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="25px"   class="tab27" bgcolor="#eeeeee"  align=center >��ȭ($)</td>
					<td class="tab22" ><comment id="__NSID__">
          	<OBJECT id=gcem_FORMAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=11>
						<param name=IsComma	      value=true>
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">	
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					 </td>
				 </tr>
				
        <tr>
					<td height="30px"   class="tab28" bgcolor="#eeeeee"  align=center >��ü��<BR>�󰢳��</td>
					<td class="tab22"  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTYM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=Format	      value="YYYY/MM">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
					<td height="30px"   class="tab27" bgcolor="#eeeeee"  align=center >����<BR>�󰢳��</td>
					<td class="tab22"  >
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTYM2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
            <param name=Format	      value="YYYY/MM">
						<param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
		
         <tr>
					<td height="25px"   class="tab28" bgcolor="#eeeeee"  align=center >ó������</td>
					<td class="tab22" colspan=3>
					 <comment id="__NSID__">
          	<OBJECT id=gcem_ASTDAT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
						<param name=Text          value="">
						<param name=Alignment	    value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
            <param name=ReadOnly      value="true">
					  <param name=ReadOnlyBackColor   value="#ccffcc">
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
					</td>
				</tr> 
				<tr>
					<td height="50px"   class="tab28" bgcolor="#eeeeee"  align=center  >��ü��<BR>�����ڵ�</td>
					<td class="tab22" colspan=3> 
						<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:1px;width:50px; height:20px;"  class="txtbox"  >
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup2('','01')">
						<input id="txt_COSTNM" type="text"  style= "position:relative;top:-2px;left:1px;width:130px;height:20px;" class="txtbox" >			
					</td>
				</tr>
				<tr>
					<td>
						<td width="70px" style="height:100%;border:0 solid #708090;" colspan=4 >&nbsp;
						<comment id="__NSID__">
							<OBJECT id=gcem_PREVYM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20;position:relative;top:1px;left:2;" >
							<param name=Text          value="">
							<param name=Alignment	    value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
							<param name=Visible       value="false">
						 </OBJECT>
						 </comment><script>__ws__(__NSID__);</script>
				 </td>
				</tr> 
			</table> 
    </td>
	</tr>
  <tr>
		<td colspan=2><BR>
		              * ��ϻ��°� ��ü�󰢹̵�� �ϰ�� ��ü�� �󰢳���� ��ü �� ���� ������ ó������ �Է��մϴ�.<BR>
									* ��ϻ��°� ��ü�󰢹̵�� �ϰ�� ���⴩��� �Ǵ� ���󰢾�, ��ü�� �󰢳���� �Է��ؾ��մϴ�.<BR>
		              * ��ϻ��°� ��ü�󰢵��   �ϰ�� �󰢳���� ���� ������ ó�����Դϴ�. <BR>
                  * ó�����ڴ� ���� �����Դϴ�. <BR>
									* �ݵ�� ������ üũ�ϰ� �����ؾ� �մϴ�.
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
		<C>Col=ACOSTCD    Ctrl=txt_COSTCD       Param=value</C>
		<C>Col=ASTAQAMTY  Ctrl=gcem_ASTAQAMTY   Param=text </C>
		<C>Col=FOBDAMT    Ctrl=gcem_FOBDAMT     Param=text </C>
		<C>Col=FOCDAMT    Ctrl=gcem_FOCDAMT     Param=text </C>
    <C>Col=FORMAMT    Ctrl=gcem_FORMAMT     Param=text </C>
    <C>Col=FOATAMT    Ctrl=gcem_FOATAMT     Param=text </C>
	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 