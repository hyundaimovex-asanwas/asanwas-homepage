<!--*************************************************************************
* @source      : taxa040.jsp                                                *
* @description : �ٷμҵ�������Ȳ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            ����ȣ             �����ۼ�
* 2007/04/30            ���м�             �����ۼ�
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�ٷμҵ�������Ȳ(taxa040)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa040.cmd.TAXA040CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");

            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&ENO_NO="+oENO_NO.value
                   + "&DTP_CD="+oDTP_CD.value;

            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {
            //�˻���ȿ�� �˻�
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oENO_NO     = document.getElementById("txtENO_NO_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");

            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);

            params = "PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&ENO_NO="+oENO_NO.value
                   + "&DTP_CD="+oDTP_CD.value;

			var url = "taxa040_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("�ٷμҵ�������Ȳ", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_RETACC.ClearData();

            fnc_ClearInputFieldAll(oExceptionList);
            document.getElementById("txtENO_NO_SHR").value = "";

            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_RETACC,0,"false","true");      // Grid Style ����

			form1.grdT_AC_RETACC.TitleHeight = 45;
            
            document.getElementById("txtPIS_YM_SHR").value = '2013-12';
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;

            fnc_SearchList();
            
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbOCC_CD_SHR"
                                        ,"cmbSAL_GBN_SHR");

        //�׸���� �޼���
        var oElementMsgList = new Array( "������"
                                        ,"�ٷα���"
                                        ,"���걸��");

        //���� �׸��
        var oExceptionList = new Array(  "cmbOCC_CD_SHR");




    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>


    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ٷμҵ�������Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�ٷμҵ�������Ȳ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
                    <col width="100"></col>
                    <col width="180"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">������</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
					</td>
                    <td class="searchState" align="right">���걸��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN_SHR" id="cmbSAL_GBN_SHR">
                            <option value=""></option>
                            <option value="8">��������</option>
                            <option value="9">����������</option>
                        </select>
                    </td>
				</tr>
                <tr>
                    <td class="searchState" align="right">�μ�</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                        </a>
                    </td>
                    <td align="right" class="searchState">���</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:450px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"        width=40    height =150 align=center    name="NO"         value={String(Currow)}    SubSumText=""</FC>
                            <FC> id=RET_YN           width=60   align=center    name=����     SubSumText="" Value={Decode(RET_YN,"","����","����")}</FC>
                            <FC> id=RET_YMD         width=70   align=center    name=������     SubSumText="" </FC>                       
                            <FC> id=DPT_NM           width=100   align=left    name=�Ҽ�                          SubSumText=""</FC>
                            <FC> id=ENO_NO           width=55   align=center    name=���                          SubSumText=""</C>
                            <FC> id=ENO_NM           width=55   align=center    name=����                          SubSumText=""</FC>
                            <C> id=CET_NO           width=100   align=center    name=�ֹι�ȣ                          SubSumText=""</C>
                            <C> id=JOB_NM           width=75   align=center    name=����                          SubSumText=" �� �� "</FC>
                            <C> id=PAYD_AMTS        width=100   align=right     rightmargin=10    name=�����޿��Ѿ�                  show=false</C>
                            <C> id=PAYD_AMTB        width=100   align=right     rightmargin=10    name=�������Ѿ�                  show=false</C>
                            <C> id=PAYD_TOT         width=100   align=right     rightmargin=10    name=�����޿��Ѿ�                value={PAYD_AMTS+PAYD_AMTB} show=false</C>
                            <C> id=OUTT_AMTS        width=100   align=right     rightmargin=10    name=�����ؿܱ޿��Ѿ�              show=false</C>
                            <C> id=OUTT_AMTB        width=100   align=right     rightmargin=10    name=�����ؿܻ��Ѿ�              show=false</C>
                            <C> id=OUTT_TOT         width=100   align=right     rightmargin=10    name=�����ؿܱ޻��Ѿ�            show=false value={OUTT_AMTS+OUTT_AMTB} </C>
                            <C> id=JAA_AMT          width=100   align=right     rightmargin=10    name=�����޿��Ѿ�                  show=false</C>
                            <C> id=JAC_AMT          width=100   align=right     rightmargin=10    name=�������Ѿ�                  show=false</C>
                            <C> id=JA1_AMT          width=100   align=right     rightmargin=10    name="�����޻�;�Ѿ�"          show=false      value={JAA_AMT+JAC_AMT} </C>
                            <C> id=JAB_AMT          width=100   align=right     rightmargin=10    name=�����ؿܱ޿��Ѿ�              show=false</C>
                            <C> id=JAD_AMT          width=100   align=right     rightmargin=10    name=�����ؿܻ��Ѿ�              show=false</C>
                            <C> id=JA2_AMT          width=100   align=right     rightmargin=10    name=�����ؿܱ޻��Ѿ�           show=false value={JAB_AMT+JAD_AMT} </C>
                            <C> id=FREE_INCOME      width=100   align=right     rightmargin=10    name="���������;�ҵ�"          show=false      </C>
                            <C> id=JAG_AMT          width=100   align=right     rightmargin=10    name="���������;�ҵ�"            show=false    </C>
                            <C> id=FREE_IN1         width=100   align=right     rightmargin=10    name=������ҵ��                 show=false value={JAG_AMT+FREE_INCOME} </C>
                            <C> id=TAX_INCOME       width=100   align=right     rightmargin=10    name=�������޿�                 BgColor=#FAFAD2 </C>
                            <C> id=MGR_AMT          width=100   align=right     rightmargin=10    name="�ٷμҵ�;������"                </C>
                            <C> id=MNI_AMT          width=100   align=right     rightmargin=10    name=�ٷμҵ�ݾ�                  BgColor=#FABBCC </C>
                            <C> id=BADD_AMT         width=100   align=right     rightmargin=10    name=���ΰ�����                    </C>
                            <C> id=SPSB_AMT         width=100   align=right     rightmargin=10    name=����ڰ�����                  </C>
                            <C> id=DFM_CNT          width=100   align=right     rightmargin=10    name="�ξ簡��;������"                </C>
                            <C> id=GDED_AMT         width=100   align=right     rightmargin=10    name="�ξ簡��;������"                </C>
                            <C> id=GOL_CNT          width=100   align=right     rightmargin=10    name="��ο��;������"                </C>
                            <C> id=GOL_AMT          width=100   align=right     rightmargin=10    name="��ο��;������"                </C>
                            <C> id=TRB_CNT          width=100   align=right     rightmargin=10    name=����ڰ�����                  </C>
                            <C> id=TBL_DED          width=100   align=right     rightmargin=10    name=����ڰ�����                  </C>
                            <C> id=WDD_AMT          width=100   align=right     rightmargin=10    name=�γ��ڰ�����                  </C>
                            <C> id=RCH_CNT          width=100   align=right     rightmargin=10    name="6������;������"                </C>
                            <C> id=RCH_AMT          width=100   align=right     rightmargin=10    name="6������;������"                </C>
                            <C> id=INP_CNT          width=100   align=right     rightmargin=10    name="����Ծ�;������"                </C>
                            <C> id=INP_AMT          width=100   align=right     rightmargin=10    name="����Ծ�;������"                </C>                            

                            <C> id=CHI_CNT          width=100   align=right     rightmargin=10    name=���ڳ������               </C>                                         
                            <C> id=SMD_AMT          width=100   align=right     rightmargin=10    name=���ڳ������                      </C>
 
                            <C> id=PER_TOT          width=100   align=right     rightmargin=10    name=����������                    BgColor=#FAFA11</C>

                            <C> id=PER_TOT1          width=100   align=right     rightmargin=10    name=����������2    show=false value={BADD_AMT+SPSB_AMT+GDED_AMT+GOL_AMT+TBL_DED+WDD_AMT+RCH_AMT+INP_AMT+SMD_AMT}          BgColor=#FAFAD2</C>
                            
                            
                            <C> id=NPEN_AMT         width=100   align=right     rightmargin=10    name=���ο��ݷ�                    </C>
                            <C> id=NPEN_DED         width=100   align=right     rightmargin=10    name="���ݺ����;������"              BgColor=#1188D2</C>
                            <C> id=HINU_AMT         width=100   align=right     rightmargin=10    name=�ǰ������                    </C>
                            <C> id=OLD_AMT         width=100   align=right     rightmargin=10    name=���������                    </C>
                            
                            <C> id=HINS_AMT         width=100   align=right     rightmargin=10    name=��뺸���                    </C>
                            <C> id=LIN_AMT          width=100   align=right     rightmargin=10    name=���强�����                  </C>
                            <C> id=LIN_DED          width=100   align=right     rightmargin=10    name="���强�����;������"            </C>
                            <C> id=LIH_AMT          width=100   align=right     rightmargin=10    name="���������;�����"              </C>
                            <C> id=LIH_DED          width=100   align=right     rightmargin=10    name="����κ����;������"            </C>
                            <C> id=MIN_DED          width=100   align=right     rightmargin=10    name=����������                  BgColor=#FAFAD2</C>
                            
                            <C> id=LMA_AMT          width=100   align=right     rightmargin=10    name=�Ϲ��Ƿ��                    show=false</C>
                            <C> id=LF2_AMT          width=100   align=right     rightmargin=10    name="����;��ְ��;�Ƿ��"  show=false</C>

                            <C> id=MHEA_AMT          width=100   align=right     rightmargin=10    name="����;65���̻�;�Ƿ��"   </C>

                            <C> id=LF2_AMT          width=100   align=right     rightmargin=10    name="����Ƿ��"   </C>

                            <C> id=OHEA_AMT          width=100   align=right     rightmargin=10    name=�׹����Ƿ��                    </C>
                                                        
                            <C> id=MMA_DED          width=100   align=right     rightmargin=10    name=�Ƿ�������                  BgColor=#FAFAD2</C>
                            
                            <C> id=LED_AMT          width=100   align=right     rightmargin=10    name=���α�����                    </C>
                            
                            <C> id=LEF_AMT          width=100   align=right     rightmargin=10    name=����������                    </C>
                            
                            <C> id=EDU_DED          width=100   align=right     rightmargin=10    name=�����������                  BgColor=#FAFAD2</C>
                            <C> id=LHO_AMT          width=100   align=right     rightmargin=10    name=�����ڱ�����                  </C>
                            <C> id=LH1_AMT          width=100   align=right     rightmargin=10    name="���ÿ�����;��ȯ��"              </C>
                            <C> id=LH2_AMT          width=100   align=right     rightmargin=10    name="�����������;���Ա�;�������޾�"  </C>
                            <C> id=HOS_DED          width=100   align=right     rightmargin=10    name="�����ڱ�;������"                BgColor=#FAFAD2</C>
                            <C> id=GOV_AMT          width=100   align=right     rightmargin=10    name=��ġ�ڱ�                      </C>
                            <C> id=LC3_AMT          width=100   align=right     rightmargin=10    name=������α�                    </C>
                            <C> id=LC2_AMT          width=100   align=right     rightmargin=10    name=������α�                    </C>

                            <C> id=CPC_DED          width=100   align=right     rightmargin=10    name=��αݰ�����                  BgColor=#FAFAD2</C>
                            <C> id=NSE_TOT          width=100   align=right     rightmargin=10    name=Ư��������                    BgColor=#99FF22</C>
                            <C> id=LF1_AMT          width=100   align=right     rightmargin=10    name="���ο���;�����"                </C>
                            <C> id=PER_SAV          width=100   align=right     rightmargin=10    name="���ο���;���������"            BgColor=#FAFAD2</C>
                            <C> id=ANN_AMT          width=100   align=right     rightmargin=10    name=���������                    </C>
                            <C> id=ANN_DED          width=100   align=right     rightmargin=10    name="��������;������"                BgColor=#FAFAD2</C>
                            <C> id=VEN_AMT          width=100   align=right     rightmargin=10    name=�����������ھ�               show=false </C>
                            <C> id=VEN_DED          width=100   align=right     rightmargin=10    name=�����������ڰ�����          show=false  BgColor=#FAFAD2</C>
                            <C> id=CARD_AMT         width=100   align=right     rightmargin=10    name="�ſ�ī��;����"                </C>
                            <C> id=CARD_DED         width=100   align=right     rightmargin=10    name="�ſ�ī��;������"                BgColor=#FAFAD2</C>

                            <C> id=GOV_DED          width=100   align=right     rightmargin=10    name="��ġ�ڱ�;������"        show=false          BgColor=#FAFAD2</C>
                            <C> id=SPC_TOT          width=100   align=right     rightmargin=10    name=��Ư��������                  BgColor=#FAFAD2 show=false </C>
                            <C> id=TTAX_STD         width=100   align=right     rightmargin=10    name=���հ���ǥ��                  </C>
                            <C> id=TAX_AMT          width=100   align=right     rightmargin=10    name=���⼼��                        BgColor=#AAFAD2</C>
                            
                           <G> name=���װ��� BgColor="#F7DCBB"
                            <C> id=HGR_DED          width=100   align=right     rightmargin=10    name="�ٷμҵ�;���װ���"              </C>
                            <C> id=GOV_DED          width=100   align=right     rightmargin=10    name="��ġ�ڱ�;���װ���"              </C>                            
                            <C> id=STX_DED          width=100   align=right     rightmargin=10    name=�������༼�װ���             show=false </C>   
                            <C> id=HTX_DED          width=100   align=right     rightmargin=10    name=�����ڱ����ڼ��װ���       show=false   </C>
                            <C> id=OTX_DED          width=100   align=right     rightmargin=10    name=�ܱ����μ��װ���              show=false</C>
                            <C> id=HSX_DED          width=100   align=right     rightmargin=10    name=�ٷ����ֽ����༼�װ���     show=false   </C>
                            <C> id=LSX_DED          width=100   align=right     rightmargin=10    name=����ֽ����༼�װ���         show=false </C>
                            <C> id=TDED_TOT         width=100   align=right     rightmargin=10    name=���װ�����                    BgColor=#FAFAD2</C>
                            <C> id=TAX_DED          width=100   align=right     rightmargin=10    name=���װ�����                    show=false</C>
                           </G> 

                           <G> name=�������� BgColor="#F7DCBB"                            
                            <C> id=DGG_TAX          width=100   align=right     rightmargin=10    name=�����ҵ漼                   </C>
                            <C> id=DJM_TAX          width=100   align=right     rightmargin=10    name=�����ֹμ�                   </C>
                            <C> id=AAA_TOT          width=100   align=right     rightmargin=10    name=�������װ�                    value={DGG_TAX+DJM_TAX+DBW_TAX}   BgColor=#FAFAD2</C>
                            
                           <G> name=���μ��� BgColor="#F7DCBB"                            
                            <C> id=JAL_AMT          width=100   align=right     rightmargin=10    name=�������ҵ漼                  </C>
                            <C> id=JAN_AMT          width=100   align=right     rightmargin=10    name=�������ֹμ�                  </C>
                            <C> id=BBB_TOT          width=100   align=right     rightmargin=10    name=������                        value={JAL_AMT+JAM_AMT+JAN_AMT} BgColor=#FAFAD2</C>
                            <C> id=INCM_TAX         width=100   align=right     rightmargin=10    name=�����ҵ漼                    </C>
                            <C> id=CITI_TAX         width=100   align=right     rightmargin=10    name=�����ֹμ�                    </C>
                            <C> id=CCC_TOT          width=100   align=right     rightmargin=10    name=������                        value={INCM_TAX+CONT_TAX+CITI_TAX} BgColor=#FAFAD2</C>
                            </G>                            

                           <G> name=ȯ�޼��� BgColor="#F7DCBB"                             
                            <C> id=DRE_INTX1        width=100   align=right     rightmargin=10    name=¡���ҵ漼                    value={if(DRE_INTX>0, DRE_INTX, 0)} show=false</C>
                            <C> id=DRE_CTTX1        width=100   align=right     rightmargin=10    name=¡���ֹμ�                    value={if(DRE_CTTX>0, DRE_CTTX, 0)} show=false</C>
                            <C> id=DDD_TOT          width=100   align=right     rightmargin=10    name=¡�����װ�                    value={DRE_INTX+DRE_DFTX+DRE_CTTX} show=false</C>                           
                            
                            <C> id=DRE_INTX        width=100   align=right     rightmargin=10    name=ȯ�޼ҵ漼                    </C>
                            <C> id=DRE_CTTX        width=100   align=right     rightmargin=10    name=ȯ���ֹμ�                    </C>
                            <C> id=EEE_TOT          width=100   align=right     rightmargin=10    name=ȯ�޼��װ�                    value={DRE_INTX+DRE_CTTX} BgColor=#FFAADD</C>
                            </G>                         
                        
                        '>
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


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
