<!--
*****************************************************
* @source       : lawa010.jsp
* @description : HRMS PAGE :: 법무관리_신규등록
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/12/06      한학현        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String getOrd_no = JSPUtil.toKor(request.getParameter("ORD_NO"));
	String title1 = "HOME/총무(기타)/법무관리/전체내역조회/";
	String title2 = request.getParameter("TITLE");
    
    boolean isAddNew = false;

	if(title2 == null || title2.trim().equals("")){
		title1 = "HOME/총무(기타)/법무관리/";
		title2 = "신규등록";
        
        isAddNew = true;
	}
%>

<html>
<head>
<title><%=title2%></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->

<script language="javascript" >

		var btnList = 'FFTTFFFT';
        var ActiveIndex = 0;
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var ord_no = document.getElementById("txtORD_NO").value;
        
            dsT_LW_BONDLIST.DataID = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SHR&ORD_NO="+ord_no;
            dsT_LW_BONDLIST.Reset();

            ds01T_LW_BONDHIST.DataID = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SHR_02&ORD_NO="+ord_no;
            ds01T_LW_BONDHIST.Reset();

            ds02T_LW_BONDHIST.DataID = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SHR_03&ORD_NO="+ord_no;
            ds02T_LW_BONDHIST.Reset();
        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {
			if( !fnc_SaveItemCheck() )	return;

			trT_LW_BONDLIST.Action = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SAV";
			trT_LW_BONDLIST.Post();

			tr01T_LW_BONDHIST.Action = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SAV_01";
			tr01T_LW_BONDHIST.Post();

			tr02T_LW_BONDHIST.Action = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SAV_02";
			tr02T_LW_BONDHIST.Post();

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
         ******************/
        function fnc_AddNew() {
            if(dsT_LW_BONDLIST.CountRow > 0 
                    && dsT_LW_BONDLIST.RowStatus(1) == "1") {
                if(!confirm("저장하지 않은 자료가 있습니다. 계속하시겠습니까?")) {
                    return;
                }
            }
        
            //모든 데이타 초기화 시킴
            fnc_Clear();
        
			// 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_LW_BONDLIST.CountColumn == 0) {
                dsT_LW_BONDLIST.setDataHeader("ORD_NO:STRING:KEYVALUETYPE,EVENT_NM:STRING,HEAD_CD:STRING,DPT_CD:STRING,ORD_YMD:STRING,ORD_MAN:STRING,ORD_TEL:STRING,YOU_NM:STRING,YOU_MAN:STRING,YOU_TEL:STRING,BOND_GBN:STRING,BOND_AMT:DECIMAL,BOND_AC_AMT:DECIMAL,BOND_TXT:STRING,SEC_LAND:STRING,SEC_PLED:STRING,SEC_GUAR:STRING,SEC_CASH:STRING,SEC_GUOR1:STRING,SEC_GUOR2:STRING,SEC_SO:STRING,LAW_NM:STRING,LAW_NO:STRING,LAW_B:STRING,LAW_1:STRING,LAW_2:STRING,LAW_3:STRING,LAW_A:STRING,LAW_GBN:STRING,WANT_MAN:STRING,DEFE_MAN:STRING,DATE_B:STRING,DATE_1:STRING,DATE_2:STRING,DATE_3:STRING,DATE_A:STRING,COST_B:DECIMAL,COST_1:DECIMAL,COST_2:DECIMAL,COST_3:DECIMAL,COST_A:DECIMAL,APP_DATE:STRING,FIN_DATE:STRING,REMARK:STRING,END_YN:STRING");
            }

   			dsT_LW_BONDLIST.AddRow();
            
            
            //사건완료 버튼 비활성
            document.getElementById("imgCase").style.display = "none";

            //접수번호 자동생성
            ds01T_LW_BONDLIST.DataID = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SHR_01";
            ds01T_LW_BONDLIST.Reset();

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {
	        if(ActiveIndex == 1){//진행사항
				// 해당 Dataset의 Header가 없으면 Header 선언
	            if (ds01T_LW_BONDHIST.CountColumn == 0) {
	                ds01T_LW_BONDHIST.setDataHeader("ORD_NO:STRING(10):KEYVALUETYPE, SEQ_NO:STRING(2):KEYVALUETYPE, GBN_TAG:STRING(2):KEYVALUETYPE, HIS_YMD:STRING(8):KEYVALUETYPE, HIS_CONT:STRING(50):NOTNULL, HIS_RESU:STRING(30), HIS_AMT:DECIMAL(10)");
	            }

				ds01T_LW_BONDHIST.AddRow();
				//접수번호
				ds01T_LW_BONDHIST.NameValue(ds01T_LW_BONDHIST.RowPosition,"ORD_NO") = document.getElementById("txtORD_NO").value;
				ds01T_LW_BONDHIST.NameValue(ds01T_LW_BONDHIST.RowPosition,"GBN_TAG") = "I";

				var cnt = parseInt(ds01T_LW_BONDHIST.CountRow);
				ds01T_LW_BONDHIST.NameValue(ds01T_LW_BONDHIST.RowPosition,"SEQ_NO") = cnt;

	        }else if(ActiveIndex == 2){//예정사항
				// 해당 Dataset의 Header가 없으면 Header 선언
	            if (ds02T_LW_BONDHIST.CountColumn == 0) {
	                ds02T_LW_BONDHIST.setDataHeader("ORD_NO:STRING(10):KEYVALUETYPE, SEQ_NO:STRING(2):KEYVALUETYPE, GBN_TAG:STRING(2):KEYVALUETYPE, HIS_YMD:STRING(8):KEYVALUETYPE, HIS_CONT:STRING(50):NOTNULL, HIS_RESU:STRING(30), HIS_AMT:DECIMAL(10)");
	            }

				ds02T_LW_BONDHIST.AddRow();
				//접수번호
				ds02T_LW_BONDHIST.NameValue(ds02T_LW_BONDHIST.RowPosition,"ORD_NO") = document.getElementById("txtORD_NO").value;
				ds02T_LW_BONDHIST.NameValue(ds02T_LW_BONDHIST.RowPosition,"GBN_TAG") = "P";

				var cnt = parseInt(ds02T_LW_BONDHIST.CountRow);
				ds02T_LW_BONDHIST.NameValue(ds02T_LW_BONDHIST.RowPosition,"SEQ_NO") = cnt;


	        }

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {
	        if(ActiveIndex == 1){//진행사항
				// 삭제 할 자료가 있는지 체크하고
	            if (ds01T_LW_BONDHIST.CountRow < 1) {
	                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
	                return;
	            }

	            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
	            if (confirm("[" + ds01T_LW_BONDHIST.NameValue(ds01T_LW_BONDHIST.RowPosition,"HIS_CONT") + "] 자료를 제거하시겠습니까?") == false) return;
	            ds01T_LW_BONDHIST.DeleteRow(ds01T_LW_BONDHIST.RowPosition);

	            // 삭제 후 해당 그리드로 Focus 이동
	            form1.grd01T_LW_BONDHIST.SetColumn(form1.grd01T_LW_BONDHIST.GetColumnID(form1.grd01T_LW_BONDHIST.GetColumnIndex("HIS_CONT")));
	            form1.grd01T_LW_BONDHIST.Focus();


	        }else if(ActiveIndex == 2){//예정사항
				// 삭제 할 자료가 있는지 체크하고
	            if (ds02T_LW_BONDHIST.CountRow < 1) {
	                alert("제거 할 자료가 없습니다.");
	                return;
	            }

	            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
	            if (confirm("[" + ds02T_LW_BONDHIST.NameValue(ds02T_LW_BONDHIST.RowPosition,"HIS_CONT") + "] 자료를 제거하시겠습니까?") == false) return;
	            ds02T_LW_BONDHIST.DeleteRow(ds02T_LW_BONDHIST.RowPosition);

	            // 삭제 후 해당 그리드로 Focus 이동
	            form1.grd02T_LW_BONDHIST.SetColumn(form1.grd02T_LW_BONDHIST.GetColumnID(form1.grd02T_LW_BONDHIST.GetColumnIndex("HIS_CONT")));
	            form1.grd02T_LW_BONDHIST.Focus();

	        }

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {
            //접수번호를 기억해 놓는다.
            var ord_no = document.getElementById("txtORD_NO").value;
            var count_num = document.getElementById("txtCOUNT_NUM").value;

			dsT_LW_BONDLIST.ClearData();
			ds01T_LW_BONDHIST.ClearData();
			ds02T_LW_BONDHIST.ClearData();

            document.getElementById("txtORD_NO").value = ord_no;
            document.getElementById("txtCOUNT_NUM").value = count_num;

			document.form1.txtORD_NO.focus();
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

	        //이곳에 해당 코딩을 입력 하세요
	        if (dsT_LW_BONDLIST.IsUpdated || ds01T_LW_BONDHIST.IsUpdated || ds02T_LW_BONDHIST.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

			if("<%=title2%>" == "신규등록"){//신규등록
		        frame = window.external.GetFrame(window);
		        frame.CloseFrame();
	        }else{//상세내역조회
	   			window.close();
   			}

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_LW_BONDLIST.isUpdated && !ds01T_LW_BONDHIST.isUpdated && !ds02T_LW_BONDHIST.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 1;//row는 하나뿐이다.
			var oEVENT_NM, oDPT_CD, oHEAD_CD, oORD_MAN, oBOND_GBN, oYOU_NM, oYOU_MAN, oORD_YMD;

			oEVENT_NM = dsT_LW_BONDLIST.NameValue(i,"EVENT_NM");
			if(oEVENT_NM.trim() == ""){
				alert("사건명을 입력해주세요." );
				document.getElementById("txtEVENT_NM").focus();
				return false;
			}

			oDPT_CD = dsT_LW_BONDLIST.NameValue(i,"DPT_CD");
			if(oDPT_CD.trim() == ""){
				alert("의뢰부서 소속을 입력해주세요." );
				document.getElementById("txtDPT_CD").focus();
				return false;
			}

			oHEAD_CD = dsT_LW_BONDLIST.NameValue(i,"HEAD_CD");
			if(oHEAD_CD.trim() == ""){
				alert("의뢰부서 관련사업본부를 입력해주세요." );
				document.getElementById("txtHEAD_CD").focus();
				return false;
			}

			oORD_YMD = dsT_LW_BONDLIST.NameValue(i,"ORD_YMD");
			if(oORD_YMD.trim().length == 0){
				alert("의뢰일자를 입력하세요.");
				document.getElementById("txtORD_YMD").focus();
				return false;
			}

			if(!cfDateExpr(oORD_YMD) || oORD_YMD.trim().length != 10){
				alert("의뢰일자가  잘못되었습니다.");
				document.getElementById("txtORD_YMD").focus();
				return false;
			}

			oORD_MAN = dsT_LW_BONDLIST.NameValue(i,"ORD_MAN");
			if(oORD_MAN.trim() == ""){
				alert("의뢰부서 담당자를 입력해주세요." );
				document.getElementById("txtORD_MAN").focus();
				return false;
			}

			oBOND_GBN = dsT_LW_BONDLIST.NameValue(i,"BOND_GBN");
			if(oBOND_GBN.trim() == ""){
				alert("의뢰부서 채권구분를 입력해주세요." );
				document.getElementById("txtBOND_GBN").focus();
				return false;
			}

			oYOU_NM = dsT_LW_BONDLIST.NameValue(i,"YOU_NM");
			if(oYOU_NM.trim() == ""){
				alert("상대처 명칭을 입력해주세요." );
				document.getElementById("txtYOU_NM").focus();
				return false;
			}

			oYOU_MAN = dsT_LW_BONDLIST.NameValue(i,"YOU_MAN");
			if(oYOU_MAN.trim() == ""){
				alert("상대처 담당자를 입력해주세요." );
				document.getElementById("txtYOU_MAN").focus();
				return false;
			}


			for(i=1; i<=ds01T_LW_BONDHIST.countrow; i++){
				if(ds01T_LW_BONDHIST.NameValue(i,"HIS_YMD") == null || ds01T_LW_BONDHIST.NameValue(i,"HIS_YMD") == "" ){
					alert("진행사항의 적용일자를 입력하세요.");
					ds01T_LW_BONDHIST.RowPosition = i;
					return false;
				}
			}

			for(i=1; i<=ds02T_LW_BONDHIST.countrow; i++){
				if(ds02T_LW_BONDHIST.NameValue(i,"HIS_YMD") == null || ds02T_LW_BONDHIST.NameValue(i,"HIS_YMD") == "" ){
					alert("예정사항의 적용일자를 입력하세요.");
					ds02T_LW_BONDHIST.RowPosition = i;
					return false;
				}
			}

			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style 적용
            cfStyleGrid(form1.grd01T_LW_BONDHIST,15,"true","right");
            cfStyleGrid(form1.grd02T_LW_BONDHIST,15,"true","right");

            //버튼들 초기화
            TabEvent(0);
<%
    //신규등록
    if(isAddNew) {
%>
            //신규추가
            fnc_AddNew();
<%
    } else {
        
        
        //관리자가 아니면 사건완료 버튼 비활성화   
        if(!(box.get("SESSION_LAW_AUTHO").equals("M")
                || box.get("SESSION_ROLE_CD").equals("1001")) ) {
%>
            document.getElementById("imgCase").style.display = "none";
<%
        }
%>

            
            

            //조회
            document.getElementById("txtORD_NO").value = "<%=getOrd_no %>";
            fnc_SearchList();
<%
    }
%>

        }

		/********************
         * 16. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

		function fnc_Calculation(){
			var i = 1;
			var oBOND_AMT, oBOND_AC_AMT;

			oBOND_AMT = dsT_LW_BONDLIST.NameValue(i,"BOND_AMT");//금액
			oBOND_AC_AMT = dsT_LW_BONDLIST.NameValue(i,"BOND_AC_AMT");//현회수액

			if(oBOND_AC_AMT == null || oBOND_AC_AMT == ""){
				dsT_LW_BONDLIST.NameValue(i,"BOND_AC_AMT") = 0;
			}

			document.medBOND_NO_AMT.Text = parseInt(oBOND_AMT) - parseInt(oBOND_AC_AMT);
		}

		function fnc_Complete() {
			var i = 1;
			var oEND_YN = dsT_LW_BONDLIST.NameValue(i,"END_YN");//금액

			if(oEND_YN == "Y"){
				alert("이미 완료하였습니다.");
			}else{
				if(!confirm("사건완료를 하시겠습니까?")) return;

				dsT_LW_BONDLIST.NameValue(i,"END_YN") = "Y";

				trT_LW_BONDLIST.Action = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa010.cmd.LAWA010CMD&S_MODE=SAV_03";
				trT_LW_BONDLIST.Post();

				//완료후에도 사건완료 버튼 비활성
				document.getElementById("imgCase").style.display = "none";

			}
		}

		function fnc_GetHeadCd(){
			var DPT_CD = document.getElementById("txtDPT_CD").value;
			var DPT_NM = document.getElementById("txtDPT_NM").value;

			//소속이 있으면 본부 조회
			if(DPT_CD != "" && DPT_NM != ""){

				if (document.all("coCommNmGDS") == null) {
					dataSet = document.createElement("<OBJECT>");
					dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
					dataSet.id = "coCommNmGDS";
					dataSet.SyncLoad = "true";

					for (var i = 0; i < document.all.length; i++) {
						if (document.all[i].tagName == "HEAD") {
							document.all[i].insertAdjacentElement("beforeEnd", dataSet);
							break;
						}
					}
				} else {
					dataSet = document.all("coCommNmGDS");
				}

			    svl = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
			          "&CD_GBN=" + "A4" +
			          "&COMM_CD=" + DPT_CD +
			          "&UP_CD=" + "";
				dataSet.DataId = svl;
				dataSet.Reset();

				if (dataSet.countrow > 0)	{
			        document.getElementById("txtHEAD_CD").value   = dataSet.NameValue(1,"UP_CD");
			        fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');
				}

			}

		}
        
        
        //입력 항목 리스트
        var elementList = new Array(         "txtORD_NO"
                                            ,"txtEVENT_NM"
                                            ,"txtHEAD_CD"
                                            ,"txtHEAD_NM"
                                            ,"txtDPT_CD"
                                            ,"txtDPT_NM"
                                            ,"txtORD_YMD"
                                            ,"txtORD_MAN"
                                            ,"txtORD_TEL"
                                            ,"txtYOU_NM"
                                            ,"txtYOU_MAN"
                                            ,"txtYOU_TEL"
                                            ,"txtBOND_GBN"
                                            ,"txtBOND_GBN_NM"
                                            ,"medBOND_AMT"
                                            ,"medBOND_AC_AMT"
                                            ,"txtBOND_TXT"
                                            ,"txtSEC_LAND"
                                            ,"txtSEC_PLED"
                                            ,"txtSEC_GUAR"
                                            ,"txtSEC_CASH"
                                            ,"txtSEC_GUOR1"
                                            ,"txtSEC_GUOR2"
                                            ,"txtSEC_SO"
                                            ,"txtLAW_NM"
                                            ,"txtLAW_NO"
                                            ,"txtLAW_B"
                                            ,"txtLAW_1"
                                            ,"txtLAW_2"
                                            ,"txtLAW_3"
                                            ,"txtLAW_A"
                                            ,"cmbLAW_GBN"
                                            ,"txtWANT_MAN"
                                            ,"txtDEFE_MAN"
                                            ,"txtDATE_B"
                                            ,"txtDATE_1"
                                            ,"txtDATE_2"
                                            ,"txtDATE_3"
                                            ,"txtDATE_A"
                                            ,"medCOST_B"
                                            ,"medCOST_1"
                                            ,"medCOST_2"
                                            ,"medCOST_3"
                                            ,"medCOST_A"
                                            ,"txtAPP_DATE"
                                            ,"txtFIN_DATE"
                                            ,"txtREMARK"
                                            ,"txtEND_YN"
                                            ,"img_HelpOn1"
                                            ,"img_HelpOn3"
                                            ,"img_HelpOn4"
                                            ,"img_HelpOn5"
                                            ,"img_HelpOn6"
                                            ,"img_HelpOn7"
                                            ,"img_HelpOn8"
                                            ,"img_HelpOn9"
                                            ,"img_HelpOn10"
                                            ,"img_HelpOn11" 
                                            ,"imgAppend1"
                                            ,"imgRemove1"
                                            ,"imgAppend2"
                                            ,"imgRemove2"
                                            );
                                            
                                            
        //Layer ID
        var layerList = new Array(  "tabLAWA010_01"
                                   ,"tabLAWA010_02"
                                   ,"tabLAWA010_03"
                                    );

        /**
         * 해당 레이어 보여주고 닫기
         * @param 클릭한 layer idx
         */
        function TabEvent(idx) {
            ActiveIndex = idx+1;
            
            //Layer 보여주고 닫기
            fnc_ShowHiddenLayer(layerList, layerList[idx]);
            
            
            //Tab 이미지 보여주고 닫기 (문서 권한에 따라 보여주는것과 아닌것이 달라짐)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }
            
                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }
            
            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";
        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : dsT_LW_BONDLIST                                     |
    | 3. Table List : T_LW_BONDLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_LW_BONDLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_LW_BONDLIST                                 |
    | 3. Table List : T_LW_BONDLIST                                |
    +----------------------------------------------->
    <Object ID="ds01T_LW_BONDLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds01T_LW_BONDHIST                                 |
    | 3. Table List : T_LW_BONDHIST                                |
    +----------------------------------------------->
    <Object ID="ds01T_LW_BONDHIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                          |
    | 2. 이름 : ds02T_LW_BONDHIST                                 |
    | 3. Table List : T_LW_BONDHIST                                |
    +----------------------------------------------->
    <Object ID="ds02T_LW_BONDHIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : trT_LW_BONDLIST                                       |
    | 3. Table List : T_LW_BONDLIST                                 |
    +----------------------------------------------->
    <Object ID ="trT_LW_BONDLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
			<Param Name=KeyValue     Value="SVL(I:dsT_LW_BONDLIST=dsT_LW_BONDLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : tr01T_LW_BONDHIST                                       |
    | 3. Table List : T_LW_BONDHIST                                 |
    +----------------------------------------------->
    <Object ID ="tr01T_LW_BONDHIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
			<Param Name=KeyValue     Value="SVL(I:ds01T_LW_BONDHIST=ds01T_LW_BONDHIST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                     |
    | 2. 이름 : tr02T_LW_BONDHIST                                       |
    | 3. Table List : T_LW_BONDHIST                                 |
    +----------------------------------------------->
    <Object ID ="tr02T_LW_BONDHIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
			<Param Name=KeyValue     Value="SVL(I:ds02T_LW_BONDHIST=ds02T_LW_BONDHIST)">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component에서 발생하는 Event 처리부       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            //접수번호 설정
            document.getElementById("txtORD_NO").value = ds01T_LW_BONDLIST.NameValue(0,"ORD_NO");
            document.getElementById("txtCOUNT_NUM").value = ds01T_LW_BONDLIST.NameValue(0,"COUNT_NUM");
        } else {

			//완료후에도 사건완료 버튼 비활성
        	if(dsT_LW_BONDLIST.NameValue(1,"END_YN") =="Y"){
				document.getElementById("imgCase").style.display = "none";
        	}

	        fnc_Calculation();
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds01T_LW_BONDLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
        } else {
            //접수번호 설정
            document.getElementById("txtORD_NO").value = ds01T_LW_BONDLIST.NameValue(0,"ORD_NO");
            document.getElementById("txtCOUNT_NUM").value = ds01T_LW_BONDLIST.NameValue(0,"COUNT_NUM");
			document.getElementById("txtEVENT_NM").focus();
        }
    </Script>

    <Script For=ds01T_LW_BONDHIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage1"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage1"), "MSG_03", iCount);
        }
    </Script>

    <Script For=ds02T_LW_BONDHIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage2"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage2"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직                     |
    +---------------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_LW_BONDLIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds01T_LW_BONDHIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=ds02T_LW_BONDHIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_LW_BONDLIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_LW_BONDLIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=ds01T_LW_BONDHIST Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[일자/내용] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("일자/내용에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <Script For=ds02T_LW_BONDHIST Event="OnDataError()">
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
	        alert("해당 필수입력항목[일자/내용] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("일자/내용에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_LW_BONDLIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <script for=tr01T_LW_BONDHIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage1"), "MSG_01");
    </script>

    <script for=tr02T_LW_BONDHIST event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage2"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_LW_BONDLIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=tr01T_LW_BONDHIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=tr02T_LW_BONDHIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | 회수액 계산                            |
    +--------------------------->
    <script language=JavaScript for=medBOND_AMT event=onKeyUp(kcode,scode)>
		fnc_Calculation();
	</script>

    <script language=JavaScript for=medBOND_AC_AMT event=onKeyUp(kcode,scode)>
		fnc_Calculation();
	</script>

    <script language=JavaScript for=medBOND_AMT event=onSetFocus()>
		var oBOND_AMT = document.medBOND_AMT.Text;
		if(oBOND_AMT == "0"){
			document.medBOND_AMT.Text = "";
		}
	</script>

    <script language=JavaScript for=medBOND_AMT event=OnKillFocus()>
	    var oBOND_AMT = document.medBOND_AMT.Text;
		if(oBOND_AMT == ""){
			document.medBOND_AMT.Text = "0";
		}
	</script>

    <script language=JavaScript for=medBOND_AC_AMT event=onSetFocus()>
		var oBOND_AC_AMT = document.medBOND_AC_AMT.Text;
		if(oBOND_AC_AMT == "0"){
			document.medBOND_AC_AMT.Text = "";
		}
	</script>

    <script language=JavaScript for=medBOND_AC_AMT event=OnKillFocus()>
	    var oBOND_AC_AMT = document.medBOND_AC_AMT.Text;
		if(oBOND_AC_AMT == ""){
			document.medBOND_AC_AMT.Text = "0";
		}
	</script>

	<script language="javascript"  for=grd01T_LW_BONDHIST event=OnExit(row,colid,olddata)>

		if(colid == "HIS_YMD"){
			if(!cfDateExpr(ds01T_LW_BONDHIST.NameValue(row,colid))){
				alert('날짜형식에 맞지않습니다.');
				ds01T_LW_BONDHIST.NameValue(row,colid) = "";
			}
		}

	</script>

	<script language="javascript"  for=grd02T_LW_BONDHIST event=OnExit(row,colid,olddata)>

		if(colid == "HIS_YMD"){
			if(!cfDateExpr(ds02T_LW_BONDHIST.NameValue(row,colid))){
				alert('날짜형식에 맞지않습니다.');
				ds02T_LW_BONDHIST.NameValue(row,colid) = "";
			}
		}

	</script>





    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_LW_BONDLIST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
        
<%
    //권한이 법무권한 마스터 이면 모두 수정가능 - M 마스터, A 모든부서, S 소속부서
    //인사 마스터(1002)는 권한이 없음
    if(box.get("SESSION_LAW_AUTHO").equals("M")
            || box.get("SESSION_ROLE_CD").equals("1001")) {
%>
            fnc_EnableElementAll(elementList);
<%
    } else {
%>
            if(dsT_LW_BONDLIST.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_ChangeStateElement(true, "txtREMARK");
            }
<%
    }
%>
        }

    </script>
    
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">
<input type="hidden" id="txtEND_YN">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><%=title2%></td>
					<td align="right" class="navigator"><%=title1%><font color="#000000"><%=title2%></font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="250" valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
		<td width="*" height="35" class="paddingTop5" align="right">
			<a href="http://www.scourt.go.kr/" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgScourt','','/images/button/btn_ScourtOver.gif',1)">  <img src="/images/button/btn_ScourtOn.gif"   name="imgScourt" width="70" height="20" border="0" align="absmiddle"></a>
			<a href="http://www.klac.or.kr/" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgKlac','','/images/button/btn_KlacOver.gif',1)">  <img src="/images/button/btn_KlacOn.gif"   name="imgKlac" width="125" height="20" border="0" align="absmiddle"></a>
            &nbsp;&nbsp;
            
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
<%
    if(isAddNew) {
%>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
<%
    }
%>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="710" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">접수번호</td>
					<td class="padding2423"><input id="txtORD_NO" style="width:100%" maxlength="10" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">관리번호</td>
					<td class="padding2423"><input id="txtCOUNT_NUM" style="width:100%" maxlength="10" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">사건명</td>
					<td class="padding2423"><input id="txtEVENT_NM" style="width:100%" maxlength="60"></td>
				</tr>
			</table>
		</td>
		<td>
			<!-- 신규등록에서는 막힌다. -->
			&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCase','','/images/button/btn_CaseOver.gif',1)"><img src="/images/button/btn_CaseOn.gif" name="imgCase" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Complete();"></a>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>의뢰부서</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width="178"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">소속</td>
					<td class="padding2423">
						<input id="txtDPT_CD" size="6" style="text-align:center;" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');fnc_GetHeadCd();">
                        <input id="txtDPT_NM" size="14" class="input_ReadOnly" readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','부서','DEPT');fnc_GetHeadCd();">
						</a>
					</td>
                    <td align="center" class="creamBold">관련사업본부</td>
					<td class="padding2423">
						<input id="txtHEAD_CD" size="6" style="text-align:center;" class="input_ReadOnly" readOnly>&nbsp;<input id="txtHEAD_NM" size="14" class="input_ReadOnly" readOnly>
						<!--
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)">
							<img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtHEAD_CD','txtHEAD_NM','사업본부','HEAD');">
						</a>
						-->
                    <td align="center" class="creamBold">의뢰일자</td>
					<td class="padding2423">
		        		<input id="txtORD_YMD" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD','','585','152');"></a>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">담당자</td>
					<td class="padding2423"><input id="txtORD_MAN" style="width:100%" maxlength="15"></td>
                    <td align="center" class="creamBold">연락처</td>
					<td class="padding2423"><input id="txtORD_TEL" style="width:100%" maxlength="18"></td>
                    <td align="center" class="creamBold">채권구분</td>
					<td class="padding2423">
						<input id="txtBOND_GBN" size="6" style="text-align:center;" onChange="fnc_GetCommNm('H3', 'txtBOND_GBN','txtBOND_GBN_NM');">
                        <input id="txtBOND_GBN_NM" size="14" class="input_ReadOnly" readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBOND_GBN','txtBOND_GBN_NM','채권내역','H3');">
                        </a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>상대처</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="258"></col>
					<col width="80"></col>
					<col width="130"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">명칭</td>
					<td class="padding2423"><input id="txtYOU_NM" style="width:100%" maxlength="30"></td>
                    <td align="center" class="creamBold">담당자</td>
					<td class="padding2423"><input id="txtYOU_MAN" style="width:100%" maxlength="15"></td>
                    <td align="center" class="creamBold">연락처</td>
					<td class="padding2423"><input id="txtYOU_TEL" style="width:100%" maxlength="18"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>채권현황</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="175"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">채권내용</td>
					<td class="padding2423"><input id="txtBOND_TXT" style="width:100%" maxlength="50"></td>
                    <td align="center" class="creamBold">금액(원)</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medBOND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=10>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">現회수액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medBOND_AC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=10>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                    <td align="center" class="creamBold">未회수액</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medBOND_NO_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=10>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>담보현황</strong></td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width="110"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">부동산근저당</td>
					<td class="padding2423" colspan="3"><input id="txtSEC_LAND" style="width:100%" maxlength="50"></td>
                    <td align="center" class="creamBold">질권</td>
					<td class="padding2423"><input id="txtSEC_PLED" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">보증보험</td>
					<td class="padding2423" colspan="3"><input id="txtSEC_GUAR" style="width:100%" maxlength="50"></td>
                    <td align="center" class="creamBold">현금예치</td>
					<td class="padding2423"><input id="txtSEC_CASH" style="width:100%" maxlength="50"></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">연대보증인1</td>
					<td class="padding2423"><input id="txtSEC_GUOR1" style="width:100%" maxlength="30"></td>
                    <td align="center" class="creamBold">연대보증인2</td>
					<td class="padding2423"><input id="txtSEC_GUOR2" style="width:100%" maxlength="30"></td>
                    <td align="center" class="creamBold">기타담보</td>
					<td class="padding2423"><input id="txtSEC_SO" style="width:100%" maxlength="30"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>직원제안란</strong></td>
		<td align="right" valign="bottom">※ 채권회수관련 정보입력 (예:채무자 재산, 거래은행 등)</td>
    </tr>
	<tr>
		<td colspan="2">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td class="padding2423" colspan="3">
						<textarea id=txtREMARK rows="3" cols="128" onkeyup="fc_chk_byte(this,450);"></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<br>

<!-- 탭 사용 컴퍼넌트 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">  
            
            <!-- 탭버튼데이블 시작 -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <td width="120"> 
                        <!-- 탭오버 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">진행사항</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td> 
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">예정사항</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td> 
                        <!-- 탭히든 -->
                        <table width="120" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">소송기록</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <td height="2" bgcolor="#A4A4A1"></td>
                </tr>
            </table>            
            <!-- 탭버튼테이블 끝 -->            
            
        </td>
    </tr>
</table>


<!-- 탭1 조건 입력 테이블 시작 -->
<div class=page id="tabLAWA010_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <tr>
	                    <td align="right" class="padding2423">

							<table width="800" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage1">&nbsp;</span></td>
									<td height="35" class="paddingTop5" align="right">
							            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend1','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append();return false;"></a>
							            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove1','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove();return false;"></a>
									</td>
								</tr>
							</table>
							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5">
								         <comment id="__NSID__">
								         <object    id="grd01T_LW_BONDHIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:228px;">
								             <param name="DataID"                  value="ds01T_LW_BONDHIST">
								             <param name="EdiTABLE"                value="true">
								             <param name="DragDropEnable"          value="true">
								             <param name="SortView"                value="Left">
								             <param name="VIEWSUMMARY"             value=0>
											 <param name="AutoReSizing"              value="true">
										  	 <param name=ColSizing  value="true">
								             <param name="Format"                  value="
												 <C> id='SEQ_NO'			width=50		name='순번'			align=center		edit='none'										</C>
								                 <C> id='HIS_YMD'		width=100		name='일자'			align=center			Edit='Numeric'		mask='XXXX-XX-XX'			</C>
								                 <C> id='HIS_CONT'		width=304		name='내용'			align=left 														</C>
								                 <C> id='HIS_AMT'		width=155		name='금액'			align=right 													</C>
								                 <C> id='HIS_RESU'		width=155		name='결과'			align=left 														</C>
								             ">
								         </object>
								         </comment><script> __ShowEmbedObject(__NSID__); </script>
							        </td>
							    </tr>
							</table>

	                    </td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>

</div>
<!-- 탭1 조건 입력 테이블 끝 -->

<!-- 탭2 조건 입력 테이블 시작 -->
<div class=page id="tabLAWA010_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:2; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <tr>
	                    <td align="right" class="padding2423">

							<table width="800" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="bottom" class="searchState"><span id="resultMessage2">&nbsp;</span></td>
									<td height="35" class="paddingTop5" align="right">
							            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend2','','/images/button/btn_InsertOver.gif',1)">  <img src="/images/button/btn_InsertOn.gif"   name="imgAppend2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append();return false;"></a>
							            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove2','','/images/button/btn_RemoveOver.gif',1)">  <img src="/images/button/btn_RemoveOn.gif"   name="imgRemove2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove();return false;"></a>
									</td>
								</tr>
							</table>
							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5">
								         <comment id="__NSID__">
								         <object    id="grd02T_LW_BONDHIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:228px;">
								             <param name="DataID"                  value="ds02T_LW_BONDHIST">
								             <param name="EdiTABLE"                value="true">
								             <param name="DragDropEnable"          value="true">
								             <param name="SortView"                value="Left">
								             <param name="VIEWSUMMARY"             value=0>
											 <param name="AutoReSizing"              value="true">
										  	 <param name=ColSizing  value="true">
								             <param name="Format"                  value="
												 <C> id='SEQ_NO'			width=50		name='순번'			align=center		edit='none'										</C>
								                 <C> id='HIS_YMD'		width=100		name='일자'			align=center			Edit='Numeric'		mask='XXXX-XX-XX'			</C>
								                 <C> id='HIS_CONT'		width=304		name='내용'			align=left 														</C>
								                 <C> id='HIS_AMT'		width=155		name='금액'			align=right 													</C>
								                 <C> id='HIS_RESU'		width=155		name='결과'			align=left														</C>
								             ">
								         </object>
								         </comment><script> __ShowEmbedObject(__NSID__); </script>
							        </td>
							    </tr>
							</table>

	                    </td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>

</div>
<!-- 탭2 조건 입력 테이블 끝 -->

<!-- 탭3 조건 입력 테이블 시작 -->
<div class=page id="tabLAWA010_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:1; visibility:hidden">

	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <tr>
	                    <td align="right" class="padding2423">

														<table width="800" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td height="35" class="paddingTop5" align="right">
										<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
											<colgroup>
												<col width="80"></col>
												<col width="133"></col>
												<col width="80"></col>
                                                <col width="300"></col>
                                                <col width="80"></col>
												<col width="*"></col>
											</colgroup>
											<tr>
							                    <td align="center" class="creamBold">소명(訴名)</td>
												<td class="padding2423"><input id="txtLAW_NM" style="width:100%" maxlength="50"></td>
							                    <td align="center" class="creamBold">사건번호</td>
												<td class="padding2423"><input id="txtLAW_NO" style="width:100%" maxlength="30"></td>
							                    <td align="center" class="creamBold">사건 구분</td>
												<td class="padding2423">
                                                    <select id="cmbLAW_GBN">
                                                        <option value=""></option>
                                                        <option value="L">제소</option>
                                                        <option value="A">피소</option>
                                                    </select>
                                                </td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
							            <strong>가압류</strong></td>
							    </tr>
								<tr>
									<td>
										<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
											<colgroup>
												<col width="80"></col>
												<col width="333"></col>
												<col width="80"></col>
												<col width="100"></col>
												<col width="80"></col>
												<col width=""></col>
											</colgroup>
											<tr>
							                    <td align="center" class="creamBold">보전처분</td>
												<td class="padding2423"><input id="txtLAW_B" style="width:100%" maxlength="40"></td>
							                    <td align="center" class="creamBold">기일</td>
												<td class="padding2423">
									        		<input id="txtDATE_B" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn5','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn5" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDATE_B','','475','594');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">소송비용</td>
												<td class="padding2423">
													<comment id="__NSID__"><object id="medCOST_B" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
														<param name=Alignment					value=2>
														<param name=Border						value=true>
														<param name=ClipMode					value=true>
														<param name=DisabledBackColor	value="#EEEEEE">
														<param name=Enable						value=true>
														<param name=IsComma					value=true>
														<param name=Language					value=0>
														<param name=MaxLength				value=10>
														<param name=Numeric					value=true>
														<param name=ShowLiteral				value="false">
														<param name=Visible						value="true">
													</object></comment><script> __ShowEmbedObject(__NSID__); </script>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
							            <strong>심급</strong></td>
							    </tr>
								<tr>
									<td>
										<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
											<colgroup>
												<col width="80"></col>
												<col width="333"></col>
												<col width="80"></col>
												<col width="100"></col>
												<col width="80"></col>
												<col width=""></col>
											</colgroup>
											<tr>
							                    <td align="center" class="creamBold">1심</td>
												<td class="padding2423"><input id="txtLAW_1" style="width:100%" maxlength="40"></td>
							                    <td align="center" class="creamBold">기일</td>
												<td class="padding2423">
									        		<input id="txtDATE_1" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn6" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDATE_1','','475','462');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">소송비용</td>
												<td class="padding2423">
													<comment id="__NSID__"><object id="medCOST_1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
														<param name=Alignment					value=2>
														<param name=Border						value=true>
														<param name=ClipMode					value=true>
														<param name=DisabledBackColor	value="#EEEEEE">
														<param name=Enable						value=true>
														<param name=IsComma					value=true>
														<param name=Language					value=0>
														<param name=MaxLength				value=10>
														<param name=Numeric					value=true>
														<param name=ShowLiteral				value="false">
														<param name=Visible						value="true">
													</object></comment><script> __ShowEmbedObject(__NSID__); </script>
												</td>
											</tr>
											<tr>
							                    <td align="center" class="creamBold">2심</td>
												<td class="padding2423"><input id="txtLAW_2" style="width:100%" maxlength="40"></td>
							                    <td align="center" class="creamBold">기일</td>
												<td class="padding2423">
									        		<input id="txtDATE_2" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn7','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn7" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDATE_2','','475','488');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">소송비용</td>
												<td class="padding2423">
													<comment id="__NSID__"><object id="medCOST_2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
														<param name=Alignment					value=2>
														<param name=Border						value=true>
														<param name=ClipMode					value=true>
														<param name=DisabledBackColor	value="#EEEEEE">
														<param name=Enable						value=true>
														<param name=IsComma					value=true>
														<param name=Language					value=0>
														<param name=MaxLength				value=10>
														<param name=Numeric					value=true>
														<param name=ShowLiteral				value="false">
														<param name=Visible						value="true">
													</object></comment><script> __ShowEmbedObject(__NSID__); </script>
												</td>
											</tr>
											<tr>
							                    <td align="center" class="creamBold">3심</td>
												<td class="padding2423"><input id="txtLAW_3" style="width:100%" maxlength="40"></td>
							                    <td align="center" class="creamBold">기일</td>
												<td class="padding2423">
									        		<input id="txtDATE_3" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn8','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn8" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDATE_3','','475','513');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">소송비용</td>
												<td class="padding2423">
													<comment id="__NSID__"><object id="medCOST_3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
														<param name=Alignment					value=2>
														<param name=Border						value=true>
														<param name=ClipMode					value=true>
														<param name=DisabledBackColor	value="#EEEEEE">
														<param name=Enable						value=true>
														<param name=IsComma					value=true>
														<param name=Language					value=0>
														<param name=MaxLength				value=10>
														<param name=Numeric					value=true>
														<param name=ShowLiteral				value="false">
														<param name=Visible						value="true">
													</object></comment><script> __ShowEmbedObject(__NSID__); </script>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
							            <strong>가처분</strong></td>
							    </tr>
								<tr>
									<td>
										<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
											<colgroup>
												<col width="80"></col>
												<col width="333"></col>
												<col width="80"></col>
												<col width="100"></col>
												<col width="80"></col>
												<col width=""></col>
											</colgroup>
											<tr>
							                    <td align="center" class="creamBold">강제처분</td>
												<td class="padding2423"><input id="txtLAW_A" style="width:100%" maxlength="40"></td>
							                    <td align="center" class="creamBold">기일</td>
												<td class="padding2423">
									        		<input id="txtDATE_A" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn9','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn9" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDATE_A','','475','558');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">소송비용</td>
												<td class="padding2423">
													<comment id="__NSID__"><object id="medCOST_A" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
														<param name=Alignment					value=2>
														<param name=Border						value=true>
														<param name=ClipMode					value=true>
														<param name=DisabledBackColor	value="#EEEEEE">
														<param name=Enable						value=true>
														<param name=IsComma					value=true>
														<param name=Language					value=0>
														<param name=MaxLength				value=10>
														<param name=Numeric					value=true>
														<param name=ShowLiteral				value="false">
														<param name=Visible						value="true">
													</object></comment><script> __ShowEmbedObject(__NSID__); </script>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

							<table width="800" border="0" cellspacing="0" cellpadding="0">
							    <tr>
							        <td class="paddingTop5" style="width:78"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
							            <strong>당사자</strong></td>
							        <td class="paddingTop5"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
							            <strong>불변기일</strong></td>
							    </tr>
								<tr>
									<td colspan="3">
										<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
											<colgroup>
												<col width="80"></col>
												<col width="122"></col>
												<col width="80"></col>
												<col width="122"></col>
												<col width="80"></col>
												<col width="100"></col>
												<col width="80"></col>
												<col width=""></col>
											</colgroup>
											<tr>
							                    <td align="center" class="creamBold">원고</td>
												<td class="padding2423"><input id="txtWANT_MAN" style="width:100%" maxlength="30"></td>
							                    <td align="center" class="creamBold">피고</td>
												<td class="padding2423"><input id="txtDEFE_MAN" style="width:100%" maxlength="30"></td>
							                    <td align="center" class="creamBold">항소</td>
												<td class="padding2423">
									        		<input id="txtAPP_DATE" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn10" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_DATE','','475','604');return false;"></a>
												</td>
							                    <td align="center" class="creamBold">상고</td>
												<td class="padding2423">
									        		<input id="txtFIN_DATE" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
							                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn11" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtFIN_DATE','','662','604');return false;"></a>
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

</div>
<!-- 탭3 조건 입력 테이블 끝 -->

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component 선언부(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 저장 및 조회용 Bind                                               |
    | 2. 이름 : bndT_LW_BONDLIST                                   |
    | 3. Table List : T_LW_BONDLIST                                 |
    +----------------------------------------------->
	<object id="bndT_LW_BONDLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_LW_BONDLIST">
		<Param Name="BindInfo", Value="
			<C>Col='ORD_NO'						Ctrl='txtORD_NO'						Param=value</C>
			<C>Col='COUNT_NUM'						Ctrl='txtCOUNT_NUM'						Param=value</C>
			<C>Col='EVENT_NM'						Ctrl='txtEVENT_NM'					Param=value</C>
			<C>Col='HEAD_CD'						Ctrl='txtHEAD_CD'						Param=value</C>
			<C>Col='HEAD_NM'						Ctrl='txtHEAD_NM'						Param=value</C>
			<C>Col='DPT_CD'							Ctrl='txtDPT_CD'						Param=value</C>
			<C>Col='DPT_NM'							Ctrl='txtDPT_NM'						Param=value</C>
			<C>Col='ORD_YMD'						Ctrl='txtORD_YMD'						Param=value</C>
			<C>Col='ORD_MAN'						Ctrl='txtORD_MAN'						Param=value</C>
			<C>Col='ORD_TEL'						Ctrl='txtORD_TEL'						Param=value</C>
			<C>Col='YOU_NM'						Ctrl='txtYOU_NM'						Param=value</C>
			<C>Col='YOU_MAN'						Ctrl='txtYOU_MAN'						Param=value</C>
			<C>Col='YOU_TEL'						Ctrl='txtYOU_TEL'						Param=value</C>
			<C>Col='BOND_GBN'					Ctrl='txtBOND_GBN'					Param=value</C>
			<C>Col='BOND_GBN_NM'				Ctrl='txtBOND_GBN_NM'			Param=value</C>
			<C>Col='BOND_AMT'					Ctrl='medBOND_AMT'				Param=text	</C>
			<C>Col='BOND_AC_AMT'				Ctrl='medBOND_AC_AMT'			Param=text	</C>
			<C>Col='BOND_TXT'						Ctrl='txtBOND_TXT'					Param=value</C>
			<C>Col='SEC_LAND'						Ctrl='txtSEC_LAND'					Param=value</C>
			<C>Col='SEC_PLED'						Ctrl='txtSEC_PLED'					Param=value</C>
			<C>Col='SEC_GUAR'						Ctrl='txtSEC_GUAR'					Param=value</C>
			<C>Col='SEC_CASH'						Ctrl='txtSEC_CASH'					Param=value</C>
			<C>Col='SEC_GUOR1'					Ctrl='txtSEC_GUOR1'					Param=value</C>
			<C>Col='SEC_GUOR2'					Ctrl='txtSEC_GUOR2'					Param=value</C>
			<C>Col='SEC_SO'							Ctrl='txtSEC_SO'						Param=value</C>
			<C>Col='LAW_NM'						Ctrl='txtLAW_NM'						Param=value</C>
			<C>Col='LAW_NO'							Ctrl='txtLAW_NO'						Param=value</C>
			<C>Col='LAW_B'							Ctrl='txtLAW_B'							Param=value</C>
			<C>Col='LAW_1'							Ctrl='txtLAW_1'							Param=value</C>
			<C>Col='LAW_2'							Ctrl='txtLAW_2'							Param=value</C>
			<C>Col='LAW_3'							Ctrl='txtLAW_3'							Param=value</C>
			<C>Col='LAW_A'							Ctrl='txtLAW_A'							Param=value</C>
			<C>Col='LAW_GBN'						Ctrl='cmbLAW_GBN'						Param=value</C>
			<C>Col='WANT_MAN'					Ctrl='txtWANT_MAN'					Param=value</C>
			<C>Col='DEFE_MAN'						Ctrl='txtDEFE_MAN'					Param=value</C>
			<C>Col='DATE_B'							Ctrl='txtDATE_B'						Param=value</C>
			<C>Col='DATE_1'							Ctrl='txtDATE_1'							Param=value</C>
			<C>Col='DATE_2'							Ctrl='txtDATE_2'							Param=value</C>
			<C>Col='DATE_3'							Ctrl='txtDATE_3'							Param=value</C>
			<C>Col='DATE_A'							Ctrl='txtDATE_A'						Param=value</C>
			<C>Col='COST_B'							Ctrl='medCOST_B'					Param=text	</C>
			<C>Col='COST_1'							Ctrl='medCOST_1'					Param=text	</C>
			<C>Col='COST_2'							Ctrl='medCOST_2'					Param=text	</C>
			<C>Col='COST_3'							Ctrl='medCOST_3'					Param=text	</C>
			<C>Col='COST_A'							Ctrl='medCOST_A'					Param=text	</C>
			<C>Col='APP_DATE'						Ctrl='txtAPP_DATE'					Param=value</C>
			<C>Col='FIN_DATE'						Ctrl='txtFIN_DATE'						Param=value</C>
			<C>Col='REMARK'							Ctrl='txtREMARK'						Param=value</C>
			<C>Col='END_YN'							Ctrl='txtEND_YN'						Param=value</C>
	    ">
	</object>

