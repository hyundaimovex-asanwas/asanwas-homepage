<!--
    ************************************************************************************
    * @Source         : vlud020.jsp                                                    *
    * @Description    : �׸񺰿�������Ȳ PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/16  |  ������   | �����ۼ�                                               *
    * 2007/03/19  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�׸񺰿�������Ȳ(vlud020)</title>
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

        // ������
        var EVL_GBN = '1';
        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;
            var DPT_CD  = form1.txtDPT_CD_SHR.value;
            var HEAD_CD  = form1.cmbHEAD_CD_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud020.cmd.VLUD020CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD+"&HEAD_CD="+HEAD_CD;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;

            // �׸��� ������ ��ȸ ��
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud020.cmd.VLUD020CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

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
  			var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;
            var DPT_CD  = form1.txtDPT_CD_SHR.value;
            var HEAD_CD  = form1.cmbHEAD_CD_SHR.value;

            params = "EVL_YY="+EVL_YY
                   + "&EVL_FRQ="+EVL_FRQ
                   + "&ENO_NO="+ENO_NO
                   + "&DPT_CD="+DPT_CD
                   + "&HEAD_CD="+HEAD_CD;

			var url = "vlud020_PV.jsp?"+params;
			alert("params =["+params+"]");
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("�׸񺰿�������Ȳ", '', 225)

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbHEAD_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_ABLRST.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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

            var EVL_YY  = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ABLRST,0,"false","false");

            getSelYy2('cmbEVL_YY_SHR');

            EVL_YY = form1.cmbEVL_YY_SHR.value;

			//�޺��ڽ� ����(�λ���)
			fnc_ChangeHEAD_CD_SHR();

            // Form Load ��
            form1.txtFLAG.value = "0";

            // ��������
            if (frameid == "vlud020") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }


            // DATASET �ʱ�ȭ
            fnc_Clear();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud020.cmd.VLUD020CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

            form1.cmbEVL_YY_SHR.focus();

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


        /*****************************************************
         * �����ʵ� �� ����� �׸��� �÷� SETTING ó�� �κ�  *
         ****************************************************/
        function fnc_ChangeColumn() {

            var UP_YN    = dsT_EV_TYPE.NameValue(1, "UP_YN");
            var DOWN_YN  = dsT_EV_TYPE.NameValue(1, "DOWN_YN");
            var UP_CNT   = dsT_EV_TYPE.NameValue(1, "UP_CNT");
            var DOWN_CNT = dsT_EV_TYPE.NameValue(1, "DOWN_CNT");

            if (DOWN_YN == 1) {
                // ���������� ��ŭ �÷��� ������
                if (DOWN_CNT == 1) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_211", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_212", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_213", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_21",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_221", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_222", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_223", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_22",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_231", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_232", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_233", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_23",  "Show") = "false";
                }
                else if (DOWN_CNT == 2) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_211", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_212", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_213", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_21",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_221", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_222", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_223", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_22",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_231", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_232", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_233", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_23",  "Show") = "false";
                }
                else if (DOWN_CNT == 3) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_211", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_212", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_213", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_21",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_221", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_222", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_223", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_22",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_231", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_232", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_233", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_23",  "Show") = "true";
                }
            }
            else {

                if (dsT_EV_TYPE.CountRow > 0) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_211", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_212", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_213", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_21",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_221", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_222", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_223", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_22",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_231", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_232", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_233", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_23",  "Show") = "false";
                }
                else {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_211", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_212", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_213", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_21",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_221", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_222", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_223", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_22",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_231", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_232", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_233", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_23",  "Show") = "true";
                }

            }

            if (UP_YN == 1) {
                // ���������� ��ŭ �÷��� ������
                if (UP_CNT == 1) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_111", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_112", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_113", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_11",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_121", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_122", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_123", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_12",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_131", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_132", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_133", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_13",  "Show") = "false";
                }
                else if (UP_CNT == 2) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_111", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_112", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_113", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_11",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_121", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_122", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_123", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_12",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_131", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_132", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_133", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_13",  "Show") = "false";
                }
                else if (UP_CNT == 3) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_111", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_112", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_113", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_11",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_121", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_122", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_123", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_12",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_131", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_132", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_133", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_13",  "Show") = "true";
                }
            }
            else {

                if (dsT_EV_TYPE.CountRow > 0) {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_111", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_112", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_113", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_11",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_121", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_122", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_123", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_12",  "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_131", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_132", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_133", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_13",  "Show") = "false";
                }
                else {
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_111", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_112", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_113", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_11",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_121", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_122", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_123", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_12",  "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_131", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_132", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_133", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("PNT_13",  "Show") = "true";
                }

            }

        }

        //�޺��ڽ� ����(�λ���)
        function fnc_ChangeHEAD_CD_SHR(){
			var EVL_YY = form1.cmbEVL_YY_SHR.value;

            dsT_CM_DEPT.DataId = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR_06&CD_GBN="+"B2"+"&EVL_YY="+EVL_YY;
            dsT_CM_DEPT.Reset();

			var oOption;

			//�޺�����
			//del_index=document.from2.select2.selectedIndex;
			//document.getElementById("cmbHEAD_CD_SHR").remove(del_index);     //������ �͸� ����
			//document.getElementById("cmbHEAD_CD_SHR").options.length = 3;    //3�� ����� ������
			document.getElementById("cmbHEAD_CD_SHR").options.length = 0;    //��δ� ����

			//�޺��� ��ü ����
            oOption = document.createElement("OPTION");
            oOption.value = "";
            oOption.text  = "��ü"
            document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            //�޺��� �ڵ� ����
            for( i = 1; i<= dsT_CM_DEPT.countrow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CM_DEPT.NameValue(i,"HEAD_CD");
                oOption.text  = dsT_CM_DEPT.NameValue(i,"HEAD_NM");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST) |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- �����ڵ� ������ -->
    <Object ID="dsT_CM_DEPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var EVL_YY  = '';
        var EVL_FRQ = '';
        var ENO_NO  = '';
        var DPT_CD  = '';
        var HEAD_CD  = '';

        var oOption;
        var Index = document.getElementById("cmbEVL_FRQ_SHR").length;

        if (iCount == 0)    {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = 1;
            oOption.text  = '1ȸ';
            document.getElementById("cmbEVL_FRQ_SHR").add(oOption);

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }


            //������ȸ��
            for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = i;
                oOption.text  = i+'ȸ';
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

        }

        // ���а��� ���� �׸��忡 �������� ��/���� ���� �÷��� ��������.
        fnc_ChangeColumn();

        if (form1.txtFLAG.value == "1") {
            EVL_YY  = form1.cmbEVL_YY_SHR.value;
            EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
            ENO_NO  = form1.txtENO_NO_SHR.value;
            DPT_CD  = form1.txtDPT_CD_SHR.value;
            HEAD_CD = form1.cmbHEAD_CD_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud020.cmd.VLUD020CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD+"&HEAD_CD="+HEAD_CD;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�׸񺰿�������Ȳ</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�׸񺰿�������Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="160"></col>
                                <col width="50"></col>
                                <col width="180"></col>
                                <col width="50"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="fnc_SearchItem();fnc_ChangeHEAD_CD_SHR();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">ȸ��&nbsp;</td>
                                <td class="padding2423" colspan="3">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select> </td>
                                </td>
                                <input type=hidden name=txtFLAG>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <select name="cmbHEAD_CD_SHR" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="3"  maxlength="3" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="9"  maxlength="9" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle"  onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1')"></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

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
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                   value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                 value="false">
                            <param name="DragDropEnable"           value="true">
                            <param name="SortView"                 value="Left">
                            <param name="ColSizing"                value="true">
                            <param name="FixSizing"                value="true">
                            <param name="VIEWSUMMARY"              value=0>
                            <param name="Format"                   value="
                                <FC> id='{currow}'     width=35    name='����'      align=center </FC>
                                <FC> id='GROUP_NM'     width=70    name='�򰡱׷�'  align=center </FC>
                                <FC> id='HEAD_NM'      width=90    name='����'      align=center </FC>
                                <FC> id='DPT_NM'       width=90    name='�Ҽ�'      align=center </FC>
                                <FC> id='JOB_NM'       width=53    name='����'      align=center </FC>
                                <FC> id='ENO_NO'       width=60    name='���'      align=center </FC>
                                <FC> id='ENO_NM'       width=60    name='����'      align=center </FC>
                                <G> name='1��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_211'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_212'   width=40    name='������'    align=right </C>
                                    <C> id='PNT_213'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_21'    width=40    name='�Ұ�'      align=right Dec=2 Value={(PNT_211+PNT_212+PNT_213)}</C>
                                </G>
                                <G> name='2��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_221'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_222'   width=40    name='������'    align=right </C>
                                    <C> id='PNT_223'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_22'    width=40    name='�Ұ�'      align=right Dec=2 Value={(PNT_221+PNT_222+PNT_223)}</C>
                                </G>
                                <G> name='3��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_231'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_232'   width=40    name='������'    align=right show=false </C>
                                    <C> id='PNT_233'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_23'    width=40    name='�Ұ�'      align=right show=false Dec=2 Value={(PNT_231+PNT_232+PNT_233)}</C>
                                </G>
                                <G> name='����1��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_111'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_112'   width=40    name='������'    align=right </C>
                                    <C> id='PNT_113'   width=40    name='����'      align=right </C>
                                    <C> id='PNT_11'    width=40    name='�Ұ�'      align=right Dec=2 Value={(PNT_111+PNT_112+PNT_113)}</C>
                                </G>
                                <G> name='����2��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_121'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_122'   width=40    name='������'    align=right show=false </C>
                                    <C> id='PNT_123'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_12'    width=40    name='�Ұ�'      align=right show=false Dec=2 Value={(PNT_121+PNT_122+PNT_123)}</C>
                                </G>
                                <G> name='����3��' HeadBgColor='#F7DCBB'
                                    <C> id='PNT_131'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_132'   width=40    name='������'    align=right show=false </C>
                                    <C> id='PNT_133'   width=40    name='����'      align=right show=false </C>
                                    <C> id='PNT_13'    width=40    name='�Ұ�'      align=right show=false Dec=2 Value={(PNT_131+PNT_132+PNT_133)}</C>
                                </G>
                            ">
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