<!--
***********************************************************************
* @source      : crua040.jsp
* @description : ä���������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/04      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>ä����������(crua040)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript">

		var btnList = 'TFTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {
            if (dsT_RC_HISTORY.IsUpdated)  {
                if(!confirm("���� �Ϸ���� ���� �۾��� �ֽ��ϴ�. ��ȸ�� ����Ͻðڽ��ϱ�?")) return;
            }

			var f = document.form1;
            var pis_yy = f.txtPIS_YY_SHR.value;
			var seq_no = f.txtSEQ_NO_SHR.value;

			if(!fnc_SearchItemCheck()) return;

			dsT_RC_HISTORY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no;
			dsT_RC_HISTORY.reset();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmp(eno_noId) {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetEnoNm(eno_noId);
            document.getElementById(eno_noId.replace(/_NO/g, "_NM")).value = obj.eno_nm;
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 *
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�ѹ��� �Ѱ��� �����͸� �Է�, ���� �� �� �ֵ��� ��
            for(i=1;i<=dsT_RC_HISTORY.CountRow;i++){
                if(dsT_RC_HISTORY.RowStatus(i) != 0){
                    document.getElementById('txtPIS_YY').focus();
                    return;
                }
            }

            //DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_RC_HISTORY.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_RC_HISTORY.setDataHeader("PIS_YY:STRING:KEYVALUE, SEQ_NO:STRING:KEYVALUE, PRO_GBN:STRING, GBN_TAG:STRING, APP_STR_YMD:STRING, APP_END_YMD:STRING, FST_STR_YMD:STRING, FST_END_YMD:STRING, SND_STR_YMD:STRING, SND_END_YMD:STRING, TRD_STR_YMD:STRING, TRD_END_YMD:STRING, BDY_STR_YMD:STRING, BDY_END_YMD:STRING, PAS_STR_YMD:STRING, PAS_END_YMD:STRING, ITV11_ENO_NO:STRING, ITV12_ENO_NO:STRING, ITV13_ENO_NO:STRING, ITV14_ENO_NO:STRING, ITV15_ENO_NO:STRING, ITV21_ENO_NO:STRING, ITV22_ENO_NO:STRING, ITV23_ENO_NO:STRING, ITV24_ENO_NO:STRING, ITV25_ENO_NO:STRING, ITV31_ENO_NO:STRING, ITV32_ENO_NO:STRING, ITV33_ENO_NO:STRING, ITV34_ENO_NO:STRING, ITV35_ENO_NO:STRING");
			}

            dsT_RC_HISTORY.AddRow();

            document.getElementById('txtPIS_YY').focus();

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";

        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_RC_HISTORY.ClearData();//�����ͼ� �ʱ�ȭ

            fnc_DisableElementAll(elementList);
            fnc_DisableElementAll(procBtnList);

            document.getElementById('txtPIS_YY_SHR').focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_RC_HISTORY.IsUpdated)  {
				if (!fnc_ExitQuestion()) return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

			var pis_yy = document.getElementById('txtPIS_YY_SHR');
			var seq_no = document.getElementById('txtSEQ_NO_SHR');

			if(pis_yy.value == '' || pis_yy.value.length < 4) {
				alert("4�ڸ����� ä��⵵�� �Է��ϼ���!");
				pis_yy.focus();
				return false;
			}
			if(seq_no.value == '' || seq_no.value.length < 2) {
				alert("2�ڸ����� ä�������� �Է��ϼ���!");
				seq_no.focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   *
         ********************************************/
        function fnc_OnLoadProcess() {
            fnc_DisableElementAll(elementList);
            fnc_DisableElementAll(procBtnList); //��ư��
            fnc_DisableElementAll(appList);     //�����ɻ�
            fnc_DisableElementAll(fstList);     //1������
            fnc_DisableElementAll(sndList);     //2������
            fnc_DisableElementAll(trdList);     //3������
            fnc_DisableElementAll(bdyList);     //��ü�˻�
            fnc_DisableElementAll(pasList);     //�����հ�

            document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";

			document.getElementById("txtPIS_YY_SHR").focus();
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        var elementList = new Array( "txtPIS_YY"
                                    ,"txtSEQ_NO"
                                    ,"cmbPRO_GBN"
                                    ,"cmbGBN_TAG");

        //���������Ⱓ  ��ü
        var appList = new Array(     "txtAPP_STR_YMD"
                                    ,"txtAPP_END_YMD"
                                    ,"imgAPP_STR_YMD"
                                    ,"imgAPP_END_YMD" );

        //1�������Ⱓ   ��ü
        var fstList = new Array(     "txtFST_STR_YMD"
                                    ,"txtFST_END_YMD"
                                    ,"imgFST_STR_YMD"
                                    ,"imgFST_END_YMD"
                                    ,"txtITV11_ENO_NO"
                                    ,"txtITV12_ENO_NO"
                                    ,"txtITV13_ENO_NO"
                                    ,"txtITV14_ENO_NO"
                                    ,"txtITV15_ENO_NO"
                                    ,"txtITV11_ENO_NM"
                                    ,"txtITV12_ENO_NM"
                                    ,"txtITV13_ENO_NM"
                                    ,"txtITV14_ENO_NM"
                                    ,"txtITV15_ENO_NM"
                                    ,"ImgEnoNoShr11"
                                    ,"ImgEnoNoShr12"
                                    ,"ImgEnoNoShr13"
                                    ,"ImgEnoNoShr14"
                                    ,"ImgEnoNoShr15" );

        //2�������Ⱓ ��ü
        var sndList = new Array(     "txtSND_STR_YMD"
                                    ,"txtSND_END_YMD"
                                    ,"imgSND_STR_YMD"
                                    ,"imgSND_END_YMD"
                                    ,"txtITV21_ENO_NO"
                                    ,"txtITV22_ENO_NO"
                                    ,"txtITV23_ENO_NO"
                                    ,"txtITV24_ENO_NO"
                                    ,"txtITV25_ENO_NO"
                                    ,"txtITV21_ENO_NM"
                                    ,"txtITV22_ENO_NM"
                                    ,"txtITV23_ENO_NM"
                                    ,"txtITV24_ENO_NM"
                                    ,"txtITV25_ENO_NM"
                                    ,"ImgEnoNoShr21"
                                    ,"ImgEnoNoShr22"
                                    ,"ImgEnoNoShr23"
                                    ,"ImgEnoNoShr24"
                                    ,"ImgEnoNoShr25" );

        //3�������Ⱓ ��ü
        var trdList = new Array(     "txtTRD_STR_YMD"
                                    ,"txtTRD_END_YMD"
                                    ,"imgTRD_STR_YMD"
                                    ,"imgTRD_END_YMD"
                                    ,"txtITV31_ENO_NO"
                                    ,"txtITV32_ENO_NO"
                                    ,"txtITV33_ENO_NO"
                                    ,"txtITV34_ENO_NO"
                                    ,"txtITV35_ENO_NO"
                                    ,"txtITV31_ENO_NM"
                                    ,"txtITV32_ENO_NM"
                                    ,"txtITV33_ENO_NM"
                                    ,"txtITV34_ENO_NM"
                                    ,"txtITV35_ENO_NM"
                                    ,"ImgEnoNoShr31"
                                    ,"ImgEnoNoShr32"
                                    ,"ImgEnoNoShr33"
                                    ,"ImgEnoNoShr34"
                                    ,"ImgEnoNoShr35" );

        //��ü�˻� ����
        var bdyList = new Array(     "txtBDY_STR_YMD"
                                    ,"txtBDY_END_YMD"
                                    ,"imgBDY_STR_YMD"
                                    ,"imgBDY_END_YMD" );

        //�����հ��� ���� ��ü
        var pasList = new Array(     "txtPAS_STR_YMD"
                                    ,"txtPAS_END_YMD"
                                    ,"imgPAS_STR_YMD"
                                    ,"imgPAS_END_YMD" );

        //��ư��
        var procBtnList = new Array( "btn_1"
                                    ,"btnPRO_STS_1"
                                    ,"btnPRO_STS_2"
                                    ,"btnPRO_STS_3"
                                    ,"btnPRO_STS_4"
                                    ,"btnPRO_STS_5"
                                    ,"btnPRO_STS_6"
                                    ,"btnPRO_STS_7"
                                    ,"btnPRO_STS_8"
                                    ,"btnPRO_STS_RESET" );

        /**
         * �۾������� ���� �����Ѵ�.
         * @param sel_sts - ������ �����ڵ�
         */
        function fnc_check(sel_sts) {
            if(document.getElementById("txtPIS_YY").value == '' || document.getElementById("txtPIS_YY").value.length < 4) {
				alert("4�ڸ����� ä��⵵�� �Է��ϼ���!");
				document.getElementById("txtPIS_YY").focus();
				return false;
			}
			if(document.getElementById("txtSEQ_NO").value == '' || document.getElementById("txtSEQ_NO").value.length < 2) {
				alert("2�ڸ����� ä�������� �Է��ϼ���!");
				document.getElementById("txtSEQ_NO").focus();
				return false;
			}
			if(document.getElementById("cmbGBN_TAG").value ==""){
    			alert("ä�뱸���� ������ �ּ���.");
    			document.getElementById("cmbGBN_TAG").focus();
    			return false;
			}
            if(document.getElementById("cmbPRO_GBN").value == "") {
                alert("��������� ������ �ּ���.");
                document.getElementById("cmbPRO_GBN").focus();
                return false;
            }

			//�Է��� ��¥�� ��ȿ�� üũ
            var strYmdList = new Array(     "txtAPP_STR_YMD"
                                           ,"txtFST_STR_YMD"
                                           ,"txtSND_STR_YMD"
                                           ,"txtTRD_STR_YMD"
                                           ,"txtBDY_STR_YMD"
                                           ,"txtPAS_STR_YMD"
                                           );
            var endYmdList = new Array(     "txtAPP_END_YMD"
                                           ,"txtFST_END_YMD"
                                           ,"txtSND_END_YMD"
                                           ,"txtTRD_END_YMD"
                                           ,"txtBDY_END_YMD"
                                           ,"txtPAS_END_YMD"
                                           );

            var ymdMsgList = new Array(     "��������"
                                           ,"1����������"
                                           ,"2����������"
                                           ,"3����������"
                                           ,"��ü�˻����"
                                           ,"�����հ��ڹ�ǥ"
                                           );

            var sts_num = fnc_covNumber(sel_sts)-1 == 0 ? 1 : fnc_covNumber(sel_sts)-2;
            for(var i=0; i<sts_num; i++) {
                if(document.getElementById(strYmdList[i]).value == "") {
                    alert(ymdMsgList[i]+" �������� �Է��� �ּ���.");
                    document.getElementById(strYmdList[i]).focus();
                    return false;
                }
                if(document.getElementById(endYmdList[i]).value == "") {
                    alert(ymdMsgList[i]+" �������� �Է��� �ּ���.");
                    document.getElementById(endYmdList[i]).focus();
                    return false;
                }
            }


            var enoList;
            var eno_no;

            for(var k=1; k<=3; k++) {
                enoList = new Array(         "txtITV"+k+"1_ENO_NO"
                                            ,"txtITV"+k+"2_ENO_NO"
                                            ,"txtITV"+k+"3_ENO_NO"
                                            ,"txtITV"+k+"4_ENO_NO"
                                            ,"txtITV"+k+"5_ENO_NO"
                                            );

                for(var i=0; i<enoList.length; i++) {
                    eno_no = document.getElementById(enoList[i]).value;
                    if(eno_no == "") continue;

                    for(var j=0; j<enoList.length; j++) {
                        if(i == j) continue;

                        if(eno_no == document.getElementById(enoList[j]).value) {
                            alert(k+"�� ������ ������ �� �ߺ��� ����� �����մϴ�.");
                            document.getElementById(enoList[j]).focus();
                            return false;
                        }
                    }
                }
            }

			return true;
        }

        /**
         * �۾�OPEN �� �����սô�.
         * @param - sel_sts (PRO_STS  1, �۾�����    2, �����ɻ���ذ���    3, ����������    4, 1�������Ϸ�    5, 2�������Ϸ�    6, 3�������Ϸ�    7, ��ü�˻�Ϸ�    8, �۾� CLOSE)
         */
        function fnc_PROSTS(sel_sts) {

            //��ȿ�� ����
            if(!fnc_check(sel_sts)) {
                return;
            }

            var msg = " �۾��� �Ͻðڽ��ϱ�?";
            switch(sel_sts) {
                case 1: msg = "�۾�OPEN"        +msg; break;
                case 2: msg = "�����ɻ���ذ���" +msg; break;
                case 3: msg = "����������"      +msg; break;
                case 4: msg = "1�������Ϸ�"     +msg; break;
                case 5: msg = "2�������Ϸ�"     +msg; break;
                case 6: msg = "3�������Ϸ�"     +msg; break;
                case 7: msg = "��ü�˻�Ϸ�"    +msg; break;
                case 8: msg = "�۾�CLOSE"       +msg; break;
            }

            if(!confirm(msg)) {
                return;
            }


            dsT_RC_HISTORY.NameValue(1, "PRO_STS") = sel_sts;

            trT_RC_HISTORY.KeyValue = "tr01(I:dsT_RC_HISTORY=dsT_RC_HISTORY)";
            trT_RC_HISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=PROC";
            trT_RC_HISTORY.post();
        }


        /**
         * ���۾� ó��
         */
        function fnc_PROSTS_RESET() {

            var PRO_STS = dsT_RC_HISTORY.NameValue(1, "PRO_STS")


            var msg = " ���۾��Ͻðڽ��ϱ�?";
            switch(PRO_STS) {
                case 2: msg = "�����ɻ���ذ���" +msg; break;
                case 3: msg = "����������"      +msg; break;
                case 4: msg = "1�������Ϸ�"     +msg; break;
                case 5: msg = "2�������Ϸ�"     +msg; break;
                case 6: msg = "3�������Ϸ�"     +msg; break;
                case 7: msg = "��ü�˻�Ϸ�"    +msg; break;
            }

            if(!confirm(msg)) {
                return;
            }

            dsT_RC_HISTORY.NameValue(1, "PRO_STS") = fnc_covNumber(PRO_STS)-1;

            trT_RC_HISTORY.KeyValue = "tr01(I:dsT_RC_HISTORY=dsT_RC_HISTORY)";
            trT_RC_HISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua040.cmd.CRUA040CMD&S_MODE=RESET";
            trT_RC_HISTORY.post();

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet								|
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_HISTORY)	|
    | 3. ���Ǵ� Table List(T_RC_HISTORY)			|
    +----------------------------------------------->
    <Object ID="dsT_RC_HISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_RC_HISTORY)		|
    | 3. ���Ǵ� Table List(T_RC_HISTORY)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_HISTORY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_RC_HISTORY Event="OnLoadCompleted(iCount)">
        fnc_DisableElementAll(elementList);
        fnc_DisableElementAll(procBtnList); //��ư��
        fnc_DisableElementAll(appList);     //�����ɻ�
        fnc_DisableElementAll(fstList);     //1������
        fnc_DisableElementAll(sndList);     //2������
        fnc_DisableElementAll(trdList);     //3������
        fnc_DisableElementAll(bdyList);     //��ü�˻�
        fnc_DisableElementAll(pasList);     //�����հ�

        document.getElementById("resultMessage").innerText = ' ';

        if (iCount == 0) {
            dsT_RC_HISTORY.AddRow();

            //�۾������� �����ϰ�
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ChangeStateElement(true, "btnPRO_STS_1");

            fnc_EnableElementAll(elementList);
            fnc_EnableElementAll(appList);      //�����ɻ�
            fnc_EnableElementAll(fstList);      //1������
            fnc_EnableElementAll(sndList);      //2������
            fnc_EnableElementAll(trdList);      //3������
            fnc_EnableElementAll(bdyList);      //��ü�˻�
            fnc_EnableElementAll(pasList);      //�����հ�


            document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;
            document.getElementById("txtSEQ_NO").value = document.getElementById("txtSEQ_NO_SHR").value;

        } else {

            switch (dsT_RC_HISTORY.NameValue(1, "PRO_STS")) {
                case "1" :  // �۾�OPEN �Ϸ����
                    fnc_ChangeStateElement(true, "btnPRO_STS_2");

                    fnc_EnableElementAll(appList);      //�����ɻ�
                    fnc_EnableElementAll(fstList);      //1������
                    fnc_EnableElementAll(sndList);      //2������
                    fnc_EnableElementAll(trdList);      //3������
                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "2" :  // �����ɻ���ذ���
                    fnc_ChangeStateElement(true, "btnPRO_STS_3");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(appList);      //�����ɻ�
                    fnc_EnableElementAll(fstList);      //1������
                    fnc_EnableElementAll(sndList);      //2������
                    fnc_EnableElementAll(trdList);      //3������
                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "3" :  // ���������� �Ϸ����
                    fnc_ChangeStateElement(true, "btnPRO_STS_4");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(fstList);      //1������
                    fnc_EnableElementAll(sndList);      //2������
                    fnc_EnableElementAll(trdList);      //3������
                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "4" :  // 1�������Ϸ� ����
                    fnc_ChangeStateElement(true, "btnPRO_STS_5");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(sndList);      //2������
                    fnc_EnableElementAll(trdList);      //3������
                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "5" :  // 2�������Ϸ����
                    fnc_ChangeStateElement(true, "btnPRO_STS_6");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(trdList);      //3������
                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "6" :  // 3�������Ϸ����
                    fnc_ChangeStateElement(true, "btnPRO_STS_7");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(bdyList);      //��ü�˻�
                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "7" :  // ��ü�˻�Ϸ�
                    fnc_ChangeStateElement(true, "btnPRO_STS_8");
                    fnc_ChangeStateElement(true, "btnPRO_STS_RESET");

                    fnc_EnableElementAll(pasList);      //�����հ�

                    break;

                case "8" :  // �۾��Ϸ����

                    break;
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_RC_HISTORY Event="OnLoadError()">

		document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_HISTORY Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_RC_HISTORY event="OnSuccess()">
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_RC_HISTORY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ä����������</td>
					<td align="right" class="navigator">HOME/��Ÿ/ä�����/<font color="#000000">ä����������</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="60"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">ä��⵵&nbsp;</td>
								<td class="padding2423">
                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>
								</td>
								<td align="center" class="searchState">ä������&nbsp;</td>
								<td class="padding2423">
									<input id="txtSEQ_NO_SHR"  size="4" maxLength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
								</td>
								<td>&nbsp;</td>
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

<!-- ���� �Է� ���̺� ���� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="120"></col>
					<col width="70"></col>
					<col width="100"></col>
					<col width="70"></col>
					<col width="80"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">ä��⵵</td>
					<td class="padding2423"><input id="txtPIS_YY" size="9" maxLength="4" onkeypress="cfCheckNumber2();" style="ime-mode:disabled;"></td>
                    <td align="center" class="creamBold">ä������</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="9" maxLength="2" onkeypress="cfCheckNumber2();" style="ime-mode:disabled;"></td>
                    <td align="center" class="creamBold">ä�뱸��</td>
                    <td class="padding2423">
                        <select id="cmbGBN_TAG" style="WIDTH:100">
                            <option value=""> </option>
                            <option value="A">����</option>
                            <option value="B">���</option>
                        </select>
                    </td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423">
                        <select id="cmbPRO_GBN" style="WIDTH:100">
							<option value=""></option>
							<option value="0">����ä��</option>
							<option value="1">����ä��</option>
						</select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�۾���Ȳ</td>
                    <td  class="padding2423" colspan="8">
                        <input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
                        <input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">

                        <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="194"></col>
                                <col width="194"></col>
                                <col width="194"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_1"  style="cursor:hand;width:110pt;height:25pt;" value=" �۾�OPEN "     onclick="fnc_PROSTS(1);">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_2"  style="cursor:hand;width:110pt;height:25pt;" value=" �����ɻ���ذ����Ϸ� "   onclick="fnc_PROSTS(2);">
                                </td>
                                <td align="center" class="padding2423">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_3"  style="cursor:hand;width:110pt;height:25pt;" value=" �����������Ϸ� "   onclick="fnc_PROSTS(3);">
                                </td>
                            </tr>
                            <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_4"  style="cursor:hand;width:110pt;height:25pt;" value=" 1�������Ϸ� "  onclick="fnc_PROSTS(4);">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_5"  style="cursor:hand;width:110pt;height:25pt;" value=" 2�������Ϸ� "  onclick="fnc_PROSTS(5);">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_6"  style="cursor:hand;width:110pt;height:25pt;" value=" 3�������Ϸ� "  onclick="fnc_PROSTS(6);">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_7"  style="cursor:hand;width:110pt;height:25pt;" value=" ��ü�˻�Ϸ� " onclick="fnc_PROSTS(7);">
                                </td>
                            </tr>
                            <tr height="50">
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_8"  style="cursor:hand;width:110pt;height:25pt;" value=" �۾�CLOSE "    onclick="fnc_PROSTS(8);">
                                </td>
                                <td align="center" class="padding2423">
                                </td>
                                <td align="center" class="padding2423">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnPRO_STS_RESET"  style="cursor:hand;width:110pt;height:25pt;" value=" ���۾� "   onclick="fnc_PROSTS_RESET();">
                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop15">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="*"></col>
				</colgroup>
                <tr >
					<td align="center" class="creamBold">���������Ⱓ</td>
					<td class="padding2423" colspan="7">
						<input id="txtAPP_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtAPP_STR_YMD','txtAPP_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_STR_YMD','','23','225');"></a> ~
						<input id="txtAPP_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtAPP_STR_YMD','txtAPP_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPP_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPP_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_END_YMD','','135','225');"></a>
					</td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop15">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="215"></col>
					<col width="70"></col>
					<col width="165"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
                <tr >
                    <td align="center" class="creamBold">1�� ��������</td>
					<td class="padding2423" >
						<input id="txtFST_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtFST_STR_YMD','txtFST_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFST_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgFST_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtFST_STR_YMD','','23','255');"></a> ~
						<input id="txtFST_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtFST_STR_YMD','txtFST_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFST_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgFST_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtFST_END_YMD','','135','255');"></a>
					</td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV11_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV11_ENO_NO','txtITV11_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV11_ENO_NO','txtITV11_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV11_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV11_ENO_NO','txtITV11_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV11_ENO_NO','txtITV11_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr11" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV11_ENO_NO','txtITV11_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV12_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV12_ENO_NO','txtITV12_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV12_ENO_NO','txtITV12_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV12_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV12_ENO_NO','txtITV12_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV12_ENO_NO','txtITV12_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr12','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr12" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV12_ENO_NO','txtITV12_ENO_NM');"></a>
                    </td>
                </tr>
                <tr >
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV13_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV13_ENO_NO','txtITV13_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV13_ENO_NO','txtITV13_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV13_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV13_ENO_NO','txtITV13_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV13_ENO_NO','txtITV13_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr13" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV13_ENO_NO','txtITV13_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV14_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV14_ENO_NO','txtITV14_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV14_ENO_NO','txtITV14_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV14_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV14_ENO_NO','txtITV14_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV14_ENO_NO','txtITV14_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr14" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV14_ENO_NO','txtITV14_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV15_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV15_ENO_NO','txtITV15_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV15_ENO_NO','txtITV15_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV15_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV15_ENO_NO','txtITV15_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV15_ENO_NO','txtITV15_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr15','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr15" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV15_ENO_NO','txtITV15_ENO_NM');"></a>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop15">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="215"></col>
					<col width="70"></col>
					<col width="165"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
                <tr >
                    <td align="center" class="creamBold">2�� ��������</td>
					<td class="padding2423" >
						<input id="txtSND_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtSND_STR_YMD','txtSND_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSND_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSND_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSND_STR_YMD','','23','315');"></a> ~
						<input id="txtSND_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtSND_STR_YMD','txtSND_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSND_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSND_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSND_END_YMD','','135','315');"></a>
					</td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV21_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV21_ENO_NO','txtITV21_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV21_ENO_NO','txtITV21_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV21_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV21_ENO_NO','txtITV21_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV21_ENO_NO','txtITV21_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr21" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV21_ENO_NO','txtITV21_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV22_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV22_ENO_NO','txtITV22_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV22_ENO_NO','txtITV22_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV22_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV22_ENO_NO','txtITV22_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV22_ENO_NO','txtITV22_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr22','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr22" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV22_ENO_NO','txtITV22_ENO_NM');"></a>
                    </td>
                </tr>
                <tr >
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV23_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV23_ENO_NO','txtITV23_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV23_ENO_NO','txtITV23_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV23_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV23_ENO_NO','txtITV23_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV23_ENO_NO','txtITV23_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr23','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr23" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV23_ENO_NO','txtITV23_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV24_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV24_ENO_NO','txtITV24_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV24_ENO_NO','txtITV24_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV24_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV24_ENO_NO','txtITV24_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV24_ENO_NO','txtITV24_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr24','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr24" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV24_ENO_NO','txtITV24_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV25_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV25_ENO_NO','txtITV25_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV25_ENO_NO','txtITV25_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV25_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV25_ENO_NO','txtITV25_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV25_ENO_NO','txtITV25_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr25','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr25" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV25_ENO_NO','txtITV25_ENO_NM');"></a>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop15">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="215"></col>
					<col width="70"></col>
					<col width="165"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
                <tr >
                    <td align="center" class="creamBold">3�� ��������</td>
					<td class="padding2423" >
						<input id="txtTRD_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtTRD_STR_YMD','txtTRD_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgTRD_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgTRD_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTRD_STR_YMD','','23','375');"></a> ~
						<input id="txtTRD_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtTRD_STR_YMD','txtTRD_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgTRD_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgTRD_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTRD_END_YMD','','135','375');"></a>
					</td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV31_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV31_ENO_NO','txtITV31_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV31_ENO_NO','txtITV31_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV31_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNo('txtITV31_ENO_NO','txtITV31_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV31_ENO_NO','txtITV31_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr31','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr31" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV31_ENO_NO','txtITV31_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV32_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV32_ENO_NO','txtITV32_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV32_ENO_NO','txtITV32_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV32_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNo('txtITV32_ENO_NO','txtITV32_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV32_ENO_NO','txtITV32_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr32','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr32" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV32_ENO_NO','txtITV32_ENO_NM');"></a>
                    </td>
                </tr>
                <tr >
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV33_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV33_ENO_NO','txtITV33_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV33_ENO_NO','txtITV33_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV33_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV33_ENO_NO','txtITV33_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV33_ENO_NO','txtITV33_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr33','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr33" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV33_ENO_NO','txtITV33_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV34_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV34_ENO_NO','txtITV34_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV34_ENO_NO','txtITV34_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV34_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV34_ENO_NO','txtITV34_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV34_ENO_NO','txtITV34_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr34','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr34" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV34_ENO_NO','txtITV34_ENO_NM');"></a>
                    </td>

                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtITV35_ENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode== 13) fnc_GetCommonEnoNm('txtITV35_ENO_NO','txtITV35_ENO_NM');"onchange= "fnc_GetCommonEnoNm('txtITV35_ENO_NO','txtITV35_ENO_NM');" style="ime-mode:disabled">
                        <input id="txtITV35_ENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtITV35_ENO_NO','txtITV35_ENO_NM');" onchange="fnc_GetCommonEnoNo('txtITV35_ENO_NO','txtITV35_ENO_NM');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr35','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr35" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtITV35_ENO_NO','txtITV35_ENO_NM');"></a>
                    </td>
                </tr>
			</table>
		</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop15">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="90"></col>
					<col width="215"></col>
					<col width="105"></col>
					<col width="*"></col>
				</colgroup>
                <tr >
					<td align="center" class="creamBold">��ü�˻����</td>
					<td class="padding2423" >
						<input id="txtBDY_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtBDY_STR_YMD','txtBDY_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBDY_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBDY_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBDY_STR_YMD','','23','255');"></a> ~
						<input id="txtBDY_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtBDY_STR_YMD','txtBDY_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBDY_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgBDY_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBDY_END_YMD','','135','255');"></a>
					</td>
                    <td align="center" class="creamBold">�����հ��ڹ�ǥ</td>
					<td class="padding2423" >
						<input id="txtPAS_STR_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtPAS_STR_YMD','txtPAS_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAS_STR_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAS_STR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAS_STR_YMD','','315','255');"></a> ~
						<input id="txtPAS_END_YMD" size="10" maxLength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtPAS_STR_YMD','txtPAS_END_YMD')" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAS_END_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAS_END_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAS_END_YMD','','430','255');"></a>
					</td>
                </tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- ä�������� ����ܰ� ���� ���̺� -->
<object id="bndT_RC_HISTORY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_HISTORY">
	<Param Name="BindInfo", Value='
		<C>Col=PRO_STS		Ctrl=txtPRO_STS	      	Param=value </C>
		<C>Col=PRO_STS_MSG	Ctrl=txtPRO_STS_MSG    	Param=value </C>
		<C>Col=PIS_YY		Ctrl=txtPIS_YY	      	Param=value </C>
		<C>Col=SEQ_NO		Ctrl=txtSEQ_NO	      	Param=value </C>
        <C>Col=PRO_GBN      Ctrl=cmbPRO_GBN         Param=value </C>
        <C>Col=GBN_TAG      Ctrl=cmbGBN_TAG         Param=value </C>
		<C>Col=APP_STR_YMD  Ctrl=txtAPP_STR_YMD     Param=value </C>
        <C>Col=APP_END_YMD  Ctrl=txtAPP_END_YMD     Param=value </C>
        <C>Col=FST_STR_YMD  Ctrl=txtFST_STR_YMD     Param=value </C>
        <C>Col=FST_END_YMD  Ctrl=txtFST_END_YMD     Param=value </C>
        <C>Col=SND_STR_YMD  Ctrl=txtSND_STR_YMD     Param=value </C>
        <C>Col=SND_END_YMD  Ctrl=txtSND_END_YMD     Param=value </C>
        <C>Col=TRD_STR_YMD  Ctrl=txtTRD_STR_YMD     Param=value </C>
        <C>Col=TRD_END_YMD  Ctrl=txtTRD_END_YMD     Param=value </C>
        <C>Col=BDY_STR_YMD  Ctrl=txtBDY_STR_YMD     Param=value </C>
        <C>Col=BDY_END_YMD  Ctrl=txtBDY_END_YMD     Param=value </C>
        <C>Col=PAS_STR_YMD  Ctrl=txtPAS_STR_YMD     Param=value </C>
        <C>Col=PAS_END_YMD  Ctrl=txtPAS_END_YMD     Param=value </C>
        <C>Col=ITV11_ENO_NO	Ctrl=txtITV11_ENO_NO    Param=value </C>
        <C>Col=ITV12_ENO_NO	Ctrl=txtITV12_ENO_NO    Param=value </C>
        <C>Col=ITV13_ENO_NO	Ctrl=txtITV13_ENO_NO    Param=value </C>
        <C>Col=ITV14_ENO_NO	Ctrl=txtITV14_ENO_NO    Param=value </C>
        <C>Col=ITV15_ENO_NO	Ctrl=txtITV15_ENO_NO    Param=value </C>
        <C>Col=ITV11_ENO_NM	Ctrl=txtITV11_ENO_NM    Param=value </C>
        <C>Col=ITV12_ENO_NM	Ctrl=txtITV12_ENO_NM    Param=value </C>
        <C>Col=ITV13_ENO_NM	Ctrl=txtITV13_ENO_NM    Param=value </C>
        <C>Col=ITV14_ENO_NM	Ctrl=txtITV14_ENO_NM    Param=value </C>
        <C>Col=ITV15_ENO_NM	Ctrl=txtITV15_ENO_NM    Param=value </C>
        <C>Col=ITV21_ENO_NO	Ctrl=txtITV21_ENO_NO    Param=value </C>
        <C>Col=ITV22_ENO_NO	Ctrl=txtITV22_ENO_NO    Param=value </C>
        <C>Col=ITV23_ENO_NO	Ctrl=txtITV23_ENO_NO    Param=value </C>
        <C>Col=ITV24_ENO_NO	Ctrl=txtITV24_ENO_NO    Param=value </C>
        <C>Col=ITV25_ENO_NO	Ctrl=txtITV25_ENO_NO    Param=value </C>
        <C>Col=ITV21_ENO_NM	Ctrl=txtITV21_ENO_NM    Param=value </C>
        <C>Col=ITV22_ENO_NM	Ctrl=txtITV22_ENO_NM    Param=value </C>
        <C>Col=ITV23_ENO_NM	Ctrl=txtITV23_ENO_NM    Param=value </C>
        <C>Col=ITV24_ENO_NM	Ctrl=txtITV24_ENO_NM    Param=value </C>
        <C>Col=ITV25_ENO_NM	Ctrl=txtITV25_ENO_NM    Param=value </C>
        <C>Col=ITV31_ENO_NO	Ctrl=txtITV31_ENO_NO    Param=value </C>
        <C>Col=ITV32_ENO_NO	Ctrl=txtITV32_ENO_NO    Param=value </C>
        <C>Col=ITV33_ENO_NO	Ctrl=txtITV33_ENO_NO    Param=value </C>
        <C>Col=ITV34_ENO_NO	Ctrl=txtITV34_ENO_NO    Param=value </C>
        <C>Col=ITV35_ENO_NO	Ctrl=txtITV35_ENO_NO    Param=value </C>
        <C>Col=ITV31_ENO_NM	Ctrl=txtITV31_ENO_NM    Param=value </C>
        <C>Col=ITV32_ENO_NM	Ctrl=txtITV32_ENO_NM    Param=value </C>
        <C>Col=ITV33_ENO_NM	Ctrl=txtITV33_ENO_NM    Param=value </C>
        <C>Col=ITV34_ENO_NM	Ctrl=txtITV34_ENO_NM    Param=value </C>
        <C>Col=ITV35_ENO_NM	Ctrl=txtITV35_ENO_NM    Param=value </C>
    '>
</object>