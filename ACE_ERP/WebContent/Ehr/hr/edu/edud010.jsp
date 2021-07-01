	<!--*************************************************************************
	* @source      : edud010.jsp												*
	* @description : �н��������̵�		    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>�н��������̵�</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

        //Layer ID
        var layerList = new Array(  "tabAIDA001_01"
                                   ,"tabAIDA001_02"
                                   ,"tabAIDA001_03"
                                   ,"tabAIDA001_04"
                                    );
        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {

            ActiveIndex = idx+1;
			fnc_ShowHiddenLayer(layerList, layerList[idx]);
            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=4; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }

                document.getElementById("TabLeft0"+i).src = "../../images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "../../images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "../../images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "../../images/common/tab25Right.gif";

            //fnc_TabOnClick(ActiveIndex);

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	TabEvent(0);

        }        
        
        
    </script>
</head>



	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<!--  <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(0)"> -->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<br>
<!-- �� ��� ���۳�Ʈ ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- �ǹ�ư���̺� ���� -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="150">
                        <!-- �ǿ��� -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">���������̼�����</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">Cy-learn ���ñ���</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="170" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">�ܺ���Ź����</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="170" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">���б���</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

</table>

<hr width="1000" size="5" align="left" color="#97C821">

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabAIDA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >


<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>�� ���������̼�����(*���濵�Ⱓ���� ���� ����)</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>1. �����</SPAN></P>

<DIV STYLE=''>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ��&nbsp; �� : 4���̻� �� ���� (4�޻��~����)&nbsp;&nbsp;&nbsp;&nbsp; (��, ���� ������ȸ�� �� ���� ����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : �ǹ����� / ���ñ��� </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : �� ������ 10���� (�ų� 1�����̻� ����), ������ ������ �ݿ�</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ��������Ⱓ : ���� ü���Ⱓ (�� ����1���� ~ ���� ���⵵)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� 1���� �����Ⱓ : ���� 12��1��~���س� 11��30��</SPAN></P>


</DIV>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>2. �����з� �� ��������</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="68" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ��</SPAN></P>
	</TD>
	<TD width="351" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ��</SPAN></P>
	</TD>
	<TD width="136" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��������</SPAN></P>
	</TD>
	<TD width="121" height="32" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���� Point</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="68" height="93" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�ǹ�����</SPAN></P>
	</TD>
	<TD width="351" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;�׷찡ġ����</SPAN></P>
	</TD>
	<TD width="136" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�̹ݿ�</SPAN></P>
	</TD>
	<TD width="121" height="40" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>������ ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="351" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;������������</SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;(������ / ��ȭ �����ʰ���, ���Ի������)</SPAN></P>
	</TD>
	<TD width="136" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��10����</SPAN></P>
	</TD>
	<TD width="121" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>������ ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="68" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���ñ���</SPAN></P>
	</TD>
	<TD width="351" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;������������</SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;(�Ǽ�����ں���/CS��������/�ܺ���Ź���� ��)</SPAN></P>
	</TD>
	<TD width="136" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��10����</SPAN></P>
	</TD>
	<TD width="121" height="59" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�߰����� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="68" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��Ÿ����</SPAN></P>
	</TD>
	<TD width="351" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;�系��������������, �ܺΰ��� ��ûƯ��, </SPAN></P>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"����";'>&nbsp;����տ��汳��, �系���а��� ��</SPAN></P>
	</TD>
	<TD width="136" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�̹ݿ�</SPAN></P>
	</TD>
	<TD width="121" height="55" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�̹ݿ�</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>3. ���޺� �����̼�����</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD colspan="2" width="122" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ��</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>����</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�δ�</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>����</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>����</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�븮</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>4��</SPAN></P>
	</TD>
	<TD width="160" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="122" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��������</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>-</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>3��</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>4��</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>5��</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>4��</SPAN></P>
	</TD>
	<TD width="65" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>4��</SPAN></P>
	</TD>
	<TD width="160" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="122" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�ּ��̼�����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>50����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>40����</SPAN></P>
	</TD>
	<TD width="65" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>40����</SPAN></P>
	</TD>
	<TD width="160" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ü���Ⱓ</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�ų� 1���� �̼�����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="9" width="673" height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="38" height="91" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��)</SPAN></P>
	</TD>
	<TD width="84" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�ǹ�����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>10����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>10����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>10����</SPAN></P>
	</TD>
	<TD width="160" height="47" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>������/��ȭ �����ʱ���</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="84" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���ñ���</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>20����</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="65" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>30����</SPAN></P>
	</TD>
	<TD width="160" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>&nbsp;</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>&nbsp;�� ���� ü���Ⱓ�� 6���� �̻��� ��� 1������ ����</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"���Ĺ���";'><BR></SPAN></P>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->
<div class=page id="tabAIDA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >


<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� Cy-learn ���ñ���</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>1. ��������</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : 400������ �پ��� ���� ������ (������ȭ ������, ���а���, OA ��ų�� ���� ��)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ������� : �� ������ (�����) </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : �ſ�</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : ������ ��������(��, �̼���� �Ϳ��޿����� ����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ������� : ���� 60�� �̻�, ������ 80% �̻�, ������ ����, ������ ����(���α����� ���� ��ũ����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>2. ��������</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD colspan="2" width="163" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���� ������</SPAN></P>
	</TD>
	<TD width="389" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���� �ȳ�</SPAN></P>
	</TD>
	<TD width="106" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ��</SPAN></P>
	</TD>
</TR>
<TR>
	<TD rowspan="2" width="81" height="88" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��������</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��ȭ����</SPAN></P>
	</TD>
	<TD width="82" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�ٽɿ���</SPAN></P>
	</TD>
	<TD width="389" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��ȹ��, â�Ƿ�, �����ذ�,������,���������̼� ��ų �� &#160;</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� ���޺� ������ȭ�� ���� ������</SPAN></P>
	</TD>
	<TD width="106" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>100���� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="82" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>��������</SPAN></P>
	</TD>
	<TD width="389" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�Ǽ�, �ε���, ������, ����, ����, ��ȹ/�λ�, �繫,</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>ȸ�� �� �������� ������ȭ�� ���� ������ </SPAN></P>
	</TD>
	<TD width="106" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>100���� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="163" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���а���</SPAN></P>
	</TD>
	<TD width="389" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>����, �Ͼ�, �߱��� ��</SPAN></P>
	</TD>
	<TD width="106" height="39" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>150���� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" width="163" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>���뿪�� ��ȭ����</SPAN></P>
	</TD>
	<TD width="389" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>OA ��ų ����� ���� ������ (Excel,Word,PPT ��)</SPAN></P>
	</TD>
	<TD width="106" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>50���� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="4" width="658" height="44" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-family:"����";'>�� �� ������ </SPAN><SPAN STYLE='font-family:"����";text-decoration:"underline";'>����ϴ� �������� ���� �ǽõǴ� ���ñ���</SPAN><SPAN STYLE='font-family:"����";'>�Դϴ�.</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>3. ��û���</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>&nbsp;&nbsp;&nbsp;�� ��û��� : Cy-learn����Ʈ ���� �� ��û  <a href="http://group.cy-learn.co.kr/"target="_blank">http://group.cy-learn.co.kr </a></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>&nbsp;&nbsp;&nbsp;�� ��û�Ⱓ : �ſ� 1~23��</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"���Ĺ���";'><BR></SPAN></P>
</div>

<div class=page id="tabAIDA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
 <P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �ܺ���Ź����</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>1. ��������</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : �����ɷ� ����� ���� �ܺα�������� ����(������������, �ǽǱ���� �������� ��)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ������� : �� ������ (�����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : ������ ��������(��, �̼���� �Ϳ��޿����� ����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>2. �������� : ������������ ��</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �系������ �������� : ����, ȸ��, ����, ǰ��/��������, ����, CS ��</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �Ǽ������ �������� : �Ǽ������ �������� �����ɷ� ���� ���� ����</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>3. ���� ���μ���</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>����������</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��û�μ�</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="3" width="409" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>�������ɿ��� ����</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>�ܺ���Ź���� ���ɼ� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>�������� �����뺸</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>������û��</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��û�� ����/����</SPAN></P>
	</TD>
	<TD width="44" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="182" height="38" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��û�� ����/�뺸</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��û�� ����/���� �뺸</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>������ó��, �����ǽ�</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>������ ��뺸��ȯ��</SPAN></P>
	</TD>
	<TD width="44" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="182" height="35" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>�������, ȯ�޼��� ����</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="21" valign="middle" style='border-left:none;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>��</SPAN></P>
	</TD>
	<TD width="44" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="21" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="183" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>�����̷°���</SPAN></P>
	</TD>
	<TD width="44" height="37" valign="middle" style='border-left:solid #000000 0.4pt;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='margin-right:-2.9pt;text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
	<TD width="182" height="37" valign="middle" style='border-left:none;border-right:none;border-top:none;border-bottom:none;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-family:"����";letter-spacing:0.1pt;'>&nbsp;</SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"���Ĺ���";'><BR></SPAN></P>
</div>


<div class=page id="tabAIDA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ���б���</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ���� : �������� �۷ι� ������ȭ�� ���Ͽ� �系 ���б��� ������ ����(�׷� ���հ���)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ������� : �� ������(�����)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �����Ⱓ : 3����(14��), ���� 3�� ���� � </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : �ܱ���(����,�߱���,�Ϻ���)ȸȭ �� ���Ͱ��� </SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ��û��� : ���� �ǽ��� ���� ������û�Ⱓ ����</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� �������� : ������ ��������(��, ������� ���κδ�)</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"����";'>�� ������� : �⼮�� 70% �̻�(�̼���� ������ �Ϳ��޿� ���� �� ��������)</SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-family:"���Ĺ���";'><BR></SPAN></P></div>


</BODY>
</HTML>
