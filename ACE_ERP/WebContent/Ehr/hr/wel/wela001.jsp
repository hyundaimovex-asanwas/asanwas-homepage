	<!--*************************************************************************
	* @source      : wela001.jsp												*
	* @description : �����Ļ��ȳ�		                                        *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2014/07/01            �̵���         	        �����ۼ�					*	
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�����Ļ��ȳ�</title>
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
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
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

    </script>
</head>



	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(0)">
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">�����Ļ��ȳ�</td>
					<td align="right" class="navigator">HOME/�����Ļ�/<font color="#000000">�����Ļ��ȳ�</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->
<br>
<br>
<!-- �� ��� ���۳�Ʈ ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- �ǹ�ư���̺� ���� -->
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="180">
                        <!-- �ǿ��� -->
                        <table width="180" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">������� ���� ����</td>
                                <td width="6"><img src="../../images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">���ڱ� ���ޱ���</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">����ī�� �����ȳ�</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="../../images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">����Ÿ ���ڱ�</td>
                                <td width="6"><img src="../../images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                </tr>

</table>

<hr width="800" size="5" align="left" color="#97C821">

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabAIDA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/11.jpg" width="720" height="1512">
  </td>
 </tr>
</table>

</div>

<!-- ��2 ���� �Է� ���̺� ���� -->
<div class=page id="tabAIDA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/22.jpg" width="720" height="794">
  </td>
 </tr>
</table>

</div>


<!-- ��3 ���� �Է� ���̺� ���� -->
<div class=page id="tabAIDA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/33.jpg" width="720" height="1512">
  </td>
 </tr>
</table>

</div>



<!-- ��4 ���� �Է� ���̺� ���� -->
<div class=page id="tabAIDA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >

<table>
 <tr>
   <td>
  		<img src="../../images/common/44.jpg" width="720" height="869">
  </td>
 </tr>
</table>

</div>


</BODY>
</HTML>
