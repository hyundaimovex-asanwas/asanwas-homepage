<!--*************************************************************************
* @source      : eisc010.jsp                                                *
* @description : 화상조직도 PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/05/02            조정호             최초작성                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.upload.pds");
	String SESSION_HEADCD = box.getString("SESSION_HEADCD");         //헤드코드
	String SESSION_ROLE_CD = box.getString("SESSION_ROLE_CD");         //롤코드
	String SESSION_DUTYCD = box.getString("SESSION_DUTYCD");         //직책코드
	String SESSION_DPTCD = box.getString("SESSION_DPTCD");         //부서코드
%>

<html>
<head>
    <title>화상조직도(eisc010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   자바스크립트 함수 선언부분                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장(처리)
                    + "T"   //취소
                    + "F"   //엑셀
                    + "F"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.eis.c.eisc010.cmd.EISC010CMD";
        var params = null;


        /********************************************
         * 01. 조회 함수_List 형태의 조회                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&DEPTH_NO="+depth_no
                   + "&ENO_NO="+selectENO_NO
                   + "&COUNT_REM="+selectCOUNT_REM
                   + "&DPT_CD="+selectDPT_CD
                   + "&HEAD_CD="+selectHEAD_CD
                   + "&TEAM_CD="+selectTEAM_CD;
			//alert(params);
            trT_CM_PERSON.KeyValue = "SHR"
                                   + "(O:dsT_CM_PERSON=dsT_CM_PERSON"
                                   + ",O:dsT_CM_PERSON2=dsT_CM_PERSON2"
                                   + ")";
            trT_CM_PERSON.action = dataClassName+params;
            trT_CM_PERSON.post();
        }

        /********************************************
         * 02. 조회 함수_Item 형태의 조회                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. 저장 함수                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. 삭제 함수                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. 인쇄 함수                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. 엑셀 저장 함수                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CM_PERSON.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }
            form1.grdT_CM_PERSON.GridToExcel("화상조직도", '', 225);
        }

        /********************************************
         * 07. 신규 함수                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. 추가 함수                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. 제거 함수                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. 초기화 함수                           *
         ********************************************/
        function fnc_Clear() {
            dsT_CM_PERSON.ClearData();
            dsT_CM_PERSON2.ClearData();

            //화상조직도 시작 Depth 1(사장)부터 시작
            depth_no = 1;

            //화상조직도에서 전 Depth의 사번을 저장 시켜 놓음
            depth_eno_no = new Array();
            depth_count_rem = new Array();

            selectENO_NO = "";
            selectDPT_CD = "";
            selectCOUNT_REM = "";
            selectHEAD_CD = "";
            selectTEAM_CD = "";

            fnc_SearchList();
        }

        /********************************************
         * 11. 화면 종료(닫기)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. 검색 조건 유효성 검사                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. 저장 유효성 체크                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //시작하면서 리스트를 조회해 옴
            fnc_SearchList();
        }

        /********************************************
         * 15. 단축키 처리                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form이 Active 될 때 처리 할 일          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * 기타 함수              *
         ********************************************/

        //화상조직도 시작 Depth 1(사장)부터 시작
        var depth_no = 1;

        //화상조직도에서 전 Depth의 사번을 저장 시켜 놓음
        var depth_eno_no = new Array();
        var depth_count_rem = new Array();

        var selectENO_NO = "";
        var selectDPT_CD = "";
        var selectCOUNT_REM = "";
        var selectHEAD_CD = "";
        var selectTEAM_CD = "";


        /*************************************************************************
         * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
         * - usage : var obj = new Image(이미지테그의ID);
         *               obj.setImage("서버의 이미지파일의 위치및 파일명");
         *************************************************************************/
        function Image(imgTag) {
            var imgTag = imgTag;
            var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";
            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        /**
         * 한단계 위로 올라갈때 사용
         */
        function upperEno_box() {
            if(depth_no > 1) {
                depth_no--;

                selectENO_NO    = depth_eno_no[depth_no-1];
                selectCOUNT_REM = depth_count_rem[depth_no-1];

                fnc_SearchList();
            }
        }

        /**
         * 한단계 내려 갈때 사용
         */
        function lowerEno_box() {

            //필요한 변수들을 가지고옴 (ENO_NO, DPT_CD, COUNT_REM, DUTY_CD, HEAD_CD, TEAM_CD)
            var eno_params = this.name.split(":");


/*
			if(depth_no == "2"){
				if( "1001" == "<%=SESSION_ROLE_CD%>" || "1002" == "<%=SESSION_ROLE_CD%>" || "<%=SESSION_DUTYCD%>" == "B0" || "<%=SESSION_DUTYCD%>" == "B1" || "<%=SESSION_DUTYCD%>" == "B2" || "<%=SESSION_DUTYCD%>" == "B5" || "<%=SESSION_HEADCD%>" ==eno_params[4]){

				}else{
					alert("같은 본부소속 인원만 조회할수있습니다");
					return ;
				}

			}


			if(depth_no == "2"){
				if( eno_params[3] == "04" ){
					if( eno_params[0] != "2090012" ){
						alert("담당중역입니다. 본부장을 클릭해야 부서장을 조회할수있습니다");
						return ;
					}
				}
			}
			*/
			//alert(depth_no);
			//alert(eno_params[1]);

			if(depth_no == "3" && eno_params[2] == "A600"){
				if( eno_params[0] == "1990027" || eno_params[0] == "1990099" || eno_params[0] == "1990030" ||
					eno_params[0] == "2030003" || eno_params[0] == "1990072" || eno_params[0] == "1990036" ||
					eno_params[0] == "1990041" || eno_params[0] == "1990104" || eno_params[0] == "2030009"){
					return ;
				}
			}else if(depth_no == "3" && eno_params[1] == "A490"){
				if( eno_params[0] == "2040026" || eno_params[0] == "2130006" || eno_params[0] == "2150006" || eno_params[0] == "2030032"||
					eno_params[0] == "2070016" || eno_params[0] == "2110005"  || eno_params[0] == "2050023"){
						return ;
					}
			}else if(depth_no == "3" && (eno_params[1] == "E760"||eno_params[1] == "E770" ||eno_params[1] == "I500" ||eno_params[1] == "E400" ||
					eno_params[1] == "I900" ) ){

						return ;

			}else if(depth_no == "4" && ( eno_params[1] == "J000" ||eno_params[1] == "G230" ||eno_params[1] == "C100"||eno_params[1] == "C180"||eno_params[1] == "C200"||eno_params[1] == "C280"||eno_params[1] == "C800"||
					eno_params[1] == "E700" ||eno_params[1] == "I600" ||eno_params[1] == "G240" ||eno_params[1] == "G250"||eno_params[1] == "I730"||eno_params[1] == "I600") ){

						return ;

			}


			//alert("길이 [" + eno_params.length + "]");
            //시작이 1일 경우만 depth array 초기화
            if(depth_no == 1) {
                depth_eno_no[depth_no-1]    = dsT_CM_PERSON.NameString(1, "ENO_NO");
                depth_count_rem[depth_no-1] = dsT_CM_PERSON.NameString(1, "COUNT_REM");
            }

            //4가 맨 마지막 더 내려 갈 수 없음
			//alert("depth_no [" + depth_no + "]");
            if(depth_no < 5 || (depth_no == 5 && eno_params[2] == "L5")) {
                //한단계 올라가기 위한 사번 저장
                depth_eno_no[depth_no]    = eno_params[0];
                depth_count_rem[depth_no] = eno_params[1];

                depth_no++;

                selectENO_NO    = eno_params[0];
                selectDPT_CD   = eno_params[1];
                selectCOUNT_REM = eno_params[2];
                selectHEAD_CD  = eno_params[4];
                selectTEAM_CD   = eno_params[5];

                fnc_SearchList();
            }

        }

        /**
         * 이미지 로드가 실패 했을 경우 발생 이벤트
         */
        function imgError() {
            this.src = "/images/common/none.jpg";
        }

        /**
         * 이미지 박스테이블을 생성시켜 반환
         * @param dataset - DB 에서 조회해 온 사원
         * @param row - 사원 리스트중 해당 사원 row count
         * @param type - 이미지를 선택시 올라갈것인지 내려갈것인지 결정 (upper, lower)
         */
        function createEno_box(dataset, row, type) {
            var oTable = document.createElement("table");
            var oRow;
            var oCell;
            var oImg;
            var oBtn;
            var imgBox;

            //box table 설정
            oTable.width        = "160";
            oTable.border       = "1";
            oTable.cellSpacing  = "0";
            oTable.cellPadding  = "0";
            oTable.borderColor  = "#999999";
            oTable.style.borderCollapse = "collapse";

            //first Row Img
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.align     = "center"
            oCell.height    = "180";
            oCell.colSpan   = "2";

            //이미지를 만듭시다.
            oImg = document.createElement("img");


            //이미지를 DB에서 가져옴
            var FILEURL = "<%=FILEURL%>" + "/" + dataset.NameString(row, "ENO_NO") + ".jpg";
            imgBox = new Image(oImg);
            imgBox.setImage(FILEURL)

            //이미지의 속성은 setImage선언아래쪽에 있어야 적용된다.
            oImg.width      = "125"
            oImg.height     = "167"
            oImg.border     = "0";


			//alert(dataset.NameString(row, "COUNT_REM"));

            //필요한 값들을 name 속성에 밀어 넣는다.
            oImg.name = dataset.NameString(row, "ENO_NO")
                      + ":" + dataset.NameString(row, "DPT_CD")
                      + ":" + dataset.NameString(row, "COUNT_REM")
                      + ":" + dataset.NameString(row, "DUTY_CD")
                      + ":" + dataset.NameString(row, "HEAD_CD")
                      + ":" + dataset.NameString(row, "TEAM_CD");

            //link event 만듬
            if(type == "upper") oImg.onclick = upperEno_box;
            else                oImg.onclick = lowerEno_box;

            oImg.onerror = imgError;

            oCell.appendChild(oImg);

            //각 내역 가져오기
            var colNames = new Array("ENO_NM","DPT_NM","TEAM_NM","DUTY_NM");
            var colDesc  = new Array("성&nbsp;&nbsp;명","소&nbsp;&nbsp;속","팀&nbsp;&nbsp;명","직&nbsp;&nbsp;책");
            var isHEAD_NM = false;
            for(var i=0; i<colNames.length; i++) {
                oRow  = oTable.insertRow();
                oCell = oRow.insertCell();
                oCell.width = "50";
                oCell.align = "center";
                oCell.className = "creamBold";
                oCell.innerHTML = colDesc[i];

                oCell = oRow.insertCell();
                oCell.className = "padding2423";
                oCell.innerHTML = dataset.NameString(row, colNames[i]);
            }



		//권한이 IT이거나 인재지원부, 본부장인 사람은 인사정보 모두 조회
		<%
		    if(box.getString("SESSION_ROLE_CD").equals("1001") || box.getString("SESSION_ROLE_CD").equals("1002")
		    		|| box.getString("SESSION_ROLE_CD").equals("2021"))  {
		%>


            //인사정보 내역 보기 버튼 만들기
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.colSpan   = "2";

            oBtn = document.createElement("input");
            oBtn.type   = "button";
            oBtn.value  = "인사정보보기";
            oBtn.name   = dataset.NameString(row, "ENO_NO");   //name 속성에 사번을 넣음
            oBtn.style.width = "160px";
            oBtn.onclick = viewEnoInfo;

            oCell.appendChild(oBtn);


		<%
		    }
		%>


		//권한이 부서장인 사람은 부서원의 인사정보 조회
		<%
		    if(box.getString("SESSION_ROLE_CD").equals("2022"))  {
		%>


		if(dataset.NameString(row, "DPT_CD") ==  "<%=SESSION_DPTCD%>"){

            //부서원의 인사정보 내역 보기 버튼 만들기
            oRow  = oTable.insertRow();
            oCell = oRow.insertCell();
            oCell.colSpan   = "2";

            oBtn = document.createElement("input");
            oBtn.type   = "button";
            oBtn.value  = "부서원정보보기";
            oBtn.name   = dataset.NameString(row, "ENO_NO");   //name 속성에 사번을 넣음
            oBtn.dpt   = dataset.NameString(row, "DPT_CD");   //name 속성에 소속을 넣음
            oBtn.style.width = "160px";
            oBtn.onclick = viewEnoInfo_Dpt;

            oCell.appendChild(oBtn);

			}

		<%
		    }
		%>

            return oTable;
        }

        /**
         * 해당 소속의 소속사원 리스트를 조회함
         * @param oTarget - 넣을곳 Object
         * @param dataset - DB 에서 조회해 온 사원 리스트
         */
        function fnc_BindingEno_box(oTarget, dataset) {
            var oTable = document.createElement("table");
            var oRow;
            var oCell;

            oTarget.appendChild(oTable);

            //box table 설정
            oTable.border       = "0";
            oTable.cellSpacing  = "0";
            oTable.cellPadding  = "10";

            oRow  = oTable.insertRow();

            for(var i=1; i<dataset.CountRow; i++) {
                oCell = oRow.insertCell();
                oCell.vAlign = "top";
                oCell.appendChild(createEno_box(dataset, i, "lower"));
            }
        }

        /**
         * 인사정보 보기 Event Handler
         */
        function viewEnoInfo() {
            var url = "";
            var data = new String();

            data.eno_no     = this.name;
            data.mode       = "read";
            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
        }

        /**
         * 부서원 인사정보 보기 Event Handler
         */
        function viewEnoInfo_Dpt() {

            var url = "";
            var data = new String();

            data.eno_no     = this.name;
            data.dpt_cd     = this.dpt;
            data.mode       = "read";

            //dsT_CM_PERSON_DPT.DataId = "/servlet/GauceChannelSVL?cmd=hr.eis.c.eisc010.cmd.EISC010CMD&S_MODE=SHR_DPT&ENO_NO="+data.eno_no+"&DPT_CD="+data.dpt_cd;
			//prompt(this, dsT_CM_PERSON_DPT.DataId);
            //dsT_CM_PERSON_DPT.Reset();

			if(data.dpt_cd != "<%=SESSION_DPTCD%>"){
				alert("소속 부서의 인원 정보만 보여집니다.");
				return false;
			}

            url = "/hr/pir/pirc010.jsp";

            window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>

    <Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>

    <Object ID="dsT_CM_PERSON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>
    <!-----------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton                       |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직                  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        var target = document.getElementById("TARGET_ENO");
        fnc_RemoveChild(target);//해당 Element의 Child Node를 모두 제거
        target.appendChild(createEno_box(dsT_CM_PERSON, 1, "upper"));
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">
        var target = document.getElementById("TARGET_ENO_LIST");
        fnc_RemoveChild(target);//해당 Element의 Child Node를 모두 제거
        fnc_BindingEno_box(target, dsT_CM_PERSON2)
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직            |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때     |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful 처리                          |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure 처리                             |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>




    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- 파일 전송을 위해 -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

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
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">화상조직도</td>
                    <td align="right" class="navigator">HOME/경영정보/인원현황(EIS)/<font color="#000000">화상조직도</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- 대상자 보여주기 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="250" align="center" valign="top">
                <table width="90%" border="3" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <tr>
                    <td><b>[화상조직도사용법]</b><br>
                    &nbsp;해당하는 사원의 사진을 클릭하면 상위 혹은 하위 소속의 직원 정보를 조회하실 수 있습니다.
                    </td>
                </tr>
                </table>
            </td>
            <td align="center" id="TARGET_ENO">

            </td>
            <td width="250"></td>
        </tr>
    </table>
    <!-- 대상자 보여주기 -->

    <br>

    <!-- 대상자에 속해 있는 사원들 보여주기 -->
    <div id="TARGET_ENO_LIST" style="width:800px; height:340; z-index:1; overflow-x:auto;" align="center">
    </div>
    <!-- 대상자에 속해 있는 사원들 보여주기 -->

    </form>
    <!-- form 끝 -->

</body>
</html>


<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->