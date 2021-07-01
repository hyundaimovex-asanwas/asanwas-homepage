<!--
***********************************************************************
* @source      : buta021.jsp
* @description : 여비계산서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      이동훈        ERP 이사
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
	String status = request.getParameter("STATUS");        		//품의번호
	//String role_cd = box.getString("SESSION_ROLE_CD");         //롤권한
%>

<html>
<head>
<title>여비계산서</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

	<script language="javascript">


        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			*
         ********************************************/
        function fnc_SearchList() {

            //여비계산서 조회
            dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR&ORD_NO="+dsTemp.NameValue(1,"ORD_NO");
            dsT_DI_BUSINESSTRIP_BASIS.reset();

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			*
         ********************************************/
        function fnc_SearchItem() {

            //여비지급기준 조회
            dsT_DI_BUSINESSTRIP_BASIS2.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_01";
            dsT_DI_BUSINESSTRIP_BASIS2.reset();

            //직급에 따른 단가명 조회
            dsT_DI_BUSINESSTRIP_BASIS3.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_02&JOB_CD="+dsTemp.NameValue(1,"JOB_CD")+"&COM_CD1="+dsTemp.NameValue(1,"COM_CD1")+"&COM_CD2="+dsTemp.NameValue(1,"COM_CD2")+"&COM_CD3="+dsTemp.NameValue(1,"COM_CD3")+"&COM_CD4="+dsTemp.NameValue(1,"COM_CD4")+"&COM_CD5="+dsTemp.NameValue(1,"COM_CD5");
            dsT_DI_BUSINESSTRIP_BASIS3.reset();

            //휴일조회
            dsT_DI_HOLIDAY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SHR_03&BUT_FR_YMD="+dsTemp.NameValue(1,"BUT_FR_YMD")+"&BUT_TO_YMD="+dsTemp.NameValue(1,"BUT_TO_YMD");
            dsT_DI_HOLIDAY.reset()


        }

		/********************************************
         * 03. 저장 함수							*
         ********************************************/
        function fnc_Save() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 04. 삭제 함수							*
         ********************************************/
        function fnc_Delete() {

        	//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 05. 인쇄 함수  							*
         ********************************************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 06. 엑셀 저장 함수  						*
         ********************************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 07. 신규 함수 							*
         ********************************************/
        function fnc_AddNew() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 08. 추가 함수 							*
         ********************************************/
        function fnc_Append() {

            if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

            dsT_DI_BUSINESSTRIP_BASIS.AddRow();
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
            dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");

        }

		/********************************************
         * 09. 제거 함수 							*
         ********************************************/
        function fnc_Remove() {

            if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

        	dsT_DI_BUSINESSTRIP_BASIS.DeleteRow(dsT_DI_BUSINESSTRIP_BASIS.RowPosition);

        }

		/********************************************
         * 10. 초기화 함수  						*
         ********************************************/
        function fnc_Clear() {

			//이곳에 해당 코딩을 입력 하세요

        }

		/********************************************
         * 11. 화면 종료(닫기)  					*
         ********************************************/
        function fnc_Exit() {

            if (dsT_DI_BUSINESSTRIP_BASIS.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}

			window.close();

        }

		/********************************************
         * 12. 검색 조건 유효성 검사  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         ********************************************/
        function fnc_OnLoadProcess() {

			dsT_DI_BUSINESSTRIP_STATE.setDataHeader("ORD_NO:STRING(20)");


 			if (gusrid == '6060002' || gusrid == '6180001'|| gusrid == '2180001'){
 				
				//임보이씨랑 이동훈, 문지예 대리는 수정가능토록
			    cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"true","false");      // Grid	 Style 적용
			    
			    document.getElementById("helpMessage").innerText = ' ※ 여비계산서 조정후 처리버튼을 클릭하셔야 반영이 됩니다. 교통비 단가 및 비고만 수정이 가능합니다.';
			    
			    
            }else if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV"){
            	
            	cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"false","false");      // Grid Style 적용
                
				document.getElementById("ImgConduct").style.display = "none";//처리버튼 않보이게
				
                document.getElementById("helpMessage").innerText = '';

            }else{
            	
            	cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,0,"true","false");      // Grid Style 적용
			    
			    document.getElementById("helpMessage").innerText = ' ※ 여비계산서 조정후 처리버튼을 클릭하셔야 반영이 됩니다. 교통비 단가 및 비고만 수정이 가능합니다.';
			    
            }

			fnc_SearchItem();//항목에 코드만 나오는거 방지

            fnc_SearchList();//여비계산서 조회

            fnc_TotAccount();//합계금액 계산



        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /********************************************
         * 16. 데이터셋 설정(fnc_compareDS도 같이 수정해야 함)*
         ********************************************/
		function fnc_SettingDS() {



			// 외부인은 금액에서 제거함
			//dsTemp를 dsT_DI_BUSINESSTRIP_STATE_CP에 복사
			cfCopyDataSet(dsTemp, dsT_DI_BUSINESSTRIP_CP, "copyHeader=yes,rowFrom=1,rowCnt=1");


            var seq1 = 0;
            var seq2 = 0;
            var seq3 = 0;
            var seq4 = 0;
            var seq5 = 0;
            var seq6 = 0;
            var g2_cnt = 0;     //출장 중 식사 회수

            //교통비
            for(i=1;i<=8;i++){

                if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C1" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C2" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C3" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C4" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C5" ||
                   dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C6"){

                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"CITY_DPT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_DPT"+i);
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"CITY_AVR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_ARV"+i);
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;

                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C1"){
                        seq1 = seq1 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C1";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq1;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C2"){
                        seq2 = seq2 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C2";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq2;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C3"){
                        seq3 = seq3 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C3";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq3;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C4"){
                        seq4 = seq4 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C4";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq4;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C5"){
                        seq5 = seq5 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C5";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq5;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                    if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"CITY_GBN"+i) == "C6"){
                        seq6 = seq6 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "C6";
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = seq6;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                }
            }

			//숙식제공교육 구분
            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP.NameValue(1,"START_GBN") == "1"){
				//전일출발 : 오전출발인 경우 숙박 1 / 식비 3 (휴일여부에 따른 식비공제)
                //           오후출발인 경우 숙박 1 / 식비 2

	            //숙박비
                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = "1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;

	            //식비
	            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "A"){        //출발일이 오전
	                g2_cnt = 3;
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "P"){  //출발일이 오후
	                g2_cnt = 2;
	            }
	            

	            
	            
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = g2_cnt;
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

                //일비(숙식제공교육은 무조건 2개)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
                    //동행인
                    if(i > 1){
                        //비고란에 동행인 직위, 성명 Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP.NameValue(1,"START_GBN") == "2"){
				//당일출발 : 숙박비,식비 여비계산 자동생성시 삭제

                //일비(숙식제공교육은 무조건 2개)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") =  dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
                    //동행인
                    if(i > 1){
                        //비고란에 동행인 직위, 성명 Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else{



        if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY") > 0){           	
	            //숙박비
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY"));
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }
        }

        		//prompt(this,dsT_DI_BUSINESSTRIP_CP.text);
        		//alert(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN"));        
	            //식비
	            //g2_cnt = (dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") - 2) * 3;
				//alert(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY"));   
	            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") == 1){    

	            	g2_cnt = 1;
	            	//alert("g2_cnt1===="+g2_cnt);
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") == 2){
	            	
	            	g2_cnt = 5;
	            	//alert("g2_cnt2===="+g2_cnt);
	            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") > 2){
	            	
	            	g2_cnt = 2 + (dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY") - 1) * 3;
	            	//alert("g2_cnt3===="+g2_cnt);
	            }
	            	
	            //alert("g2_cnt===="+g2_cnt);
	            /*
		            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "A"){        //출발일이 오전
		            	
		                //g2_cnt = g2_cnt + 2;
		            	g2_cnt = g2_cnt + 1;
		            	alert(g2_cnt); 
		            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_FR_GBN") == "P"){  //출발일이 오후
		                g2_cnt = g2_cnt + 1;
		            }
		            if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN") == "A"){        //도착일이 오전
		                g2_cnt = g2_cnt + 1;
		            }else if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_TO_GBN") == "P"){  //도착일이 오후
		                g2_cnt = g2_cnt + 3;
		                alert(g2_cnt); 
		            }
				*/

	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = g2_cnt;
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //잡비
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"GBN_CD") = "G3";
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"BUT_DAY");
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

            }//숙식제공교육 구분 끝

            //단가 및 식비공제, 합계금액 Setting
            var sqn_no;
            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){

                sqn_no = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"SQN_NO");//일련번호

                for(j=1;j<=dsT_DI_BUSINESSTRIP_BASIS2.CountRow;j++){
                    if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD") == dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,"GBN_CD")){


                        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD").substring(0,1) == "G"){
                            dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(sqn_no,"EXT_02"));
                        }else{
                            dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(1,"EXT_02"));
                        }
                    }

                }//단가

                dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"BAS_CNT");//합계급액

            }

            //sort해준다.(신규와 저장데이터 비교를 위해 필요)
            dsT_DI_BUSINESSTRIP_BASIS.SortExpr = "+GBN_CD+SQN_NO";
            dsT_DI_BUSINESSTRIP_BASIS.Sort();

		}

        /********************************************
         * 16. 데이터셋 비교(fnc_SettingDS도 같이 수정해야 함)*
         ********************************************/
		function fnc_compareDS() {

			//dsTemp를 dsT_DI_BUSINESSTRIP_STATE_CP에 복사
			cfCopyDataSet(dsTemp, dsT_DI_BUSINESSTRIP_CP_TMP, "copyHeader=yes,rowFrom=1,rowCnt=1");

            var seq1 = 0;
            var seq2 = 0;
            var seq3 = 0;
            var seq4 = 0;
            var seq5 = 0;
            var seq6 = 0;
            var g2_cnt = 0;     //출장 중 식사 회수

			if (dsT_DI_BUSINESSTRIP_BASIS_TMP.CountColumn == 0) {
			    dsT_DI_BUSINESSTRIP_BASIS_TMP.setDataHeader("ORD_NO:STRING:KEYVALUETYPE, GBN_CD:STRING:KEYVALUETYPE, SQN_NO:STRING:KEYVALUETYPE, " +
                                             				"ENO_NO:STRING, NAM_KOR:STRING, DPT_CD:STRING, JOB_CD:STRING, CITY_DPT:STRING,CITY_AVR:STRING, PRICE_AMT:DECIMAL, BAS_CNT:DECIMAL, COST_AMT:DECIMAL, REMARK:STRING, DESC_AMT:DECIMAL");
			}

            //교통비
            for(i=1;i<=8;i++){

                if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C1" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C2" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C3" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C4" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C5" ||
                   dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C6"){

                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"CITY_DPT") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_DPT"+i);
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"CITY_AVR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_ARV"+i);
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;

                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C1"){
                        seq1 = seq1 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C1";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq1;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C2"){
                        seq2 = seq2 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C2";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq2;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C3"){
                        seq3 = seq3 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C3";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq3;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C4"){
                        seq4 = seq4 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C4";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq4;
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C5"){
                        seq5 = seq5 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C5";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq5;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                    if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"CITY_GBN"+i) == "C6"){
                        seq6 = seq6 + 1;
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "C6";
                        dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = seq6;
                        dsT_DI_BUSINESSTRIP_BASIS.NameValue(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,"BAS_CNT") = "1";
                    }
                }
            }

			//숙식제공교육 구분
            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"START_GBN") == "1"){
				//전일출발 : 오전출발인 경우 숙박 1 / 식비 3 (휴일여부에 따른 식비공제)
                //           오후출발인 경우 숙박 1 / 식비 2

	            //숙박비
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //식비
	            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "A"){        //출발일이 오전
	                g2_cnt = 3;
	            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "P"){  //출발일이 오후
	                g2_cnt = 2;
	            }

	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){


	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = g2_cnt;
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

                //일비(숙식제공교육은 무조건 2개)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){


                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = "2";
                    //동행인
                    if(i > 1){
                        //비고란에 동행인 직위, 성명 Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"OFFER_GBN") == "Y" && dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"START_GBN") == "2"){
				//당일출발 : 숙박비,식비 여비계산 자동생성시 삭제
                //일비(숙식제공교육은 무조건 2개)
                for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
                    dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = "2";
                    //동행인
                    if(i > 1){
                        //비고란에 동행인 직위, 성명 Set
                        eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
                    }
                }

            }else{


           if(dsT_DI_BUSINESSTRIP_CP.NameValue(1,"SLEEP_DAY") > 0){ 
	            //숙박비
                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G1";
                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;


                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"SLEEP_DAY"));

            }
                
	            //식비
                g2_cnt = (dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_DAY") - 2) * 3;

		            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "A"){        //출발일이 오전
		                g2_cnt = g2_cnt + 2;
		            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_FR_GBN") == "P"){  //출발일이 오후
		                g2_cnt = g2_cnt + 1;
		            }
		            if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_TO_GBN") == "A"){        //도착일이 오전
		                g2_cnt = g2_cnt + 1;
		            }else if(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_TO_GBN") == "P"){  //도착일이 오후
		                g2_cnt = g2_cnt + 3;
		            }


	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G2";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = g2_cnt;
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

	            //일비
	            for(i=1;i<=Number(dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_CNT"))+1;i++){
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.AddRow();
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ORD_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ORD_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"ENO_NO") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"ENO_NO");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"NAM_KOR") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"NAM_KOR");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"DPT_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"DPT_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"JOB_CD") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"JOB_CD");
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"GBN_CD") = "G3";
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"SQN_NO") = i;
	                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"BAS_CNT") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"BUT_DAY");
	                //동행인
	                if(i > 1){
	                    //비고란에 동행인 직위, 성명 Set
	                    eval('dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(dsT_DI_BUSINESSTRIP_BASIS_TMP.RowPosition,"REMARK") = dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NM'+(i-1)+'") + " " + dsT_DI_BUSINESSTRIP_CP_TMP.NameValue(1,"COM_NAM'+(i-1)+'")');
	                }
	            }

            }//숙식제공교육 구분 끝




            //단가 및 식비공제, 합계금액 Setting
            var sqn_no;
            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS_TMP.CountRow;i++){

                sqn_no = dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"SQN_NO");//일련번호
                for(j=1;j<=dsT_DI_BUSINESSTRIP_BASIS2.CountRow;j++){
                    if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD") == dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,"GBN_CD")){


                        if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD").substring(0,1) == "G"){
                            dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(sqn_no,"EXT_02"));
                        }else{
                            dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") = dsT_DI_BUSINESSTRIP_BASIS2.NameValue(j,dsT_DI_BUSINESSTRIP_BASIS3.NameValue(1,"EXT_02"));
                        }
                    }

                }//단가


                dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"BAS_CNT");//합계급액

            }

            //sort해준다.(신규와 저장데이터 비교를 위해 필요)
            dsT_DI_BUSINESSTRIP_BASIS_TMP.SortExpr = "+GBN_CD+SQN_NO";
            dsT_DI_BUSINESSTRIP_BASIS_TMP.Sort();


			if(dsT_DI_BUSINESSTRIP_BASIS_TMP.countrow != dsT_DI_BUSINESSTRIP_BASIS.countrow){
				return false;
			}else{
				for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS_TMP.CountRow;i++){
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"ORD_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"ORD_NO")){
						return false;
					}

					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"GBN_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"SQN_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"SQN_NO")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"ENO_NO") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"ENO_NO")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"NAM_KOR") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"NAM_KOR")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"DPT_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"DPT_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"JOB_CD") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"JOB_CD")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"CITY_DPT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"CITY_DPT")){
						return false;
					}
					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"CITY_AVR") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"CITY_AVR")){
						return false;
					}


					//교통비와 비고는 수정이 가능하므로 비교불가

					if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"GBN_CD").substring(0,1) != "C"){



						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"PRICE_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"PRICE_AMT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"BAS_CNT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"BAS_CNT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"COST_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT")){
							return false;
						}
						if(dsT_DI_BUSINESSTRIP_BASIS_TMP.NameValue(i,"DESC_AMT") != dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"DESC_AMT")){
							return false;
						}

					}


				}
			}

			return true;

		}

        /********************************************
         * 17. 합계금액 계산						*
         ********************************************/
		function fnc_TotAccount() {

            var tot_sum = 0;//합계 금액

            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){
                tot_sum = tot_sum + dsT_DI_BUSINESSTRIP_BASIS.NameValue(i,"COST_AMT");
            }

            form1.medTOT_AMT.Text = tot_sum;

		}

        /********************************************
         * 18. '처리'버튼 처리  					*
         ********************************************/
		function fnc_Reflect() {

            //if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV") return;

            if (!dsT_DI_BUSINESSTRIP_BASIS.IsUpdated ) {
				//alert("저장할 자료가 없습니다.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return;
			}

            for(i=1;i<=dsT_DI_BUSINESSTRIP_BASIS.CountRow;i++){
				dsT_DI_BUSINESSTRIP_BASIS.UserStatus(i) = 1;
            }

            trT_DI_BUSINESSTRIP_BASIS.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta021.cmd.BUTA021CMD&S_MODE=SAV";
			trT_DI_BUSINESSTRIP_BASIS.post();

            dsTemp.NameValue(1,"BASIS_YN") = "SA";//여비계산서 저장 여부

            alert("처리되었습니다. 상신이 가능합니다.");

			window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

	<!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP_BASIS)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(T_DI_BUSINESSTRIP_BASIS)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS) 		|
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS_TMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------------------+
    | 1. 조회용 DataSet							               |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_BASIS2)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS) 		   |
    +---------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------------------+
    | 1. 조회용 DataSet							               |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_BASIS3)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS) 		   |
    +---------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_BASIS3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!---------------------------------------------+
    | 1. 조회용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_HOLIDAY)|
    | 3. 사용되는 Table List(T_DI_HOLIDAY) 		   |
    +---------------------------------------------->
	<Object ID="dsT_DI_HOLIDAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP)    |
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP)    |
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_CP_TMP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet							    |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_DI_BUSINESSTRIP_STATE)    |
    | 3. 사용되는 Table List(dsT_DI_BUSINESSTRIP_STATE) 		    |
    +------------------------------------------------------->
	<Object ID="dsT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_BASIS)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_BASIS)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
	</Object>

    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

		if (iCount < 1)    {
            //fnc_SearchItem();//조회 함수_Item 형태의 조회
			fnc_SettingDS();//데이터셋 설정
			//alert("신규");

		}


		else {
			//데이터셋 비교
			if(fnc_compareDS()){

				// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
				fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
			}else{

			}

            dsTemp.NameValue(1,"BASIS_YN") = "SA";//여비계산서 저장 여부
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[항목/NO] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[항목/NO]에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS2 Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS2 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS3 Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_BUSINESSTRIP_BASIS3 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAY Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
	<Script For=dsT_DI_HOLIDAY Event="OnLoadError()">
        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
        cfErrorMsg(this);
		window.close();
    </script>
    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
        cfErrorMsg(this);
		window.close();

    </script>


    <!---------------------------------------------------------------------------------------------------------+
    | Grid상에서 Editable상태에서 하나의 Cell에 입력을 완료한 후, 다음 Cell로 포커스를 옮길 때 발생하는 Event  |
    +---------------------------------------------------------------------------------------------------------->
    <script language=JavaScript for=grdT_DI_BUSINESSTRIP_BASIS event=OnExit(row,colid,olddata)>


		if(colid == "PRICE_AMT" || colid == "BAS_CNT"){
		    dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"COST_AMT") = dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT")*dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"BAS_CNT");
		    fnc_TotAccount();
		}


    </script>

	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_BASIS event=OnRowPosChanged(row)>

	    var Column = grdT_DI_BUSINESSTRIP_BASIS.GetColumn();

	    //header이 없어 오류가 날 수 있다.
	    if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == undefined){
	       return false;
	    }



        //교통비단가만 수정이 가능(단, 자가용은 팝업으로 수정하므로 수정불가)
        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == "C5" || (dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) != "C" && dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) != "G")){
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='항목'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='출발지'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='도착지'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='단가'       align=right     Edit=none                   </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='수량'       align=right     Edit=none                   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='금액'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='비고'       align=left                                  </C>";

        }else if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD").substring(0,1) == "G"){
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='항목'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='출발지'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='도착지'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='단가'       align=right                                 </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='수량'       align=right                        		   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='금액'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='비고'       align=left                                  </C>";


        }else{
            grdT_DI_BUSINESSTRIP_BASIS.Format = "<C> id='{CUROW}'    width=39    name='NO'         align=center    value={String(Currow)}      </C>" +
                                                "<C> id='GBN_CD'     width=100   name='항목'       align=left      Edit=none EditStyle=Lookup  Data='dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME' </C>" +
                                                "<C> id='SQN_NO'     width=40    name='SEQ'        align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_DPT'   width=90    name='출발지'     align=center    Edit=none                   </C>" +
                                                "<C> id='CITY_AVR'   width=90    name='도착지'     align=center    Edit=none                   </C>" +
                                                "<C> id='PRICE_AMT'  width=70    name='단가'       align=right                                 </C>" +
                                                "<C> id='BAS_CNT'    width=50    name='수량'       align=right     			                   </C>" +
                                                "<C> id='COST_AMT'   width=70    name='금액'       align=right     Edit=none                   </C>" +
                                                "<C> id='REMARK'     width=160   name='비고'       align=left                                  </C>";
        }




	    for(var i=0; i < grdT_DI_BUSINESSTRIP_BASIS.CountColumn; i++) {
	    	
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i),'HeadColor')   = "#000000";   // Header ForeColor
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i),'HeadBgColor') = "#dae0ee";   // Header BackColor
	        grdT_DI_BUSINESSTRIP_BASIS.ColumnProp(grdT_DI_BUSINESSTRIP_BASIS.GetColumnID(i), 'Sort')       = true;        //Sort 여부
	    }


	    grdT_DI_BUSINESSTRIP_BASIS.SetColumn(Column);

	</script>

    <script language=JavaScript for=grdT_DI_BUSINESSTRIP_BASIS event="OnClick(row,colid)">
        //단가 클릭시에 팝업(비고도 입력가능하기때문에 로우전체로 걸면 않된다.
        if(colid == "PRICE_AMT"){
	        var flag = "";//저장가능여부
	        //처리가능여부
	        if(dsTemp.NameValue(1,"ENO_NO") != gusrid || '<%=status%>' != "SV"){
	            flag = "N";
	        }else{
	            flag = "Y";
	        }

	        //교통비만 팝업
	        if(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"GBN_CD") == "C5"){

				window.showModalDialog("../../../Ehr/hr/but/buta024.jsp?row="+row+"&flag="+flag, dsT_DI_BUSINESSTRIP_BASIS, "dialogWidth:635px; dialogHeight:330px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

	            if(isNaN( Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY"))) || !isFinite(Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY")))){
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") = Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_TOLL")) + 0;
	            }else{
	                dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") = Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_TOLL")) + (Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_OIL")) * (Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_DISTANCE")) / Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"CAR_EFFICIENCY"))));
	            }

                if(Number(dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT")) != 0){
                    dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"COST_AMT")  = dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"PRICE_AMT") * dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"BAS_CNT") + dsT_DI_BUSINESSTRIP_BASIS.NameValue(row,"DESC_AMT");//합계급액
                }

	            dsT_DI_BUSINESSTRIP_BASIS.RowPosition = row;

	        }
        }

    </script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">여비계산서</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" width="650">
			    <span id="helpMessage">&nbsp;</span>

			</td>
			<td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConduct','','../../images/button/btn_ConductOver.gif',1)"> <img src="../../images/button/btn_ConductOn.gif" name="ImgConduct"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_BUSINESSTRIP_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:315px;">
						<param name="DataID" value="dsT_DI_BUSINESSTRIP_BASIS">
						<param name="Format" value='
							<C> id="{CUROW}"	width=39	name="NO"		align=center	value={String(Currow)}		</C>
							<C> id="GBN_CD"	    width=100	name="항목"		align=left	    Edit=none EditStyle=Lookup  Data="dsT_DI_BUSINESSTRIP_BASIS2:GBN_CD:GBN_NAME" </C>
							<C> id="SQN_NO"		width=40	name="SEQ"		align=center	Edit=none </C>
                            <C> id="CITY_DPT"	width=90	name="출발지"	align=center	Edit=none </C>
							<C> id="CITY_AVR"	width=90	name="도착지"	align=center    Edit=none </C>
                            <C> id="PRICE_AMT"	width=70	name="단가"		align=right     </C>
                            <C> id="BAS_CNT"	width=50	name="수량"		align=right     Edit=none </C>
                            <C> id="DESC_AMT" 	width=70	name="식비공제"	align=right     Edit=none </C>
                            <C> id="COST_AMT"	width=70	name="금액"		align=right     Edit=none </C>
                            <C> id="REMARK"	    width=160	name="비고"		align=left      </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <tr>
			<td  width="50%" align="left" class="paddingTop5">
				<!-- 조회 상태 테이블 시작 -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- 조회 상태 테이블 끝 -->
			</td>
			<td  width="" align="right" class="paddingTop5">
				<!-- 조회 상태 테이블 시작 -->
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState" width="100">출장비 계 :&nbsp;&nbsp;</td>
	                                <td valign="bottom" class="searchState">
										<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100;">
											<param name=Alignment						value=2>
											<param name=Border							value=true>
											<param name=ClipMode						value=true>
											<param name=DisabledBackColor			value="#D1B2FF">
											<param name=InheritColor   				value=true>
											<param name=Enable							value=false>
											<param name=IsComma						value=true>
											<param name=Language						value=0>
											<param name=MaxLength					value=14>
											<param name=Numeric						value=true>
											<param name=ShowLiteral					value="false">
											<param name=Visible							value="true">
										</object></comment><script> __ShowEmbedObject(__NSID__); </script>
	                                </td>
	                                <td width="20"> </td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<!-- 조회 상태 테이블 끝 -->
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

</body>
</html>