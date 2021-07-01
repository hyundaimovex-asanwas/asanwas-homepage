<!--
    ************************************************************************************
    * @Source         : pird010.jsp                                                    *
    * @Description    : �λ���ī�� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/05  |  ������   | �����ۼ�                                               *
    * 2007/05/10  |  �̽¿�   | ���Ǽ���                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�λ���ī��(pird010)</title>
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

        var btnList = 'TFFTFTFT';

        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            var OCC_CD =  document.getElementById("cmbOCC_CD_SHR").value;
            var PRT_SELT = document.getElementById("cmbPRT_SELT_SHR").value;
            var NO_SHR = document.getElementById("txtNO_SHR").value;

            // ���κ��ΰ��
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                if (document.getElementById("txtNO_SHR").value == "") {
                    alert("����� �ʼ��Է��׸��Դϴ�.");
                    document.getElementById("txtNO_SHR").focus();
                    return;
                }
            }
            //��� ����
            if(document.form1.chkPRT_GUB.checked == true) {
                var PRT_GUB = "Y";
            }else {
                var PRT_GUB = "N";
            }


            //�̸�����
            if(PRT_SELT == "1" && PRT_GUB == "Y"){

            if(document.form1.cmbPRT_KIND1_SHR.checked == true) {
                var PRT_PAGE_01 = "Y" ;
			}else{
                var PRT_PAGE_01 = "N";
            }
            if(document.form1.cmbPRT_KIND2_SHR.checked == true) {
                var PRT_PAGE_02 = "Y";
			}else{
                var PRT_PAGE_02 = "N";
			}
            if(document.form1.cmbPRT_KIND3_SHR.checked == true) {
                var PRT_PAGE_03 = "Y";
			}else{
                var PRT_PAGE_03 = "N";
			}
            if(document.form1.chkPRT_YN1_SHR.checked == true) {
                var QVAL_01 = "Y";
			}else{
                var QVAL_01 = "N";
			}
            if(document.form1.chkPRT_YN2_SHR.checked == true) {
                var QVAL_02 = "Y";
			}else{
                var QVAL_02 = "N";
			}
            if(document.form1.chkPRT_YN4_SHR.checked == true) {
                var QVAL_04 = "Y";
			}else{
                var QVAL_04 = "N";
			}
            if(document.form1.chkPRT_YN7_SHR.checked == true) {
            	var QVAL_07 = "Y";
            }else{
                var QVAL_07 = "N";
			}


			var url = "pird010_PV.jsp"
			              + "?OCC_CD="+OCC_CD
                          + "&PRT_SELT="+PRT_SELT
                          + "&NO_SHR="+NO_SHR
                          + "&PRT_PAGE_01="+PRT_PAGE_01
                          + "&PRT_PAGE_02="+PRT_PAGE_02
                          + "&PRT_PAGE_03="+PRT_PAGE_03
                          + "&QVAL_01="+QVAL_01
                          + "&QVAL_02="+QVAL_02
                          + "&QVAL_04="+QVAL_04
                          + "&QVAL_07="+QVAL_07;


            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
	        return;

	        }

            //�ٷ� ���
	        else {

            var hnwParm = "[:OCC_CD]=[:PRT_SELT]=[:NO_SHR]=[:PRT_PAGE_01]=[:PRT_PAGE_02]=[:PRT_PAGE_03]=";
            hnwParm    += "[:QVAL_01]=[:QVAL_02]=[:QVAL_04]=[:QVAL_07]=";
            document.form1.rptObject.SetValues = hnwParm;

			hnwParm = "";
            hnwParm    += "[:OCC_CD]="   + document.getElementById("cmbOCC_CD_SHR").value;
            hnwParm    += "[:PRT_SELT]=" + document.getElementById("cmbPRT_SELT_SHR").value;
            hnwParm    += "[:NO_SHR]="   + document.getElementById("txtNO_SHR").value;

            if(document.form1.cmbPRT_KIND1_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_01]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_01]=N";
			}
            if(document.form1.cmbPRT_KIND2_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_02]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_02]=N";
			}
            if(document.form1.cmbPRT_KIND3_SHR.checked == true) {
                hnwParm    += "[:PRT_PAGE_03]=Y";
			}else{
                hnwParm    += "[:PRT_PAGE_03]=N";
			}


            if(document.form1.chkPRT_YN1_SHR.checked == true) {
                hnwParm    += "[:QVAL_01]=Y";
			}else{
                hnwParm    += "[:QVAL_01]=N";
			}
            if(document.form1.chkPRT_YN2_SHR.checked == true) {
                hnwParm    += "[:QVAL_02]=Y";
			}else{
                hnwParm    += "[:QVAL_02]=N";
			}

            if(document.form1.chkPRT_YN4_SHR.checked == true) {
                hnwParm    += "[:QVAL_04]=Y";
			}else{
                hnwParm    += "[:QVAL_04]=N";
			}

            if(document.form1.chkPRT_YN7_SHR.checked == true) {
            	hnwParm    += "[:QVAL_07]=Y";
            }else{
                hnwParm    += "[:QVAL_07]=N";
			}


         document.form1.rptObject.SetValues = hnwParm;
         document.form1.rptObject.RunButton("CommandPrint");
         return;

         }

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            alert("�������Դϴ�.");

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

			//�˾����� ȣ���
            if (dsTemp != null) {

                document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = false;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = false;
	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;


            }else{

	            document.getElementById("cmbOCC_CD_SHR").value    = 'AM';
	            document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = true;
	            document.getElementById("cmbPRT_SELT_SHR").value  = '1';
	            document.getElementById("txtNO_SHR").value        = '';
	            document.getElementById("txtNM_SHR").value        = '';
                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;
                document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;
                document.getElementById("chkPRT_GUB").checked  = false;
                document.getElementById("chkPRT_GUB").disabled = false;

                document.getElementById("cmbOCC_CD_SHR").focus();
            }

            document.getElementById("resultMessage").innerText = ' ';

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
            // �ٷα��� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			//�˾����� ȣ���
            if (dsTemp != null) {

               	//�ٷα���
				document.getElementById("cmbOCC_CD_SHR").value = dsTemp.NameValue(1,"OCC_CD");
            	document.getElementById("cmbOCC_CD_SHR").disabled = true;

            	//��¼���
				document.getElementById("cmbPRT_SELT_SHR").value = "1";
            	document.getElementById("cmbPRT_SELT_SHR").disabled = true;

            	//���
            	document.getElementById("txtNO_SHR").value = dsTemp.NameValue(1,"ENO_NO");
            	document.getElementById("txtNM_SHR").value = dsTemp.NameValue(1,"ENO_NM");
                document.getElementById("txtNO_SHR").className = "input_ReadOnly";
                document.getElementById("txtNO_SHR").readOnly     = true;
                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly     = true;
                document.getElementById("ImgNo").style.display = "none";

				//�⺻üũ ��
                document.getElementById("cmbPRT_KIND1_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND2_SHR").checked  = true;
	            document.getElementById("cmbPRT_KIND3_SHR").checked  = true;


	            document.getElementById("chkPRT_YN1_SHR").checked  = true;
	            document.getElementById("chkPRT_YN2_SHR").checked  = true;
	            document.getElementById("chkPRT_YN4_SHR").checked  = true;
	            document.getElementById("chkPRT_YN7_SHR").checked  = true;

            }else{

                document.getElementById("chkPRT_GUB").checked = true;
	            document.getElementById("cmbOCC_CD_SHR").focus();
            }

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsTemp != null) {
                window.close();

            } else {
                frame = window.external.GetFrame(window);

                frame.CloseFrame();
            }

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

        function fnc_Popup(cd, nm){

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
               fnc_empl2Popup(cd, nm, '1');
            }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
              // fnc_commonCodePopup(cd, nm,'�Ҽ�','A4');
               fnc_commnmPopup(cd, nm, '�Ҽ�', 'DEPT');
           }

            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
               fnc_commonCodePopup(cd, nm,'����','A2');
            }

        }

        function fnc_FldChange() {

            document.getElementById("txtNO_SHR").value = "";
            document.getElementById("txtNM_SHR").value = "";

            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {

                document.getElementById("txtNM_SHR").className = "";
                document.getElementById("txtNM_SHR").readOnly  = false;
                document.getElementById("chkPRT_GUB").disabled = false;

            } else{

                document.getElementById("txtNM_SHR").className = "input_ReadOnly";
                document.getElementById("txtNM_SHR").readOnly  = true;
                document.getElementById("chkPRT_GUB").checked  =  false;
                document.getElementById("chkPRT_GUB").disabled =  true;
                document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
                document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;


            }

        }


        //��±��п� ���� ��¼�������
        function fnc_GUBUN() {

         if(document.getElementById("chkPRT_GUB").checked  ==  true)  {

              document.getElementById("cmbPRT_KIND1_SHR").checked  =  true;
              document.getElementById("cmbPRT_KIND2_SHR").checked  =  true;
              document.getElementById("cmbPRT_KIND3_SHR").checked  =  true;

              document.getElementById("cmbPRT_KIND1_SHR").disabled  =  true;
              document.getElementById("cmbPRT_KIND2_SHR").disabled  =  true;
              document.getElementById("cmbPRT_KIND3_SHR").disabled  =  true;

              document.getElementById("txtNM_SHR").focus();

         }
         else {

              document.getElementById("cmbPRT_KIND1_SHR").disabled  =  false;
              document.getElementById("cmbPRT_KIND2_SHR").disabled  =  false;
              document.getElementById("cmbPRT_KIND3_SHR").disabled  =  false;


         }

       }


        function fnc_GetNm() {

            // ���κ�
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
                fnc_GetEnoNm('txtNO_SHR', 'txtNM_SHR','0','0');
            }

            // �ҼӺ�
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "2") {
                fnc_GetCommNm('A4', 'txtNO_SHR','txtNM_SHR');
            }

            // ������
            else if (document.getElementById("cmbPRT_SELT_SHR").value == "3") {
                fnc_GetCommNm('A2', 'txtNO_SHR','txtNM_SHR','0','0');
            }

        }

        function fnc_Getcd() {

            // ���κ�
            if (document.getElementById("cmbPRT_SELT_SHR").value == "1") {
	            fnc_GetEnoNo('txtNM_SHR','txtNO_SHR');
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)    |
    | 3. ���Ǵ� Table List(T_CM_PERSON)           |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�λ���ī��</td>
                    <td align="right" class="navigator">HOME/�λ����/�λ��������/<font color="#000000">�λ���ī��</font></td>
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
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a-->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right" >(�Ҽ�/�������� ��� BLANK: ALL)</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="80"></col>
                    <col width="80"></col>
                    <col width="192"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
					<td class="creamBold" align="right">�ٷα���</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 100%">
							<option value="A">���</option>
						</select>
					</td>
                    <td align="center" class="creamBold">���������</td>
                    <td align="center" class="padding2423">
                        <input type="checkbox" name="cmbPRT_KIND1_SHR" id=cmbPRT_KIND1_SHR style="border:0" align="absmiddle" checked>1&nbsp;
                        <input type="checkbox" name="cmbPRT_KIND2_SHR" id=cmbPRT_KIND2_SHR style="border:0" align="absmiddle" checked>2&nbsp;
                        <input type="checkbox" name="cmbPRT_KIND3_SHR" id=cmbPRT_KIND3_SHR style="border:0" align="absmiddle" checked>3&nbsp;
                    </td>
                    <td align="center" class="creamBold">��¼���</td>
                    <td class="padding2423">
                        <select id=cmbPRT_SELT_SHR onchange="fnc_FldChange()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" style="width:72">
                            <option value="1">���κ�</option>
                            <option value="2">�ҼӺ�</option>
                            <option value="3">������</option>
                        </select>
                        <input id=txtNO_SHR  name=txtNO_SHR size="8"  maxlength="8" onKeyPress="JavaScript: if(document.getElementById('cmbPRT_SELT_SHR').value == '1') cfNumberCheck(); if (event.keyCode == 13) fnc_GetNm();" onChange="fnc_GetNm();">
                        <input id=txtNM_SHR name=txtNM_SHR size="12" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_Getcd();" onchange="fnc_Getcd();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup('txtNO_SHR','txtNM_SHR')"></a>
                    </td>
                </tr>
                <tr>
                   <td align="center" class="creamBold">��¿���</td>
                    <td class="padding2423" colspan="5">
                        <input type="checkbox" name="chkPRT_YN1_SHR"  id=chkPRT_YN1_SHR  style="border:0" align="absmiddle" checked>��ü����
                        <input type="checkbox" name="chkPRT_YN2_SHR"  id=chkPRT_YN2_SHR  style="border:0" align="absmiddle" checked>��������
                        <input type="checkbox" name="chkPRT_YN4_SHR"  id=chkPRT_YN4_SHR  style="border:0" align="absmiddle" checked>��������
                        <input type="checkbox" name="chkPRT_YN7_SHR"  id=chkPRT_YN7_SHR  style="border:0" align="absmiddle" checked>���&nbsp;
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                     <td class="padding2423" colspan="5">
                         <input type="checkbox" name="chkPRT_GUB"     id=chkPRT_GUB      style="border:0" align="adsmiddle" onClick="fnc_GUBUN()"  checked>�̸�����
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
                    <td valign="top" class="searchState">
                    <!--���⼭���� �ڵ��Դϴ�//-->
                    <comment id="__NSID__">
                      <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
                      <param name="hnwsrc"    VALUE="pird010.hnw">
                      <param name="initvalue" VALUE="">
                      <param name="hidewnd"   VALUE="N">
                      <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                      </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    <!--������� �ڵ��Դϴ�//-->

                        <span id="resultMessage">&nbsp;</span>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>
