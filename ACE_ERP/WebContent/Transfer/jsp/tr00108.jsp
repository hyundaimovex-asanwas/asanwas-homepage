<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  입고관리
+ 프로그램 ID	: TR00108.HTML
+ 기 능 정 의	: 입고정보
+ 변 경 이 력	: 정미선
+ 서 블 릿 명	: 
------------------------------------------------------------------------------
+ 수 정 내 용  :	그리드 추가 및 개선사항 수정   
+ 수   정  자  :  이민정
+ 수 정 일 자  :  2007. 1. 4
------------------------------------------------------------------------------
+ 수 정 내 용  :  EDI 관련 수신 팝업 추가
+ 수   정  자  :  정영식
+ 수 정 일 자  :  2008. 10. 21
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
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"><param name=UseChangeInfo    value=false>  
</OBJECT>

<OBJECT id=gcDsgetdate classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true">
</OBJECT>

<OBJECT id=gcDs_etc13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name=SyncLoad              value="true">
</OBJECT>

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>
   
<OBJECT id=gcDs_temps classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT>

<OBJECT id=gcDs_etc9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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

		gcDs_etc0.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //상태
		gcDs_etc0.Reset() ; 

		gcDs_etc1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_s1e2?NOH=Y&gstr1=&gstr2=0002";  //Project 
		gcDs_etc1.Reset();

		gcDs_etc2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0003"; //적재구분
		gcDs_etc2.Reset();

		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //상차지 
		gcDs_etc4.Reset();

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //하차지 
		gcDs_etc5.Reset(); 

		gcDs_etc13.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0008";  //단위 
		gcDs_etc13.Reset(); 

		gcDsgetdate.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsGetDates?NOH=Y&gstr1=0001";  //Project 
		gcDsgetdate.Reset() ;

		gcDs_etc9.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0001";  //납품구분 
		gcDs_etc9.Reset(); 

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

			  //2008.10.30 JYS 추가
				//수작업 입고 잡을 경우 공장상차도가 아닐 경우 MSG를 띄움..
				//사용자가 확인 하고 일반적으로 취소해야함...
				//그렇지 않을 경우 문제가 될 수 있음.. EDI 로 입고하는 것과 중복 될 수 있음.

        if(gcDs3.NameValue(gcDs3.rowposition,"CAR_NO")==""){
					alert("배차가 되지 않았습니다. 확인 바랍니다.");
					return false;
				}

        
				if(gcDs2.NameValue(cnt,"DLVL_TYPE")!="0002"){ //공장상차도가 아닐 경우
					if (confirm("선택하신 건은 공장상차도가 아닙니다.\n\n공장상차도건만 수작업으로 입고하시길 권장합니다.\n\n수작업 입고를 하시겠습니까?")){

					}else{
					  gcDs1.UndoAll();
						return false;
					}
				}

				//부분입고 처리함. //A-부분입고, B-전체입고, C-미입고
				if(gcDs2.namevalue(cnt,"CNT_STS")=="A"){ //A-부분입고
					gcDs1.AddRow() ; 	
					ls_row = gcDs1.RowPosition ; 
					gcDs1.NameValue(ls_row,"ORDER_NO")			= gcDs2.NameValue(cnt,"ORDER_NO") ; 
					gcDs1.NameValue(ls_row,"ORDER_SEQ")			= gcDs2.NameValue(cnt,"ORDER_SEQ") ; 
					gcDs1.NameValue(ls_row,"ARTC_NM")				= gcDs2.NameValue(cnt,"ARTC_NM") ;  
					gcDs1.NameValue(ls_row,"ARTC_CNT")			= gcDs2.NameValue(cnt,"JAN_ARTC_CNT") ; //부분입고 후 남은수량
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
					gcDs1.NameValue(ls_row,"JAN_ARTC_CNT")	= gcDs2.NameValue(cnt,"JAN_ARTC_CNT") ;  

					if(gcDs2.NameValue(cnt,"LINE_PART") =="0001") gcDs1.NameValue(ls_row,"WAREHOUSE") ='0001' ; 
					else gcDs1.NameValue(ls_row,"WAREHOUSE") ='0002';
				}else if(gcDs2.namevalue(cnt,"CNT_STS")=="C"){ //미입고
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
					gcDs1.NameValue(ls_row,"JAN_ARTC_CNT")	= gcDs2.NameValue(cnt,"JAN_ARTC_CNT") ;  
					if(gcDs2.NameValue(cnt,"LINE_PART") =="0001") gcDs1.NameValue(ls_row,"WAREHOUSE") ='0001' ; 
					else gcDs1.NameValue(ls_row,"WAREHOUSE") ='0002';
				}
			}
		}
	}

	/******************************************************************************
		Description : 수량 체크
		              2008.03.07
									정영식
									입고 수량체크함.
	******************************************************************************/
	function ln_Chk_Cnt(){
	  var temp_cnt=0;
		for(i=1;i<=gcDs2.countRow;i++){   //주문상세 
		  temp_cnt=0;
			for(j=1;j<=gcDs1.countRow;j++){ //입고
				if(gcDs2.namevalue(i,"ORDER_NO")==gcDs1.namevalue(j,"ORDER_NO")&&gcDs2.namevalue(i,"ORDER_SEQ")==gcDs1.namevalue(j,"ORDER_SEQ")){
					temp_cnt=temp_cnt+gcDs1.namevalue(j,"ARTC_CNT");
					if(gcDs2.namevalue(i,"ARTC_CNT")<temp_cnt){
							gcDs1.rowposition;

							alert("수량을 확인하십시요");

							return false;
					}
				}
			}
		}

		return true;
	}

	/******************************************************************************
		Description :
	******************************************************************************/
	function SAVEWRHS(){
	
		if (!gcDs1.isUpdated) return;


    if(!ln_Chk_Cnt()) return;


		if (confirm("입력하신 입고정보를 저장하시겠습니까 ? ")){
			for(var cnt =1 ;cnt<=gcDs1.countRow ;cnt++){
				gcDs1.NameValue(cnt,"GOODS_SEQ") = cnt ;  
			}
			
			gcTr01.KeyValue = "trInWRHS(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trInWRHS";

			gcTr01.Parameters = "gstr1="+ENTER_DATE.Text+",gstr2="+gusrid  ; //입고일자, 사용자 
			gcTr01.post();
		}
	}

 	/******************************************************************************
		Description :
	******************************************************************************/
	function ln_Query(){
	
		imgAll.style.display = "";
		
		imgAllCancle.style.display = "none";

		var parm1 = "&gstr0=O"
						  + "&gstr3=" + LINE_PART.BindColVal
						  + "&gstr4=" + ORDER_NO.Text
						  + "&gstr6="+ ETD_DATE.Text
							+ "&gstr7="+ DLVL_TYPE.BindColVal;
						 
		gcDs3.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderSts1?NOH=Y" +parm1  ; 

		gcDs3.Reset() ;
	
	}


	function ln_Query02(p){
	
		imgAll.style.display = "";
		imgAllCancle.style.display = "none";
		var parm = 
						  "&gstr2=" + ETD_DATE.Text
						 + "&gstr3=" + LINE_PART.BindColVal
						 + "&gstr4=O"
						 + "&gstr5=" + CUST_NM.value 
						 + "&gstr1=" ;//+ ORDER_NO.Text
	
		gcDs2.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderdetail_2?NOH=Y" +parm +p ; 

		gcDs2.Reset() ;
	}

	function ln_Query03(p){
	
		imgAll.style.display = "";
		imgAllCancle.style.display = "none";
		var parm = "&gstr4=" ;
		gcDs1.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsInWRHS?NOH=Y"+parm +p ;  

		gcDs1.Reset() ; 
	
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
		Description : 동일포장 선택
	******************************************************************************/
	function ln_Sum(){

  var flag1 = "";//계정코드
  var flag2 = "";//세목코드
  var sum1 = 0;
  var sum2 = 0;
  var sum3 = 0;
  var j=1;

	for(i=1;i<=gcDs2.countrow;i++) {
	  if(i==1){
		  gcds_temp.addrow();
		  gcds_temp.namevalue(j,"ARTC_CNT")=gcDs2.namevalue(i,"ARTC_CNT");
		  gcds_temp.namevalue(j,"ORDER_NO")=gcDs2.namevalue(i,"ORDER_NO");
		  j++;
		}
	}
}


	/******************************************************************************
		Description :
	******************************************************************************/
	function __SelectAll(){
	
		for(var i=1;i<=gcDs2.CountRow ; i++){
			//2007.10.31 정영식 추가
			if(gcDs2.namevalue(i,"BGTYPE")=="A"){
				gcDs2.NameValue(i,"CHECK") = "F";   
			}else{
        gcDs2.NameValue(i,"CHECK") = "T";   
			}
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

/******************************************************************************
		Description : 입고수신
		2008.10.21 추가
 *****************************************************************************/
 function ln_EDI_Receive(){
 
		var strURL = "tr00104_EDI_Receive.jsp";
		var myW = 850;
		var myH = 513;
		var w = window.top.screen.width;
		var h = window.top.screen.height;
		var Lf=0, Tp=150;
		var arrParam	= new Array();
		
		arrParam[0]="C"; //입고
		
		if(w>=myW){Lf=(w-myW)/2;}
		if(h>=myH){Tp=(h-myH)/2;}

		PopWinValue = window.showModalDialog(strURL,arrParam,"cenert:yes;dialogWidth:"+myW+"px;dialogHeight:"+myH+"px;scroll:no;help:0;status:0");
 }
</SCRIPT> 

<script language=JavaScript for=Grid1 event=OnClick(row,colid)>    
  if (colid == "CHECK") {
     CheckSameAS(row);			

		 if(gcDs2.namevalue(gcDs2.rowposition,"BGTYPE")=="A"){
       gcDs2.namevalue(gcDs2.rowposition,"CHECK")="F";
		 }

  }else {
     INWareHouse(row) ;
  }
</script>

<script language="javascript"  for=Grid2 event=CanColumnPosChange(row,colid)>
	 if(colid == "ARTC_CNT"){
	    ln_Chk_Cnt();

	 }
</script>

<script language=JavaScript for=Grid2 event=OnKillFocus()>

</script>

<script language=JavaScript for=Grid3 event=OnClick(row,colid)>   
	if(row>0){
		ln_Query02(gcDs3.namevalue(row,"ORDER_NO"));
		ln_Query03(gcDs3.namevalue(row,"ORDER_NO"));
	}
 </script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	LINE_PART.index = 0 ; 
</script>


<script language=JavaScript for=gcDs_etc9 event=OnLoadCompleted(rowcnt)>
	gcDs_etc9.InsertRow(1) ; 
	gcDs_etc9.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc9.NameValue(1,"MINORNM" )  = "==== 선택====" ; 
	var row = DLVL_TYPE.IndexOfColumn("MINORCD", "0003");
	gcDs_etc9.deleterow(row+1);
	DLVL_TYPE.index = 0; 
</script>


<script language=JavaScript for=gcDs2 event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";

</script>

<script language=JavaScript for=gcDs2 event=OnLoadCompleted(row)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language=JavaScript for=gcDs3 event="onloadCompleted(row,colid)">
	gcDs1.ClearData();
	gcDs2.ClearData();
</script>

<script language=JavaScript for=gcDs2 event="OnLoadStarted()">
	Grid1.DataID = "gcDs_temps";
</script>

<script language=JavaScript for=gcDs1 event="onloadCompleted(row,colid)">

	var temp_artc_cnt1=0;
	for (var i=1; i<=gcDs2.countrow; i++){   //주문상세데이타
	  temp_artc_cnt1=0;
		for (var j=1; j<=gcDs1.countrow; j++){ //입고데이타
			var ord_no2 = gcDs2.namevalue(i,"order_no");
			var ord_no1 = gcDs1.namevalue(j,"order_no");
			var ord_seq2 = gcDs2.namevalue(i,"order_seq");
			var ord_seq1 = gcDs1.namevalue(j,"order_seq");
			var artc_cnt2 = gcDs2.namevalue(i,"artc_cnt");
			var artc_cnt1 = gcDs1.namevalue(j,"artc_cnt");

			if (ord_no2==ord_no1 && ord_seq2==ord_seq1){
			  temp_artc_cnt1=temp_artc_cnt1+artc_cnt1;
				
				if (artc_cnt2==temp_artc_cnt1) gcDs2.namevalue(i,"BGTYPE")="A";
				else if (artc_cnt2>temp_artc_cnt1) gcDs2.namevalue(i,"BGTYPE")="B";

			}
		}
	}

	gcDs2.ResetStatus();
	Grid1.DataID = "gcDs2";
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
			  <img src="../../../Common/img/btn/btn_edi_re.gif"  style="cursor:hand" onclick="ln_EDI_Receive()">
				<img src="../../../Common/img/com_b_query.gif" style="cursor:hand" onclick="ln_Query();">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
				  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:20px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=60>반출일자</td>
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
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee"  width=60>주문번호</td>
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
						
						<td class="tab12" style="height:30px;text-align:center" bgcolor="#eeeeee" width=60>업체명</td>
						<td class="tab12_left" >&nbsp;<input id="CUST_NM" name="CUST_NM" type="text" class="txt11" style='width:120;position:relative;left:0px;top:0px;ime-mode:active' ></td> 
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee" width=60>사업명</td>
						<td class="tab12_left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=LINE_PART  style='border:0;position:relative;left:0px;top:2px;height:220;width:120px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc1">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^120">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value="0">
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td> 
						<td class="tab12" style="text-align:center" bgcolor="#eeeeee" width=60>납품구분</td>
						<td >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=DLVL_TYPE  style='border:0;position:relative;left:0px;top:2px;height:220;width:100px;' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value="gcDs_etc9">
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value="True">
								<param name=ListExprFormat	value="MINORNM^0^100">
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
						<td height=20 bgcolor=#FFFF99 ><B>&nbsp;&nbsp;주문정보&nbsp; ( * 노란 선택은 공장상차도 중 배차완료 된 데이터임. 수작업 입고 해야합니다.)</B></td>
						<td height=20 bgcolor=#FFFF99 align=right>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid3 style="width:100%;height:162px;border:0 solid #777777;border-top-width:1px;border-bottom-width:1px;display:block" viewastext>
							<PARAM NAME="DataID"			VALUE="gcDs3">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<param name="ColSizing"  value="true">  
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE=" 
									<F> Name='No.'				  	ID='SeralNo' 		HeadAlign=Center HeadBgColor=#E8E8E8 Width=30	 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center  Value={ToString(RowCount-CurRow+1)}	</F>
									<C> Name='Project'				ID=LINE_PART		HeadAlign=Center HeadBgColor=#eeeeee Width=120 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' edit=none  suppress=1, show=false</C> 
									<C> Name='상태'					ID=ORDER_STS 	HeadAlign=Center HeadBgColor=#eeeeee Width=40  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center EditStyle=Lookup Data='gcDs_etc0:MINORCD:MINORNM' edit=none, suppress=1</C>
									<C> Name='반출일자'			ID=EDT_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center  MASK='XXXX-XX-XX' edit=none, suppress=2  </C>
									<C> Name='화주'					ID=SHIPPER			HeadAlign=Center HeadBgColor=#eeeeee Width=100 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=left, suppress=3 edit=none  </C> 
									<C> Name='상차지'				ID=LD_CARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=50  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center, suppress=4 edit=none,	 editstyle=LookUp Data='gcDs_etc4:MINORCD:MINORNM'  </C> 
									<C> Name='하차지'				ID=OFF_CARGO	HeadAlign=Center HeadBgColor=#eeeeee Width=50  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center, suppress=5 edit=none,	 editstyle=LookUp Data='gcDs_etc5:MINORCD:MINORNM'  </C> 
									<C> Name='배정번호'			ID=CARINFO			HeadAlign=Center HeadBgColor=#eeeeee Width=190 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=left, edit=none  </C> 
									<C> Name='품명'					ID=ARTC_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=left, edit=none  </C>   
									<C> Name='수량'					ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=right edit=none  </C>
									<C> Name='용적(CBM)'		ID=PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=50  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=right edit=none  </C>
									<C> Name='중량(KG)'			ID=PKG_WGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=60  bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=right edit=none  </C>
									<C> Name='투입목적/공정' 	ID=OBJ_REMK		HeadAlign=Center HeadBgColor=#eeeeee Width=120 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=left edit=none, suppress=3</C>
									<C> Name='제출일자'			ID=CRE_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center  edit=none show=false</C>
									<C> Name='납품일자'			ID=LD_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center MASK='XXXX-XX-XX' edit=none, show=false  </C>
									<C> Name='포장수'				ID=PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=90  align=right edit=none, show=false  </C> 
									<C> Name='주문번호'			ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center edit=none, show=false  </C>  
									<C> Name='SEQ'					ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=right show=false edit=none  </C> 
									<C> Name='차량'					ID=CAR_NO   		HeadAlign=Center HeadBgColor=#eeeeee Width=100 bgcolor={IF(CAR_NO<>'' AND DLVL_TYPE='0002','Yellow')} align=center edit=none  </C> 
								">
								
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr>
						<td height=20  ><B>&nbsp;&nbsp;주문상세정보 &nbsp;&nbsp;&nbsp;</B><input id="A" name="A" type="text" class='txt11' style='width:30;position:relative;left:0px;top:0px;ime-mode:active;background-color:#DDF2FC' > 하늘색:전체입고, <input id="B" name="B" type="text" class='txt11' style='width:30;position:relative;left:0px;top:0px;ime-mode:active;background-color:#FFFF99' > 노란색:부분입고, <input id="C" name="C" type="text" class='txt11' style='width:30;position:relative;left:0px;top:0px;ime-mode:active;background-color:#FFFFFF' > 흰색:미입고 </td>
						 <td align=right width = 265> 
						<img id=imgAll src="../../../Common/img/btn/btn_all.gif" style="position:relative;left:12px;top:2px;cursor:hand" onclick="__SelectAll();" alt="주문정보를 전체 선택합니다.">
						<img id=imgAllCancle src="../../../Common/img/btn/btn_all_cancel.gif" style="position:relative;left:-6px;top:2px;display:none;cursor:hand" onclick="__SelectCancle();"  alt="선택한 주문정보를 취소합니다.">
						</td>
					</tr>
					<tr> 
						<td colspan=2>
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:100%;height:182px;border:1 solid #777777;border-bottom-width:0px;border-left-width:0px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs2">
								<PARAM NAME="TitleHeight" 	VALUE="22">
								<PARAM NAME="RowHeight"   	VALUE="20">
								<PARAM NAME="BorderStyle" 	VALUE="0">
								<PARAM NAME="Fillarea"			VALUE="true">
								<PARAM NAME="Editable"			VALUE="false">
								<param name="ColSizing"  		value="true">  
								<param name="AllShowEdit" 	VALUE="true">
								<Param Name="ReDraw"       	value=true>
								<PARAM NAME="Format"			VALUE="  
									<F> Name='◈'					ID=CHECK			HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center, edit=none, EditStyle=CheckBox, cursor=hand</F>  
									<F> Name='주문번호'		ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=center,	edit=none</F>  
									<F> Name='업체명'			ID=VEND_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left,		edit=none show=false</F> 
									<C> Name='No.'				ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center edit=none show=false</C>   
									<C> Name='품명'				ID=ARTC_NM  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left   edit=none</C>  
									<C> Name='규격'				ID=STN_SZNM		HeadAlign=Center HeadBgColor=#eeeeee Width=100	align=left edit=none, show=false</C>
									<C> Name='단위'				ID=ARTC_UNIT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=left edit=none, editstyle=LookUp Data='gcDs_etc13:MINORCD:MINORNM'</C>
									<C> Name='수량'				ID=ARTC_CNT		BgColor={Decode(GBN_JEBSU,'Y',Decode(GBN_ARTC_CNT,'N','#DDF2FC','#FFFFFF'),'#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right SHOW=FALSE</C> 
									<C> Name='현재수량'		ID=GBN_ARTC_CNT  	HeadAlign=Center HeadBgColor=#eeeeee Width=60  align=right   edit=none SHOW=FALSE</C>  
									<C> Name='수량'				ID=ARTC_CNT		BgColor={Decode(BGTYPE,'A','#DDF2FC','B','#FFFF99','C','#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right show=false</C> 
									<C> Name='수량'				ID=ARTC_CNT		bgcolor={Decode(BGTYPE,'A','#DDF2FC','B','#FFFF99','C','#FFFFFF')} HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right </C> 
									<C> Name='수량'				ID=ARTC_CNT		bgcolor=@acolor HeadAlign=Center HeadBgColor=#eeeeee Width=50		align=right show=false </C> 
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이(CM)'		ID=PKG_LNGTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='폭(CM)'			ID=PKG_WIDTH	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='높이(CM)'		ID=PKG_HEIGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='용적(CBM)'	ID=PKG_CBM  		HeadAlign=Center HeadBgColor=#eeeeee Width=80	align=right </C>  
										<C> Name='중량(KG)'		ID=PUNIT_WGHT 	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
										<C> Name='포장수량'		ID=PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none </C> 
									</G>
									<C> Name='포장수량'			ID=MIX_OTHERS 	HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='포장수량'			ID=SAMEAS			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,edit=none, show=false </C> 
									<C> Name='총용적(CBM)'		ID=T_CBM			HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PKG_CBM * PKG_CNT } dec =2</C>
									<C> Name='총중량(KG)'		ID=T_WEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=80		align=right,edit=none  value={PUNIT_WGHT * PKG_CNT } dec ">
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
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid2 style="width:100%;height:232px;border:1 solid #777777;border-bottom-width:0px;border-left-width:0px;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<PARAM NAME="AllShowEdit" VALUE="true">
								<PARAM NAME="ColSizing"		VALUE="true">  
								<PARAM NAME="ViewSummary"	value="1">
								<PARAM NAME="Format"			VALUE="
									<F> Name='No.',				ID=SeralNo 			HeadAlign=Center HeadBgColor=#e8e8e8 Width=25		Align=Center	Value={ToString(RowCount-CurRow+1)}	</F>
									<C> Name='입고일자'		ID=ENTER_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=left    edit=none  Mask='XXXX-XX-XX'</C>  
									<C> Name='입고번호'		ID=ENTER_NO			HeadAlign=Center HeadBgColor=#eeeeee Width=90   align=center  edit=none  </C>  
									<C> Name='물류창고'		ID=WAREHOUSE		HeadAlign=Center HeadBgColor=#eeeeee Width=115  align=center  edit=none Value={Decode(WAREHOUSE,'0001','파주물류센터','0002','고성물류센터')}</C> 
									<C> Name='SEQ'				ID=GOODS_SEQ		HeadAlign=Center HeadBgColor=#eeeeee Width=30		align=center  edit=none </C>
									<C> Name='물품명'			ID=ARTC_NM			HeadAlign=Center HeadBgColor=#eeeeee Width=115	align=left    edit=none </C>
									<C> Name='수량'				ID=ARTC_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	SumText=@sum</C> 
									<G> Name='단위포장' HeadBgColor=#eeeeee
										<C> Name='길이(CM)'		ID=PKG_LNGTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='폭(CM)'			ID=PKG_WIDTH		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='높이(CM)'		ID=PKG_HEIGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right</C> 
										<C> Name='용적(CBM)'	ID=PKG_CBM  		HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right </C> 
										<C> Name='중량(KG)'		ID=PUNIT_WEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none  SumText=@sum</C> 
										<C> Name='포장수량'		ID=PKG_CNT			HeadAlign=Center HeadBgColor=#eeeeee Width=70		align=right,	edit=none SumText=@sum</C> 
									</G>
									<C> Name='총용적(CBM)'	ID=TOTAL_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none SumText=@sum</C>
									<C> Name='총중량(KG)'		ID=TOTAL_WEIGHT HeadAlign=Center HeadBgColor=#eeeeee Width=90		align=right,	edit=none SumText=@sum</C>
									 
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

