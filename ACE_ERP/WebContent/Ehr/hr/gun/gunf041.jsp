<!--
*****************************************************
* @source       : gunf041.jsp
* @description : �ٹ����� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/01/23      �̵���        ���� �ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO   = request.getParameter("ENO_NO");
	String prmYYYY     = request.getParameter("YYYY");
	String prmMONTH    = request.getParameter("MONTH");
%>

<html>
<head>
<title>�ٹ� Ȯ��</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var prmENO_NO   = "<%=prmENO_NO %>";    //���

        var prmYYYY     = "<%=prmYYYY %>";      //����
        
        var prmMONTH    = "<%=prmMONTH %>";     //��        
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����
			var eno_no = prmENO_NO;		//���
			var yyyy   = prmYYYY;		//����
			var mm     = prmMONTH;		//��
			
			//alert("eno_no: "+eno_no);
			//alert("yyyy: "+yyyy);
			//alert("mm: "+mm);			
			
			//dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf070.cmd.GUNF070CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no;
			
			dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf040.cmd.GUNF040CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no+"&PIS_YM="+yyyy+mm;			
			
			dsT_DI_WORKSTYLE.reset();

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
            if (dsT_DI_WORKSTYLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_MONTHLY.GridToExcel("����Ȯ��", '', 225);

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
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			cfStyleGrid_New(form1.grdT_DI_MONTHLY,15,"false","false");      // Grid Style ����

			fnc_SearchList();
			
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
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_WORKSTYLE                      |
    | 3. Table List : T_DI_MONTHLY                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_WORKSTYLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
		<PARAM NAME="SubsumExpr"	  VALUE="total,1:WEEK_NO">          
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=2000000>
 
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_WORKSTYLE)		|
    | 3. ���Ǵ� Table List(T_DI_MONTHLY)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_MONTHLY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_MONTHLY.focus();
        }

    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_MONTHLY event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_MONTHLY event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>



<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../images/button/btn_ExcelOver.gif',1)"> 
	        <img src="../../images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->



<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="950" border="0" cellspacing="0" cellpadding="0">
		<tr align="center">
			<td>
				<comment id="__NSID__">
				<object	id="grdT_DI_MONTHLY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
					<param name="DataID"				value="dsT_DI_WORKSTYLE">
					<param name="EdiTABLE"				value="false">
					<param name="DragDropEnable"		value="true">
					<param name="SortView"				value="Left">
					<param name="VIEWSUMMARY"			value=0>
					<param name="Format"				value="
								<C> id='WEEK_NO'		width=50			name='����'					align=center			suppress=1 Value={Decode(CurLevel,1,'�Ұ�',WEEK_NO)}</C> 								
								<C> id='DPT_NM'			width=120			name='�Ҽ�'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NM'			width=80			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='HOL_YN'			width=50			name='����'					align=center			show=false</C>
								<C> id='REG_YMD'		width=100			name='����'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='YOIL'			width=50			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C> 
								<C> id='GUBUN'			width=80			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='STR_TIME'		width=100			name='�ٹ�����'				align=center			</C>
								<C> id='END_TIME'		width=100			name='�ٹ�����'				align=center			</C>		
								<C> id='WRK_TIME'		width=100			name='�ٹ��ð�'				align=center			DEC=1</C>			
								<C> id='WEEK_TOT_TIME'	width=100			name='����\\�ٷνð�'			align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='REMARK'			width=300			name='����'					align=left			</C>
							">
				</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
			</td>
		</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

