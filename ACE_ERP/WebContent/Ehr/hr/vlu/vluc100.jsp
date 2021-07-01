<!--
    ************************************************************************************
    * @Source         : vluc100.jsp 					                                 *
    * @Description    : ����������ȹ ����.           *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/12  |  ���ؼ�   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>����������ȹ����(vluc100)</title>
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

		var btnList = 'TFTTFFFT';
		var flag = false;		//��ǥ���� �Է±Ⱓ ����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

			if( searchDiv == '1' || searchDiv == undefined ) {
				//����������ȹ �ʱ�ȭ
	            document.getElementById("resultMessagesub").innerText = '';
				dsT_EV_AIMSUB.ClearAll();

				if( !fnc_SearchItemCheck() ) return;

	            //�����ͼ� ����(��ǥ���� ��ȸ)
	            dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SHR&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtAIM_YMD_SHR=1900-01-01&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbEVLENO_NO_SHR="+document.getElementById("cmbEVLENO_NO_SHR").value;
	            dsT_EV_AIMLST.Reset();
            }

			if( searchDiv == '2' ) {
	            //�����ͼ� ����(����������ȹ ��ȸ)
	            dsT_EV_AIMSUB.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SHR_01&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtAIM_YMD_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO")+"&txtAIM_SEQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
	            dsT_EV_AIMSUB.Reset();
            }

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem(searchDiv) {

			if( searchDiv == '1' ) {
	            //�⵵�� ��ȸ������ ��ȸ
	            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&txtEVL_GBN_SHR=2";
	            dsT_EV_ESTINFO.Reset();
            }

			if( searchDiv == '2' ) {
	            //ITEM_SEQ �ִ밪 ��ȸ
	            dsT_EV_AIMSUB_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc040.cmd.VLUC040CMD&S_MODE=SHR_02&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtAIM_YMD_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO")+"&txtAIM_SEQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_SEQ");
	            dsT_EV_AIMSUB_01.Reset();
            }

			if( searchDiv == '3' ) {
	            //��ǥ���ΰ� �򰡿��� ��ȸ
	            dsT_EV_AIMSUB_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_01&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtAIM_YMD_SHR=1900-01-01&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbEVLENO_NO_SHR="+document.getElementById("cmbEVLENO_NO_SHR").value;
	            dsT_EV_AIMSUB_02.Reset();
            }

			if( searchDiv == '4' ) {
	            //���� ��ȸ
	            dsT_EV_EVLIST_DT.DataID = "/servlet/GauceChannelSVL?cmd=common.combo.evlenonm.cmd.EVLENONMCMD&S_MODE=SHR&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
	            dsT_EV_EVLIST_DT.Reset();
            }

        }

        /******************
         * 03. ���� �Լ�  *
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

			//Ʈ����� ����
			trT_EV_AIMSUB.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc100.cmd.VLUC100CMD&S_MODE=SAV";
			trT_EV_AIMSUB.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

			if( !fnc_SaveItemCheck('2') ) return;

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_AIMSUB.CountColumn == 0) {
                dsT_EV_AIMSUB.setDataHeader("EVL_YY:STRING, EVL_FRQ:INT, AIM_YMD:STRING, ENO_NO:STRING, EVLENO_NO:STRING, AIM_SEQ:INT, ITEM_SEQ:INT, ITEM_DEC:STRING:NOTNULL, T_CHECK:STRING, JAN_UP:STRING, JAN_DN:STRING, FEB_UP:STRING, FEB_DN:STRING, MAR_UP:STRING, MAR_DN:STRING, APR_UP:STRING, APR_DN:STRING, MAY_UP:STRING, MAY_DN:STRING, JUN_UP:STRING, JUN_DN:STRING, JUL_UP:STRING, JUL_DN:STRING, AUG_UP:STRING, AUG_DN:STRING, SEP_UP:STRING, SEP_DN:STRING, OCT_UP:STRING, OCT_DN:STRING, NOV_UP:STRING, NOV_DN:STRING, DEC_UP:STRING, DEC_DN:STRING ");
	            fnc_SearchItem('2');		//�����׸� ���� �ִ밪 ��ȸ
            } else {
            	var maxItemSeq = 0;
	            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
	            dsT_EV_AIMSUB.AddRow();

				//�����׸���� �ִ밪 ���ϱ�.
	            for( i=1; i<=dsT_EV_AIMSUB.CountRow; i++ ) {
	            	if( maxItemSeq < dsT_EV_AIMSUB.NameValue(i,"ITEM_SEQ") )
						maxItemSeq=dsT_EV_AIMSUB.NameValue(i,"ITEM_SEQ");
				}

				//�׸��� �ڷ� ����
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
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_AIMSUB.AddRow();

			//�׸��� �ڷ� ����
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
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_AIMSUB.CountRow < 1) {
                alert("���� �� �ڷᰡ �����ϴ�.");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_AIMSUB.NameValue(dsT_EV_AIMSUB.RowPosition,"ITEM_DEC") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_AIMSUB.DeleteRow(dsT_EV_AIMSUB.RowPosition);

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_AIMSUB.SetColumn(form1.grdT_EV_AIMSUB.GetColumnID(form1.grdT_EV_AIMSUB.GetColumnIndex("ITEM_DEC")));
            form1.grdT_EV_AIMSUB.Focus();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = '';
			dsT_EV_AIMLST.ClearAll();
            document.getElementById("resultMessagesub").innerText = '';
			dsT_EV_AIMSUB.ClearAll();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        if (dsT_EV_AIMSUB.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			if( !valid(form1) )
				return false;
			else
				return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck(searchDiv) {

			if( searchDiv == '1') { 		//����� ��ȿ�� üũ
	        	if ( dsT_EV_AIMSUB.isUpdated ) {
	        		for( i=1; i<=dsT_EV_AIMSUB.CountRow; i++ ) {
						if( dsT_EV_AIMSUB.RowStatus(i) == 1 || dsT_EV_AIMSUB.RowStatus(i) == 2 || dsT_EV_AIMSUB.RowStatus(i) == 3 ) {
							if( dsT_EV_AIMSUB.NameValue(i, "ITEM_SEQ") == '' ) {
								alert("������ �ʼ��Է»����Դϴ�..");
								dsT_EV_AIMSUB.RowPosition = i;
	                            form1.grdT_EV_AIMSUB.SetColumn("ITEM_SEQ");
	                            form1.grdT_EV_AIMSUB.focus();
								return false;
							}
							if( dsT_EV_AIMSUB.NameValue(i, "ITEM_DEC") == '' ) {
								alert("�ֿ������׸��� �ʼ��Է»����Դϴ�..");
								dsT_EV_AIMSUB.RowPosition = i;
	                            form1.grdT_EV_AIMSUB.SetColumn("ITEM_DEC");
	                            form1.grdT_EV_AIMSUB.focus();
								return false;
							}
						}
					}
				} else {
					fnc_Message(document.getElementById("resultMessage"),"MSG_04");
					alert("���� �� �ڷᰡ �����ϴ�!");
	                return false;
				}
				return true;
			}

			if( searchDiv == '2') { 		//�߰�,���Ž� ��ȿ�� üũ
	        	if ( dsT_EV_AIMLST.CountRow == 0 ) {
					alert("������ ��ǥ���� ������ �����ϴ�");
					return false;
				}
				return true;
			}

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_AIMLST, 15, "false", "false");
            cfStyleGrid(form1.grdT_EV_AIMSUB, 15, "true", "false");

			//�⵵�� ��ȸ������ ��ȸ
			fnc_SearchItem('1');

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ��ǥ���� ���ο� ����,		*
         *		����������ȹ�� �Է� disable,							*
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
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
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
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_AIMSUB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_AIMSUB)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

	<script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
		//����������ȹ ��ȸ
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

		fnc_SearchItem('3');		//��ǥ���ο��� ��ȸ

        if (iCount == 0)    {

			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

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

			alert("�����׸���� �ִ밪�� �����ϴ�.");

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Append();

        }

    </Script>

    <Script For=dsT_EV_AIMSUB_02 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			alert("��ǥ���ο��� ���� �����ϴ�.");

        } else {

			//�򰡿��� ��ȸ
			if( dsT_EV_AIMSUB_02.NameValue(2,"AIM_YMD") != '' ) {
				fnc_DisableSet('true');		//�ԷºҰ� ó��
				alert("�򰡰� �������̰ų� �Ϸ�Ǿ����Ƿ� ����������ȹ���� �Է� �Ұ��մϴ�.");
				return;
			} else {
				fnc_DisableSet('false');		//�Է°��� ó��
			}

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			if( dsT_EV_AIMSUB_02.NameValue(1,"ACCEPT_GBN") == '1' ) {		//�����ϰ�� ó��
				fnc_DisableSet('true');		//�ԷºҰ� ó��
				alert("����ó�� �Ǿ����Ƿ� ���� �Ұ� �մϴ�.");
			} else {
				fnc_DisableSet('false');		//�Է°��� ó��
			}

        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

			document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';
            alert("������Ⱓ�� �ƴմϴ�.");

        } else {

			document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
			document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
			document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
			document.getElementById("txtENO_NM_SHR").value = '<%=box.get("SESSION_ENONM")%>';
			document.getElementById("txtDPT_NM_SHR").value = '<%=box.get("SESSION_DPTNM")%>';

        }

		//���� ��ȸ
		fnc_SearchItem('4');

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {


        } else {

			//����
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
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_AIMSUB Event="OnLoadError()">

        document.getElementById("resultMessagesub").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_AIMSUB Event="OnDataError()">

        document.getElementById("resultMessagesub").innerText = ' ';

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�ֿ������׸�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�ֿ������׸� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_AIMSUB event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
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
	                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������ȹ����</td>
	                    <td align="right" class="navigator">HOME/�λ���/������/<font color="#000000">����������ȹ����</font></td>
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
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1')"></a>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
		            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
					<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<!-- ���� �Է� ���̺� �� -->

	<!-- power Search���̺� ���� -->
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
	                                <td align="right" class="searchState">�ش�⵵</td>
	                                <td class="padding2423">
	                                	<input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">ȸ��</td>
	                                <td class="padding2423">
										<input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">�Ҽ�</td>
	                                <td class="padding2423">
	                                	<input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
	                                </td>
	                                <td align="right" class="searchState">������ ���</td>
	                                <td class="padding2423">
	                                	<input id=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly style="text-align:center:">
	                                </td>
									<td align="right" class="searchState">����</td>
	                                <td class="padding2423">
	                                	<input id=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly style="text-align:center;">
	                                </td>
	                                <td align="right" class="searchState">����</td>
	                                <td class="padding2423">
		                                    <select id=cmbEVLENO_NO_SHR style="width:100" valid='key=true' field='����' onChange="fnc_SearchList('1');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
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
	<!-- power Search���̺� �� -->

	<!-- ��ȸ ���� ���̺� ���� -->
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
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
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
									<C> id='EVL_YY'       width=40        name='�ش�⵵'     align=center		show=false </C>
									<C> id='EVL_FRQ'       width=40        name='��ȸ��'     align=center		show=false </C>
									<C> id='AIM_YMD'       width=40        name='��ǥ��������'     align=center		show=false </C>
									<C> id='ENO_NO'       width=40        name='�����ڻ��'     align=center		show=false </C>
									<C> id='EVLENO_NO'       width=40        name='���ڻ��'     align=center		show=false </C>
									<C> id='AIM_SEQ'       width=50        name='����'     align=center 		show=false </C>
									<C> id='TASK_AIM'       width=208        name='�ֿ������ǥ'     align=left	</C>
									<C> id='BASIC_PAR'       width=208        name='��������ǥ'     align=left </C>
									<C> id='GAUGE_GB'       width=60        name='�跮����'     align=center	editstyle=combo	data='1:�跮,2:��跮' </C>
									<C> id='AIM_LEVEL'       width=208        name='��ǥ����'     align=left </C>
									<C> id='ADDING_PCT'       width=40        name='����ġ'     align=right </C>
									<C> id='DIFFICULT_PNT'       width=40        name='���̵�'     align=center		editstyle=combo	data='10:10,20:20' </C>
									<C> id='ACCEPT_GBN'       width=80        name='��ǥ���ο���'     align=center		show=false </C>
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
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
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
										<C> id='ITEM_SEQ'		width=40		name='����'			align=center		edit=none		show=false </C>
										<C> id='ITEM_DEC'		width=289	    name='�ֿ������׸�'	align=Left	editlimit=200 </C>
										<C> id='T_CHECK'		width=19		name='��\\\\ü'			align=center		editstyle=checkbox </C>
										<X> name='���� ����' HeadBgColor='#F7DCBB'
											<G> name='1��' HeadBgColor='#F7DCBB'
												<C> id='JAN_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='JAN_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='2��' HeadBgColor='#F7DCBB'
												<C> id='FEB_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='FEB_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='3��' HeadBgColor='#F7DCBB'
												<C> id='MAR_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='MAR_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='4��' HeadBgColor='#F7DCBB'
												<C> id='APR_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='APR_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='5��' HeadBgColor='#F7DCBB'
												<C> id='MAY_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='MAY_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='6��' HeadBgColor='#F7DCBB'
												<C> id='JUN_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='JUN_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='7��' HeadBgColor='#F7DCBB'
												<C> id='JUL_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='JUL_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='8��' HeadBgColor='#F7DCBB'
												<C> id='AUG_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='AUG_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='9��' HeadBgColor='#F7DCBB'
												<C> id='SEP_UP'		width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='SEP_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='10��' HeadBgColor='#F7DCBB'
												<C> id='OCT_UP'	width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='OCT_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='11��' HeadBgColor='#F7DCBB'
												<C> id='NOV_UP'	width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='NOV_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
											</G>
											<G> name='12��' HeadBgColor='#F7DCBB'
												<C> id='DEC_UP'	width=19		name='��'		align=center		editstyle=checkbox </C>
												<C> id='DEC_DN'	width=19		name='��'		align=center		editstyle=checkbox </C>
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	</form>
	<!-- form �� -->

	<!-- Validation Init  -->
	<jsp:include page="/common/CommonValid.jsp" flush="true">
	   <jsp:param name="INIT"    value="false"/>
	</jsp:include>

</body>
</html>