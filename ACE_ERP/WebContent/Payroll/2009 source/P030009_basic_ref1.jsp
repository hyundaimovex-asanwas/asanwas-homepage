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
 * 최종수정일자	: 2007-12-04
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy = request.getParameter("eyy");		//귀속년도
    String eno = request.getParameter("eno");		//사번
%>

<html>
<head>
<title><%=eyy%>년 근로소득공제 인적공제 참고사항</title>
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
<SCRIPT language="JavaScript" src="imgs/web.js"></SCRIPT>
<SCRIPT language="JavaScript" src="imgs/06YearEntry.js"></SCRIPT>
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT>
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
			<td width="93">
				<div align="center"><font face="굴림">공제금액</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
		    <td width="40" bgcolor="#FFF8EE" rowspan=9>
				<div align="center"><font face="굴림">기본</font></div>
			</td>
			<td width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림">본 인</font></div>
			</td>
			<td colspan="2"><font face="굴림">모든 근로자 <br>
				</font></td>
			<td width="93">
				<div align="center"><font face="굴림">150만원</font></div>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
			<td width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림"> 배우자공제</font></div>
			</td>
			<td colspan="2"><font face="굴림"> 소득금액이 없거나 자산소득(근로,퇴직,이자,배당,기타소득 등)을<br>
				포함한 연간 소득금액의 합계액이 100만원 이하인 자<br>
				</font></td>
			<td width="93">
				<div align="center"><font face="굴림"> 150만원</font></div>
			</td>
		</tr>
		
		<tr bgcolor="#FFFFFF">
			<td rowspan="7" width="83" bgcolor="#FFF8EE">
				<div align="center"><font face="굴림">부양가족 </font></div>
			</td>
			<td colspan="2"><font face="굴림">근로자본인 및 배우자의 부양가족(연령 계산시 초일산입)으로서<br>
				연간 소득금액의 합계액이 100만원 이하인 자<br>
				</font></td>
			<td rowspan="7" width="93">
				<div align="center"><font face="굴림">150만원 </font></div>
				<p align="center"><font face="굴림">(1인당)<br>
					</font></p>
			</td>
		</tr>
		
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">자녀<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림">만 20세 이하(1989.1.1
				이후 출생)<br>
				당해연도중에 만 20세에 도달하더라도 공제가능함</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">부모<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림">남 : 만 60세 이상(1949.12.31
				이전 출생) <br>
				여 : 만 60세 이상(1949.12.31 이전 출생)</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">형제자매<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림">만 20세이하(1989.1.1
				이후 출생) 또는 <br>
				남 : 만 60세 이상(1949.12.31 이전 출생)<br>
				여 : 만 60세 이상(1949.12.31 이전 출생) </font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">생활보호<br>
					대상자</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림">국민기초생활 보장법 제2조 제2호의 수급자</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">장애인
				</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림">연령제한 없음<br> 
			직계비속 또는 입양자와 그 배우자가 모두 장애인에 <br>
			해당하는 경우 그 배우자도 포함.
			</font></td>
		</tr>
		<tr>
			<td width="65" bgcolor="#FFFFFF">
				<div align="center"><font face="굴림">위탁아동<br>
					</font></div>
			</td>
			<td width="359" bgcolor="#FFFFFF"><font face="굴림" color=#ff6633>만 18세 이하(1991.1.1
				이후 출생)<br>
				해당 과세기간에 6개월 이상 직접 양육한 위탁아동<br>
				당해연도중에 만 18세에 도달하더라도 공제가능함</font></td>
		</tr>
	  
	  <tr bgcolor="#FFFFFF">
	    <td width="40" bgcolor="#FFF8EE" rowspan=4>
			<div align="center"><font face="굴림">추가</font></div>
		</td>
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">경로우대공제 </font></div>
		</td>
		<td width="408" colspan="2" ><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 (배우자 포함) 중
		  <br>&nbsp;만 70세 이상(1939.12.31 이전 출생)
		  </font></td>
		<td width="86" valign="top">
		  <div align="center"><font face="굴림">
			100만원
			<br>(1인당)
			</font></div>
		</td>
	  </tr>
	   <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">장애인공제 </font></div>
		</td>
		<td width="408" colspan="2" ><font face="굴림">근로자 본인 또는 생계를 같이하는 부양가족 중 장애인이 있는
		  경우 <br>
		  (장애인의 범위) <br>
		  - 장애인복지법에 의한 장애인 <br>
		  - 국가유공자 등 예우 및 지원에 관한 법률에 의한 상이자 <br>
		  - 위의 상이자와 유사한 자로서 근로능력이 없는자 <br>
		  - 지병에 의하여 평상시 치료를 요하는 자가 그 치료기간이 1년 이상<br>
		  &nbsp;&nbsp;&nbsp;지속될 것이 예상되고 장애치료기간 동안에는 취학·취업이 곤란한 상태에<br>
		  &nbsp;&nbsp;&nbsp;있는 자(말기 암, 만성 신부전증환자 등)
		  <br>&nbsp;&nbsp;&nbsp;※ 의료기관 발행의 "장애인증명서" 첨부
		  </font></td>
		<td  valign="middle" align="center">
		  200만원<br>(1인당)
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">부녀자공제 </font></div>
		</td>
		<td width="408" colspan="2"><font face="굴림"> 배우자가 없는 여성근로자로서 기본공제를 적용받는 부양가족이 있는 <br>
						세대주이거나, 배우자가 있는 여성근로자인 경우(남편 소득 유무 무시)<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림">50만원 <br>
			<br>
			</font></div>
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="80" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림">자녀양육공제 <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="굴림">만 6세 이하의 직계비속이 있는 경우 <br>
		  (2003. 1. 1 이후 출생한 직계비속 또는 입양자,위탁아동) <br>
		  &nbsp;※ 유치원아, 영유아 및 취학전 아동의 교육비공제와 중복공제 적용
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림">100만원<br>
			(1인당) <br>
			</font></div>
		</td>
	  </tr>
	  <tr bgcolor="#FFFFFF">
		<td width="120" colspan="2" bgcolor="#FFF8EE">
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
	   <tr bgcolor="#FFFFFF">
		<td width="120" colspan="2" bgcolor="#FFF8EE">
		  <div align="center"><font face="굴림" >출산·입양자 공제 <br>
			</font></div>
		</td>
		<td width="408"  colspan="2" bgcolor="#FFFFFF"><font face="굴림">당해년도 출산·입양한 자녀가 있는 경우<br>
		  </font></td>
		<td width="86">
		  <div align="center"><font face="굴림"> 200만원<br>(1인당)
			</font></div>
		</td>
	  </tr> 
	</table>

</body>
</html>
