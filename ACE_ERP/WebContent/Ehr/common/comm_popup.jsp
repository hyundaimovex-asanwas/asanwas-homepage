<%@ page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Exception Message</title>
<link href="/css/style.css" rel="stylesheet" type="text/css">

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
    var errTitle    = args.title;
	var errMsg     = args.message;

    oTitle.innerText = errTitle;
	oMessage.value = errMsg;
}

function fcUnload() {
	/*var lo_Menu = args.top.oMenu;
	var ls_PgId = lo_Menu.oMenuGDS.NameValue(lo_Menu.oMenuGDS.RowPosition, "PROGRAM_ID");
	ls_PgId = ls_PgId.trim();

	if (ls_PgId != "") {
		lo_Menu.top.oMainContent.location.href = ls_PgId;
	} */
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
                <td align="center"><img src="../images/common/up2.gif"></td>
              </tr>
              <tr>
                <td align="center">&nbsp;</td>
              </tr>
              <tr>
                <td align="center"><table width="98%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="5" height="20" align="center" valign="top">&nbsp;</td>
                      <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><strong><img src="../images/common/icon.gif" width="14" height="14" align="absMiddle">&nbsp;</strong></td>
                                <td id="oTitle"></td>
                            </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td align="center" valign="top">&nbsp;</td>
                      <td><textarea name="oMessage" cols="82" rows="15" class="inputB"></textarea></td>
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

