<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�����ڷ���
+ ���α׷� ID	: AC01070.HTML
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: AC01070_S01,AC01070_S11,AC01070_T01
------------------------------------------------------------------------------>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/css/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/js/intro.js"></script>

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
  var gs_date = gn_Replace(gcurdate,"/");

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
		fnInit();               //�ʱ�ȭ �Լ�
	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function fnInit(){
    alert("�غ�����ȭ���Դϴ�.");
		//*****  ������ �ʱ�ȭ �Լ��� ���⿡..  ********
		//cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
		//window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.
		//window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		//window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query() {

	}

	/******************************************************************************
		Description : �߰�
	******************************************************************************/
	function ln_Add(){
	  gcds_data.addrow();

	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		ln_Query();
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Delete(){

	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Excel(){
	}

	/******************************************************************************
		Description : �μ�����
	******************************************************************************/
	function ln_SrhBuse(){

	}

	/******************************************************************************
		Description : �Է°� üũ
	******************************************************************************/
	function ln_Valchk(){

	}
	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- master data -->
<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--��üũ-->
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 


<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gn_LoadComp('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
</script>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
 		  <img src="../../Sales/images/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">
			<!-- <img src="../../Sales/images/com_b_insert.gif"	style="cursor:hand" onClick="ln_Add()"> -->
			<!-- <img src="../../Sales/images/com_b_save.gif"		style="cursor:hand"	onclick="ln_Save()"> -->
			<img src="../../Sales/images/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()">
			<!-- <img src="../../Sales/images/com_b_print.gif" style="cursor:hand" onclick="ln_Print()"> -->
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0101">��ǰ</td>
					<td class="tab_b0101">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0101">��¼���</td>
					<td class="tab_b0101">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0101">����</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>		
					</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">������</td>
					<td class="tab_b0100">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">����</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_ classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td colspan=2>
      <table width="395" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:390px;" viewastext>
							<param name="DataID"				value="gcds_data">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='�Ҽ�ȸ��'		  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center</C> 
								<C> Name='�İ�ȸ��'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='��'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center</C> 
								<C> Name='����ڹ�ȣ'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='����'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center</C> 
								<C> Name='�ֹ�/���ǹ�ȣ'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=90	align=center</C> 
								<C> Name='�����'	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center</C> 
								<C> Name='�ð�'	  	ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center</C> 
								<C> Name='���Ϳ�����'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center</C> 
								<C> Name='�ð�'	  ID=			HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

</body>
</html>