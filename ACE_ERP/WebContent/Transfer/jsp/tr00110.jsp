<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반츨 P/L 및 C/I 생성
+ 프로그램 ID	:	TR00110.HTML
+ 기 능 정 의	:	반출 P/L 및 C/I 생성
+ 변 경 이 력	:	정미선
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

	var	lb_boolean1 =  false ; 
	var gs_ordno = null ; 
	var gs_plno = null ; 
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

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();
		
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0003";  //납품구분 
		gcDs_etc2.Reset(); 
		
		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e4?NOH=Y";  //적재구분 
		gcDs_etc5.Reset();

		PL_FLAG.index = 2 ; 
		ETD_DATE.Text = gs_date ; 
	}
 
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
  
	  //2007.11.20 정영식추가 

		var parm = "&gstr6=" + ORDER_NO.Text
						 + "&gstr11=" + ETD_DATE.Text
						 + "&gstr2=" + ETD_DATE.Text
						 + "&gstr3=" + ETD_DATE.Text
						 + "&gstr4=" + LINE_PART.BindColVal
						 + "&gstr12=O"
						 + "&gstr10=" + CUST_NM.value  
						 + "&gstr13=" + PL_FLAG.BindColVal ; 

		gcDs1.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsMakePl3?NOH=Y"  + parm; 

		gcDs1.Reset() ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Excel(){
	
		ExcelDialog(Grid1,'반출 PL 및 CI 리스트') ; 
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectAll(){
	
		for(var i=1;i<=gcDs1.CountRow ; i++){
			gcDs1.NameValue(i,"CHECK") = "T" ;   
		}
//		imgAllCancle.style.display = "" ; 
		imgAll.style.display = 'none' ; 
	}

	/******************************************************************************
		Description : PACKING LIST 요청
	******************************************************************************/ 
	function MakingPl(){
	
		var row =  null ; 
		var ls_plflag = null ; 
		var ls_check = null ; 
		var ls_cnt1  =  0 ; 
		var S = '' ; 
		var batch_orderno = '' ; 

		for(var ls_cnt=1; ls_cnt<=gcDs1.CountRow; ls_cnt++){
		  ls_plflag = gcDs1.NameValue(ls_cnt,"PL_TYPE" ) ; 
		  ls_check = gcDs1.NameValue(ls_cnt,"CHECK" ) ; 

	    if(	ls_plflag == "Y" && ls_check=="T" ){ // Pl요청한 건들 : 주문등록시 PL 신청 체크한건 (ls_plflag="Y")
				MakingPl_Y(ls_cnt) ;  
			} else if( ls_plflag != "Y" && ls_check=="T" && ls_plflag != "C")	{ //PL 및 CI 생성에서 직접 생성하는 건들   
				batch_orderno = batch_orderno + gcDs1.NameValue(ls_cnt,"ORDER_NO") + '/' ;  //주문번호를 가져감.
				ls_cnt1++;  
			}  
		}
	
 		if( ls_cnt1 > 0 ) { 
			if (confirm("주문번호가 정확합니까?")){
				alert("batch_orderno::"+batch_orderno);
				window.location.href="../../Transfer/html/TR00111.html?gstr1=make&gstr2="+batch_orderno+"&" + LINE_PART.bindcolval + "/" + ETD_DATE.text ; 
			}
		} 		
		//else alert("PL 작성을 위한 주문   정보를 선택해 주십시오!!!");
	}

	/******************************************************************************
		Description : PL개별 요청한 PACKING  LIST 작성
	******************************************************************************/ 
	function MakingPl_Y(row){
	
		var order_no = gcDs1.NameValue(row,"ORDER_NO") ; 

		gcTr01.KeyValue = "trMakingPl(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trMakingPl";
		gcTr01.post();
		gcDs1.Reset();
		
	}

</SCRIPT>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcDs1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=true>  
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad				value="false">
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
<script language=JavaScript for=Grid1 event=OnClick(row,colid)> 
	if (colid=="CHECK"){
		if( gcDs1.NameValue(row,"PL_TYPE")=="C"||gcDs1.NameValue(row,"PL_TYPE")=="A"){
			alert("Packing List 가 존재합니다. " ) ; 
		} else {
			var ls_chk = gcDs1.namevalue(row,colid);
			if (strim(ls_chk)=="" || strim(ls_chk)=="F") gcDs1.namevalue(row,colid)="T";
			else gcDs1.namevalue(row,colid) = gcDs1.OrgNameValue(row,colid);
		}
	}
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
  //2007.11.20 정영식 막음.
	/*
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	LINE_PART.index = 0 ; 
	*/
</script>

<script language=JavaScript for=Grid1 event=OnDblClick(row,colid)>
	window.location.href="../../Transfer/html/TR00111.html?gstr1=update&gstr2="+strim(gcDs1.NameValue(row,"PL_NO")) ; 
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
			<td><img src="../img/TR00110_head_1.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="../img/btn/b_plwrite.gif"  style='cursor:hand' onclick="MakingPl();" >
				<img src="../img/com_b_excel.gif" style="cursor:hand" onclick="ln_Excel();">
				<img src="../img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11" bgcolor="#eeeeee" style="height:30px;width:100px;">반출일자</td>
						<td class="tab11_left" style="width:140px">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:4px; width:63px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:10px;top:1px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab11" bgcolor="#eeeeee"  width=100>주문번호</td>
						<td class="tab11_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab11" style="width:100px;" bgcolor="#eeeeee">PL/CI요청</td>
						<td class="tab13_left" style="width:150px;">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PL_FLAG style='border:0;position:relative;left:8px;top:1px;height:150' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 width=90>
								<param name=CBData					value="^전체,Y^개별요청,N^일반">
								<param name=CBDataColumns		value="DIVCODE,DIVNAME">
								<param name=SearchColumn		value=DIVNAME>
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="DIVNAME^0^50">								
								<param name=BindColumn			value="DIVCODE">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
					<tr>
						<td class="tab12" bgcolor="#eeeeee" style="height:30px;width:100px;">업체명</td>
						<td class="tab12_left"><input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:205;position:relative;left:8px;top:0px'></td> 
						<td class="tab12" bgcolor="#eeeeee">사업명</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;height:110;width:160px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 >
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
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
					<td height=20 bgcolor=#FFFF99 colspan=2><B>&nbsp;&nbsp;주문정보 : </B>
							<img id=imgAll src="../img/btn/btn_all.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="__SelectAll();"  alt="주문정보를 전체 선택합니다."> 
					</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:100%;height:401px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"		VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="0">
								<PARAM NAME="ColSelect"		VALUE="true"> 
								<param name="ColSizing"   value="1">
								<PARAM NAME="IndWidth"		VALUE="17">								
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<F> Name='◈'					ID='CHECK'		HeadAlign=Center HeadBgColor=#eeeeee Width=20		align=center EditStyle=CheckBox, cursor=hand, edit=none, bgcolor=@ucolor</F>
									<F> Name='No.'				ID='SeralNo' 	HeadAlign=Center HeadBgColor=#e8e8e8 Width=30		align=center bgcolor='#efefef' value={ToString(RowCount-CurRow+1)}	</F> 
									<F> Name='PL요청'			ID=PL_TYPE		HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=center edit=none Value={Decode(PL_TYPE,'Y','개별요청','C','완료','A','완료','일반')}</C></F> 
									<C> Name='PL/CI No'   ID=PL_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center edit=none</C> 
									<C> Name='반출일자'   ID=ETD_DT			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center MASK ='XXXX-XX-XX' edit=none</C>
									<C> Name='신청업체명' ID=CUST_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=180  align=left edit=none</C> 
									<C> Name='담당자'     ID=CUST_PRSN  HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=left edit=none,  show=false </C>  
								 	<C> Name='실화주'     ID=SHIPPER_NM HeadAlign=Center HeadBgColor=#eeeeee Width=180  align=left edit=none</C> 
									<C> Name='대표품목'   ID=CTN_STDRD  HeadAlign=Center HeadBgColor=#eeeeee Width=110	align=left edit=none,  show=false</C>  								 	
									<C> Name='담당자'     ID=SHIPPERPS  HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=left edit=none,  show=false</C>  
									<C> Name='적재구분'		ID=CARGO_TYPE HeadAlign=Center HeadBgColor=#eeeeee Width=120	align=left , editstyle=LookUp Data='gcDs_etc2:MINORCD:MINORNM' edit=none</C> 
									<C> Name='차량종류'		ID=CAR_NAME	  HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left			EditStyle=Lookup Data='gcDs_etc5:CAR_TYPE:CAR_NAME', edit=none , show=false </C> 	
									<C> Name='상태'       ID=ORDER_STS	HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center , editstyle=combo Data='0001:등록,0002:접수,0003:반출/반입중,0004:추가등록' edit=none, show=false</C>  
									<C> Name='반출요청일자'   ID=ETD_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center MASK ='XXXX-XX-XX' edit=none, show=false</C>
 									<C> Name='Project명'   ID=LINE_PART	HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' edit=none, show=false</C> 
									<C> Name='물류비 부담' ID=CDNAM			HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=left edit=none,  show=false</C> 
									<C> Name='주문번호'    ID=ORDER_NO	HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=center edit=none</C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr> 
	</table>
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

