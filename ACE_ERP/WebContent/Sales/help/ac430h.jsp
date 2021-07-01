<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%
/******************************************************************************
 * 시스템명 		: 환불 상세  Help 
 * 프로그램ID 	: ac430h
 * J  S  P		    : ac430h
 * 서 블 릿		: Au430h
 * 작 성 자		: 정영식
 * 작 성 일		: 2008-03-20
 * 기능정의		: 환불상세조회 
 * [수정 일 자][수정자] 내용
 * [2008-10-15][심동현] 입금액 1,7,8, 회계구분 코드 적용..
 *
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	// 대리점 구분
	String gubun = HDUtil.nullCheckStr(request.getParameter("gubun"));
	String title = "환불상세정보[환불액/환입액 입력/수정]";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title>환불상세정보 : 환불액과 환입액 입력, 수정 가능　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            사용자 정의 Java Script                       *
	 ***************************************************************************/
%>
		<script language="javascript">
			var strParam=window.dialogArguments;
			var sRsv_sid = strParam.ds1.namevalue(strParam.ds1.rowposition,"rsv_sid");
			var sstatus_cd = strParam.ds1.namevalue(strParam.ds1.rowposition,"status_cd");
			
			//alert("sstatus_cd::"+sstatus_cd);
			
			function fnOnLoad() {
			    cfStyleGrid(getObjectFirst("gr1"), "comn");
			    fnSelect();
			
			   if(sstatus_cd=="JO"||sstatus_cd=="PO"){ //접수완료, 환불완료
			   //if(sstatus_cd=="TO"){
			    	getObjectFirst("app").style.display = "inline";
		    		getObjectFirst("can").style.display = "inline";
				}else{
			        getObjectFirst("app").style.display = "none";
		    		getObjectFirst("can").style.display = "none";
				}
			    
			    
			    //if(sstatus_cd=="JO"){
			       	//getObjectFirst("app").style.display = "inline";
		    		//getObjectFirst("cal").style.display = "inline";
			    //}else{
			    	//getObjectFirst("app").style.display = "none";
		    		//getObjectFirst("cal").style.display = "none";
			   // }
			}
			
			/*
			function fnSelect() {
				fnSubSelect1();
			}
			*/
			//  
			function fnSelect() {
			   /*
				if(!keyword.value) {
					alert("대리점코드 또는 대리점명을 입력해주세요.");
					keyword.focus();
					return false;
				};
			   */	
			   
			    v_job="S";
				ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac430H?proType=S&dsType=1&sRsv_sid=" + sRsv_sid ;
				//prompt('ds1.Dataid::',ds1.Dataid  );
				ds1.Reset();
			
			}
			
			
			/*
			function fnAdd() {
				var row = ds1.rowposition;
			
				window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
									 ds1.namevalue(row, "client_nm") + ";" +
								 	 ds1.namevalue(row, "client_cd");
			 	fnClose();
			}
			
			*/
			function fnClose() {
				window.close();
			}
			
			
			function fnApply(){
			   /*
			    for(i=1;i<ds1.countrow;i++){
			    	alert("i::::"+i+"::::::::::"+ds1.SysStatus(ds1.RowPosition));
			   }
			   */
			   
			  if(sstatus_cd!="JO"&&sstatus_cd!="PO"){ //접수완료,환불완료
			  //if(sstatus_cd!="TO"){
			   		alert("작업상태가 접수완료 또는 환불완료가 아닙니다. 확인 하십시요.");
			   		return;
			   }
			   			   
			   if(!fnApply_Chk()) return ; 
			   			
			   if (ds1.isUpdated ){ 
			        v_job = "I";	
			         window.status="저장 중입니다. 잠시만 기다려 주십시오...";
			
			         ln_TRSetting(tr1, 
			             "<%=dirPath%><%=HDConstant.PATH_HELP%>Ac430H",
			             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
			             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
			             
			             //prompt('',ds1.text);
			             tr_post(tr1);
		       }
			}
			
			
			//저장시 금액 체크 
			function fnApply_Chk(){
				for (i =1; i<=ds1.countrow;i++){
					if(ds1.namevalue(i,"PAY_AMT3")!=0  || ds1.namevalue(i,"PAY_AMT4")!=0){
						if(ds1.namevalue(i,"PAY_AMT1")<ds1.namevalue(i,"PAY_AMT3")+ds1.namevalue(i,"PAY_AMT4")){
							alert("입금액보다 환불+환입액이 더 많습니다. 확인 바랍니다.");
							return false;
						}
					}
				}
				return true;
			}
			
			
            function fnCancel(){
				ds1.undoAll();
			}
            			
           // 저장후 데이타 중 가상계좌, 카드, 무통장, 보증금,의 환불금액을 Parent에 반영함. 			
            function fnData_Trans(){
            
                var dblbank_amt=0;
                var dblcard_amt=0;
                var dblaccount_amt=0;
                var dbldepo_amt=0;
                var dblonline_amt=0;
                var dblgift_amt=0;
      	
            	for(k=1;k<=ds1.countrow;k++){
            		if(ds1.namevalue(k,"PAY_CD")=="020"){ //가상계좌
            			dblbank_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="040"){ //신용카드, 
            		    dblcard_amt += ds1.namevalue(k,"PAY_AMT3"); 
            		}else if(ds1.namevalue(k,"PAY_CD")=="080"){ //무통장
            			dblaccount_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="100"){ //보증금대체 
            			dbldepo_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="050"){ //인터넷 (카드) 
            			dblonline_amt += ds1.namevalue(k,"PAY_AMT3");
            		}else if(ds1.namevalue(k,"PAY_CD")=="060"){ //상품권 
            			dblgift_amt += ds1.namevalue(k,"PAY_AMT3");
            		}
            	}

            	strParam.bank_amt.text = dblbank_amt;
            	strParam.card_amt.text = dblcard_amt;
            	strParam.account_amt.text = dblaccount_amt;
            	strParam.depo_amt.text = dbldepo_amt;
            	strParam.online_amt.text = dblonline_amt;
            	strParam.gift_amt.text = dblgift_amt;
            	
            	strParam.fnTotSum(); //계 자동 계산 
            }			
		
		</script>
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
	   //alert("저장성공");
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
       	
        //메시지 처리
        var msg='';
        
        //alert("msgDS::"+msgDS.CountRow);
        
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);     
          	
         fnData_Trans(); 	    	
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
        
        //에러메시지
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        //메시지 처리
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);		              
	</script>		
		
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			ft_cnt1.innerText="<%=HDConstant.S_MSG_SEARCH_DATA%>";
//			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			ft_cnt1.innerText="Cnt : " + row;
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
//			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  그리드 더블클릭 이벤트 발생
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
		    /*
			var row = ds1.rowposition;			
			
			window.returnValue = ds1.namevalue(row, "client_sid") + ";" +
								 ds1.namevalue(row, "client_nm") + ";" +
								 ds1.namevalue(row, "client_cd");
			window.close();
			*/
		</script>
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	;
            }
		</script>
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object  id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
</object>


<%=HDConstant.COMMENT_END%>

	</head>	
	
<!--  BODY START -->
		<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table>
			<tr>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:1px;top:5px;width:270px;">
						<tr>
							<td  height=25>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center><font style="position:relative;top:1px;width:240;height:15;left:5px;"><%=title%></font>
								<input type="hidden" name="gubun" value="<%=gubun%>" style="width:20;position:relative;top:2px;border:0;" readonly>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:4px;top:7px;width:200px">
						<tr>
							<td align=right>
							    <img src="<%=dirPath%>/Sales/images/save.gif"	 id=app style="cursor:pointer;position:relative;left:3px;top:3px;display:none"  onClick="fnApply()">
								<img src="<%=dirPath%>/Sales/images/cancel.gif" id=can style="cursor:pointer;position:relative;left:3px;top:3px;display:none"  onclick="fnCancel()">
								<img src="<%=dirPath%>/Sales/images/p_exit.gif"    style="cursor:pointer;position:relative;left:3px;top:3px;" onClick="fnClose()">  
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
			<tr>
				<td>
<%
/*---------------------------------------------------------------------------->
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>
					<comment id="__NSID__"><object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%>  style="width=489px; height:200px;border:1 solid #777777;">
						<param name="DataID"		  value="ds1">
						<param name="BorderStyle"   VALUE="0">
                		<param name=ColSizing         value="true">
                		<param name="editable"         value="true">
                		<param name=UsingOneClick  	value="1">
                        <Param Name="AllShowEdit"   value="True">
                        <param name=ViewSummary value=1>
						<param name="Format" 		  value="
							<c> Name='입금일자'	ID='PAY_DATE'		     Width=66  align=center   edit = none  SumText='합계'    mask='XXXX/XX/XX'  suppress=1 </c>
							<c> Name='입금구분' 	ID='PAYNM'	  	         Width=62  align=center   edit = none  </c>
							<c> Name='판매가 ' 		ID='PAY_AMT0'	  	 Width=60  align=right      edit = none  SumText=@max  dec=0    </c>
							<c> Name='입금액' 		ID='PAY_AMT1'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
							<c> Name='매출정산' 	ID='PAY_AMT2'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
							<c> Name='환불액' 		ID='PAY_AMT3'	  	 Width=60  align=right      edit = RealNumeric  SumText=@sum  dec=0</c>
							<c> Name='환입액' 		ID='PAY_AMT4'	  	 Width=60  align=right      edit = RealNumeric  SumText=@sum  dec=0</c>
							<c> Name='승인취소' 	ID='PAY_AMT5'	  	 Width=60  align=right      edit = none  SumText=@sum  dec=0</c>
						">
												
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
				</td>
			</tr>
			<tr>
				<td>
					<fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
					&nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
					</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<!--  상태바 플레쉬. src 밸류에 .swf를 직접 넣는 것이 브라우져 패치로 오류를 일으킴 
				따라서 .swf를 담은 페이지를 src로 지정해서 로딩화면을 보여주는 것이 맞을 듯.
				적절한 로딩화면이 사실 좋다고 생각하긴 함.
				해당 페이지의 TIP이 들어가 있는? 읽을 시간도 안됨;;; 움.. -->
			<iframe id="LowerFrame" 
				name="work" 
				style="display:none; position:absolute; left:100px; top:150px;" 
				Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.jpg" 
				width="320px" 
				height="42px">
			</iframe>	
			</td>
			</tr>
		</table>
	</body>
	<!-- BODY END -->
</html>