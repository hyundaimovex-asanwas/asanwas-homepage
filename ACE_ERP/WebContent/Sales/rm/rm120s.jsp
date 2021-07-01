<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 평면도
 * 프로그램ID 	: Rm120S
 * J  S  P		: rm120s
 * 서 블 릿		: rm120s
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-07-27
 * 기능정의	:
 * 수정내용	: 
 * [수  정   일  자][수정자] 내용
 *						2006-09-06 레이어팝 스크립트 추가
 *						2006-09-06 상태1 레이어 完
 *							나머지 상태 레이어 수정
 *							객실 타입 추가
 *							이미지 수정 (상하객실구분)
 * [2007-09-12][심동현] 새 메뉴트리 적용
 * [2008-02-16][심동현] 전체 호텔에 대해 객실현황 팝 추가.
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
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());	
//   	firstday="20060805";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
         var v_job = "H";		
		 var div='';
		/*
		 * 페이지로딩
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

	        v_job = "H";		

			cfStyleGrid(getObjectFirst("gr3"), "comn");		//요약그리드

			sSDate.Text = '<%=firstday%>';	
			div = 'init';
		} 
		 
		function fnInit() {
		}
		
		/*
		 * 메인 조회 (평면)
		 */
		function fnSelect() {
			if(getObjectFirst("sUpjang").value=="0"){
				alert("영업장은 반드시 선택하셔야 합니다.");
				return false;
			}
			if(!sSDate.Text){
				alert("숙박일자를 입력해주세요.");
				sSDate.focus();
				return false;
			};
	
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sSDate.Text;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);

			fnSelect3();
		}


		/*
		 * 상태 요약 조회 (평면)
		 */
		function fnSelect3() {
			v_job = "S";	//select 일듯..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sUpjang="+ getObjectFirst("sUpjang").value
			          + ",sSDate=" + sSDate.Text
			          + ",sTDate=" + sSDate.Text;			          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv740I",
			    "JSP(O:DS3=ds3)",
			    param);
			   
			tr_post(tr1);
		}
			
   		// 영업장 변경시 영업장 활성/비활성 	
		function fnChange() {
			if (sUpjang.value == '1') {
				getObjectFirst("TR_1").style.display='inline';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';				
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			} if (sUpjang.value == '2') {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='inline';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '3' ) {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='inline';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '5') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='inline';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '6') {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='inline';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '7') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='inline';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '8' ) {
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='inline';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '9') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='inline';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '10') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='inline';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';				
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '11') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='inline';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '13') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='inline';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '24') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='inline';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '12') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='inline';
				getObjectFirst("TR_71").style.display='none';
			}  if (sUpjang.value == '71') {	
				getObjectFirst("TR_1").style.display='none';
				getObjectFirst("TR_2").style.display='none';
				getObjectFirst("TR_3").style.display='none';
				getObjectFirst("TR_5").style.display='none';
				getObjectFirst("TR_6").style.display='none';
				getObjectFirst("TR_7").style.display='none';
				getObjectFirst("TR_8").style.display='none';
				getObjectFirst("TR_9").style.display='none';
				getObjectFirst("TR_10").style.display='none';
				getObjectFirst("TR_11").style.display='none';
				getObjectFirst("TR_13").style.display='none';
				getObjectFirst("TR_24").style.display='none';
				getObjectFirst("TR_12").style.display='none';
				getObjectFirst("TR_71").style.display='inline';
			} 			

		}
	
		
		

	// 객실 상태 팝업 스크립트 ---------------------------------------------------------------------------------------		
		function fnStatusPop(roomsid, status,sBgnDate,sEndDate) {
		/*	상태는 배정된 것과 고장객실 2개뿐.
			ROOM_STATUS_TXT") == '1') {	 //빈방
			ROOM_STATUS_TXT") == '2') {	 //이미자동
			ROOM_STATUS_TXT") == '3') {	 //자동예정 (우선배정)
			ROOM_STATUS_TXT") == '4') {	 //이미배정
			ROOM_STATUS_TXT") == '5') {	 //배정객실
			ROOM_STATUS_TXT") == '6') {	 //고장객실      */

	        var arrParam    = new Array();
	        var arrResult   = new Array();
	       
	        var param = "?sRoomSid=" + roomsid
			          + "&sRoomStatus=" + status
        			  + "&sBgnDate=" + sBgnDate
					  + "&sEndDate="+ sEndDate;
			if (status == "4") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "5") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "6") {
				var strURL = '<%=dirPath%>/Sales/help/rm120h.jsp' + param;
			} else if (status == "undefined" || status == null) {
				alert("정보가 일치하지 않습니다!");
				return;
			}          

			var win = document.all.roomInfoWin;
			win.src = "";
			win.style.display = "none";
			win.src = strURL;
			win.style.display = "";			
		};		
		
		//우클릭
		function fnRClick(obj) {
			 if (ds1.countrow > 0 ) {	
			 	var status;
			 	var roomSid;
			    if (event.button==2 || event.button==3) {
			    	for (i = 1; i <= ds1.countrow; i++) {
			    		if(obj.id == ds1.namevalue(i, "ROOM_NO2")) {
			    			status = ds1.namevalue(i, "ROOM_STATUS_TXT"); //1:빈방,4:배정방,5:이미배정방, 6:고장방
			    			roomSid = ds1.namevalue(i, "ROOM_SID");
			    		};
			    	};
			    	
			    	if (status == "1" ) {
			    		alert ("빈 객실입니다!");
			    		return false;
			    	} else if(status == "2" || status == "3"){	
			    		alert ("자동배정 예정객실입니다!");
			    		return false;
			    	} else {
			    		fnStatusPop(roomSid, status, sSDate.Text, sSDate.Text);
			    	};
		    	};
		    } else {
		    	alert("정보가 없습니다!");
		    };
   		};



		// 좌클릭=우클릭과 동일
		function statChange(obj) {
			 if (ds1.countrow > 0 ) {	
			 	var status;
			 	var roomSid;
			    	for (i = 1; i <= ds1.countrow; i++) {
			    		if(obj.id == ds1.namevalue(i, "ROOM_NO2")) {
			    			status = ds1.namevalue(i, "ROOM_STATUS_TXT"); //1:빈방,4:배정방,5:이미배정방, 6:고장방
			    			roomSid = ds1.namevalue(i, "ROOM_SID");
			    		};
			    	};
			    	
			    	if (status == "1" ) {
			    		alert ("빈 객실입니다!");
			    		return false;
			    	} else if(status == "2" || status == "3"){	
			    		alert ("자동배정 예정객실입니다!");
			    		return false;
			    	} else {
			    		fnStatusPop(roomSid, status, sSDate.Text, sSDate.Text);
			    	};
		    } else {
		    	alert("정보가 없습니다!");
		    };
		}


	// 요약표 숨기기 토글 스크립트 ---------------------------------------------------------------------------------------
		function togLayer(){
			if(getObjectFirst("summaryTb").style.display=='none'){
				getObjectFirst("summaryTb").style.display='';
			} else {
				getObjectFirst("summaryTb").style.display='none';
			};
		}
	
		</script>
<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
	<script language="javascript" for="tr1" event="onsuccess()">
//		이후 필요한 메세지 띄우기는 rm310i.jsp 포캐스팅 변경을 참고할 것..
		var msg='';
        if(v_job=="I1") {	//객실 상태 저장
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//            for ( i=1; i<=msgDS.CountRow; i++ )
//            	msg+=msgDS.namevalue(i,"pMsg")+"\n";
//            if ( msgDS.CountRow > 0 ) 
//	          	alert(msg);     
	        fnSelect();   //메인 조회 (평면)
        }  else if(v_job == "I2") {	// 배정 저장
	        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
	        fnSelect();   //메인 조회 (평면)
	        fnSelect2();   //명단 조회
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        };
	</script>
	<script language=JavaScript for="tr1" event=OnFail()>
		alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
/*        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		div='';  
		
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        var msg='';
        //메시지 처리
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		*/
	</script>
	

	<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
	    if(row==0) return;
	    var v_yn = "";
	    var v_msg = "";
	    for(var i=1; i<=row; i++){
	        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
	            v_msg += ds_result.NameValue(i, "MSG")+"\n";
	        }
	    }
	    if(v_msg!=""){
	        alert(v_msg);
	    }
	</script>


	<script language=JavaScript for=ds1 event=OnLoadCompleted(rowcnt)>
		var upjang = sUpjang.value;
		
		for (i = 1 ; i <= ds1.countrow; i++) {
			if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '4') {	 //이미배정
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_f.jpg';		//주황
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '5') {	 //예약 및 객실배정완료
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_m.jpg';	//하늘
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '3') {	 //우선배정
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_r.jpg';	 //보라
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '6') {	 //고장배정
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_p.jpg';	//다홍
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '1') {	 //빈방
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_e.jpg';	//회색
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");
				}
			} else if (ds1.namevalue(i, "ROOM_STATUS_TXT") == '2') {	 //다른 날 자동예정
				if (getObjectFirst(ds1.namevalue(i, "ROOM_NO2"))) {
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).background='<%=dirPath%>/Sales/images/map/1_b.jpg';	//군청
					getObjectFirst(ds1.namevalue(i, "ROOM_NO2")).innerHTML="<B>"+ds1.namevalue(i, "ROOM_NO")+"</B><BR>"+ ds1.namevalue(i, "ROOM_TYPE_CD");					
				}
			}
		}
	</script>
	
	<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
	</script>

<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 평면 객실상태  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 배정대상인원메인  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 객실상태 요약표  -->
	<param name="SyncLoad" 	value="true">
</object>


<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 지역 -->
    <param name="SyncLoad"  value=false>
</object>

<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 상품정보 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 반 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 조 -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- 메세지 -->
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	
<!-- 객실상태창 레이어 -->
<iframe id=roomInfoWin frameborder=0 marginwidth=0 marginheight=0 scrolling=no style="POSITION: absolute;DISPLAY:none;width:520;height:260;left: expression((document.body.clientWidth - 520)/2);top: expression((document.body.clientHeight - 260)/2);Z-INDEX: 9;"></iframe>

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845' >
					<tr>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
								<tr>
									<td> </td>
									<td align='right'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- 조회 -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr height="5px">
			<td></td>
		</tr>
		
		<tr height="30px">
			<td width='845px' colspan=2>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="60px">호　텔</td>
	                    <td align=left width=530 bgcolor="#ffffff">&nbsp;																										
							<select name="sUpjang" onchange="javascript:fnChange()">
								<option value="0">호텔을 선택하세요!</option>
								<option value="1">금강산호텔 본관(GH)</option>
								<option value="2">금강산호텔 별관(GB)</option>
								<option value="3">패밀리비치호텔(FH)</option>
								<option value="5">외금강호텔(MH)</option>
								<option value="6">해금강호텔(HH)</option>
								<option value="7">금강펜션타운(PT)</option>
								<option value="8">온천빌리지(OV)</option>
								<option value="9">구룡마을(NV)</option>
								<option value="10">포레스트돔(FD)</option>
								<option value="11">캠핑카(CC)</option>
								<option value="24">해변텐트(ST)</option>
								<option value="12">자가텐트(YT)</option>
								<option value="71">아산생활관(AL)</option>
								<option value="13">금강빌리지(KV)</option>

							</select>
						</td>	
						
						<td align=left class="text"  width=60>숙박기간</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>

					</tr>
				</table>
			</td>
		</tr>
		
		
		<tr height='10px'>
			<td></td>
		</tr>
		
		<tr>
			<td align="right">
				<table>
					<tr align=center>
						<td width=60><a href="javascript:togLayer();">[요약표]</a></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_e.jpg"><FONT COLOR=white>빈 객실</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_r.jpg"><FONT COLOR=white>자동예정</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_m.jpg"><FONT COLOR=white>배정객실</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_b.jpg"><FONT COLOR=white>이미자동</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_f.jpg"><FONT COLOR=white>이미배정</font></td>
						<td width=80 background="<%=dirPath%>/Sales/images/map/1_p.jpg"><FONT COLOR=white>고장객실</FONT></td>
					</tr>
				</table>
			</td>
		</tr>

		<tr id=summaryTb style="display:none"><!-- 객실상태 요약표.-->
			<td align="right">
				<%=HDConstant.COMMENT_START%>
				<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width=556 height=160 border=1 style="display:;">
					<param name="DataID"        value="ds3">
					<param name="ColSizing"		value="true">
					<param name="Fillarea"		value="false">
					<param name="Editable"		value="true">
					<param name="BorderStyle"	value="0">
					<param name=SortView  		value="Left">
					<param name=IndWidth 		value="20">
					<param name=ViewHeader      value="false">
				    <param name=ViewSummary     value=1>					
					<param name="Format" 			value="
					    <C> name='TYPE'       ID='TYPE'   Width=52    align=center SumText='계'</C>
					    <C> name='stat1'      ID='S1'  width=84     align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat2'   	  ID='S3'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat3'      ID='S5'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat4'      ID='S2'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat5'      ID='S4'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
						<C> name='stat6'      ID='S6'  width=84 	align=center show=true SumText=@sum SumTextAlign=center</C>
					">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
		
		<tr>
			<td align=center>
				<!-- 평면시작 div -->
				<div id=pageSelect style='width:845;height:400;overflow-y:auto;background:white;border:1 solid 	#9D9C9C;display:;position:relative;top:3px'>
				<table  border='0' cellpadding='0' cellspacing='1'>
					<tr id=TR_1 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang01n.jsp"/>
						</td>
					</tr>

					<tr id=TR_2 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang02n.jsp"/>
						</td>
					</tr>

					<tr id=TR_3 style="display:none">
						<td>
								<jsp:include page="/Sales/rm/upjang03n.jsp"/>
						</td>
					</tr>
					
					<tr id=TR_5 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang05n.jsp"/>
						</td>
					</tr>

					<tr id=TR_6 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang06n.jsp"/>
						</td> 
					</tr>

					<tr id=TR_7 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang07n.jsp"/>
						</td>
					</tr>

					<tr id=TR_8 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang08n.jsp"/>
						</td>
					</tr>

					<tr id=TR_9 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang09n.jsp"/>
						</td>
					</tr>

					<tr id=TR_10 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang10n.jsp"/>
						</td>
					</tr>
					<tr id=TR_11 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang11n.jsp"/>
						</td>
					</tr>
					<tr id=TR_13 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang13n.jsp"/>
						</td>
					</tr>
					<tr id=TR_24 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang24n.jsp"/>
						</td>
					</tr>
					<tr id=TR_12 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang12n.jsp"/>
						</td>
					</tr>
					<tr id=TR_71 style="display:none">
						<td >
								<jsp:include page="/Sales/rm/upjang71n.jsp"/>
						</td>
					</tr>
				</table>
				</div>
			</td>
		</tr>

		<tr>
			<td><BR>
				<table border=0 width=845 cellspacing=0 cellpadding=0>
					<tr>
						<td>				
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=300 height=200 border=1 style="display:none;">
								<param name="DataID"        value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								   <C> name='No.'      	ID='{STRING(CURROW)}'   Width=30    align=center</C>
								   <C> name='room1'    	ID='ROOM_NO'  width=40 	align=left editlimit=16 show=true</C>
									<C> name='room2'   	ID='ROOM_NO2' width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='TYPE'    	ID='ROOM_TYPE_CD'  		 	width=50 	align=left editlimit=15 edit=none show=true  </C>
									<C> name='RoomSid'  ID='ROOM_SID'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='txt'      ID='ROOM_STATUS_TXT'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='st'       ID='ROOM_STATUS'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>
									<C> name='RsvSid'   ID='RSV_SID'  		 	width=30 	align=center editlimit=15 edit=none show=true </C>																		
								">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
					</tr>
				<table>

			</td>
		</tr>
	</table>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

