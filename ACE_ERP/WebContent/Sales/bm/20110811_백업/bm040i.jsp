<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	식수배정
+ 프로그램 ID	: bm040i.jsp
+ 기 능 정 의	: 조회|수정
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm040i_s01,bm040i_s02,bm040i_t01
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
			gcds_cm001.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=CM001";
			gcds_cm001.Reset();
	}


	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){

			var sdata = "/services/servlet/sales.bm.bm040i_s01"
								+ "?v_str1=" + txt_companynm_fr.value;
			gcds_data_1.DataID = sdata; 
			gcds_data_1.Reset();

	}


	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Add(){

	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/
	function ln_Save(){

			if (!gcds_data_2.isUpdated) {
				alert(gn_Msg(4));
				return;
			}

			gcds_data_2.namevalue(gcds_data_2.rowposition,"U_EMPNO") = gusrid;

			gctr_data.KeyValue = "bm040i_t01(I:DATA=gcds_data_2)";
			gctr_data.Action = "/services/servlet/sales.bm.bm040i_t01";
			gctr_data.post();
			
			//ln_Query();
			var str1 = gcds_data_1.namevalue(gcds_data_1.rowposition,"VEND_SID");
			var str2 = gcds_data_1.namevalue(gcds_data_1.rowposition,"TEAM_CD");

			gcds_data_2.DataID = "/services/servlet/sales.bm.bm040i_s02?v_str1="+str1+"&v_str2="+str2;
			//prompt("",gcds_data_2.DataID);
			gcds_data_2.Reset();
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

	}


	/******************************************************************************
		Description : 입력값 체크
	******************************************************************************/
	function ln_Valchk(){

  }

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_cm001 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
</script>

<script language="javascript" for="gcds_data_1" event="onloadCompleted(row,colid)">
	gn_LoadComp('1',gcds_data_1.countrow);
</script>

<script language="javascript" for="gcds_data_2" event="OnLoadStarted()">
	gn_LoadStart();
</script>

<script language="javascript" for="gcds_data_2" event="onloadCompleted(row,colid)">
	gn_LoadComp('2',gcds_data_2.countrow);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=javascript for=gcem_acdate_fr event=OnKeyUp(kcode,scode)>
	  if (kcode=="13") ln_Query();
</script>

<script language="javascript"  for=gcgd_disp1 event=OnClick(Row,Colid)>
		var str1 = gcds_data_1.namevalue(gcds_data_1.rowposition,"VEND_SID");
		var str2 = gcds_data_1.namevalue(gcds_data_1.rowposition,"TEAM_CD");

		gcds_data_2.DataID = "/services/servlet/sales.bm.bm040i_s02?v_str1="+str1+"&v_str2="+str2;
		//prompt("",gcds_data_2.DataID);
		gcds_data_2.Reset();

</script>

<script language="javascript" for="gcds_cm001" event="onloadCompleted(row,colid)">
	gcds_cm001.InsertRow(gcds_cm001.RowPosition)
	gcds_cm001.Namevalue(1,"DETAIL_NM") = "없음";
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
			<img src="/services/Sales/images/refer.gif" style="position:relative;top:-5px;"	align=absmiddle onclick="ln_Query()">
      <img src="/services/Sales/images/save.gif"	style="position:relative;top:-5px;" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0100">회&nbsp;사&nbsp;명</td>
					<td class="tab_b0000">
            <input id="txt_companynm_fr" type="text" class="txt_a01" style="width:72px" onkeydown="if(event.keyCode==13) ln_Query();" onBlur="bytelength(this,this.value,30);">	
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
						<table border="0" cellpadding=0 cellspacing=0 style='width:350px;height:483px;font-size:9pt;'>
	  			    <tr>
								<td valign=top>
									<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:340px;height:403px;" viewastext>
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
											<F> Name='No.'				ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
											<C> Name='소속회사'		ID=VEND_NM	  HeadAlign=Center HeadBgColor=#EEEEEE Width=150	align=left</C> 
											<C> Name='팀명'		    ID=TEAM_NM		HeadAlign=Center HeadBgColor=#EEEEEE Width=120		align=left</C>  
											<C> Name='소속회사'		ID=VEND_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=90		align=center show=false</C>  
											<C> Name='소속팀코드'	ID=TEAM_CD		HeadAlign=Center HeadBgColor=#EEEEEE Width=90		align=center show=false</C>  
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset id=ft_div1 style="width:341px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
										<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
									</fieldset>								
								</td>
							</tr>
						</table>
					</td>
					<td valign=top>
						<table border="0" cellpadding=0 cellspacing=0 style='width:453px;height:483px;font-size:9pt;'>
	  			    <tr>
								<td valign=top>
									<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:526px;height:403px;" viewastext>
										<param name="DataID"				value="gcds_data_2">
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
											<F> Name='No.'				ID={CURROW} 	 HeadAlign=Center HeadBgColor=#EEEEEE Width=30	align=center</F>
											<C> Name='사업자번호'	ID=WORK_NO		 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center edit=none</C> 
											<C> Name='성명'		    ID=CUST_NM		 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center edit=none</C> 
											<C> Name='조식'		    ID=EATING_BRE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center editstyle='lookup' data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
											<C> Name='중식'		    ID=EATING_LUN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center align=center editstyle='lookup' data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
											<C> Name='석식'		    ID=EATING_DIN	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center align=center editstyle='lookup' data='gcds_cm001:DETAIL:DETAIL_NM' bgcolor=#C4DDFF</C> 
											">
									</OBJECT></comment><script>__ws__(__NSID__);</script>
									<fieldset id=ft_div2 style="width:527px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
										<font id=ft_cnt2 style="position:relative;top:4px;left:8px"></font>
									</fieldset>
								</td>
							</tr>
						</table>
  				</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
