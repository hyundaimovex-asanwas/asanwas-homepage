<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �ջ����յ��
+ ���α׷� ID	:  Redu_popup.html
+ �� �� �� ��	:  �ջ����յ��
+ ��   ��  �� :  ������
+ �� �� �� �� :  2011.08.01
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
<title>�ջ����յ��</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_hisdat = gs_date;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	ln_Before();
}

/******************************************************************************
	Description : �� ��ȸ
******************************************************************************/
function ln_Before() {

	//�����ڵ�[�˻�]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();

	//�ڻ�з�[�˻�]
	gcds_asdivcod.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";
	gcds_asdivcod.Reset();

	gclx_fdcode.bindcolval = gs_fdcode;
}

/******************************************************************************
	Description : ��ȸ  
******************************************************************************/
function ln_Query(){ 

	var str1 = gclx_fdcode.BindColVal;              //�Ҽ�
	var str2 = gclx_asdivcod.BindColVal;            //�ڻ�з�
	var str3 = txt_COSTCD.value;	              	  //����
 
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>Redu_popup_s1"
									  + "?v_str1="+str1
									  + "&v_str2="+str2
									  + "&v_str3="+str3;
										
	gcds_code01.Reset(); 
}

/******************************************************************************
	Description : ���� (������ó��)
******************************************************************************/
function ln_Save(){

  if(confirm("�ջ����հ��� �����͸� �����Ͻðڽ��ϱ�?")){
		gctr_code01.KeyValue   =  "Account.Redu_popup_t1?(I:USER=gcds_code01)";
		gctr_code01.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>Redu_popup_t1?";
		gctr_code01.Parameters =  "v_str1="+gs_userid;
		//prompt('',gcds_code01.text);
		gctr_code01.post();
	}
}

/******************************************************************************
	Description : ���� �˾�
	Parameter   : srow - grid�� row, strgb - 01: grid,  02:�˻�����
******************************************************************************/
function ln_Popup4(srow,strgb){

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


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- ���� -->
<OBJECT id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- �ڻ�з� -->
<OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="Redu_popup_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	ft_cnt01.innerText = "��ȸ�Ǽ� : " + row + " ��";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("�˻��� �����Ͱ� �����ϴ�.");
</script>

<!-- �ҼӺз� (�˻�)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
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
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  OnLoad="ln_Start()" >
<table width="860" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif">
			<img src="../img/redu_popup_head.gif">
		</td>
		<td width="325px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_save.gif"	     style="cursor:hand" onClick="ln_Save()">
			<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand" onClick="ln_Query()">
		</td>
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:1px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" class="tab35" align=center >����</td>
		<td width="150px" class="tab35" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_fdcode">
				<param name=CBDataColumns		value="FDCODE, FDNAME">
				<param name=SearchColumn		value=FDNAME>
				<param name=Sort				value=false>
				<param name=ListExprFormat		value="FDNAME^0^140">
				<param name=BindColumn			value="FDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px" class="tab35" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:1px;border-right-width:0px;border-top-width:1px;border-bottom-width:1px;"> �ڻ�з�
		</td>  
	  	<td class="tab35" width="150px" style="border:0 solid #708090;border-left-width:1px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
				<param name=ComboDataID			value="gcds_asdivcod">
				<param name=CBDataColumns		value="CDCODE,CDNAM">
				<param name=SearchColumn		value="CDNAM">
				<param name=Sort				    value=false>
				<param name=ListExprFormat	value="CDNAM^0^140">
				<param name=BindColumn			value="CDCODE">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
    <td class="tab21" style="height:30px;width:80px;" bgcolor="#eeeeee" align="center" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;">������</td> 
		<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:1px;border-bottom-width:1px;text-align;height:30px;font-family:����;font-size:9pt; " >&nbsp;    
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:160px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
		</td>
	</tr>
	<tr>
	</tr>
</table>
							
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:3px;width:280px;border:0 solid #708090;">
	<tr> 			
		<td style="width:280" ALIGN=LEFT VALIGN=TOP>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:310px; border:1 solid #708090;display:block;" viewastext>
				<param name="DataID"		value="gcds_code01">
				<param name="IndWidth"		value='0'>
				<param name="BorderStyle"	value="0">
				<param name="Fillarea"		value="true">
				<param name="Sortview"		value="left">
				<param name="ColSizing"		value="true">
				<param name="Editable"		value="true"> 
				<param name=TitleHeight     value="30">
				<param name="Format"		value=" 
					<C> Name='�ڻ��ȣ'		  ID=ASTNBR  	 HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center  edit=none </C>
					<C> Name='�ڻ��'			  ID=ASTNM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=120	  align=left	  edit=none </C>
					<C> Name='������'			  ID=COSTNM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=left	  edit=none </C> 
					<C> Name='�������'		  ID=ASAQSDAT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	edit=none Mask=XXXX-XX-XX</C>
					<C> Name='����\\���'		  ID=ASTYUSE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=35	  align=center	edit=none dec=2</C>
					<C> Name='���ݾ�'		  ID=ASTAQAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	  edit=none </C>
					<G> Name='�ջ����հ���'      HeadAlign=Center HeadBgColor=#B9D4DC
						<C> Name='��ȭ'	      ID=REDUAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	 </C>
						<C> Name='��ȭ'	      ID=FOREAMT     HeadAlign=Center HeadBgColor=#B9D4DC Width=100	  align=right	 </C>
						<C> Name='�߻����'	  ID=REDUYM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center Mask=XXXX-XX </C>
						<C> Name='��������'	  ID=REDUMM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=right </C>
					</G>
					">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
	  <tr>
		<td><BR>
				* �ջ����հ��� �ʵ常 �Է� �����մϴ�.<BR>
				* �ݰ����� ��� ��ȭ, ��ȭ ��� �Է��մϴ�. <BR>
				* �߻������ �ջ����ձݾ��� �߻��� ����� �Է��մϴ�. <BR>
				* ���������� �ջ��������� ���� ���� ������ ���������� �Է��մϴ�. <BR>
				* ���� �ڻ꿡 ���Ͽ� 2���̻� �ջ������� �߻��� ��� �����ݾ��� �Է�, �߻����, ���������� ������ �߻��� ������.
    </td>
  </tr>
</table>		

<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================================
-->
<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe> 


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
