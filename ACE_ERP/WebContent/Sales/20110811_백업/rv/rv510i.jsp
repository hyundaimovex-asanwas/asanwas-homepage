<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 취소/환불
 * 프로그램ID 	 : RV510I
 * J  S  P		 : rv510i
 * 서 블 릿		 : RV510I
 * 작 성 자		 : 안준성
 * 작 성 일		 : 2006-08-03
 * 기능정의		 : 취소/환불 (조회, 신규, 저장, 취소, 삭제)
 * [수  정   일  자][수정자] 내용
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-11-18][심동현] 공제율과 작업유형 간의 제약조건 강
 * [2008-11-21][심동현] 공제코드 수정. 이제 rv511i와 다릅니다.~
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);		   
   String firsttime = m_today.format(date.getTime()).substring(8,12);		      

    //대리점 구분
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
	<%//페이지로딩%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	<%//트리초기화 호출%>
			fnInit();
		}
	<%// 데이타셋 헤더 설정%>
	function fnSetHeader(){
		if (ds1.countrow < 1){
			v_job = "H";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
	            "JSP(O:DEFAULT=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);           
		}
		if (selectImgDs.countrow < 1){
			var s_temp1 = "PICTURE_INFO:STRING";
			selectImgDs.SetDataHeader(s_temp1);
		}		
	}
	<%// 선조회%>
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>'; 
		
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
                        
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
            "JSP(O:IMAGE=imgDs,O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);           
        <%//대리점%>
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
        <%//작업상태1%>
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset(); 
        <%//작업상태2%>
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();        
        <%//공제율%>
        ds_charge.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV027&s_item1=Y&s_item3=Y";
        ds_charge.Reset();        
        <%//송금은행%>
        ds_bancod.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC002&s_item1=Y";
        ds_bancod.Reset(); 
		
		<%//취소 및 환불%>
        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_item1=Y";
        codeDs1.Reset(); 
	}
	<%//메인조회%>
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("수정중인 행이 있습니다."); 
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sClientSid=" + sClientSid.value + "," 
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
            + "sBgnDate=" + sBgnDate.text + ","                         
            + "sEndDate=" + sEndDate.text;
		imgDs.ClearAll();
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
            "JSP(O:DS1=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }
	<%// 행추가(그리드별)%>
	function fnAddRow() {
		if ( sClientSid.value == '' ) {
			alert("대리점을 선택해 주세요");
			return;
		}
		ds1.addrow();
		ds1.namevalue(ds1.rowposition,"client_sid") = sClientSid.value;
		ds1.namevalue(ds1.rowposition,"accept_date") = '<%=firstday%>';
		ds1.namevalue(ds1.rowposition,"accept_time") = '<%=firsttime%>';		
		lc_status2.index = lc_status2.IndexOfColumn("detail", "RR");
		ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");	
		imgDs.addRow();		

		for ( i=1;i<=ds_client_info.CountRow;i++ ) {
			if ( sClientSid.value == ds_client_info.namevalue(i,"client_sid") )  {
				client_dam_nm.value = ds_client_info.namevalue(i,"client_dam_nm");
				mobile_no.value = ds_client_info.namevalue(i,"tel_no");
				break;
			}
		}
		
		sJobType.Index = 0;
	}
	<%// 행삭제(그리드별)%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
		 imgDs.DeleteRow(ds1.RowPosition);		
	}
	<%// 적용%>
	function fnApply() {
		if ( ds1.isUpdated || imgDs.isUpdated ) {	
			for ( i=1; i<= ds1.CountRow; i++ )  {
				if ( ds1.RowStatus(i) == 1 || ds1.RowStatus(i) == 3 ) {	<%//insert||update 인 경우%>
					//저장 전 체크
					if(ds1.namevalue(i,"accept_sid") == '' || ds1.namevalue(i,"accept_sid") == '0' ) {
						alert("신청서 번호를 입력해 주세요.");
						return;
					}			
					if(ds1.namevalue(i,"rsv_sid") == '' || ds1.namevalue(i,"rsv_sid") == '0' ) {
						alert("성명을 입력해 주세요.");
						return;
					}
					if(ds1.namevalue(i,"charge_cd") == '' || ds1.namevalue(i,"charge_cd") == '0' ) {
						alert("환불 사유코드를 선택하지 않았습니다. 적절한 사유코드를 선택해주세요.");
						lc_charge.focus();
						return;
					};
					
					
					if(ds1.namevalue(i,"charge_cd")=='13') { <%//당일상품인데 사유가 당일이 아닌 경우%>
						if(ds1.namevalue(i,"goods_sid")==35||ds1.namevalue(i,"goods_sid")==30||ds1.namevalue(i,"goods_sid")==54){
							alert("당일상품은 사유='당일상품'만 가능합니다.");
							lc_charge.focus();
							return;
						};
					};
					if (ds1.namevalue(i,"job_type")==2&& ds1.namevalue(i,"pay_amt")*1 > 0) { <%//유형=취소&&입금액이 있으면%>
						alert("입금액이 있는경우 [취소+환불],[환불] 요청만 가능합니다.");
						return;
					};
					if (ds1.namevalue(i,"charge_cd")=='41'&&ds1.namevalue(i,"job_type")!=3) { <%//과입환불 && 유형!=환불면%>
						alert("과입환불 사유인 경우 [환불] 요청만 가능합니다.");
						return;
					};

					if(ds1.namevalue(i,"job_type")!=2){ <%//유형!=취소&&환불요청금액이 없는경우%>
						if(ds1.namevalue(i,"rq_amt")==''&&ds1.namevalue(i,"rq_amt")==0){
							alert("환불요청금액을 입력해주시기 바랍니다.");
							rq_amt.focus();
							return;
						}
					}

					if (ds1.namevalue(i,"rq_amt")*1 > 0&&ds1.namevalue(i,"bank_acc_no")=='' ) { <%//환불요청금액이 있으면%>
						alert("환불 계좌정보를 입력해주시기 바랍니다.");
						bank_acc_no.focus();
						return;
					};

				}
			}

	        v_job = "I";	
			window.status="저장 중입니다. 잠시만 기다려 주십시오...";
//			alert("gogo");

			ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
	             "JSP(I:DEFAULT=ds1,I:IMAGE=imgDs,O:reqNoDS=reqNoDS,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");

	         tr_post(tr1);
	         
			selectImgDs.clearData();
		    selectImgDs.addrow();
		    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(ds1.rowposition,"picture_info");
			selectImgDs.ResetStatus();
		}        
	}


	//취소
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	/*
	 * 대리점팝업
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];					
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	} 	

	// 신청서 번호 팝업
	function fnPopup2() {    
		if ( sClientSid.value == '' ) {
			alert("대리점를 선택해 주세요");
			return;
		}             
		if ( depart_date.text.trim() == '' ) {
			alert("출발일자를 입력해 주세요.");
			return;
		}             		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv011h.jsp?sClientSid="+sClientSid.value+"&sDepartDate="+depart_date.text;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
	    	accept_sid.value = arrParam[0];
			accept_no.value = arrParam[1];
		} else {
	    	accept_sid.value = 0;
			accept_no.value = '';
		}
	} 	

	//취소|환불 요청고객정보 팝업
	function fnPopup3() { 
		if ( sClientSid.value.trim() == '' || sClientSid.value.trim() == '0' ) {
			alert("대리점를 선택해 주세요");
			return;
		}
		if ( accept_sid.value.trim() =='' || accept_sid.value.trim() == '0' ) {
			alert("신청서 번호를 입력해 주세요.");
			return;
		}
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;

		strURL = "<%=dirPath%>/Sales/help/rv012h.jsp?sClientSid="+sClientSid.value+"&sAcceptSid="+accept_sid.value+"&sAcceptDate="+accept_date.text+"&sAcceptTime="+accept_time.text;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			rsv_sid.value = arrParam[8];							
	    	cust_sid.value = arrParam[0];				
	    	cust_nm.value = arrParam[1];
	    	manage_no.value = arrParam[2];
	    	company_nm.value = arrParam[3];		    			    	
			positions.value = arrParam[4];
			cust_mobile_no.value = arrParam[5];			
			tour_amt.text = arrParam[9];		//판매가	
			pay_amt.text = arrParam[10];		//입금액
			depart_date.text = arrParam[15];								
			depart_time.text = arrParam[16];														
			charge_rate.value = arrParam[17];
			goods_nm.value = arrParam[18];//상품명
			goods_sid.value = arrParam[19];//상품sid
			confirm_yn.value = arrParam[20];//운영마감
			status_nm.value = arrParam[21];//예약상태명
			status_cd.value = arrParam[22];//예약상태코드
		} else {
			rsv_sid.value = 0;									
	    	cust_sid.value = 0;			
	    	cust_nm.value = '';
	    	manage_no.value = '';
	    	company_nm.value = '';		    			    	
			positions.value = '';
			cust_mobile_no.value = '';
			tour_amt.text = 0;		//판매가				
			pay_amt.text = 0;	
//			depart_date.text = '';								
			depart_time.text = '';								
			charge_rate.value = 0;																				
			goods_nm.value = '';//상품명
			confirm_yn.value = '';//운영마감
			status_nm.value = '';//예약상태명

		}
	} 	
	
	// 대리점 자동셋팅(조건)
	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 
	
	//대리점 자동셋팅(조건)

	function fnSetting(dataSet) {
		var exit=false;	
		if ( dataSet == 'ds6' ) {	//대리점
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;					
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}			
		}
	} 	
	
	
	//작업상태 셋팅
	// 요청취소(RC)인 것만 요청(RR)로 수정할 수 있습니다.!
	function fnStatusSet(status) {
		if ( ds1.namevalue(ds1.rowposition,"status_cd") == 'RC' ) {
			lc_status2.index = lc_status2.IndexOfColumn("detail", status);		
		} else {
			alert("[요청취소]상태인 것들만 [요　청]으로 수정할 수 있습니다.");
		};

	}

</script>	    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
		    if(Row<1) return;
		    imgDs.RowPosition = Row;	
		</script>
		

		
		<script language=JavaScript for= lc_status2 event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");		
		</script>	
		
		<script language=JavaScript for= lc_charge event=OnSelChange()>
			// 공제율 콤보 변경할 경우 	2007-01-25
			if (ds_charge.namevalue(ds_charge.rowposition,"detail" ) == '41' ) {	//과입환불일 경우
				rq_amt.readOnly = 'false';
				charge_rate.value = '0';
//				amt.text = ''; // 환불요청금액 입력란				
				
				sJobType.Index = 2;
			} else if (ds_charge.namevalue(ds_charge.rowposition,"detail" ) == '32' ) {	//예약변경인 경우
				rq_amt.readOnly = 'true';				
				charge_rate.value = '0';
				rq_amt.text = ''; // 환불요청금액 입력란				
				sJobType.Index = 1;
			} else if (ds_charge.namevalue(ds_charge.rowposition,"detail" ) == '13' ) {	//당일상품인 경우 2008-07-03 심동
				amt.readOnly = 'true';
				charge_rate.value = '0';
				rq_amt.text = 1*pay_amt.text-30000 ; // 환불요청금액 입력란 (3마넌만 환입..)
				sJobType.Index = 0;	// 취소+환불로
			} else {	//나머지 취소 혹은 환불일 경우
				rq_amt.readOnly = 'true';		
				charge_rate.value = ds_charge.namevalue(ds_charge.rowposition, "item2");
				rq_amt.text = Math.round(pay_amt.text * (100-ds_charge.namevalue(ds_charge.rowposition, "item2")) / 100);
				
				if (1*pay_amt.text > 0) {
					sJobType.Index = 0;				
				} else {
					sJobType.Index = 1;	
				};
				
			};
								
			ds1.namevalue(ds1.rowposition, "charge_cd") = ds_charge.namevalue(ds_charge.rowposition, "detail");		
		</script>	
		
		<script language=JavaScript for= lc_bancod event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "bancod") = ds_bancod.namevalue(ds_bancod.rowposition, "detail");		
		</script>	
		
		<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
		    	txt_file.value = gcip_file.value;
		    	photo.src = gcip_file.value;
		    }
		</script>		
		
		<script language=JavaScript for=sBgnDate event=OnKillFocus()> 
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
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
        var msg='';
        //alert("1");
        //alert(v_job);
        //alert(reqNoDS.namevalue(count++,"req_no"));
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
          	            
			//req_no셋팅          	            
            var count=1;
            for ( i=1;i<=ds1.CountRow;i++ ) {
            	if ( ds1.namevalue(i,"req_no") == '' )
		            ds1.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds1.ResetStatus();
            
            //메시지 처리
			if ( msgDS.CountRow > 0 ) {
		        for ( j=1; j<=msgDS.CountRow; j++ )
		          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
				if(msg!='')
					alert(msg);
		    }
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
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
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = tr1.SrvErrMsg("ERROR", i) + "\n";
		
		if(alertMsg!='')
			alert(alertMsg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            var count=1;
            for ( i=1;i<=ds1.CountRow;i++ ) {
            	if ( ds1.namevalue(i,"req_no") == '' )
		            ds1.namevalue(i,"req_no") = reqNoDS.namevalue(count++,"req_no");
            }
            ds1.ResetStatus();
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
		lc_status2.index=index;
		index=lc_charge.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"charge_cd"));
		lc_chargeindex=index;			
		index=lc_bancod.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bancod"));
		lc_bancodindex=index;
	</script>	
	<script language=JavaScript for=codeDs1 event="OnLoadCompleted(row)">
		codeDs1.DeleteRow(1);
		sJobType.Index = 0;
	</script>
	
	<script language=JavaScript  for=ds_bancod event="OnLoadCompleted(row)">
     	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";		
	</script>	
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
	        photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
	    else 
	        photo.src = "<%=dirPath%>/Sales/images/00000.gif";
	        
		selectImgDs.clearData();
	    selectImgDs.addrow();
	    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(Row,"picture_info");
		selectImgDs.ResetStatus();		
		
	</script>	
	
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_charge classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_bancod classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=selectImgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

<table border="0" width="845px"  cellpadding="0" cellspacing="0">

	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >																																								
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
											
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=left width=70 class="text">&nbsp;대리점</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sClientSid" type="hidden" value="<%=c_sid%>">                                
									<input id="sClientCd" type="text" class="textbox" value="<%=c_cd%>" style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" readonly='readonly' maxlength="5" onBlur="fnSetting('ds_client')" >
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="대리점를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="textbox_d" value="<%=c_nm%>" style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>		
            					<td align=left width=70 class="text">&nbsp;작업상태</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>																				
            					<td align=left width=70 class="text">&nbsp;신청일자</td>
                                <td align=left bgcolor="#ffffff" width=300>&nbsp;																										
								     <%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>																				
            				</tr>
            			</table>
					</td>
				</tr>															
			</table>	
		</td>											
	</tr>
	<tr>
		<td height="10"></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="290px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=290px; height:370" border="1" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
                            <param name="ViewSummary" value="1">
							<param name="Format" 			value="
				                <C> name='작업상태'    ID='status_cd' width=60  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true sumtext=계</C>
				                <C> name='신청일'  ID='accept_date'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX sumtext=@count</C>
				                <C> name='신청번호'    ID='accept_no'  width=100 align=center editlimit=15 edit=none show=true sumtext=건</C>
				                <C> name='이름'      ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='관리번호'       ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>															                
				                <C> name='대리점SID'   ID='client_sid' width=60  align=left editlimit=12 show=false</C>
				                <C> name='신청시간'  ID='accept_time'         align=left show=false </C>															                
				                <C> name='담당자'        ID='client_dam_nm'       align=left editlimit=20 show=false</C>
				                <C> name='연락처'    ID='mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='출발일'  ID='depart_date'         align=left editlimit=8 show=false</C>
				                <C> name='출발시간'  ID='depart_time'         align=left editlimit=8 show=false</C>															                
				                <C> name='신청SID'   ID='accept_sid'  align=left editlimit=12 show=false</C>
				                <C> name='예약SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
				                <C> name='고객SID'     ID='cust_sid'    align=left editlimit=12 show=false</C>
				                <C> name='주민/여권번호'    ID='manage_no'   align=left editlimit=20 show=false</C>
				                <C> name='직장명'   ID='company_nm'  align=left editlimit=30 show=false</C>
				                <C> name='직위'    ID='positions'   align=left editlimit=30 show=false</C>
				                <C> name='연락처'    ID='cust_mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='판매가'      ID='tour_amt'     align=left editlimit=33 show=false</C>															                
				                <C> name='입금액'      ID='pay_amt'     align=left editlimit=33 show=false</C>
				                <C> name='환불요청금액'  ID='rq_amt'         align=left editlimit=12 show=False</C>
				                <C> name='환불액'  ID='rq_amt'         align=left editlimit=12 show=False</C>
				                <C> name='공제코드'    ID='charge_cd'   align=left editlimit=1 show=False</C>
				                <C> name='표준공제율'    ID='charge_rate'   align=left show=false</C>														                
				                <C> name='송금은행'       ID='bancod'      align=left editlimit=2 show=False</C>
				                <C> name='송금은행명'        ID='bannm'       align=left editlimit=50 show=false</C>
				                <C> name='송금계좌'  ID='bank_acc_no'         align=left editlimit=20 show=false</C>
				                <C> name='예금주' ID='bank_acct_nm'        align=left editlimit=32 show=false</C>
				                <C> name='사유'       ID='reason'      align=left editlimit=200 show=false</C>
				                <C> name='처리결과' ID='desc'        align=left editlimit=200 show=false</C>	
				               	<C> name='취소' ID='job_type'        align=left editlimit=200 show=false</C>						                
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>		
					<td width="25px">
					</td>					
					<td align="left" valign="top" width="530px">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="530px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">작업상태</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left"  colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_status2>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable2  value=false>																											
															</object>
															<%=HDConstant.COMMENT_END%>
															<img src="<%=dirPath%>/Sales/images/refund_rq.gif"   	style="cursor:hand;position:relative;top:1px" onclick="fnStatusSet('RR')">
														</td>


													<tr>
														<td align=center width=100 class="text">작업유형</td>
						                                <td colspan=3 align=left bgcolor="#ffffff">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=sJobType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=codeDs1>
																<param name=BindColumn      value="detail">
		                                                        <param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80"></object>
																<param name=ReadOnly  	value="true">
															<%=HDConstant.COMMENT_END%>
														</td>															
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																											
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																						
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																										
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">관리번호</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="req_no" type="text" class="textbox_d"   value="" size="20" readonly>
														</td>																																																			
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">담당자</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="textbox"   value="담당자" size="20">
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">연락처</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="textbox"   value="010-3399-0101" size="20">
														</td>	
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">출발일</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="false">
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">																																																				
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">상품</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=goods_nm name=goods_nm type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
															<input id=goods_sid name=status_sid type="hidden"  value="">
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">신청서번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;                                
															<input id="accept_no" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="신청서번호를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2();">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">재방문횟수</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="north_cnt" name=north_cnt type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">운영마감</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=confirm_yn name=confirm_yn type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
														</td>																									
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">예약상태</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=status_nm name=status_nm type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
															<input id=status_cd name=status_cd type="hidden"  value="">
														</td>																									
													</tr>																												
																				
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">성명</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">																									
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
															<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="고객정보를 검색합니다" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup3();">
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">주민/여권번호</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="textbox_d"  size="20" value="" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">직장</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="company_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px;color:black; text-align:left;" readonly>																						
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">직위</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="positions" type="text" class="textbox_d"  readonly>																						
														</td>																									
													</tr>																																																																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">판매가</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=tour_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>																																												
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">연락처</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="cust_mobile_no" type="text" class="textbox_d"  size="20" value="" style="text-align: left" readonly>
														</td>
													</tr>		
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">입금액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=pay_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>		
														<td width="90px" bgcolor="#ffffff" colspan="2" rowspan="7">
															<table border="0" cellpadding="0" cellspacing="0" width="200px" height="120px" bgcolor="#666666" style="border:0px solid #6f7f8d">
																<tr bgcolor="#ffffff">
																	<td width="150px" bgcolor="#ffffff">
																		<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="120px">
																	</td>
																	<td width="150px" align="left" bgcolor="#ffffff" align="absmiddle">
                                                                        <input type=hidden name=txt_file>
																		<%=HDConstant.COMMENT_START%>
						  												<OBJECT id=gcip_file classid=<%=HDConstant.CT_INPUT_FILE_CLSID%> style="width:80; height:20;">
						      												<param name="Text" value="찾아보기" align="center">
				          												</OBJECT>
																		<%=HDConstant.COMMENT_END%>
																		<br><br>
																		<img src="<%=dirPath%>/Sales/images/print.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="pr1.preview();" >																													
																	</td>																												
																</tr>
															</table>
														</td>																																																																				
													</tr>																																																																																																																																																			
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">사유 | 공제율</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_charge classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=190 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_charge>
																<param name=BindColumn      value="detail">
																<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
																<param name=ListExprFormat  value="detail_nm^0^80;item4^0^50">
															</object>
															<%=HDConstant.COMMENT_END%>			
															<input id="charge_rate" type="text" class="textbox_d"  size="7" value="" style="text-align: right" readonly>																																																		
														</td>
													</tr>																																																																																																																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">환불요청금액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=rq_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																										
														</td>	
													</tr>																																																																																																																																																				
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">환불액</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																										
														</td>	
													</tr>																																																																																																																																																				

													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">송금은행</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_bancod classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_bancod>
																<param name=BindColumn      value="detail">
																<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^110"></object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">송금계좌</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="bank_acc_no" type="text" class="textbox"  size="20" value="" style="text-align:left;">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">예금주</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="bank_acct_nm" type="text" class="textbox"  size="20" value=""  style="text-align:left;">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">환불사유</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="textbox"  size="50" value=""  style="text-align:left;">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">비고</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc" type="text" class="textbox_d"  size="50" value="" style="text-align: left" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">처리결과</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc2" type="text" class="textbox_d"  size="50" value="" style="text-align: left" readonly>
														</td>
													</tr>																																																																																																																							
												</table>																						
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>	
					</td>
				</tr>
			</table>
		</td>
	</tr>											
</table>
	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
     <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="imgDs">
             <param name=BindInfo    value="
                <C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>
<%=HDConstant.COMMENT_END%>       
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
        <C>Col=req_no           Ctrl=req_no             Param=value </C>
        <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
        <C>Col=accept_date      Ctrl=accept_date        Param=text </C>
        <C>Col=accept_time      Ctrl=accept_time        Param=text </C>        
        <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
        <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
        <C>Col=depart_date      Ctrl=depart_date        Param=text </C>
        <C>Col=depart_time      Ctrl=depart_time        Param=text </C>

        <C>Col=goods_nm			Ctrl=goods_nm			Param=value </C>
        <C>Col=confirm_yn		Ctrl=confirm_yn			Param=value </C>
        <C>Col=status_nm		Ctrl=status_nm			Param=value </C>
        
        <C>Col=accept_sid       Ctrl=accept_sid         Param=value </C>
        <C>Col=accept_no        Ctrl=accept_no          Param=value </C>
        <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
        <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
        <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
        <C>Col=manage_no        Ctrl=manage_no          Param=value </C>
        <C>Col=company_nm       Ctrl=company_nm         Param=value </C>
        <C>Col=positions        Ctrl=positions          Param=value </C>
        <C>Col=cust_mobile_no   Ctrl=cust_mobile_no     Param=value </C>
        <C>Col=tour_amt         Ctrl=tour_amt           Param=text </C>        
        <C>Col=pay_amt          Ctrl=pay_amt            Param=text </C>
        <C>Col=rq_amt           Ctrl=rq_amt             Param=text </C>
        <C>Col=amt           	Ctrl=amt                Param=text </C>
        <C>Col=charge_cd        Ctrl=lc_charge   	 	Param=BindColVal</C>
        <C>Col=bancod           Ctrl=lc_bancod          Param=BindColVal </C>
        <C>Col=charge_rate      Ctrl=charge_rate        Param=value </C>        
        <C>Col=bannm            Ctrl=bannm              Param=value </C>
        <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
        <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
        <C>Col=reason           Ctrl=reason             Param=value </C>
        <C>Col=desc             Ctrl=desc               Param=value </C>        
        <C>Col=desc2            Ctrl=desc2              Param=value </C>
		<C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>  
		<C>Col=job_type         Ctrl=sJobType           Param=BindColVal </C>  
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    

<input type="hidden" name="row" value="">
<!-----------------------------------------------------------------------------
					출력물 정의부분
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
		<param NAME="DetailDataID"			VALUE="selectImgDs">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
			<I>id='picture_info' ,left=80 ,top=120 ,right=1900 ,bottom=2700</I>
		</B>
	">
	</object> 

<%=HDConstant.COMMENT_END%>      
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

