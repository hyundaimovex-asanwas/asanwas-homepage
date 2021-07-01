<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산  주문상태변경
+ 프로그램 ID	: TR00214.HTML
+ 기 능 정 의	: 주문상태변경
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
</OBJECT> 

<OBJECT id=gcDs_etc0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT> 

<OBJECT id=gcDs_etc1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT> 

<OBJECT id=gcDs_etc2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT>  

<OBJECT id=gcDs_etc3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="false"> 
</OBJECT> 

<OBJECT id=gcDs_etc4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	 <param name=SyncLoad value="true"> 
</OBJECT> 

<OBJECT id=gcDs_etc5 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
		Description : 페이지 로딩
	******************************************************************************/ 
	function Start(){
	
		gcDs_etc0.DataId =  "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //상태
		gcDs_etc0.Reset() ; 

		gcDs_etc1.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0002"; //Project
		gcDs_etc1.Reset() ; 

		gcDs_etc2.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //Project
		gcDs_etc2.Reset() ;

		gcDs_etc3.DataId =   "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0009"; //Project
		gcDs_etc3.Reset() ;

		gcDs_etc4.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //상차지 
		gcDs_etc4.Reset();

		gcDs_etc5.DataID = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00501_s1?v_str1=0007";  //하차지 
		gcDs_etc5.Reset(); 

		if(location.search){
		
			var str0=location.search.split("&")[0];
			var str1=location.search.split("&")[1];
			var str2=location.search.split("&")[2];
			var str3=location.search.split("&")[3];
			var str4=location.search.split("&")[4];
			var str5=location.search.split("&")[5];
			var str6=location.search.split("&")[6];
		}

		if (str1=="" || str1==undefined){
		
			TO_DATE.Text = gs_date ;
			FROM_DATE.Text =gs_date ; 
			
		} else {
		
			TO_DATE.Text		= str1;
			FROM_DATE.Text	= str2;
			
			PROJECT.index		= PROJECT.IndexOfColumn("MINORCD", str3);
			
			QMANAGER.Value	= str4;
			ORDER_NO.Text		= str5;
			
			if (PROJECT.IndexOfColumn("MINORCD", str6)<0) ORDER_STS.index = 0;
			
			else ORDER_STS.index = PROJECT.IndexOfColumn("MINORCD", str6);

			ln_Query();
		}

		curr_date.Text = gs_date ; 
		
		MANAGER.value = gusrid ; 
		MANAGER.disabled = "true" ; 
		
	}


	/******************************************************************************
		Description : 
	******************************************************************************/
	function ls_EDI(){

	alert("개발중!");

	
	}



	/******************************************************************************
		Description : 
	******************************************************************************/ 
	function ln_Query(){
	
		var ls_from_date = FROM_DATE.Text ; 
		var ls_to_date = TO_DATE.Text ; 
		var ls_project = PROJECT.BindColVal ; 
		var ls_ordno = ORDER_NO.Text ;
		var ls_ordsts = ORDER_STS.BindColVal ;

		if(ORDER_STS.BindColVal =='0001'){
			ORDER_STS1.index=ORDER_STS1.IndexOfColumn("MINORCD", "0002");
			ORDER_STS1.Enable=false;
			ORDER_STS12.value = "접수";
		} else {
			ORDER_STS1.index = 0 ; 
			ORDER_STS1.Enable=false;
		}

		gcDs1.DataId = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>dsOrderSts?NOH=Y&gstr0=I&gstr1="+ls_from_date+"&gstr2="+ls_to_date+"&gstr3="+ls_project+"&gstr4="+ls_ordno+"&gstr5=" + ls_ordsts ; 
		gcDs1.Reset();
	} 

	/******************************************************************************
		Description : 
	******************************************************************************/ 
	function ln_Save(){
		if (confirm("선택하신 주문정보의 상태를 변경하시겠습니까 ?")){
			gcTr01.KeyValue = "trOrderRegMst(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderSts";
			gcTr01.post();
		}
	}

	/******************************************************************************
		Description :	삭제
	******************************************************************************/ 
	function ln_Delete(){

    var strSendGb="";     //전송구분
    var strChkGb="";      //체크박스 구분

		gcDs1.ClearAllMark();
		if (gcDs1.countrow<1) return;

		if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){
      for(i=1;i<=gcDs1.CountRow;i++){
				if(gcDs1.namevalue(i,"CHK")=="T"){
           strChkGb="Y";
					 if(gcDs1.namevalue(i,"EDI_STS")=="S"||gcDs1.namevalue(i,"EDI_STS")=="A"||gcDs1.namevalue(i,"EDI_STS")=="Y"){
							alert("EDI 전송이 되었습니다. 삭제 할 수 없습니다.");
              return false;
           }else{
							strSendGb="Y";
           }
        }
      } 

      if(strChkGb!="Y"){
				alert("삭제할 데이터를 선택하십시요.");
        return false;
      }

      if(strSendGb=="Y"){
				alert("접수된 주문정보이오니 한번더 확인해 주십시오.");
      }
		}

		
		if (confirm("선택하신 주문정보를 삭제하시겠습니까 ?  ")){
			for(i=1;i<=gcDs1.CountRow;i++) {
				if(gcDs1.namevalue(i,"CHK")=="T") {
					gcDs1.RowMark(i)=1;		
				}
			}	
	
			gcDs1.DeleteMarked();
			gcTr01.KeyValue = "trOrderCar(I:DATA=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>tr00101_t1";
			gcTr01.post();
		}
	}



	/******************************************************************************
		Description : 
	******************************************************************************/ 
	function ln_Save(){
		//2007.08.22 정영식
		var ins_sts="";
		for(i=1;i<=gcDs1.countrow;i++){
			if(gcDs1.NameValue(i,"CHK")=="T"){
				if(gcDs1.NameValue(i,"ORDER_STS")=="0002"){
					alert("이미 접수된 건입니다. ") ; 			
					gcDs1.NameValue(i,"CHK" )="F" ;  
					gcDs1.RowMark(i) = 1;
					return;
				}else if(gcDs1.NameValue(i,"ORDER_STS")=="0001"&&fn_trim(gcDs1.NameValue(i,"ING_STS"))=="X"){
					alert("이미 취소된 건입니다. 재 접수할 수 없습니다.") ; 			
					gcDs1.NameValue(i,"CHK" )="F" ;  
					gcDs1.RowMark(i) = 1;
					return;
				}
			}
		}
		
		//신규 접수
		if (confirm("선택하신 주문정보의 상태를 변경하시겠습니까 ?")){
			gcTr01.KeyValue = "trOrderRegMst(I:USER=gcDs1)";
			gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderSts";
			//prompt("",gcDs1.text);
			gcTr01.post();
		}

		//EDI 전송전 취소 후 재접수할 경우
	}

	/******************************************************************************
	Description : 주문 취소 (2008.11.10)
******************************************************************************/ 
function ln_Cancel(){
  var strChkGb="";
	
	if (gcDs1.namevalue(gcDs1.rowposition,"ORDER_STS")!="0001"){
		for(i=1;i<=gcDs1.CountRow;i++){
			if(gcDs1.namevalue(i,"CHK")=="T"){
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
		return false;
	}

	if (confirm("선택하신 주문정보의 상태를 취소하시겠습니까 ?")){
		gcTr01.KeyValue = "trOrderCancel(I:USER=gcDs1)";
		gcTr01.Action = "<%=dirPath%><%=HDConstant.PATH_TRANSFER%>trOrderCancel";

		gcTr01.post();
	}
}

</SCRIPT> 

<script language=JavaScript for=gcTr01 event=OnSuccess()>
	gcDs1.Reset() ;
</script>

<script language=JavaScript for=gcDs_etc2 event=OnLoadCompleted(rowcnt)>
	gcDs_etc2.InsertRow(1) ; 
	gcDs_etc2.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc2.NameValue(1,"MINORNM" )  = "===선택===" ; 
	ORDER_STS.Index = 0 ;
</script>

<script language=JavaScript for=gcDs_etc3 event=OnLoadCompleted(rowcnt)>
	gcDs_etc3.InsertRow(1) ; 
	gcDs_etc3.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc3.NameValue(1,"MINORNM" )  = "===선택===" ; 
</script>

<script language=JavaScript for=gcDs_etc1 event=OnLoadCompleted(rowcnt)>
	gcDs_etc1.InsertRow(1) ; 
	gcDs_etc1.NameValue(1,"MINORCD" )  = "    " ; 
	gcDs_etc1.NameValue(1,"MINORNM" )  = "===선택===" ; 
	PROJECT.index = 0 ; 
</script>

<script language="javascript"  for=gcGR1 event=OnHeadCheckClick(Col,Colid,bCheck)>
	if(bCheck == "1")	{
		for(i=1;i<=gcDs1.CountRow;i++){ 
			if(gcDs1.NameValue(i,"ORDER_STS") != "0002") gcDs1.NameValue(i,"CHK") = "T";
		} 
	} else {
		for(i=1;i<=gcDs1.CountRow;i++){ 
			if(gcDs1.NameValue(i,"ORDER_STS") != "0002") gcDs1.NameValue(i,"CHK") = gcDs1.OrgNameValue(i,"CHK");
		} 
	}
</script>

<script language=JavaScript for=gcGR1 event=OnClick(row,colid)>

  if(colid!="CHK") return;
  
  if(gcDs1.CountRow<1) return;
	

	if(gcDs1.NameValue(row,"ORDER_STS") == "0002"&&gcDs1.NameValue(row,"INS_STS") == ""){ 
		alert("이미 접수된 건입니다. ") ; 
		gcDs1.NameValue(row,"CHK" )   ="F" ;  
		return false ;
	}

	if(gcDs1.NameValue(row,"ORDER_STS") == "0004"){ 
		alert("추가 접수된 건은 추가물품 처리로 가셔서 처리하시기 바랍니다. ") ; 
		gcDs1.NameValue(row,"CHK" )   ="F" ;  
		return false ;
	}

	if(colid == "CHK") {
		var ls_chk = gcDs1.NameValue(row,"CHK");
		if (strim(ls_chk)=="" || strim(ls_chk)=="F") gcDs1.NameValue(row,"CHK") = "T";
		else gcDs1.NameValue(row,"CHK") = gcDs1.OrgNameValue(row,"CHK");

		//ORDER_NO 가 동일한 건은 모두 체크함.
		for(i =1 ; i<=gcDs1.CountRow ; i++ ) {
			if(gcDs1.NameValue(row,"ORDER_NO") == gcDs1.NameValue(i,"ORDER_NO" )){
				gcDs1.NameValue(i,"CHK" ) = gcDs1.NameValue(row,"CHK") ; 
			} 
		}
	} 

</script>

<script language=JavaScript for=gcGR1 event=OnDblClick(row,colid)>

		if (row<1) return;
	
		if (colid=="CHK") return;

		var result="";
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

	    arrParam[0]="update1";
	    arrParam[1]=gcDs1.namevalue(row,"ORDER_NO");
	    arrParam[2]="A";	  

		strURL = "<%=dirPath%>/Transfer/jsp/tr00202.jsp?gstr1=update&gstr2="+gcDs1.NameValue(row,"ORDER_NO")+"&A" ; 
		
		strPos = "dialogWidth:900px;dialogHeight:700px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
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
			<td width="876" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">
				<img src="<%=dirPath%>/Common/img/btn/com_b_cancle.gif" style="cursor:hand" onclick="ln_Cancel()">
				<img src="<%=dirPath%>/Common/img/btn/b_save.gif" style="cursor:hand" onclick="ln_Save()"> 
				<img src="<%=dirPath%>/Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_Delete()">
				<img src="<%=dirPath%>/Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">
			</td>
		</tr>
		<tr><td height="1px" colspan=2></td></tr>
		<tr>
			<td colspan=2>
			  <table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
					<tr>
						<td class="tab11" style="height:30px;" bgcolor="#eeeeee" width=75>&nbsp;반입일자</td>
						<td class="tab21" style="width:250px;">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=FROM_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:65px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="cursor:hand;position:relative;left:0px;top:1px;" onclick="__GetCallCalendar('FROM_DATE', 'Text');">&nbsp;&nbsp;<font style="position:relative;top:-2px;">~</font>&nbsp;&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=TO_DATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:5px; width:65px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="YYYY/MM/DD">
									<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Common/img/btn_calendar.gif" style="cursor:hand;position:relative;left:0px;top:1px;" onclick="__GetCallCalendar('TO_DATE', 'Text');">  
						</td>
						<td class="tab11" bgcolor="#eeeeee" width=75>&nbsp;Project</td>
						<td class="tab21" >&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=PROJECT  style='border:0;position:relative;left:0px;top:2px;width:160px;height:200' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc1>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^160">
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td class="tab11" bgcolor="#eeeeee"  width=75>&nbsp;확인자</td>
						<td class="tab22"  >&nbsp;<input id="QMANAGER" name="QMANAGER" type="text" class="txt11" style='width:130;position:relative;left:0px;top:0px;ime-mode:active'></td>
					</tr>
					<tr>
						<td class="tab12" style="height:30px;" bgcolor="#eeeeee"  width=75>&nbsp;주문번호</td>
						<td class="tab12" style="text-align:left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_NO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:6px; width:70px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
									<param name=Alignment			value="0">
									<param name=Border	      value="false">
									<param name=Format	      value="##########">
									<param name=PromptChar	  value="_">
									<param name=UpperFlag			value=1> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>   
						</td>
						<td class="tab12" bgcolor="#eeeeee"  width=75>&nbsp;현재상태</td>
						<td class="tab12" style="text-align:left">&nbsp;
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_STS  style='border:0;position:relative;left:0px;top:2px;width:120px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69>
								<param name=ComboDataID			value=gcDs_etc2>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=ListExprFormat	value="MINORNM^0^120">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr> 
				</table> 
			</td>
		</tr> 
		<tr><td height=5 colspan=2></td></tr>
		<tr>
			<td colspan=2> 
				<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:300px;font-size:9pt;background-color:#ffffff;border:1 solid #708090" >
					<tr>
						<td bgcolor="#eeeeee" align=right class=tab11 colspan=2 style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							확인자&nbsp;&nbsp;:<input id="MANAGER" name="MANAGER" type="text" class="txt11" style='width:130;position:relative;left:0px;top:-1px'>&nbsp;&nbsp; 확인일시&nbsp;: &nbsp; 
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=curr_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:0px;top:4px; width:130px;height:17px;font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
							</OBJECT>
							<%=HDConstant.COMMENT_END%> &nbsp;&nbsp;&nbsp;변경할 상태&nbsp;&nbsp;:
							<input id="ORDER_STS12" name="ORDER_STS12" type="text" class="txt11" style='width:0;position:relative;left:0px;top:-1px' style=dispaly:none>등록 -- > 접수							
							<%=HDConstant.COMMENT_START%>
							<OBJECT id=ORDER_STS1  style='border:0;position:relative;left:0px;top:2px;height:110' classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  width=0 height=100  >
								<param name=ComboDataID			value=gcDs_etc3>  
								<param name=CBDataColumns		value="MINORCD,MINORNM">
								<param name=SearchColumn		value=MINORNM>
								<param name=SortColumn			value="MINORCD"> 
								<param name=Sort						value=True>
								<param name=Visible					value=false>
								<param name=ListExprFormat	value="MINORCD^2^32,MINORNM^1^100">								
								<param name=BindColumn			value="MINORCD">
								<param name=Index						value=0>
								<param name=InheritColor		value="true"> 
								<param name=ComboStyle			value=2>
							</OBJECT>
							<%=HDConstant.COMMENT_END%>&nbsp;&nbsp; 
							
							</td>
					</tr> 
					<tr>
						<td colspan=2 >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcGR1 style="width:874;height:402px;border:0 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcDs1">
								<PARAM NAME="TitleHeight" VALUE="22">
								<PARAM NAME="RowHeight"   VALUE="20">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="false">
								<PARAM NAME=ColSelect			VALUE="false"> 
								<PARAM NAME="IndWidth"		VALUE="17">
								<PARAM NAME="AllShowEdit" VALUE="true">  
								<param name=ColSizing  value="true">
								<param name="TitleHeight"	VALUE=30>
								<PARAM NAME="Format"			VALUE="  
									<F>	Name=''	ID=CHK, width=20 EditStyle=CheckBox	Pointer=Hand HeadCheck=false	HeadBgColor=#eeeeee HeadCheckShow=true align=center bgcolor=@acolor, Edit=none  bgcolor={IF(ING_STS='C','Gold')} </F>
									<C> Name='Project'				ID=LINE_PART	HeadAlign=Center HeadBgColor=#eeeeee Width=120  align=left EditStyle=Lookup Data='gcDs_etc1:MINORCD:MINORNM' edit=none  suppress=1, show=false</C> 
									<C> Name='상태'					ID=ORDER_STS	HeadAlign=Center HeadBgColor=#eeeeee Width=30   align=center EditStyle=Lookup Data='gcDs_etc0:MINORCD:MINORNM' edit=none, suppress=1 bgcolor={IF(ING_STS='C','Gold')} </C> 
									<C> Name='반입일자'			ID=EDT_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=70   align=center  MASK='XXXX-XX-XX' edit=none, suppress=2  bgcolor={IF(ING_STS='C','Gold')} </C>
									<C> Name='주문번호'			ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80   align=center edit=none, suppress=6  bgcolor={IF(ING_STS='C','Gold')} </C>  
									<C> Name='화주'					ID=SHIPPER			HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, suppress=3 edit=none  bgcolor={IF(ING_STS='C','Gold')} </C> 
									<C> Name='상차지'				ID=LD_CARGO		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=center, suppress=4 edit=none,	 editstyle=LookUp Data='gcDs_etc4:MINORCD:MINORNM'  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='하차지'				ID=OFF_CARGO	HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=center, suppress=5 edit=none,	 editstyle=LookUp Data='gcDs_etc5:MINORCD:MINORNM'  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='배정번호'			ID=CARINFO			HeadAlign=Center HeadBgColor=#eeeeee Width=190  align=left, edit=none  bgcolor={IF(ING_STS='C','Gold')}</C> 
									<C> Name='품명'					ID=ARTC_NM		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, edit=none  bgcolor={IF(ING_STS='C','Gold')}</C>   
									<C> Name='수량'					ID=ARTC_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='용적(CBM)'		ID=PKG_CBM		HeadAlign=Center HeadBgColor=#eeeeee Width=60   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='중량(KG)'			ID=PKG_WGHT		HeadAlign=Center HeadBgColor=#eeeeee Width=50   align=right edit=none   bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='투입목적/공정' 	ID=OBJ_REMK		HeadAlign=Center HeadBgColor=#eeeeee Width=120 align=left edit=none, suppress=3  bgcolor={IF(ING_STS='C','Gold')} </C>
									<C> Name='전송상태' 			ID=EDI_STS  		HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='1:미전송,S:전송중,Y:전송완료' bgcolor={IF(ING_STS='C','Gold')}</C>   
									<C> Name='수정상태' 			ID=ING_STS  		HeadAlign=Center HeadBgColor=#eeeeee Width=55   align=left edit=none  EditStyle=Combo Data='U:수정,C:취소,I:신규'  bgcolor={IF(ING_STS='C','Gold')}</C>          
									<C> Name='제출일자'			ID=CRE_DATE		HeadAlign=Center HeadBgColor=#eeeeee Width=80 align=center  edit=none bgcolor={IF(ING_STS='C','Gold')}</C>
									<C> Name='납품일자'			ID=LD_DATE			HeadAlign=Center HeadBgColor=#eeeeee Width=80 align=center MASK='XXXX-XX-XX' edit=none, show=false  </C>
									<C> Name='포장수'				ID=PKG_CNT		HeadAlign=Center HeadBgColor=#eeeeee Width=90 align=right edit=none, show=false  </C> 
									<C> Name='주문번호'			ID=ORDER_NO		HeadAlign=Center HeadBgColor=#eeeeee Width=80  align=center edit=none, show=false  </C>  
									<C> Name='SEQ'					ID=ORDER_SEQ	HeadAlign=Center HeadBgColor=#eeeeee Width=40  align=right show=false edit=none  </C> 
								">
							</OBJECT>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr style="display:none">
						<td width=29 class="tab11" bgcolor="#eeeeee">
						</td>
						<td class="tab11">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=Grid1 style="width:860;height:102px;border:1 solid #777777;display:block" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_educ">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Editable"		VALUE="true">
								<param name="AllShowEdit" VALUE="true">
								<PARAM NAME="Format"			VALUE="  
									<C> Name='▣'				ID=GRAYY		HeadAlign=Center HeadBgColor=#eeeeee Width=30 Mask='XXXX' align=center</C>  
									<C> Name='상태'			ID=PERFECT	HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=right</C> 
									<C> Name='확인자'		ID=GRAYY		HeadAlign=Center HeadBgColor=#eeeeee Width=100 Mask='XXXX' align=center</C> 
									<C> Name='확인일시'	ID=EDCCD  		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C>  
									<C> Name='입력자'		ID=PGCCD		HeadAlign=Center HeadBgColor=#eeeeee Width=100 align=left, editstyle=LookUp data='gcds_preduc:minorcd:minornm'</C> 
									<C> Name='입력일시'	ID=EDCCD		HeadAlign=Center HeadBgColor=#eeeeee Width=100  align=left, editstyle=LookUp data='gcds_hreduc:minorcd:minornm'</C>  
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
