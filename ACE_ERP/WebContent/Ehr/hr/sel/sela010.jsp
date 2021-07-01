<!--
    ************************************************************************************
    * @Source         : sela010.jsp                                                    *
    * @Description    : 즐겨찾기 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/24 |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>즐겨찾기(sela010)</title>
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

        var btnList = 'TTFTFFFT';

        var iRow  = 0;
        var Count = 0;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var COMM_CD = dsT_CM_EMPLIST.NameValue(1, "COMM_CD");
            var ROLE_CD = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
            var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';

            //사용자 권한 체크를 위해 해당 사용자의 Role ID를 가져온 후 정상적으로 가져왔다면 메뉴 Tree를 Display한다.
            trT_CM_MENULST.KeyValue = "tr01(O:SHR_01=dsT_CM_MENULST,O:SHR_02=dsT_CM_FAVORITES)";
            trT_CM_MENULST.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD;
            trT_CM_MENULST.post();

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

            var menu_lbl  = '';
            var upmenu_id = '';
            var menu_seq  = 0;

            // 아무것도 없는 상태에서 추가 하게 되면 처음은 AddNew하고 나중 부터 InsertRow합
            if (dsT_CM_FAVORITES.CountColumn == 0) {
                dsT_CM_FAVORITES.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, MENU_ID:STRING:KEYVALUETYPE, MENU_NM:STRING, MENU_SEQ:INT, UPMENU_ID:STRING, MENU_LBL:INT, FORM_ID:STRING, MENU_FLD:STRING, MENU_GBN:STRING");

            }

            Count = Count + 1;

            // 첫번째 폴더 추가시
            if (dsT_CM_FAVORITES.CountRow == 0) {
                form1.mgrdT_CM_FAVORITES.Insert(1,2,"");

                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID")   = 'fav00001';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '즐겨찾기1';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = 1;
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = 'root';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = 1;
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';
            }
            else {

                // 메뉴 다음 폴더 추가시 (메뉴의 폴더에 대한 하위 폴더)
                if (dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'f') {

                    menu_seq  = new Number(dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")) + 1;
                    upmenu_id = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID");
                    menu_lbl  = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL");

                    form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,0,"");
                    fnc_getMenuId();    // 폴더에 대한 MENU ID 생성

                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '즐겨찾기'+Count;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = menu_seq;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = upmenu_id;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = menu_lbl;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';

                }
                // 폴더 다음 폴더 추가시 (동일레벨 폴더)
                else {

                    upmenu_id = 'root';

                    if (dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL") == 1) {
                        menu_lbl  = '1';
                        form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,3,"");
                    }
                    else {
                        menu_lbl  = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL");
                        form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,0,"");
                    }

                    fnc_getMenuId();

                    menu_seq  = new Number(dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition - 1, "MENU_SEQ")) + 1;

                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '즐겨찾기'+Count;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = menu_seq;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = upmenu_id;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = menu_lbl;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';

                }
            }

            //사용자 권한 체크를 위해 해당 사용자의 Role ID를 가져온 후 정상적으로 가져왔다면 메뉴 Tree를 Display한다.
            trT_CM_FAVORITES.KeyValue = "tr01(I:SAV=dsT_CM_FAVORITES,O:SHR=dsT_CM_FAVORITES02)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SAV";
            trT_CM_FAVORITES.post();

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            if (dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'f') {

                form1.mgrdT_CM_FAVORITES.Delete(form1.mgrdT_CM_FAVORITES.RowPosition);
            }
            else if (dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'm') {

                if (confirm("해당 폴더 아래 하위 메뉴와 폴더들이 모두 삭제됩니다. 제거하시겠습니까?") == false) return;
                form1.mgrdT_CM_FAVORITES.Delete(0);
            }

            //사용자 권한 체크를 위해 해당 사용자의 Role ID를 가져온 후 정상적으로 가져왔다면 메뉴 Tree를 Display한다.
            trT_CM_FAVORITES.KeyValue = "tr01(I:DEL=dsT_CM_FAVORITES)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=DEL";
            trT_CM_FAVORITES.post();

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = ' ';

            fnc_SearchList();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            //cfStyleGrid(form1.grdT_CM_MENULST,0,"false","false");
            //cfStyleGrid(form1.grdT_CM_MENULST,0,"false","false");

            dsT_CM_EMPLIST.ClearData();

            //Login 사용자의 권한 Role 정보를 가져 온다.
            dsT_CM_EMPLIST.DataId="/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR_00&ENO_NO="+'<%=box.get("SESSION_ENONO")%>';
            dsT_CM_EMPLIST.Reset();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

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

        function fnc_AddMenu() {

            var menu_id   = '';
            var menu_nm   = '';
            var menu_seq  = 0;
            var upmenu_id = '';
            var menu_lbl  = '';
            var form_id   = '';
            var menu_fld  = '';
            var menu_gbn  = '';

            if (dsT_CM_MENULST.CountRow == 0) {
                alert("선택하신 메뉴가 없습니다.");
                return;
            }


            if (dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_GBN") != 'f') {
                alert("선택하신 메뉴는 추가하실 수 없습니다");
                return;
            }

            if (form1.mgrdT_CM_FAVORITES.RowPosition == -1) {
                alert("즐겨찾기 폴더를 먼저 입력하세요");
                return;
            }

            iRow = form1.mgrdT_CM_FAVORITES.RowPosition;

            // 메뉴 아래 생성되는 경우
            if (dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'f') {

                menu_id   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_ID");
                menu_nm   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_NM");
                menu_seq  = new Number(dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")) + 1;
                upmenu_id = dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "UPMENU_ID");
                menu_lbl  = dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_LBL");
                form_id   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "FORM_ID");
                menu_fld  = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_FLD");
                menu_gbn  = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_GBN");

                form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,0,"");


            }
            // 폴더 아래 생성되는 경우
            else {

                menu_id   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_ID");
                menu_nm   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_NM");
                menu_seq  = new Number(dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")) + 1;
                upmenu_id = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID");
                menu_lbl  = new Number(dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")) + 1;
                form_id   = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "FORM_ID");
                menu_fld  = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_FLD");
                menu_gbn  = dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_GBN");

                form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,4,"");

            }

            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID")   = menu_id;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = menu_nm;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = menu_seq;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = upmenu_id;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = menu_lbl;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = form_id;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = menu_fld;
            dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = menu_gbn;

            form1.mgrdT_CM_FAVORITES.LayoutInfo("ColumnInfo", "MENU_NM::<CHILD>::type") = 'none';

            // update
            trT_CM_FAVORITES.KeyValue = "tr01(I:SAV=dsT_CM_FAVORITES,O:SHR=dsT_CM_FAVORITES02)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SAV"
            trT_CM_FAVORITES.post();

        }

        /* MENU ID 생성 */
        function fnc_getMenuId() {
            var SysStatus = dsT_CM_FAVORITES.SysStatus(dsT_CM_FAVORITES.RowPosition);
            var MenuId = 'fav00001';

            if (SysStatus == 1) {

                if (dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID") == '') {

                    for (var i = 1; i <= dsT_CM_FAVORITES.CountRow; i++) {

                        if (dsT_CM_FAVORITES.NameValue(i, "MENU_ID") >= MenuId &&
                            dsT_CM_FAVORITES.NameValue(i, "MENU_GBN") == 'm' &&
                            i != dsT_CM_FAVORITES.RowPosition) {

                           MenuId = 'fav' + lpad(new Number(dsT_CM_FAVORITES.NameValue(i, "MENU_ID").substr(3,5)) + 1, 5, '0');
                        }
                    }

                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID") = MenuId;
                }
            }
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
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_MENULST)   |
    | 3. 사용되는 Table List(T_CM_MENULST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_MENULST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--Object ID="imgT_CM_MENULST" ClassID="CLSID:2B0B1D8B-CAAA-4E06-BD9A-A09A916BD67A>
         <Param Name="DataID"         Value="service.csv">
    </object-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_MENULST)   |
    | 3. 사용되는 Table List(T_CM_MENULST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAVORITES" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_MENULST)   |
    | 3. 사용되는 Table List(T_CM_MENULST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAVORITES02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_EMPLIST)   |
    | 3. 사용되는 Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_MENULST                      |
    | 3. Table List : T_CM_MENULST                  |
    +----------------------------------------------->
    <Object ID ="trT_CM_MENULST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_MENULST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_FAVORITES                    |
    | 3. Table List : T_CM_FAVORITES                |
    +----------------------------------------------->
    <Object ID ="trT_CM_FAVORITES" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_FAVORITES)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <script Language=JavaScript For=dsT_CM_FAVORITES Event="OnRowPosChanged(row)">

        if (dsT_CM_FAVORITES.NameValue(row, "MENU_GBN") == 'f') {
            form1.mgrdT_CM_FAVORITES.LayoutInfo("ColumnInfo", "MENU_NM::<CHILD>::type") = 'none';
        }
        else {
            form1.mgrdT_CM_FAVORITES.LayoutInfo("ColumnInfo", "MENU_NM::<CHILD>::type") = 'edit';
        }

    </script>

    <script language=JavaScript For=dsT_CM_FAVORITES Event="OnColumnChanged(row,colid)">

        // 폴더이면서 수정인 경우
        if (colid == 'MENU_NM' && dsT_CM_FAVORITES.NameValue(row,"MENU_GBN") == 'm' &&  dsT_CM_FAVORITES.RowStatus(row) == 3) {

            iRow = row;

            // update
            trT_CM_FAVORITES.KeyValue = "tr01(I:SAV=dsT_CM_FAVORITES,O:SHR=dsT_CM_FAVORITES02)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SAV";
            trT_CM_FAVORITES.post();

            dsT_CM_FAVORITES.RowPosition = iRow;

        }

    </script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {
            var COMM_CD = dsT_CM_EMPLIST.NameValue(1, "COMM_CD");
            var ROLE_CD = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
            var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';

            //사용자 권한 체크를 위해 해당 사용자의 Role ID를 가져온 후 정상적으로 가져왔다면 메뉴 Tree를 Display한다.
            trT_CM_MENULST.KeyValue = "tr01(O:SHR_01=dsT_CM_MENULST,O:SHR_02=dsT_CM_FAVORITES)";
            trT_CM_MENULST.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD;
            trT_CM_MENULST.post();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_MENULST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_MENULST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_MENULST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_MENULST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

   <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAVORITES Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

   <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAVORITES02 Event="OnLoadCompleted(iCount)">

        if (iCount > 0)  {

            /** 데이터셋 복사 **/
            cfCopyDataSet(dsT_CM_FAVORITES02, dsT_CM_FAVORITES, "copyHeader=yes")

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES02 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES02 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_MENULST event="OnSuccess()">


    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_MENULST event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_FAVORITES event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_FAVORITES event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

        dsT_CM_FAVORITES.ClearData();
        dsT_CM_FAVORITES.DataId = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR_03&ENO_NO="+'<%=box.get("SESSION_ENONO")%>';
        dsT_CM_FAVORITES.Reset();

        form1.mgrdT_CM_FAVORITES.RowPosition = iRow;

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">즐겨찾기</td>
                    <td align="right" class="navigator">HOME/기초정보/셀프서비스/<font color="#000000">즐겨찾기</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="370" >
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id=mgrdT_CM_MENULST classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=370 height=410>
                            <Param Name="DataID"            value="dsT_CM_MENULST">
                            <param name="ImageDataID"       value="imgT_CM_MENULST">
                            <Param Name="Sort"              value="false">
                            <Param Name="ColumnInfo"        value='
                                <COLUMNINFO>
                                <COLUMN id="MENU_NM" refcolid="MENU_NM">
                                    <TREE type="2"   levelcolumn="MENU_LBL"/>
                                    <HEADER left="0" top="0" right="333" bottom="30" bgcolor="#F7DCBB" text="메뉴"/>
                                    <VIEW   left="0" top="0" right="333" bottom="23" bordercolor="#FFFFFF" />
                                    <GROUP level="3" bgcolor="#FFFFFF" bordercolor="Crimson" />
                                    <GROUP level="2" bgcolor="#FFFFFF" bordercolor="Crimson" />
                                    <GROUP level="1" bgcolor="#FFFFFF" bordercolor="Crimson" />
                                </COLUMN>
                                </COLUMNINFO>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
        <td width="60" align="center">
            <input type=button id="btnCOPY" value=" >> "  onClick="fnc_AddMenu();">
        </td>
        <td width="370" >
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','/images/button/btn_AppendOver.gif',1)"><img src="/images/button/btn_AppendOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_RemoveOver.gif',1)"><img src="/images/button/btn_RemoveOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
                    </td>
                </tr>
                <tr align="center">
                    <td class="paddingTop5">
                        <comment id="__NSID__">
                        <object id=mgrdT_CM_FAVORITES classid="clsid:8B6E903C-6297-44FB-B6C5-4F9D7FCA2A08" width=370 height=380>
                            <Param Name="DataID"            value="dsT_CM_FAVORITES">
                            <param name="ImageDataID"       value="imgT_CM_MENULST">
                            <Param Name="Sort"              value="false">
                            <Param Name="ColumnInfo"        value='
                                <COLUMNINFO>
                                <COLUMN id="MENU_NM" refcolid="MENU_NM">
                                    <TREE type="2" levelcolumn="MENU_LBL"/>
                                    <HEADER left="0" top="0" right="333" bottom="30" bgcolor="#F7DCBB" text="즐겨찾기 메뉴"/>
                                    <VIEW   left="0" top="0" right="333" bottom="23" bordercolor="#FFFFFF" />
                                    <GROUP level="3" bgcolor="#FFFFFF"/>
                                    <GROUP level="2" bgcolor="#FFFFFF"/>
                                    <GROUP level="1" bgcolor="#FFFFFF"/>
                                    <CHILD type="edit" />
                                </COLUMN>
                                </COLUMNINFO>'>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>