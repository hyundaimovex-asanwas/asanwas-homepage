<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>PLZ 이벤트</title>
<style type="text/css">
<!--
body {
	margin: 0px;
}
-->
</style>

<script>
function goEvent() {
	var form = document.eventFrm;

	if(form.a1.value.length <= 0 || form.a2.value.length <= 0 || form.a3.value.length <= 0) {
		alert("정답을 입력해 주세요.");
		return;
	} else if (form.a1.value.toUpperCase() != "P" || form.a2.value.toUpperCase() != "L" || form.a3.value.toUpperCase() != "Z") {
		alert("정답이 아닙니다.");
		return;
	} else if (form.name.value.length <= 0) {
		alert("이름을 입력해 주세요.");
		form.name.focus();
		return;
	} else if (form.hp2.value.length <= 0 || form.hp3.value.length <= 0) {
		alert("연락처를 입력해 주세요.");
		return;
	}

	form.submit();
}
</script>
</head>

<body>
<form name="eventFrm" method="post" action="/plz/event_ok.jsp" target="goAction">
<table width="490" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
    <td height="200" background="<%=imageServer%>/tour_img/plz/event/event_090418_03.jpg" style="padding-left:161px;padding-top:169px;background-repeat:no-repeat">
	<table>
		<tr>
			<td height="70" valign="top">
			<input name="a1" type="text" size="1" style="border:0px; width:26px; height:26px;font-size:29px; text-align:center;" maxlength="1" />
			<input name="a2" type="text" size="1" style="margin-left:10px; border:0px; width:26px; height:26px;font-size:29px; text-align:center;" maxlength="1" />
			<input name="a3" type="text" size="1" style="margin-left:11px; border:0px; width:26px; height:26px;font-size:29px; text-align:center;" maxlength="1" />
			</td>
		</tr>
	</table>
	</td>
  </tr>
  <tr valign="top">
    <td height="20" background="<%=imageServer%>/tour_img/plz/event/event_090418_01.jpg" style="padding-left:130px;padding-top:20px;background-repeat:no-repeat">
	<table width="256" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top" >
        <td height="25" colspan="5">
		<input type="text" name="name" />
		</td>
      </tr>
      <tr>
        <td width="54">
		<select name="hp1">
            <option value="010">010</option>
            <option value="011">011</option>
            <option value="016">016</option>
            <option value="017">017</option>
			<option value="018">018</option>
			<option value="019">019</option>
        </select></td>
        <td width="15">-</td>
        <td width="51"><input name="hp2" type="text" size="5" /></td>
        <td width="13">-</td>
        <td width="123"><input name="hp3" type="text" size="5" />        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><img src="<%=imageServer%>/tour_img/plz/event/event_090418_02.jpg" border="0" usemap="#Map" /></td>
  </tr>
</table>
</form>
<map name="Map" id="Map"><area shape="rect" coords="172,10,313,50" href="javascript:goEvent();" /></map></body>
<iframe name="goAction" width="0" height="0"></iframe>
</html>
