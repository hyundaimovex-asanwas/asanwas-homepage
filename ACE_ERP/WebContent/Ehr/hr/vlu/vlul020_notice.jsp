<!--
***********************************************************************
* @source      : vluk050_notice.jsp
* @description : �򰡱Ⱓ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/11/21      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ھȳ���(vluk050_notice)</title>
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

		var btnList = 'TTTTFFTT';

        var today = '<%=box.get("SESSION_TODAY")%>';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {



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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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

			cfStyleGrid(form1.grdT_EV_RQSTYMD,15,"false","false");      // Grid Style ����

			document.getElementById("txtEVA_YY_SHR").value = getToday().substring(0,7);

            fnc_DisableElementAll(elementList);
            
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



<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onload="fnc_OnLoadProcess();">



<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���� �ȳ���</td>
					<td align="right" class="navigator">HOME/�λ���/������/<font color="#000000">���� �ȳ���</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->



<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�ȳ���</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->
<br>
<font color="black" size="3"  face = "����"">��  �λ��򰡴� ȸ����</font>
<font color="blue" size="3"  face = "����"">�λ���å ������ �����ϴ� ����</font>
<font color="black" size="3"  face = "����"">�� �˴ϴ�.</font>
<br><font color="black" size="1"  face = "����"">  </font><br>
<font color="black" size="3"  face = "����"">���� �򰡴� </font>
<font color="blue" size="3"  face = "����"">������� �� �ɷ� / ���� ����� ���� �����ڷ�</font>
<font color="black" size="3"  face = "����"">�� �ǰ�, </font>
<br><font color="black" size="1"  face = "����"">  </font><br>
<font color="black" size="3"  face = "����"">��������  </font>
<font color="blue" size="3"  face = "����"">������ ó��</font>
<font color="black" size="3"  face = "����"">�� ���� �� �ʿ��� ����Դϴ�. </font>
<br><font color="black" size="1"  face = "����"">  </font><br>
<font color="black" size="3"  face = "����"">���ں��� </font>
<font color="red" size="3"  face = "����"">����</font>
<font color="black" size="3"  face = "����"">�ϰ�</font>
<font color="red" size="3"  face = "����"">�������� ��</font>
<font color="black" size="3"  face = "����"">�� ��� �帮��, </font>
<br><font color="black" size="1"  face = "����"">  </font><br>
<font color="black" size="3"  face = "����"">���� �Ϲ����� ������ �˷��帮���� �����Ͻñ� �ٶ��ϴ�.  </font>
<br>
<br>
<br><br>

<font color="black" size="4"face = "����"">��  ������  </font>
<font color="blue" size="4" face = "����"">�Ϲ��� ����</font>
<br><br>
<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" >
          <tr bgcolor="#FFF8EE" height="40" >
            <td width="200" align = "center" >
              <font color="#333333" face="����" size = 3><b>�򰡿���</b></font> 
            </td>
            <td width="500" bgcolor="#FFF8EE" align = "center">
              <font color="#333333" face="����" size = 3><b>��&nbsp;��</b></font> 
            </td>
            <td width="300" bgcolor="#FFF8EE" align = "center">
              <font color="#333333" face="����" size = 3><b>��&nbsp;��</b></font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2><b>��Ȥȿ��</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="����" size = 2>�������� Ư�� �پ ���� ��Ȥ�Ǿ� �� ����� ��ü�� ���� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2>�з�, ��Ŵ���, �ܸ� ��</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2><b>����ȭ(��Ȥȭ)</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="����" size = 2>���������� ���������� ���ϰ� ���ϰų� ����ġ�� ���� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
               <font color="#333333" face="����" size = 2>�򰡿� ���� �η���, ������ ����, ���ɷ�</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2><b>�߽�(ǥ��)ȭ</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="����" size = 2>���� ��ټ����� �߰� ������ �ο��ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2>�򰡿� ���� ������, �򰡿� ���� �η���</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2><b>���� ����</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font color="#333333" face="����" size = 2>���� ���õ� �Ͱ� ���� ����׸� ���ų� ����� �򰡸� �ο��ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font color="#333333" face="����" size = 2>������ ������ ������ ����</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2><b>������</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="����" size = 2>�ڽ��� �ɷ�, Ư������ �ݴ�� ���ϸ� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2>�ڽ��� ��/���� ����</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2><b>������ ��</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="����" size = 2>Ư���� ������ ������ �ǵ������� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2>����, �ڱ��� �����</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2><b>������� �߽�</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="����" size = 2>�򰡽����� ������ ����� �߽��Ͽ� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2>�ֱ� ������ �߽�</font>
            </td>            
          </tr>
          <tr height="40" >
            <td width="200" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2><b>������ ���</b></font>
            </td>
            <td width="500" bgcolor="#FFFFFF">
              <font face="����" size = 2>������, ������ ��� �� �������� ������� ���ϴ� ���</font>
            </td>
            <td width="300" bgcolor="#FFFFFF" align = "center">
              <font face="����" size = 2>����, ����, ����, ��Ұ��� ��</font>
            </td>            
          </tr>              
    
          
    </table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>
