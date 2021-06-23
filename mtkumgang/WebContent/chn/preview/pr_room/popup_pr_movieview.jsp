<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%
  String img_name = new String();
  int board_seq = 0;
  img_name       = ParamUtil.getReqParameter(request.getParameter("img_name"));
  board_seq      = Util.parseInt(request.getParameter("board_seq"), 0);
  
	//조회수 증가
	CommonBoard commonDao = new CommonBoard();
    commonDao.updateReadnum(board_seq);  
%>




 
<script language="javascript">
  //대리점고객전용
  function Top_agent01(){
         var val = "http://toursales.hdasan.com/services/index.jsp?ut=A&c_sid=&c_id=";
	window.open(val,"agency","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
  //협력업체전용
  function Top_agent02(){
          var val = "http://toursales.hdasan.com/services/index.jsp?ut=C&c_sid=&c_id=";
	window.open(val,"agency","left=0,top=0,width=1024,height=630,fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,titlebar=1");
  }
</script>



<html>
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="http://www.mtkumgang.com/asanway/img//tour_common/common.css">
<script language="JavaScript" src="http://www.mtkumgang.com/asanway/img//tour_common/flash.js"></script>
</head>

<body class="popmargin">

<!-- 팝업사이즈 : 450 X 436 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td width="100%">
			<!-- / 타이틀 -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="65" class="bg_dgreen2">
			<tr valign="top">
				<td class="tpad_20 lpad_20"><img src="<%=imageServer%>/chn_img/preview/pop_tit_movview.gif"></td>
				<td align="right" class="tpad_20 rpad_15"><img src="<%=imageServer%>/chn_img/preview/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- 타이틀 / -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr><td height="29"></td></tr>
			<tr>
				<td style="padding:0 5 0 5" align="center"><!-- 동영상 -->
				
<%
  if(!img_name.equals("")){
%>				
				<script language="javascript">
					m_id = "mplayer";//동영상 아이디
					m_width = "320";//가로크기
					m_height ="240"; //세로높이
					//m_filename ="mms://211.49.227.161/00/01/57/81_x1_200.asf"; //동영상 파일명
					m_filename ="<%=img_name%>";
					m_control = "true"; // 컨트롤 보임설정
					m_start ="true"; // 자동플레이 설정
					m_transparent =""; //공백, transparent(투명)
					show_movie_F(m_id,m_width,m_height,m_filename,m_control,m_start,m_transparent);
				</script>
<%}else{%>
                등록된 동영상이 없습니다.
<%}%>

				</td>
			</tr>
			<tr><td height="22"></td></tr>
			<tr>
				<td align="center"><a href="javascript:;" onClick="window.close();"><img src="<%=imageServer%>/chn_img/preview/btn_pre_confirm.gif"></a><!-- 확인 --></td>
			</tr>
			<tr><td height="23"></td></tr>
			</table>

			
			<!-- 하단바  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dgreen2"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
