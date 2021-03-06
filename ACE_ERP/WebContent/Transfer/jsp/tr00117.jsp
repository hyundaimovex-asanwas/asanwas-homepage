<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 P/L & C/I 검색
+ 프로그램 ID	:	TR00117.HTML
+ 기 능 정 의	:	P/L & C/I 검색
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


<SCRIPT language=JavaScript>
	get_cookdata();

	var lb_boolean1 =  false ; 
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
		Description :
	******************************************************************************/ 
	function Start(){
	
		//OnStatusStart() ; 
		FROM_DATE.Text = gs_date ; 
		
		TO_DATE.Text = gs_date ; 
		
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();
		
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //상차지 
		gcDs_etc2.Reset();
		
		gcDs_etc11.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsProject_s01?v_str1="; //물류비 부담
		gcDs_etc11.Reset();		
		
		//TheStatusEnd1() ; 
	
		if(location.search){
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];
			var str3=location.search.split("&")[3];
			var str4=location.search.split("&")[4];
		}	

		if (str1=="" || str1==undefined){
		
			FROM_DATE.Text = gs_date ;
			
			gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
			gcDsgetdate.Reset() ;
			
			//if(gcDsgetdate.CountRow > 0 ) TO_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1");		
			TO_DATE.Text = gs_date ; 
				
		} else {
		
			FROM_DATE.Text		= str1;
			
			TO_DATE.Text	= str2;
			
			LINE_PART.index		= LINE_PART.IndexOfColumn("MINORCD", str3);
			
			SEARCH_TYPE.index		= SEARCH_TYPE.IndexOfColumn("MINORCD", str4);
			
		}	
		
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Disp_Detail(){
	
		if(lb_boolean1 == false ) {
			document.all.Grid1.style.width = "100%" ; 
			document.all.tddetail.style.display = 'none' ; 
			lb_boolean1 = true ; 
		} else {
			document.all.Grid1.style.width = "500px" ; 
			document.all.tddetail.style.display = 'block' ; 
			lb_boolean1 = false ;  
			
		}
		
	}

	/******************************************************************************
		Description : 조회
	******************************************************************************/ 
	function ln_Query(){
	  var parm = "&gstr0=O"
						 + "&gstr1=" + PL_NO.Text
						 + "&gstr2=" + SHIPPERNM.value
						 + "&gstr3=" + FROM_DATE.Text
						 + "&gstr4=" + TO_DATE.Text
						 + "&gstr5=" + LINE_PART.BindColVal
						 + "&gstr6=" + ORDER_NO.value;
		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsPlMaster?NOH=Y" +parm ; 

		gcDs1.Reset() ; 
	}

	/******************************************************************************
		Description :  ADD COMBO == "선택" 
	******************************************************************************/
	function AddChoiceProjct(obj){
		obj.InsertRow(1) ; 
		obj.NameValue(1,"TR_PROJECT" )  = "" ; 
		obj.NameValue(1,"USE_PROJNM" )  = "=선택 or 입력=" ;  
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ls_EDI(){
	//alert("개발중!");
		var strURL = "TR00117_EDI.html";
		var myW = 730;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,window,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");	
	}
</SCRIPT> 

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	LINE_PART.index = 0 ; 
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT> 

<OBJECT id=gcDs_etc11 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad		value="true">
	 <param name=UseFilter	value="true">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
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

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDs1 event="OnLoadStarted()">
	//OnStatusStart() ; 
 </script> 

<script language=JavaScript for=gcDs1  event="onloadCompleted(row,colid)">
	//TheStatusEnd(row) ; 
</script>

<script language=JavaScript for=gcGR1 event=OnDblClick(row,colid)>
	window.location.href="../../Transfer/html/TR00111.html?gstr1=update&gstr2="+strim(gcDs1.NameValue(row,"PL_NO")) ; 
</script>


<script language=JavaScript for=LINE_PART event=OnSelChange2(row)>
	gcDs_etc11.Filter();
</script>

<script language=JavaScript for=gcDs_etc11 event=onFilter(row)>
	if (gcDs_etc11.NameValue(row,"LINE_PART") == LINE_PART.BindColVal) return true;
	else return false;
</script>

<script language=JavaScript for=gcDs_etc11 event=OnRowsetChanged()>
	if (gcDs_etc11.namevalue(1,"TR_PROJECT")!=""){
		AddChoiceProjct(gcDs_etc11) ; 
		PROJECT.Index = 0 ; 
	} else {
		gcDs_etc11.UndoAll();
	}
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
			<td><img src="../img/TR00117_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
  				<img src="../img/btn/btn_edi.gif" style="cursor:hand" onclick="ls_EDI()">
				<img src="../img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr>
			<td colspan=2>
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11" bgcolor="#eeeeee" width=100>반출일자</td>
						<td class="tab11_left" style="width:350px">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:4px; width:63px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:8px;top:1px;cursor:hand" onclick="__GetCallCalendar('FROM_DATE', 'Text');">
							<span style="position:relative;left:10px;top:-3px">~</span>
					    <%=HDConstant.COMMENT_START%>
					    <OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:20px;top:4px; width:63px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:22px;top:1px;cursor:hand" onclick="__GetCallCalendar('TO_DATE', 'Text');"> 
						</td>
						<td class="tab11" bgcolor="#eeeeee"  width=100>P/L, C/I No</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PL_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:100px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="############">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td> 
					</tr> 
					<tr>
						<td class="tab11" bgcolor="#eeeeee">송하인</td>
						<td class="tab11_left"><input id="SHIPPERNM" name="SHIPPERNM" type="text" class="txt11" style='width:205;position:relative;left:8px;top:0px;ime-mode:active' ></td> 
						<td class="tab11" bgcolor="#eeeeee">사업명</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:0px;width:160px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn			value=MINORNM>
								<param name=SortColumn				value="MINORCD"> 
								<param name=Sort							value=True>
								<param name=ListExprFormat			value="MINORNM^0^160">
								<param name=BindColumn				value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor				value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td> 
					</tr>
					<tr>
						<td class="tab12" bgcolor="#eeeeee">주문번호</td>
						<td class="tab12_left">
							<input id="ORDER_NO" name="ORDER_NO" type="text" class="txt11" style='width:105;position:relative;left:8px;top:0px' >
						</td> 
						
						<td class="tab12" bgcolor="#eeeeee">물류비 부담</td>
						<td class="tab14_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PROJECT  style='border:0;position:relative;left:8px;top:2px;width:220px;height:300' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc11">  
								<param name=SearchColumn			value="USE_PROJNM">
								<param name=SortColumn				value="TR_PROJECT"> 
								<param name=ListExprFormat			value="USE_PROJNM^0^195">
								<param name=BindColumn				value="TR_PROJECT">
								<param name=InheritColor				value="true"> 
								<param name=ComboStyle				value="2">
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
					<!-- <tr><td bgcolor="#eeeeee" align=right class=tab11><input id="txt_hobby1" name="txt_hobby1" type="text" class="txt31" style='width:54;position:relative;left:0px;top:-2px' value=" 차량종류 : ">&nbsp;
					<%=HDConstant.COMMENT_START%><OBJECT id=Project classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:0px;top:3px;font-size:12px;width:130px;"  >
									<param name=ComboDataID			value="gcds_before">
									<param name=CBDataColumns		value="INFODIV, DSPNM">
									<param name=SearchColumn		value="DSPNM">
									<param name=Sort						value="false">
									<param name=ListExprFormat	value="DSPNM^0^250">
									<param name=BindColumn			value="INFODIV">
								</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%><OBJECT id=tb_Radio classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
                       style="height:15; width:135"> 
                           <param name=Cols     value="3"> 
                           <param name=Format value="1^전체,2^배정,3^미정"> 
                     </OBJECT><%=HDConstant.COMMENT_END%>  &nbsp;&nbsp;&nbsp;
					</td><td bgcolor="#eeeeee" align=right class=tab11> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <%=HDConstant.COMMENT_START%><OBJECT id=tb_Radio classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 
                       style="height:15; width:150"> 
                           <param name=Cols     value="3"> 
                           <param name=Format value="1^전체,2^배정,3^미정"> 
                     </OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="../img/btn/b_save.gif" style="cursor:hand" style="position:relative;left:0px;top:2px" onclick="ln_Query()">
					</td>
					</tr>  -->
					<tr><td height=20 bgcolor=#FFFF99 colspan=2><B>&nbsp;&nbsp;주문정보 : </B></td></tr>
					<tr>
						<td colspan=2 style="border:0 solid #777777;border-top-width:1px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:100%;height:381px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"				VALUE="gcDs1">
								<PARAM NAME="TitleHeight" 		VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" 		VALUE="0">
								<PARAM NAME="Fillarea"				VALUE="true">
								<PARAM NAME="Editable"				VALUE="false">
								
								<PARAM NAME="ColSelect"			VALUE="true"> 
								<param name="ColSizing" 			value="1">
								<PARAM NAME="IndWidth"			VALUE="17">								
								<param name="AllShowEdit" 		VALUE="true">
								<PARAM NAME="Format"				VALUE="   
									<F> Name='No.'				ID='SeralNo'		HeadAlign=Center HeadBgColor=#e8e8e8 Bgcolor='#efefef' align=center	width=25 value={ToString(RowCount-CurRow+1)}	</F> 
									<C> Name='PL/CI No'		ID=PL_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center</C> 
									<C> Name='출발일자' 		ID=START_DT		HeadAlign=Center HeadBgColor=#eeeeee Width=75		align=center  MASK='XXXX-XX-XX'   </C>
									
									<C> Name='송하인'   		ID=PL_SHPPRNM HeadAlign=Center HeadBgColor=#eeeeee Width=80  		align=left   </C>  
									<C> Name='수화인'			ID=PL_CSTMNM	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=left   </C>  

									<C> Name='출발시간'		ID=START_TIME 	HeadAlign=Center HeadBgColor=#eeeeee Width=60		align=center  MASK='XX:XX', show=false  </C>
									<C> Name='출발지'			ID=START_LCT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center EditStyle=Lookup Data='gcDs_etc2:MINORCD:MINORNM'</C> 
									<C> Name='도착지'  		ID=REACH_LCT	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center EditStyle=Lookup Data='gcDs_etc2:MINORCD:MINORNM'</C> 
									<C> Name='대표품목' 		ID=RPR_GOODS	HeadAlign=Center HeadBgColor=#eeeeee Width=110  	align=left</C> 
									<C> Name='총중량'   		ID=T_WEIGHT  		HeadAlign=Center HeadBgColor=#eeeeee Width=75		align=right </C>  
								 	<C> Name='총용적'   		ID=T_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=75		align=right</C> 
									<C> Name='주문번호' 		ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center</C>
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
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

