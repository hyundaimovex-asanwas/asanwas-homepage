<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<style type="text/css">
<!--
.style1 {	color: #565656;	font-family: "돋움", Verdana;	font-size: 12px;}
.style2 {	color: #3F667D;	font-family: "돋움", Verdana;	font-size: 12px;font-weight: bold;}
.style3 {	color: #00A5D5;	font-family: "돋움", Verdana;	font-size: 11px;}
.style3_pt {	color: #000000;	font-family: "돋움", Verdana;	font-size: 11px;}
.style4 {	color: #000000;	font-family: "돋움", Verdana;	font-size: 11px;}
.style5 {	color: #565656;	font-family: "돋움", Verdana;	font-size: 12px;font-weight: bold;}
.style6 {	color: #00A5D5;	font-family: "돋움", Verdana;	font-size: 12px;}
.style6 {	color: #00A5D5;	font-family: "돋움", Verdana;	font-size: 12px;}
.table_bottom {	color: #3f667d;	font-family: "돋움", Verdana;	font-size: 14px; font-weight: bold;}
table,tr,td {font-size:12px;font-family:돋움;color:#666666;}
.table_l13 { padding-left:12px; }
.text_field {font-family:돋움 ;color:#666666; font-size:12px ;background-color:#ffffff; border: 1pt #c8c8c8 solid;height: 18px;}
.table_l131 {padding:0 12 0 12; }
-->
</style>
</head>

<body>
<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/tit_res01.gif"></td>
  </tr>
		<tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
  <tr>
    <td height="16">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="<%=imageServer%>/reservation/img/img_p_01.gif"></td>
  </tr>
		<tr>
    <td><img src="<%=imageServer%>/reservation/img/img_n_04.gif"></td>
  </tr>
</table>

<br>
<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="5"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="<%=imageServer%>/reservation/img/img_c_04_02.gif"></td>
          <td width="297"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="75"><img src="<%=imageServer%>/reservation/img/tab_01_on.gif"></td>
              <td width="76"><img src="<%=imageServer%>/reservation/img/tab_02.gif"></td>
              <td width="75"><img src="<%=imageServer%>/reservation/img/tab_03.gif"></td>
              <td width="71"><img src="<%=imageServer%>/reservation/img/tab_04.gif"></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="2" colspan="5" bgcolor="424242"></td>
  </tr>
  <tr>
    <td width="112" height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_01.gif"></td>
    <td height="26" colspan="4" class="table_l13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="19"><input name="radiobutton" type="radio" value="radiobutton"></td>
          <td width="128">금강산 2박 3일</td>
          <td width="19"><input name="radiobutton" type="radio" value="radiobutton"></td>
          <td width="147">금강산 1박 2일</td>
          <td width="19"><input name="radiobutton" type="radio" value="radiobutton"></td>
          <td>개성관광</td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_02.gif"></td>
    <td height="26" class="table_l13">
      <input name="textfield24" type="text" class="text_field" style="width:206px">
    </td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="112" height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_11.gif"></td>
    <td height="26" class="table_l13">대한민국</td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_03.gif"></td>
    <td height="26" class="table_l13">
      <input name="textfield22" type="text" class="text_field" style="width:96px">
-
<input name="textfield23" type="text" class="text_field" style="width:96px">
    </td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="112" height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_12.gif"></td>
    <td height="26" class="table_l13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="60"><a href="#"><img src="<%=imageServer%>/reservation/img/btn_act.gif" border="0" align="absmiddle"></a></td>
          <td>확인</td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_04.gif"></td>
    <td height="26" colspan="4" class="table_l13"><table width="345" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="245"><select name="select" class="text_field" style="width:57px">
            <option>1982</option>
          </select>
          년&nbsp;
          <select name="select2" class="text_field" style="width:43px">
            <option>01</option>
          </select>
          월
          &nbsp;
                <select name="select3" class="text_field" style="width:43px">
                  <option>01</option>
                </select>
          일 </td>
        <td><input name="radiobutton" type="radio" value="radiobutton"></td>
        <td>양력</td>
        <td><input name="radiobutton" type="radio" value="radiobutton"></td>
        <td>음력</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_05.gif"></td>
    <td height="26" colspan="4" class="table_l13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="209"><input name="textfield2" type="text" class="text_field" style="width:206px"></td>
          <td><img src="<%=imageServer%>/reservation/img/btn_zip.gif"></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_06.gif"></td>
    <td height="26" colspan="4" class="table_l13"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
          <input name="textfield5" type="text" class="text_field" style="width:206px"></td>
          <td><input name="textfield43" type="text" class="text_field" style="width:340px"></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
		
		<tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_07.gif"></td>
    <td height="26" class="table_l13">
      <select name="select4" class="text_field" style="width:53px;">
        <option>031</option>
      </select>
-
<input name="textfield42222" type="text" class="text_field" style="width:62px">
-
<input name="textfield42252" type="text" class="text_field" style="width:62px">
    </td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="112" height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_13.gif"></td>
    <td height="26" class="table_l13">
      <select name="select7" class="text_field" style="width:53px;">
        <option>018</option>
      </select>
-
<input name="textfield4222" type="text" class="text_field" style="width:62px">
-
<input name="textfield4225" type="text" class="text_field" style="width:62px">
    </td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_08.gif"></td>
    <td height="26" colspan="4" class="table_l13">
      <input name="textfield422342" type="text" class="text_field" style="width:98px">
@
<input name="textfield42242" type="text" class="text_field" style="width:90px">
&nbsp;
<select name="select5" style="width:112px; height:16px; font-size:11px">
  <option>선택하기</option>
</select></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_09.gif" ></td>
    <td height="26" class="table_l13">
    <input name="textfield6" type="text" class="text_field" style="width:206px"></td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="112" height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_14.gif"></td>
    <td height="26" class="table_l13"><input name="textfield42233" type="text" class="text_field" style="width:206px"></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" bgcolor="f7f7f7" class="table_l13"><img src="<%=imageServer%>/reservation/img/table_10.gif" ></td>
    <td height="26" colspan="4" class="table_l13"><input name="textfield42234" type="text" class="text_field" style="width:206px"></td>
  </tr>
  <tr>
    <td height="1" colspan="5" bgcolor="424242"></td>
  </tr>
		<tr>
		  <td height="66" colspan="5"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td rowspan="2" class="style3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td height="18" class="style3">* 함께 가시는 분 예약을 하시려면 <img src="<%=imageServer%>/reservation/img/info_img01.gif" align="absmiddle"> 를 클릭하세요. </td>
                  </tr>
                  <tr>
                    <td height="18">* <img src="<%=imageServer%>/reservation/img/info_img02.gif" align="absmiddle"> <span class="style3">를 클릭하시면 <span class="style3_pt">결제단계<span class="style3">로 이동합니다.</td>
                  </tr>
                </table>
                <br>              </td>
              <td width="159" class="style3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="82"><img src="<%=imageServer%>/reservation/img/btn_plus.gif"></td>
                  <td><img src="<%=imageServer%>/reservation/img/btn_save.gif"></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
          </table></td>
  </tr>
		<tr>
    <td colspan="5">&nbsp;</td>
  </tr>
</table>

<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" colspan="8"><img src="<%=imageServer%>/reservation/img/img_c_04_02_1.gif"></td>
  </tr>
  <tr>
    <td height="2" colspan="8" bgcolor="424242"></td>
  </tr>
  <!-- 테이블 복사 시작 -->
  <tr>
    <td width="33" height="26" align="center"><input type="checkbox" name="checkbox" value="checkbox"></td>
    <td width="85" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_01.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td width="240" height="26" class="style2" style="padding-left:13px">01</td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="85" height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_09.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td width="244" height="26" class="style2" style="padding-left:13px">홍길동</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_02.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">123456-1234879</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_10.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">1982년 00월 00일</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_03.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">남자</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_11.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">480-101</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_04.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" colspan="5" class="table_l13">경기도 의정부시 가능1동 </td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_05.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">031-888-8888</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_12.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">018-0000-0000</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_06.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" colspan="5" class="table_l13">hjb0929@nate.com</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_07.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">위지기립</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_13.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">고붕</td>
  </tr>
  <!-- 테이블 복사 끝 -->
  
  <tr>
    <td height="1" colspan="8" bgcolor="#424242"></td>
  </tr>
  <tr>
    <td width="33" height="26" align="center"><input type="checkbox" name="checkbox" value="checkbox"></td>
    <td width="85" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_01.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td width="240" height="26" class="style2" style="padding-left:13px">02</td>
    <td width="1" height="26" bgcolor="DDDDDD"></td>
    <td width="85" height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_09.gif"></td>
    <td width="1" height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td width="244" height="26" class="style2" style="padding-left:13px">홍길동</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_02.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">123456-7894561</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_10.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">1982년 00월 90일 </td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_03.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">홍길동</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_11.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">480-101</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_04.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" colspan="5" class="table_l13">경기도 의정부시 가능1동 </td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_05.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">031-888-8888</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_12.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">018-000-0000</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_06.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" colspan="5" class="table_l13">hjb0929@nate.com</td>
  </tr>
  <tr>
    <td height="1" colspan="8" bgcolor="#dddddd"></td>
  </tr>
  <tr>
    <td height="26" class="table_l13">&nbsp;</td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_07.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">위지그룹</td>
    <td height="26" bgcolor="DDDDDD"></td>
    <td height="26" class="table_l13"><img src="<%=imageServer%>/reservation/img/table02_13.gif"></td>
    <td height="26"><img src="<%=imageServer%>/reservation/img/line.gif"></td>
    <td height="26" class="table_l13">고붕</td>
  </tr>
    <tr>
    <td height="1" colspan="8" bgcolor="afafaf"></td>
  </tr>
		<tr>
		  <td height="33" colspan="8" align="right" bgcolor="f8f8f8" class="table_bottom" style="padding-right:28px">전체 예약인원 : 33명 </td>
  </tr>
		<tr>
		  <td height="2" colspan="8" bgcolor="424242"></td>
  </tr>
		<tr>
    <td height="12" colspan="8"  class="style3">&nbsp;</td>
  </tr>
		<tr>
    <td colspan="8" align="right"><table width="322" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="82"><a href="#"><img src="<%=imageServer%>/reservation/img/btn_modify.gif" border="0"></a></td>
        <td width="81"><a href="#"><img src="<%=imageServer%>/reservation/img/btn_alldel.gif" border="0"></a></td>
        <td width="82"><a href="#"><img src="<%=imageServer%>/reservation/img/btn_seldel.gif" border="0"></a></td>
        <td><a href="#"><img src="<%=imageServer%>/reservation/img/btn_buy.gif" border="0"></a></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
