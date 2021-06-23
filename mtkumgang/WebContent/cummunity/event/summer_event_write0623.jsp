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
#Layer1 {	position:absolute;
	left:282px;
	top:408px;
	width:208px;
	height:158px;
	z-index:1;
}
#Layer2 {	position:absolute;
	left:166px;
	top:337px;
	width:43px;
	height:36px;
	z-index:2;
}

-->
</style></head>
<body>
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="/asanway/img/summer_img/01.jpg" width="800" height="238"></td>
  </tr>
  <tr>
    <td><table width="800" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="554" rowspan="2"><table width="554" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="421" valign="top" background="/asanway/img/summer_img/02.jpg"><table width="554" height="388" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="44">&nbsp;</td>
                <td width="510" height="388" background="/asanway/img/summer_img/03.jpg"><div id="Layer1">
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
                                  <td width="50" align="right"><a href="#"><img src="/asanway/img/summer_img/btn_close.gif" width="9" height="9" border="0" /></a></td>
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
                  <div id="Layer2"><img src="/asanway/img/summer_img/ico_03.gif" width="35" height="30" /></div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td height="295" valign="top" background="/asanway/img/summer_img/04.jpg"><table width="246" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="75">&nbsp;</td>
          </tr>
          <tr>
            <td style="padding-left:7;"><input name="textfield" type="text" value="홍길동(hong)" size="20" class="txt">
              <br>
              <br>
              <textarea name="textfield2" cols="26" rows="13" class="txt">튜브에 여름 휴가 아이디어를 적어주세요. (최대 100글자)</textarea></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><img src="/asanway/img/summer_img/05.jpg" width="246" height="126" border="0" usemap="#done"></td>
      </tr>
    </table></td>
  </tr>
</table>

<map name="done">
<area shape="rect" coords="11,1,200,72" href="#" onFocus="this.blur()"></map></body>
</html>
