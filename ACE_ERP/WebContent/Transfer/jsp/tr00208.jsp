<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반입주문조회
+ 프로그램 ID	: TR00208.HTML
+ 기 능 정 의	: 입고정보
+ 변 경 이 력	: 정미선
+ 작성일자 :
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 :
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>


<!-- /******************************************************************************
	Description : DataSet 선언
******************************************************************************/ -->    
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
	 <param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad 	value="true">
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">
</OBJECT>
<%=HDConstant.COMMENT_END%>

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_seq = null ; 
    var gs_date = '<%=firstday%>';
	var gs_date1 = gs_date.substring(0,6) + "01";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]

			Start();//선조회

			window.status="완료";

		}
	/******************************************************************************
		Description :  START 등록 
	******************************************************************************/
	function Start(){

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //
		gcDsgetdate.Reset() ;
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc13.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //단위 
		gcDs_etc13.Reset(); 

		ENTER_DATE.Text = gs_date;	
		
		ETD_DATE.Text = gcDsgetdate.NameValue(1,"APP_DT1");

		
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function INWareHouse(row){	
	
		gs_ordno = gcDs2.NameValue(row,"ORDER_NO") ; 
		gs_seq = gcDs2.NameValue(row,"ORDER_SEQ") ; 

		gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsInWRHS?NOH=Y&gstr4="+gs_ordno + "&gstr5="+gs_seq ; 
		gcDs1.Reset() ; 
		
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function AddWRHS(){
		if( strim(ENTER_DATE.Text) == "") { 
			alert("입고일자를 입력하십시오 !!") ; 
	    return false ;  
		}

		gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsInWRHS?NOH=N"; 
		gcDs1.Reset() ; 

		var ls_check = null ;
		var ls_row = null ; 

		for(var cnt=1 ; cnt<=gcDs2.CountRow ;cnt++) {
			ls_check = gcDs2.NameValue(cnt,"CHECK") ;
			if( ls_check == "T"){

				gcDs1.AddRow() ; 	
				ls_row = gcDs1.RowPosition ; 
				gcDs1.NameValue(ls_row,"ORDER_NO")			= gcDs2.NameValue(cnt,"ORDER_NO") ; 
				gcDs1.NameValue(ls_row,"ORDER_SEQ")			= gcDs2.NameValue(cnt,"ORDER_SEQ") ; 
				gcDs1.NameValue(ls_row,"ARTC_NM")				= gcDs2.NameValue(cnt,"ARTC_NM") ;  
				gcDs1.NameValue(ls_row,"ARTC_CNT")			= gcDs2.NameValue(cnt,"ARTC_CNT") ; 
				gcDs1.NameValue(ls_row,"PKG_LNGTH")			= gcDs2.NameValue(cnt,"PKG_LNGTH") ; 
				gcDs1.NameValue(ls_row,"PKG_HEIGHT")		= gcDs2.NameValue(cnt,"PKG_HEIGHT") ; 
				gcDs1.NameValue(ls_row,"PKG_WIDTH")			= gcDs2.NameValue(cnt,"PKG_WIDTH") ; 
				gcDs1.NameValue(ls_row,"PUNIT_WEIGHT")	= gcDs2.NameValue(cnt,"PUNIT_WGHT") ;   
				gcDs1.NameValue(ls_row,"PKG_CNT")				= gcDs2.NameValue(cnt,"PKG_CNT") ;  
				gcDs1.NameValue(ls_row,"PKG_CBM")				= gcDs2.NameValue(cnt,"PKG_CBM") ;  
				gcDs1.NameValue(ls_row,"TOTAL_CBM")			= gcDs2.NameValue(cnt,"PKG_CNT") * gcDs2.NameValue(cnt,"PKG_CBM") ;  
				gcDs1.NameValue(ls_row,"TOTAL_WEIGHT")	= gcDs2.NameValue(cnt,"PKG_CNT") * gcDs2.NameValue(cnt,"PUNIT_WGHT") ;  
				gcDs1.NameValue(ls_row,"ENTER_DATE")		= ENTER_DATE.Text ;
				 
				gcDs1.NameValue(ls_row,"ENTER_NO") ='자동부여' ;

				if(gcDs2.NameValue(cnt,"LINE_PART") =="0001") gcDs1.NameValue(ls_row,"WAREHOUSE") ='0001' ; 
				else gcDs1.NameValue(ls_row,"WAREHOUSE") ='0002' ;
			}
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function SAVEWRHS(){
		if (!gcDs1.isUpdated) return;

		if (confirm("입력하신 입고정보를 저장하시겠습니까 ? ")){
			for(var cnt =1 ;cnt<=gcDs1.countRow ;cnt++){
				gcDs1.NameValue(cnt,"GOODS_SEQ") = cnt ;  
			}
			
			gcTr01.KeyValue = "trInWRHS(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trInWRHS";
			gcTr01.Parameters = "gstr1="+ENTER_DATE.Text ; //주문번호 
			gcTr01.post();
		}
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Query(){
		imgAll.style.display = "";
		imgAllCancle.style.display = "none";

		var parm = "&gstr1=" + ORDER_NO.Text
						 + "&gstr2=" + ETD_DATE.Text
						 + "&gstr3=" + LINE_PART.BindColVal
						 + "&gstr4=I"
						 + "&gstr5=" + CUST_NM.value;
	
		gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderdetail_1?NOH=Y" +parm ; 
		gcDs2.Reset() ;
	}

	/******************************************************************************
		Description : 동일포장 선택
	******************************************************************************/
	function CheckSameAS(row){
		var ls_value = gcDs2.NameValue(row,"CHECK") ; 

		if(gcDs2.NameValue(row,"MIX_OTHERS") =="T" ){ 

				var ls_no = gcDs2.NameValue(row,"SAMEAS") ; 
				var ls_orderno= gcDs2.NameValue(row,"ORDER_NO") ; 
				var ls_orderno1 = null ; 
				var ls_no1 = null ; 

				for(i=1;i<gcDs2.CountRow ; i++){  
					ls_orderno1 = gcDs2.NameValue(i,"ORDER_NO") ; 
					ls_no1 = gcDs2.NameValue(i,"SAMEAS") ; 

					if(ls_orderno == ls_orderno1 && ls_no == ls_no1 ) { // 주문번호와 포장번호가 동일할 경우
						if (ls_value=="T") gcDs2.NameValue( i ,"CHECK")  = "" ; 
						else gcDs2.NameValue( i ,"CHECK")  = "T" ; 
					}
				} 

		} else {
			if (ls_value=="T") gcDs2.NameValue( row ,"CHECK")  = "" ; 
			else gcDs2.NameValue( row ,"CHECK")  = "T" ; 
		}
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectAll(){
		for(var i=1;i<=gcDs2.CountRow ; i++){
			gcDs2.NameValue(i,"CHECK") = "T" ;   
		}
		imgAllCancle.style.display = "" ; 
		imgAll.style.display = 'none' ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectCancle() {
		for(var i=1;i<=gcDs2.CountRow ; i++){
			gcDs2.NameValue(i,"CHECK") = "" ;   
		}

		imgAllCancle.style.display = "none" ; 
		imgAll.style.display = '' ; 
	}
</SCRIPT> 

<script language=JavaScript for=gcDs2 event=OnLoadCompleted(rowcnt)>
	if(gcDs2.CountRow > 0 ) INWareHouse(1);
</script>

<script language=JavaScript for=Grid1 event=OnClick(row,colid)>  
   if ( colid == "CHECK") CheckSameAS(row);
   else INWareHouse(row) ;
</script>

<script language=JavaScript for=gcDs2 event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language=JavaScript for=gcDs2  event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";

	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language=javascript for=gcTr01 event=onSuccess()>
	gcDs1.Reset();
	gcDs2.Reset();
	alert("정상적으로 입고정보가 저장되었습니다.");
</script>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>

</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>

	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:20px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=75>반입일자</td>
						<td class="tab12_left" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee"  width=75>주문번호</td>
						<td class="tab12_left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=75>업체명</td>
						<td class="tab12_left" >&nbsp;<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:150;position:relative;left:0px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee" width=75>Project</td>
						<td>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:0px;top:2px;height:220;width:160px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr>
				</table> 
			</td>
		</tr> 
		<tr><td height=5></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=20 bgcolor=#FFFF99 ><B>&nbsp;&nbsp;주문정보</B></td>
						<td height=20 bgcolor=#FFFF99 align=right>
							<img id=imgAll src="../../../Common/img/btn/btn_all.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="__SelectAll();" alt="주문정보를 전체 선택합니다.">&nbsp;
							<img id=imgAllCancle src="../../../Common/img/btn/btn_all_cancel.gif" style="position:relative;left:-6px;top:2px;display:none;cursor:hand" onclick="__SelectCancle();"  alt="선택한 주문정보를 취소합니다.">
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:100%;height:242px;border:0 solid #777777;border-top-width:1px;border-bottom-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs2">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="ColSizing"  value="true">  
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='◈'					ID=CHECK			HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center, edit=none, EditStyle=CheckBox, cursor=hand</F>  
									<F> Name='주문번호'		ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center,	edit=none</F>  
									<F> Name='업체명'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left,		edit=none</F> 
									<C> Name='No.'				ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none</C>   
									<C> Name='품명'				ID=ARTC_NM  	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left   edit=none</C>  
									<C> Name='규격'				ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left edit=none, show=false</C>
									<C> Name='단위'				ID=ARTC_UNIT	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=left edit=none, editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM'</C>
									<C> Name='수량'				ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right,edit=none </C> 
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이(CM)'		ID=PKG_LNGTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='폭(CM)'			ID=PKG_WIDTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='높이(CM)'		ID=PKG_HEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='용적(CBM)'	ID=PKG_CBM  	HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=right </C>  
										<C> Name='중량(KG)'		ID=PUNIT_WGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
										<C> Name='포장수량'		ID=PKG_CNT	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
									</G>
									<C> Name='포장수량'			ID=MIX_OTHERS HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='포장수량'			ID=SAMEAS			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='총용적(CBM)'	ID=T_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PKG_CBM * PKG_CNT } dec =2</C>
									<C> Name='총중량(KG)'		ID=T_WEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PUNIT_WGHT * PKG_CNT } dec =2</C>
								  <C> Name='차량'					ID=CAR_NO   	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=center edit=none  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td height=20  ><B>&nbsp;&nbsp;입고정보 </B></td>
						<td align=right><font style="position:relative;top:-4px;left:-2px;">(입고일자 :</font>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ENTER_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:0px;top:0px;cursor:hand" onclick="__GetCallCalendar('ENTER_DATE', 'Text');"><font style="position:relative;top:-4px;left:2px;">)</font>&nbsp;
							<img src="../../../Common/img/btn/b_write.gif"  style="position:relative; left:0px;top:2px;cursor:hand" onclick="AddWRHS();" alt="입고정보를 작성합니다.">
							<img src="../../../Common/img/btn/b_save.gif" style="position:relative; left:0px;top:2px;cursor:hand" onclick="SAVEWRHS();" alt="입력한 입고정보를 저장합니다.">&nbsp;
						</td>
					</tr>
					<tr> 
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid2 style="width:100%;height:302px;border:1 solid #777777;border-bottom-width:0px;border-left-width:0px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true">  
								<PARAM NAME="ViewSummary"	value="1">
								<PARAM NAME="Format"			VALUE="
									<F> Name='No.',				ID=SeralNo 				HeadAlign=Center HeadBgColor=#e8e8e8 Width=25		Align=Center	Value={ToString(RowCount-CurRow+1)}	</F>
									<C> Name='입고일자'		ID=ENTER_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=left Mask='XXXX-XX-XX'</C>  
									<C> Name='입고번호'		ID=ENTER_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=90   align=center</C>  
									<C> Name='물류창고'		ID=WAREHOUSE		HeadAlign=Center HeadBgColor=#eeeeee Width=115  align=center Value={Decode(WAREHOUSE,'0001','파주물류센터','0002','고성물류센터')}</C> 
									<C> Name='SEQ'				ID=GOODS_SEQ		HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center</C>
									<C> Name='물품명'			ID=ARTC_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=115	align=left</C>
									<C> Name='수량'				ID=ARTC_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none SumText=@sum</C> 
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이(CM)'		ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='폭(CM)'			ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='높이(CM)'		ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='용적(CBM)'	ID=PKG_CBM  			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right </C> 
										<C> Name='중량(KG)'		ID=PUNIT_WEIGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none  SumText=@sum</C> 
										<C> Name='포장수량'		ID=PKG_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none SumText=@sum</C> 
									</G>
									<C> Name='총용적(CBM)'		ID=TOTAL_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none </C>
									<C> Name='총중량(KG)'		ID=TOTAL_WEIGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none </C>
									 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
					</tr> 
				</table> 

			</td>
		</tr>
		<tr><td style="height:10px;"></td></tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->

</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

