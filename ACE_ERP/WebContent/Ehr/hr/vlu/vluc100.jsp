<!--
    ************************************************************************************
    * @Source         : vluc100.jsp 					                                 *
    * @Description    : 세부추진계획 수정.           *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/12  |  안준성   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>세부추진계획수정(vluc100)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

		var btnList = 'TFTTFFFT';
		var flag = false;		//목표설정 입력기간 여부

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

			if( searchDiv == '1' || searchDiv == undefined ) {
				//세부추진계획 초기화
	            document.getElementById("resultMessagesub").innerText = '';
				dsT_EV_AIMSUB.ClearAll();

				if( !fnc_SearchItemCheck() ) return;

	            //데이터셋 전송(목표설정 조회)
	            dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SHR&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtAIM_YMD_SHR=1900-01-01&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbEVLENO_NO_SHR="+document.getElementById("cmbEVLENO_NO_SHR").value;
	            dsT_EV_AIMLST.Reset();
            }

			if( searchDiv == '2' ) {
	            //데이터셋 전송(세부추진계획 조회)
	            dsT_EV_AIMSUB.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SHR_01&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtAIM_YMD_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO")+"&txtAIM_SEQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
	            dsT_EV_AIMSUB.Reset();
            }

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem(searchDiv) {

			if( searchDiv == '1' ) {
	            //년도별 평가회차정보 조회
	            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&txtEVL_GBN_SHR=2";
	            dsT_EV_ESTINFO.Reset();
            }

			if( searchDiv == '2' ) {
	            //ITEM_SEQ 최대값 조회
	            dsT_EV_AIMSUB_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc040.cmd.VLUC040CMD&S_MODE=SHR_02&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtAIM_YMD_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO")+"&txtAIM_SEQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
	            dsT_EV_AIMSUB_01.Reset();
            }

			if( searchDiv == '3' ) {
	            //목표승인과 평가여부 조회
	            dsT_EV_AIMSUB_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_01&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtAIM_YMD_SHR=1900-01-01&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbEVLENO_NO_SHR="+document.getElementById("cmbEVLENO_NO_SHR").value;
	            dsT_EV_AIMSUB_02.Reset();
            }

			if( searchDiv == '4' ) {
	            //평가자 조회
	            dsT_EV_EVLIST_DT.DataID = "/servlet/GauceChannelSVL?cmd=common.combo.evlenonm.cmd.EVLENONMCMD&S_MODE=SHR&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
	            dsT_EV_EVLIST_DT.Reset();
            }

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

			if( !fnc_SaveItemCheck('1') )	return;

			for( i=1; i<=dsT_EV_AIMSUB.CountRow; i++ ) {
				if( dsT_EV_AIMSUB.RowStatus(i) == 1 || dsT_EV_AIMSUB.RowStatus(i) == 3 ) {
					if( dsT_EV_AIMSUB.NameValue(i,"JAN_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JAN_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"JAN_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JAN_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"FEB_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"FEB_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"FEB_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"FEB_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"MAR_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"MAR_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"MAR_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"MAR_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"APR_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"APR_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"APR_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"APR_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"MAY_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"MAY_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"MAY_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"MAY_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"JUN_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JUN_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"JUN_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JUN_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"JUL_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JUL_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"JUL_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"JUL_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"AUG_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"AUG_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"AUG_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"AUG_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"SEP_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"SEP_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"SEP_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"SEP_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"OCT_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"OCT_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"OCT_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"OCT_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"NOV_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"NOV_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"NOV_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"NOV_DN") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"DEC_UP") == '' )
						dsT_EV_AIMSUB.NameValue(i,"DEC_UP") = 'F';
					if( dsT_EV_AIMSUB.NameValue(i,"DEC_DN") == '' )
						dsT_EV_AIMSUB.NameValue(i,"DEC_DN") = 'F';
				}
			}

			//트랜잭션 전송
			trT_EV_AIMSUB.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SAV";
			trT_EV_AIMSUB.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

			if( !fnc_SaveItemCheck('2') ) return;

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_AIMSUB.CountColumn == 0) {
                dsT_EV_AIMSUB.setDataHeader("EVL_YY:STRING, EVL_FRQ:INT, AIM_YMD:STRING, ENO_NO:STRING, EVLENO_NO:STRING, AIM_SEQ:INT, ITEM_SEQ:INT, ITEM_DEC:STRING:NOTNULL, T_CHECK:STRING, JAN_UP:STRING, JAN_DN:STRING, FEB_UP:STRING, FEB_DN:STRING, MAR_UP:STRING, MAR_DN:STRING, APR_UP:STRING, APR_DN:STRING, MAY_UP:STRING, MAY_DN:STRING, JUN_UP:STRING, JUN_DN:STRING, JUL_UP:STRING, JUL_DN:STRING, AUG_UP:STRING, AUG_DN:STRING, SEP_UP:STRING, SEP_DN:STRING, OCT_UP:STRING, OCT_DN:STRING, NOV_UP:STRING, NOV_DN:STRING, DEC_UP:STRING, DEC_DN:STRING ");
	            fnc_SearchItem('2');		//추진항목 순번 최대값 조회
            } else {
            	var maxItemSeq = 0;
	            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
	            dsT_EV_AIMSUB.AddRow();

				//추진항목순번 최대값 구하기.
	            for( i=1; i<=dsT_EV_AIMSUB.CountRow; i++ ) {
	            	if( maxItemSeq < dsT_EV_AIMSUB.NameValue(i,"ITEM_SEQ") )
						maxItemSeq=dsT_EV_AIMSUB.NameValue(i,"ITEM_SEQ");
				}

				//그리드 자료 셋팅
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVL_YY")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVL_FRQ")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AIM_YMD")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ENO_NO")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVLENO_NO")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AIM_SEQ")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ITEM_SEQ")=maxItemSeq+1;

	            form1.grdT_EV_AIMSUB.SetColumn("ITEM_DEC");
	            form1.grdT_EV_AIMSUB.Focus();
            }

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_AIMSUB.AddRow();

			//그리드 자료 셋팅
            if (dsT_EV_AIMSUB.CountRow == 1) {
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVL_YY")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVL_FRQ")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AIM_YMD")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ENO_NO")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"EVLENO_NO")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AIM_SEQ")=dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
				dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ITEM_SEQ")=dsT_EV_AIMSUB_01.NameValue(1,"ITEM_SEQ")+1;
            }
            form1.grdT_EV_AIMSUB.SetColumn("ITEM_DEC");
            form1.grdT_EV_AIMSUB.Focus();

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_AIMSUB.CountRow < 1) {
                alert("제거 할 자료가 없습니다.");
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ITEM_DEC") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_AIMSUB.DeleteRow(dsT_EV_AIMSUB.RowPosition);

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_AIMSUB.SetColumn(form1.grdT_EV_AIMSUB.GetColumnID(form1.grdT_EV_AIMSUB.GetColumnIndex("ITEM_DEC")));
            form1.grdT_EV_AIMSUB.Focus();

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = '';
			dsT_EV_AIMLST.ClearAll();
            document.getElementById("resultMessagesub").innerText = '';
			dsT_EV_AIMSUB.ClearAll();

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_EV_AIMSUB.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( !valid(form1) )
				return false;
			else
				return true;

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck(searchDiv) {

			if( searchDiv == '1') { 		//저장시 유효성 체크
	        	if ( dsT_EV_AIMSUB.isUpdated ) {
	        		for( i=1; i<=dsT_EV_AIMSUB.CountRow; i++ ) {
						if( dsT_EV_AIMSUB.RowStatus(i) == 1 || dsT_EV_AIMSUB.RowStatus(i) == 2 || dsT_EV_AIMSUB.RowStatus(i) == 3 ) {
							if( dsT_EV_AIMSUB.NameValue(i, "ITEM_SEQ") == '' ) {
								alert("순번은 필수입력사항입니다..");
								dsT_EV_AIMSUB.RowPosition = i;
	                            form1.grdT_EV_AIMSUB.SetColumn("ITEM_SEQ");
	                            form1.grdT_EV_AIMSUB.focus();
								return false;
							}
							if( dsT_EV_AIMSUB.NameValue(i, "ITEM_DEC") == '' ) {
								alert("주요추진항목은 필수입력사항입니다..");
								dsT_EV_AIMSUB.RowPosition = i;
	                            form1.grdT_EV_AIMSUB.SetColumn("ITEM_DEC");
	                            form1.grdT_EV_AIMSUB.focus();
								return false;
							}
						}
					}
				} else {
					fnc_Message(document.getElementById("resultMessage"),"MSG_04");
					alert("저장 할 자료가 없습니다!");
	                return false;
				}
				return true;
			}

			if( searchDiv == '2') { 		//추가,제거시 유효성 체크
	        	if ( dsT_EV_AIMLST.CountRow == 0 ) {
					alert("상위의 목표수정 정보가 없습니다");
					return false;
				}
				return true;
			}

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_AIMLST, 15, "false", "false");
            cfStyleGrid(form1.grdT_EV_AIMSUB, 15, "true", "false");

			//년도별 평가회차관리 조회
			fnc_SearchItem('1');

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /********************************************
         * 15. 목표승인 여부에 따른,		*
         *		세부추진계획의 입력 disable,							*
         *******************************************/
        function fnc_DisableSet(disableDiv) {

			if( disableDiv == 'true' ) {
				form1.grdT_EV_AIMSUB.Editable = "false";

				document.getElementById("image0").disabled=true;
				document.getElementById("image2").disabled=true;
				document.getElementById("btn1").disabled=true;
				document.getElementById("btn2").disabled=true;
			} else {
				form1.grdT_EV_AIMSUB.Editable = "true";

				document.getElementById("image0").disabled=false;
				document.getElementById("image2").disabled=false;
				document.getElementById("btn1").disabled=false;
				document.getElementById("btn2").disabled=false;
			}

        }

        /********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);
		}

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_AIMSUB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_AIMSUB_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_AIMSUB_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)      |
    | 3. 사용되는 Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_AIMSUB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_AIMSUB)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

	<script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
		//세부추진계획 조회
		if( row > 0 )
			fnc_SearchList('2');
	</script>

	<script language=JavaScript for=grdT_EV_AIMSUB event=OnClick(row,colid)>
		if( grdT_EV_AIMSUB.Editable == true && colid == 'T_CHECK' ) {
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JAN_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JAN_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"FEB_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"FEB_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"MAR_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"MAR_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"APR_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"APR_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"MAY_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"MAY_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JUN_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JUN_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JUL_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"JUL_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AUG_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"AUG_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"SEP_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"SEP_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"OCT_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"OCT_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"NOV_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"NOV_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"DEC_UP") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
			dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"DEC_DN") = dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"T_CHECK");
		}
	</script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

		fnc_SearchItem('3');		//목표승인여부 조회

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("검색하신 조건의 자료가 없습니다!");

        } else {

			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_AIMLST.CountRow);

        }

  	 	grdT_EV_AIMLST.SetColumn("TASK_AIM");//set focus

    </Script>

    <Script For=dsT_EV_AIMSUB Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessagesub"),"MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessagesub"),"MSG_03",dsT_EV_AIMSUB.CountRow);

        }

  	 	grdT_EV_AIMSUB.SetColumn("ITEM_DEC");//set focus

    </Script>

    <Script For=dsT_EV_AIMSUB_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			alert("추진항목순번 최대값이 없습니다.");

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Append();

        }

    </Script>

    <Script For=dsT_EV_AIMSUB_02 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			alert("목표승인여부 값이 없습니다.");

        } else {

			//평가여부 조회
			if( dsT_EV_AIMSUB_02.NameValue(2,"AIM_YMD") != '' ) {
				fnc_DisableSet('true');		//입력불가 처리
				alert("평가가 진행중이거나 완료되었으므로 세부추진계획수정 입력 불가합니다.");
				return;
			} else {
				fnc_DisableSet('false');		//입력가능 처리
			}

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
			if( dsT_EV_AIMSUB_02.NameValue(1,"ACCEPT_GBN") == '1' ) {		//승인일경우 처리
				fnc_DisableSet('true');		//입력불가 처리
				alert("승인처리 되었으므로 수정 불가 합니다.");
			} else {
				fnc_DisableSet('false');		//입력가능 처리
			}

        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';
            alert("평가적용기간이 아닙니다.");

        } else {

			document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
			document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
			document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
			document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
			document.getElementById("txtDPT_NM_SHR").value = '<%=box.get("SESSION_DPTNM")%>';

        }

		//평가자 조회
		fnc_SearchItem('4');

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {


        } else {

			//평가자
			var oOption;
			for( i=1; i<=dsT_EV_EVLIST_DT.CountRow; i++ ) {
				oOption = document.createElement("OPTION");
				oOption.value = dsT_EV_EVLIST_DT.NameValue(i,"EVLENO_NO");
				oOption.text = dsT_EV_EVLIST_DT.NameValue(i,"EVLENO_NM");
				document.getElementById("cmbEVLENO_NO_SHR").add(oOption);
			}

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_AIMSUB Event="OnLoadError()">

        document.getElementById("resultMessagesub").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_AIMSUB Event="OnDataError()">

        document.getElementById("resultMessagesub").innerText = ' ';

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[주요추진항목] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("주요추진항목에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_AIMSUB event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_AIMSUB event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- 켈린더 프레임-->
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
	                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">세부추진계획수정</td>
	                    <td align="right" class="navigator">HOME/인사평가/성과평가/<font color="#000000">세부추진계획수정</font></td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1')"></a>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- 버튼 테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<!-- 조건 입력 테이블 끝 -->

	<!-- power Search테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" class="greenTable">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <colgroup>
	                                <col width="80 "></col>
	                                <col width="40 "></col>
	                                <col width="40 "></col>
	                                <col width="40 "></col>
	                                <col width="40 "></col>
	                                <col width="80"></col>
	                                <col width="140 "></col>
	                                <col width="80 "></col>
	                                <col width="40 "></col>
	                                <col width="80 "></col>
	                                <col width="70 "></col>
	                                <col width="70 "></col>
	                            </colgroup>
	                            <tr>
	                                <td align="right" class="searchState">해당년도</td>
	                                <td class="padding2423">
	                                	<input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">회차</td>
	                                <td class="padding2423">
										<input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">소속</td>
	                                <td class="padding2423">
	                                	<input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
	                                </td>
	                                <td align="right" class="searchState">피평가자 사번</td>
	                                <td class="padding2423">
	                                	<input id=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly style="text-align:center:">
	                                </td>
									<td align="right" class="searchState">성명</td>
	                                <td class="padding2423">
	                                	<input id=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">평가자</td>
	                                <td class="padding2423">
		                                    <select id=cmbEVLENO_NO_SHR style="width:100" valid='key=true' field='평가자' onChange="fnc_SearchList('1');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
		                                     </select>
	                                </td>
	                            </tr>
	                        </table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- power Search테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td valign="top" class="searchState">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							<object	id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:120px;">
								<param name="DataID"					value="dsT_EV_AIMLST">
								<param name="Editable"					value="false">
								<param name="DragDropEnable"			value="true">
								<param name="SortView"					value="Left">
								<param name="IndWidth"					value=0>
								<param name="VIEWSUMMARY"				value=0>
								<param name="AutoReSizing"              value="true">
								<param name=ColSizing  value="true">
								<param name="Format"					value="
									<C> id='EVL_YY'       width=40        name='해당년도'     align=center		show=false </C>
									<C> id='EVL_FRQ'       width=40        name='평가회차'     align=center		show=false </C>
									<C> id='AIM_YMD'       width=40        name='목표설정일자'     align=center		show=false </C>
									<C> id='ENO_NO'       width=40        name='피평가자사번'     align=center		show=false </C>
									<C> id='EVLENO_NO'       width=40        name='평가자사번'     align=center		show=false </C>
									<C> id='AIM_SEQ'       width=50        name='순번'     align=center 		show=false </C>
									<C> id='TASK_AIM'       width=208        name='주요업무목표'     align=left	</C>
									<C> id='BASIC_PAR'       width=208        name='성과평가지표'     align=left </C>
									<C> id='GAUGE_GB'       width=60        name='계량구분'     align=center	editstyle=combo	data='1:계량,2:비계량' </C>
									<C> id='AIM_LEVEL'       width=208        name='목표수준'     align=left </C>
									<C> id='ADDING_PCT'       width=40        name='가중치'     align=right </C>
									<C> id='DIFFICULT_PNT'       width=40        name='난이도'     align=center		editstyle=combo	data='10:10,20:20' </C>
									<C> id='ACCEPT_GBN'       width=80        name='목표승인여부'     align=center		show=false </C>
								">
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td valign="bottom" class="searchState" style="padding-top:15"><span id="resultMessageSub">&nbsp;</span>
	        </td>
			<td valign="top" class="searchState" style="padding-top:15">&nbsp;</td>
			<td align="right" valign="bottom">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn1','','/images/button/btn_AppendOver.gif',1)">  <img src="/images/button/btn_AppendOn.gif"   id="btn1" name="btn1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn2','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   id="btn2" name="btn2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove();"></a>
			</td>
	    </tr>
	</table>
	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td  class="paddingTop5" style="padding-top:1">
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                    <td>
								<comment id="__NSID__">
								<object	id="grdT_EV_AIMSUB" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:180px;">
									<param name="DataID"					value="dsT_EV_AIMSUB">
									<param name="Editable"					value="true">
									<param name="DragDropEnable"			value="true">
									<param name="SortView"					value="Left">
									<param name="VIEWSUMMARY"				value=0>
									<param name=UsingOneClick  value="1">
									<param name="AutoReSizing"              value="true">
									<param name=ColSizing  value="true">
									<param name="Format"					value="
										<C> id='ITEM_SEQ'		width=40		name='순번'			align=center		edit=none		show=false </C>
										<C> id='ITEM_DEC'		width=289	    name='주요추진항목'	align=Left	editlimit=200 </C>
										<C> id='T_CHECK'		width=19		name='전\\\\체'			align=center		editstyle=checkbox </C>
										<X> name='추진 일정' HeadBgColor='#F7DCBB'
											<G> name='1月' HeadBgColor='#F7DCBB'
												<C> id='JAN_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='JAN_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='2月' HeadBgColor='#F7DCBB'
												<C> id='FEB_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='FEB_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='3月' HeadBgColor='#F7DCBB'
												<C> id='MAR_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='MAR_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='4月' HeadBgColor='#F7DCBB'
												<C> id='APR_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='APR_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='5月' HeadBgColor='#F7DCBB'
												<C> id='MAY_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='MAY_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='6月' HeadBgColor='#F7DCBB'
												<C> id='JUN_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='JUN_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='7月' HeadBgColor='#F7DCBB'
												<C> id='JUL_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='JUL_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='8月' HeadBgColor='#F7DCBB'
												<C> id='AUG_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='AUG_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='9月' HeadBgColor='#F7DCBB'
												<C> id='SEP_UP'		width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='SEP_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='10月' HeadBgColor='#F7DCBB'
												<C> id='OCT_UP'	width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='OCT_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='11月' HeadBgColor='#F7DCBB'
												<C> id='NOV_UP'	width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='NOV_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='12月' HeadBgColor='#F7DCBB'
												<C> id='DEC_UP'	width=19		name='상'		align=center		editstyle=checkbox </C>
												<C> id='DEC_DN'	width=19		name='하'		align=center		editstyle=checkbox </C>
											</G>
										</X>
									">
								</object>
								</comment><script> __ShowEmbedObject(__NSID__); </script>
	                    </td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->

	<!-- Validation Init  -->
	<jsp:include page="/common/CommonValid.jsp" flush="true">
	   <jsp:param name="INIT"    value="false"/>
	</jsp:include>

</body>
</html>