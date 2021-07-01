<!--
***********************************************************************
* @source      : gund010.jsp
* @description : �����߻�/�̻��ݾ� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/20      ���뼺        �����ۼ�.
* 2009/11/11      ������        U&I ������� ����
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�����߻�/�̻��ݾ�(gund010)</title>
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
    <script language="javascript" >

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

            if(!fnc_SearchItemCheck()) return;

            var f = document.form1;

			//���º����û��Ȳ ���� ��ȸ
			var pis_ym = document.getElementById("txtPIS_YM_SHR").value;
            var gbn = "";
			var gbn_cd = "";
            var basis = "";
            if(f.rdoGBN_SHR[0].checked){
                gbn = "HEAD";
                gbn_cd = document.getElementById("cmbHEAD_CD_SHR").value;
            }else{
                gbn = "DPT";
                gbn_cd = document.getElementById("cmbDPT_CD_SHR").value;
            }

			dsT_DI_YEARLY.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.d.gund010.cmd.GUND010CMD&S_MODE=SHR&PIS_YM="+pis_ym+"&GBN="+gbn+"&GBN_CD="+gbn_cd+"&BASIS=DILI";
			dsT_DI_YEARLY.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            if (dsT_DI_YEARLY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_YEARLY.GridToExcel("�����߻�/�̻��ݾ�", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
			document.getElementById("cmbHEAD_CD_SHR").value = "";
            document.getElementById("cmbDPT_CD_SHR").value = "";

            document.getElementById("resultMessage").innerText = ' ';

            dsT_DI_YEARLY.ClearData();

            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			if (dsT_DI_YEARLY.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_ym = document.getElementById("txtPIS_YM_SHR");

            if(pis_ym.value == ""){
                alert("�ش����� �Է��ϼ���!");
                pis_ym.focus();
                return false;
            }

            return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_YEARLY,0,"false","true");      // Grid Style ����

			     
            //����
            for( i = 1; i <= dsT_CM_COMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_B2.NameValue(i,"CODE")+"  "+dsT_CM_COMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            }
            //�Ҽ�
            for( i = 1; i <= dsT_CM_COMMON_A4.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A4.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A4.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A4.NameValue(i,"CODE_NAME");
                document.getElementById("cmbDPT_CD_SHR").add(oOption);

            }

			
            document.getElementById("txtPIS_YM_SHR").value = today.substring(0,7);
            document.getElementById("txtPIS_YM_SHR").focus();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet						|
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_YEARLY)  |
    | 3. ���Ǵ� Table List(T_DI_YEARLY) 		    |
    +----------------------------------------------->
	<Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ���� ����-->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �Ҽ� ����-->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A4"/>
       <jsp:param name="CODE_GUBUN"    value="A4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_YEARLY Event="OnLoadCompleted(iCount)">

        var sum_amt = 0;

		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
            //�հ�ݾ�
//            for(i=1; i<=iCount; i++){
//                sum_amt = sum_amt + dsT_DI_YEARLY.NameValue(i,"YEAR_PAY");
//            }
//
//            dsT_DI_YEARLY.AddRow();
//
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "JOB_NM") = "�� ��";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "ENO_NM") = iCount+"��";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YRP_CNT") ="";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "USE_CNT") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "NO_CNT") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YRP_PER") = "";
//            dsT_DI_YEARLY.NameValue(dsT_DI_YEARLY.RowPosition, "YEAR_PAY") = sum_amt;

        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_YEARLY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_YEARLY Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����߻�/�̻��ݾ�</td>
					<td align="right" class="navigator">HOME/���°���/��������/<font color="#000000">�����߻�/�̻��ݾ�</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="120"></col>
							<col width="520"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
                            <td class="searchState" align="right">�ش���&nbsp;</td>
							<td class="padding2423" align="left">
								<input id="txtPIS_YM_SHR"  name="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this)" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','500','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
							</td>

                            <td class="padding2423" rowspan="2">
								<table width="100%" height="100%" border="1" cellspacing="1" cellpadding="2">
									<tr>
										<td><input type="radio" id="radio11" name="rdoGBN_SHR" style="border:none" value="0" checked>����
                                                <select id="cmbHEAD_CD_SHR" name="cmbHEAD_CD_SHR" style="WIDTH:70%">
                                                    <option value=""> </option>
                                                </select>
                                        </td>
										<td><input type="radio" id="radio12" name="rdoGBN_SHR" style="border:none" value="0">�Ҽ�
                                                <select id="cmbDPT_CD_SHR" name="cmbDPT_CD_SHR" style="WIDTH:70%">
                                                    <option value=""> </option>
                                                </select>
                                        </td>

									</tr>
								</table>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_YEARLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" 					value="dsT_DI_YEARLY">
						<Param Name="ViewSummary"   		value="1" >
						<param name="SortView" 				value="Left">						
						<param name="Format" 					value='
							<C> id="{CUROW}"	width=38	name="NO"				align=center	value={String(Currow)}	</C>
                            <C> id="DPT_NM"	    width=100	name="�μ�"		    align=center   suppress=1 </C>
                            <C> id="TEAM_NM"	width=100	name="��"		    	align=left       suppress=2 </C>                            
                            <C> id="JOB_NM"		width=80	name="����"		    align=center   SumText="�� ��" </C>
                            <C> id="ENO_NO"     width=65	name="���"         	align=center    </C>
                            <C> id="ENO_NM"	    width=60	name="����"	        align=center    </C>

                            <G> name="���������Ȳ" HeadBgColor="#F7DCBB"
                                <C> id="YRP_CNT"	width=60	name="�߻�"	    align=right     	sumtext=@sum </C>
                                <C> id="USE_CNT"	width=60	name="���"	    align=right     	sumtext=@sum </C>
                                <C> id="NO_CNT"	    width=60	name="�̻��"		align=right    	sumtext=@sum </C>
                                <C> id="YRP_PER"		width=50	name="�����"		align=right    	sumtext=@avg show=false</C>
                            </G>
                            <C> id="YEAR_PAY"	width=80	name="�̻��;�ݾ�"   align=right   sumtext=@sum </C>
                            <C> id="HIR_YMD"	width=75	name="�Ի���"			align=center    </C>                            
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