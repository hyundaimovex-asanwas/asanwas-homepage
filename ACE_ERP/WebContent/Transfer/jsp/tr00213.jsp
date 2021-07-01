<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 포장주문등록
+ 프로그램 ID	: TR00213.HTML
+ 기 능 정 의	: 포장주문등록
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
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=true>
	 <param name=UseUpdate   value=true> 
</OBJECT> 

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=true>
</OBJECT> 

<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=true>
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

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>
<%=HDConstant.COMMENT_END%>
 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>

<OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT> 

 <OBJECT id="gcTr03" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--주문 마스터-->
</OBJECT>
<%=HDConstant.COMMENT_END%>
 
<SCRIPT language=JavaScript>
	get_cookdata();

	var	lb_boolean1 =  false ; 
	var gs_type = "insert" ; 
	var gs_porderno ="" ; 
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
		GetParam() ; 
		Initialize() ; 

		if( gs_parm[0]  == "update"){
			gs_type = "update" ; 
			gs_porderno = gs_parm[1] ;
		}

		PORDER_NO.Enable = 'false' ; 

		if(gs_type == "insert") {  
			gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkg?NOH=N" ; 
			gcDs1.Reset() ; 
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkgFL?NOH=N" ; 
			gcDs2.Reset()  ;
			gcDs1.AddRow() ; 
			disp_end.style.display='none';
		}	else {
			gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkg?NOH=Y&gstr1=" + gs_porderno ;
			gcDs1.Reset() ;   
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkgFL?NOH=Y&gstr1=" + gs_porderno+"&gstr2=B" ;
			gcDs2.Reset()  ;
			gcDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderPkgFL?NOH=Y&gstr1=" + gs_porderno+"&gstr2=A" ;
			gcDs3.Reset()  ;

			ln_Query(gs_porderno) ; 
			ln_Query1(gs_porderno) ; 
			GetVcmYn() ; 
		}
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function Initialize(){
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0016";  //Project 
		gcDs_etc1.Reset();
		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0017";  //Project 
		gcDs_etc2.Reset();
		gcDs_etc3.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0018";  //Project 
		gcDs_etc3.Reset();
		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0019";  //Project 
		gcDs_etc4.Reset(); 
		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0025";  //Project 
		gcDs_etc5.Reset(); 
	}

	/******************************************************************************
		Description : DataCheck
	******************************************************************************/ 
	function DataCheck() { 
		if(strim(ORDER_DATE.Text) == ''){alert("요청일자 누락");	 return false ; 	}
		if(WORK_FORM.index == 0 ) {alert("작업형태 누락") ; return false ; }
		if(strim(CUST_CD.value) == '' ) {alert("거래처 누락") ; return false ; }
		if(strim(ARTC_CD.value) == '' ) {alert("품명코드 누락") ; return false ; }
		if(strim(ARTC_NM.value) == '' ) {alert("품명 누락") ; return false ; }
		if(PKG_FORM.index == 0  ) {alert("포장형태") ; return false ; }
		if(strim(PKG_CNT.value) == '' ||  strim(PKG_CNT.value) == 0   ) {alert("포장수 누락") ; return false ; }
		if(PKG_UNIT.index == 0   ) {alert("포장수 단위 누락") ; return false ; }
		if(WAREHOUSE.index == 0   ) {alert("물류창고 누락") ; return false ; }
		if(BFILE_NAME.value == ''   ) {alert("사진파일 누락") ; return false ; }
		if(BFILE_NAME.value == ''   ) {alert("사진파일 누락") ; return false ; }  
		return true ;  
	}

	/******************************************************************************
		Description : 저장
	******************************************************************************/ 
	function SAVE(){ 
		var ls_filename = BINPUT_FILE.value ; 
		var ls_filename1 = AINPUT_FILE.value ; 

		if( !DataCheck() ) {return false ; }

		if(gs_type == "insert" ){
			var ls_yymm =  ORDER_DATE.Text.substring(2,6) ; 
			gcDs_etc0.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetSeqNo?NOH=Y&gstr1=0004&gstr2=" + ls_yymm;  // 주문번호 Load
			gcDs_etc0.Reset();   
			gs_porderno = 'P' + ls_yymm +  gcDs_etc0.NameValue(1,"SEQ_NO")  ; 
			gcDs1.NameValue(1,"ORDER_STS") ='0001' ;  //접수	
		}

		// 포장전 사진   
		gcTr01.KeyValue = "trInWRHS(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderPkg";
		gcTr01.Parameters = "gstr1="+gs_porderno  ; //주문번호 
		gcTr01.post();	
		gcDs1.Reset() ; 

		if(  ls_filename  != "") {
				 
			if(gcDs2.CountRow > 0 ){ //이미 이미지 파일이 있을때
				gcDs2.NameValue(1,"IMG")  = BINPUT_FILE.VALUE ;  
			}	else { // 이미지 파일을 인서트
				gcDs2.AddRow() ; 
				gcDs2.NameValue(1,"PORDER_NO") = gs_porderno ; 
				gcDs2.NameValue(1,"FTYPE") = 'B' ;  //포장전 사진 
				gcDs2.NameValue(1,"IMG")  = ls_filename ;  
			}

			gcTr02.KeyValue = "trInWRHS(I:USER=gcDs2)";
			gcTr02.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderPkgFL";
			gcTr02.Parameters = "gstr1="+gs_porderno  ; //주문번호 
			gcTr02.post();	
			gcDs2.Reset() ;  
		}

		// 포장후 사진
		if(  ls_filename1  != ""){ 
			if(gcDs3.CountRow > 0 ){ //이미 이미지 파일이 있을때
				gcDs3.NameValue(1,"IMG")  = BINPUT_FILE.VALUE ;  
			}	else { // 이미지 파일을 인서트
				gcDs3.AddRow() ; 
				gcDs3.NameValue(1,"PORDER_NO") = gs_porderno ; 
				gcDs3.NameValue(1,"FTYPE") = 'A' ;  //포장전 사진 
				gcDs3.NameValue(1,"IMG")  = ls_filename1 ;  
			} 

			gcTr03.KeyValue = "trInWRHS(I:USER=gcDs3)";
			gcTr03.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderPkgFL";
			gcTr03.Parameters = "gstr1="+gs_porderno ; //주문번호 
			gcTr03.post();	
			gcDs3.Reset() ; 
		}
	} 
 
	/******************************************************************************
		Description : DownLoad --- > Excel DataLoad
	******************************************************************************/
	function ln_Query(PicUrl){ 
		if(strim(PicUrl) == '') pictures.src ='../../../Common/img/0000000.gif' ; 
		else pictures.src ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadPicture?NOH=Y&gstr1=" +PicUrl+"&gstr2=B"; // + e ; 
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Query1(PicUrl){ 
		if(strim(PicUrl) == '')	pictures1.src ='../../../Common/img/0000000.gif' ; 
		else pictures1.src ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadPicture?NOH=Y&gstr1=" +PicUrl+"&gstr2=A"; // + e ; 
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ln_Divide(str, delim){
		var strArr = str.split(delim);
		var rtn = "";
		var a = strArr.length;

		if(a>0) rtn=strArr[a-1];

		strArr = null;
		return rtn;
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
		Description :  거래처코드
	******************************************************************************/  
	function call_vender(obj,objtype){
		strURL = "TR00102_E3.html";
		PopupOpenDialog(400,420) ;	
		if(PopWinValue != null ){
			if(obj =="CUST_CD" ) {	
				gcDs1.NameValue(1,obj) = PopWinValue[0];  
				CUST_CD.value = PopWinValue[0];
				CUST_NM.value =PopWinValue[1];
			}
		}
	}

	/******************************************************************************
		Description :  AI진공포장
	******************************************************************************/  
	function CallVcmYn(){
		if(ACM_YM.checked ==true ) gcDs1.NameValue(1,"ACM_YM") = 'Y';
		else gcDs1.NameValue(1,"ACM_YM") = 'N';
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function GetVcmYn(){
		var ls_vcm = gcDs1.NameValue(1,"ACM_YM");
		if(ls_vcm =="Y" )	ACM_YM.checked = true;
		else ACM_YM.checked = false;
	}
 </SCRIPT> 

<script language=JavaScript for=BINPUT_FILE event=OnClick()>
	BFILE_NAME.value =  ln_Divide(BINPUT_FILE.value, "\\");  
</script>

<script language=JavaScript for=AINPUT_FILE event=OnClick()>
	AFILE_NAME.value =  ln_Divide(AINPUT_FILE.value, "\\");  
</script>
  
<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc1) ; 
	WORK_FORM.index = 0 ;
</script> 

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc2) ; 
 PKG_FORM.index = 0 ;
</script> 

<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc3) ; 
	PKG_UNIT.index = 0 ; 
</script> 

<script language=JavaScript for=gcDs_etc5 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc5) ; 
	PACK_TYPE.index = 0 ; 
</script> 

<script language=JavaScript for=gcDs_etc4 event=OnLoadCompleted(rowcnt)>
	AddChoice(gcDs_etc4) ; 
	WAREHOUSE.index = 0 ; 
</script> 

<script language=JavaScript for=gcTr02 event=OnSuccess()>
	ln_Query(gs_porderno) ; 
</script>

<script language=JavaScript for=gcTr03 event=OnSuccess()>
	ln_Query1(gs_porderno) ; 
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
				<img src="../../../Common/img/btn/b_save.gif" style="cursor:hand" onclick="SAVE()"> 
				<img src="../../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee" width=120>&nbsp;Packing No</td>
						<td class="tab21" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>&nbsp;&nbsp;(자동부여)
						</td>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;요청일자</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:8px;top:1px;cursor:hand" onclick="__GetCallCalendar('ORDER_DATE', 'Text');"> 
						</td>
					</tr>
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee"  width=100>&nbsp;업체</td>
						<td class="tab13_left" colspan=3 >
							<input id="CUST_CD" name="CUST_CD" type="text" class="txt11" style='width:70;position:relative;left:8px;top:0px' disabled>
							<img src="../../../Common/img/btn_find.gif" style="position:relative;left:8px;top:3px;cursor:hand" onclick="call_vender('CUST_CD','Text');">
							<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:230;position:relative;left:8px;top:0px' disabled> 
						</td>
					</tr>
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee"  width=100>&nbsp;물류센터</td>
						<td class="tab11_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=WAREHOUSE style='border:0;position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=180 height=100  >
								<param name=ComboDataID			value=gcDs_etc4>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^180">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td>
						<td class="tab11_left" bgcolor="#eeeeee"  width=100>&nbsp;품명</td>
						<td class="tab13_left"> 
							<input id="ARTC_CD" name="ARTC_CD" type="text" class="txt11" style='width:130;position:relative;left:8px;top:0px'> 
							<input id="ARTC_NM" name="ARTC_NM" type="text" class="txt11" style='width:130;position:relative;left:8px;top:0px'> 
						</td>
					</tr>
					<tr>  
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;입고상태</td>
						<td class="tab11_left">
						  <%=HDConstant.COMMENT_START%>
						  <OBJECT id=WORK_FORM  style='border:0;position:relative;left:8px;top:1px;width:120px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
								</OBJECT>
								<%=HDConstant.COMMENT_END%> 
						</td>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;포장형태</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PKG_FORM  style='border:0;position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  >
								<param name=ComboDataID			value=gcDs_etc2>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
								</OBJECT>
								<%=HDConstant.COMMENT_END%> 
						</td>
					</tr> 
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;포장량</td>
						<td class="tab11_left"><input id="PKG_CNT" name="PKG_CNT" type="text" class="txt11_right" style='width:90;position:relative;left:8px;top:1px' ></td>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;단위</td>
						<td class="tab13_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PKG_UNIT  style='border:0;position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  >
								<param name=ComboDataID			value=gcDs_etc3>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^120">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee"  width=100>&nbsp;포장타입</td>
						<td class="tab11_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PACK_TYPE  style='border:0;position:relative;left:8px;top:1px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=120 height=100  >
								<param name=ComboDataID			value="gcDs_etc5">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn			value="MINORNM">
								<param name=SortColumn				value="MINORCD"> 
								<param name=Sort							value="True">
								<param name=ListExprFormat			value="MINORNM^0^120">
								<param name=BindColumn				value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor				value="true"> 
								<param name=ComboStyle				value="2">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> 
						</td>
						<td class="tab11_left" bgcolor="#eeeeee"  width=100>&nbsp;AL진공</td>
						<td class="tab13_left"><input type="checkbox" id=ACM_YM name=ACM_YM class="chk1" value="N" style='position:relative;left:8px;top:1px' onclick="CallVcmYn();" ></td>
					</tr>  
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;포장전사진</td>
						<td class="tab13_left" colspan=3>
							<input id="BFILE_NAME" name="BFILE_NAME" type="text" class="txt11_20_1" style='width:490;height:18px;position:relative;left:8px;top:-1px'>
							 <%=HDConstant.COMMENT_START%>
							 <OBJECT id='BINPUT_FILE' classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="width:110; height:17;position:relative;left:5px;top:2px">
							<param name="Text"	value='FileOpen'>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td class="tab11_left" bgcolor="#eeeeee" width=100>&nbsp;비고</td>
						<td class="tab13_left" bgcolor="#eeeeee"  colspan=3><textarea name="REMARK" id="REMARK" class="textarea1" style="width:100%; height:42;border:0;overflow:auto"></textarea></td>
					</tr>
					<tr>
						<td class="tab12_left" bgcolor="#eeeeee" width=100>&nbsp;사진</td>
						<td colspan=3><img id=pictures src= '../../../Common/img/0000000.gif' width=600 height=300 onclick="window.open(this.src,'','resizable=yes,scrollbars=no,status=no')"></td>
					</tr> 
				</table> 
			</td>
		</tr> 
		<tr><td height=10 colspan=2>&nbsp;</td></tr>
		<tr>
			<td colspan=2>
				<div  id=disp_pic1 style="display:none" >
					<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:250px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
						<tr><td class="tab11" bgcolor="#eeeeee"   width=120>&nbsp;</td></tr> 
					</table>
				</div>
			</td>
		</tr>
		<tr><td height=10px>&nbsp;</td></tr>
		<tr>
			<td colspan=2>
				<div  id=disp_end style="display:none" >
					<table  cellpadding="0" cellspacing="0" border="0" style="width:876px; ;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
						<tr> 
							<td class="tab11_left" bgcolor="#eeeeee" width=120>&nbsp;포장완료일자</td>
							<td  class="tab11_left">
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=END_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
									style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
										<param name=Alignment			value="0">
										<param name=Border	      value="false">
										<param name=Format	      value="YYYY/MM/DD">
										<param name=PromptChar	  value="_"> 
								</OBJECT>
								<%=HDConstant.COMMENT_END%>
								<img src="../../../Common/img/btn_calendar.gif" style="position:relative;left:8px;top:1px;" onclick="__GetCallCalendar('END_DATE', 'Text');"> 
							</td>
							<td class="tab11_left" bgcolor="#eeeeee" width=120>&nbsp;포장후사진</td>
							<td class="tab11_left">
							  <input id="AFILE_NAME" name="AFILE_NAME" type="text" class="txt11" style='width:390;height:18px;position:relative;left:8px;top:-2px'>
								<%=HDConstant.COMMENT_START%>
								<OBJECT id=AINPUT_FILE classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:relative;left:0px;top:2px;width:110; height:18;"> 
									<param name="Text"            value='FileOpen'> 
								</OBJECT>
								<%=HDConstant.COMMENT_END%> 
							</td>
						</tr> 
						<tr>
							<td class="tab11_left" bgcolor="#eeeeee" width=120>&nbsp;사진</td>
							<td colspan=3>
							<img id=pictures1 src= '../../../Common/img/0000000.gif' width=600 height=400 onclick="window.open(this.src,'','resizable=yes,scrollbars=no,status=no')"></td>
						</tr> 
					</table>  
				</div>
			</td>
		</tr> 
		<tr>
			<td colspan=2>
				<div  id=disp_pic1 style="display:none" >
					<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:250px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
						<tr>
							<td class="tab11" bgcolor="#eeeeee" width=100>&nbsp;</td>
						</tr> 
					</table>  
				</div>
			</td>
		</tr>
	</table>
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->


<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcbn01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID				value=gcDs1>
	<param name=BindInfo			value='
				<C>Col=PORDER_NO     Ctrl = PORDER_NO     Param=Text</C>   
				<C>Col=ORDER_DATE    Ctrl = ORDER_DATE    Param=Text</C>   
				<C>Col=WORK_FORM     Ctrl = WORK_FORM     Param=BindColVal</C>   
				<C>Col=CUST_CD       Ctrl = CUST_CD       Param=value</C>   
				<C>Col=ARTC_CD       Ctrl = ARTC_CD       Param=value</C>   
				<C>Col=ARTC_NM       Ctrl = ARTC_NM       Param=value</C>   
				<C>Col=PKG_FORM      Ctrl = PKG_FORM      Param=BindColVal</C>   
				<C>Col=PKG_CNT       Ctrl = PKG_CNT       Param=value</C>   
				<C>Col=PKG_UNIT      Ctrl = PKG_UNIT      Param=BindColVal</C>   
				<C>Col=WAREHOUSE     Ctrl = WAREHOUSE     Param=BindColVal</C>   
				<C>Col=BFILE_NAME    Ctrl = BFILE_NAME    Param=value</C>   
				<C>Col=REMARK        Ctrl = REMARK        Param=value</C>   
				<C>Col=END_DATE      Ctrl = END_DATE      Param=Text</C>   
				<C>Col=END_TIME      Ctrl = END_TIME      Param=Text</C>   
				<C>Col=AFILE_NAME    Ctrl = AFILE_NAME    Param=value</C> 
				<C>Col=PACK_TYPE     Ctrl = PACK_TYPE     Param=BindColVal</C> 
	'></OBJECT>
	<%=HDConstant.COMMENT_END%>
</BODY>
</HTML>
<jsp:include page="/common/sys/body_e.jsp"  flush="true"/>

