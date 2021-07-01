<!--
***********************************************************************
* @source      : idtb009.jsp
* @description : �ڵ� ��ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2019/03/13      �̵���        ERP �̻�
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>�ڵ� ��ȸ</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="../../common/common.js"></script>
    <script language=javascript src="../../common/mdi_common.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>
	<base target="_self">

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		var retObj = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_CM_COMMON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb001.cmd.IDTB001CMD&S_MODE=SHR_COD&GBN="+retObj.gbn+"&COMM_CD="+document.getElementById('txtCOMM_CD_SHR').value;
           
			//trT_CM_CONTRACT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb001.cmd.IDTB001CMD&S_MODE=SAV";            
            
            //prompt('',dsT_CM_COMMON.DataID);
            
            dsT_CM_COMMON.Reset();

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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			window.close();

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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_CM_COMMON,0,"false","right");      // Grid Style ����

            document.getElementById("title").innerText      = retObj.title;
   
            //retObj.comm_cd = '';
            //retObj.comm_nm = '';

            fnc_SearchList();

			//document.getElementById('txtCOMM_CD_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
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
    | 2. �̸��� ds_ + �ֿ� ���̺��()      |
    | 3. ���Ǵ� Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_CM_COMMON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = ' ';
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			document.getElementById('txtCOMM_CD_SHR').focus();

        } else {

            document.getElementById("resultMessage").innerText = '* '+iCount+' ���� �ڷᰡ ��ȸ�Ǿ����ϴ�.';
	  	 	grdT_CM_COMMON.SetColumn("COMM_CD");//set focus

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_COMMON Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-------------------------------+
    | �׸����� ROW�� ���� Ŭ�� �Ҷ�  |
    +-------------------------------->
	<script language=JavaScript for=grdT_CM_COMMON event=OnDblClick(row,colid)>

		var retObj = window.dialogArguments;

		//retObj.comm_cd = dsT_CM_COMMON.NameValue(row,'CODE_CD');
		//retObj.comm_nm = dsT_CM_COMMON.NameValue(row,'CODE_NM');
		//retObj.cd_gbn  = dsT_CM_COMMON.NameValue(row,'CD_GBN');

		
		retObj.p01_amt  = dsT_CM_COMMON.NameValue(row,'P01_AMT');
		retObj.p02_amt  = dsT_CM_COMMON.NameValue(row,'P02_AMT');
		retObj.p03_amt  = dsT_CM_COMMON.NameValue(row,'P03_AMT');		
		retObj.p04_amt  = dsT_CM_COMMON.NameValue(row,'P04_AMT');
		
		window.close();

	</script>

	<!-------------------------------+
    | �׸����� ROW���� ���� �Է��Ҷ�|
    +-------------------------------->
	<script language=JavaScript for=grdT_CM_COMMON event=OnReturn(row,colid)>

		var retObj = window.dialogArguments;

		//retObj.comm_cd = dsT_CM_COMMON.NameValue(row,'CODE_CD');
		//retObj.comm_nm = dsT_CM_COMMON.NameValue(row,'CODE_NM');
		//retObj.cd_gbn  = dsT_CM_COMMON.NameValue(row,'CD_GBN');

		retObj.p01_amt  = dsT_CM_COMMON.NameValue(row,'P01_AMT');
		retObj.p02_amt  = dsT_CM_COMMON.NameValue(row,'P02_AMT');
		retObj.p03_amt  = dsT_CM_COMMON.NameValue(row,'P03_AMT');		
		retObj.p04_amt  = dsT_CM_COMMON.NameValue(row,'P04_AMT');
		
		window.close();

	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- �̸��� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
		<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="550" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="25" background="../../images/common/barBg.gif">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle"><span id="title"></span>������ȸ</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="550" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)">
	            <img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()">
	            </a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="550" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td align="center" class="blueTable">
	                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                            <tr>
	                                <td align="center" class="searchState">��� �ڵ�&nbsp;</td>
									<td class="padding2423">
									<input name="txtCOMM_CD_SHR" id="txtCOMM_CD_SHR" size="50" maxlength="50" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									<input type="text" style="display:none">
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
	<table width="550" border="0" cellspacing="0" cellpadding="0">
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
	<table width="450" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
	                <tr align="center">
	                    <td>
	                        <comment id="__NSID__">
	                        <object    id="grdT_CM_COMMON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:550px;height:300px;">
	                            <param name="DataID"            value="dsT_CM_COMMON">
								<param Name="Editable"          value="false">
	                            <param name=HiddenHScroll    	value="true">
	                            <param name="Format"            value='
	                            	<C> id=JOB_CD		width=100	name=�����ڵ�		align=center 	show=false</C>
	                            	<C> id=JOB_NM		width=100	name=����			align=center 	suppress=1</C>	                            	
	                                <C> id=GRADE_CD		width=80    name=���    		align=center	</C>
	                                
	                            	<C> id=P01_AMT		width=80	name=�⺻����		align=right 	</C>
	                                <C> id=P02_AMT		width=80    name=�ð���\\����   align=right		</C>	                                
	                                
	                            	<C> id=P03_AMT		width=80	name=���ϼ���		align=right 	</C>
	                                <C> id=P04_AMT		width=80    name=Ư����\\����   align=right 	</C>	                                
	                                
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
	
	
	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="450" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState">* �ش��׸��� ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
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