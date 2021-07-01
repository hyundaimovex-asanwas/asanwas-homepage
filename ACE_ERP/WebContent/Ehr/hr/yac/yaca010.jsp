<!--
****************************************************************************
* @source      : yaca010.jsp                                                													*
* @description : �������������ȳ� PAGE                                      												*
****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 												*
*----------------------------------------------------------------------------
* 2012/11/23            �̵���             �����ۼ�                         															*
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>
<%
Configuration configPath = Configuration.getInstance();
String fileDownLoadPath = configPath.getString("framework.file.download");
%>
<HTML><HEAD><TITLE>�������������ȳ�</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<link href="/css/general2.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "F"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
        //Layer ID
        var layerList = new Array(  "tabYACA001_01"
                                   ,"tabYACA001_02"
                                   ,"tabYACA001_03"
                                   ,"tabYACA001_04"
                                   ,"tabYACA001_05"
                                   ,"tabYACA001_06"
                                   ,"tabYACA001_07"
                                   ,"tabYACA001_08"
                                   ,"tabYACA001_09"
                                   ,"tabYACA001_10"
                                    );


        //Layer ID
        var LeftlayerList = new Array(  "layer_1"
                                   ,"layer_2"
                                   ,"layer_3"
                                   ,"layer_4"
                                   ,"layer_5"
                                   ,"layer_6"
                                   ,"layer_7"
                                   ,"layer_8"
                                   ,"layer_9"
                                   ,"layer_10"
                                   ,"layer_11"
                                   ,"layer_12"
                                    );

        var LeftTwolayerList = new Array(  "layerTwo_1"
                                   ,"layerTwo_2"
                                   ,"layerTwo_3"
                                   ,"layerTwo_4"
								   );

        /**
         * �ش� ���̾� �����ְ� �ݱ�
         * @param Ŭ���� layer idx
         */
        function TabEvent(idx) {
            ActiveIndex = idx+1;
			fnc_ShowHiddenLayer(layerList, layerList[idx]);
            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=10; i++) {
                if(document.getElementById("TabBtn0"+i) == undefined) {
                    continue;
                }
                document.getElementById("TabLeft0"+i).src = "/images/common/tabGray25Left.gif";
                document.getElementById("TabBtn0"+i).className = "hiddenMenu25";
                document.getElementById("TabRight0"+i).src = "/images/common/tabGray25Right.gif";
            }

            document.getElementById("TabLeft0"+ActiveIndex).src = "/images/common/tab25Left.gif";
            document.getElementById("TabBtn0"+ActiveIndex).className = "overMenu25";
            document.getElementById("TabRight0"+ActiveIndex).src = "/images/common/tab25Right.gif";

            //fnc_TabOnClick(ActiveIndex);

        }
        /**
         * ������ â���� �����ְ� �ݴ� ��Ȱ
         */
        function fnc_ClickBtn(selectKey) {
            var indexKey;

            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(LeftlayerList, LeftlayerList[parseInt(selectKey)-1]);

            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=12; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("LeftTabBtn"+indexKey) == undefined) {
                    continue;
                }
                document.getElementById("LeftTabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("LeftTabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("LeftTabBtn"+indexKey).className    = "tabV";
                document.getElementById("LeftTabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("LeftTabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("LeftTabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("LeftTabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("LeftTabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";
        }
        /**
         * ������ â���� �����ְ� �ݴ� ��Ȱ
         */
        function fnc_ClickBtnTwo(selectKey) {
            var indexKey;

            //Layer �����ְ� �ݱ�
            fnc_ShowHiddenLayer(LeftTwolayerList, LeftTwolayerList[parseInt(selectKey)-1]);

            //Tab �̹��� �����ְ� �ݱ� (���� ���ѿ� ���� �����ִ°Ͱ� �ƴѰ��� �޶���)
            for(var i=1; i<=4; i++) {
                indexKey = lpad(i, 2, "0");
                if(document.getElementById("LeftTwoTabBtn"+indexKey) == undefined) {
                    continue;
                }
                document.getElementById("LeftTwoTabLeft"+indexKey).src         = "/images/common/tabTop.gif";
                document.getElementById("LeftTwoTabBtn"+indexKey).background   = "/images/common/tabMiddle.gif";
                document.getElementById("LeftTwoTabBtn"+indexKey).className    = "tabV";
                document.getElementById("LeftTwoTabRight"+indexKey).src        = "/images/common/tabBottom.gif";
            }

            selectKey = lpad(selectKey, 2, "0");

            document.getElementById("LeftTwoTabLeft"+selectKey).src            = "/images/common/tabTop_over.gif";
            document.getElementById("LeftTwoTabBtn"+selectKey).background      = "/images/common/tabMiddle_over.gif";
            document.getElementById("LeftTwoTabBtn"+selectKey).className       = "tabV_over";
            document.getElementById("LeftTwoTabRight"+selectKey).src           = "/images/common/tabBottom_over.gif";
        }

		function fnc_LeftFlow(paramOne, paramTwo){
			TabEvent(paramOne);
			fnc_ClickBtn(paramTwo);
		}
		function fnc_LeftTwoFlow(paramOne, paramTwo){
			TabEvent(paramOne);
			fnc_ClickBtnTwo(paramTwo);
		}
        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }
//-->
</SCRIPT>
</HEAD>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onLoad="TabEvent(5)" >
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="23"><img src="/images/common/barHead.gif" width="23"
					height="25"></td>
				<td valign="top" background="/images/common/barGreenBg.gif"
					class="barTitle">�������������ȳ�</td>
				<td align="right" class="navigator">HOME/���꼼��/��������/<font
					color="#000000">�������������ȳ�</font></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>

	<!-- Ÿ��Ʋ �� ���̺� �� -->
<TABLE cellSpacing=0 cellPadding=0 width=800 border=0>
	<tr>
		<td>
		  ��� �ٷ��ڴ� �������� �ȳ����� �ݵ�� �����ϰ� �ش�Ǵ� �ҵ���� ���� ���� üũ�� �� <br>
		  �׿� �ʿ��� ���� �ҵ���� �� ���������� �����Ͽ��� �մϴ�.<BR><BR>
          <FONT color=#ff0000>* �ξ簡�� �� �Ƿ��, ������ ���� ���� ���� �׸��� ���� ��쿡�� 
          <U>"�Ű�" ����(���)�� �����ϼž� �մϴ�.</U>
          </FONT>		
		</td>
	</tr>
</table>


<!-- �� ��� ���۳�Ʈ ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="left">

            <!-- �ǹ�ư���̺� ���� -->
            <table border="0" cellspacing="0" cellpadding="0">

                <tr>
                    <td width="120">
                        <!-- �ǿ��� -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft06"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(5)" style="cursor:hand" id="TabBtn06">����������</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight06"></td>
                            </tr>
                        </table>
                    </td>

                    <td>
                        <!-- ������ -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft08"></td>
                                <td align="center" class="hiddenMenu25" onclick="fnc_LeftFlow(7,1)" style="cursor:hand" id="TabBtn08">�ҵ����</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight08"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                
                    

                
                         <!-- ������ -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft09"></td>
                                <td align="center" class="hiddenMenu25" onclick="fnc_LeftTwoFlow(8,1)" style="cursor:hand" id="TabBtn09">���װ���</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight09"></td>
                            </tr>
                        </table>
                    </td>
                    
                </tr>
                <tr>                    
                    
                    <td>
                        <!-- ������ -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft010"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(9)" style="cursor:hand" id="TabBtn010">������������</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight010"></td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <!-- ������ -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft02"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(1)" style="cursor:hand" id="TabBtn02">���⼭�� ���ʿ�</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight02"></td>
                            </tr>
                        </table>
                    </td>            
                
                    <td width="150">
                        <!-- �ǿ��� -->
                        <table width="250" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tab25Left.gif" width="6" height="25" id="TabLeft01"></td>
                                <td align="center" class="overMenu25" onclick="TabEvent(0)" style="cursor:hand" id="TabBtn01">�ҵ�ݾ׿��</td>
                                <td width="6"><img src="/images/common/tab25Right.gif" width="7" height="25" id="TabRight01"></td>
                            </tr>
                        </table>
                    </td>

                    <td>
                        <!-- ������ 
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft03"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(2)" style="cursor:hand" id="TabBtn03">����ũ</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight03"></td>
                            </tr>
                        </table>
                    </td>
                    
                    <td>
                         
                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft07"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(6)" style="cursor:hand" id="TabBtn07">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012.hwp&FILE_URL=<%=fileDownLoadPath%>/2012.hwp"  target=_blank>
								������ �������
								</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight07"></td>
                            </tr>
                        </table>
                    </td>       
                    
                    <td>

                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft04"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(3)" style="cursor:hand" id="TabBtn04">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012 ox quiz.pdf&FILE_URL=<%=fileDownLoadPath%>/2012 ox quiz.pdf"  target=_blank>OX���� ����</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight04"></td>
                            </tr>
                        </table>
                    </td>
                    <td>

                        <table width="150" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="6"><img src="/images/common/tabGray25Left.gif" width="6" height="25" id="TabLeft05"></td>
                                <td align="center" class="hiddenMenu25" onclick="TabEvent(4)" style="cursor:hand" id="TabBtn05">
								<A  href="/common/downloadFile.jsp?FILE_NAME=2012 ox result.pdf&FILE_URL=<%=fileDownLoadPath%>/2012 ox result.pdf"  target=_blank>
								OX���� ����
								</a>
								</td>
                                <td width="6"><img src="/images/common/tabGray25Right.gif" width="7" height="25" id="TabRight05"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
				-->


            </table>
        </td>
    </tr>
</table>

<hr width="760" size="5" align="left" color="#97C821">

<!-- ��1 ���� �Է� ���̺� ���� -->
<div class=page id="tabYACA001_01" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="4" height="30"><b><font color="#FF3300">�� ���� �ҵ�ݾ� 100���� ����
						�ҵ�ݾ� ��ǿ� ���Ͽ�</font></b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><b>1.�ҵ�ݾ� 100������ �߿伺</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>��</td>
					<td>�ҵ�ݾ��� ����</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>���� �ҵ�ݾ��̶� ����(�ٷΡ���������ڡ����ҵ� ��)���������絵 ���� �հ�����ν�,
						�Ѽ��� �ݾ��� �ƴ϶� <u>�ʿ��� ������ ���� �ݾ��� ����.</u><br>
						�̶�, �Ѽ��Աݾ׿��� ������ҵ� �� �и�������� �ҵ�ݾ��� ������. </td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>��</td>
					<td>�ҵ�ݾ� 100������ �ʰ��ϸ� �������� �ʴ� �׸�</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><font color="#3333FF">����ڰ���, ������/��ӡ������ڸ��� �⺻����, ��������, ���������, �ſ�ī�����, ������/��ӡ������ڸ��� ȥ�Ρ���ʺ��</font></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="3"><b>2. �����, �θ��, �ڳ�, �����ڸ��� ��ǥ���� ������ �ҵ�ݾ� 100����</b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">��</td>
					<td>2�� �̻��� �����ҵ��� ������ �ҵ�ݾ��� �ջ��Ͽ� 100���� �ʰ����θ� �����.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">��</td>
					<td>���� �� ����ڳ� ����ڵ� ���(���)�� ���� ������ �������� 100���� �ʰ����θ� �����.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td valign="top">��</td>
					<td>�ҵ��� ������ �𸣸� ������ �����ϴ� ȸ�翡 �����ϴ� ���� ������, 4�� ������ ���Ե� ��쿡�� �ٷ���,
						������ �ȵ� ��쿡�� ����� �Ǵ� ��Ÿ�ҵ����� ���ɼ��� ����.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>1) <font color="#3333FF">�ٷμҵ���</font> : �� �����޿� - �ٷμҵ���� = 100����<br>
						<font color="#FF0000">&nbsp;&nbsp;&nbsp;&nbsp;�� �� �����޿��� �ִ� 500���� �����̸�
						���� ��û ������</font><br>
						2) <font color="#3333FF">�����, �������� ���� �뿪 �����</font> <br>
						&nbsp;&nbsp;&nbsp;&nbsp;: �� ���Աݾ� - �ʿ���(������ �ܼ������ ���� �ݾ�) = 100����<br>
						3) <font color="#3333FF">�����ҵ���</font> <br>
					&nbsp;&nbsp;&nbsp;&nbsp;: �ʿ��� �������� ���� ������ �Ѿ��� �ҵ�ݾ����� ����.<br>
						4) <font color="#3333FF">���ݼҵ���</font> <br>
					&nbsp;&nbsp;&nbsp;&nbsp;: ������������ ��� 2001.12.31 ���� ������ �������� �޴� ������ ������ҵ��̹Ƿ� �θ�Կ���<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��Ȱ�� �����ְ� �ִٸ� ���������� ������. </td>
				</tr>
			</table>

</div>
<!-- ��1 ���� �Է� ���̺� �� -->
<div class=page id="tabYACA001_02" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="3" height="30"><b><font color="#FF0000">�� ���������� ������ �ʿ䰡
						���� ���</font></b></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">1. </td>
					<td>�ڵ������� ������ �ϳ��� 100������ �Ѵ´ٸ� ������ ������ �� �ٸ� ���强���� �������� �����ص� �߰��� ���� �� ��. (���强���� �����ѵ�: 100����)
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">�� �¹��̺κ�
									����ũ: </font></td>
								<td><font color="#FF0000">������ �� 100������ �Ѵ� ���ź��迡 ������ ��쿡�� �ڵ��������� �Ƴ� ���Ƿ� �����Ͽ� �Ƴ��� �ҵ���� ��û�ϴ� ���� ������ </font></td>
							</tr>
						</table>
						</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">2.</td>
					<td>�Ƿ�񿵼����� �հ谡 �� �����޿��� 3% ���϶�� �������� ������ �ʿ����.<br>
						���� ��� ������ 3,000�����̰� �Ƿ�� ������� 90���� �����̸� �������� �����ص� ���� �� ��.<br>
						(�Ƿ�� �����ѵ��� �� �����޿��� 3%��)</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">3.</td>
					<td>�ſ�ī�� ���ݾ�(���ݿ����� ���ݾ� ����)�� �� �����޿��� 25% ���϶�� ���ݾ�Ȯ�μ��� ������ �ʿ����.<br>
						���� ��� ������ 3,000�����̰� �ſ�ī����ݾ��� 450���� �����̸� Ȯ�μ��� �����ص� ���� �� ��.<br>
					(�ſ�ī����� �����ѵ��� �� �����޿��� 25%��)<br>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">�� �¹��̺κ� ����ũ: </font></td>
								<td><font color="#FF0000">�Ƴ��� �ſ�ī�� ������ ������ 25% ���Ϸ� ����Ǹ� �Ƴ��� ����ī�带 ����ϴ� ���� ������.</font></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">4.</td>
					<td>�ٷ��� ������ ������α�(������ü ��) �ְ� �ѵ��� �� �����޿����� <font color="#0033CC">�ٷμҵ������</font>��
						������ �ݾ��� 10%��.<br>
						���� ��� ������ 3,000�����̸� 17,750,000���� 10%�� 1,775,000���� �Ѵ� ��α� �������� �����ص�
						1,775,000���� ������.
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top"><font color="#0033CC">�� </font></td>
								<td><font color="#0033CC">�ٷμҵ������ : 12,250,000 = 1,000���� + (���� 1500���� �ʰ��� �� 15%)</font></td>
							</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="130"><font color="#FF0000">�� �¹��̺κμ���ũ: </font></td>
								<td><font color="#FF0000">������ ��α� �ѵ��� �ʰ��Ǹ� �ʰ��п� ���� �Ƴ� ���Ƿ� ����Ͽ� �Ƴ��� �ҵ���� ��û�ϴ°��� ������.</font></td>
							</tr>
						</table>

					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td valign="top">5.</td>
					<td> ����ᡤ�Ƿ�񡤱����������ڱݡ�ȥ�Ρ��̻硤��ʡ��ſ�ī�� ������ �ٷ����� �Ⱓ�� ����� �ݾ׸� �����ǹǷ� �Ի� ���� �����
						�������� ������ �ʿ����.</td>
				</tr>
			</table>
</div>

<div class=page id="tabYACA001_03" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="750" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td height="30"><b><font color="#FF0000">�� �¹��� �κ� ����ũ</font></b></td>
				</tr>
				<tr>
					<td>1. ����ڰ����� ����� <font color="#0033CC">������ �ҵ�ݾ� 100���� ���ϡ�</font> ������ Ȯ���� ������.</td>
				</tr>
				<tr>
					<td>2. <u><b>���� �ҵ�ݾ� 100���� �ʰ��ϴ� �����</b></u>�� ���õ� ���� �ҵ���� ���� ����</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;�� ������� �������� �Ұ�����</font></td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;�� ������� ���强 �����</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ������̰� �Ǻ����ڰ� ������� ��쿡�� ����, �Ƴ� ��� �ҵ���� �Ұ�����.</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;�� ������� �Ƿ��</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ƿ��� ������� �ҵ�� ���ɿ� ������� �Ƿ�� ������ �ٷ��ڰ� ������ ���� �� ����.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ٸ�, �Ƿ������� �Ƿ�� ���� ������ ����� �������� �� �����Ƿ� �ſ�ī��(���ݿ����� ����)��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ƿ�� �����Ͽ��ٸ� ī������ڰ� �����ؾ� ��.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�׸��� �Ƿ������� �� �����޿��� 3%�� �ʰ� ����ؾ� �����ǹǷ� �Ƿ�������� ���� ��쿡�� ���κ���<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ���� ������ʿ��� �����ϴ� ���� ������ ��쵵 ���� �� �����Ƿ� ����</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;�� ������� ������</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������� �ҵ����ѿ���� �����Ƿ� ������� ������� �ҵ���� �Ұ�����</td>
				</tr>
				<tr>
					<td><font color="#0033CC">&nbsp;&nbsp;&nbsp;&nbsp;�� ������� �ſ�ī��</font></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ſ�ī��(���ݿ����� ����)�� �ҵ����ѿ���� �����Ƿ� �� ������ ���Ƽ� ���� ���� �� ����, ����ī���<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ������ �ƴ϶� ����� �����̹Ƿ� ���� ���� ���� �� ����. ���� ���������� ���� ����� ����<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ī�带 �ַ� ����ϴ� ���� ������.</td>
				</tr>
				<tr>
					<td>3. <u><b>���� �ҵ�ݾ��� 100���� ������ �����</b></u>�� ���õ� ���� �ҵ���� ���� ����</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<font color="#0033CC">������� �������� �� ���强 �����, �Ƿ��, ������, �ſ�ī��(���ݿ����� ����) �ҵ������ ������.</font></td>
				</tr>
				<tr>
					<td>4. �θ��, ���Ρ����, (��)���θ��� �ſ�ī��(���ݿ����� ����) ���ݾ�</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;���ɿ� ������� �ҵ��� ���� ���踦 ���� �ϴ� ���������� ����� �ݾ��� ���������� ���������ڷ� ��û�� <br>
						&nbsp;&nbsp;&nbsp;&nbsp;����ڰ� �ҵ������ �ؾ� ��.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;���� ���, ������� ������ �θ�� ���������� �ߴٸ� �ٷ����� �Ƴ��� ī������� ���� �� ����.<br><br></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b><font color="#FF0000">�� �ּ����� �ٸ� �����ڸ��� ���л��� �ִ� ��� ����ũ</font></b></td>
				</tr>
				<tr>
					<td valign="top">
					���� �����ϸ鼭 ���л��� �����ڸ�(���� �ҵ�ݾ��� 100���� ������ ����, ó��, ó��, �õ���, ����, ����)��
						��ϱ��� �ٷ��� ������ �������� ��쿡�� ������ ������ �����ѵ�, �� �� ������ ���������� 12.31�� �����̹Ƿ�
						12.31�� ������ �����ڸ��� �ֹε���� �ű�� ���� ������. </td>
				</tr>
				<tr>
					<td valign="top"><font color="#0033CC">- ��� 1 : �ֹε���� ���� �Ǿ� �ִ� ó���� ���е�ϱݿ� ���� ������ ������ �ް��� �ϴ� ��� ���� ���� ����</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �ٷ����� �ֹε�������� ���������� ���踦 ���� �ؾ� �ϹǷ� 12.31�� ������ �ּ����� �ű��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���� ������.<br>
						<font color="#0033CC">- ��� 2 : ���� ��ϱ��� ���ְ� �ִ� ����(���л�)�� ���� �����ϴٰ� ������ ������п� ������ �Ŀ� ��������<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�б� ��ó�� ���� �ű� ��� ���� ���� ����</font><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �ٷ��� �Ǵ� ���Ű����� ����, ������ ���, �ٹ���(�����) �������� �ּҸ� �Ͻ� ����� ��쿡��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>���Ͻ���Ż�Ȳǥ(���� ���� ����)���� ����</u>�ϸ� ���踦 ���� �ϴ� ������ �����Ͽ� ���� ������.</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td><b><font color="#FF0000">�� ����ڿ� ������ �ڳడ �ؿ� ���� ���� ��� ����ũ</font></b></td>
				</tr>
				<tr>
					<td valign="top"> �ڳ� ���к� ���� ����� ��Ģ������ <u>���б��� �������� ����</u>��
						�� �ں������� ���� �л��̾�� ��. <br>
						�׷��� ���ܷ� �������̳� ������������������κ��� ���� ������ ���� ��ġ����, �ʡ��ߵ��л��̶�� ���к� ���� ������.</td>
				</tr>
				<tr>
					<td valign="top"><font color="#0033CC"> ���� �����: �� ��ü�ɰ迭 ���л����� �б����� ��õ�� ���� ��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �ڿ�����, ���, ����, ü�� �о��� ��Ư���á������á����� �Ը� �̻� ��ȸ���� �Ի��Ͽ�<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���������ڿ��� ����� ������ ��<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �ܱ� ���ΰ� ������ ����� ������ ���л��� Ư������ ����� ��</font><br><br></td>
				</tr>
			</table>
</div>



<!-- ���װ��� -->
<div class=page id="tabYACA001_04" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- ������������ -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- OX���� ���� -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<!-- OX���� ���� -->
<div class=page id="tabYACA001_05" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>


<div class=page id="tabYACA001_06" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
      <table width="597" border="0" cellspacing="0" cellpadding="0"  bgcolor="#F5FAFE">
        <tr>
          <td colspan="5" height="1">&nbsp;</td>
        </tr>
        <tr>
          <td width="15" height="20">&nbsp;</td>
          <td  width="189" valign="top">
            <table width="189" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� �� ��<br>
                          (�޿��Ѿ�+���Ѿ�)</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a
                        href="javascript:onClick=fnc_LeftFlow(7,1);">�ٷμҵ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32" valign="top">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�ٷμҵ�ݾ�</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,2);">�� �� �� ��</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>���ݺ�������</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">Ư�� �ҵ� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,6);">��Ÿ �ҵ� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� ǥ ��</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( X )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� �� ��</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� �� ��</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,1);">���װ��� �� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� �� ��</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( - )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>�� �� �� �� ��</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20" align="center"><b>( = )</b></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 bgcolor=#FDD18F
                  border=0 width="189" height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#ffedd2>
                        <div align=center><b>���� �Ǵ� ȯ�޼���</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="189"><img src="/images/common/arrow.gif" width="189" height="708"> </td>
          <td  valign="top">
            <table width="189" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b>�������޿�<br>
                          (�ѱ޿���-������ҵ�)</b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,2);">�� �� �� ��<br>
                          (����,�����,�ξ簡��)</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,3);">�� �� �� ��<br>
                          (��ο��,�����,�γ���...)</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,4);">���ڳ� �߰�����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="20">&nbsp;</td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">����� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">�Ƿ�� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">������ ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">�����ڱ� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,5);">��α� ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
					<br>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,6);">���ο����������</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,7);">�ſ�ī�����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
			  <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,8);">�ұ�����һ���� �����α�</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
			  <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,9);">����ֽ����ݵ�ҵ����</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,10);">�����������ڰ���</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,11);">�츮���������⿬�ݰ���</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div align=center><b><a href="javascript:onClick=fnc_LeftFlow(7,12);">���ø�������ҵ���� </a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2">&nbsp;</td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div   align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,1);">�ٷμҵ漼�װ���</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div
                    align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,2);">�����ڱ����ڼ��װ���</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="2"></td>
              </tr>
              <tr bgcolor="#F5FAFE">
                <td width="189" height="32">
                  <table cellspacing=1 cellpadding=0 width="189" bgcolor=#F4D5A6
                  border=0 height="32">
                    <tbody>
                    <tr>
                      <td bgcolor=#fff8ee>
                        <div   align=center><b><a href="javascript:onClick=fnc_LeftTwoFlow(8,4);">��ġ�ڱݼ��װ���</a></b></div>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </td>
              </tr>

            </table>
          </td>
          <td width="15">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="5" height="15">&nbsp;</td>
        </tr>
      </table>
</div>
<!-- ���� ������� -->
<div class=page id="tabYACA001_07" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
</div>
<!-- �ҵ���� -->
<div class=page id="tabYACA001_08" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab���̺���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn01" onclick="fnc_ClickBtn(1)" style="cursor:hand;">
						�ٷμҵ����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn02" onclick="fnc_ClickBtn(2)" style="cursor:hand;">
						�⺻����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn03" onclick="fnc_ClickBtn(3)" style="cursor:hand;">
						�߰�����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn04" onclick="fnc_ClickBtn(4)" style="cursor:hand;">
						���ڳ��߰�����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft05"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn05" onclick="fnc_ClickBtn(5)" style="cursor:hand;">
						Ư������
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight05"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft06"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn06" onclick="fnc_ClickBtn(6)" style="cursor:hand;">
						�����������
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight06"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft07"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn07" onclick="fnc_ClickBtn(7)" style="cursor:hand;">
						�ſ�ī�������
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight07"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft08"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn08" onclick="fnc_ClickBtn(8)" style="cursor:hand;">
						�ұ����<br>�һ���ΰ���
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight08"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft09"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn09" onclick="fnc_ClickBtn(9)" style="cursor:hand;">
						����ֽ����ݵ�<br>�ҵ����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight09"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft10"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn10" onclick="fnc_ClickBtn(10)" style="cursor:hand;">
						�������ռҵ����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight10"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft11"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn11" onclick="fnc_ClickBtn(11)" style="cursor:hand;">
						�츮���������⿬��
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight11"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTabLeft12"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTabBtn12" onclick="fnc_ClickBtn(12)" style="cursor:hand;">
						���ø���<br>����ҵ����
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTabRight12"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>

		<!-- ������ Tab ������ �κ� -->
		<td>
		<td valign="top"><!-- Layer �� --> <!--���� ������ ���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- �ּ� ���̰� 350�� �Ǿ���մϴ�.���� �������ʿ� �����ϴ�. ������ ���� �ֱ� ������ -->
				<td height="360" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- �ٷμҵ�������� -->
				<div id="layer_1" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
        <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;1. �ٷμҵ����</b></font><font face="�޸հ����׷���" size="4" color="#333333"><b>
        <br>
        </b></font><font face="�޸հ����׷���" color="#333333"><b><font face="����"><br>
        </font></b></font><font color="#333333" face="����"> &nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">��
        �ٷμҵ������ ��� �ٷ��ڿ��� ����Ǹ� �����޿��׿� ����������� �޶����ϴ�<b>.&nbsp;</b></font></font><font face="�޸հ����׷���" size="2" color="#333333"><b><br>
        </b></font>
        <table width="603" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="264">
              <div align="center"><font color="#333333" face="����">�� &nbsp;&nbsp;��
                &nbsp;&nbsp;��</font> </div>
            </td>
            <td width="326" bgcolor="#FFF8EE">
              <div align="center"><font color="#333333" face="����">�� &nbsp;�� &nbsp;�� &nbsp;��</font>
              </div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">500��������</font>
              </div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">�ѱ޿��� X 80%</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">500���� ~ 1,500��������</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">400���� + (500����
                �ʰ����� 50%</font><font face="����">) </font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">1,500���� ~ 3,000��������</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">900���� + (1,500����
                �ʰ����� 15%)</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">3,000���� ~ 4,500��������</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font color="#333333" face="����">1,125���� + (3,000����
                �ʰ����� 10%)</font></div>
            </td>
          </tr>
          <tr>
            <td width="264" bgcolor="#FFFFFF">
              <div align="center"><font face="����">4,500���� �ʰ�</font></div>
            </td>
            <td width="326" bgcolor="#FFFFFF">
              <div align="center"><font face="����">1,275���� + (4,500���� �ʰ����� 5%)</font></div>
            </td>
          </tr>
        </table>
        <br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#666666">
          <tr>
            <td height="44" width="606" bgcolor="#FFF8EE"><font color="#000000" face="����"><font color="#333333"><a name="#4"><b>�ٷμҵ���
              ����</b></a>�� ?<br>
              <br>
              &nbsp;&nbsp;&nbsp;�Ʒ��� ���׿� �ش�Ǵ� ���ݾ��� �ջ��� �ݾ��� <b>���� �� �޿���</b>�� �˴ϴ�)
              </font></font></td>
          </tr>
          <tr>
            <td height="664" width="606" bgcolor="#FFF8EE"> <font color="#333333" face="����">&nbsp;<br>
              &nbsp;1) &nbsp;�ٷ��� �������� ���Ͽ� ���� ����, �޷�, ����, �ӱ�, ��, ���� ��<br>
              <br>
              &nbsp;&nbsp;2) &nbsp;�׿��� ó�п� ���� ��<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;(������ȸ �����ȸ �Ǵ� �̿� ���ϴ� �ǰ�����
              ���ǿ� ���Ͽ� �󿩷� �޴�&nbsp;�ݾ�)<br>
              <br>
              &nbsp;&nbsp;3) &nbsp;�ٷμ���, ��������, ���ü���, ��������, �ⳳ����, �������� ��Ÿ �̿� ������
              ������ �޿�<br>
              <br>
              &nbsp;&nbsp;4) &nbsp;�ټӼ���, �����ް���, ����������, �¹�����, �������� ���������, ���ټ���
              ��<br>
              <br>
              &nbsp;&nbsp;5) &nbsp;����, ����ȸ�� �Ǵ� ��������� ���ٻ������ �����ϴ� ���ݼ���� ���谡������
              ����,<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���ǸŸ��� ���� �Ǵ� ������ �������� ���� �밡,
              ��Ÿ �̿� ������ ������ �޿�<br>
              <br>
              &nbsp;&nbsp;6) &nbsp;�ð��� �ٹ�����, ��ټ���, ���ټ���, Ư�����α� ��Ÿ �̿� ������ ������ �޿�<br>
              <br>
              &nbsp;&nbsp;7) &nbsp;����ٱ���� ������� �����ϴ� ������, ü�´ܷú� ������� �����ϴ� �ݾ�<br>
              <br>
              </font> <font color="#333333" face="����">&nbsp;&nbsp;8) &nbsp;�ٷα��ع�
              ��45���� ���� �޾�����<br>
              <br>
              &nbsp;&nbsp;9) &nbsp;��������, �ؿܱٹ����� ��Ÿ �̿� ������ ������ �޿�<br>
              <br>
              &nbsp;10) ��к�, �ǰ���, ������ ��Ÿ �̿� ������ ������� ������ �����μ� ������ ���Ͽ� ���� ����<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;�и����� �ƴ��� �޿�<br>
              <br>
              &nbsp;11) ���������� �����ϴ� ���α�, ���α�, �������ϱ�, ���ڱ�, ���б� ��Ÿ �̿� ������ ������ �޿�<br>
              <br>
              &nbsp;12) ���б� �������� �ڳడ ���� �������� ������ǿ� ���Ͽ� ���б��κ��� �޴� ���б�,�к����<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;���� �������� �ٷμҵ濡 �ش��մϴ�.<br>
              <br>
              &nbsp;13) �������� �������� �ڳడ ����ڷκ��� �޴� ���ڱ�, ���б��� �����մϴ�.<br>
              <br>
              &nbsp;14) �ٷ��ڰ� �⺻�޿� �̿ܿ� ������ġ �Ǵ� �ǸŽ��� � ���� ����ڷκ��� �߰��� &nbsp;����&nbsp;�޴�<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;����, ����� ���� �ٷμҵ濡 �ش��մϴ�.<br>
              <br>
              &nbsp;15) ������ ������� ���޵Ǵ� ���� �Ǵ� ������ �޿�<br>
              <br>
              &nbsp;16) �������� ���Ͽ� �޴� �ҵ����μ� ���� �ҵ濡 ������ �ƴ��ϴ� �������α�, �������αݱ�Ÿ<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;�̿� ������ ������ �޿�<br>
              <br>
              &nbsp;17) �����������ޱ����� ���� �����ϴ��� �������� Ư���� ���ο� ���Ѵ밡�� �����ϴ�&nbsp;�ݾ���<br>
              &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;�ٷμҵ濡 �ش��մϴ�.<br>
              <br>
              &nbsp;18) �ް��� ��Ÿ �̿� ������ ������ �޿�<br>
              <br>
              &nbsp;19) �ٷμҵ濡 �ش��ϴ� �޿��� ������ ���޹޴� ��쿡�� �� ���޴���� �ð��� ���մϴ�.<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �縳�б� �������� �ڳ࿡ ���� ��ϱ�
              ������<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �ٷ��ڰ� �δ��Ͽ��� �� �ҵ漼 ����
              ����ڰ� �δ��� ��� �� �ҵ漼��<br>
              &nbsp;&nbsp;&nbsp;&nbsp;</font> <font color="#333333" face="����">&nbsp;&nbsp;-
              ������ �Ǵ� �⿬���� �ӿ�(������� �� ��ܵ�Ϲ����� �Ҿ������� �ӿ� ����)�� ������ ����<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �������ν� ���
              ����<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �������� ���������̰ų� ������ �Ǵ�
              �� �����, ��Ÿ�� ������ ��������ڷ��ϴº���<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ǵ� ��Ź�� �����Ͽ�
              ����Ḧ ����ڰ� �δ��ϴ°�<br>
              <br>
              &nbsp;20) �������� �� �������� �����Ǵ� �ݰ��� ������� ȸ��δ���� �ٷμҵ濡 �ش�<br>
              <br>
              &nbsp;21) ������ �⿬���� �츮�������տ��� �������� �ڻ���<br>
              <br>
              &nbsp;22) ��뺸���ݿ��� ���޹޴� ������������ �� �������ް��޿� (���������� �����󿩶� �����)<br>
              </font></td>
          </tr>
        </table>
				</div>
				<div id="layer_2" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        &nbsp; <font size="2" color="#333333"><b>2. �⺻���� (����, �ҵ����� ����)</b></font><font face="�޸հ����׷���" size="4" color="#333333"><b><br>
        </b></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="83">
              <div align="center"><font face="����">�⺻��������</font></div>
            </td>
            <td colspan="2" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="93">
              <div align="center"><font face="����">�����ݾ�</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� ��</font></div>
            </td>
            <td colspan="2"><font face="����">��� �ٷ��� <br>
              </font></td>
            <td width="93">
              <div align="center"><font face="����">150����</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="����"> ����ڰ���</font></div>
            </td>
            <td colspan="2"><font face="����"> �ҵ�ݾ��� ���ų� �ڻ�ҵ�(�ٷ�,����,����,���,��Ÿ�ҵ� ��)��<br>
              ������ ���� �ҵ�ݾ��� �հ���� 100���� ������ ��<br>
              </font></td>
            <td width="93">
              <div align="center"><font face="����"> 150����</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td rowspan="6" width="83" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�ξ簡�� </font></div>
            </td>
            <td colspan="2"><font face="����">������(����� ����)�� �ξ簡��(���� ���� ���ϻ���)���μ�<br>
              ���� �ҵ�ݾ��� �հ���� 100���� ������ ��<br>
              </font></td>
            <td rowspan="6" width="93">
              <div align="center"><font face="����">150���� </font></div>
              <p align="center"><font face="����">(1�δ�)<br>
                </font></p>
            </td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="����">�ڳ�<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="����">�� 20�� ����(1993.1.1
              ���� ���)<br>
              ���ؿ����߿� �� 20���� �����ϴ��� ����������</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="����">�θ�<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="����">��.�� ���: �� 60�� �̻�(1953.12.31 ���� ���) </font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="����">�����ڸ�<br>
                </font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="����">�� 20������(1993.1.1
              ���� ���) �Ǵ� <br>
              ��/�� : �� 60�� �̻� (1953.12.31 �������)</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="����">���ú�ȣ<br>
                �����</font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="����">��Ȱ��ȣ������� ��6�� ��1ȣ
              �ش� �� : �������� ����</font></td>
          </tr>
          <tr>
            <td width="65" bgcolor="#FFFFFF">
              <div align="center"><font face="����">�����</font></div>
            </td>
            <td width="359" bgcolor="#FFFFFF"><font face="����">�������� ����</font></td>
          </tr>
        </table>
		 <div align="left">&nbsp;&nbsp;<br>
          <font color="#FF6600" face="����">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">��
          �������� (2008.1.1 ����) - ������� �������� ����� ����� ���� ���</font></font><font color="#EA5200" face="����"></font><br>
          </div>
          <div align="left">&nbsp;&nbsp;<br>
          <font color="#FF6600" face="����">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#EA5200">��
          �����Ҵ� - ����, �ҵ� �������ǿ� �ش���� �ʴ���</font></font><font color="#EA5200" face="����"><br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          �����ڸ��� �����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          ���� ����, ���, �̸�, ����, �ܻ���, ��ī, ����� ��<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
          �ֹε��ǥ�� �񵿰Ű���(��, ������ �ξ��� �ϰ� ������ �ְ� ����� ������ ��� ������������ ÷��)</font><br>
          </div>
				</div>
				<div id="layer_3" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="����">3. �߰�����(<font color="#EA5200">�켱
        �⺻����</font></font></b></font><font face="����" size="2" color="#EA5200"><b>
        ��� �ش�Ǿ�� ��<font color="#333333">)</font></b></font><font face="�޸հ����׷���" size="4" color="#333333"><b><br>
        </b></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="80">
              <div align="center"><font face="����">�߰���������</font></div>
            </td>
            <td width="408" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="86">
              <div align="center"><font face="����">�����ݾ�</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="����">��ο����� </font></div>
            </td>
            <td width="408"><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� (����� ����) ��
              <br><br>&nbsp;&nbsp;&nbsp; �� �� 70�� �̻�(1943.12.31 ���� ���)<br>&nbsp;
              </font></td>
            <td width="86" valign="top">
              <div align="center"><font face="����">
              	<br>100����
              	<br>(1�δ�)
              	</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="����">����ڰ��� </font></div>
            </td>
            <td width="408"><font face="����">�ٷ��� ���� �Ǵ� ���踦 �����ϴ� �ξ簡�� �� ����ڰ� �ִ�
              ���<br>
              <br>
              (������� ����) <br>
              - �ɽŻ���ڿ� ������ü�� <br>
              - ���������� ���� � ���� ������ ���� ������ <br>
              - û������ڿ� �ð������ <br>
              - �����Ƿ����(1979.8.29 ����ɷ� ��9588ȣ) ��ǥ1�� ������ ���̱���<br>
              &nbsp;&nbsp;&nbsp;���̱���ǥ�� 1�� ���� 3�޿� ���ϴ� �����ڿ� ���� ������ ��ü��ְ�<br>
              &nbsp;&nbsp;&nbsp;�ִ� �� <br>
              - ������ ���Ͽ� ���� ġ�Ḧ ���ϴ� �ڰ� �� ġ��Ⱓ�� 1�� �̻�<br>
              &nbsp;&nbsp;&nbsp;���ӵ� ���� ����ǰ� ���ġ��Ⱓ ���ȿ��� ���С������ ����� ���¿�<br>
              &nbsp;&nbsp;&nbsp;�ִ� ��(���� ��, ���� �ź�����ȯ�� ��)
              <br>&nbsp;&nbsp;&nbsp;�� �Ƿ��� ������ "���������" ÷��
              </font></td>
            <td  valign="middle" align="center">
              200����<br>(1�δ�)
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�γ��ڰ��� </font></div>
            </td>
            <td width="408"><font face="����"> ����ڰ� ���� �����ٷ��ڷμ� ���� ���� �⺻���� ��� �ξ簡���� �ִ� <br>
							�������̰ų�, ����ڰ� �ִ� �����ٷ����� ���(���� �ҵ� ���� ����)<br>
              </font></td>
            <td width="86">
              <div align="center"><font face="����">50���� <br>
                <br>
                </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�ڳ�������� <br>
                </font></div>
            </td>
            <td width="408" bgcolor="#FFFFFF"><font face="����">��6�� ������ �������� �ִ� ��� <br>��6�� ������ ��Ź�Ƶ��� �ִ� ��� <br>
              (2006. 1. 1 ���� ����ڳ�) <br>
              </font></td>
            <td width="86">
              <div align="center"><font face="����">100����<br>
                (1�δ�) <br>
                </font></div>
            </td>
          </tr>
		   <tr bgcolor="#FFFFFF">
            <td width="80" bgcolor="#FFF8EE">
              <div align="center"><font face="����">��ꡤ�Ծ����<br>
                </font></div>
            </td>
            <td width="408" bgcolor="#FFFFFF"><font face="����">2012�� �� ��ꡤ�Ծ��� ���
              </font></td>
            <td width="86">
              <div align="center"><font face="����">200����<br>
                (1�δ�) <br>
                </font></div>
            </td>
          </tr>
        </table>
				</div>
				<div id="layer_4" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;4. ���ڳ� �߰�����</b></font><font face="�޸հ����׷���" size="4" color="#333333"><b><br>
        <br>
        <font size="2">&nbsp;&nbsp;&nbsp;<font face="����" color="#EA5200">�� �⺻����
        �����</font></font></b><font size="2" face="����" color="#EA5200">(�ҵ��� ���� �� 20�� ������)
        �� �ش��ϴ� �ڳడ 2�� �̻��� ��쿡 �߰����� �����</font><font size="2">
        </font></font><font face="�޸հ����׷���" size="4" color="fuchsia"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�⺻���� ��� �ڳ��</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="����">���� �ݾ�</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="����">2��</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="����">�� 100����</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="303" bgcolor="#FFF8EE">
              <div align="center"><font face="����">3�� �̻�</font></div>
            </td>
            <td width="316">
              <div align="center"><font face="����">�� 100���� + (�ڳ�� - 2��) X 200����</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="2">
              <div align="left"><font face="����">�� ����</font></div>
              <p align="left"><font face="����">&nbsp;�� �¹��� �κΰ� 2���� 20�� �̸��� �ڳ࿡ ���� ���� 1�� �⺻������ ���� ��� ���ڳ� �߰� ������ ����<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ����<br>
			  </font><font face="����">&nbsp;�� 23���� �ڳడ ������� ��쿡�� ����� �ڳฦ �⺻ ���� ����ڷ� ��û�� ��� ���ڳ� �߰� ���� ���
			  <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ڳ࿡ �ش���</font></p>
              </td>
          </tr>
        </table>
				</div>
				<div id="layer_5" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">

        <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b><font face="����">&nbsp;5. Ư������</font></b></font><font face="�޸հ����׷���" size="4" color="#333333"><b><br>
        <br>
        </b>
		<font size="2" face="�޸հ����׷���" color="#0000FF">&nbsp;&nbsp;&nbsp;��
		�ٷ������Ⱓ ���ȿ� ������ ����� ���� �ִ� ��쿡 �����մϴ�.(��α� ����)</font><br>

		<font size="2">&nbsp;&nbsp;&nbsp;</font></font><font face="�޸հ����׷���" color="#333333"><font face="����" color="#EA5200">��
        �⺻���������(����,�����,�ξ簡��)�� ���� ���(�����,�Ƿ��,������)�� �����ϰų�, ������<br>
        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;������ ��α�,�����ڱ���
        �ִ� ��� �ҵ�ݾ׿��� ������� �����ѱݾ��� ������ �ִ� ���Դϴ�.</font></font>
        <div align="left"><font face="����" color="#EA5200">&nbsp;&nbsp;&nbsp;&nbsp;��
		ǥ�ذ��� = Ư��������û�� ���� �ʾҰų� �Ǵ� ��û������ �հ���� 100���� �̸��� ������ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������������
          ǥ�ذ��� 100���� ����</font><font size="2"><br>
          <br>
          </font><b><font face="����">&nbsp;&nbsp;
          <a name="a12_5_1">
          5.1 ��������</a></font></b>
          : <b><font face="����">��뺸���+�ǷẸ���+��������纸���+��Ÿ���强�����+���ο���</font></b>
          <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <b><font color="EA5200"> (���� ����� ����, �ҵ� ���� ����)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="115">
                <div align="center"><font face="����">�� ��</font></div>
              </td>
              <td width="360">
                <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
              </td>
              <td width="109">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
            </tr>
			<tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="����">���װ�������� </font></div>
              </td>
              <td width="360"><font face="����">�޿����� ¡���� �ǰ�����,��뺸���,��������纸��� <br>
                </font></td>
              <td width="109">
                <div align="center"><font face="����">�� �� </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="����">��������뺸�强<br>
                  ����� </font></div>
              </td>
              <td width="360"><font face="����">����ο� ���Ͽ� ����(�Ǻ����ڰ� ������� ���)<br>
			  �� ����� �������� �� <b><u>"����� ���� ���� ���� �հ��"</u></b>
			  <br>&nbsp;&nbsp;&nbsp;&nbsp;���� ǥ�õ� �ݾ�<br>
                </font></td>
              <td width="109">
                <div align="center"><font face="����">100���� �ѵ�</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="����">�Ϲݺ��强����� </font></div>
              </td>
              <td width="360"><font face="����">���� �� ���������� ������, ���غ���, �ڵ�������,<br>
                ȭ��/���� ��Ÿ�� ���ظ� �㺸�ϴ� ���� ����<br>
                <br>
                �� ����ᳳ�������� <b><u>"���强 ���� �����հ��"</u></b> ���� ǥ��
				<br>&nbsp;&nbsp;&nbsp;&nbsp;�� �ݾ�<br>
                ��<b><u> �������ڿ� �Ǻ�����</u></b>�� �⺻������ �޴� �����, �ξ簡��
				<br>&nbsp;&nbsp;&nbsp;&nbsp;�� ���</font></td>
              <td width="109">
                <div align="center"><font face="����">100���� �ѵ� </font></div>
              </td>
            </tr>
          </table>
					<br>
          &nbsp;&nbsp;&nbsp;&nbsp;<font color="#7800BF" face="����">&nbsp;�� �����
          ���� ���强 ���������� �Ϲ� ���强 ���������� ���ÿ� �ش�Ǵ� ��쿡�� ���� �ϳ��� ����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ͽ��� ��.</font><br>
          <br>
          <br>
          <b><font face="����">&nbsp;&nbsp;
          <a name="a12_5_2">
          5.2 �Ƿ�����</a></font></b>
          <b><font color="EA5200"> (���� ����� ����, �ҵ� ���� ����)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td colspan="2">
                <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
              </td>
              <td width="132">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
              <td width="227">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td colspan="2" bgcolor="#FFF8EE"><font face="����">���� �� �⺻��������ڸ�
                ���� ������<br>
                �Ƿ��� �ѱ޿����� 3%�� �ʰ��ϴ� �ݾ� <br>
                </font></td>
              <td width="132">
                <div align="center"><font face="����">700����<br>
                  �ѵ�</font></div>
              </td>
              <td width="227"><font face="����">����, �����, ��ο������ �Ƿ��� 500������
                �ʰ��Ͽ� �������� ���� �ݾװ� ���Ͽ�
                ���� �ݾ��� �߰��� ���� </font></td>
            </tr>
          </table>
					<br>
          &nbsp;&nbsp;<font color="#7800BF" face="����">&nbsp;&nbsp;�� �Ƿ�� ����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ���������ᡤ���������� ���� �Ƿ��� �����<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ġ�ᡤ����� ���� �Ǿ�ǰ(�Ѿ�)���Ժ�<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ����� ���屸 ���ԡ��������<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �ǻ� ���� ó�濡 ���� �Ƿ��� ���ԡ����� ���<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� �÷º����� �Ȱ桤����Ʈ���� ���Ժ�(�⺻���� ����� 1�δ� 50���� �ѵ�)<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ��û�� ���Ժ�<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� ��������纸��� ��40�� ��1�׿� ���� ���� ������ �����Ϻκδ��</font><br><br>
          &nbsp;&nbsp;<font color="#7800BF" face="����">&nbsp;&nbsp;�� ��ǥ���� �����Ҵ�<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �ٸ� ������ �⺻���� ����ڿ� ���� �Ƿ��,���踦 ���� ���� �ʴ� �������ӿ� ���� �Ƿ��<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �Ƿ����� �ƴ� ������������, ����� ��Ȱġ�� �缳�п���, ����ȯ�� �̼۾�ü ������ �̿��,<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���� ���� �Ƿ��, �系 �ٷ� ������� ���� �Ƿ�� ��</font><br>
          <br>
          <br>
          <b><font face="����">&nbsp;&nbsp;
          <a name="a12_5_3">
          5.3 ���������</a></font></b>
          <b><font color="EA5200"> (���� ����� �ҵ� ���� ����)</font></b>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td colspan="2">
                <div align="center"><font face="����">�� �� �� �� �� �� ��</font></div>
              </td>
              <td width="292">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
              <td width="120">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td colspan="2" bgcolor="#FFF8EE">
                <div align="center"><font face="����">�� �� </font></div>
              </td>
              <td width="292"><font face="����">������ ��,��,��,����,���п��� ������<br>
                </font></td>
              <td width="120">
                <div align="center"><font face="����">�� �� �� �� </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="52" rowspan="3" bgcolor="#FFF8EE">
                <div align="center"><font face="����">����� </font>
                  <p><font face="����">�ξ�</font></p>
                  <p><font face="����">���� <br>
                    </font></p>
                </div>
              </td>
              <td bgcolor="#FFF8EE" width="115">
                <div align="center"><font face="����">��ġ����,������,<br>
                  �������Ƶ� </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="����">��,��,�縳��ġ���� ������,
                �������Ƶ�(��6���̸�)<br>
                ������� �� �п�������� ������ �ݾ�<br>
				(2007����� ü���ü� �̿�� ����)
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="����">1�δ� <br>
                  300���� </font></div>
              </td>
            </tr>
            <tr>
              <td width="115" bgcolor="#FFF8EE">
                <div align="center"><font face="����">��,��,����б� </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="����">�⺻���� ����ڷ� ��,��,
                ���� ������, �޽ĺ�, <br>��� �� �б�������, ������ ���Ժ�<br>
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="����">1�δ�<br>
                  300���� </font></div>
              </td>
            </tr>
            <tr>
              <td bgcolor="#FFF8EE" width="115">
                <div align="center"><font face="����">���л� </font></div>
              </td>
              <td width="292" bgcolor="#FFFFFF"><font face="����">�⺻���� ����ڷ� ������
                ������<br>
                </font></td>
              <td width="120" bgcolor="#FFFFFF">
                <div align="center"><font face="����">1�δ� <br>
                  900���� </font></div>
              </td>
            </tr>
			<tr>
				<td bgcolor="#FFF8EE" colspan="2"><div align="center">���� ������</div>
				</td>
				<td bgcolor="#FFFFFF" colspan="2">�� ���� �ٹ��� = ���ܿ��� �Բ� �����ϴ� �ڿ� ���� ������<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�����ơ������� �Ƶ� ������� ����)<br>
				�� ���� �ٹ��� = �ں����� �ڰ���(���б� ���� �̻���)������Ư��������<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�ξ��ǹ��ڿ� ���ܿ��� 1���̻� ������ ��)�� ���� ������

				</td>
			</tr>
          </table>
					<br>
          &nbsp;&nbsp;<font color="#7800BF" face="����">&nbsp;&nbsp;�� ����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-����� Ư�������� 1�δ� ���װ���<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-���̹����� ����</font><br><br>
          &nbsp;&nbsp;<font color="#7800BF" face="����">&nbsp;&nbsp;�� ��ǥ���� �����Ҵ�<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ���������� ������, �ҵ�ݾ� 100���� �ʰ����� ������, �ٸ� ������ �⺻ ���� ������� �ڿ� ���� ������ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ��, ��, ��, ���л��� �缳�п� ������ <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �ܺ� ���翡 ���� �Ǳ� ������, ���� �����ü����п� �� ü���ü� �̿�� ��<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �б� ����
          �̿��, �ڳ� ���п� ������, ������, �������� ������ å�� ��<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ���� �н���(����, ������,
          ����� ��), ������ ��<br>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ���б�</font><br>
          <br>
          &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;�п� ����&gt;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- '�п��� ����, ��� ���� ����'�� ����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �̼�, ����, ����,
          �ٵ�, ����, ����, ���� �� ���Ƹ� ������� �ϴ� �п�</font><br>
          <br>
		  &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;ü���ü� ����&gt;<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 'ü���ü��� ��ġ���̿뿡 ���� ����'�� ���� ü������(�������塤������ �� ����)�������� ��</font><br>

          <br>
		  &nbsp;&nbsp;&nbsp;<font color="#9900FF">&nbsp;&nbsp;&lt;������ ������&gt;<br>

          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �ٷκ����⺻���� ���� �系�ٷκ���������κ��� ���� ���б� �� <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ���� ���� �б��κ��� ���� ���б� �� <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �ٷ����� �л��� �������κ��� ���� ���б� �� <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ���ܱٹ����������� ���޵Ǵ� �ڳ� � ���� ���б� �� <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- �׹ۿ� ���� ��ü�κ��� ���� ���б� ��</font><br><br>

          <b><font face="����">&nbsp;&nbsp;
          <a name="a12_5_4">
          5.4 ��αݰ���</a></font></b><font face="����">
          :<b> ������α�+Ư�ʱ�α�+������α����޾�<br>
          &nbsp;&nbsp;&nbsp;</b><font color="#EA5200">&nbsp;�� �ٷμҵ��� ����,�����,�����Ӹ� ���� ����</font></font><br>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="110">
                <div align="center"><font face="����">�� ��</font></div>
              </td>
              <td width="354">
                <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
              </td>
              <td width="120">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">����<br>
                  ��α� </font></div>
              </td>
              <td width="354"><font face="����">- ���� �Ǵ� ������ġ��ü�� ����� ��ǰ ��<br>
                - ���� �Ǵ� �Ǻ�� �̿��Ҽ� �ִ� ��ȸ�����ü��� ����� ��ǰ<br>
                - �ҿ��̿����� �Ῥ����� ���Ͽ� ����� ��ǰ<br>
                - �縳�б�, ��ɴ���,�������б� ����,������б� ������<br>
                &nbsp;&nbsp; ����� �ü���,������ �Ǵ� ������(�縳�б�-���б� ����)<br>
                - ��ȸ�������� ���ȸ�� ������ ��α� <br>
                - Ư������(�糭)������ �ڿ����� �뿪
                <br>- <u>10���� �ʰ��� ���װ���</u>)
                </font></td>
              <td width="120">
                <div align="center"><font face="����">�� �� </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">������α� </font></div>
              </td>
              <td width="354"><font face="����">��ȸ��������, �б�, �м�������ü, ���д�ü, ��ȭ������ü,<br>
                �ֹ� ��û�� ��ϵ� ������ü, ���������ڻ�, �ҿ��̿�����,<br>
                �뵿���պ�, ������üȸ��� <br>
                </font></td>
              <td width="120">
                <div align="center"><font face="����">*�ѵ���<br>
				1. ������ü��α��� �ִ� ���<br>
				�ѵ���=�ҵ�ݾ�x10%+Min[�ҵ�ݾ�x10%, ������ü �� ������α�]<br>
				2. ������ü��α��� ���� ���<br>
				�ѵ���=�ҵ�ݾ�x20%<br><br>
				*������=Min[������α� �ش��, �ѵ���]</font></div>
              </td>
            </tr>
          </table>
					<br>
          <font color="#7800BF" face="����">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��
          ����� ����, �ݾ�, ����, ������, ������ ����� ��Ϲ�ȣ, ������ ����� ���� ����</font><br>
          <font face="����"><br>
          <br>
          <b>&nbsp;&nbsp;
          <a name="a12_5_5">
          5.5 �����ڱݰ���</a></b><br>
          &nbsp;&nbsp;&nbsp;<font color="#EA5200">&nbsp;�� �ٷμҵ��� ���θ��Ǹ� ���� ����<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(���κ� ����/������ ��ǰ������ �پ��ϱ� ������
          �Ʒ� ���� �̿��� �ҵ���� ��� ���δ� ���� ���࿡ Ȯ�� �ٶ�)<br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#7800BF">�� "���ؽð� 3��� ����" ������ 2006.1.1 ���� ���డ���ڿ�
          �����ڸ� �ش��.</font></font>
          <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
            <tr bgcolor="#FFF8EE">
              <td width="110">
                <div align="center"><font face="����">�� ��</font></div>
              </td>
              <td width="358">
                <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
              </td>
              <td width="116">
                <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">������</font></div>
              </td>
              <td width="358"><font face="����">1. 12.31. ���� ������ �������� �ƴ��� ������ ������ ������ �� ��<br>
					2. �ش� �����Ⱓ�� �ѱ޿� ���� 5,000�� �������� ����� ��<br>
					3. ����� �Ǵ� �⺻������� �ξ簡���� �ִ� ����� ��<br>
					4. �������ñԸ��� ������ �����ϱ� ���� ���� ��<br>
					5. ������ ����� ��� �����ϴ� �������� ��<br>
					&nbsp;&nbsp;- ������ �ܿ� ������ ���� ������ ��� �Ӵ������������<br>&nbsp;&nbsp;&nbsp;&nbsp;Ȯ�����ڸ� ���� ��<br>
					&nbsp;&nbsp;- �Ӵ������������ �ּ����� �ֹε�� ��� �ּ����� ���� ��
              </font></td>
              <td rowspan="3" width="116">
                <div align="center"><font face="����">������������<br>
                �ڱ� �ҵ������<br><br>
				= (�����������Ա�<br>������ ��ȯ��<br>&nbsp;+ ������)x40%<br><br>
				(300���� �ѵ�)
                  <br>
                  </font>

                </div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">��ξ� ���� �濵���� �ƴ��ϴ� �����ڷκ��� ������ �������� ������ ��ȯ�� </font></div>
              </td>
              <td width="358"><font face="����">1. �����Ⱓ ������ ���� ������ �������� �ƴ��� ������ ������ ������ �� ��<br>
				2. ������ �������ñԸ��� ������ �����ϱ� ���� ���� ��<br>
				3. �ش� �����Ⱓ�� �ѱ޿����� 5,000�� �������� ������μ� ����ڳ� �⺻������� �ξ簡���� �ִ� ����� ��ξ����ǵ�Ϲױ����̿��ں�ȣ�����ѹ��� ��2���� ���� ��ξ� ���� �濵���� �ƴ��ϴ� �����ڷκ��� ������ ���������ڱ��� ��
</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">�����������Ա� <br>
                  �����ݻ�ȯ�� <br>
                  ����</font></div>
              </td>
              <td width="358"><font face="����">���� ���� �������̰� ���������� �ٷ��� ������ ���ؽð� <br>
                3�� ���� �������ñԸ��� ������ �����ϱ� ���� <u>���ø��������<br>
                �����Ͽ�</u> ������������ ������ ���Ա��� ������ ��ȯ��<br>
                <font color="#EA5200">(������ û��αݰ� ������ ���Ա��� ���� ���� �� ����)<br>�� 2008.1.1 ���Ŀ��� ��������</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="110" bgcolor="#FFF8EE">
                <div align="center"><font face="����">��������������Ա� ���ڻ�ȯ�� ����</font></div>
              </td>
              <td width="358"><font face="����">1. �����Ⱓ ������ ���� ������ ������ ������ �Ǵ� ������ ������� �ٷ���(�Ͽ�ٷ��� ����) <br>
2. ���뱸������ ������ ������ �����Ͽ� ������ �ش���� ���� �� <br>
-�����Ⱓ ������ ���� 2���� �̻��� �����ϴ� ��� <br>
-�ش� �����Ⱓ�� 2���� �̻��� �����ϴ� ��� <br>
3. 1., 2. �� ������ ������ ���� �������ñԸ��� �������μ� ����� ���ؽð��� 3�� �� ������ ������ ����ϱ� ���Ͽ� ����ȸ�� �� �Ǵ� �������ñ�����κ��� ������ ������ ����� ��� �����ϴ� ��������������Ա� �� ��
-���Ա��� ��ȯ�Ⱓ�� 15�� �̻��� �� <br>
-���ü������������ �Ǵ� ��������Ϻ��� 3�� �̳��� ������ ��������������Ա��� �� <br>
-��������������Ա��� ä���ڰ� �ش� ������� ������ ������ ������ �� ��
</font></td>
              <td align=center> �����ڱ� ������=
Min(��������������Ա����ڻ�ȯ��+Min(���ø�������ҵ������+�����������Ա� ���� ������),300�� ��),1,000����(600 or 1,500����))

              </td>
            </tr>
          </table>
		  </div>

				</div>
				<div id="layer_6" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;6. ���ο��� �������</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font face="Geneva, Arial, Helvetica, san-serif" color="#EA5200"><br>
        </font></font></b><font size="2" face="Geneva, Arial, Helvetica, san-serif" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="Geneva, Arial, Helvetica, san-serif" color="#EA5200">��
        �ٷμҵ��� ���θ��Ƿ� ������ ��쿡�� ������ �����մϴ�.</font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="198" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="146">
              <div align="center"><font face="����">��������</font></div>
            </td>
            <td width="130" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� ��</font></div>
            </td>
            <td width="105">
              <div align="center"><font face="����">�� �� �� ��</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="198" bgcolor="#FFF8EE" rowspan="2">
              <div align="left"><font face="����">- ��20�� �̻� ������ <br>
                - �ſ�100���������� ���Ծ�<br>
                - ����Ⱓ10���̻�<br>
                &nbsp;&nbsp;( �� 55�����ĺ��� 5���̻�<br>
                &nbsp;&nbsp;&nbsp; �������·� ���޹޴�����)</font></div>
            </td>
            <td height="19" width="146" bgcolor="#FFF8EE">
              <div align="center"><font face="����">2000.12.31���� ������</font></div>
            </td>
            <td width="130" height="19">
              <div align="center"><font face="����">�������Ծ���40%</font></div>
            </td>
            <td height="19" width="105">
              <div align="center"><font face="����">72�����ѵ� </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="146" bgcolor="#FFF8EE" height="15">
              <div align="center"><font face="����">2001.01.01���� ������</font></div>
            </td>
            <td width="130" height="15">
              <div align="center"><font face="����">�������Ծ� ����<br>(�������ݺ����<br>����)</font></div>
            </td>
            <td height="15" width="105">
              <div align="center"><font face="����">400�����ѵ�</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td colspan="4"><font face="����" color="#EA5200">�� ���强 ������ ���������� ����������
              ���� ��Ÿ���� �����ؼ� ������ �ּ���.</font></td>
          </tr>
        </table>
				<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


				</div>
				<div id="layer_7" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;7. �ſ�ī�� ������</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="����">��
        </font></font><font face="����" color="#EA5200">�ٷμҵ��� �Ǵ� ���ҵ� 100���� ������ �����, �ξ簡���� ����12�������ؿ��� 11������ �����<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ݾ��� ���� �ѱ޿�����
        20���� �ʰ��ϴ� ��� �� �ʰ��ݾ��� 20���� �����ϴ� ���Դϴ�.</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="181" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td bgcolor="#FFF8EE" width="80">
              <div align="center"><font face="����">�� ��</font></div>
              </td>
            <td width="520">
              <div align="center"><font face="����">�� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td bgcolor="#FFF8EE">
	              <div align="center"><font face="����">���Ⱓ</font></div>
	            </td>
              <td><font face="����">���س⵵ 1��1��~���س⵵ 12��31�ϱ��� ���� </font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
	  					<td bgcolor="#FFF8EE">
	              <div align="center"><font face="����">�ҵ������<br> ��� </font></div>
	            </td>
	  					<td bgcolor="#FFFFFF">
								1. [�ſ�ī��/���ݿ����� �ѻ��ݾ� - (�ѱ޿��� X 25%)] X 20%<br>
								2. [����(üũ)ī��/����ī��  �ѻ��ݾ� - (�ѱ޿��� X 25%)] X 30%<br>
								3. [������� �ѻ��ݾ� - (�ѱ޿��� X 25%)] X 30% (����� ���۸����� ����)
	            </td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="����">�����ѵ�</font></div>
              </td>
              <td><font face="����">300������ �ѱ޿��� 20% �� ���� �ݾ�<br>
								���������� : �߰� 100����
              </font></td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="����">�������ݾ� </font></div>
              </td>
              <td>����,�����,�ξ簡���� ����� �ݾ�(����) <br>
                - �ſ�ī��, ����ī��, ��ȭ��ī�� ��<br>
                - ���γ��� �п� ������<br>
                - ���ݿ����� ���ݾ�
							</td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="����">�������ܾ� </font></div>
              </td>
              <td>
				- ����� �� ȸ�� �������<br>
                - ���������(���ݺ����,�ǷẸ���), ����������(������,���б�,�������)<br>
                - ����,���漼,�����,������ �� <br>
                - ���� ��� �ݾ�<br>
                - �����ڸ��� ���ݾ�<br>
                - �ּ����� �ٸ� 20�� �ʰ� �ڳ��� ���ݾ� ��
								</td>
            </tr>
            <tr bgcolor="#FFFFFF">

            <td bgcolor="#FFF8EE">
              <div align="center"><font face="����">���⼭�� </font></div>
              </td>
              <td ><font face="����">�ſ�ī��ҵ������û��,�ſ�ī����ݾ�Ȯ�μ�, ���ݿ����� ���ݾ� Ȯ�μ� </font></td>
             </tr>
          </table>
					<br>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <font color="#7800BF" face="����">�� ���ݿ����� ���ݾ� Ȯ�μ���<br>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����û ���ݿ����� Ȩ������(<a href="http://www.taxsave.go.kr" target="_blank">www.taxsave.go.kr</a>)���� ȸ������ �� ������ ���� �߱� ����.</font>
				</div>
				<div id="layer_8" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;8. �ұ�����һ���ΰ���</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="����">��
        </font></font><font face="����" color="#EA5200">�ٷ��� ������ �Ի� �� �Ǵ� ������ �ұ��,�һ���� ������ �����Ͽ� 2012�� 12�� 31�ϱ��� �����ϴ�<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����α� ����(�� 300���� �ѵ�)</font><br>
				</div>
				<div id="layer_9" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;9. ��� �ֽ��� �ݵ� �ҵ����</b></font><font size="4" color="#333333"><b><font size="2"><br>
        <font color="#EA5200"><br>
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="����">��
        </font></font><font face="����" color="#EA5200">2008�� 10�� 20�� ���� ����ֽ��� �ݵ�(������)�� ������ ��� �Ǵ� �̹� ������ �ݵ��� ��������� 3���̻�<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����ϰ� ��������� ������ ��� ����</font><br><br>
		<font color="#EA5200">
        </font></font></b><font size="2" color="#EA5200">&nbsp;&nbsp;</font></font><font color="#EA5200"><font face="����">��
        </font></font><font face="����" color="#EA5200">�б⺰ 300���� �ѵ�, �� 1200���� �ѵ�<br><br>&nbsp;&nbsp;&nbsp;��
        							2010.1.1.���� �����ڴ� �ҵ���� ��� ����</font>
				</div>
				<div id="layer_10" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="����">10. �������ռҵ����</font></b></font><br>
        <br>
        <font size="4" color="#333333"><font size="2">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="����" color="#EA5200">&nbsp;��
        </font></font><font face="����" color="#EA5200">�ٷμҵ��� ���� ���Ǹ� ����</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="324" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="261">
              <div align="center"><font face="����">�� �� �� ��</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td width="324"><font face="����">- �����ڰ� â���������� �Ǵ� �ű������������տ� <br>
              &nbsp;&nbsp; �����ϴ� ��� <br>
              <br>
              - ��ó����������ڽ�Ź�� �������ǿ� �����ϴ� ��� <br>
              <br>
              - "��ó��������� ���� Ư����ġ��"�� ���� ��������<br>
              &nbsp;&nbsp;������ �����ڷκ��� ���ڹ��� �ݾ��� ��ó�����<br>
              &nbsp;&nbsp;�����ϴ� ��� <br>
              <br>
              - "��ó��������� ���� Ư����ġ��"�� ���Ͽ� ��ó�����<br>
              &nbsp;&nbsp; �����ϴ� ��� <br>
              </font></td>
            <td width="261" valign="top"><br><br><br>
			- 2012.1.1 ���� ����(���ھ�) X 10%<br>
			&nbsp;&nbsp;&nbsp;2012.1.1 ���� ����(���ھ�) X 20%<br><br>
             - �ٷμҵ�ݾ� X 40% �ѵ�<br></font></td>
          </tr>
        </table>
				</div>
				<div id="layer_11" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="����">11. �츮�������� �⿬�� �ҵ����</font></b></font><br>
        <br>
        <font size="4" color="#333333"><font size="2">&nbsp;&nbsp;&nbsp;</font></font><font color="#333333"><font face="����" color="#EA5200">&nbsp;��
        </font></font><font face="����" color="#EA5200">�ٷμҵ��� ���� ���Ǹ� ����</font><br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="324" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="261">
              <div align="center"><font face="����">�� �� �� ��</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td>
              �ٷ��� ���� �⺻���� ���� �츮�������տ��� �ڻ��ָ�
              <br>����ϱ� ���Ͽ� �츮�������տ� �⿬�ϴ� ���
            </td>
            <td align="center">
              ���� �⵵�� �⿬�ݾ�
              <br>(400���� �ѵ�)
            </td>
          </tr>
        </table>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <font color="#7800BF" face="����">
        �� �ҵ���� ������ ���� �ݾ׿� ���Ͽ� ���� ���� ����� �ٷμҵ� ������. (�����̿�)</font>
				</div>
				<div id="layer_12" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;<font face="����">12. ���ø�������ҵ���� </font></b></font><br>
        <br>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="385" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�� �� �� �� �� ��</font></div>
            </td>
            <td width="200">
              <div align="center"><font face="����">�� �� �� ��</font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td>
              ���ø�������* ���Ծ��� 40% ����
              <br>- ������ ������ ������
              <br>-�������ñԸ��� ����(���Դ�� ���ؽð� 3�� �� ����)�� �� ä��<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ������ ������(2009.12.31. ���� ���Ը� �ش�)
              <br>* ���ø�������
              <br>�����ù��� ���� û������(�� ���Ծ� 10�� �� ����)
              <br>��������ø�������(2009.12.31.���� ����)
              <br>������û����������(�� ���Ծ� 10�� �� ����)
            </td>
            <td align="center">
              <br>�� 300���� �ѵ�
            </td>
          </tr>
        </table>

				</div>
				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--���� ������ �� --> <!-- Layer �� -->
		</td>
	</tr>
</table>
</div>
<!-- ���װ��� -->
<div class=page id="tabYACA001_09" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="130" valign="top" style="padding:7 0 0 0"><!--tab���̺���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft01"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn01" onclick="fnc_ClickBtnTwo(1)" style="cursor:hand;">
						�ٷμҵ漼�װ���
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight01"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft02"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn02" onclick="fnc_ClickBtnTwo(2)" style="cursor:hand;">
						�����ڱ�<br>���ڼ��װ���
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight02"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft03"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn03" onclick="fnc_ClickBtnTwo(3)" style="cursor:hand;">
						�ܱ����μ��װ���
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight03"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td style="padding:0 0 3 0"><!--tab over -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="/images/common/tabTop.gif" width="130" height="5" id="LeftTwoTabLeft04"></td>
					</tr>
					<tr>
						<td height="20" background="/images/common/tabMiddle.gif" class="tabV" id="LeftTwoTabBtn04" onclick="fnc_ClickBtnTwo(4)" style="cursor:hand;">
						��ġ�ڱݼ��װ���
						</td>
					</tr>
					<tr>
						<td><img src="/images/common/tabBottom.gif" width="130"	height="5" id="LeftTwoTabRight04"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>

		<!-- ������ Tab ������ �κ� -->
		<td>
		<td valign="top"><!-- Layer �� --> <!--���� ������ ���� -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5" height="5"><img
					src="/images/common/arcGray01.gif" width="5" height="5"></td>
				<td background="/images/common/arcGray02.gif"></td>
				<td width="5" background="/images/common/arcGray03.gif"></td>
			</tr>
			<tr>
				<td width="5" background="/images/common/arcGray04.gif"></td>
				<!-- �ּ� ���̰� 350�� �Ǿ���մϴ�.���� �������ʿ� �����ϴ�. ������ ���� �ֱ� ������ -->
				<td height="360" valign="top" bgcolor="#FFFFFF" style="padding:15">


				<!-- �ٷμҵ�������� -->
				<div id="layerTwo_1" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;1. �ٷμҵ漼�װ���</b></font><font face="�޸հ����׷���" size="4" color="#333333"></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font><font color="#333333" size="2"> </font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="124" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="162">
              <div align="center"><font face="����">��������� </font></div>
            </td>
            <td width="324">
              <div align="center"><font face="����">���� ��� </font></div>
            </td>
            <td width="98">
              <div align="center"><font face="����">���� �ѵ� </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td height="78" width="162" bgcolor="#FFF8EE">
              <div align="center"><font face="����">�ٷμҵ��� �ִ� ��� �ٷ��� </font></div>
            </td>
            <td height="78" width="324"><font face="����">�ٷμҵ濡 ���� ���⼼����<br>
              <br>
              �� 50�������� : ���⼼�� �� 55% <br>
              <br>
              �� 50�����ʰ�: 275,000 + (50���� �ʰ��ݾ� �� 30%) </font></td>
            <td height="78" width="98">
              <div align="center"><font face="����">50����</font></div>
            </td>
          </tr>
        </table>
				</div>


				<div id="layerTwo_2" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b><font size="2" color="#333333"><b>&nbsp;2.
        �����ڱ� ���Ա� ���� ���װ���</b></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><br>
        </font></font></b><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><font color="#FF6600"><br>
        </font></font></font><font size="4" color="#FF6600"><font size="3"><font size="2">&nbsp;&nbsp;&nbsp;</font></font></font></font><font color="#333333"><font color="#FF6600"><font face="����">&nbsp;<font color="#EA5200">
        ��  1998.12.28 �������� ������ ������ �����Ǿ� 1999.1.1���� ������ ��� ��������� �ƴ�</font></font></font></font><font size="2" color="#333333"><b><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><br>
        </font></font> </b></font>
        <table width="600" border="0" cellspacing="1" cellpadding="2" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="473">
              <div align="center"><font face="����">�� �� �� �� (�� �� �� ������ �������) </font></div>
              </td>

            <td width="116">
              <div align="center"><font face="����">�� �� �� </font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="473">
                <div align="left"><font face="����">�� �ٷμҵ��� ������ ������ �Ǵ� 1���ø��� �����ϴ�
                  �������ϰ� </font></div>
                <p align="left"><font face="����"> �� 1995.11.1~ 1997. 12. 31 �Ⱓ �� "��������������� �� 67���� 2�� ����"�� ����
                	<br>&nbsp;&nbsp;&nbsp;&nbsp;�̺о������� ���
                  <br>&nbsp;&nbsp;&nbsp;&nbsp;�� �������ñԸ� ������ �������μ�&nbsp; ����Ư���� ���� ������
                  �����ϴ� �� ���<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;�� 1995.10.31�� ���� �á�������û���� �̺о��������� Ȯ���� ��<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;�� 1997.12.31���� �ŸŰ���� ü���ϰ� ������ ������ ��� ����<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;�� ���ðǼ����ڷ� ���� ���ʷ� �о���� �������μ� ���� ������ �ϰ��� �� �ٸ�<br>
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ڰ� ������ ����� ���� ������ ��<br>
                  </font></p>
                <p align="left"><font face="����"> �� ���� ������ ���� �����Ͽ� 1995.11.1����
                  ������ ���Աݿ� ���� ���� ��ȯ���� �� </font></p>
              </td>
              <td width="116">
                <div align="center"><font face="����">���ڻ�ȯ���� 30% </font></div>
              </td>
            </tr>
          </table>
				</div>


				<div id="layerTwo_3" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;3. �ܱ����� ���װ���</b></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="255">
              <div align="center"><font face="����">�� �� �� ��</font></div>
              </td>

            <td width="183">
              <div align="center"><font face="����">�� �� ��</font></div>
              </td>

            <td width="171">
              <div align="center"><font face="����">�� �� �� �� ��</font></div>
              </td>
            </tr>
            <tr bgcolor="#FFFFFF">
              <td width="255">
                <div align="left"><font face="����">���ܿ��� �ٷθ� �����ϰ� ���� ���ܱٷ�<br>
                  �ҵ濡 ���Ͽ� �ܱ����� �����Ͽ��ų�<br>
                  ������ �ҵ漼���� �ִ� ��� ���� </font></div>
              </td>
              <td width="183">
                <div align="center"><font face="����">�ܱ����� �����Ͽ��ų�<br>
                  ������ ���� </font></div>
              </td>
              <td width="171">
                <div align="center"><font face="����">�ٷμҵ� ���⼼��<br>
                  ��<br>
                  ���ܱٷμҵ�<br>
                  ��<br>
                  �ٷμҵ�ݾ� </font></div>
              </td>
            </tr>
          </table>
				</div>
				<div id="layerTwo_4" style="position:absolute; visibility:hidden; display:none; display:none; width:620px; z-index:1;">
          <hr style="color:#333333;" align="left" noshade width="480" size="1">
        <font size="2" color="#333333"><b>&nbsp;4. ��ġ�ڱݼ��װ���</b></font><font face="�޸հ����׷���" size="4" color="#333333"></font><font
 face="�޸հ����׷���" size="4" color="fuchsia"><font size="3"><br>
        <br>
        </font></font><font color="#333333" size="2"> </font>
				<font color="#EA5200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				��  �ٷμҵ��� ���θ��Ǹ� ���� ����<br></font>
        <table width="600" border="0" cellspacing="1" cellpadding="3" height="124" bordercolor="#666666" bgcolor="#666666" align="center">
          <tr bgcolor="#FFF8EE">
            <td width="162">
              <div align="center"><font face="����">��������� </font></div>
            </td>
            <td width="324">
              <div align="center"><font face="����">���� ��� </font></div>
            </td>
            <td width="98">
              <div align="center"><font face="����">���� �ѵ� </font></div>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td height="78" width="162" bgcolor="#FFF8EE">
              <div align="center"><font face="����">����(�Ŀ�ȸ ��
              ���Ű�������ȸ ����)��
              ��ġ�ڱ��� ����� �ٷ���</font></div>
            </td>
            <td height="78" width="324">
							<u>10�������� ���װ���</u> + 10���� �ʰ��� �ҵ����<br><br>
							<font color="#0000FF">* ��α� X 100 / 110</font><br><br>
							��) 10���� ���<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ҵ漼 90,909 + �ֹμ� 9,091 = 100,000 ����
            </td>
            <td height="78" width="98">
              <div align="center"><font face="����">10����<br>(�ֹμ� ����)</font></div>
            </td>
          </tr>
        </table>
				</div>

				</td>
				<td width="5" background="/images/common/arcGray05.gif"></td>
			</tr>
			<tr>
				<td height="5" background="/images/common/arcGray06.gif"></td>
				<td background="/images/common/arcGray07.gif"></td>
				<td background="/images/common/arcGray08.gif"></td>
			</tr>
		</table>
		<!--���� ������ �� --> <!-- Layer �� -->
		</td>
	</tr>
</table>
</div>
<div class=page id="tabYACA001_10" style="position:absolute; left:20; top:515; width:800; height:300; z-index:3;" >
			<table width="710" border="0" cellspacing="1" cellpadding="4">
				<tr>
					<td colspan="3" height="30"><b><font color="#0033CC">�� �������� ���� �ȳ�</font></b></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">1. ���������� �߻��Ⱓ</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>�� <u>�Ϲ� ������: ���� 1��~12��</u>  �� �ű� �Ի���: �Ի� ��~12��  �� �ؿܹ���(���ܼҵ���) ���� ������: ���� ��~12��<br>
						<font color="#FF6600">����) �ſ�ī�� ���ݾ� Ȯ�μ�, �Ƿ�� �������� : ���� 1.1 ~ ���� 12.31<br>
						</font>
					</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">2. ��� ���������� ����������(Fax, Mail, ���ͳݹ߱�
						�Ұ�)���� ��Ģ�̳�, �Ʒ� �������� ���ͳ� �߱��� �����˴ϴ�.</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>�� �ֹε�ϵ���ܱ��ε�ϻ������  �� ����ᳳ������  �� �����ڱ� ���� ����/��ȯ ���� <br>
						�� (����)�������� ��������  �� �ſ�ī�� �� ���ݿ����� ���ݾ� Ȯ�μ��� ��αݳ�������</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><font color="#0033CC">3. �ٷ��� ���� ���Ƿ� �߱޵Ǿ�� �����Ǵ� ��������</font></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>�� �ҵ���� : �����ڱ�, ���ο���, ��������, ������������, �츮����<br>
						�� ���װ��� : �����ڱ���������, �����ġ�ڱ�</td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"> <font color="#FF0000">4. ����û Ȩ�������� <a href="http://www.yesone.go.kr" target="_blank">(http://www.yesone.go.kr)</a> �̿��ϴ� ��� �ݵ�� <b><u>"�ҵ���� ���� ����ǥ �� �� ���� �׸� �󼼳�����"</u></b> �� �Բ� ���� �ٶ��ϴ�.</font></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"> <font color="#0033CC">5. �Ű��� �Է��׸� ������� ���������� �����Ͽ� �ֽð�,
						A5 ũ�⺸�� ���� �������� �нǹ����� ���Ͽ� A4 �̸����� <br>
						&nbsp;&nbsp;&nbsp;&nbsp;�����Ͽ� ���� �ٶ��ϴ�.</font></td>
				</tr>
			</table>
			<br>
			<table border="0" cellspacing="1" cellpadding="2" bgcolor="#999999" width="715">
				<tr align="center">
					<td colspan="2" height="20" bgcolor="F8F3DC"><b>����</b></td>
					<td bgcolor="F8F3DC" width="165"><b>������</b></td>
					<td bgcolor="F8F3DC"><b>����� �� �������</b></td>
					<td bgcolor="F8F3DC" width="140"><b>�߱�ó</b></td>
				</tr>
				<tr>
					<td colspan="2" align="center" height="20" bgcolor="F8F3DC">����</td>
					<td bgcolor="#FFFFFF">�ҵ�����Ű�</td>
					<td bgcolor="#FFFFFF">�� ����</td>
					<td bgcolor="#FFFFFF">- ������ �ۼ�</td>
				</tr>
				<tr>
					<td colspan="2" align="center" bgcolor="F8F3DC">�ٹ�������</td>
					<td valign="top" bgcolor="#FFFFFF">
					��(��) �ٹ���<br>
						�ٷμҵ��õ¡�������� ��<br>
						�ٷμҵ��õ¡����</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>���س⵵ �ߵ��Ի���(����Ի�) �� �׷�� ������</td>
							</tr>
							<tr>
								<td>-</td>
								<td>�ϻ���� �̻� ���� �Ի���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><font color="#0033CC">
						* ������ ����� �ػ��� �ٹ��� ����(����)�� �� ����
									<br>
									�ش�ȵ�.</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- ��(��) �ٹ�ȸ��</td>
				</tr>
				<tr>
					<td rowspan="6" align="center" bgcolor="F8F3DC" width="20">
					��<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��</td>
					<td rowspan="4" align="center" bgcolor="F8F3DC" width="40">
					��<br>
						��<br>
						��<br>
						��</td>
					<td bgcolor="#FFFFFF">�ֹε�ϵ</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>���س⵵ �ű� �Ǵ� ��� �Ի��� �ٷ���</td>
							</tr>
							<tr>
								<td>-</td>
								<td>���س⵵�� ����������� ������ �ִ� �ٷ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>(�ڳ���� ��)</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- ��û �Ǵ� ���繫��</td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">������������</td>
					<td valign="top" bgcolor="#FFFFFF">- �������谡 �ֹε�ϵ���� Ȯ�ε��� �ʴ� ���<br>
					<font color="#0033CC">&nbsp;&nbsp;* �ξ��� ���������� �ְŸ� �Բ� ���� �ʴ� ��쿡 �ش�<br>
					&nbsp;&nbsp;&nbsp;��</font></td>

					<td valign="top" bgcolor="#FFFFFF">- ��û �Ǵ� ���繫��</td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">�Ͻ������ ���Ű�����Ȳǥ<br>
						<span class="tit_f10">(���С���硤��������������� ÷��)</span></td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>�����ڸŰ� ����, ������ ���, �ٹ��� �Ǵ� �������
									�������� �Ͻ�����Ͽ� �ֹε�ϵ���� Ȯ�ε��� �ʴ� ���</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- ������ �ۼ�<br>* <A  href="/common/downloadFile.jsp?FILE_NAME=2007form.xls&FILE_URL=<%=fileDownLoadPath%>/2007form.xls"  target=_blank><font color="#FF0000">���ĺ���</font></a></td>
				</tr>
				<tr>
					<td valign="top" bgcolor="#FFFFFF">����������</td>
					<td valign="top" bgcolor="#FFFFFF">���α��ʻ�Ȱ���� ������</td>
					<td valign="top" bgcolor="#FFFFFF">- �� ���� �����繫��</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
						��<br>��<br>��
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						��������� �Ǵ�<br>
						����ε����(��ø) �纻,<br>
						��������
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td>���� �Ǵ� �ξ簡����</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>�� ����κ������� ���� �����<br>
									�� ������ �� �׽� ġ�Ḧ ���ϴ� ����ȯ�ڷμ� �ٷδɷ�<br>
									&nbsp;&nbsp;&nbsp;&nbsp;�� ���� ��<br>
									<font color="#FF0000">* ����ȯ���� ��� �ݵ�� ��� �ǻ��� ������ ��<br>
									&nbsp;&nbsp;"����� ����" ÷���ؾ� ��<br>
									&nbsp;&nbsp;(�ǰ�������� ������ ��ü �Ұ�����)</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- �Ƿ��� �Ǵ�<br>
						&nbsp;&nbsp;�� ���� �����繫��</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">�γ���</td>
					<td valign="top" bgcolor="#FFFFFF">������������</td>
					<td valign="top" bgcolor="#FFFFFF">- ���س⵵ 12���� �������� ȥ�νŰ� �� �����ٷ���</td>
					<td valign="top" bgcolor="#FFFFFF">- ��û �Ǵ� ���繫��</td>
				</tr>
				<tr>
					<td colspan="2" align="center" bgcolor="F8F3DC">
					���ݺ����<br>
						�ǰ�/���<br>
						����� </td>
					<td valign="top" bgcolor="#FFFFFF"></td>
					<td bgcolor="#FFFFFF">- ���κδ� ���Ծ׿� ���Ͽ� ȸ�翡�� �ϰ�ó����.
						<br>&nbsp;&nbsp;(�������� ��õ¡�� ������ �� ¡���θ� ������ ���<br>
						&nbsp;&nbsp;&nbsp;&nbsp;���Ծ� �ջ��.)</td>
					<td valign="top" bgcolor="#FFFFFF"></td>
				</tr>
				<tr>
					<td rowspan="5" align="center" bgcolor="F8F3DC">
						Ư<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��
					</td>
					<td align="center" bgcolor="F8F3DC">�����</td>
					<td bgcolor="#FFFFFF">����ᳳ������(������)</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>����/����/���غ���, ������� �� ���强 ������ ����Ḧ <br>
									������ �ٷ��� </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>�� �Ϲݺ���� ��������뺸�� ����</td>
							</tr>
						</table>

					</td>
					<td valign="top" bgcolor="#FFFFFF">- �ش� �������<br>
					<A  href="/common/downloadFile.jsp?FILE_NAME=2010Iform01.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform01.doc"  target=_blank><font color="#FF0000">���ĺ���</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">�Ƿ��</td>
					<td valign="top" bgcolor="#FFFFFF">
					�Ƿ�����޸��� ��<br>
						�����Ƿ�񿵼���,<br>
						����� ���屸 ��<br>
						���Կ�����</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10"><font color="#FF6600">-</font></td>
								<td colspan="3"><font color="#FF6600">���� �Ƿ�� �ѱ޿����� 3% �ʰ��Ͽ�
									������ �ٷ���</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td width="10">��</td>
								<td colspan="2">���ʰ��� ������ �ʿ����.</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>��</td>
								<td colspan="2">�Ϲݰ����Ƿ��� ���Ρ�����ڡ�������Ƿ�񱸺��ؾ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#FF6600">��</font></td>
								<td colspan="2"><font color="#FF6600">2004�� ����������� �Ƿ�񿵼�����
									���� ��������� ��ȭ�Ǿ� ���̿����� �����ȵ�.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>�Ƿ��,������: �����(������) ���� ����Ȯ�μ�</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">�� &quot;�������޾�, �ſ�ī�����, ���ݿ����� ����&quot;<br>
									&nbsp;&nbsp;&nbsp; ���� ���� ������ ��</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>��û��(����� ���屸) ���Ժ��: ���� ������</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">�� �Ǹ��ڰ� &quot;������� ����&quot;�� Ȯ�� ������ ��</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>�Ȱ�(����) ���Ժ��: ���� ������</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">�� �Ȱ�簡 &quot;������� ����&quot; �� &quot;�÷±�����&quot;����
									<br>
									&nbsp;&nbsp;&nbsp; Ȯ�� ������ ��</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td valign="top">*</td>
								<td>�Ƿ�뱸 ����(����)���: �ǻ� ó������ �Ƿ�񿵼���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">�� �Ǹ���(�Ӵ���)�� �����ϰ� &quot;�Ƿ� �뱸��&quot;��
									<br>
									&nbsp;&nbsp;&nbsp; ����� ��</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- �Ƿ���, �౹, �Ȱ���,<br>
						&nbsp;&nbsp;����� ���屸 ��<br>
						&nbsp;&nbsp;�Ƿ�뱸 �Ǹ�ó<br><br>
					- ���ΰǰ��������<br>
					&nbsp;&nbsp;<a href="http://www.nhic.or.kr" target="_blank">(www.nhic.or.kr)</a>
					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform02.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform02.doc"  target=_blank><font color="#FF0000">���ĺ���</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">������</td>
					<td valign="top" bgcolor="#FFFFFF">
					������볳�Կ�����,<br>
						�п��������Կ�����,<br>
						�����ݳ��Կ�����,<br>
						������������</td>
					<td valign="top" bgcolor="#FFFFFF"> - �ڳ�, �����, �����ڸŰ� ��ġ�� �������ü� �� �ʡ��ߡ���
						<br>&nbsp;&nbsp;���п� �������� �ٷ��� (�����Ư��/��Ȱ ���� ����)<br>
						- ������ �Ƶ��� �缳�п� �� ü���ü��� �����ϴ� �ٷ��� <br>
						- �ٷ��� ������ ���С����п��� ���� ���� ��(�����ɷ� ����<br>
						&nbsp;&nbsp;�� ����)<br>
					<td valign="top" bgcolor="#FFFFFF">- ������� �� �б����п�					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform03.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform03.doc"  target=_blank><font color="#FF0000">���ĺ���</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					��<br>
						��<br>
						��<br>
						��</td>
					<td valign="top" bgcolor="#FFFFFF"> �ֹε�ϵ(������ ����)<br>
						�� ���ø������ೳ������,<br>
						�����ڱݻ�ȯ����,<br>
						<span class="tit_f10">��������������Ա����ڻ�ȯ����,</span><br>
						<font color="#0033CC">(������� �ǹ� ���ε �� 2006.1.1 ���� ���Ա��� ��� ���ñ��ؽð� �������� ÷��)
						<br><br><br><br><br><br><br>
						�� ���ؽð� 3��� ���� ������ 2006.1.1 ���� ���డ���� �� �����ڸ� �ش��.</font>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td colspan="2">���ø�������</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top" width="10">��</td>
								<td>�������� �Ǵ� ���ؽð� 3��� ���� �������ñԸ��� 1���� �����ڷμ� �������� �ٷ��� ���θ��Ƿ�</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>û������(�� ���Ծ� 10���� ������ ��), �ٷ������ø�������, ������ø�������(�б� ���Ծ� 	300���� ������ ��)�� �������ϴ� ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* ���� : û��α�, �Ͻÿ�ġ�� û�࿹��, �����<br>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���úα�(��������)</font>
								</td>
							</tr>
							<tr>
								<td>-</td>
								<td colspan="2">�����������Ա� ������ ��ȯ</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>��</td>
								<td>�������� �ٷ��� ���θ��Ƿ� </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>���� ���ø�������� �����Ͽ� ���ؽð� 3��� ���� �������ñԸ��� ������ �����ϱ� ���� ������ �ݾ��� ��ȯ�ϴ� ���(2008.1.1���� ��������)</td>
							</tr>
							<tr>
								<td>-</td>
								<td colspan="2">��������������Ա� ���ڻ�ȯ (�������)</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>��</td>
								<td>�������� �ٷ��� ���θ��Ƿ� </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>���ؽð� 3��� ���� �������ñԸ��� ������ ����ϱ� ���Ͽ� ���ÿ� �� ������� �����ϰ� ����������������ñ�����κ��� ������ �ݾ��� ���ڻ�ȯ�ϴ� ��� <br>
								(��, ���θ����� ���ÿ� ���θ��Ƿ� ����� ���� / ��ȯ�Ⱓ 15�� �̻�) </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#0033CC">*</font></td>
								<td><font color="#0033CC">��ȯ���� �ܿ� ��������������Ա� ����� �Ǵ� ������ ���ε �� �������������� ÷���ؾ� ��</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
					- �ش� �������, <br>
						&nbsp;&nbsp;�� ���� �����繫��, ����<br><br>
					- �Ǳ��� �ε��� ����<br>
					&nbsp;&nbsp;���� �˸���<br>
					&nbsp;<a href="http://www.realtyprice.or.kr" target="_blank">(www.realtyprice.or.kr)</a>
					<br>���ĺ���<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform04.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform04.doc"  target=_blank><font color="#FF0000">�����ڱݻ�ȯ����</font></a>
					<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform05.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform05.doc"  target=_blank><font color="#FF0000">��������������Ա����ڻ�ȯ����</font></a></td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">��α�</td>
					<td valign="top" bgcolor="#FFFFFF">
					��α����޸��� ��<br>
						������αݿ�����,<br>
						�ֹ���û ��ϼ���</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">-</td>
								<td colspan="2">�ٷ��� ���θ��Ƿ� ������ ��α��� �ִ� ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>������α�(���װ���): ������������ġ��ü ��α�, ����<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��� ��</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>������α�(20%�ѵ��������): ������ü ��α�, �ҿ�<br>	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�̿����� ��<br>
								�� ������ü ��α� (10% �ѵ����� ����)</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* ������ü�� ��� ��ο����� �ܿ� �� ��ȸ �Ǵ� �߾�ȸ ���� �ֹ���û��
									��ϵǾ����� ���� �ϴ� �������� ÷���ؾ� ��</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><font color="#FF6600">��</font></td>
								<td><font color="#FF6600">2004�� ����������� ��αݿ������� ���� ��������� ��ȭ�Ǿ�
									�ż��� &quot;���� ��45ȣ�� 2 ����&quot;�� ���� ������������ ������.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#0033CC">* ��ġ�ڱ� ��α��� ��ġ���� ���ɿ��� ���ϴ� ������ �������� ����.</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- ��α� �������<br>
					<a  href="/common/downloadFile.jsp?FILE_NAME=2010Iform06.doc&FILE_URL=<%=fileDownLoadPath%>/2010Iform06.doc"  target=_blank><font color="#FF0000">���ĺ���</font></a></td>
				</tr>
				<tr>
					<td rowspan="5" align="center" bgcolor="F8F3DC">
					��<br>
						��<br>
						Ư<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��<br>
						��</td>
					<td align="center" bgcolor="F8F3DC">(����)<br>
						����</td>
					<td valign="top" bgcolor="#FFFFFF">(����)�������ೳ������</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>�ٷ��� ���θ��Ƿ� ���ο��� (2000.12.31 ���� ���Ժ�) �Ǵ� ��������(2001.1.1 ���� ���Ժ�)�� �����ϰ� �����Ծ��� ������ ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td><font color="#FF6600">* ȸ�翡�� ��ü������ (����)�������࿡ ���� ����������
									<br> &nbsp;&nbsp; �������� ����.</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td class="tit_f10">&nbsp;&nbsp;&nbsp;<font color="#FF6600">(���ѻ��� : �������� 55��
									���� �� / ���� : Ʈ���ÿ��� ��)</font></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF">- �ش� �������</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					     ����<br>
						����<br>
						����</td>
					<td valign="top" bgcolor="#FFFFFF">
					����(����)Ȯ�μ�,<br>
						���ڵ�ҵ������û��</td>
					<td valign="top" bgcolor="#FFFFFF">
					- �ٷ��� ���θ��Ƿ� �������� � ���� ����(����)�� ���</td>
					<td valign="top" bgcolor="#FFFFFF">
					- �߼ұ��û �Ǵ�<br>
						&nbsp;&nbsp;���� ���հ�����</td>
				</tr>
				<tr>
					<td align="center" bgcolor="F8F3DC">
					     ��<br>
						��<br>
						ī<br>
						��</td>
					<td valign="top" bgcolor="#FFFFFF">
					�ſ�ī�� �� ���ݾ� Ȯ�μ�, <br>
						���ݿ����� ���ݾ� Ȯ�μ�, <br>
						�п������� ���γ��� Ȯ�μ�</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top"><font color="#FF6600">-</font></td>
								<td colspan="2"><font color="#FF6600">���� �ſ�ī��(���ݿ����� ����)�� �ѱ޿�����
									25% �ʰ��Ͽ� ������ �ٷ���<br>
									���� ����ī�带 �ѱ޿��� 25%�ʰ��Ͽ� ������ �ٷ���</font></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>��</td>
								<td>���ʰ��� ������ �ʿ����. </td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">��</td>
								<td>���ΰ� ���踦 �����ϸ� �ҵ��� 100���� ������ ����� �� ����������� ����� ī��(���ݿ����� ����)�ݾ� �� �п��� ���γ��ξ��� �ִ� ���</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><font color="#FF6600">* �����ڸſ� ���� ���ݾ��� ���ܵ�.</font></td>
							</tr>
						</table>
						<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - �ش� ī��ȸ�� �� �п�,<br>
						&nbsp;&nbsp;���ݿ����� Ȩ������</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
					
					     �ұ��<br>
						/<br>					     
						�һ�<br>
						����<br>
						����<br>
						�α�

						</td>
					<td valign="top" bgcolor="#FFFFFF">
					�����αݳ�������</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td colspan="2">�ٷ��� ������ �Ի��� �Ǵ� ������ �ұ�����һ���� ������ �����Ͽ� 2012�� 12�� 31�ϱ��� �����ϴ� �����α�</td>
							</tr>
						</table>
						<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - �߼ұ���߾�ȸ</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
						���<br>
						�ֽ���<br>
						�ݵ�<br>
						�ҵ�<br>
						����<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF">
				    ����ֽ����ݵ�<br>�ҵ���� Ȯ�μ�</td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td colspan="2">2008�� 10�� 20�� ���� ����ֽ����ݵ�(������)�� ������ ���<br>�Ǵ� �̹� ������ �ݵ��� ���� ����� 3�� �̻� �����ϰ�<br>����� ������ ��� ���Ծ� ����</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - �ش� �������<br>
					2010.01.01. ���� �����ڴ� �ش� ������� ����</td>
				</tr>

				<tr>
					<td align="center" bgcolor="F8F3DC">
					��<br>
						��<br>
						��<br>
						��</td>
					<td align="center" bgcolor="F8F3DC">
					��<br>
						��<br>
						��<br>
						��<br>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> �����ڱ����ڼ��װ�����û�� <br>
						<span class="tit_f10">(�̺о�����Ȯ�μ�, <br>
						���Ա����ڻ�ȯ����, <br>
						�ŸŰ�༭, ���ε ÷��)</span></td>
					<td valign="top" bgcolor="#FFFFFF">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10" valign="top">-</td>
								<td>������ �Ǵ� 1���� �����ڷμ� �������� �ٷ��� ���θ��Ƿ�
									��95.11.1~��97.12.31 �Ⱓ �� ���� ���� ������ <u>�̺о�����</u>�� ��桤�����ϱ� ���Ͽ� ����
									������� ���ڸ� ��ȯ�ϴ� ���</td>
							</tr>
						</table>
					</td>
					<td valign="top" bgcolor="#FFFFFF"> - ������ġ��ü������,<br>
						&nbsp;&nbsp;�ش� �������</td>
				</tr>
			</table>


</div>

</BODY>
</HTML>
