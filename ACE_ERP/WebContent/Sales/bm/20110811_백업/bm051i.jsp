<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	전화번호 관리
+ 프로그램 ID	: bm051i.jsp
+ 기 능 정 의	: 조회|등록|수정
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm051i_s01,bm051i_t01,bm051i_chk_s01
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

			var sdata = "/services/servlet/sales.bm.bm051i_s01"
								+ "?v_str1=사업자관리";
			gcds_data.DataID = sdata; 
			gcds_data.Reset();		

	}

	/******************************************************************************
		Description : 선조회
	******************************************************************************/
	function ln_Before(){
      ln_Enable("s");
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
		var temp= gcem_telNum.text;
    var chk="";

		temp = temp.replace("-","");
		temp = temp.replace("-","");

		//alert("temp::"+temp);
    //alert(temp.length);
		for (i=0;i<temp.length;i++){
			if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				chk="N";	//숫자
			}else{
				chk="C";	//문자
				break;
			}
		}

		if(chk=="N"){
			//alert("숫자");
			var str1 = temp;

			var sdata = "/services/servlet/sales.bm.bm051i_s01"
								+ "?v_str1=" + str1;//숫자
			gcds_data.DataID = sdata; 
			gcds_data.Reset();			
		}else{
      //alert("문자");
			var str2 = temp;
			var sdata = "/services/servlet/sales.bm.bm051i_s01"
								+ "?v_str2=" + str2;//문자
			gcds_data.DataID = sdata; 
			gcds_data.Reset();
		}
	}

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){
			var row = gcds_data.rowposition;
      
			ln_Enable("a");

			gcds_data.addrow();
			gcds_data.NameValue(row,"REGI_DATE") = gs_date; 
			gcds_data.NameValue(row,"I_EMPNO")   = gusrid; 
			gcds_data.NameValue(row,"U_EMPNO")   = gusrid; 
			gcra_sn.CodeValue = "S"; 
			gcra_op.CodeValue = "O";
			gcem_tel_num.focus();
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

    gctr_data.KeyValue = "bm051i_t01(I:DATA=gcds_data)";
    gctr_data.Action = "/services/servlet/sales.bm.bm051i_t01";
    //prompt("",gcds_data.text);
		gctr_data.post();

		ln_Query();

	}


	/******************************************************************************
		Description : 사원(팝업)
	******************************************************************************/
	function ln_SrhEmpno(){
		var strURL = "bm051i_r.html";
		var strPos = "dialogWidth:435px;dialogHeight:475px;status:no;scroll:no;resizable:no";
		var arrResult = showModalDialog(strURL,window,strPos);

		if (arrResult == -1 || arrResult == null || arrResult == "") return;
		var firstList = arrResult.split(";");
		
		txt_cust_sid.value   = firstList[0]; 
		txt_cdname_fr.value  = firstList[1]; 
	} 


	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

		if (gcem_tel_num.text == null || gcem_tel_num.text == "") {
			alert("전화번호는 필수 입력사항입니다.");
			return false;
		}

		if (txt_cdname_fr.value == null || txt_cdname_fr.value == "") {
			alert("등록자는 필수 입력사항입니다.");
			return false;
		}		

		if (txt_rec_plac.value == null || txt_rec_plac.value == "") {
			alert("수신처는 필수 입력사항입니다.");
			return false;
		}		


		//키값중복체크
		var row = gcds_data.rowposition;
		if(gcds_data.sysStatus(row)=="1"){

				gcds_chk.DataID = "/services/servlet/sales.bm.bm051i_chk_s01?v_str1="+gcem_tel_num.text;
				gcds_chk.Reset();

				if(gcds_chk.namevalue(1,"TEL_SID") != 0){
					alert("중복된 전화번호가 있습니다.확인후 입력하세요");
					gcds_data.namevalue(row,"TEL_SID") = "";
					gcds_data.deleterow(row);
					return;
				}				
		}

		return true;
	}
	
/******************************************************************************
	Description : Enable Format
******************************************************************************/
function ln_Enable(chk){

	if (chk == "a") {
		gcem_tel_num.enable	= true;	
	}else if(chk == "s") {
    gcem_tel_num.enable	= false;
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
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
//	gn_LoadComp('1',gcds_data.countrow);
	ln_Enable("s");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 <script language=JavaScript for=gcem_telNum event=onKeyDown(kcode,scode)>
    if (kcode != 13) return;
		var temp= gcem_telNum.text;
    var chk="";

		temp = temp.replace("-","");
		temp = temp.replace("-","");

		//alert("temp::"+temp);

		for (i=0;i<temp.length;i++){
			if(temp.charAt(i)>="0" && temp.charAt(i)<="9"){
				chk="N";
			}else{
				chk="C";
				break;
			}
		}

		if(chk=="N"){
			//alert("숫자");
			var str1 = temp;

			var sdata = "/services/servlet/sales.bm.bm051i_s01"
								+ "?v_str1=" + str1;//숫자
			gcds_data.DataID = sdata; 
			gcds_data.Reset();			
		}else{
      //alert("문자");
			var str2 = temp;
			var sdata = "/services/servlet/sales.bm.bm051i_s01"
								+ "?v_str2=" + str2;//문자
			gcds_data.DataID = sdata; 
			gcds_data.Reset();
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;cursor:hand;"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/plus.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Add()">
      <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;cursor:hand;" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100" style='width:110px;'>전화번호/수신처</td>
					<td class="tab_b0000">
					<!-- <param name=GeneralEdit   value="true"> -->
						<fieldset class=field_01 style="width:80px;">
						<comment id="__NSID__"><OBJECT id=gcem_telNum classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
							class="gcem_01" style="width:75px;">
								<param name=Alignment			value=0>
								<param name=GeneralEdit   value="true">
								<param name=Border	      value=false>
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
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td>
						<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:450px;height:403px;" viewastext>
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
								<C> Name='TEL_SID'		ID=TEL_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='전화번호'	  ID=TEL_NUM		HeadAlign=Center HeadBgColor=#EEEEEE Width=200		align=left show=true</C> 
								<C> Name='등록자SID'	ID=CUST_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='수신처'	  	ID=REC_PLAC		HeadAlign=Center HeadBgColor=#EEEEEE Width=200		align=left show=true</C> 
								<C> Name='남북구분'	  ID=SN		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='업무구분'	  ID=OP		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='비고'	  	  ID=BIGO		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='등록일자'	  ID=REGI_DATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='입력자'	  	ID=I_EMPNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='입력일'	  	ID=I_DATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='수정자'	  	ID=U_EMPNO		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								<C> Name='수정일'	  	ID=U_DATE		HeadAlign=Center HeadBgColor=#EEEEEE Width=80		align=left show=false</C> 
								">
            </OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset id=ft_div1 style="width:451px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
							<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
						</fieldset>
					</td>
					<td width=3></td>
					<td valign=top>
						<table class="tab_b1011" border="0" cellpadding=0 cellspacing=0 style='width:423px;height:425px;font-size:9pt;'>
	  			    <tr>
								<td class="tab_a0101"">전화번호</td>
								<td class="tab_b0101">
									<fieldset class=field_01 style="width:130px;">
									<comment id="__NSID__"><OBJECT id=gcem_tel_num classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:120px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="000000000000000">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td class="tab_a0101">등&nbsp;록&nbsp;자</td>
								<td class="tab_b0101">
									<input id="txt_cust_sid" type="hidden" class="txt_a01" style="cursor:hand;position:relative;width:70px;top:-3px;">
									<input id="txt_cdname_fr" type="text" class="txt_a01" style="cursor:hand;position:relative;width:70px;top:-3px;" disabled>
									<img src="/services/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:4px;top:3px;" onclick="ln_SrhEmpno();">
								</td> 
							</tr>
							<tr>
   							<td class="tab_a0101">수&nbsp;신&nbsp;처</td>
								<td class="tab_b0101">
<!-- 									<fieldset class=field_01 style="width:80px;">
									<comment id="__NSID__"><OBJECT id=gcem_rec_plac classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
										class="gcem_01" style="width:76px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="########">
											<param name=PromptChar	  value="">
											<param name=Enable			  value="true">
                      <param name=UpperFlag	    value=1>
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									</fieldset> -->
									<input id="txt_rec_plac" type="text" class="txt_a01" style="position:relative;width:200px;top:0px;" maxlength=20>
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">남북구분</td>
								<td class="tab_b0101" colspan=3>
									<comment id="__NSID__"><object id=gcra_sn classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:100;cursor:hand;">
											<param name=Cols     value="2">
											<param name=CodeValue  value="S">
											<param name=Format   value="S^남,N^북">
									</object></comment><script>__ws__(__NSID__);</script>		
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">업무구분</td>
								<td class="tab_b0101" colspan=3>
									<comment id="__NSID__"><object id=gcra_op classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
											style="position:relative;left:4px;top:0px;height:24;width:100;cursor:hand;">
											<param name=Cols     value="2">
											<param name=CodeValue  value="O">
											<param name=Format   value="O^업무,P^개인">
									</object></comment><script>__ws__(__NSID__);</script>		
								</td>
							</tr>
							<tr>
   							<td class="tab_a0101">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
								<td class="tab_b0101" colspan=3>
						      <textarea id="txt_bigo" class="txt_a01"  style= "width:200px; height:71px; overflow:auto;position:relative;left:4px" maxlength="30" onBlur="bytelength(this,this.value,40);"></textarea>
								</td>
							</tr>
							<tr><td class="tab_b0100" colspan="4">&nbsp;</td></tr> 
						</table>
  				</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!-- CodeValue -->
<comment id="__NSID__">
<object  id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcds_data>
	<param name=ActiveBind    value=true>	
	<param name=BindInfo			value='
		<C>Col=TEL_NUM   Ctrl=gcem_tel_num	  Param=Text</C>
		<C>Col=CUST_SID  Ctrl=txt_cust_sid	  Param=Value</C>
		<C>Col=REC_PLAC  Ctrl=txt_rec_plac	  Param=Value</C>
		<C>Col=SN        Ctrl=gcra_sn	        Param=CodeValue</C>
		<C>Col=OP        Ctrl=gcra_op	        Param=CodeValue</C>
		<C>Col=BIGO      Ctrl=txt_bigo	      Param=Value</C>
		<C>Col=CUST_NM   Ctrl=txt_cdname_fr	  Param=Value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
