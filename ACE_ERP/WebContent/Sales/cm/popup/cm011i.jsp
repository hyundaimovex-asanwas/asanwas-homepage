<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	������ȣ ����
+ ���α׷� ID	: cm011i.jsp
+ �� �� �� ��	: ��ȸ|���|����
+ �� �� �� ��	: �躴��
+ �� �� �� ��   : 2007.12.03
+ �� �� �� ��   : 2007.12.06
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<html>
<head> 
<jsp:include page="/Sales/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../Common/js/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
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
		ln_before();//����ȸ
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
//		fnInit();               //�ʱ�ȭ �Լ�
	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function fnInit(){
		//*****  ������ �ʱ�ȭ �Լ��� ���⿡..  ********
		cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
		window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.
		//window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		//window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		//window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	}

/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){
	//�ƹ��͵� ���� ������ �ҷ����� ���� �Ķ����(zzzzz) ����
	gcds_data01.DataID = "/services/servlet/sales.cm.cm011i_s01?"
											 + "v_str1=zzzzz";
	gcds_data01.Reset();
//

}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query() {
	gcds_data01.DataID = "/services/servlet/sales.cm.cm011i_s01?"
											 + "v_str1="+fn_trim(gcem_carnum.value);
//											 + "&v_str2="+fn_trim(gcem_cardnum.value);

	gcds_data01.Reset();
	}

	/******************************************************************************
		Description : �߰�
	******************************************************************************/
	function ln_Add(){
	  gcds_data02.addrow();

	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
//		ln_Query();
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
<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
<%=HDConstant.COMMENT_END%>

<comment id="__NSID__">

<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--
<object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="false"></object>
<!--��üũ--
<OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT><PARAM NAME="SyncLoad" VALUE="true"></OBJECT>
//-->
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
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/new.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
            <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
<!-- 			<img src="../../Sales/images/com_b_print.gif" style="cursor:hand" onclick="ln_Print()">
      <img src="../../Sales/images/com_b_excel.gif"	style="cursor:hand" onClick="ln_Excel()"> -->
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">������ȣ</td>
					<td class="tab_b0100" style='width:180px'>
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_carnum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
					<td class="tab_a0100">�����ȣ</td>
					<td class="tab_b0000">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_cardnum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
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
    <!-- <td colspan=2>  -->
    <td>
      <table width="415" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:405px;height:190px;" viewastext>
							<param name="DataID"				value="gcds_data01">
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
								<C> Name='����SID'		ID=CAR_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='������ȣ'		ID=CAR_NO		HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C> 
								<C> Name='�����ȣ'	  	ID=CAR_DNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=170	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:406px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:462px;'>
		    <tr>
					<td class="tab_a0101">������ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_no classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="####################">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">�����ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_dno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="####################">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">������ȣ</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_rno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
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
				  <td class="tab_a0101">��������</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_use_sdate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;					
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">��������</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:90px;">
						<comment id="__NSID__"><OBJECT id=gcem_use_edate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>&nbsp;	
					</td>		
				</tr>

		    <tr>

				  <td class="tab_a0101">ä������</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><object id=gcra_stay_ls classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="position:relative;left:4px;top:0px;height:24;width:200;cursor:hand;">
								<param name=Cols     value="3">
								<param name=CodeValue  value="0">
								<param name=Enable  value="False">
								<param name=Format   value="0^���,1^�ܱ�">
						</object></comment><script>__ws__(__NSID__);</script>					
					</td>		

				</tr>
				<tr>
				<td class="tab_b0000" style='height:50px' colspan=2>&nbsp;&nbsp;1:�ƻ�, 2:��ȭ, 3:Ǫ��, 7:��������, 8:���������(������������), <br>&nbsp;&nbsp; 9, 10, 11: ��õ��, �ݰ��� ȣ�� ����</td></tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__">
							<OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:200px;" viewastext>
							<param name="DataID"				value="gcds_data02">
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
								<F> Name='No.'							ID={CURROW} 		HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='����������ȣSID'		ID=CARNO_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='����SID'					ID=CAR_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='������ȣ'					ID=CAR_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='�����ȣ'				  	ID=CAR_DNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='������ȣ'					ID=CAR_RNO			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='��������'				ID=USE_SDATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='���������'				ID=USE_EDATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								<C> Name='�Ҽ�'							ID=VEND_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=120	align=center</C> 
								">
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:877px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_1>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CUST_SID   Ctrl=gcem_cust_sid	Param=text</C>
		<C>Col=VEND_NM    Ctrl=txt_vend_nm	  Param=value</C>
		<C>Col=OP         Ctrl=gcra_op	      Param=CodeValue</C>
		<C>Col=REC_PLAC   Ctrl=txt_rec_plac	  Param=value</C>
		<C>Col=TEL_NUM    Ctrl=txt_tel_num	  Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__">
<object  id=gcbn_data3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_2>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CT        Ctrl=gcra_ct	       Param=CodeValue</C>
		<C>Col=WORK_NO   Ctrl=txt_work_no	   Param=value</C>
		<C>Col=TEL_SID   Ctrl=txt_tel_sid	   Param=value</C>
		<C>Col=TEL_DATE  Ctrl=gcem_tel_date	 Param=text</C>
		<C>Col=TEL_STIME Ctrl=gcem_tel_stime Param=text</C>
		<C>Col=TEL_ETIME Ctrl=gcem_tel_etime Param=text</C>
		<C>Col=TEL_DURA  Ctrl=gcem_tel_dura	 Param=text</C>
		<C>Col=UP_SID    Ctrl=txt_up_sid	   Param=value</C>
		<C>Col=CAL_YN    Ctrl=gcra_cal_yn	   Param=CodeValue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!--------------------------------- �ڵ� �κ� �� --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

</body>
</html>