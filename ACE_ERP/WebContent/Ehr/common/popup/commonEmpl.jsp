<!--
***********************************************************************
* @source      : commonEmpl.jsp
* @description : 사원정보조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/04/28            이동훈            	ERP 이사									 *
***********************************************************************
-->

<%@ page contentType="text/html;charset=euc-kr"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>

    <head>
    <title>사원정보조회(commonEmpl)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/result.js"></script>	    
    <script language=javascript src="../../common/common.js"></script>
    <script language="javascript" src="../../common/calendar/calendar.js"></script>
    <base target="_self">
    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

    
        var retObj = window.dialogArguments;
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송

            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.common.empl.cmd.EMPLCMD&S_MODE=SHR00"
									                                 + "&ENO_NO="+document.getElementById("txtENO_NO_SHR").value
									                                 + "&DPT_CD="+document.getElementById("hidEMPL_DPT_CD").value
									                                 + "&GBN_CD="+document.getElementById("hidGBN_CD").value
									                                 + "&RET_CD="+document.getElementById("hidRET_CD").value
									                                 + "&STR_YMD="+document.getElementById("hidSTR_YMD").value
									                                 + "&END_YMD="+document.getElementById("hidEND_YMD").value
									                                 ;
            
            //prompt(this, dsT_CM_PERSON.DataID);
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

            cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","right");      // Grid Style 적용

            document.getElementById("txtENO_NO_SHR").value  = retObj.eno_nm;
            document.getElementById("hidEMPL_DPT_CD").value = retObj.dpt_cd;
            document.getElementById("hidGBN_CD").value      = retObj.gbn_cd;
            document.getElementById("hidRET_CD").value      = retObj.ret_cd;
            document.getElementById("hidSTR_YMD").value     = retObj.str_ymd;
            document.getElementById("hidEND_YMD").value     = retObj.end_ymd;

            if (retObj.eno_nm != "") {
                fnc_SearchList();
            }else{//넘어온 데이터가 없으면 포커스가 검색단으로 간다. 
                document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus
            }


            //반환할 데이타 초기화
            retObj.eno_no ='';
            retObj.eno_nm ='';
            retObj.occ_cd ='';
            retObj.occ_nm ='';
            retObj.dpt_cd ='';
            retObj.dpt_nm ='';
            retObj.job_cd = '';
            retObj.job_nm = '';
            retObj.head_cd = '';
            retObj.head_nm = '';
            retObj.cet_no  = '';
            retObj.mf_tag  = '';
            retObj.hirg_ymd = '';
            retObj.hir_ymd  = '';
            retObj.ret_ymd  = '';
            retObj.ram_ymd  = '';
            retObj.ram_ymd2 = '';
            retObj.ram_ymd3 = '';
            retObj.dpa_ymd  = '';
            retObj.mid_ymd1 = '';
            retObj.mid_ymd2 = '';
            retObj.mid_ymd3 = '';
            retObj.hirr_ymd = '';
        }
        
        /********************
         * 15. 단축키 처리  *
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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        		Value="True">
        <Param Name="UseChangeInfo"   	Value="True">
        <Param Name="ViewDeletedRow"  	Value="False">
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

            //fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus

        } else {

            //fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        retObj.occ_cd   = dsT_CM_PERSON.NameValue(row,'OCC_CD');
        retObj.occ_nm   = dsT_CM_PERSON.NameValue(row,'OCC_NM');
        retObj.dpt_cd   = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        retObj.dpt_nm   = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        retObj.job_cd   = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        retObj.job_nm   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        retObj.head_cd  = dsT_CM_PERSON.NameValue(row,'HEAD_CD');
        retObj.head_nm  = dsT_CM_PERSON.NameValue(row,'HEAD_NM');
        retObj.cet_no   = dsT_CM_PERSON.NameValue(row,'CET_NO');
        retObj.mf_tag   = dsT_CM_PERSON.NameValue(row,'MF_TAG');
        retObj.hirg_ymd = dsT_CM_PERSON.NameValue(row,'HIRG_YMD');
        retObj.hir_ymd  = dsT_CM_PERSON.NameValue(row,'HIR_YMD' );
        retObj.ret_ymd  = dsT_CM_PERSON.NameValue(row,'RET_YMD' );
        retObj.ram_ymd  = dsT_CM_PERSON.NameValue(row,'RAM_YMD' );
        retObj.ram_ymd2 = dsT_CM_PERSON.NameValue(row,'RAM_YMD2');
        retObj.ram_ymd3 = dsT_CM_PERSON.NameValue(row,'RAM_YMD3');
        retObj.dpa_ymd  = dsT_CM_PERSON.NameValue(row,'DPA_YMD' );
        retObj.mid_ymd1 = dsT_CM_PERSON.NameValue(row,'MID_YMD1');
        retObj.mid_ymd2 = dsT_CM_PERSON.NameValue(row,'MID_YMD2');
        retObj.mid_ymd3 = dsT_CM_PERSON.NameValue(row,'MID_YMD3');
        retObj.hirr_ymd = dsT_CM_PERSON.NameValue(row,'HIRR_YMD');
        
        window.close();

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PERSON event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        retObj.occ_cd   = dsT_CM_PERSON.NameValue(row,'OCC_CD');
        retObj.occ_nm   = dsT_CM_PERSON.NameValue(row,'OCC_NM');
        retObj.dpt_cd   = dsT_CM_PERSON.NameValue(row,'DPT_CD');
        retObj.dpt_nm   = dsT_CM_PERSON.NameValue(row,'DPT_NM');
        retObj.job_cd   = dsT_CM_PERSON.NameValue(row,'JOB_CD');
        retObj.job_nm   = dsT_CM_PERSON.NameValue(row,'JOB_NM');
        retObj.head_cd  = dsT_CM_PERSON.NameValue(row,'HEAD_CD');
        retObj.head_nm  = dsT_CM_PERSON.NameValue(row,'HEAD_NM');
        retObj.cet_no   = dsT_CM_PERSON.NameValue(row,'CET_NO');
        retObj.mf_tag   = dsT_CM_PERSON.NameValue(row,'MF_TAG');
        retObj.hirg_ymd = dsT_CM_PERSON.NameValue(row,'HIRG_YMD');
        retObj.hir_ymd  = dsT_CM_PERSON.NameValue(row,'HIR_YMD' );
        retObj.ret_ymd  = dsT_CM_PERSON.NameValue(row,'RET_YMD' );
        retObj.ram_ymd  = dsT_CM_PERSON.NameValue(row,'RAM_YMD' );
        retObj.ram_ymd2 = dsT_CM_PERSON.NameValue(row,'RAM_YMD2');
        retObj.ram_ymd3 = dsT_CM_PERSON.NameValue(row,'RAM_YMD3');
        retObj.dpa_ymd  = dsT_CM_PERSON.NameValue(row,'DPA_YMD' );
        retObj.mid_ymd1 = dsT_CM_PERSON.NameValue(row,'MID_YMD1');
        retObj.mid_ymd2 = dsT_CM_PERSON.NameValue(row,'MID_YMD2');
        retObj.mid_ymd3 = dsT_CM_PERSON.NameValue(row,'MID_YMD3');
        retObj.hirr_ymd = dsT_CM_PERSON.NameValue(row,'HIRR_YMD');
        
        window.close();

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
            <td height="25" background="../../images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">사원정보 조회</td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" class="searchState">사원 번호/성명&nbsp;</td>
                                    <td class="padding2423">
                                        <input name="txtENO_NO_SHR" id="txtENO_NO_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()"><input type="text" style="display:none">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                        <input type="hidden" id="hidGBN_CD">
                                        <input type="hidden" id="hidRET_CD">
                                        <input type="hidden" id="hidSTR_YMD">
                                        <input type="hidden" id="hidEND_YMD">
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

    <!-- 조회 상태 테이블 시작-->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
					    <td>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span>
						</td>
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
                            <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:200px;">
                                <param name="DataID"            	value="dsT_CM_PERSON">
                                <param Name="Editable"          	value="false">
                                <param name=HiddenHScroll    	value="true">
                                <param name="Format"            value='
                                    <C> id=HEAD_NM           width=100  name=본부   align=left   </C>
                                    <C> id=DPT_NM            width=90   name=부서   align=left   </C>
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