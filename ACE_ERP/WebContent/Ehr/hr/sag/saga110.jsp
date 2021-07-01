<!--
***********************************************************************
* @source      : saga110.jsp
* @description : �޿��Ѱ��󼼳����� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/27      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�޿��Ѱ��󼼳�����(saga110)</title>
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

		var btnList = 'TFFTTTFT';

        var today = getToday();

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

			var pis_ym = document.getElementById('txtPIS_YM_SHR').value;
            var ret_gbn = document.getElementById('cmbRET_GBN_SHR').value;

			dsT_CP_PAYMASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.sag.a.saga110.cmd.SAGA110CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&RET_GBN="+ret_gbn;
    		dsT_CP_PAYMASTER.reset();

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

			if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CP_PAYMASTER.GridToExcel("�޿��Ѱ��󼼳�����", '', 225);

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

			//document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
            document.getElementById('cmbRET_GBN_SHR').value = "1";

			document.getElementById("resultMessage").innerText = ' ';

            dsT_CP_PAYMASTER.ClearData();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CP_PAYMASTER.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var pis_ym = document.getElementById('txtPIS_YM_SHR');

            if(pis_ym.value == ""){
                alert("��ȸ����� �Է��ϼž� �մϴ�!");
                pis_ym.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);

			cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"false","false");      // Grid Style ����

			fnc_changeGrid();

            document.getElementById('txtPIS_YM_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		function fnc_changeGrid(){

            var ret_gbn = document.getElementById('cmbRET_GBN_SHR').value;
            var format = "";

            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var preDate   = new Date(PIS_YM.substring(0,4), PIS_YM.substring(5,7)-2, "01");
            var prePIS_YY = preDate.getFullYear();
            var prePIS_MM = lpad((preDate.getMonth()+1),2,"0");
            var lastDay   = fnc_covNumber(fnc_Lastday(prePIS_YY, prePIS_MM));

            var PIS_YM = PIS_YM.substring(0,4)+"�� "+PIS_YM.substring(5,7)+"��";
            var prePIS_YM = prePIS_YY+"�� "+prePIS_MM+"��";

            //�Ի��� ��ȸ
            if(ret_gbn=="1"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=100   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=80    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=80    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HIR_YMD' width=80    name='�Ի���'  align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<G> name='�޿���' HeadBgColor='#F7DCBB'";
                format = format + "<C> id='LAST_AMT'    width=90    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='SALT_AMT'    width=90    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='DIF_SUM' width=90    name='����'       align=right  Value={SALT_AMT-LAST_AMT}    HeadBgColor='#F7DCBB'</C>";
                format = format + "</G>";
                format = format + "<C> id='REMARK'  width=109   name='���'       align=left HeadBgColor='#F7DCBB'</C>";

            //����� ��ȸ
            }else if(ret_gbn=="2"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=100   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=80    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=80    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='RET_YMD' width=80    name='�����'  align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<G> name='�޿���' HeadBgColor='#F7DCBB'";
                format = format + "<C> id='LAST_AMT'    width=90    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='SALT_AMT'    width=90    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='DIF_SUM' width=90    name='����'       align=right  Value={SALT_AMT-LAST_AMT}    HeadBgColor='#F7DCBB'</C>";
                format = format + "</G>";
                format = format + "<C> id='REMARK'  width=109   name='���'       align=left HeadBgColor='#F7DCBB'</C>";

            //3:�ټӼ��纯����
            }else if(ret_gbn=="3"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=100   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=60    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HIR_YMD' width=80    name='�Ի���'  align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='LSEV_YY' width=60    name='�ټӳ��' align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<G> name='�ټӼ���' HeadBgColor='#F7DCBB'";
                format = format + "<C> id='PRE_AMT' width=90    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='CUR_AMT' width=90    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='DIF_SUM' width=90    name='����'       align=right  Value={CUR_AMT-PRE_AMT}    HeadBgColor='#F7DCBB'</C>";
                format = format + "</G>";
                format = format + "<C> id='REMARK'  width=89    name='���'       align=left HeadBgColor='#F7DCBB'</C>";

            //4:����ī��, 5:���ڱ�, 6:���ϱٹ�����, 7:ö�ߴ�������, 8:���ϰ�������, 9:��Ÿ
            }else if(ret_gbn=="4" || ret_gbn=="5" || ret_gbn=="6" || ret_gbn=="7" || ret_gbn=="8" || ret_gbn=="9"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=100   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=80    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=80    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                if(ret_gbn=="4"){
                    format = format + "<G> name='����ī��' HeadBgColor='#F7DCBB'";
                }else if(ret_gbn=="5"){
                    format = format + "<G> name='���ڱ�' HeadBgColor='#F7DCBB'";
                }else if(ret_gbn=="6"){
                    format = format + "<G> name='���ϱٹ�����' HeadBgColor='#F7DCBB'";
                }else if(ret_gbn=="7"){
                    format = format + "<G> name='ö�ߴ�������' HeadBgColor='#F7DCBB'";
                }else if(ret_gbn=="8"){
                    format = format + "<G> name='���ϰ�������' HeadBgColor='#F7DCBB'";
                }else{
                    format = format + "<G> name='�޿���' HeadBgColor='#F7DCBB'";
                }
                format = format + "<C> id='PRE_AMT' width=95    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='CUR_AMT' width=95    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='DIF_SUM' width=95    name='����'       align=right  Value={CUR_AMT-PRE_AMT}    HeadBgColor='#F7DCBB'</C>";
                format = format + "</G>";
                format = format + "<C> id='REMARK'  width=174   name='���'       align=left HeadBgColor='#F7DCBB'</C>";


            }else if(ret_gbn=="10" || ret_gbn=="11"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=100   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=60    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=80    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=80    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HIR_YMD' width=80    name='�Ի���'  align=center HeadBgColor='#F7DCBB'</C>";

                //�⺻���纯����
                if(ret_gbn=="10"){
                    format = format + "<G> name='�⺻����' HeadBgColor='#F7DCBB'";
                    format = format + "<C> id='BEFORE_BAS_AMT'  width=90    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "<C> id='AFTER_BAS_AMT'   width=90    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "<C> id='DIFF_BAS_AMT'    width=90    name='����'       align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "</G>";

                //�������纯����
                }else if(ret_gbn=="11"){
                    format = format + "<G> name='��������' HeadBgColor='#F7DCBB'";
                    format = format + "<C> id='BEFORE_SGF_AMT'  width=90    name='"+prePIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "<C> id='AFTER_SGF_AMT'   width=90    name='"+PIS_YM+"'         align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "<C> id='DIFF_SGF_AMT'    width=90    name='����'       align=right HeadBgColor='#F7DCBB'</C>";
                    format = format + "</G>";
                }

                format = format + "<C> id='REMARK'  width=109   name='���'       align=left HeadBgColor='#F7DCBB'</C>";

            //������Ÿ����, �ݿ���Ÿ����
            }else if(ret_gbn=="12" || ret_gbn=="13"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=120   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=70    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=90    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=90    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HIR_YMD' width=90    name='�Ի���'  align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='SAL_NM'  width=110   name='����'       align=left   HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='REMARK'  width=110   name='����'       align=left   HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='AMOUNT'  width=99    name='�ݾ�'       align=right  HeadBgColor='#F7DCBB'</C>";

            //�����
            }else if(ret_gbn=="14"){
                format = format + "<C> id='OCC_CD'  width=40    name='�ٷα���'     align=center  Show=false</C>";
                format = format + "<C> id='DPT_NM'  width=129   name='�Ҽ�'       align=left  HeadBgColor='#F7DCBB' SubSumText={DECODE(OCC_CD,'0','������ �Ұ�','1','������ �Ұ�','2','������ �Ұ�','3','�ѱ��ΰ���� �Ұ�','8','PJT �Ұ�','9','��ä�� �Ұ�','�� ��')}</C>";
                format = format + "<C> id='JOB_NM'  width=70    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NO'  width=90    name='���'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='ENO_NM'  width=95    name='����'       align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HIR_YMD' width=95    name='�Ի���'  align=center HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='NPEN_AMT'    width=100   name='���ο���'     align=right  HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='HINU_AMT'    width=100   name='�ǰ�����'     align=right  HeadBgColor='#F7DCBB'</C>";
                format = format + "<C> id='OLD_AMT'     width=100    name='���������'       align=right  HeadBgColor='#F7DCBB'</C>";

            }

            document.form1.grdT_CP_PAYMASTER.Format = format;

		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CP_PAYMASTER)   |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)		     |
    +------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <Param name="SubsumExpr"	  value="total,1:OCC_CD">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_changeGrid();

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CP_PAYMASTER.RealCount(0,iCount));

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
		cfErrorMsg(this);

    </Script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޿��Ѱ��󼼳�����</td>
					<td align="right" class="navigator">HOME/�������/�޿�����/<font color="#000000">�޿��Ѱ��󼼳�����</font></td>
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
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
									<col width="100"></col>
                                    <col width="80"></col>
									<col width="140"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
                                <td class="searchState" align="right">��ȸ���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="javascript:if(txtPIS_YM_SHR.readOnly == true){return;} calendarBtn('datetype2','txtPIS_YM_SHR','','50','107');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td class="searchState" align="right">��ȸ����&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbRET_GBN_SHR" onChange="fnc_SearchList()">
                                        <option value="1">�Ի���</option>
                                        <option value="2">�����</option>
                                        <option value="10">�⺻���������</option>
                                        <option value="3">�ټӼ��纯����</option>
                                        <option value="11">�������纯����</option>
                                        <option value="9">�����ξ�񺯰���</option>
                                        <option value="5">���ڱ�</option>
                                        <option value="12">������Ÿ����</option>
                                        <option value="13">�ݿ���Ÿ����</option>
                                        <option value="4">����ī��</option>
                                        <option value="6">���ϱٹ�����</option>
                                <!--        <option value="7">ö�ߴ�������</option>    -->
                                        <option value="8">���ϰ�������</option>
                                        <option value="14">�����</option>
                                    </select>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_CP_PAYMASTER">
							<param name="Format"					value="">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->
<!--<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">�� �Ի���/����� ������ ���� ��ȸ�ϰ� �ؾ� �ֽ� �����Ͱ� �ݿ��˴ϴ�.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>-->

</form>
<!-- form �� -->

</body>
</html>
