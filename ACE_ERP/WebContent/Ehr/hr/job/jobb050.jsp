<!--
***********************************************************************
* @source      : jobb050.jsp
* @description : ������Ȳ�Ѱ�ǥ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/11      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<html>
<head>
<title>������Ȳ�Ѱ�ǥ(vluf037)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
***********************************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
***********************************************************************
-->
<script language="javascript" >

/**
 * ���� onload function
 */
function fnc_OnLoadProcess() {
	//Grid Style ����
	//cfStyleGrid(ds_TEST_MAIN, "comn", false);

	// ����÷�� �����ͼ��� ��� ���� ����.
	ds.setDataHeader("COL1:STRING, COL2:INT, COL3:INT, COL4:INT, COL5:INT, COL6:INT, COL7:INT, COL8:INT, COL9:INT, COL10:INT");
    ds.ImportData("'�ѹ���', 1, 1, 1, 2, 3, 4, 0, 0, 12");
}

</script>
</head>

<!--
***********************************************************************
* ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
***********************************************************************
-->

<!-- MAIN�� ���Ǵ� �����ͼ� -->
<object id="ds" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    <param name="Syncload" value="true">
</object>

<!-- �����ͼ� ��ȸ�� ������ ��� -->
<script language=JavaScript for=ds event=OnLoadCompleted(rowcnt)>
</script>

<!-- �����ͼ� ��ȸ�� ���� �߻��� ��� -->
<script language="javascript"  for="ds" event="OnLoadError()">
    cfErrorMsg(ds); //�����޽��� ó��.
</script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������Ȳ�Ѱ�ǥ</td>
                    <td align="right" class="navigator">HOME/�λ���/��������/�����̵�/<font color="#000000">������Ȳ�Ѱ�ǥ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<!-- ���� �Է� ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="120"></col>
                                <col width="240"></col>
                                <col width="120"></col>
                                <col width="240"></col>
                                <col width="*"></col>
                                <col width="80"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ٷα���&nbsp;</td>
                                <td class="">
									<select name="menu1" style="WIDTH: 40%" onChange="MM_jumpMenu('',this,0)">
										<option selected>�繫��</option>
										<option>�ù���</option>
									</select>
								</td>
                                <td align="right" class="searchState">������&nbsp;</td>
                                <td class="padding2423"><input name=txt size="12" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();"></td>
                                <td></td>
                                <td align="left"><img src="/images/common/searchBtn.gif" width="42" height="20" style="cursor:hand"></td>
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
        <td class="paddingTop15">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 00���� �ڷᰡ ��ȸ�Ǿ����ϴ�.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grd" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:310px;">
                            <param name="DataID"                  value="ds">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='COL1'         	width=100   name='�Ҽ�'          align=left </C>
                                <G> name='����'
	                                <C> id='COL2'         	width=70   name='����'          align=center </C>
	                                <C> id='COL3'         	width=70   name='�δ�'          align=center </C>
	                                <C> id='COL4'     		width=70    name='����'        align=center </C>
	                                <C> id='COL5'     		width=70    name='����'        align=center </C>
	                                <C> id='COL6'     		width=70    name='�븮'        align=center </C>
	                                <C> id='COL7'     		width=70    name='4��'        align=center </C>
	                                <C> id='COL8'     		width=70    name='5��'        align=center </C>
	                                <C> id='COL9'     		width=70    name='�ù���'        align=center </C>
	                            </G>
	                            <C> id='COL10'     		width=100    name='��'        align=center </C>
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
