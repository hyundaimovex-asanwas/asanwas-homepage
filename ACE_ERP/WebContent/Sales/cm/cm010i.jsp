<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	차량관리
+ 프로그램 ID	: cm010.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: KBJ
+ 서 블 릿 명	: cm010_s01,cm010_s02,cm010_t01
------------------------------------------------------------------------------>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<jsp:include page="/Sales/common/include/head.jsp"/>
<Script language="javascript" src="../common/include/PubFun.js"></script>
<link rel="stylesheet" href="../common/include/common.css">
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	get_cookdata();
	var gs_date = gn_Replace(gcurdate,"/");
	var gdataset = "";

	/******************************************************************************
		Description : 페이지 로딩
	******************************************************************************/
	function fnOnLoad(tree_idx){	
		fnInit_tree(tree_idx);	
		ln_Before();
	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
    //gcem_acdate_fr.text = gs_date;
		//차종
		gcds_cu017.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU017&v_str2=Y";
		gcds_cu017.Reset();
    
		//최초방문여부
		gcds_cu018.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CU018&v_str2=Y";
		gcds_cu018.Reset();
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		if(gcra_snkorea.CodeValue==1){
			var sdata = "/services/servlet/sales.cm.cm010i_s01"
								+ "?v_str1=" + txt_car_no_fr.value;
			gcds_data_1.DataID = sdata; 
			gcds_data_1.Reset();
		} else {
			var sdata = "/services/servlet/sales.cm.cm010i_s01"
								+ "?v_str2=" + txt_cardno_fr.value;
			gcds_data_1.DataID = sdata; 
			gcds_data_1.Reset();		
		}
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){
		if (!gcds_data_2.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

	gcds_data_2.NameValue(gcds_data_2.rowposition,"CAR_SID") = gcds_data_2.NameValue(gcds_data_2.rowposition,"T1_CAR_SID");
    gcds_data_2.NameValue(gcds_data_2.rowposition,"I_EMPNO") = gusrid;
    gcds_data_2.NameValue(gcds_data_2.rowposition,"U_EMPNO") = gusrid;

    gctr_data.KeyValue = "cm010i_t01(I:DATA=gcds_data_2)";
    gctr_data.Action = "/services/servlet/sales.cm.cm010i_t01";
		gctr_data.Parameters = "v_str1=" +  gcds_data_2.namevalue(gcds_data_2.rowposition,"T1_CAR_SID");
    //prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();
	}

	/******************************************************************************
		Description : 소속사
	******************************************************************************/
	function ln_SrhCust(){
		var strURL   = "../common/html/Company_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_vend_id.text = firstList[0];
		txt_vend_name.value = firstList[1];
	}

	/******************************************************************************
		Description : 소속팀
	******************************************************************************/
	function ln_SrhTeam(){
		var strURL   = "../common/html/Company_Team_pop.html";
		var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		gcem_team_cd.text = firstList[0];
		txt_team_name.value = firstList[1];
	} 
	
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cu018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
<script language="javascript" for="gcds_data_1" event="OnLoadStarted()">
	gn_LoadStart();
/*
	if (gcds_data.countrow>0){
		if (gcds_data.namevalue(1,"file_nm")=="") {
			file_nm.src="/services/Sales/images/00000.gif";
		} else {
			var str1 = gcds_data.namevalue(1,"CUST_SID");
			file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1; //확인후 수정할것
			
		}
	} else {
		if (row <1) {
			file_nm.src="/services/Sales/images/00000.gif";
			alert("검색된 데이터가 없습니다.");
		}		
	}
*/
</script>

<script language="javascript" for="gcds_data_1" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>

<!-- 움직일때 마다 사진나오게 -->
<!-- <script language=javascript for=gcds_data event=OnRowPosChanged(row)>
	if (gcds_data.namevalue(row,"file_nm")=="") {
		file_nm.src="services/Sales/images/00000.gif;
	} else {
		var str1 = gcds_data.namevalue(row,"empno");
		file_nm.src="/services/servlet/groupware.g050050_s3?v_str1="+str1;//확인후 수정할것.
	}
</script> -->
<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language=JavaScript for=gcra_snkorea event=OnSelChange()>
   if(gcra_snkorea.CodeValue==1){
		 document.all["d1"].style.display="block";
		 document.all["d2"].style.display="none";		 
	 } else {
		 document.all["d1"].style.display="none";
		 document.all["d2"].style.display="block";
	 } 
</script>

<script language="javascript"  for=gcgd_disp event=OnClick(Row,Colid)>
	var str1 = gcds_data_1.namevalue(gcds_data_1.rowposition,"CAR_SID");

	gcds_data_2.DataID = "/services/servlet/sales.cm.cm010i_s02?v_str1="+str1;
	gcds_data_2.Reset();
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=3>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
      <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=3>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>

					<td class="tab_b0000" style="width:180px;">
						<comment id="__NSID__"><object id=gcra_snkorea classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:170">
							<param name=Cols	      value="2">
							<param name= CodeValue  value="1">
							<param name=AutoMargin	value="true">
							<param name=Format	value="1^차량번호,2^차대번호">			
						</object></comment><script>__ws__(__NSID__);</script>	
					</td>	
					<td class="tab_b0000">
					  <!-- 차량번호 -->
					  <div id=d1>
						<input id="txt_car_no_fr" type="text" class="txt_a01"  style="width:100px;" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">
            </div>
						<!-- 차대번호 -->
						<div id=d2 style="display:none">
						<input id="txt_cardno_fr" type="text" class="txt_a01"  style="width:100px;" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">
						</div>
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td>
      <table width="290" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:290px;height:410px;" viewastext>
							<param name="DataID"				value="gcds_data_1">
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
								<F> Name='No.'			ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center show=false</F>
								<C> Name='차량번호'	ID=CAR_NO			HeadAlign=Center HeadBgColor=#EEEEEE Width=130	align=center</C> 
								<C> Name='차대번호'	ID=CAR_DNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=125	align=center</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:291px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
    <td>
      <table width="120" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td class="tab_b1110" valign=top height=100>
					<!-- -------------------------------------- -->
									<!-- <input type="text" class="txt_a01" id=txt_file name="txt_file" readonly style="width:100px;top:-3px;">  -->
<!-- 									<comment id="__NSID__">
										<object id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:8px;width:80;height:20;top:2px">
											<param name="Text"		value="찾아보기">
											<param name="Enable"  value="true">
										</object>
									</comment><script>__ws__(__NSID__);</script>	 -->
									<!-- <input type=image id="file_nm" NAME="file_nm" src="../../person/html/photo/00000.gif" style="width:60px;height:40px;"> -->
					  <input type=image id="file_nm" NAME="file_nm" src="/services/Sales/images/00000.gif" style="width:115px;height:97px;">
          <!-- -------------------------------------- -->
					</td>
        </tr>
        <tr> 
          <td class="tab_b1111" valign=top height=330>
              &nbsp;
					</td>
        </tr>
      </table>
    </td>
		<td>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style="width:460px;">
		    <tr>
					<td class="tab_a0101">차량등록번호</td>
					<td class="tab_b0001">
						<input id="txt_car_no" type="text" class="txt_a01"  style="width:100px;" disabled>
					</td>	
				</tr>
		    <tr>
					<td class="tab_a0101">차&nbsp;&nbsp;&nbsp;&nbsp;종</td>
					<td class="tab_b0001">
            <input id="txt_car_type" type="text" class="txt_a01"  style="width:100px;" disabled>			
					</td>					
				</tr>
		    <tr>
				  <td class="tab_a0101">차&nbsp;&nbsp;&nbsp;&nbsp;명</td>
					<td class="tab_b0001">
            <input id="txt_car_nm" type="text" class="txt_a01"  style="width:100px;" disabled>			
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">형&nbsp;&nbsp;&nbsp;&nbsp;식</td>
					<td class="tab_b0001">
            <input id="txt_car_form" type="text" class="txt_a01"  style="width:100px;" disabled>		
				</tr>
		    <tr>
				  <td class="tab_a0101">연&nbsp;&nbsp;&nbsp;&nbsp;식</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:50px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_year classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:47px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="0000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
						<B>년식</B>
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">배&nbsp;기&nbsp;량</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:50px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_cc classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:47px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="00000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<B>CC</B>
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">승차인원</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:50px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_persons classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:47px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
						<B>명</B>
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">최대적재량</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:50px;">
						<comment id="__NSID__"><OBJECT id=gcem_max_kg classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:47px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="00000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>	
						<B>kg</B>
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">차&nbsp;&nbsp;&nbsp;&nbsp;종1</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_car_type_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu017">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">차대번호</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:100px;">
						<comment id="__NSID__"><OBJECT id=gcem_car_dno classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:97px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="00000000000000000000">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">최초방문여부</td>
					<td class="tab_b0001">
						<comment id="__NSID__"><OBJECT id=gclx_north_yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_cu018">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>		
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">최초방문(예정)일</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_north_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:67px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value=false>
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">소속회사</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:67px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#################">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>
						<input id="txt_vend_name" type="text" class="txt_a01"  style="cursor:hand;position:relative;width:120px;top:-3px;" disabled>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhCust();">	
					</td>		
				</tr>
		    <tr>
				  <td class="tab_a0101">소&nbsp;속&nbsp;팀</td>
					<td class="tab_b0001">
						<fieldset class=field_01 style="width:70px;">
						<comment id="__NSID__"><OBJECT id=gcem_team_cd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:52px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="#########">
								<param name=PromptChar	  value="">
								<param name=UpperFlag     value=1>
								<param name=Enable        value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						</fieldset>			
						<input id="txt_team_name" type="text" class="txt_a01"  style="cursor:hand;position:relative;width:120px;top:-3px;" disabled>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhTeam();">		
					</td>		
				</tr>
				<tr><td colspan=2 height=43></td></tr>
			</table>		
		<td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data_2>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=CAR_NO        Ctrl=txt_car_no	     Param=Value</C>
		<C>Col=CAR_TYPE      Ctrl=txt_car_type	   Param=Value</C>
		<C>Col=CAR_NM        Ctrl=txt_car_nm	     Param=Value</C>
		<C>Col=CAR_FORM      Ctrl=txt_car_form	   Param=Value</C>
		<C>Col=CAR_YEAR      Ctrl=gcem_car_year	   Param=Text</C>
		<C>Col=CAR_CC        Ctrl=gcem_car_cc	     Param=Text</C>
		<C>Col=CAR_PERSONS   Ctrl=gcem_car_persons Param=Text</C>
		<C>Col=MAX_KG        Ctrl=gcem_max_kg	     Param=Text</C>
		<C>Col=CAR_TYPE_CD   Ctrl=gclx_car_type_cd Param=bindColval</C>
		<C>Col=CAR_DNO       Ctrl=gcem_car_dno	   Param=Text</C>
		<C>Col=NORTH_YN      Ctrl=gclx_north_yn	   Param=bindcolval</C>
		<C>Col=NORTH_DATE    Ctrl=gcem_north_date	 Param=Text</C>
		<C>Col=CLIENT_SID       Ctrl=gcem_vend_id	   Param=Text</C>
		<C>Col=CLIENT_NM       Ctrl=txt_vend_name	   Param=Value</C>
		<C>Col=TEAM_CD       Ctrl=gcem_team_cd	   Param=Text</C>
		<C>Col=TEAM_NM       Ctrl=txt_team_name	   Param=Value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>