<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	������������
+ ���α׷� ID	: bm010i.jsp
+ �� �� �� ��	: ��ȸ|���|����|����
+ �� �� �� ��	: �� �� ��
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
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
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query(){
			var sdata = "/services/servlet/sales.bm.bm011s_s01"
								+ "?v_str1=" + gcem_vend_id.text  //ȸ���
								+ "&v_str2=" + gcem_regi_no_fr.text  //�ֹ�/���ǹ�ȣ
								+ "&v_str3=" + txt_cust_nm_fr.value; //����
			gcds_data.DataID = sdata; 
			gcds_data.Reset();
	}


	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Excel(){
			if (gcds_data.countrow<1) alert(gn_Msg(4));
			else gn_Excel(gcgd_disp,"����������ȸ","","");
	}

	/******************************************************************************
		Description : ��¹�
	******************************************************************************/
	function ln_Print(){
       alert("�غ����Դϴ�.");
	}

	/******************************************************************************
		Description : �Ҽӻ�
	******************************************************************************/
	function ln_SrhCust(){
			var strURL   = "../common/html/Company_pop.html";
			var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
			var arrResult = showModalDialog(strURL,window,strPos);

			if (arrResult == -1 || arrResult == null || arrResult == "") return;
			var firstList = arrResult.split(";");
			gcem_vend_id.text = firstList[0];
			gcem_vend_nm_fr.text = firstList[1];
	}
	</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>


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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="ln_Excel()">
			<img src="/services/Sales/images/print.gif"	style="cursor:hand" align=absmiddle onclick="ln_Print()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">ȸ&nbsp;��&nbsp;��</td>
					<td class="tab_b0100" style='width:150px'>
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:90px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=Enable        value=false>
								<param name=GeneralEdit   value="true">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<comment id="__NSID__"><OBJECT id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:0px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="">
								<param name=PromptChar	  value="">
								<param name=Visible        value=false>
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					  <img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhCust();">
					</td>	
					<td class="tab_a0100">�ֹ�/���ǹ�ȣ</td>
					<td class="tab_b0100"  style='width:160px'>
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_regi_no_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:97px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="">
								<param name=MaxLength   value="13">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>					
					</td>	
					<td class="tab_a0100">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0000">
				    <input id="txt_cust_nm_fr" type="text" class="txt_a01"  style="width:80px;" maxlength="29">	
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
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:875px;height:430px;" viewastext>
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
								<F> Name='No.'				  ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30	 align=center</F>
								<C> Name='�Ҽ�ȸ���ڵ�'	ID=VEND_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center </C> 
								<C> Name='�Ҽ�ȸ��'	  	ID=VEND_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='���ڵ�'	  	  ID=TEAM_CD		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center show=false</C> 
								<C> Name='��'	  	      ID=DETAIL_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='����ڹ�ȣ'	  ID=WORK_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	 align=center</C> 
								<C> Name='����'	        ID=CUST_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=65	 align=center</C> 
								<C> Name='�ֹ�/���ǹ�ȣ' ID=REGI_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=100 align=center</C> 
								<C> Name='������ȭ'	    ID=TEL_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	 align=center</C> 
								<C> Name='�����ȭ'	  	ID=MOBILE_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	 align=center</C> 
								<C> Name='����'	        ID=POSITIONS	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center</C> 
								<C> Name='�ּ�1'	      ID=ADDRESS1		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=right show=false</C> 
								<C> Name='�ּ�2'	      ID=ADDRESS2		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=right show=false</C> 
								<C> Name='�ּ�'	        ID=ADDRESS		HeadAlign=Center HeadBgColor=#EEEEEE Width=150 align=right</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
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

