<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Exception Message</title>
	<link href="../css/style.css" rel="stylesheet" type="text/css">

	<script language=javascript src="/common/common.js"></script>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
}
.style1 {color: #FF0000}
-->
</style>

<script>

var args = self.dialogArguments;

function fcOnload() {
	var errMsg = args.GLB_GDS.ErrorMsg;
	errMsg = errMsg.split("$");

	oMessage.value = errMsg[0];
	oStackTrace.value = errMsg[1];

}

function fcUnload() {

}

function fcBtnClose() {
	fcUnload();
	window.close();

}

</script>
</head>

<body onload="fcOnload()" border=0 onunload="fcBtnClose()">
<table width="529" border="0" cellpadding="0" cellspacing="0" bgcolor="D1DEE9">
  <tr>
    <td height="5" colspan="3"></td>
  </tr>
  <tr>
    <td width="5">&nbsp;</td>
    <td><table width="529" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
        <tr>
          <td align="center" valign="middle" bgcolor="#FFFFFF"> <table width="529" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td height="5" align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><img src="../images/common/up.gif"></td>
              </tr>
              <tr>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="18" align="center" valign="top"><img src="../images/common/icon_arrow.gif"></td>
                      <td> 시스템에 예기치 않은 오류가 발생하였습니다.<br>
                        [상세내역]의 내용을 복사하여 다음의 메일주소로 보내주시기 바랍니다. <br>
                        <font color="blue"><strong>담당자 : 전산팀 이동훈 과장 (02-3669-3753)</strong></font><br>
                        <font color="#FF9900"><strong>Email : andrew20@hdasan.com</strong></font>
                        </td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="5" height="18" align="center" valign="top">&nbsp;</td>
                      <td><strong><font color=43403B><img src="../images/common/icon.gif" width="14" height="14" align="absMiddle"></font></strong><font color=43403B><font color="#000000">오류내용</font></font>
                      </td>
                    </tr>
                    <tr>
                      <td align="center" valign="top">&nbsp;</td>
                      <td><textarea name="oMessage" cols="82" rows="2" class="inputB"></textarea></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="5" height="20" align="center" valign="top">&nbsp;</td>
                      <td><strong><font color=43403B><img src="../images/common/icon.gif" width="14" height="14" align="absMiddle"></font></strong>상세내역
                      </td>
                    </tr>
                    <tr>
                      <td align="center" valign="top">&nbsp;</td>
                      <td><textarea name="oStackTrace" cols="82" rows="6" class="inputB"></textarea></td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
                <td height="5" align="center">&nbsp;</td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td width="5">&nbsp;</td>
  </tr>
  <tr>
    <td height="5" colspan="3"></td>
  </tr>
</table>
</body>
</html>

