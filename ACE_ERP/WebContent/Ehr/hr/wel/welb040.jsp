<!--
***********************************************************************
* @source      : welb040.jsp
* @description : �ӿ������������ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/08      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ӿ������������(welb040)</title>
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

		var btnList = 'TFTTFFTT';
        var type = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

            form1.document.getElementById("grdT_WL_HDPCBOOK").focus();


			dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
    		dsT_WL_HDPCBOOK.reset();

            //��ȸ�Ҷ� �ʱ�ȭ
            fnc_EnableElementAll(shrList);
            dsT_WL_HDPCBOOK.UseChangeInfo = true;
            type = "";

            if(dsT_WL_HDPCBOOK.NameValue(1,"JOB_NM") == null){
              fnc_ShowElement("imgConduct");
              fnc_ShowElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_ShowElement("Image5");
           }

        }


        /**
         * ó�� ����
         */
        function fnc_Proc() {
            var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;

            if(pis_yymm == "") {
                alert("��� ����� �Է��ϼ���");
                return;
            }

            dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SHR_PROC&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
            dsT_WL_HDPCBOOK.reset();

            fnc_DisableElementAll(shrList);
            dsT_WL_HDPCBOOK.UseChangeInfo = false;  //������ ��� �Է��ϰ� ����(insert ó��)
            type = "PROC";
            alert("���� ����� Ȯ�� �� ���� ��ư�� ��������");
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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			trT_WL_HDPCBOOK.KeyValue = "tr01(I:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
			trT_WL_HDPCBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=SAV&TYPE="+type;
			trT_WL_HDPCBOOK.post();

            fnc_ShowElement("imgConfirm");
         }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_WL_HDPCBOOK.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("�����Ͻ� [�������:"+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_YM')+" �޴�����ȣ:"+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PHN_NO')+"] �� �ش��ϴ� �����͸� �����մϴ�.\n�����Ͻðڽ��ϱ�?")){
				dsT_WL_HDPCBOOK.DeleteRow(dsT_WL_HDPCBOOK.RowPosition);

				trT_WL_HDPCBOOK2.KeyValue = "tr01(I:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
				trT_WL_HDPCBOOK2.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=DEL&PIS_YY="+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_YY')+"&PIS_MM="+dsT_WL_HDPCBOOK.NameValue(dsT_WL_HDPCBOOK.RowPosition,'PIS_MM');
				trT_WL_HDPCBOOK2.post();
			}

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

			if (dsT_WL_HDPCBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_WL_HDPCBOOK.GridToExcel("�ڵ��� ������ ����", '', 225);

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

			document.getElementById("resultMessage").innerText = ' ';
			dsT_WL_HDPCBOOK.ClearData();

            fnc_EnableElementAll(shrList);

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_HDPCBOOK.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
            if (!dsT_WL_HDPCBOOK.IsUpdated && dsT_WL_HDPCBOOK.UseChangeInfo) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            if(type == "PROC"
                    && !confirm(document.getElementById('txtPIS_YM_SHR').value+" �����͸� �űԷ� �����մϴ�.\n���� �����ʹ� �ʱ�ȭ �˴ϴ�. �����Ͻðڽ��ϱ�?"))
                return false;

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
          function fnc_OnLoadProcess() {
 //           cfStyleGrid2(form1.grdT_WL_HDPCBOOK);      // Grid Style ����
            cfStyleGrid(form1.grdT_WL_HDPCBOOK,15,"false","false");      // Grid Style ����

            form1.grdT_WL_HDPCBOOK.Editable = "true";

            document.getElementById('txtPIS_YM_SHR').value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById('txtPIS_YM_SHR').focus();

        }

            //�Ϸ� �� ��ư �Ⱥ��̰�
           function hid_button() {

           var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;
           dsT_WL_HDPCBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=FINSHR&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
    	   dsT_WL_HDPCBOOK.reset();

           var YN_TAG = document.getElementById('hidYN_TAG').value;

      	   if(YN_TAG >0 ){
    	      fnc_HiddenElement("imgConduct");
              fnc_HiddenElement("Image4");
              fnc_HiddenElement("imgConfirm");
              fnc_HiddenElement("Image5");
    	   }
    	   else{
            fnc_ShowElement("imgConduct");
            fnc_ShowElement("Image4");
            fnc_ShowElement("imgConfirm");
            fnc_ShowElement("Image5");
            }

            fnc_SearchList();
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        var shrList = new Array(     "txtPIS_YM_SHR"
                                    ,"imgPIS_YM_SHR"
                                );


         /**
         * �Ϸ� ����
         */
        function fnc_Fins()
        {
         if(dsT_WL_HDPCBOOK.CountRow < 1) {
				alert("��ȸ�� ó��->���� ��ư�� ������ �� �Ϸ��۾��� �Ͻʽÿ�.");
			}
	    else{
	          var pis_yymm = document.getElementById('txtPIS_YM_SHR').value;


			trT_WL_HDPCBOOK.KeyValue = "tr01(O:dsT_WL_HDPCBOOK=dsT_WL_HDPCBOOK)";
		    trT_WL_HDPCBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.wel.b.welb040.cmd.WELB040CMD&S_MODE=FINS&PIS_YY="+pis_yymm.substring(0,4)+"&PIS_MM="+pis_yymm.substring(5,7);
			trT_WL_HDPCBOOK.post();

			fnc_HiddenElement("imgConduct");
            fnc_HiddenElement("Image4");
            fnc_HiddenElement("imgConfirm");
            fnc_HiddenElement("Image5");


		    }
        }

        //�޷� ��Ŀ�� ����
          function card_con(){
           document.getElementById('grdT_WL_HDPCBOOK').focus();
           document.getElementById('txtPIS_YM_SHR').focus();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_HDPCBOOK) |
    | 3. ���Ǵ� Table List(T_WL_HDPCBOOK)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_HDPCBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_HDPCBOOK)	|
    | 3. ���Ǵ� Table List(T_WL_HDPCBOOK)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_HDPCBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    <Object ID ="trT_WL_HDPCBOOK2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_HDPCBOOK Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_HDPCBOOK Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_HDPCBOOK Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_HDPCBOOK event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>
    <script for=trT_WL_HDPCBOOK2 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_HDPCBOOK event="OnFail()">
        cfErrorMsg(this);
    </script>
    <script for=trT_WL_HDPCBOOK2 event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess(); hid_button();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" onblur="card_con();" ></iframe>
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ӿ������������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�޴�������/<font color="#000000">�ӿ������������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Proc()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
									<col width="70"></col>
									<col width="80"></col>
                             		<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">�������&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM_SHR" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfCheckNumber();" onkeyup="cfDateHyphen(this);" style="ime-mode:disabled" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; this.focus();} hid_button();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPIS_YM_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','10','116');"></a>
                                </td>
								<td>&nbsp;</td>
								<td>
								</td>
								<td class="padding2423">
                                      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','/images/button/btn_OutOver.gif',1)"><img src="/images/button/btn_OutOn.gif" name="imgConfirm" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Fins()"></a>
                                      <input type="hidden" id="hidYN_TAG">
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
						<object	id="grdT_WL_HDPCBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
							<param name="DataID"	 value="dsT_WL_HDPCBOOK">
                            <param name="ColSelect"  value="true">
                            <param name="Editable"   value="true">
							<param name="Format"					value="
								<C> id={currow}		 width=55   name='NO'			align=center </C>
                                <C> id='JOB_NM'      width=90   name='����'           align=left Edit=None </C>
                                <C> id='ENO_NO'      width=95   name='���'           align=center Edit=None </C>
                                <C> id='ENO_NM'      width=95   name='����'           align=center Edit=None </C>
                                <C> id='NM_GBN_VAL'  width=90   name='����'           align=center Edit=None Value={Decode(NAME_GBN,'1','���θ���','2','���θ���')}</C></C>
                                <C> id='PHN_NO'      width=120  name='�޴�����ȣ'     align=left Edit=None </C>
								<C> id='PIS_YM'	     width=90	name='���������'	  align=center Edit=None </C>
								<C> id='KR_USE_AMT'	 width=130	name='����'		  align=right BgColor='#F0FFF0'</C>
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


<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

<!-- T_AC_CEFBOOK ���� ���̺� -->
	<!-- T_ID_CEFBOOK ���� ���̺� -->
	<object id="bndT_WL_HDPCBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_HDPCBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=YN_TAG      Ctrl=hidYN_TAG     Param=value</C>
		">
	</object>