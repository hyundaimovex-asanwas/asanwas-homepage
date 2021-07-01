<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>                               
<% String dirPath = request.getContextPath(); //HDASan. ContextPath 및 기타 변수 설정. %>


<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	입출국명단
+ 프로그램 ID	: bm025s.jsp
+ 기 능 정 의	: 조회|저장|출력
+ 변 경 이 력	: 김 종 현
+ 서 블 릿 명	: bm025s_s01,bm025s_s02,bm025s_t01,bm025s_t02
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

			gcds_rm015.DataID = "/services/servlet/sales.bm.bm_common_s01?v_str1=RM015&v_str2=Y";
			gcds_rm015.Reset();
	}


	/******************************************************************************
		Description : 조회
	******************************************************************************/
	function ln_Query(){
			if(gcem_acdate_fr.text == null || gcem_acdate_fr.text==""){
					alert("날짜필수 항목입니다.입력해주세요.");
					gcem_acdate_fr.focus();
					return false;
			}

			if(gcra_snkorea.CodeValue==1){
					var sdata = "/services/servlet/sales.bm.bm025s_s01"
										+ "?v_str1=" + gcem_acdate_fr.text
										+ "&v_str2=" + gclx_rm015.bindcolval
										+ "&v_str3=" + gcra_firstYN.CodeValue
										+ "&v_str4=" + gcra_printYN.CodeValue;
					gcds_data_1.DataID = sdata; 
					gcds_data_1.Reset();
			} else {
					var sdata = "/services/servlet/sales.bm.bm025s_s02"
										+ "?v_str1=" + gcem_acdate_fr.text
										+ "&v_str2=" + gclx_rm015.bindcolval
										+ "&v_str3=" + gcra_firstYN.CodeValue
										+ "&v_str4=" + gcra_printYN.CodeValue;
					gcds_data_2.DataID = sdata; 
					gcds_data_2.Reset();
			}
	}

	/******************************************************************************
		Description : 등록
	******************************************************************************/
	function ln_Save(){
		if(gcra_snkorea.CodeValue==1){
			 var row = gcds_data_1.rowposition;
			 if (row<1){alert("적합한 대상이 없습니다.");return;}

			 for(i=1;i<=gcds_data_1.countrow;i++) {
					if(gcds_data_1.namevalue(i,"CHK")=="T"){
						 gcds_data_1.namevalue(i,"SNP_YN")="Y";
						 gcds_data_1.namevalue(i,"U_EMPNO")=gusrid;
					}
					gctr_data.KeyValue = "bm025s_t01(I:DATA=gcds_data_1)";
					gctr_data.Action = "/services/servlet/sales.bm.bm025s_t01";
					gctr_data.post();
			 }
			 alert("작업 완료했습니다.");
		} else {
			 var row = gcds_data_2.rowposition;
			 if (row<1){alert("적합한 대상이 없습니다.");return;}

			 for(i=1;i<=gcds_data_2.countrow;i++) {
					if(gcds_data_2.namevalue(i,"CHK")=="T"){
						 gcds_data_2.namevalue(i,"NSP_YN")="Y";
						 gcds_data_2.namevalue(i,"U_EMPNO")=gusrid;
					}
					gctr_data.KeyValue = "bm025s_t02(I:DATA=gcds_data_2)";
					gctr_data.Action = "/services/servlet/sales.bm.bm025s_t02";
					gctr_data.post();
			 }
			 
			 alert("작업 완료했습니다.");
		}

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
</script>



<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_data_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_rm015 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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


<script language=JavaScript for=gcra_snkorea event=OnSelChange()>
   if(gcra_snkorea.CodeValue==1){
		 document.all["d1"].style.display="block";
		 document.all["d2"].style.display="none";		 
	 } else {
		 document.all["d1"].style.display="none";
		 document.all["d2"].style.display="block";
	 } 
</script>


<!-- 그리드1 전체선택 -->
<script language="javascript"  for=gcgd_disp1 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(gcds_data_1.countrow > 0){
			if(bCheck==0){
				for(i=1; i<=gcds_data_1.countrow; i++){
						gcds_data_1.namevalue(i,"CHK") = 'F';
				}
			} else {
				for(i=1; i<=gcds_data_1.countrow; i++){
						gcds_data_1.namevalue(i,"CHK") = 'T';
				}
			}
	} else {
			alert("체크할 데이터가 없습니다.");
	}
</script>


<!-- 그리드2 전체선택 -->
<script language="javascript"  for=gcgd_disp2 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(gcds_data_2.countrow > 0){
			if(bCheck==0){
				for(i=1; i<=gcds_data_2.countrow; i++){
						gcds_data_2.namevalue(i,"CHK") = 'F';
				}
			} else {
				for(i=1; i<=gcds_data_2.countrow; i++){
						gcds_data_2.namevalue(i,"CHK") = 'T';
				}
			}
	} else {
			alert("체크할 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_rm015" event="onloadCompleted(row,colid)">
	gcds_rm015.InsertRow(gcds_rm015.RowPosition)
	gcds_rm015.Namevalue(1,"DETAIL_NM") = "[전 체]";
	gclx_rm015.index=0;
</script>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- <script language="javascript" for="gctr_data" event="onsuccess()">
	alert(gn_Msg(1));
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gn_Msg(2));
</script> -->


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px">
  <tr> 
    <td  align="right" style="padding-top:4px;" colspan=2>
		  <img src="/services/Sales/images/refer.gif" style="cursor:hand"	align=absmiddle onclick="ln_Query()">
			<img src="/services/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="ln_Save()">
		</td>
	</tr>
	<tr><td height=3></td></tr>
  <tr> 
    <td colspan=2>
			<table class="tab_b1111" border="0" cellpadding="1" cellspacing="0" style='width:877px;'>
		    <tr>
					<td class="tab_a0101">날&nbsp;&nbsp;&nbsp;&nbsp;짜</td>
					<td class="tab_b0001">
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
						<img src="/services/Sales/images/help.gif" style="position:relative;left:4px;top:3px;cursor:hand" onclick="GetCallCalendar_XY('gcem_acdate_fr','Text', '200', '260');">
					</td>	
					<td class="tab_b0001" colspan=4>
 						<comment id="__NSID__"><object id=gcra_snkorea classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:120">
							<param name=Cols	      value="2">
							<param name= CodeValue  value="1">
							<param name=AutoMargin	value="true">
							<param name=Format	value="1^남->북,2^북->남">			
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
		    <tr>
					<td class="tab_a0100">시&nbsp;&nbsp;&nbsp;&nbsp;간</td>
					<td class="tab_b0100">
						<comment id="__NSID__"><OBJECT id=gclx_rm015 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
							style="position:relative;left:4px;top:1px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_rm015">
							<param name=CBDataColumns		value="DETAIL, DETAIL_NM">
							<param name=SearchColumn		value=DETAIL_NM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="DETAIL_NM^0^150">
							<param name=BindColumn			value=DETAIL>
							<param name=Enable          value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script>	
					</td>						
					<td class="tab_a0100">최초여부</td>
					<td class="tab_b0100">
						<comment id="__NSID__"><object id=gcra_firstYN classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:180">
							<param name=Cols	     value="3">
							<param name=CodeValue  value="Y">
							<param name=AutoMargin	value="true">
							<param name=Format	value="^무관,Y^최초,N^기방문">			
						</object></comment><script>__ws__(__NSID__);</script>
					</td>	
					<td class="tab_a0100">출력여부</td>
					<td class="tab_b0000">
						<comment id="__NSID__"><object id=gcra_printYN classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
								style="height:30; width:150">
							<param name=Cols	      value="3">
							<param name= CodeValue  value="Y">
							<param name=AutoMargin	value="true">
							<param name=Format	value="^무관,Y^최초,N^미출">			
						</object></comment><script>__ws__(__NSID__);</script>
					</td>	
				</tr>
			</table>		
		</td>
	</tr>
  <tr><td height=3></td></tr> 
  <tr> 
    <td colspan=2>
		  <div id=d1 style="width:876px; height:410px;">
      <table width="395" cellpadding="0" cellspacing="0" border="0">
				 <tr><td align=center><b>남->북</b></td></tr>
				 <tr> 
						<td>
							<comment id="__NSID__"><OBJECT  id=gcgd_disp1 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:383px;" viewastext>
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
								<param name="Editable"      value="true">
								<param name="sortview"			value=left>
								<param name="Format"				value="  
									<F> Name='No.'			 ID={CURROW} 	HeadAlign=Center HeadBgColor=#EEEEEE Width=30		align=center</F>
									<C> Name='기출력'		   ID=CHK			    HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center editstyle=checkbox HeadCheck=false HeadCheckShow=true editable=true edit=true</C>
									<C> Name='RSV_SID'	 ID=RSV_SID			HeadAlign=Center HeadBgColor=#EEEEEE Width=35	 align=center show=false </C> 
									<C> Name='CUST_SID'	 ID=CUST_SID		HeadAlign=Center HeadBgColor=#EEEEEE Width=35	 align=center show=false </C> 
									<C> Name='직장'	  	 ID=VEND_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=100 align=left   edit=none</C> 
									<C> Name='직위'	  	 ID=POSITIONS		HeadAlign=Center HeadBgColor=#EEEEEE Width=55	 align=center edit=none</C> 
									<C> Name='성명'	  	 ID=CUST_NM			HeadAlign=Center HeadBgColor=#EEEEEE Width=65	 align=center edit=none</C> 
									<C> Name='생년월일'	 ID=BIRTHDAY		HeadAlign=Center HeadBgColor=#EEEEEE Width=60	 align=center edit=none Mask=XX-XX-XX</C> 
									<C> Name='주소'	     ID=ADDRESS			HeadAlign=Center HeadBgColor=#EEEEEE Width=200 align=left edit=none</C> 
									<C> Name='방문목적'	 ID=NORTH_PURPOSE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=left edit=none</C> 
									<C> Name='방문기간'	 ID=ARRIVE_DATE	HeadAlign=Center HeadBgColor=#EEEEEE Width=70	 align=center edit=none Mask=XXXX-XX-XX</C> 
									<C> Name='사진명단번호'	ID=WORK_NO	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center edit=none</C> 
									<C> Name='성별'	     ID=SEXN		  	HeadAlign=Center HeadBgColor=#EEEEEE Width=35	 align=center edit=none editstyle=combo data='1:남,2:여'</C> 
									<C> Name='SNP_YN'	ID=SNP_YN	HeadAlign=Center HeadBgColor=#EEEEEE Width=80	 align=center edit=none show=false</C> 
									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
 							<fieldset id=ft_div1 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt1 style="position:relative;top:4px;left:8px"></font>
							</fieldset>
						</td>
				 </tr>
      </table>
			</div>
		  <div id=d2 style="width:876px; height:410px; display:none">
      <table width="395" cellpadding="0" cellspacing="0" border="0">
				 <tr><td align=center><b>북->남</b></td></tr>
				 <tr> 
						<td>
							<comment id="__NSID__"><OBJECT  id=gcgd_disp2 class="tab_b0111" classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  style="width:877px;height:383px;" viewastext>
								<param name="DataID"				value="gcds_data_2">
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
									<C> Name='기출력'		   ID=CHK			    HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center editstyle=checkbox HeadCheck=false HeadCheckShow=true editable=true edit=true</C>
									<C> Name='RSV_SID'		  ID=RSV_SID			 HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center show=false edit=none</C> 
									<C> Name='CUST_SID'	  	ID=CUST_SID			 HeadAlign=Center HeadBgColor=#EEEEEE Width=50	align=center show=false edit=none</C> 
									<C> Name='성명'	  	    ID=CUST_NM			 HeadAlign=Center HeadBgColor=#EEEEEE Width=65	align=center edit=none</C> 
									<C> Name='국적'	  	    ID=NATION_NAME	 HeadAlign=Center HeadBgColor=#EEEEEE Width=140	align=center edit=none</C> 
									<C> Name='남/여'	      ID=SEXN			     HeadAlign=Center HeadBgColor=#EEEEEE Width=35	align=center edit=none</C> 
									<C> Name='생년월일'	    ID=BIRTHDAY			 HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center edit=none Mask=XXXX-XX-XX </C> 
									<C> Name='입출국증번호'	ID=WORK_NO			 HeadAlign=Center HeadBgColor=#EEEEEE Width=100	align=center edit=none</C> 
									<C> Name='입국날짜'	  	ID=DEPART_DATE	 HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center edit=none Mask=XXXX-XX-XX</C> 
									<C> Name='입국목적'	    ID=NORTH_PURPOSE HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=center edit=none</C> 
									<C> Name='입국전직장'	  ID=VEND_NM	  	 HeadAlign=Center HeadBgColor=#EEEEEE Width=70	align=left   edit=none</C> 
									<C> Name='직위'	        ID=POSITIONS		 HeadAlign=Center HeadBgColor=#EEEEEE Width=60	align=center edit=none</C> 

									<C> Name='NSP_YN'	      ID=NSP_YN		     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false edit=none </C> 
									<C> Name='수정자'	      ID=U_EMPNO		   HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false edit=none</C> 
									<C> Name='수정일'	      ID=U_DATE		     HeadAlign=Center HeadBgColor=#EEEEEE Width=80	align=center show=false edit=none</C> 


									">
							</OBJECT></comment><script>__ws__(__NSID__);</script>
							<fieldset id=ft_div2 style="width:878px;height:20px;background-color:#FFFFFF;border:1 solid #c5c5c5;border-top-width:0px;text-align:LEFT;">
								<font id=ft_cnt2 style="position:relative;top:4px;left:8px"></font>
							</fieldset>
						</td>
				 </tr>
      </table>
			</div>
    </td>
  </tr>
  <tr><td height=3></td></tr>  
</table>
<!--------------------------------- 코딩 부분 끝 --------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

