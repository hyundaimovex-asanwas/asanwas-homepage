<!--*************************************************************************
* @source      : taxa280.jsp                                                *
* @description : �ҵ��õ��������Ȳ PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2012/01/30            ����ȣ             �����ۼ�                         *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�ҵ��õ��������Ȳ(taxa280)</title>
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
                    + "T"   //����(ó��)
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD";
        var params;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YM    = document.getElementById("txtPIS_YM_SHR");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");
            var SAL_GBN   = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���

            if(oPIS_YM.value == "") {
                alert("�ش����� ����ֽ��ϴ�.");
                oPIS_YM.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&PIS_YM="+pis_ym[0]+pis_ym[1]
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
            	   + "&SAL_GBN="+SAL_GBN;            

            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();


            
        }


        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");

            if(oPIS_YM.value == "")
                return;

            var pis_ym      = oPIS_YM.value.split("-");

            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];


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


			var PIS_YM_SHR = document.getElementById("txtPIS_YM_SHR").value; // �ش���
            var SAL_GBN   = document.getElementById("cmbSAL_GBN_SHR").value; // �޻󿩱���

			//�ش����� ������ ��ȸ ����.
			if(PIS_YM_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �Է��ϼ���.");
					document.getElementById("txtPIS_YM_SHR").focus();
					return false;
				}
			}

			//�ش����� �߸��Ǿ����� ��ȸ����.
			if(PIS_YM_SHR.trim().length != 7){
				if(event.type == "change"){
					return false;
				}else{
					alert("�ش����� �߸��Ǿ����ϴ�.");
					document.getElementById("txtPIS_YM_SHR").focus();
					return false;
				}
			}

            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");

            
            
			//�հ�
            gcds_report0.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report0.Reset();

			//�ӿ�(����)
            gcds_report1.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT1&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report1.Reset();

			//�Ϲ�������
            gcds_report2.DataID = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa280.cmd.TAXA280CMD&S_MODE=SHR_PRINT2&PIS_YY="+pis_ym[0]+"&PIS_MM="+pis_ym[1]+"&SAL_GBN="+SAL_GBN;
            gcds_report2.Reset();

            
            
			gcrp_print.Preview();

        }


        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("��Ÿ�ҵ�/�������ξװ���", '', 225);
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

            dsT_AC_ETCPAY.ClearData();


            //��� �Է�â�� �ʱ�ȭ
            fnc_ClearInputElement(elementList);
            fnc_DisableElementAll(elementList);

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"false","true");      // Grid Style ����

            //document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            //�ڵ� ��ȸ
            fnc_SearchItem();
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

    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_AC_ETCPAY_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_RP_PAYTABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 			Value="True">
        <Param Name="UseChangeInfo" 	Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>


	<OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="false">
	</OBJECT>

	<OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" VALUE="true">
	</OBJECT>

	<OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<param name=SortExpr     value="+TREECD">
	  	<param name=SubsumExpr   value="1:TREECD">
		<PARAM NAME="SyncLoad" VALUE="true"><!-- REPORT��ȸ DataSet-->
	</OBJECT>
    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>


    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_ETCPAY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* �۾��� �Ϸ� �Ͽ����ϴ�!");
        dsT_AC_ETCPAY_SAV.ClearData();
        fnc_DisableElementAll(elementList);

        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <script for=grdT_AC_ETCPAY event=OnDblClick(Row,Colid)>

    </script>


    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_AC_ETCPAY_SAV event=CanRowPosChange(row)>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��õ��,���μ�/�ҵ��õ��������Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">��õ��,���μ�/�ҵ��õ��������Ȳ</font></td>
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
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                    <col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>                    
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">�ش���</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onchange="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
					<td align="center" class="searchState">����</td>
					<td>								
						<select id="cmbSAL_GBN_SHR" style="WIDTH:70" onchange="fnc_SearchList()">
							<option value="0" >��  ��</option>
                            <option value="2" >��  ��</option>
						</select>							
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
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                        <param name="DataID" 			value="dsT_AC_ETCPAY">
                        <param name="Editable" 			value="true">
                        <param name="DragDropEnable" 	value="true">
                        <param name="SortView" 			value="Left">
						<param name="VIEWSUMMARY"		value=1>
                        <param name="Format" 			value='
                            <C> id="{CUROW}"     width=30        align=center   name="NO"      		value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM        width=80        align=center   name="�Ҽ�"    		SumBgColor=#C3D0DB</C>
                            <C> id=PIS_YM        width=60        align=center   name="���"    		SumBgColor=#C3D0DB</C>
                            <C> id=JOB_NM        width=80        align=center   name="����"    		SumBgColor=#C3D0DB</C>
                            <C> id=REG_NM        width=80        align=center   name="ȸ��Ҽ�" 	SumBgColor=#C3D0DB</C>
                            <C> id=ENO_NO        width=60        align=center   name="���"    		SumBgColor=#C3D0DB</C>
                            <C> id=ENO_NM        width=60        align=center   name="����"    		SumBgColor=#C3D0DB </C>
                            <C> id=PAY_SUM       width=80        align=right    name="�޿�"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=BP35000       width=80        align=right    name="�Ĵ�"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=BP24000       width=80        align=right    name="����"    		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=SALT_AMT      width=80        align=right    name="��"      		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=INCM_TAX      width=80        align=right    name="���ټ�"  		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=CITI_TAX      width=80        align=right    name="�ֹμ�"  		SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=DDTT_AMT      width=80        align=right    name="�����հ�"    	SumBgColor=#C3D0DB SumText=@sum	</C>
                            <C> id=PAY_AMT       width=80        align=right    name="�����޾�"    	SumBgColor=#C3D0DB SumText=@sum	</C>

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


<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- �޿�������Ȳ[����] --
------------------------------------------------------------------------------>
<OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"				VALUE="gcds_report0">
	<param name="DetailDataID"				value="gcds_report1">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="LandScape"					VALUE="1">
    <PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="120">
	<PARAM NAME="Format" VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='�޿�������Ȳ_���ο�.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_report0'
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=458 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=895 ,top=5 ,right=1917 ,bottom=105 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>

	<L> left=353 ,top=295 ,right=2467 ,bottom=295 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=34 ,top=361 ,right=2780 ,bottom=361 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=227 ,right=2780 ,bottom=227 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=34 ,top=438 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=229 ,right=32 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=229 ,right=258 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=229 ,right=353 ,bottom=438 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1340 ,top=229 ,right=1340 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2475 ,top=229 ,right=2475 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=229 ,right=2780 ,bottom=438 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1606 ,top=295 ,right=1606 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1872 ,top=295 ,right=1872 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=642 ,top=295 ,right=642 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=879 ,top=295 ,right=879 ,bottom=440 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2162 ,top=295 ,right=2162 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1101 ,bottom=440 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1101 ,top=295 ,right=1340 ,bottom=295 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>

	<C>id='PIS_MM', left=1222, top=13, right=1311, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='COUNTR', left=274, top=372, right=350, bottom=422, align='right'</C>
	<C>id='PIS_YY', left=964, top=13, right=1135, bottom=98, align='right', face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<C>id='PAY_AMT', left=2488, top=372, right=2772, bottom=422, align='right', face='Arial', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=45, top=372, right=140, bottom=422, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=153, top=372, right=203, bottom=422, align='right', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TODATEE', left=2580, top=132, right=2783, bottom=179, align='right' ,mask='XXXX.XX.XX', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DDTT_AMT', left=2167, top=377, right=2467, bottom=427, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITI_TAX', left=1611, top=377, right=1867, bottom=427, align='right'</C>
	<C>id='INCM_TAX', left=1348, top=377, right=1601, bottom=427, align='right'</C>
	<C>id='SALT_AMT', left=1106, top=377, right=1327, bottom=427, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP24000', left=887, top=377, right=1093, bottom=427, align='right'</C>
	<C>id='BP35000', left=648, top=377, right=877, bottom=427, align='right'</C>
	<C>id='PAY_SUM', left=361, top=377, right=637, bottom=427, align='right'</C>

	<T>id='��' ,left=2164 ,top=301 ,right=2464 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=1875 ,top=301 ,right=2151 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=1609 ,top=301 ,right=1864 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ټ�' ,left=1348 ,top=301 ,right=1601 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1103 ,top=301 ,right=1332 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=885 ,top=301 ,right=1090 ,bottom=351 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ĵ�' ,left=645 ,top=301 ,right=874 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿�' ,left=358 ,top=301 ,right=635 ,bottom=351 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=45 ,top=240 ,right=245 ,bottom=348 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=200 ,top=372 ,right=245 ,bottom=422 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=137 ,top=372 ,right=163 ,bottom=422 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Print Date:' ,left=2314 ,top=132 ,right=2578 ,bottom=179 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1   ���ο�' ,left=32 ,top=179 ,right=242 ,bottom=221 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���޳���' ,left=361 ,top=240 ,right=1327 ,bottom=290 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1348 ,top=240 ,right=2467 ,bottom=290 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� : ��' ,left=2580 ,top=179 ,right=2783 ,bottom=221 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=271 ,top=240 ,right=348 ,bottom=348 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޾�' ,left=2488 ,top=240 ,right=2772 ,bottom=348 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1311 ,top=13 ,right=1385 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='�޿� ���� ��Ȳ' ,left=1416 ,top=13 ,right=1869 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='��' ,left=1137 ,top=13 ,right=1219 ,bottom=98 ,face='HY������M' ,size=20 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
</R>
</A>

<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
<R>id='�޿�������Ȳ_����ٹ���.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , MasterDataID='gcds_report1'
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=287 ,face='Arial' ,size=10 ,penwidth=1

	<L> left=874 ,top=129 ,right=874 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=637 ,top=129 ,right=637 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1867 ,top=129 ,right=1867 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=129 ,right=1601 ,bottom=274 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2156 ,top=129 ,right=2156 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2775 ,top=63 ,right=2775 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2470 ,top=63 ,right=2470 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1335 ,top=63 ,right=1335 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=348 ,top=63 ,right=348 ,bottom=272 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=253 ,top=63 ,right=253 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=63 ,right=26 ,bottom=272 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=195 ,right=2775 ,bottom=195 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=26 ,top=61 ,right=2775 ,bottom=61 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=29 ,top=277 ,right=2775 ,bottom=277 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=129 ,right=2470 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1087 ,bottom=274 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1087 ,top=129 ,right=1335 ,bottom=129 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=350 ,top=127 ,right=2464 ,bottom=127 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>

	<C>id='DDTT_AMT', left=2162, top=206, right=2462, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CITI_TAX', left=1606, top=206, right=1861, bottom=256, align='right'</C>
	<C>id='INCM_TAX', left=1343, top=206, right=1595, bottom=256, align='right'</C>
	<C>id='BP24000', left=882, top=206, right=1087, bottom=256, align='right'</C>
	<C>id='BP35000', left=642, top=206, right=871, bottom=256, align='right'</C>
	<C>id='PAY_SUM', left=355, top=206, right=632, bottom=256, align='right'</C>
	<C>id='COUNTR', left=269, top=206, right=345, bottom=256, align='right'</C>
	<C>id='PAY_AMT', left=2483, top=206, right=2767, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=39, top=206, right=134, bottom=256, align='right', face='����', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=147, top=206, right=197, bottom=256, align='right', face='����', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SALT_AMT', left=1095, top=206, right=1330, bottom=256, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>

	<T>id='2  �ӿ�(����)' ,left=26 ,top=13 ,right=313 ,bottom=55 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޾�' ,left=2483 ,top=74 ,right=2767 ,bottom=182 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=266 ,top=74 ,right=342 ,bottom=182 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1343 ,top=74 ,right=2462 ,bottom=124 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���޳���' ,left=355 ,top=74 ,right=1322 ,bottom=124 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=132 ,top=206 ,right=158 ,bottom=256 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=195 ,top=206 ,right=240 ,bottom=256 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=39 ,top=74 ,right=240 ,bottom=182 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ĵ�' ,left=640 ,top=137 ,right=869 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=879 ,top=137 ,right=1085 ,bottom=187 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿�' ,left=353 ,top=137 ,right=629 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ټ�' ,left=1343 ,top=137 ,right=1595 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=1606 ,top=137 ,right=1861 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=1872 ,top=137 ,right=2148 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2162 ,top=137 ,right=2462 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1095 ,top=137 ,right=1330 ,bottom=187 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=141
<R>id='�޿�������Ȳ_detail.sbt' ,left=0 ,top=8 ,right=2831 ,bottom=140 , DetailDataID='gcds_report2'
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=316 ,face='Arial' ,size=10 ,penwidth=1

	<L> left=32 ,top=95 ,right=2780 ,bottom=95 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=32 ,top=224 ,right=2780 ,bottom=224 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=158 ,right=2472 ,bottom=158 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1090 ,top=158 ,right=1340 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2151 ,top=158 ,right=2472 ,bottom=158 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=298 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=1340 ,top=98 ,right=1340 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=258 ,top=98 ,right=258 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=353 ,top=98 ,right=353 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=635 ,top=156 ,right=635 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1869 ,top=156 ,right=1869 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1601 ,top=156 ,right=1601 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=882 ,top=156 ,right=882 ,bottom=298 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1093 ,top=156 ,right=1093 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2475 ,top=98 ,right=2475 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2780 ,top=98 ,right=2780 ,bottom=298 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<L> left=2154 ,top=156 ,right=2154 ,bottom=298 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=32 ,top=98 ,right=32 ,bottom=295 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>

	<C>id='DPT_NM', left=92, top=40, right=606, bottom=84, align='left', face='����', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_MM', left=153, top=237, right=203, bottom=285, align='right', face='����', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PIS_YY', left=45, top=237, right=140, bottom=285, align='right', face='����', size=10, bold=false,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTR', left=271, top=237, right=348, bottom=285, align='right'</C>
	<C>id='PAY_AMT', left=2488, top=237, right=2772, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{currow+2}', left=32, top=40, right=87, bottom=84, align='left', face='����', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_SUM', left=361, top=237, right=629, bottom=285, align='right'</C>
	<C>id='DDTT_AMT', left=2162, top=237, right=2467, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BP35000', left=640, top=237, right=877, bottom=285, align='right'</C>
	<C>id='BP24000', left=887, top=237, right=1090, bottom=285, align='right'</C>
	<C>id='SALT_AMT', left=1101, top=237, right=1332, bottom=285, align='right', face='Arial', size=10, bold=true,  forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INCM_TAX', left=1348, top=237, right=1598, bottom=285, align='right'</C>
	<C>id='CITI_TAX', left=1603, top=237, right=1864, bottom=285, align='right'</C>

	<T>id='��  ��' ,left=45 ,top=105 ,right=245 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=200 ,top=237 ,right=245 ,bottom=285 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='.' ,left=137 ,top=237 ,right=163 ,bottom=285 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ο�' ,left=271 ,top=105 ,right=348 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1348 ,top=105 ,right=2467 ,bottom=156 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����޾�' ,left=2488 ,top=105 ,right=2772 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���޳���' ,left=361 ,top=105 ,right=1327 ,bottom=156 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�޿�' ,left=361 ,top=166 ,right=629 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ĵ�' ,left=640 ,top=166 ,right=877 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=887 ,top=166 ,right=1090 ,bottom=216 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1101 ,top=166 ,right=1332 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ټ�' ,left=1348 ,top=166 ,right=1598 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ֹμ�' ,left=1603 ,top=166 ,right=1864 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ' ,left=1872 ,top=166 ,right=2148 ,bottom=216 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=2162 ,top=166 ,right=2467 ,bottom=216 ,face='����' ,size=10 ,bold=true ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

</B>
</R>
</A>

<B>id=Footer ,left=0 ,top=1895 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2826 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=5 ,right=2781 ,bottom=106</I>
</B>
">
</OBJECT>

</body>
</html>

