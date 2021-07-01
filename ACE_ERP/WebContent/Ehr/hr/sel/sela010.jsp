<!--
    ************************************************************************************
    * @Source         : sela010.jsp                                                    *
    * @Description    : ���ã�� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/24 |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>���ã��(sela010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TTFTFFFT';

        var iRow  = 0;
        var Count = 0;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var COMM_CD = dsT_CM_EMPLIST.NameValue(1, "COMM_CD");
            var ROLE_CD = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
            var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';

            //����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
            trT_CM_MENULST.KeyValue = "tr01(O:SHR_01=dsT_CM_MENULST,O:SHR_02=dsT_CM_FAVORITES)";
            trT_CM_MENULST.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD;
            trT_CM_MENULST.post();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }



        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            var menu_lbl  = '';
            var upmenu_id = '';
            var menu_seq  = 0;

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
            if (dsT_CM_FAVORITES.CountColumn == 0) {
                dsT_CM_FAVORITES.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, MENU_ID:STRING:KEYVALUETYPE, MENU_NM:STRING, MENU_SEQ:INT, UPMENU_ID:STRING, MENU_LBL:INT, FORM_ID:STRING, MENU_FLD:STRING, MENU_GBN:STRING");

            }

            Count = Count + 1;

            // ù��° ���� �߰���
            if (dsT_CM_FAVORITES.CountRow == 0) {
                form1.mgrdT_CM_FAVORITES.Insert(1,2,"");

                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_ID")   = 'fav00001';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '���ã��1';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = 1;
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = 'root';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = 1;
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';
            }
            else {

                // �޴� ���� ���� �߰��� (�޴��� ������ ���� ���� ����)
                if (dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'f') {

                    menu_seq  = new Number(dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")) + 1;
                    upmenu_id = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID");
                    menu_lbl  = dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL");

                    form1.mgrdT_CM_FAVORITES.Insert(form1.mgrdT_CM_FAVORITES.RowPosition,0,"");
                    fnc_getMenuId();    // ������ ���� MENU ID ����

                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "ENO_NO")    = '<%=box.get("SESSION_ENONO")%>';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '���ã��'+Count;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = menu_seq;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = upmenu_id;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = menu_lbl;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';

                }
                // ���� ���� ���� �߰��� (���Ϸ��� ����)
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
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_NM")   = '���ã��'+Count;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_SEQ")  = menu_seq;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "UPMENU_ID") = upmenu_id;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_LBL")  = menu_lbl;
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "FORM_ID")   = 'fav';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_FLD")  = '/hr/fav/';
                    dsT_CM_FAVORITES.NameValue(dsT_CM_FAVORITES.RowPosition, "MENU_GBN")  = 'm';

                }
            }

            //����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
            trT_CM_FAVORITES.KeyValue = "tr01(I:SAV=dsT_CM_FAVORITES,O:SHR=dsT_CM_FAVORITES02)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SAV";
            trT_CM_FAVORITES.post();

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            if (dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'f') {

                form1.mgrdT_CM_FAVORITES.Delete(form1.mgrdT_CM_FAVORITES.RowPosition);
            }
            else if (dsT_CM_FAVORITES.NameValue(form1.mgrdT_CM_FAVORITES.RowPosition, "MENU_GBN") == 'm') {

                if (confirm("�ش� ���� �Ʒ� ���� �޴��� �������� ��� �����˴ϴ�. �����Ͻðڽ��ϱ�?") == false) return;
                form1.mgrdT_CM_FAVORITES.Delete(0);
            }

            //����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
            trT_CM_FAVORITES.KeyValue = "tr01(I:DEL=dsT_CM_FAVORITES)";
            trT_CM_FAVORITES.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=DEL";
            trT_CM_FAVORITES.post();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = ' ';

            fnc_SearchList();

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            //cfStyleGrid(form1.grdT_CM_MENULST,0,"false","false");
            //cfStyleGrid(form1.grdT_CM_MENULST,0,"false","false");

            dsT_CM_EMPLIST.ClearData();

            //Login ������� ���� Role ������ ���� �´�.
            dsT_CM_EMPLIST.DataId="/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR_00&ENO_NO="+'<%=box.get("SESSION_ENONO")%>';
            dsT_CM_EMPLIST.Reset();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
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
                alert("�����Ͻ� �޴��� �����ϴ�.");
                return;
            }


            if (dsT_CM_MENULST.NameValue(dsT_CM_MENULST.RowPosition, "MENU_GBN") != 'f') {
                alert("�����Ͻ� �޴��� �߰��Ͻ� �� �����ϴ�");
                return;
            }

            if (form1.mgrdT_CM_FAVORITES.RowPosition == -1) {
                alert("���ã�� ������ ���� �Է��ϼ���");
                return;
            }

            iRow = form1.mgrdT_CM_FAVORITES.RowPosition;

            // �޴� �Ʒ� �����Ǵ� ���
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
            // ���� �Ʒ� �����Ǵ� ���
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

        /* MENU ID ���� */
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
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_MENULST)   |
    | 3. ���Ǵ� Table List(T_CM_MENULST)          |
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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_MENULST)   |
    | 3. ���Ǵ� Table List(T_CM_MENULST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAVORITES" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_MENULST)   |
    | 3. ���Ǵ� Table List(T_CM_MENULST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_FAVORITES02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EMPLIST)   |
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_MENULST                      |
    | 3. Table List : T_CM_MENULST                  |
    +----------------------------------------------->
    <Object ID ="trT_CM_MENULST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_MENULST)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_FAVORITES                    |
    | 3. Table List : T_CM_FAVORITES                |
    +----------------------------------------------->
    <Object ID ="trT_CM_FAVORITES" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_FAVORITES)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
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

        // �����̸鼭 ������ ���
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {
            var COMM_CD = dsT_CM_EMPLIST.NameValue(1, "COMM_CD");
            var ROLE_CD = dsT_CM_EMPLIST.NameValue(1, "ROLE_CD");
            var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';

            //����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
            trT_CM_MENULST.KeyValue = "tr01(O:SHR_01=dsT_CM_MENULST,O:SHR_02=dsT_CM_FAVORITES)";
            trT_CM_MENULST.action = "/servlet/GauceChannelSVL?cmd=hr.sel.a.sela010.cmd.SELA010CMD&S_MODE=SHR&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD;
            trT_CM_MENULST.post();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_MENULST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_MENULST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_MENULST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_MENULST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

   <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAVORITES Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

   <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_FAVORITES02 Event="OnLoadCompleted(iCount)">

        if (iCount > 0)  {

            /** �����ͼ� ���� **/
            cfCopyDataSet(dsT_CM_FAVORITES02, dsT_CM_FAVORITES, "copyHeader=yes")

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES02 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_FAVORITES02 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_MENULST event="OnSuccess()">


    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_MENULST event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_FAVORITES event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
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

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ã��</td>
                    <td align="right" class="navigator">HOME/��������/��������/<font color="#000000">���ã��</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- ��ȸ ���� ���̺� ���� -->
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
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
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
                                    <HEADER left="0" top="0" right="333" bottom="30" bgcolor="#F7DCBB" text="�޴�"/>
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
                                    <HEADER left="0" top="0" right="333" bottom="30" bgcolor="#F7DCBB" text="���ã�� �޴�"/>
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
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>