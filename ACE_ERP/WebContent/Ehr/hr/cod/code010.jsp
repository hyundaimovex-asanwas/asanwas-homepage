<!--
    ************************************************************************************
    * @Source         : code010.jsp                                                     *
    * @Description    : 개인정보조회 PAGE                                              *
    * @Developer Desc :                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                         *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사									     *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%

	//String ROLE_CD      = box.getString("SESSION_ROLE_CD");

    //ROLE_CD가 IT인지 여부
    boolean itMaster = false;

    //if(ROLE_CD.equals("1001")) {
    //	itMaster = true;
    //}



%>


<html>
    <head>
    <title>개인정보조회</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    //Configuration conf = Configuration.getInstance();

    //String FILEURL = conf.get("framework.file.upload.pds");
    //String p_eno_no = request.getParameter("") != null ? request.getParameter("") : ls_UserId;
    //String p_mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
    
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >


        var imgBox  = null;        // 업로드된 사진 보여주기

        var dsTemp = window.dialogArguments;
        var p_eno_no = gusrid;
        var p_mode = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_ACCESS.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code010.cmd.CODE010CMD&S_MODE=SHR_ACC";
            dsT_CM_ACCESS.Reset();        	
        	
            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc010.cmd.PIRC010CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_PERSON.Reset();

            //학력사항 조회
            dsT_CM_SCHOOL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_SCHOOL.Reset();

            //가족사항 조회
            dsT_CM_FAMILY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_FAMILY.Reset();

            //입사전 경력 조회
            dsT_CM_BHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira024.cmd.PIRA024CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_BHISTORY.Reset();            
            
            //입사후 경력 조회
            dsT_CM_AHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_AHISTORY.Reset();

            //자격 내역 조회
            dsT_CM_QUALIFICATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_QUALIFICATION.Reset();

            //사회공헌 조회
            dsT_CM_SERVICE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_SERVICE.Reset();

            //상벌사항 조회
            dsT_CM_REWARD.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_REWARD.Reset();

           //고과사항 조회
            //dsT_CM_GRADE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira035.cmd.PIRA035CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            //dsT_CM_GRADE.Reset();

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

            //이곳에 해당 코딩을 입력 하세요
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요
        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            dsT_CM_PERSON.ClearData();

            // 서브탭 초기화면 호출
            fnc_ViewFrameTab(1);

        }

        /********************************************
         * 11. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
        	
            if(p_mode == "read") {
            	
                window.close();
                
            } else {
            	
            	window.close();
            	
            }
            
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //param 값들 정의(팝업으로 넘어오는 경우)
            if(dsTemp != null) {
                p_eno_no    = dsTemp.eno_no;
                p_mode      = dsTemp.mode;

                //팝업은 수정요청 버튼이 않보인다.
	            document.getElementById("imgRequest").style.display = "none";
            }

            document.getElementById("imgSearch").style.display = "none";

            //imgBox = new Image(document.form1.viewImage);

            // 탭의 초기화면 호출
            fnc_ViewFrameTab(1);

            fnc_SearchList();

            photo.src = "../../../Ehr/photo/" + p_eno_no + ".jpg";    
            
            cfStyleGrid_New(grdT_CM_AHISTORY, 0,"false","false");
            cfStyleGrid_New(grdT_CM_BHISTORY, 0,"false","false");            
            cfStyleGrid_New(grdT_CM_FAMILY, 0,"false","false");
            cfStyleGrid_New(grdT_CM_QUALIFICATION, 0,"false","false");
            cfStyleGrid_New(grdT_CM_SCHOOL, 0,"false","false");
            cfStyleGrid_New(grdT_CM_SERVICE, 0,"false","false");
            cfStyleGrid_New(grdT_CM_REWARD, 0,"false","false");
            cfStyleGrid_New(grdT_CM_GRADE, 0,"false","false");
            
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        var old_i = 0;                 // 탭 번호
        var old_u = 0;                 // 서브탭번호
        var old_enono = '';            // 사번(탭클릭시 현재 입력된 사번과 비교하기 위함)


        /*******************************************************
         * 탭화면안의 서브탭 호출시 관련 jsp 가져와 뿌려준다.  *
         *******************************************************/
        function fnc_ViewFrameTab(u) {

            var iframe = document.getElementById("iframe_tab_"+u);
            
            var gubun = "1";//권한에 따른 수정 가능(불가능)을 위한 변수(pirc011, pira018)

            // 이전과 다른 탭을 클릭한 경우 이전화면은 보이지 않고, 새로운 화면을 보임
            if (old_u != u && old_u != 0) {

                document.getElementById('view_tab_'+old_u).style.display='none';
            }

            document.getElementById('view_tab_'+u).style.display='inline';

            if(iframe != undefined) {
            	
                if (iframe.src == "about:blank") {

                  iframe.src = iframe.load_src + "?ENO_NO="+p_eno_no + "&GUBUN="+gubun + "&mode="+p_mode+"&srcid=code010";
                }
                else {

                    // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오기 위함
                    //에러
                    if (iframe.contentWindow.document.getElementById("ENO_NO").value != p_eno_no) {

                        iframe.contentWindow.document.getElementById("ENO_NO").value = p_eno_no;
                        iframe.contentWindow.fnc_SearchList();
                    }
                }
            }

            old_u=u;

        }

        /*************************************************************************
         * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
         * - usage : var obj = new Image(이미지테그의ID);
         *               obj.setImage("서버의 이미지파일의 위치및 파일명");
         *************************************************************************/
        function Image(imgTag) {
        	 
            var imgTag = imgTag;
            
            var action = "../../../servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";
            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        function fnc_code020Popup(){

            window.showModalDialog("../../hr/cod/code020.jsp", "Modal", "dialogWidth:1050px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        }


    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    
    <Object ID="dsT_CM_ACCESS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   <Object ID="dsT_CM_SERVICE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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

        var ENO_NO  = "";
        var FILEURL = "";

        ENO_NO = dsT_CM_PERSON.NameValue(1, "ENO_NO");
        
        
        //
		
		
        //imgBox.setImage(FILEURL);

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 
<form name="form1">
-->

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRequest','','../../images/button/btn_RequestOver.gif',1)"><img src="../../images/button/btn_RequestOn.gif" name="imgRequest" width="80" height="20" border="0" align="absmiddle" onClick="fnc_code020Popup()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                </colgroup>
                <tr>
                    <td align="center" rowSpan="4">
					<img id="photo" src="photo.src" border="0" width="136" height="170" style="position: relative; top: 2px"/></td>     
                    <td align="center" class="blueBold">사&nbsp;&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input type=hidden id="REG_NO">
                        <input id="txtENO_NO" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">국문성명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM"  class="input_ReadOnly" readonly style="width:100%">
                    </td>
                    <td align="center" class="blueBold">한자성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_CHI"  class="input_ReadOnly" readonly style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">생년월일</td>
                    <td class="padding2423">
                        <input id="txtBIR_YMD" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
                    <td class="padding2423">
                         <input id="txtBIR_TAG" class="input_ReadOnly" readonly style="width:100%">
                    </td>
                    <td align="center" class="blueBold">영문성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" class="input_ReadOnly" readonly style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtDPT_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">년&nbsp;&nbsp;&nbsp;&nbsp;차</td>
                    <td class="padding2423">
                        <input id="txtHOB_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtHOB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">입&nbsp;사&nbsp;일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">결 혼 일</td>
                    <td class="padding2423">
                        <input id="txtWED_YMD" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">담당업무</td>
                    <td class="padding2423">
                        <input id="txtPER_JOB" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 기본사항 시작 -->
<table width="1000" height="394" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    <tr><td align="center">
        <input type=hidden id="ENO_NO" size="10">
        <!-- 탭 버튼 테이블 시작 -->
        <table width="996" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop5">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <tr>
                            <td align="left">
                                <input type=button id="btn2" value="기본정보"      onclick="fnc_ViewFrameTab(1)">
                                <input type=button id="btn3" value="가족사항"      onclick="fnc_ViewFrameTab(2)">
                                <input type=button id="btn4" value="입사전경력"    onclick="fnc_ViewFrameTab(3)">
                                <input type=button id="btn5" value="입사후경력"    onclick="fnc_ViewFrameTab(4)">
                                <input type=button id="btn6" value="자격면허"      onclick="fnc_ViewFrameTab(5)">
                                <input type=button id="btn7" value="학력사항"      onclick="fnc_ViewFrameTab(6)">                                
                                <input type=button id="btn8" value="사회공헌"      onclick="fnc_ViewFrameTab(7)">
                      	        <input type=button id="btn9" value="상벌사항"      onclick="fnc_ViewFrameTab(8)">
                          		<!--  <input type=button id="btn9" value="고과사항"      onclick="fnc_ViewFrameTab(9)">	  -->
                                <input type=hidden id="ENO_NO" size="10">
                            </td>
                        <tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- 탭 버튼 테이블 끝 -->

        <!-- 인사기본2 시작 -->
        <div id="view_tab_1" style="width:996;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_1" src="about:blank" load_src="../../hr/cod/code011.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본2 끝 -->

        <!-- 가족사항 시작 -->
        <div id="view_tab_2" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>가족사항</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_FAMILY">
                                        <param name="Format"                  value="
			                                <C> id={currow}        width=35   name='순번'         align=center </C>
			                                <C> id=REL_NM          width=100   name='관계'         align=center </C>
			                                <C> id=ENO_NM          width=100   name='성명'         align=center </C>
			                                <C> id=BIR_YMD         width=100  name='생년월일'     align=center mask='XX-XX-XX'</C>
			                                <C> id=EDGR_NM         width=130   name='학력'         align=center  </C>
			                                <C> id=OCC_NAM         width=160   name='근무처'                    </C>
			                                <C> id=JOB_CD          width=100   name='직위'                      </C>
			                                <C> id=DPD_TAG1        width=100   name='부양여부'     align=center value={Decode(DPD_TAG,'O','부양','X','미부양','')} </C>
			                                <C> id=HIU_TAG1        width=100   name='의보여부'     align=center value={Decode(HIU_TAG,'O','부양','X','미부양','')} </C>,'미부양','')} </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 가족사항 끝 -->

        <!-- 입사전경력 시작 -->
        <div id="view_tab_3" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>입사후경력</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_BHISTORY">
                                        <param name="Format"                  value="
			                                <C> id={currow}        width=45   name='순번'         align=center </C>
			                                <C> id=CMP_NAM         width=150  name='회사명'                    </C>
			                                <C> id=STR_YMD         width=80   name='입사일'       align=center </C>
			                                <C> id=END_YMD         width=80   name='퇴사일'       align=center </C>
			                                <C> id=DPT_NAM         width=150   name='소속'                      </C>
			                                <C> id=JOB_CD          width=80   name='직위'        align=center  </C>
			                                <C> id=CHG_JOB         width=200  name='담당업무'                  </C>
			                                <C> id=REMARK          width=140  name='비고'                      </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 입사전경력 끝 -->

        <!-- 입사후경력 시작 -->
        <div id="view_tab_4" style="width:800;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>입사후경력</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_AHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_AHISTORY">
                                        <param name="Format"                  value="
                                            <C> id={currow}        width=30   name='순번'         align=center </C>
                                            <C> id=STR_YMD         width=80   name='시작일'       align=center </C>
                                            <C> id=END_YMD         width=80   name='종료일'       align=center </C>
                                            <C> id=APP_NM          width=100  name='발령구분'     align=center  </C>
                                            <C> id=DPT_NM          width=120  name='소속'                      </C>
                                            <C> id=TEAM_NM         width=150   name='팀'              			 </C>
                                            <C> id=JOB_NM          width=70   name='직위'           align=center  </C>
                                            <C> id=DUTY_NM         width=70   name='직책'                      </C>
                                            <C> id=REMARK          width=130  name='비고'                      </C>
                                            <C> id=JCD_NM          width=95   name='재직구분'    align=center  </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 입사후경력 끝 -->

        <!-- 자격면허 시작 -->
        <div id="view_tab_5" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>자격면허</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_QUALIFICATION">
                                        <param name="Format"                  value="
                                            <C> id={currow}        width=35   name='순번'         align=center </C>
                                            <C> id=QUA_NM          width=170   name='자격면허'                  </C>
                                            <C> id=GAN_YMD         width=100   name='취득일'       align=center </C>
                                            <C> id=CHG_YMD         width=100   name='갱신일'       align=center </C>
                                            <C> id=DUE_YMD         width=100   name='만기일'       align=center </C>
                                            <C> id=QUA_NO          width=150   name='증서번호'                  </C>
                                            <C> id=APP_ADM         width=150   name='발행처'                    </C>
                                            <C> id=ETG_YN1         width=120   name='수당지급'     align=center value={Decode(ETG_YN,'O','지급','X','미지급','')} </C>

                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 자격면허 끝 -->

        <!-- 학력사항 시작 -->
        <div id="view_tab_6" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>학력사항</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_SCHOOL">
                                        <param name="Format"                  value="
			                                <C> id=EDGR_CD         width=45   name='코드'         align=center </C>
			                                <C> id=EDGR_NM         width=120   name='학력구분'    align=center  </C>
			                                <C> id=GURS_YMD        width=100   name='입 학 일'     align=center </C>
			                                <C> id=GURE_YMD        width=100   name='졸 업 일'     align=center </C>
			                                <C> id=SCH_NAM         width=200   name='학교'       align=center </C>
			                                <C> id=MAJ_NM          width=120   name='전공'      align=center </C>
			                                <C> id=MAJ_NM2         width=120   name='복수전공'     align=center</C>
			                                <C> id=GRD_NM          width=120   name='졸업구분'     align=center  </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 학력사항 끝 -->

        <!-- 사회공헌 시작 -->
        <div id="view_tab_7" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>사회공헌</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_SERVICE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_SERVICE">
                                        <param name="Format"                  value="
                                          <C> id={currow}        	width=40   name='순번'         align=center  </C>
                                          <C> id=STR_YMD         	width=100   name='일 자'        align=center  </C>
                                          <C> id=ATT_NM          	width=150  name='주 관'                      </C>
                                          <C> id=ATT_OFFICE      	width=150  name='행사장소'                   </C>
                                          <C> id=ATT_SBJ         	width=400  name='행사내용'                   </C>
                                          <C> id=ATT_HOUR        	width=85   name='시간'         align=center  </C>
                                         ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 사회공헌 끝 -->




        <!-- 상벌 사항 시작-->
        <div id="view_tab_8" style="width:1000;height:394;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>상벌사항</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
			                        <comment id="__NSID__">
			                        <object id="grdT_CM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
			                            <param name="DataID"                    value="dsT_CM_REWARD">
			                            <param name="Format"                    value="
			                                <C> id={currow}        width=30     name='순번'           align=center </C>
			                                <C> id=REPU_YMD        width=100     name='상벌일자'       align=center </C>
			                                <C> id=REPU_CD1        width=150    name='상벌구분'       align=center value={Decode(REPU_CD,'1','포상(사내)','2','포상(사외)','3','징계(사내)','')} </C>

			                                <C> id=REPU_TNM        width=150     name='상벌종류'                    </C>
			                                <C> id=SYC_NAM         width=170     name='수여처'                      </C>
			                                <C> id=REPU_RMK        width=170    name='상벌내역'                    </C>
			                                <C> id=REMARK3         width=155    name='비고'                        </C>
			                            ">
			                        </object>
			                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
         </div>
        <!-- 상벌 사항 끝 -->



        <!-- 고과상황 시작  -->

        <div id="view_tab_9" style="width:1000;height:394;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>고과사항</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
			                        <comment id="__NSID__">
			                        <object id="grdT_CM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:363px;">
			                            <param name="DataID"                    value="dsT_CM_GRADE">
			                            <param name="Format"                    value="
			                                <C> id={currow}       width=30     name='순번'          	 	align=center </C>
			                                <C> id=EVAYM          width=100    name='고과년월'      		 align=center mask='XXXX-XX'</C>
			                                <C> id=GRADE3         width=315    name='역량고과등급'       align=center </C>
			                                <C> id=GRADE4         width=315    name='업적고과등급'       align=center </C>
			                            ">
			                        </object>
			                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
         </div>

        <!--고과상황 끝 -->

    </td></tr>
</table>
<!-- 인사기본2 끝 -->


</form>
<!-- form 끝 -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 달성도배점설정 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO         	Ctrl=txtENO_NO      Param=value Disable=disabled</C>
        <C>Col=ENO_NM         	Ctrl=txtENO_NM      Param=value </C>
        <C>Col=NAM_CHI        	Ctrl=txtNAM_CHI     Param=value </C>
        <C>Col=NAM_ENG        Ctrl=txtNAM_ENG     Param=value </C>
        <C>Col=BIR_YMD        	Ctrl=txtBIR_YMD     Param=value </C>
        <C>Col=BIR_TAG        	Ctrl=txtBIR_TAG     Param=value </C>
        <C>Col=HIR_YMD        Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=DPT_CD         Ctrl=txtDPT_CD      Param=value </C>
        <C>Col=DPT_NM         Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_CD         Ctrl=txtJOB_CD      Param=value </C>
        <C>Col=JOB_NM         Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=HOB_CD         Ctrl=txtHOB_CD      Param=value </C>
        <C>Col=HOB_NM         Ctrl=txtHOB_NM      Param=value </C>
        <C>Col=WED_YMD        Ctrl=txtWED_YMD     Param=value </C>
        <C>Col=PER_JOB        	Ctrl=txtPER_JOB     Param=value </C>
    '>
</object>