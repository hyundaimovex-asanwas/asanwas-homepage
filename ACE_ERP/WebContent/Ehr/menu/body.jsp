<!--
*****************************************************
* @source       : body.jsp
* @description : MAIN PAGE :: 무제 문서
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      한학현        최초작성.
* 2006/09/12      김석두        Main 화면 Scroll 처리
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>
<head>
<title>body frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >

//메뉴관련 셋팅(child frame에서 사용)
var idColumn = "PGM_ID";//ID 컬럼명
var nameColumn = "PGM_NM";//해당 name 컬럼명
var levelColumn = "LEVEL";//해당 level 컬럼명
var flagColumn = "DIVIDE";//해당 flag 컬럼명

/********************************************
	* 13. Form Load 시 Default 작업 처리 부분  *
********************************************/
function fnc_OnLoadProcess(){
	ds_UserInfo.DataId="/menu/LeftMenu_data.csv";
	ds_UserInfo.Reset();
}

//상태 표시
function getWinStat(strID, winstat)
{
	//opener.frame.Provider("MDIManager1").FrameShow("showdefault");
}

//창안에서의 이벤트를 catch하여 해당 function을 call한다.
frame.SetEvent("onwinstat", getWinStat);

</script>
</head>

<!--
**************************************************************
* 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
**************************************************************
-->

<!-- 메뉴구성 및 권한 데이터셋-->
<comment id="__NSID__">
<object id=ds_UserInfo classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="css/general.css" rel="stylesheet" type="text/css">

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll="auto" >
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" background="/images/common/mainBg.gif" style="padding: 15 20 30 20">

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
    <tr valign="middle">
        <td align="center">
            <img src="/images/common/batang2.gif" width="434" height="429">
        </td>
    </tr>
</table>

<!--

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center"> <table width="210" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="11" height="24" align="center" valign="top" bgcolor="E8EED6"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
					<td align="center" valign="bottom" bgcolor="E8EED6" style="font-weight:bold">2006
						<img src="/images/specialHr/formTitle.gif" width="71" height="17" align="absmiddle"></td>
					<td width="11" align="center" valign="top" bgcolor="E8EED6"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="E8EED6">

            <!--평가정보테이블 시작 ->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
					<td height="11"></td>
					<td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center" valign="top" style="padding-bottom:11px;">
						<table width="775" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
									<img src="/images/specialHr/formT1.gif" width="46" height="15" align="absmiddle"> <B>(하반기)</B>
								</td>
							</tr>
							<tr>
								<td class="hrWtable" style="padding:10 6 6 6">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="25" align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT8.gif" width="116" height="20"></td>
										</tr>
										<tr>
											<td align="center"><img src="/images/specialHr/inputImg4.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg5.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
										</tr>
										<tr>
											<td height="23" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-04
												~ 2006-12-07</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-14
												~ 2006-12-16</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-22
												~ 2006-12-29</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<!--평가정보테이블 끝 ->

		</td>
	</tr>
	<tr>
		<td height="3"></td>
	</tr>
	<tr>
		<td bgcolor="E8EED6">

			<!--평가정보테이블 시작 ->
			<table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>&nbsp;</td>
					<td align="center" valign="top" style="padding-top:7px;">
						<table width="775" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
									<img src="/images/specialHr/formT2.gif" width="44" height="15" align="absmiddle">
								</td>
							</tr>
							<tr>
								<td class="hrWtable" style="padding:10 6 6 6">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="25" align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT3.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT7.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
											<td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
											<td align="center" valign="top" background="/images/specialHr/formLineBg.gif"><img src="/images/specialHr/inputT8.gif" width="116" height="20"></td>
										</tr>
										<tr>
											<td align="center"><img src="/images/specialHr/inputImg3.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg7.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg4.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg5.gif" width="116" height="80"></td>
											<td align="center"><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
										</tr>
										<tr>
											<td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-04 부터<br>2006-12-05 까지</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-06 부터<br>2006-12-07 까지</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-08 부터<br>2006-12-11 까지</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-14 부터<br>2006-12-16 까지</td>
											<td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">2006-12-22 부터<br>2006-12-29 까지</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                 		</td>
					<td width="11">&nbsp;</td>
				</tr>
				<tr>
					<td height="11" width="11"><img src="/images/specialHr/gridGreenLB.gif" width="11" height="11"></td>
					<td height="11"></td>
					<td><img src="/images/specialHr/gridGreenRB.gif" width="11" height="11"></td>
				</tr>
				<tr>
					<td colspan=2 ><font color="red">※ 본 화면은 평가 일정 정보를 보여주는 화면 입니다. </td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;<td>
				</tr>
				<tr>
					<td colspan=2 ><font color="blue">☞ 인사 평가 작업은 상단의 '인사평가' 메뉴를 클릭 후 왼쪽 트리 메뉴에 나타나는 [인사평가] 메뉴를 더블 클릭 하십시요!</td>
				</tr>
				<tr>
					<td colspan=2><font color="blue">&nbsp;&nbsp;&nbsp;해당 메뉴의 [역량평가] 또는 [업적평가] 메뉴에서 [자기평가진행정보]를 통해 작업 하세요!</td>
				</tr>
			</table>
			<!--평가정보테이블 끝 ->

		</td>
	</tr>
</table>

-->

		</td>
	</tr>
</table>
</body>
</html>