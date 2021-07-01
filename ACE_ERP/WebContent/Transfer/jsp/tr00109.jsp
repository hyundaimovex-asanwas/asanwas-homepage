<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 차량별 상차정보
+ 프로그램 ID	: TR00109.HTML
+ 기 능 정 의	: 차량별 상차정보
+ 변 경 이 력	: 정미선
+ 서 블 릿 명	: TR00109.HTML
-----------------------------------------------------------------------------
+ 수 정 내 용 : 상차 수신 반영 	
+ 수   정  자 : 정영식
+ 수 정 일 자 : 2008.10.22
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
</OBJECT>

<OBJECT id=gcDs2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><!-- <param name=UseChangeInfo    value=false>   -->
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> <!--상차예정 일괄 -->
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDsBe classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false">
</OBJECT>
<%=HDConstant.COMMENT_END%> 

 <!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<%=HDConstant.COMMENT_START%>
<OBJECT id="gcTr01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--상차예정 건별-->
</OBJECT>

<OBJECT id="gcTr02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4"><!--상차예정 일괄-->
  <param name="keyvalue" value="trLoadLst3_batch(I:USER=gcDs0)">   
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
		Description :
	******************************************************************************/ 
	function Start(){
	
		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc2.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCarAcc?NOH=Y&gstr1=";
		gcDs_etc2.Reset();

		gcDs_etc13.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //단위 
		gcDs_etc13.Reset(); 

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;

		//f(gcDsgetdate.CountRow > 0 ) ETD_DATE.Text =  gcDsgetdate.NameValue(1,"APP_DT1") ; 
		ETD_DATE.Text = gs_date;
		
	}

	/******************************************************************************
		Description : 
	******************************************************************************/
	function ls_EDI(){
	
		var strURL = "TR00104_EDI.html";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="B"; //주문배정관리
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}


		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
	}

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Query(){
		var parm = "&gstr0=O"                   //O - 반출, I- 반입 
						 + "&gstr1=" + ETD_DATE.Text    //반출일자
						 + "&gstr2=" + ORDER_NO.Text    //주문번호
						 + "&gstr3="                    // 
						 + "&gstr4=" + fn_trim(LINE_PART.BindColVal) //사업명
						 + "&gstr5=" + CUST_NM.value;       //업체명 
						// + "&gstr6=T";

		gcDsBe.DataId ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsEdCar3?NOH=Y"+parm; //상태 "

		gcDsBe.Reset() ; 
	} 
	
 	/******************************************************************************
		Description : 상차작성정보
	******************************************************************************/ 
	function CallLoadList(){
	
	  	ln_SetDataHeader();
    	gcDs0.Addrow();
    	gcDs0.namevalue(gcDs0.rowposition,"ETD_DATE") =fn_trim(ETD_DATE.text);//반출일자
		gcDs0.namevalue(gcDs0.rowposition,"LINE_PART")=fn_trim(LINE_PART.bindcolval) ;//사업장
		gcDs0.namevalue(gcDs0.rowposition,"GUSER") =gusrid ;//사용자

		if (confirm("공장상차도 중 입고된 데이터를\n\n상차정보로 일괄 작성하시겠습니까?")){       
      	gcTr02.Action ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3_batch?"; 

			gcTr02.post();
			
		}

   /**
		if (confirm("상차정보를 작성하시겠습니까 ?")){
			for(i =1 ; i<=gcDsBe.CountRow ; i++ ) {
				if(gcDsBe.NameValue(i,"CHK") =="T"){
					gcDs0.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsCallSpTr00108?NOH=Y&gstr1="+ ETD_DATE.Text
					                                                              +"&gstr2="+gcDsBe.namevalue(i,"CAR_SEQ_NO") + "&gstr4=T" ;
					gcDs0.Reset();
					// 2007.09.04 정영식 막음.
					if (gcDs0.namevalue(1,"PL2")=="C") alert("정상적으로 상차정보가 작성되었습니다.");
					else alert("상차정보 작성 중 오류가 발생하였습니다.");
				}
		 }
	}
	**/
	
}
	/******************************************************************************
		Description :
	******************************************************************************/ 
  function ln_Save() {
  
		if (!gcDs2.isUpdated || gcDs2.countrow<1) return;

		if (confirm("상차예정 정보를 저장하시겠습니까?")){
		
			gcTr01.KeyValue = "trLoadLst3(I:USER=gcDs2)";
			
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3";

			gcTr01.post(); 
		}
  }

	/******************************************************************************
		Description : 생성된 상차예정정보
    Parameter   : A-조건에 맞는 전체
		              그외는 배정정보

	******************************************************************************/
	function ln_LoadSrh(e){

   //2008.03.08 정영식 막음.
   /*
	  if(e=="A"){
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3?NOH=Y&gstr2=" + ORDER_NO.text 
			                                                         +"&gstr3=" + ETD_DATE.text
																															 +"&gstr4=" + CUST_NM.value
																															 +"&gstr5=O"
																															 +"&gstr6=" + LINE_PART.bindcolval
			gcDs2.Reset();
		}else{
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3?NOH=Y&gstr7=" + e;
			gcDs2.Reset();
		}
 */

	 if(e=="A"){
	    // 검색조건으로 조회
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3_1?NOH=Y&gstr1="                          //배정번호       
			                                                         +"&gstr2=" + ETD_DATE.text					 //반출일자       
																															 +"&gstr3=" + ORDER_NO.text 				 //주문번호       
																															 +"&gstr4=" + CUST_NM.value					 //거래처         
																															 +"&gstr5=" + fn_trim(LINE_PART.bindcolval)	 //사업명         
																															 +"&gstr6=O";												 //반출구분코드   


			gcDs2.Reset();
		}else{
		  //배정정보 그리드 클릭시 배정번호로 조회
			gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLoadlst3_1?NOH=Y&gstr1=" + e
			                                                         +"&gstr2=" 
																															 +"&gstr3=" 
																															 +"&gstr4="
																															 +"&gstr5=" 
						
																															 +"&gstr6=O"; //반출


			gcDs2.Reset();
		}
	}

 /******************************************************************************
		Description : 배정상세 조회
	******************************************************************************/
	function LoadCarLD(row){
		var ls_car_seq_no = gcDsBe.NameValue(row,"CAR_SEQ_NO") ; 
		var in_out				= gcDsBe.NameValue(row,"IN_OUT") ; 
		var order_no			= gcDsBe.NameValue(row,"ORDER_NO") ; 
		var div_io				= gcDsBe.NameValue(row,"DIV_IO") ; 
		var edt_date			= gcDsBe.NameValue(row,"EDT_DATE") ;  

		if(div_io == "") div_io = "N";

   //20070828 정영식 막음
   /*****
		if( order_no != null && div_io =="Y"){ 
			alert("분할 반출은 수정되지 않습니다. ") ; 
			Save_bnt.style.display = "none";  
		}	else {
			Save_bnt.style.display= "";  
		}
   ***/
 
		gcDs2.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsLdCarGoodsEtc3?NOH=Y&gstr1=&gstr2="+ ls_car_seq_no+"&gstr3="+in_out+"&gstr4="+div_io+"&gstr5="+edt_date;
		gcDs2.Reset() ; 
	}



	/******************************************************************************
		Description : 재고정보 검색
	******************************************************************************/
	function ln_LoadData() {
		if (gcDsBe.countrow<1) return;

    var icnt_0=0;
		var icnt = 0;

		for(var j=1;j<=gcDsBe.countrow;j++){
			if (gcDsBe.sysStatus(j)!="0") icnt_0++;
		}

		if (icnt_0==0) {
			alert("배정정보를 선택하십시요.");
			return;
		}

		if (icnt_0>1) {
			alert("배정정보를 한개만 선택하십시요.");
			gcDsBe.undoall();
			return;
		}


		for (var i=1; i<=gcDs2.countrow; i++){
			if (gcDs2.sysStatus(i)!="0") icnt++;
		}

		if (icnt>0) {
			alert("상차예정정보를 저장하신 후 재고 데이터를 검색하실 수 있습니다.");
			return;
		}

		var strURL = "TR00109_E2.html";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,window,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");

	}

	/******************************************************************************
		Description : 재고정보 검색
	******************************************************************************/
	/*function ln_Del(){
		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
			if (confirm("선택하신 상차예정 정보를 삭제하시겠습니까?")){
				gcDs2.deleterow(gcDs2.rowposition);
				gcTr01.KeyValue = "trLoadLst2(I:USER=gcDs2)";
				gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst2";
				gcTr01.post(); 
			}
		}
	}*/

	/******************************************************************************
		Description : 상차예정정보삭제
	******************************************************************************/
	function ln_Del(){

		var row = gcDs2.rowposition;
		if (gcDs2.sysStatus(row)=="1") gcDs2.undo(row);
		else {
		  //EDI 전송건은 삭제불가
			if(!ln_Chk_Del()) return;

			if (confirm("선택하신 상차예정 정보를 삭제하시겠습니까?")){
				  gcDs2.ClearAllMark();
					
					for (var i=1; i<=gcDs2.countrow; i++ ) {
						if(gcDs2.NameValue(i,"CHK") =="T"){
					  	gcDs2.RowMark(i)=1;
						}
					}
					gcDs2.DeleteMarked();
					gcTr01.KeyValue = "trLoadLst3(I:USER=gcDs2)";
					gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trLoadLst3";

					gcTr01.post(); 
			}
		}
	}

 /******************************************************************************
		Description : 상차예정정보삭제시 체크 : EDI 전송건은 삭제 못 함.
	******************************************************************************/
  function ln_Chk_Del(){

		return true;
	}

  /******************************************************************************
		Description : 조건에 따른 Grid 색깔 변경
	******************************************************************************/
	function gcGR2ColorChange(row,eventid){
		if(eventid == "acolor") {
			if(gcgd_data2.NameValue(row,"CHK") == "T" ) return '#FAFCA7' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor1") {
			if(gcgd_data2.NameValue(row,"CHK") == "T" ) return '#FFCCCC' ; 
			else return '#FFFFFF' ; 
		}

		if(eventid == "acolor2") { 
			if(gcgd_data2.NameValue(row,"EXT_PKG_CNT") != 0 ) return "#FF0033" ;
			else return "#330000" ;
		}

		if(eventid == "acolor3") { 
			if(gcgd_data2.NameValue(row,"EXT_ARTC_CNT") != 0 )	return "#FF0033" ;
			else return "#330000" ;
		}
	}

  /******************************************************************************
		Description : DataSet Head 생성
	******************************************************************************/
	function ln_SetDataHeader(){
		if (gcDs0.countrow<1){   
			var s_temp = "ETD_DATE:STRING(8),LINE_PART:STRING(4),GUSER:STRING(10)"
			gcDs0.SetDataHeader(s_temp);
		}
  }

	/******************************************************************************
		Description : 상차정보데이타에서 입고수량으로 입고상세 데이타 확인
	******************************************************************************/
	function ln_Popup_INWRHS(row){
		var strURL = "TR00109_E3_Popup.html";
		var myW = 440;
		var myH = 200;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
				
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,window,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
	}

/******************************************************************************
		Description : 상차수신
		2008.10.22 추가
 *****************************************************************************/
 function ln_EDI_Receive(){
		var strURL = "TR00104_EDI_Receive.html";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="D"; //상차
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
 }
</SCRIPT> 

<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR VISIBLE
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDsBe event="OnLoadStarted()">
	//OnStatusStart() ; 
</script> 
<!-----------------------------------------------------------------------------
	  DESCRIPTION : STATUS BAR HIDDEN
------------------------------------------------------------------------------>
<script language=JavaScript for=gcDsBe  event="onloadCompleted(row,colid)">
	//	TheStatusEnd(row) ; 
</script>

<script language=JavaScript for=gcDs2 event="OnLoadStarted()"> 
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible"; 
</script>

<script language=JavaScript for=gcDs2  event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden"; 
	// if (row <1) alert("검색된 데이터가 없습니다!");      // 2007. 02. 08 이동훈 수정
</script>


<script language=javascript for=gcgd_data1 event=onClick(row,colid)>
	var strFlag="";
	if(row<1){
		if(colid=="CHK"){
			if(gcDsBe.namevalue(1,colid)=="T")	strFlag="F";
			else strFlag="T";
			for(i=1;i<=gcDsBe.countrow;i++){
				gcDsBe.namevalue(i,"CHK")=strFlag;
			}
			return;
		}else{
			return;
		}
	}
  
	gcDsBe.UndoAll();
  if(colid == "CHK") {
		if (gcDsBe.NameValue(row,colid) == "T") gcDsBe.NameValue(row,colid) = "F";
		else gcDsBe.NameValue(row,colid) = "T";
	} 

	ln_LoadSrh(gcDsBe.namevalue(row,"CAR_SEQ_NO"));

</script>

<script language=javascript for=gcgd_data2 event=onClick(row,colid)>
  if(row<1) return;  

	if(colid == "CHK") {
		if (gcDs2.NameValue(row,colid) == "T") gcDs2.NameValue(row,colid) = "F";
		else gcDs2.NameValue(row,colid) = "T";
	} 

</script>

<script language="javascript" for=gcgd_data2 event=OnExit(row,colid,olddata)>
	var org_val = gcDs2.OrgNameValue(row,"ARTC_CNT");
	var usr_val = gcDs2.NameValue(row,"ARTC_CNT");
	var org_cnt = gcDs2.NameValue(row,"ORG_CNT");
	var jaego_cnt = gcDs2.NameValue(row,"ORG_ARTC_CNT");

	if (org_val!=usr_val) {
		if (usr_val>org_cnt) {
			alert("현재 입고된 물품수량 이상을 입력하실 수 없습니다.");
			gcDs2.NameValue(row,"ARTC_CNT") = org_val;
			return;
		}
	} else {
		if (usr_val>org_cnt) {
			alert("현재 입고된 물품수량 이상을 입력하실 수 없습니다.");
			gcDs2.NameValue(row,"ARTC_CNT") = org_cnt;
			return;
		}
	}
</script>

<script language=JavaScript for=gcgd_data2 event=OnDblClick(row,colid)>
	if(row<1) return;
	if(colid ="ARTC_CNT"){
		ln_Popup_INWRHS(row); //입고수량 상세팝업
	}
</script>


<script language=javascript for=gcTr01 event=onSuccess()>
	alert("정상적으로 저장이 완료되었습니다.");
</script>

<script language=JavaScript for=gcTr01 event=OnFail()>
	alert("Error Code : " + gcTr01.ErrorCode + "\n" + "Error Message : " + gcTr01.ErrorMsg + "\n");
</script>

<script language=javascript for=gcTr02 event=onSuccess()>
	alert("반출일자 "+ETD_DATE.TEXT+" 데이타가 정상적으로 상차예정 되었습니다.");
</script>

<script language=JavaScript for=gcTr02 event=OnFail()>
	alert("Error Code : " + gcTr02.ErrorCode + "\n" + "Error Message : " + gcTr02.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	LINE_PART.index = 0 ; 
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
			<td><img src="../img/TR00110_head.gif"></td>
			<td width="685" align="right" background="../../common/img/com_t_bg.gif" style="padding-top:4px;">
			  <!-- 2008.10.22 EDI 전송 및 상차정보작성 모두 막고, 상차수신을 추가로 넣음. -->
				<!-- <img src="../../common/img/btn/btn_edi.gif" style="cursor:hand" onclick="ls_EDI()"> -->
				<img src="../img/com_b_load.gif" style="cursor:hand" onclick="CallLoadList();"> 
				<img src="../img/btn/btn_edi_re.gif"  style="cursor:hand" onclick="ln_EDI_Receive()">
				<img src="../img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=70>반출일자</td>
						<td class="tab12_left">
						 <%=HDConstant.COMMENT_START%>
						 <OBJECT id=ETD_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:5px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="../img/btn_calendar.gif" style="position:relative;left:6px;top:2px;cursor:hand" onclick="__GetCallCalendar('ETD_DATE', 'Text');"> 
						</td>
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">주문번호</td>
						<td class="tab12_left">
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:3px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="#############">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<!--
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">반출/반입</td>
						<td class="tab12_left" style="width:90px;">
							<%=HDConstant.COMMENT_START%><OBJECT id=IO_FLAG style='border:0;position:relative;left:8px;top:1px;height:150;width:70' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=CBData					value="^전체,O^반출,I^반입">
								<param name=CBDataColumns		value="DIVCODE,DIVNAME">
								<param name=SearchColumn		value="DIVNAME">
								<param name=ListExprFormat	value="DIVNAME^0^70">
								<param name=BindColumn			value="DIVCODE">
							</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						-->
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">업체명</td>
						<td class="tab12_left" style="width:130px;"><input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:105;position:relative;left:8px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="width:70px;text-align:center" bgcolor="#eeeeee">사업명</td>
						<td>
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:8px;top:1px;height:200;width:160px' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
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
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=25 bgcolor=#efefef colspan=2><B>&nbsp;&nbsp;[배정정보] </B>
						<img id=imgAll src="../img/btn/btn_all.gif" style="position:relative;left:12px;top:2px;display:none;cursor:hand" onclick="__SelectAll();" alt="주문정보를 전체 선택합니다."><!-- &nbsp; -->
						<img id=imgAllCancle src="../img/btn/btn_all_cancel.gif" style="position:relative;left:-6px;top:2px;display:none;cursor:hand" onclick="__SelectCancle();"  alt="선택한 주문정보를 취소합니다."></td>
					</tr>
					<tr>						
						<td class=tab11 style="border:0 solid #777777;border-top-width:1px;" >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data1 style="width:100%;height:121px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDsBe">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="AllShowEdit" VALUE="true">
								<param name="ColSizing"  value="true">  
								<PARAM NAME="Format"			VALUE="   
								  	<C> Name=''	         		ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center bgcolor=@acolor, Edit=none</C>
									<C> Name='배정번호'	  	ID=CAR_SEQ_NO  HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=center  </C> 
									<C> Name='구분'				ID=CARGO_TYPE  HeadAlign=Center HeadBgColor=#eeeeee Width=100	 align=left </C>
									<C> Name='차량종류'	  	ID=CAR_NAME		 HeadAlign=Center HeadBgColor=#eeeeee Width=100	 align=left </C> 
									<C> Name='차량번호'	 	ID=CAR_NO 		 HeadAlign=Center HeadBgColor=#eeeeee Width=90	 align=left </C> 
                  					<C> Name='기사명'	    	ID=PSN_KNAME	 HeadAlign=Center HeadBgColor=#eeeeee Width=60	 align=center </C>
									<C> Name='대표품목'		ID=CTN_STDRD	 HeadAlign=Center HeadBgColor=#eeeeee Width=100   align=left </C>
									<C> Name='상차지'	    	ID=LD_CARGONM	 HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
									<C> Name='하차지'		  	ID=OFF_CARGONM HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
									<C> Name='화주'	  	 		ID=SHIPPNM     HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td style="height:5px;"></td></tr>
		<tr>
			<td colspan=2> 
				<table cellpadding="0" cellspacing="0" border="0" style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td height=25 bgcolor=#efefef><B>&nbsp;&nbsp;[상차예정정보] </B></td>
						<td bgcolor=#efefef align=right>
							<img src="../img/btn/btn_jaego.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadData()">
							<img src="../img/btn/b_save.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Save();">
							<!-- <img src="../img/btn/b_delete.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_Del();"> -->
							<img src="..//img/com_b_query.gif" style="position:relative;left:0px;top:2px;cursor:hand" onclick="ln_LoadSrh('A');">
						</td>
						<td bgcolor=#efefef style="width:8px">&nbsp;</td>
					</tr>
					<tr>
						<td colspan=3>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2 style="width:100%;height:261px;border:0 solid #777777;border-top-width:1px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs2">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Editable"		VALUE="true">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true"> 
								<PARAM NAME="Format"			VALUE="  
									<F>	Name=''	          ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center edit=none </F>
									<F> Name='주문번호'   ID=ORDER_NO 	   HeadAlign=Center HeadBgColor=#eeeeee Width=90	align=left   edit=none bgcolor=@acolor</F>
									<C> Name='품명'			  ID=ARTC_NM  		 HeadAlign=Center HeadBgColor=#eeeeee Width=110	align=left   edit=none bgcolor=@acolor</C>
									<C> Name='단위'			  ID=ARTC_UNIT	 HeadAlign=Center HeadBgColor=#eeeeee Width=90	align=left   edit=none 
									editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM' bgcolor=@acolor</C>
									<G> Name='수량' HeadBgColor=#eeeeee
										<C> Name='입고수량'	ID=IN_ARTC_CNT	 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=@acolor1</C>
										<C> Name='적재수량'	ID=ARTC_CNT			 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=#DDF2FC</C>
										<C> Name='잔여수량'	ID=EXT_ARTC_CNT  HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
									</G>
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이'	    ID=PKG_LNGTH		 HeadAlign=Center HeadBgColor=#eeeeee Width=75	align=right, edit=none  Dec=0, bgcolor=@acolor1</C>
										<C> Name='폭'	      ID=PKG_WIDTH     HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
										<C> Name='높이'	    ID=PKG_HEIGHT    HeadAlign=Center HeadBgColor=#eeeeee Width=75  align=right, edit=none  Dec=0, bgcolor=@acolor Color=@acolor3</C>
									</G>
									<C> Name='총중량(KG)'	ID=TOTAL_WEIGHT  HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=right, edit=none dec=2 bgcolor=@acolor</C>
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

