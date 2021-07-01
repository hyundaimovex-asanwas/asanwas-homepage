<!--
***********************************************************************
* @source      : jobb050.jsp
* @description : 응답현황총괄표 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/11      오대성        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<html>
<head>
<title>응답현황총괄표(vluf037)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
***********************************************************************
* 자바스크립트 함수 선언부분
***********************************************************************
-->
<script language="javascript" >

/**
 * 공통 onload function
 */
function fnc_OnLoadProcess() {
	//Grid Style 적용
	//cfStyleGrid(ds_TEST_MAIN, "comn", false);

	// 파일첨부 데이터셋의 헤더 정보 설정.
	ds.setDataHeader("COL1:STRING, COL2:INT, COL3:INT, COL4:INT, COL5:INT, COL6:INT, COL7:INT, COL8:INT, COL9:INT, COL10:INT");
    ds.ImportData("'총무부', 1, 1, 1, 2, 3, 4, 0, 0, 12");
}

</script>
</head>

<!--
***********************************************************************
* 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
***********************************************************************
-->

<!-- MAIN에 사용되는 데이터셋 -->
<object id="ds" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
    <param name="Syncload" value="true">
</object>

<!-- 데이터셋 조회시 성공한 경우 -->
<script language=JavaScript for=ds event=OnLoadCompleted(rowcnt)>
</script>

<!-- 데이터셋 조회시 오류 발생한 경우 -->
<script language="javascript"  for="ds" event="OnLoadError()">
    cfErrorMsg(ds); //에러메시지 처리.
</script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">응답현황총괄표</td>
                    <td align="right" class="navigator">HOME/인사평가/직무관리/직무이동/<font color="#000000">응답현황총괄표</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<!-- 조건 입력 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="120"></col>
                                <col width="240"></col>
                                <col width="120"></col>
                                <col width="240"></col>
                                <col width="*"></col>
                                <col width="80"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">근로구분&nbsp;</td>
                                <td class="">
									<select name="menu1" style="WIDTH: 40%" onChange="MM_jumpMenu('',this,0)">
										<option selected>사무직</option>
										<option>택배직</option>
									</select>
								</td>
                                <td align="right" class="searchState">조사년월&nbsp;</td>
                                <td class="padding2423"><input name=txt size="12" maxlength="7" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();"></td>
                                <td></td>
                                <td align="left"><img src="/images/common/searchBtn.gif" width="42" height="20" style="cursor:hand"></td>
                             </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 00건의 자료가 조회되었습니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grd" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:310px;">
                            <param name="DataID"                  value="ds">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='COL1'         	width=100   name='소속'          align=left </C>
                                <G> name='직위'
	                                <C> id='COL2'         	width=70   name='부장'          align=center </C>
	                                <C> id='COL3'         	width=70   name='부대'          align=center </C>
	                                <C> id='COL4'     		width=70    name='차장'        align=center </C>
	                                <C> id='COL5'     		width=70    name='과장'        align=center </C>
	                                <C> id='COL6'     		width=70    name='대리'        align=center </C>
	                                <C> id='COL7'     		width=70    name='4사'        align=center </C>
	                                <C> id='COL8'     		width=70    name='5사'        align=center </C>
	                                <C> id='COL9'     		width=70    name='택배직'        align=center </C>
	                            </G>
	                            <C> id='COL10'     		width=100    name='계'        align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>
