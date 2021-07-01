<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	세탁관리
+ 프로그램 ID	: bm063i.jsp
+ 기 능 정 의	: 조회|등록|저장|
+ 변 경 이 력	: KBJ
+ 서 블 릿 명	: bm063i_s01,bm063i_t01,bm063i_chk_s01
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
		ln_Query();
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		var sdata = "/services/servlet/sales.bm.bm063i_s01"
							+ "?v_str1=" + gcem_acdate_fr.text;
		gcds_data.DataID = sdata; 
		gcds_data.Reset();
	}

	/******************************************************************************
		Description : 팝업
	******************************************************************************/
	function ln_Pop(){
		var strURL = "bm063i_r.html";
		var strPos = "dialogWidth:300px;dialogHeight:430px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");

    gcds_data.NameValue(gcds_data.rowposition,"COOP_SID")= firstList[0];
    gcds_data.NameValue(gcds_data.rowposition,"VEND_NM") = firstList[1];
	}


	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){
		gcds_data.addrow();
		gcds_data.NameValue(gcds_data.rowposition,"I_EMPNO") = gusrid;
		gcds_data.NameValue(gcds_data.rowposition,"LAUN_DATE") = gcem_acdate_fr.text;
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

    gctr_data.KeyValue = "bm063i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm063i_t01";
    //prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();
	}

	/******************************************************************************
		Description : 삭제
	******************************************************************************/
	function ln_Delete(){

	}

	/******************************************************************************
		Description : 엑셀
	******************************************************************************/
	function ln_Excel(){
		 SetTitle("세탁 관리_" + gcem_acdate_fr.text + "");
		 if (gcds_data.countrow<1) { 
		 } else {gcgd_disp.GridToExcel("세탁 관리_" + gcem_acdate_fr.text + "", "C:\\Temp\\세탁관리.xls",2);}
	}

	/******************************************************************************
		Description : 출력
	******************************************************************************/
	function ln_Print(){
		alert("업무협의중입니다.");
	}

	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){
		if (gcds_data.NameValue(gcds_data.rowposition,"COOP_SID") =="") {
			alert("이용한 업체가 없습니다.");
			return false;
		} 

		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="3"){
       gcds_data.NameValue(gcds_data.rowposition,"U_EMPNO") = gusrid;			
		}

		//키값중복체크
		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="1"){

				gcds_chk.DataID = "/services/servlet/sales.bm.bm063i_chk_s01?v_str1=" + gcem_acdate_fr.text
					                                                       + "&v_str2=" + gcds_data.NameValue(gcds_data.rowposition,"COOP_SID");
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"COOP_SID") != 0){
					alert(" 해당날짜에 중복된 업체명이 있습니다.확인후 입력하세요");
					gcds_data.namevalue(row,"COOP_SID") = "";
					gcds_data.deleterow(row);
					return;
				}				
		}

		return true;

	}
	
</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
//	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	gn_LoadComp_NonAlert('1',gcds_data.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_accode_fr event=OnKeyUp(kcode,scode)>
	if (kcode=="13") ln_Query();
</script>

<script language="javascript"  for=gcgd_disp event=OnDblClick(Row,Colid)>
	if(Colid=="VEND_NM") ln_Pop();
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
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/plus.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
      <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
<!--			<img src="/services/Sales/images/print.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onclick="ln_Print()">	 //-->
			<img src="/services/Sales/images/excel.gif"	style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onClick="ln_Excel()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">날&nbsp;&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0000" colspan=3>
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '255', '260');">	
					</td>				
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td colspan=2>
			<table class="tab_b1100" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_b0011" align=right><font size='-1' face='돋움'><b>*단위:USD</b></font></td>				
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr>  
  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:876px;height:383px;" viewastext>
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
							<Param Name="UsingOneClick" value="1">
							<param name="Editable"      value="true">
							<param name="sortview"			value=left>
							<param name="Format"				value="  
							<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center show=false</F>
							<C> Name='COOP_SID'		ID=COOP_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=55	  align=center show=false</C>
							<C> Name='업체명'		  ID=VEND_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=110  align=left edit=none</C>
							<X>Name='세탁물현황'  HeadAlign=Center HeadBgColor=#EEEEEE align=center
								<G> Name='드라이' HeadAlign=Center HeadBgColor=#EEEEEE align=center>
									<C> Name='1$'		ID=D1		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='2$'		ID=D2		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='3$'		ID=D3		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
								</G>
								<G> Name='물세탁'	HeadAlign=Center HeadBgColor=#EEEEEE 		align=center>
									<C> Name='1$'		ID=W1		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='2$'		ID=W2		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='3$'		ID=W3		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='5$'		ID=W5		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='7$'		ID=W7		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
								</G>
								<G> Name='수선' 	HeadAlign=Center HeadBgColor=#EEEEEE 		align=center>
									<C> Name='2$'		ID=R2		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
									<C> Name='4$'		ID=R4		HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=right edit=true</C> 
								</G>
								<C> Name='금액'		ID=LAUN_FEE 	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=right edit=true value={D1 + (D2*2) + (D3*3) + W1+(W2*2) + (W3*3) + (W5*5) + (W7*7) + (R2*2) + (R4*4)}</C>
								<C> Name='정산'		ID=CALC_YN		HeadAlign=Center HeadBgColor=#EEEEEE Width=40	 align=center EditStyle=CheckBox</C>
								<C> Name='비고'		ID=BIGO			  HeadAlign=Center HeadBgColor=#EEEEEE Width=110 align=left edit=true</C>
              </X>
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
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>