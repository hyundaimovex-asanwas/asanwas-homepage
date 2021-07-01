<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	: �繫ȸ����� - �����󰢰���		
+ ���α׷� ID	: A090002.html
+ �� �� �� ��	: ������ ��ȸ ȭ���̴�
+ ��   ��  �� : �� ����
+ �� �� �� �� : 
-----------------------------------------------------------------------------
+ �� �� �� �� : ������ ���ν��� ���� ( RPG ==> STORED PROCEDURE )  	   
+ ��   ��  �� : ������
+ �� �� �� �� : 2009.10.21
-----------------------------------------------------------------------------
+ �� �� �� ��	: A090002_s1
+ PROCEDURE 	: 
------------------------------------------------------------------------------>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>������</title>
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
	gcrd_gubun.codevalue=1;
 }

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	var str1 = gclx_fdcode.BindColVal;                //����
	var str2 = gclx_asdivcod.BindColVal;              //�ڻ�з�
	var str3 = gcem_jasan.text;                       //�ڻ��ڵ�
    var str4 = txt_jasan.value;                       //�ڻ��
	
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090022_s1"
									  + "?v_str1="+str1+"&v_str2="+str2
									  + "&v_str3="+str3+"&v_str4="+str4
										+ "&v_str5="+gclx_astdeprst.bindcolval
										+ "&v_str6="+gcrd_gubun.codevalue
										+ "&v_str7="+txt_COSTCD.value;
	gcds_code01.Reset();
}

/******************************************************************************
	Description : ������ó��
******************************************************************************/
function ln_Popup(){
	var row ="";
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var arrParam	= new Array();

	strURL = "./asetdep_popup_22.jsp";
	strPos = "dialogWidth:870px;dialogHeight:450px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
	
		gcds_code01.addrow();
		row = gcds_code01.rowposition;
		gcds_code01.namevalue(gcds_code01.rowposition,"HISDAT")=gs_date;
		arrParam = arrResult.split(";");
		//eval(e).value  = arrParam[0];
		gcds_code01.namevalue(row,"ASNBR") = arrParam[0]; 
		gcds_code01.namevalue(row,"ASNAM") = arrParam[1]; 
		gcds_code01.namevalue(row,"MUSREPAMT") = arrParam[2]; 
		gcds_code01.namevalue(row,"FSSTAT") = arrParam[3];

	} else {
		//eval(e).value = "";
		/*
		gcds_code01.namevalue(row,"ASNBR") = ""; 
		gcds_code01.namevalue(row,"ASNAM") = ""; 
		gcds_code01.namevalue(row,"MUSREPAMT") = "";
		gcds_code01.namevalue(row,"FSSTAT") = "";
		*/
	}
}

/******************************************************************************
	Description : ���̿�
******************************************************************************/
function ln_Popup2(){
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gclx_fdcode.bindcolval; //�����ڵ�
	arrParam[1] = gclx_fdcode.text;       //������

	strURL = "./astforward_popup.jsp";
	strPos = "dialogWidth:335px;dialogHeight:180px;dialogTop:320px;dialogLeft:400px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

/*
	if (arrResult != null) {
		//arrParam = arrResult.split(";"); 
		//txt_jasan.value = arrParam[1];  //�ڻ��
		//gcem_jasan.text = arrParam[0];  //�ڻ��ڵ�
	} else {
		//gcem_jasan.text = "";
		//txt_jasan.value = "";
	}
	*/
}


/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Finish(){
	var arrResult	= new Array();
	var arrParam	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gclx_fdcode.bindcolval; //�����ڵ�
	arrParam[1] = gclx_fdcode.text;       //������

	strURL = "./astfinish_popup.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:450px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

/*
	if (arrResult != null) {
		//arrParam = arrResult.split(";"); 
		//txt_jasan.value = arrParam[1];  //�ڻ��
		//gcem_jasan.text = arrParam[0];  //�ڻ��ڵ�
	} else {
		//gcem_jasan.text = "";
		//txt_jasan.value = "";
	}
	*/
}


/******************************************************************************
	Description : ������������ȸ
******************************************************************************/
/*
function ln_Popup2(){
	var row ="";
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	var arrParam	= new Array();

	strURL = "./Asetdep_popup2.jsp";
	strPos = "dialogWidth:900px;dialogHeight:490px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
}
*/

/******************************************************************************
	Description : �ڻ�� �˾�
******************************************************************************/
function ln_Popup3(e){

	if(e=='01'){           //�ڻ�� �˾�â
		var arrResult	= new Array();
		var arrParam	= new Array();
		var strURL;	
		var strPos;

        arrParam[0]=gclx_asdivcod.bindcolval;
		
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

/******************************************************************************
	Description : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("������","",2);
}

/******************************************************************************
	Description :  �ջ����� �ݾ� ����ϱ�
******************************************************************************/
function ln_Redu(){
	var row ="";
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var arrParam	= new Array();

	strURL = "./redu_popup.jsp";
	strPos = "dialogWidth:870px;dialogHeight:550px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
	
		gcds_code01.addrow();
		row = gcds_code01.rowposition;
		gcds_code01.namevalue(gcds_code01.rowposition,"HISDAT")=gs_date;
		arrParam = arrResult.split(";");
		
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_create classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_cancel classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<!-- ���� -->
<comment id="__NSID__"><object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script>

<!-- �ڻ�з� -->
<comment id="__NSID__"><object  id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

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

//	gcgd_disp01.Editable =true;

	if(gcds_code01.countrow<=0)
		alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<script language="javascript" for="gcds_create" event="OnLoadStarted()">
	window.status=" ������ ó�����Դϴ�. ";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_create" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  ������ó���� �Ϸ� �߽��ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	window.status="";
</script>

<script language="javascript" for="gcds_cancel" event="OnLoadStarted()">
	window.status=" ������ ������Դϴ�. ";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_cancel" event="onloadcompleted(row,colid)">
	ln_Query();
	window.status="  ��������Ҹ� �Ϸ� �߽��ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
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
	//document.all.LowerFrame.style.visibility="hidden";    
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="��ü";
	gclx_asdivcod.index=0;
</script>

<script language=JavaScript for=gcgd_disp01  event=OnDblClick(row,colid)>
	////document.all.LowerFrame.style.visibility="visible";
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	if(row<1) return;
	var arrResult	= new Array();
	var arrParam	= new Array();
	arrParam[0] = gcds_code01.NameValue(row,"ASTNUM");
	arrParam[1] = gcds_code01.NameValue(row,"LASTYM");
	arrParam[2] = gcrd_gubun.codevalue;
	var strURL = "./asetdep_popup23.jsp";
	var strPos = "dialogWidth:662px;dialogHeight:560px;dialogTop:180px;dialogLeft:250px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
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
</script>
</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a090002_head.gif">	</td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		  <img src="../../Common/img/btn/com_btn_redu.gif"	style="cursor:hand;" onclick="ln_Redu()"> 
		  <img src="../../Common/img/btn/com_b_excel.gif"	style="cursor:hand;" onclick="ln_Excel()"> 
		  <img src="../../Common/img/btn/com_b_finish.gif"  style="cursor:hand"  onclick="ln_Finish()">
		  <img src="../../Common/img/btn/com_b_eyuol.gif"   style="cursor:hand"  onclick="ln_Popup2()">
		  <img src="../../Common/img/btn/com_b_refundp.gif" style="cursor:hand"  onclick="ln_Popup()">
		  <img src="../../Common/img/btn/com_b_query.gif"	style="cursor:hand"  onclick="ln_Query()">
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
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-4px;cursor:hand"	 onclick="ln_Popup3(01)">
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
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >�󰢻���</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
			 <OBJECT id=gclx_astdeprst classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:100px;">
						<param name=CBData					value="^��ü,0^������,1^�Ϸ�">
						<param name=CBDataColumns		value="Code, Parm">
						<param name=SearchColumn		value="Parm">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="Parm^0^120">
						<param name=BindColumn			value="Code">
					</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 


		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center >����</td>
		<td width="120px" class="tab28"  >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:100">
					<param name=Cols	  value="2">
					<param name=Format	value="1^��ȭ,2^��ȭ">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 

		<td width="80px"  class="tab28"  bgcolor="#eeeeee" align=center> ������</td>  
	    <td class="tab28"  >&nbsp;
			<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:-1px; width:190px; height:20px;" class="txtbox" >			
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Popup4('','02')">
			<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;"  class="txtbox"  >
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
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		value='0'>
					<param name="BorderStyle"	value="0">
					<param name="Fillarea"		value="true">
					<param name="Sortview"		value="left">
					<param name="ColSizing"		value="true">
					<param name="Editable"		value="False"> 
					<param name=TitleHeight   value="30">
					<param name=ViewSummary   value="1">
					<param name="Format"		value=" 
					<C> Name='�ڻ��ȣ'			  ID=ASNBR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=53	  align=center BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='�ڻ��'				  ID=CDNAM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='��      ��'</C>
					<C> Name='������'				  ID=COSTNM			HeadAlign=Center HeadBgColor=#B9D4DC Width=125	align=left	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext=''</C>
					<C> Name='�������'			  ID=ASAQSDAT		HeadAlign=Center HeadBgColor=#B9D4DC Width=65	  align=center BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX/XX'</C>
					<C> Name='����\\���'		  ID=ASTYUSE		HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='' dec=2</C>
					<C> Name='���ݾ�'			  ID=ASTAQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='���⴩���'	    ID=ABDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='���󰢾�'	    ID=ACDEPRAMT	HeadAlign=Center HeadBgColor=#B9D4DC Width=77  	align=right	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='��⴩���\\(����+���)'  ID=ACDEPRSUM	HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='@sum'</C>
					<C> Name='��������'			  ID=ASTRMAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right	 BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='@sum' </C>
					<C> Name='����\\�󰢳��'	ID=LASTYM			HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='' Mask='XXXX/XX'</C>
					<C> Name='���\\����'	    ID=REGIGB			HeadAlign=Center HeadBgColor=#B9D4DC Width=27 	align=center BgColor={IF(ASTDEPRST='1','#FFCC66','FFFFFF')} SumBgColor=#C3D0DB sumtext='' </C>
					<C> Name='�ڻ��ȣ'			  ID=ASTNUM			HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right	show=false</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:310px; top:180px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
