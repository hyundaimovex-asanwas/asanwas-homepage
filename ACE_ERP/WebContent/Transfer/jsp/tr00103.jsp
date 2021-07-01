<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반출배정조회
+ 프로그램 ID	: TR00103.HTML
+ 기 능 정 의	: 반출배정조회
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
	 <param name=SyncLoad value="false">
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<SCRIPT language=JavaScript>

	get_cookdata();
	
	//lfn_init();
	
	var	lb_boolean1 =  false ; 

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

	function Start(){
			
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc2.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //상태
		gcDs_etc2.Reset() ; 	

		gcDs_etc3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //상차지 
		gcDs_etc3.Reset();

		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //하차지 
		gcDs_etc4.Reset(); 

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //적재구분 
		gcDs_etc5.Reset();

		gcDs_etc6.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00302_popup_s2?v_str1=";  
		gcDs_etc6.Reset();

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;

		FROM_DATE.Text = gs_date ; 
			
		if(gcDsgetdate.CountRow > 0 ) TO_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1");
		
	}

	/******************************************************************************
		Description :  조회
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr0=O"
						 + "&gstr1=" + CAR_SEQ_NO.Text
						 + "&gstr2=" + FROM_DATE.Text
						 + "&gstr3=" + TO_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr5=" + ORDER_NO.Text;

		gcDs1.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsList_ldh?NOH=Y"+parm ; 
		gcDs1.Reset() ; 
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function Excel(){
		ExcelDialog(Grid1,'배정검색') ; 
	}
 
	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoice(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"MINORCD" )  = "" ; 
		obj.NameValue(1,"MINORNM" )  = "=선택 or 입력=" ;   
	}

/******************************************************************************
	Description : 배정 취소 (2008.11.06)
	              관리자가 직접 배정을 취소한다.
******************************************************************************/ 
function ln_Cancel(){
  var strChkGb="";
	
	if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){ //접수된건
		for(i=1;i<=gcDs1.CountRow;i++){
			if(gcDs1.namevalue(i,"CHECK")=="T"){
				strChkGb="Y";
				if(gcDs1.namevalue(i,"EDI_STS")!="S"&&gcDs1.namevalue(i,"EDI_STS")!="A"&&gcDs1.namevalue(i,"EDI_STS")!="Y"){
					alert("EDI 전송이 되지 않았습니다. 취소할 수 없습니다.");
					return false;
				}
			}
		} 

		if(strChkGb!="Y"){
			alert("주문취소할 데이터를 선택하십시요.");
			return false;
    }
	}else{
		alert("EDI 전송전 제출건은 취소를 하지 말고 삭제하십시요.");
	}

	if (confirm("선택하신 주문정보의 상태를 취소하시겠습니까 ?")){
	
		gcTr01.KeyValue = "trOrdCarCancel(I:USER=gcDs1)";
		
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrdCarCancel";

		gcTr01.post();
	}
}

 </SCRIPT> 

 <script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)> 
	AddChoice(gcDs_etc1) ; 
	LINE_PART.Index = 0 ; 
</script>

 <!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event="OnLoadStarted()">
	OnStatusStart() ; 
 </script> 

<!-----------------------------------------------------------------------------
		G A U C E   C O M P O N E N T' S
		Tranaction    E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 <script language=JavaScript for=gcTr01 event=OnSuccess()>
		alert("주문 취소를 완료하였습니다.");
</script>

<script language=JavaScript for=gcTr01 event=OnFail()>
  alert("Error Code : " + gcTr01.ErrorCode + "\n" + "Error Message : " + gcTr01.ErrorMsg + "\n");
</script>
<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
	//TheStatusEnd(row) ; 
</script>


</head>
<jsp:include page="/Common/sys/body_s07.jsp"  flush="true"/>
<BODY>

	<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td width="876" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
			  <img src="../../../Common/img/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">
				<img src="../../../Common/img/com_b_excel.gif"  style="cursor:hand" onclick="Excel()"> 
				<img src="../../../Common/img/com_b_query.gif"  style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>반출일자</td>
						<td class="tab12_left" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:4px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('FROM_DATE', 'Text');">
							<font style="position:relative;top:-2px;">~</font> &nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative; left:0px;top:1px;cursor:hand" onclick="__GetCallCalendar('TO_DATE', 'Text');">
						</td>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>주문번호</td>
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
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee"  width=75>배정번호</td>
						<td class="tab12_left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=CAR_SEQ_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>     
						</td>
						<td class="tab12_left" style="text-align:center" bgcolor="#eeeeee" width=75>사업명</td>
						<td>&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:0px;top:2px;width:160px;height:200;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
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
				<table  cellpadding="0" cellspacing="0" border="0" style="width:870px;height:300px;font-size:9pt;background-color:#ffffff;border:0 solid #708090" >
					<tr>
						<td class=tab12_left  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:876px;height:443px;border:1 solid #777777;border-right-width:0px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true">  
								<PARAM NAME="Format"			VALUE="  
									<F> Name='No.'	ID=GRAYY HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center Value={ToString(RowCount-CurRow+1)}  edit=none </F> 
									<F>	Name=''	    ID=CHECK,  width=20 EditStyle=CheckBox	Pointer=Hand 	HeadBgColor=#eeeeee HeadCheckShow=true align=center  bgcolor={IF(ING_STS='C','Gold')} </F>
									<G> Name='배정정보' HeadBgColor=#D5EDFB 
										<C> Name='반출일자'			ID=EDT_DATE		 HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none MASK='XXXX-XX-XX'   </C> 
									  <C> Name='상태'					ID=ORDER_STS	 HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none EditStyle=Lookup Data='gcDs_etc2:MINORCD:MINORNM' edit=none,  show=false</C> 
									  <C> Name='화주'					ID=SHIPPER		 HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left,   bgcolor={IF(ING_STS='C','Gold')} edit=none </C> 
									  <C> Name='상차지'				ID=LD_CARGONM	 HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left,   bgcolor={IF(ING_STS='C','Gold')} edit=none </C> 
									  <C> Name='하차지'				ID=OFF_CARGONM HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left,   bgcolor={IF(ING_STS='C','Gold')} edit=none </C> 
										<C> Name='배정번호'			ID=CAR_SEQ_NO  HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none </C>  
										<C> Name='반출/반입'			ID=IN_OUT			 HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none Value={Decode(IN_OUT,'I','반입','O','반출','반출')} show=false</C>
										<C> Name='구분'					ID=TYPE				 HeadAlign=Center HeadBgColor=#eeeeee Width=50  align=center  bgcolor={IF(ING_STS='C','Gold')} show=false</C>										
										<C> Name='차량종류'			ID=CARTYPENO	 HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left    bgcolor={IF(ING_STS='C','Gold')} edit=none EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME'</C> 
										<C> Name='주문번호'			ID=ORDER_NO		 HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center  bgcolor={IF(ING_STS='C','Gold')} show=false</C>  
										<C> Name='PROJECT'			ID=LINE_PART	 	HeadAlign=Center HeadBgColor=#eeeeee Width=140 align=left    bgcolor={IF(ING_STS='C','Gold')} edit=none EditStyle=Lookup Data='gcds_etc1:MINORCD:MINORNM' show=false</C>
										<C> Name='입고예정일자'		ID=LD_DATE		 	HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=center  bgcolor={IF(ING_STS='C','Gold')} MASK='XXXX-XX-XX' show=false</C>
										<C> Name='대표품목'			ID=CTN_STDRD	 HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left    bgcolor={IF(ING_STS='C','Gold')} edit=none </C> 
									</G>

									<G> Name='배차정보' HeadBgColor=#FAFCA7
										<C> Name='차량번호'			ID=CAR_NO			 HeadAlign=Center HeadBgColor=#eeeeee Width=115 align=right   bgcolor={IF(ING_STS='C','Gold')} edit=none</C> 
										<C> Name='운전자번호'		ID=PERSON_NO	 HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=center, bgcolor={IF(ING_STS='C','Gold')} show=false</C>
										<C> Name='운전자명'			ID=PERSON_NO	 HeadAlign=Center HeadBgColor=#eeeeee Width=65  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none EditStyle=Lookup Data='gcDs_etc6:person_no:prsn_name'</</C>
										<C> Name='출발시간'			ID=START_TIME  HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none MASK='XX:XX'</C>
										<C> Name='복귀일자'			ID=RTRN_DATE	 HeadAlign=Center HeadBgColor=#eeeeee Width=70  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none MASK='XXXX-XX-XX'</C>
										<C> Name='복귀시간'			ID=RTRN_TIME	 HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=center  bgcolor={IF(ING_STS='C','Gold')} edit=none MASK='XX:XX'</C>
									</G>
									<C> Name='전송상태' 		ID=EDI_STS  	HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='1:미전송,S:전송중,Y:전송완료' bgcolor={IF(ING_STS='C','Gold')}</C>   
									<C> Name='상태' 		ID=ING_STS  	HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='X:삭제,U:수정,C:취소,I:신규'  bgcolor={IF(ING_STS='C','Gold')}</C>          
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table> 
			</td>
		</tr> 
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

