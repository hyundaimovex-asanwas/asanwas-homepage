<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �ŷ�ó�ڵ�	
+ ���α׷� ID	:  gczm_vender_poopup22.jsp
+ �� �� �� ��	:  �ŷ�ó�ڵ� �˾�â
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :	��ü���� ����
+ ��   ��  �� : �� �� ��
+ �� �� �� �� : 2006.03.17
-----------------------------------------------------------------------------
+ �� �� �� �� :	���ݰ�꼭 ���԰ŷ�ó ��Ͻ� ����ڹ�ȣ �� �ֹι�ȣ�� �˻�
+ ��   ��  �� : �� �� ��
+ �� �� �� �� : 2017.05.25
-----------------------------------------------------------------------------
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>�ŷ�ó�ڵ���ȸ</title>
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
var parentGubun="";
var gs_strGubun =""; //��ǥ����
var g_param; //�ŷ�ó�ڵ�,��,����ڵ�Ϲ�ȣ
var g_strcomgb="" ; //��ü����

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
   //gcra_useyn.codevalue ="Y";
   gcra_regno_gb.codevalue="1";

	var strParam = new Array();
	strParam=window.dialogArguments;

	if(strParam[0]=="0020"){
        g_param = strParam[1];
		if(g_param!=""){
		    gcem_vend_id.text=g_param;
			ln_Query2();
		}
    }else if(strParam[0]=="VAT"){ //���Ը��� ����� �ŷ�ó
		g_strcomgb="T"; //���Ը��⿡���� ���̰�����ü�� ��ȸ ���� �ʰ� ��. 2009.04.23
    }else{
    
		if(strParam.length==0){

		}else if(strParam.length==1){
			gs_strGubun = strParam[0];
			ln_Query2();
		}else if(strParam.length==2) {
			gs_strGubun = strParam[0];
			gcem_vend_id.text=strParam[1];
			if(gcem_vend_id.text==""){
			}else{
				ln_Query2();
			}
		}
   }
	//��������
	//gcds_comcode01.DataID =  g_servlet+"/Account.vendcode_s1?v_str1=";
	//gcds_comcode01.Reset();

	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
/*
	gcds_code01.DataID =  g_servlet+"/Account.a010003_s0?v_str1="+txt_vend_cd.value+"&v_str2="+gcem_vend_id.text
	                                                 // +"&v_str3="+gclx_atdiv.Bindcolval+"&v_str4="+gs_strGubun; 
	//prompt("gcds_code01",gcds_code01.DataID);
	gcds_code01.Reset();
*/
}

/******************************************************************************
	Description : ��ǥ������ ��ȸ��. �ŷ�ó��/�ŷ�ó�ڵ�/����ڵ�Ϲ�ȣ�� ��ȸ����
******************************************************************************/
function ln_Query2(){
		
	if(gcra_regno_gb.codevalue=="1"){
		
		if(gcem_vend_id.text.length!=10){
			alert("����ڹ�ȣ�� 10�ڸ��� �ƴմϴ�. ��� �Է��Ͻʽÿ�.");
			return false;
		}
	}else if(gcra_regno_gb.codevalue=="2"){
		if(gcem_vend_id.text.length!=13){
			alert("�ֹι�ȣ��  13�ڸ��� �ƴմϴ�. ��� �Է��Ͻʽÿ�.");
			return false;
		}
	}		
		
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s7?v_str1="+gcem_vend_id.text+"&v_str2=Y&v_str3="+g_strcomgb;                           
	gcds_code01.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
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

}

/******************************************************************************
	Description : â�ݱ�
	parameter   : A - ����
******************************************************************************/
function ln_Close(p){
	if (p=="A") {
		var row = gcds_code01.rowposition;
		window.returnValue = gcds_code01.namevalue(row,"VEND_CD")  + ";" 
                           + gcds_code01.namevalue(row,"VEND_NM")  + ";"
						   + gcds_code01.namevalue(row,"VD_DIRECT") + ";"
						   + gcds_code01.namevalue(row,"BSNS_CND")  + ";"
						   + gcds_code01.namevalue(row,"BSNS_KND")  + ";"
						   + gcds_code01.namevalue(row,"VEND_ID")  + ";"
						   + gcds_code01.namevalue(row,"COCOMYN") + ";"
						   + gcds_code01.namevalue(row,"CREDGB");			
		window.close();
	} else {
		window.close();
	}
}

<%
/******************************************************************************
	Description : ä�ǰ��з� 
	parameter   : 
******************************************************************************/
%>
function  ln_Credgb_Alert(){
    var row = gcds_code01.rowposition;
	if(gcds_code01.namevalue(row,"CREDGB")=="1"||gcds_code01.namevalue(row,"CREDGB")=="2"){
		alert("[ä��(��)�з�] ��ü�Դϴ�. \n\n������ ���� �ٶ��ϴ�.");
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_comcode01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_comcode01" event="onloadCompleted(row,colid)">
	gcds_comcode01.insertrow(1);
	gcds_comcode01.namevalue(1,"VEND_CD") = "";
	gcds_comcode01.namevalue(1,"VEND_NM") = "��ü";
	gcds_comcode01.index=0;
</script>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">

	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if(gcds_code01.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
    ln_Credgb_Alert();
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
</script>


<script language=JavaScript for=gcra_regno_gb event=OnSelChange()>
	if(gcra_regno_gb.codevalue=="1"){
		gcem_vend_id.format ="000-00-00000";
	}else if(gcra_regno_gb.codevalue=="2"){	
		gcem_vend_id.format ="000000-0000000";
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:478px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">��Ϲ�ȣ</td>
		<td width="300px" style="border:0 solid #708090;height:25px" >
		  <comment id="__NSID__">
		    <object id=gcra_regno_gb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:180px;height:20px" >
				<param name=Cols		value="2">
				<param name=Format	    value="1^����ڹ�ȣ,2^�ֹι�ȣ">
		    </object>
		    
		    <object  id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:100px" onkeydown="if(event.keyCode==13) ln_Query2();">
				<param name=Text			value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=Format          value="000-00-00000">
				<param name=PromptChar	    value="_">
			</object>
		  </comment><script>__ws__(__NSID__);</script>
		</td>
		<td align="right"><img src="../../Common/img/btn/com_b_find.gif" alt="�ŷ�ó�ڵ带 �˻��մϴ�" style="position:relative;left:0px;top:0px;cursor:hand;" onclick="ln_Query2()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		      <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle"     VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
			  <PARAM NAME="Fillarea"		VALUE="true">
			  <PARAM NAME="ColSizing"		VALUE="true">
			  <param name="sortview"        value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=VEND_CD,		 Name=�ŷ�ó�ڵ�,          width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true    Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C>ID=VEND_NM,		 Name=�ŷ�ó��,			width=240,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true      Color={Decode(CREDGB,1,'red',2,'red','black')}</C>
					<C>ID=VEND_ID,		 Name='����ڹ�ȣ',	    width=120,	HeadBgColor=#B9D4DC, align=center,    mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')}, Edit=none sort=true  Color={Decode(CREDGB,1,'red',2,'red','black')} </C>
					<C>ID=VD_DIRECT,	 Name=��ǥ��,				width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=BSNS_CND,		 Name=����,				width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=BSNS_KND,		 Name=����,				width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=POST_NM,		 Name=�����ȣ,			width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,     sort = true show = true </C>
					<C>ID=ADDRESS1,		 Name=�ּ�1,				width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=ADDRESS2,		 Name=�ּ�2,				width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=COCOMYN,		 Name=��ü����,			width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true EditStyle=Combo Data='N:�Ϲݾ�ü,Y:���¾�ü,S:Ư�������ü,T:���̰�����ü,M:�鼼��ü'</C>
				">
	    </object></comment><script>__ws__(__NSID__);</script> 
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:478;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;" Frameborder="0" src="<%=dirPath%>/Purch/common/html/progress.htm" width="400px" height="146px"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 