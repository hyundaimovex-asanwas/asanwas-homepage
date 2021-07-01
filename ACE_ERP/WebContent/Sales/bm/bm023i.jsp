<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                              
<%    String dirPath = request.getContextPath(); //HDASan. ContextPath �� ��Ÿ ���� ����. %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	ü�� ����
+ ���α׷� ID	: bm023i.jsp
+ �� �� �� ��	: bm023i_s01,bm023i_t01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<Script language="javascript" src="../common/include/PubFun.js">
    <link rel="stylesheet" href="../common/include/common.css">
</script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");
	var gdataset = "";

	/******************************************************************************
		Description : ������ �ε�
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	
		ln_Before();            
	}

	/******************************************************************************
		Description : ����ȸ
	******************************************************************************/
	function ln_Before(){
		gcem_acdate_fr.text = gs_date;
	}

	/******************************************************************************
		Description : ��ȸ
	******************************************************************************/
	function ln_Query(){
			if(gcem_acdate_fr.text == null || gcem_acdate_fr.text==""){
					alert("��¥�ʼ� �׸��Դϴ�.�Է����ּ���.");
					gcem_acdate_fr.focus();
					return false;
			}

			var sdata = "/services/servlet/sales.bm.bm023i_s01"
								+ "?v_str1=" + gcem_vend_nm_fr.text //ȸ���ڵ�
								+ "&v_str2=" + gcem_acdate_fr.text  //�����
								+ "&v_str3=" + txt_cdname_fr.value; //����
			gcds_data.DataID = sdata;
			//prompt("",gcds_data.DataID);
			gcds_data.Reset();
			var ii = gcds_data.countrow;
			if(ii > 0){
				for( i = 1 ; i <= ii ; i++){
					gcds_data.namevalue(i, "CHK") = "T";
				}
			}
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Save(){
		 var row = gcds_data.rowposition;
		 if (row<1){alert("������ ����� �����ϴ�.");return;}

		 for(i=1;i<=gcds_data.countrow;i++) {
				if(gcds_data.namevalue(i,"CHK")=="T"){
					 gcds_data.namevalue(i,"LSTAY_DEL")=gs_date.substring(0,4)+gs_date.substring(5,7)+gs_date.substring(8,10);
				}else{ 
					 gcds_data.namevalue(i,"LSTAY_DEL")="";
					 gcds_data.namevalue(i,"U_EMPNO")=gusrid;	 
				} 

				gctr_data.KeyValue = "bm023i_t01(I:DATA=gcds_data)";
				gctr_data.Action = "/services/servlet/sales.bm.bm023i_t01";
				gctr_data.post();
		 }
	}

	/******************************************************************************
		Description : ����
	******************************************************************************/
	function ln_Excel(){
		  SetTitle("ü������");
			if (gcds_data.countrow<1) alert(gn_Msg(4));
			else gcgd_disp.GridToExcel("ü������ ","C:\\Test\\dsh1033.xls",2);
	}
	
	/******************************************************************************
		Description : ȸ���
	******************************************************************************/
	function ln_SrhCust(){
		var strURL   = "../Common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_vend_nm_fr.text = firstList[0];
		//txt_cscdnm.value = firstList[1];
	}
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
//	gn_LoadComp('1',gcds_data.countrow);
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<!-- �׸���1 ��ü���� -->
<script language="javascript"  for=gcgd_disp event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(gcds_data.countrow > 0){
			if(bCheck==0){
				for(i=1; i<=gcds_data.countrow; i++){
						gcds_data.namevalue(i,"CHK") = 'F';
				}
			} else {
				for(i=1; i<=gcds_data.countrow; i++){
						gcds_data.namevalue(i,"CHK") = 'T';
				}
			}
	} else {
			alert("üũ�� �����Ͱ� �����ϴ�.");
	}
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
		  <img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
			<img src="/services/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">ȸ&nbsp;��&nbsp;��</td>
					<td class="tab_b0100" style="width:150px;">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_nm_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:65px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="##########">
								<param name=PromptChar	  value="">
								<param name=Enable        value=false>
								<param name=UpperFlag     value=1>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					  <img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhCust();">			
					</td>	
					<td class="tab_a0100">��&nbsp;��&nbsp;��</td>
					<td class="tab_b0100" style="width:100px;">
						<fieldset class=field_01 style="width:67px;">
						<comment id="__NSID__"><OBJECT id=gcem_acdate_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:62px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=Enable			  value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '400', '260');">
					</td>	
					<td class="tab_a0100">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
					<td class="tab_b0000">
            <input id="txt_cdname_fr" type="text" class="txt_a01" style="width:72px" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">
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
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:410px;" viewastext>
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
							<param name="Editable"      value="true">
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
								<C> Name='����'		   ID=CHK			    HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center editstyle=checkbox HeadCheck=false HeadCheckShow=true editable=true edit=true</C>
								<C> Name='����SID'		ID=T1_RSV_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=70  align=left edit=none show=false</C> 
								<C> Name='�Ҽ�ȸ��'		ID=VEND_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=120 align=left edit=none</C> 
								<C> Name='��'		      ID=TEAM_NM	  	HeadAlign=Center HeadBgColor=#EEEEEE Width=85	 align=left edit=none</C> 
								<C> Name='����ڹ�ȣ' ID=WORK_NO		  HeadAlign=Center HeadBgColor=#EEEEEE Width=90	 align=center edit=none</C> 
								<C> Name='����'		    ID=CUST_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=60  align=center edit=none</C> 
								<C> Name='�ֹ�/���ǹ�ȣ' ID=MANAGE_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=100 align=center mask='XXXXXX-XXXXXXX' edit=none</C> 
								<C> Name='�����'		  ID=DEPART_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center, mask='XXXX/XX/XXXX' edit=none</C> 
								<C> Name='�ð�'		    ID=DEPART_TIME	HeadAlign=Center HeadBgColor=#EEEEEE Width=50	 align=center, mask='XX:XX' edit=none</C> 
								<C> Name='��濹����'	ID=ARRIVE_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center, mask='XXXX/XX/XXXX' edit=none</C> 
								<C> Name='�ð�'		    ID=ARRIVE_TIME	HeadAlign=Center HeadBgColor=#EEEEEE Width=50	 align=center, mask='XX:XX' edit=none</C> 
								
								<C> Name='����SID'		ID=RSV_SID	    HeadAlign=Center HeadBgColor=#EEEEEE Width=50	 align=center edit=none show=false</C> 
								<C> Name='ü�������'	ID=LSTAY_DEL	  HeadAlign=Center HeadBgColor=#EEEEEE Width=100 align=center edit=none show=false</C> 
								<C> Name='������'		  ID=U_EMPNO	    HeadAlign=Center HeadBgColor=#EEEEEE Width=50	 align=center edit=none show=false</C> 
								<C> Name='������'		  ID=U_DATE      	HeadAlign=Center HeadBgColor=#EEEEEE Width=50	 align=center edit=none show=false</C> 
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