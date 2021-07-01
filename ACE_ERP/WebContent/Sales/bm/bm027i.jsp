<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	휴가신청서 작성
+ 프로그램 ID	: bm027i.jsp
+ 기 능 정 의	: 조회|등록|저장|엑셀
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm027i_s01,bm027i_s02,bm027i_t01.java
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
			gcem_acdate_fr.text = gs_date;
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

			if(txt_cdname_fr.value == null || txt_cdname_fr.value==""){
					alert("이름은 필수 항목입니다.입력해주세요.");
					return false;
			}

			var sdata = "/services/servlet/sales.bm.bm027i_s01"
								+ "?v_str1=" + txt_cust_sid.value
								+ "&v_str2=" + gcem_acdate_fr.text;
			gcds_data.DataID = sdata; 
			gcds_data.Reset();

	}

	/******************************************************************************
		Description : 엑셀 (조회)
	******************************************************************************/
	function ln_ExcelQuery(){

			var sdata = "/services/servlet/sales.bm.bm027i_s02"
								+ "?v_str1=" + gcds_data.namevalue(gcds_data.rowposition,"NS_PLAN");
			gcds_back.DataID = sdata; 
			gcds_back.Reset();

	}

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){

		if (gcds_data.RowStatus(gcds_data.RowPosition) == 1 ){
					return false;
		}
	     gcds_data.addrow()
		 var row = gcds_data.rowposition
		 gcds_data.namevalue(row,"CUST_SID") = txt_cust_sid.value;
		 gcds_data.namevalue(row,"I_EMPNO")  = gusrid;
		 gcds_data.namevalue(row,"U_EMPNO")  = gusrid;
		 gcds_data.namevalue(row,"POSITIONS")= txt_positions.value;
		 gcds_data.namevalue(row,"CUST_NM")  = txt_cdname_fr.value;
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){

		if (!gcds_data.isUpdated) {
			alert(gn_Msg(4));
			return;
		}

    if (!ln_Valchk()) return;

    gctr_data.KeyValue = "bm027i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm027i_t01";
		gctr_data.post();
    
    ln_Query();
	}

	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
     ln_ExcelQuery();

		 SetTitle("휴가신청서 작성");
		 if (gcds_back.countrow<1) { alert("해당날짜에 맞는 내용이 없습니다"); gcem_acdate_fr.focus();
		 } else {gcgd_back.GridToExcel("휴가 신청서 작성 ","C:\\Temp\\휴가신청서작성.xls",2);}
	}
	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){
		var row = gcds_data.rowposition;

		if(gcds_data.sysStatus(row)=="3"){
				gcds_chk.DataID = "/services/servlet/sales.bm.bm027i_chk_s01?v_str1="+fn_trim(txt_cust_sid.value);
				//prompt("",gcds_chk.DataID);
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"CUST_SID") == 0){
					ln_Add();
					return;
				}				
		}

		return true;
  }
	/******************************************************************************
		Description : 사원(팝업)
	******************************************************************************/
	function ln_SrhEmpno(){
		var strURL = "bm027i_r.html";
		var strPos = "dialogWidth:435px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value   = firstList[0]; 
		txt_cdname_fr.value  = firstList[1]; 
		txt_positions.value  = firstList[2]; 
		ln_Query();
	} 
</script>

<!----	D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N		------->
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"   VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_back classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"   VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"   VALUE="true">
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
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<input id="txt_positions" type="hidden" class="txt_a01">
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/plus.gif"	style="cursor:hand" align=absmiddle onClick="ln_Add()">
      <img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
			<img src="/services/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">성&nbsp;&nbsp;&nbsp;명</td>
					<td class="tab_b0100" style="width:150px;">
					  <input id="txt_cust_sid" type="hidden" class="txt_a01" style="cursor:hand;position:relative;width:70px;top:-3px;">
            <input id="txt_cdname_fr" type="text" class="txt_a01" style="cursor:hand;position:relative;width:70px;top:-3px;" disabled>
						<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhEmpno();">
					</td>	
					<td class="tab_a0100">날&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0000">
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="__GetCallCalendar7('gcem_acdate_fr','Text');">
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
					  <!-- editStyle=Popup -->
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:410px;" viewastext>
							<param name="DataID"				value="gcds_data">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#A4B8C5">
							<param name="LineColor" 		value="#A4B8C5">
							<param name="Editable"      value="true">
							<param name="TitleHeight"		value="22">
							<param name="RowHeight"			value="20">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="sortview"			value=left>
							<param name="Format"				value="  
								<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center show=false edit=none</F>
								<C> Name='T1CUST_SID'	ID=T1CUST_SID	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false edit=none</C> 
								<C> Name='직위'		    ID=POSITIONS	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true  edit=none</C> 
								<C> Name='성명'	  	  ID=CUST_NM	  HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=true  edit=none</C> 
								<C> Name='부임일'	  	ID=ORDER_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false  edit=none mask='XXXX/XX/XXXX'</C> 
								<C> Name='DEPRT_SID'	ID=DEPRT_SID	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='CUST_SID'	  ID=CUST_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='구분코드'	  ID=REASON			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=true  edit=true EditStyle=Combo		Data='1:정기,2:비정기'</C> 
								<C> Name='구분명'	  	ID=REASON_NM	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='출발일'	  	ID=NS_PLAN		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true  edit=true mask='XXXX/XX/XXXX'</C> 
								<C> Name='복귀일'	  	ID=SN_PLAN		HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true  edit=true mask='XXXX/XX/XXXX'</C> 
								<C> Name='휴가일수'	  ID=VACA_DAYS	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=true  edit=true</C> 
								<C> Name='차수'   	  ID=NUMBERS		HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center show=true edit=false</C>
								<C> Name='비고'	  	  ID=BIGO			  HeadAlign=Center HeadBgColor=#EEEEEE Width=270	align=left show=true  edit=true</C> 
								<C> Name='입력자'	  	ID=I_EMPNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='입력일'	  	ID=I_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='수정자'	  	ID=U_EMPNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='수정일'	  	ID=U_DATE			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								<C> Name='CUST_SIDYN'	  	ID=CUST_SIDYN			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=false edit=none</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>

						<!-- 엑셀 -->
						<comment id="__NSID__"><OBJECT class="tab_b0110" id=gcgd_back classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:352px;display:none" viewastext>
						<param name="DataID"				value="gcds_back">
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
								<C> Name='직위'		    ID=POSITIONS	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=true  edit=none</C> 
								<C> Name='성명'	  	  ID=CUST_NM	  HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center show=true  edit=none</C> 
								<C> Name='부임일'	  	ID=ORDER_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=true  edit=none mask='XXXX/XX/XXXX'</C> 
								<C> Name='구분코드'	  ID=REASON			HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=true  edit=true EditStyle=Combo		Data='1:정기,2:비정기'</C> 
								<C> Name='출발일'	  	ID=NS_PLAN		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=true  edit=true mask='XXXX/XX/XXXX'</C> 
								<C> Name='복귀일'	  	ID=SN_PLAN		HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center show=true  edit=true mask='XXXX/XX/XXXX'</C> 
								<C> Name='휴가일수'	  ID=VACA_DAYS	HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=true  edit=true</C> 
								<C> Name='비고'	  	  ID=BIGO			  HeadAlign=Center HeadBgColor=#EEEEEE Width=75	align=center show=true  edit=true</C> 
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
