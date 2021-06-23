<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.*"%>
<%@ page import="com.hmm.ejb.common.UtilDB"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>::금강산 여름휴가 프로젝트::</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.txt{font-family:돋움; font-size:11; border: 1 solid;}
.font{font-family:돋움; font-size:11;}
#Layer1 {
	position:absolute;
	left:282px;
	top:408px;
	width:208px;
	height:158px;
	z-index:1;
}
#Layer2 {
	position:absolute;
	left:205px;
	top:469px;
	width:61px;
	height:65px;
	z-index:2;
}
-->
</style></head>

<body>
<div id="Layer1">
  <table width="200" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="1" rowspan="3" bgcolor="#3B52B7"></td>
      <td height="1" bgcolor="#3B52B7"></td>
      <td width="1" rowspan="3" bgcolor="#3B52B7"></td>
    </tr>
    <tr>
      <td height="150" align="center" bgcolor="ffffff"><table width="180" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="180" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="130" height="20" class="font">홍길동(hong)</td>
              <td width="50" align="right"><a href="#"><img src="http://test1.hdasan.com/asanway/img/summer_img/btn_close.gif" width="9" height="9" border="0" /></a></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="1" bgcolor="#3B52B7"></td>
        </tr>
        <tr>
          <td height="110" valign="top" style="padding-top:10;">&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="1" bgcolor="#3B52B7"></td>
    </tr>
  </table>
</div>
<div id="Layer2"><img src="http://test1.hdasan.com/asanway/img/summer_img/tu_01_1.gif" width="63" height="55" /></div>
<table width="640" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="http://test1.hdasan.com/asanway/img/summer_img/01.jpg" width="640" height="351" /></td>
  </tr>
  <tr>
    <td height="329" align="center" background="http://test1.hdasan.com/asanway/img/summer_img/02.jpg"><table width="458" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="280" background="http://test1.hdasan.com/asanway/img/summer_img/05.jpg">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="640" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="491" align="right" valign="top" background="http://test1.hdasan.com/asanway/img/summer_img/03.jpg"><table width="410" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="75">&nbsp;</td>
          </tr>
          <tr>
            <td height="30" valign="top"><input name="textfield" type="text" value="홍길동(hong)" size="20" class="txt"></td>
          </tr>
          <tr>
            <td height="30" valign="bottom"><textarea name="textfield2" cols="50" rows="2" class="txt">튜브에 여름 휴가 아이디어를 적어주세요. (최대 100글자)</textarea></td>
          </tr>
        </table></td>
        <td align="right"><img src="http://test1.hdasan.com/asanway/img/summer_img/04.jpg" width="150" height="210" border="0" usemap="#go_event" /></td>
      </tr>
    </table></td>
  </tr>
</table>

<map name="go_event" id="go_event">
<area shape="rect" coords="1,47,69,140" href="#" onfocus="this.blur()">
</map></body>
</html>
