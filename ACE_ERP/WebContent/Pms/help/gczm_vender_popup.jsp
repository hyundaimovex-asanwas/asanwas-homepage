<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ �� �� �� ��	:  �繫ȸ����� - �ŷ�ó�ڵ�	
+ ���α׷� ID	:  Gczm_vender_poopup.html
+ �� �� �� ��	:  �ŷ�ó�ڵ� �˾�â
+ ��   ��  �� :  
+ �� �� �� �� :  
-----------------------------------------------------------------------------
+ �� �� �� �� :	��ü���� ����
+ ��   ��  �� : �� �� ��
+ �� �� �� �� : 2006.03.17
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
   gcra_useyn.codevalue ="Y";

	var strParam = new Array();
	strParam=window.dialogArguments;

	if(strParam[0]=="0020"){
    g_param = strParam[1];
		if(g_param!=""){
		  gcem_vendnm.text=g_param;
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
			gcem_vendnm.text=strParam[1];
			if(gcem_vendnm.text==""){
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
	gcds_code01.DataID =  g_servlet+"/Account.a010003_s0?v_str1="+txt_vend_cd.value+"&v_str2="+gcem_vendnm.text
	                                                 // +"&v_str3="+gclx_atdiv.Bindcolval+"&v_str4="+gs_strGubun; 
	//prompt("gcds_code01",gcds_code01.DataID);
	gcds_code01.Reset();
*/
}

/******************************************************************************
	Description : ��ǥ������ ��ȸ��. �ŷ�ó��/�ŷ�ó�ڵ�/����ڵ�Ϲ�ȣ�� ��ȸ����
******************************************************************************/
function ln_Query2(){
	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s7?v_str1="+gcem_vendnm.text+"&v_str2="+gcra_useyn.codevalue+"&v_str3="+g_strcomgb;                           
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
											 + gcds_code01.namevalue(row,"VEND_ID");
		window.close();
	} else {
		window.close();
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
	ln_Close('A');
</script>

<script language=JavaScript for="gcgd_disp" event=OnKeyPress(kcode)>
	if (kcode==13) ln_Close('A');
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
		<td class="tab12" width="65px;" bgcolor="#eeeeee" align="center">�˻�����</td>
		<td width="165px" style="border:0 solid #708090;height:25px"><comment id="__NSID__">
			<object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:160px" onkeydown="if(event.keyCode==13) ln_Query2();">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value=true>
				<param name=GeneralEdit value="true">
				<param name=PromptChar	value="_">
			</object></comment><script>__ws__(__NSID__);</script>
		</td>
		<td colspan =2 >&nbsp;
			<comment id="__NSID__">
			<object id=gcra_useyn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0	style="position:relative;left:0px;top:2px;width:170px;height:20px;">
				<param name=Cols		value="3">
				<param name=Format	value="Y^���,N^�̻��,^��ü">
			</object></comment><script>__ws__(__NSID__);</script> 
		</td> 
		<!-- <td class="tab12" width="70px;" bgcolor="#eeeeee">�ŷ�ó�ڵ�</td>
		<td width="60px"><input type="text" class="txt11" id="txt_vend_cd" style="position:relative;left:5px;width:70px;" onkeydown="if(event.keyCode==13) ln_Query();"  maxlength="13"></td> -->
		<!-- <td class="tab16" width="40px;" bgcolor="#eeeeee" align="center">����</td>
		<td>
			<comment id="__NSID__"><object  id=gclx_atdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:3px;top:1px;font-size:12px;width:60px;">
						<param name=ComboDataID     value="gcds_comcode01">
						<param name=SearchColumn		value=CDNAM>
						<param name=Sort						value=false>
						<param name=ListExprFormat	value="CDNAM^0^65">
						<param name=BindColumn			value=CDCODE>
			</object></comment><script>__ws__(__NSID__);</script> 
		</td> -->
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="�ŷ�ó�ڵ带 �˻��մϴ�" style="position:relative;left:0px;top:0px;cursor:hand;" onclick="ln_Query2()"></td>
	</tr>
	
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:476;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		    <PARAM NAME="DataID"			VALUE="gcds_code01">
			  <PARAM NAME="BorderStyle" VALUE="0">
			  <PARAM NAME="Indwidth"		VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="ColSizing"		VALUE="true">
				<param name="sortview"    value=left>
			  <PARAM NAME="Format"			VALUE="  
					<C>ID=VEND_CD,		 Name=�ŷ�ó�ڵ�,   width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true</C>
					<C>ID=VEND_NM,		 Name=�ŷ�ó��,			width=240,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left, sort = true</C>
					<C>ID=VEND_ID,		 Name='����ڹ�ȣ',	width=120,	HeadBgColor=#B9D4DC, align=center,   mask='XXX-XX-XXXXX',Edit=none sort=true</C>
					<C>ID=VD_DIRECT,	 Name=��ǥ��,				width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=BSNS_CND,		 Name=����,					width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=BSNS_KND,		 Name=����,					width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=POST_NM,		 Name=������ȣ,			width=80,	  HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true show = true </C>
					<C>ID=ADDRESS1,		 Name=�ּ�1,				width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
					<C>ID=ADDRESS2,		 Name=�ּ�2,				width=130,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,		sort = true show = true </C>
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

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:100px; top:130px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 