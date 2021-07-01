<!--
***********************************************************************
* @source      : approver.jsp
* @description : 결재자정보조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/13      오대성        최초작성.
* 2006/11/22      한학현        엔터이벤트 추가.
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
    <title>결재자정보조회(approver)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var retObj = window.dialogArguments;

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'F' + 'F' + 'F' + 'F' + 'T';
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            
            //데이터셋 전송
            dsT_CM_PERSON.DataID = "/servlet/GauceChannelSVL?cmd=common.empl.cmd.EMPLCMD&S_MODE=SHR"
                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
                                 + "&DPT_CD="+document.getElementById("txtDPT_CD_SHR").value
                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
                                 ;
            dsT_CM_PERSON.reset();
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {


        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            // 엑셀로 변환 할 자료가 있는지 체크하고

            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합

            // Pow Append 후 Grid에 Append된 Row의 특정 Column으로 이동하는거

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            // 삭제 할 자료가 있는지 체크하고

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)

            // 삭제 후 해당 그리드로 Focus 이동

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            //이곳에 해당 코딩을 입력 하세요

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            window.close();

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


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style 적용
            
            //넘어온 사번과 구분을 저장하고
            document.getElementById("txtENO_NO").value      = retObj.eno_no;
            document.getElementById("hidGBN_CD").value      = retObj.gbn_cd;
            document.getElementById("hidRET_CD").value      = retObj.ret_cd;
            document.getElementById("hidSTR_YMD").value     = retObj.str_ymd;
            document.getElementById("hidEND_YMD").value     = retObj.end_ymd;
            
            //넘어온 사번으로 사원정보 검색
            var enoObj = fnc_GetCommonEnoNm("txtENO_NO", "", "", "", "");
            if(enoObj == null || enoObj.eno_no == "") {
                alert("신청자 정보가 없습니다.");
                window.close();
                return;
            }
            
            //검색조건(소속)지정
            if(retObj.dpt_cd != "") {
                document.getElementById("txtDPT_CD_SHR").value  = retObj.dpt_cd;
                fnc_GetCommNm('A4', "txtDPT_CD_SHR", "txtDPT_NM_SHR");
            } else {
                document.getElementById("txtDPT_CD_SHR").value  = enoObj.dpt_cd;
                document.getElementById("txtDPT_NM_SHR").value  = enoObj.dpt_nm;
            }
            
            //신청자 정보 추가
            document.getElementById("lblJOB_NM_A2").innerText   = enoObj.job_nm;
            document.getElementById("lblENO_NO_A2").innerText   = enoObj.eno_no;
            document.getElementById("lblENO_NM_A2").innerText   = enoObj.eno_nm;
            
            //신청자 정보 저장
            document.getElementById("txtENO_NO").value      = enoObj.eno_no;
            document.getElementById("txtENO_NM").value      = enoObj.eno_nm;
            document.getElementById("txtDPT_CD").value      = enoObj.dpt_cd;
            document.getElementById("txtDPT_NM").value      = enoObj.dpt_nm;
            document.getElementById("txtJOB_CD").value      = enoObj.job_cd;
            document.getElementById("txtJOB_NM").value      = enoObj.job_nm;
            
            
            //반환할 값 초기화
            retObj.eno_no   = "";
            retObj.eno_nm   = "";
            retObj.occ_cd   = "";
            retObj.occ_nm   = "";
            retObj.dpt_cd   = "";
            retObj.dpt_nm   = "";
            retObj.job_cd   = "";
            retObj.job_nm   = "";
            retObj.head_cd  = "";
            retObj.head_nm  = "";
            retObj.cet_no   = "";
            retObj.hir_ymd  = "";
            retObj.mf_tag   = "";
            
            fnc_SearchList();
        }
        
        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        /**
         * 결재자를 선정한 후 확인을 누르면 결재자정보가 넘어감
         * (결재자가 없으면 신청자가 결재자로 넘어감)
         */
        function fnc_Confirm() {
            if(document.getElementById('txtENO_NO').value == "") {
                alert("결재자를 선택해 주세요.");
                return;
            }
            retObj.eno_no = document.getElementById('txtENO_NO').value;
            retObj.eno_nm = document.getElementById('txtENO_NM').value;
            retObj.dpt_cd = document.getElementById('txtDPT_CD').value;
            retObj.dpt_nm = document.getElementById('txtDPT_NM').value;
            retObj.job_cd = document.getElementById('txtJOB_CD').value;
            retObj.job_nm = document.getElementById('txtJOB_NM').value;
            
            window.close();
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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("검색하신 조건의 자료가 없습니다.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        document.getElementById('txtENO_NO').value  = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById('txtENO_NM').value  = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        document.getElementById('txtDPT_CD').value  = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        document.getElementById('txtDPT_NM').value  = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        document.getElementById('txtJOB_CD').value  = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        document.getElementById('txtJOB_NM').value  = dsT_CM_PERSON.NameValue(row,'JOB_NM');

        //결재자 정보 추가
        document.getElementById("lblJOB_NM_A1").innerText   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        document.getElementById("lblENO_NO_A1").innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById("lblENO_NM_A1").innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        document.getElementById('txtENO_NO').value  = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById('txtENO_NM').value  = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        document.getElementById('txtDPT_CD').value  = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        document.getElementById('txtDPT_NM').value  = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        document.getElementById('txtJOB_CD').value  = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        document.getElementById('txtJOB_NM').value  = dsT_CM_PERSON.NameValue(row,'JOB_NM');

        //결재자 정보 추가
        document.getElementById("lblJOB_NM_A1").innerText   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        document.getElementById("lblENO_NO_A1").innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        document.getElementById("lblENO_NM_A1").innerText   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- form 시작 -->
    <form name="form1">

    <!-- 타이틀 바 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">결재자정보조회</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 타이틀 바 테이블 끝 -->

    <!-- 버튼 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">사원 번호/성명&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="10" maxlength="10" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
                                        <input type="text" style="display:none">
                                        
                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">
                                        
                                        <input type="hidden" id="txtENO_NO">
                                        <input type="hidden" id="txtENO_NM">
                                        <input type="hidden" id="txtDPT_CD">
                                        <input type="hidden" id="txtDPT_NM">
                                        <input type="hidden" id="txtJOB_CD">
                                        <input type="hidden" id="txtJOB_NM">
                                    </td>
                                    
                                    <td align="center" class="searchState">소속&nbsp;</td>
                                    <td class="padding2423">
                                        <input name=txtDPT_CD_SHR size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                        <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                        <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->

    <!-- 내용 조회 그리드 테이블 시작-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:160px;">
                                <param name="DataID"            value="dsT_CM_PERSON">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=본부   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=소속   align=left   </C>
                                    <C> id=JOB_NM            width=80   name=직위   align=left   </C>
                                    <C> id=ENO_NO            width=80   name=사번   align=center </C>
                                    <C> id=ENO_NM            width=80   name=성명   align=center </C>
                                '>
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 내용 조회 그리드 데이블 끝-->

    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="60"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="70"></col>
                        <col width="50"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">결재자</td>
                        <td align="center" class="creamBold">직위</td>
                        <td class="padding2423" id="lblJOB_NM_A1"></td>
                        <td align="center" class="creamBold">사번</td>
                        <td class="padding2423" id="lblENO_NO_A1"></td>
                        <td align="center" class="creamBold">성명</td>
                        <td class="padding2423" id="lblENO_NM_A1"></td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">신청자</td>
                        <td align="center" class="creamBold">직위</td>
                        <td class="padding2423" id="lblJOB_NM_A2"></td>
                        <td align="center" class="creamBold">사번</td>
                        <td class="padding2423" id="lblENO_NO_A2"></td>
                        <td align="center" class="creamBold">성명</td>
                        <td class="padding2423" id="lblENO_NM_A2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="paddingTop8" align="center">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_ConfirmOver.gif',1)"><img src="/images/button/btn_ConfirmOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Confirm()"></a>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->
    
    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">* 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->
    
    </form>
    <!-- form 끝 -->

</body>
</html>