<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명	: 급여시스템
 * 프로그램ID 	: P030009_basic_ref
 * J  S  P		: 
 * 서 블 릿		: 
 * 작 성 자		: 정영식
 * 작 성 일		: 2007-12-04
 * 기능정의	    : 기본공제에 대한 설명   
 *                   
 *                   
 * 최종수정일자	: 2010-12-21   이 동 훈
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");		//귀속년도
    String eno = request.getParameter("eno");		//사번
%>

<html>
<head>
<title>2010년 근로소득공제 인적공제 참고사항</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>


<!-- 기존 가우스 시작-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<script language="javascript" src="imgs/web.js"></script>
<script language="javascript" src="imgs/06yearentry.js"></script>
<script language="javascript" src="imgs/applychk.js"></script>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //등록
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
	//var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

</script>

<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
    <br>
    <b><font face="굴림">&nbsp;&nbsp;&nbsp;※ 인적공제</a></font></b>
	<table width="640" border="0" cellspacing="1" cellpadding="2" bordercolor="#666666" bgcolor="#666666" align="center">
		<tr bgcolor="#FFF8EE">
			<td width="123" colspan=2>
				<div align="center"><font face="굴림">기본공제내역</font></div>
			</td>
			<td colspan="2" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림">공 제 대 상 내 역</font></div>
			</td>
			<td width="100">
				<div align="center"><font face="굴림">공제금액</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="40" bgcolor="#FFF8EE" rowspan=8>
				<div align="center"><font face="굴림">기본</font></div>
			</td>
			<td width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림">본 인</font></div>
			</td>
			<td colspan="2"><font face="굴림">모든 근로자 <br>
				</font></td>
			<td width="100">
				<div align="center"><font face="굴림">150만원</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림"> 배우자공제</font></div>
			</td>
			<td colspan="2"><font face="굴림"> 소득금액이 없거나 소득금액(근로,퇴직,이자,배당,기타소득 등)의<br>
				합계액이 100만원 이하인 자<br>
				</font></td>
			<td width="100">
				<div align="center"><font face="굴림"> 150만원</font></div>
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
			<td rowspan="6" width="100" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림">부양가족 </font></div>
			</td>
			<td colspan="2"><font face="굴림">근로자본인 및 배우자의 부양가족(연령 계산시 초일산입)으로서<br>
				연간 소득금액의 합계액이 100만원 이하인 자<br>
				</font></td>
			<td rowspan="6" width="100">
				<div align="center"><font face="굴림">150만원 </font><br>
				<font face="굴림">(1인당)
					</font></div>
			</td>
		</tr>






		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">직계비속<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="굴림">만 20세 이하(1990.1.1
				이후 출생)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">부모<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="굴림">만 60세 이상(1950.12.31
				이전 출생) </font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">형제자매<br>
					</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="굴림">만 20세 이하(1990.1.1
				이후 출생) 또는 <br>
				만 60세 이상(1950.12.31 이전 출생)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">생활보호<br>
					대상자</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="굴림">국민기초생활 보장법상 수급자</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">장애자</font></div>
			</td>
			<td width="360" bgcolor="#FFFFFF"><font face="굴림">연령제한 없음</font></td>
		</tr>
	  




	  <tr bgcolor="#FFFFFF">
	    <td width="40" bgcolor="#FFF8EE" rowspan=5>
			<div align="center"><font face="굴림">추가</font></div>
		</td>
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">경로우대공제 </font></div>
		</td>
		<td width="408" colspan="2" ><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 (배우자 포함) 중


		  <br>만 70세 이상(1940.12.31 이전 출생)
		  </font></td>
		<td width="86" valign="top">
		  <div align="center"><font face="굴림">

			100만원
			<br>(1인당)
			</font></div>
		</td>
	  </tr>
	   <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">장애인공제 </font></div>
		</td>
		<td width="408" colspan="2" ><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 중 장애자가 있는
		  경우 <br>
		  (장애자의 범위) <br>
		  - 장애인복지법상 장애인 <br>
		  - 상이자 <br>
		  - 상이자와 유사한 자로서 근로능력이 없는자 <br>
		  - 항시 치료를 요하는 중증환자
		  <br>&nbsp;&nbsp;&nbsp;※ "장애인증명서" 또는 "상이자증명서" 첨부
		  </font></td>
		<td  valign="middle" align="center">
		  200만원<br>(1인당)
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">부녀자공제 </font></div>
		</td>
		<td width="408" colspan="2"><font face="굴림"> 배우자가 없는 여성근로자로서 부양가족이 있는 세대주인 경우,<br>
						 배우자가 있는 여성근로자인 경우(남편 소득 유무 무시)<br>
		  </font></td>
		<td width="86"valign="middle">
		  <div align="center"><font face="굴림">50만원 
			</font></div>
		</td>
	  </tr>

	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">자녀양육비공제 <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="굴림">만6세 이하의 직계비속, 입양자, 위탁아동이 있는 경우 <br>
		  (2004. 1. 1 이후 출생자) <br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림">100만원<br>
			(1인당) <br>
			</font></div>
		</td>
	  </tr>

	  <tr bgcolor="#FFFFFF">
		<td width="100" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">출생/입양자 <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="굴림">기본공제대상 직계비속 또는 입양자<br>
		  - 해당 과세기간에 출생 또는 입양신고
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림">200만원<br>
			(1인당) <br>
			</font></div>
		</td>
	  </tr>


	  <tr bgcolor="#FFFFFF">
		<td width="140" colspan="2" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">다자녀추가 공제 <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="굴림">기본공제대상자녀가 2인 이상인 근로자의 경우<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림">50만원 + <br> (자녀수-2인) <br> * 100만원
			</font></div>
		</td>
	  </tr> 
	</table>

</body>
</html>
