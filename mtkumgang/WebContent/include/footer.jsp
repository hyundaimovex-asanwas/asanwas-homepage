<script language="javascript">
function familyPop(val)
{
   if(val !=""){
     window.open(val,"family");
   }
}
</script>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="922">
				<table width="884" cellpadding="0" cellspacing="0" border="0" class="footer">
				<tr valign="top">
					<td width="104" height="20" rowspan="2"><a href="javascript:;" onClick="javascript:familyPop('http://www.hyundai-asan.com')"><img src="<%=imageServer%>/tour_img/footer_logo.gif"></a></td>
					<td width="645" class="tpad_3">
					<a href="/include/intro.jsp"><img src="<%=imageServer%>/tour_img/footer_01.gif"></a>
					<a href="/center/download/download_view.jsp"><img src="<%=imageServer%>/tour_img/footer_02.gif"></a>
					<a href="http://www.hdasan.com/nember/privacy.jsp" target="_blank"><img src="<%=imageServer%>/tour_img/footer_03.gif"></a>
					<a href="/include/contactus.jsp"><img src="<%=imageServer%>/tour_img/footer_04.gif"></a>
					<a href="http://baton.hdasan.com" target="_blank"><img src="<%=imageServer%>/tour_img/footer_080324.gif" border="0"></a>
					</td>
					<td width="135">
						<table width="132" height="17" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="center" style="background:url('<%=imageServer%>/tour_img/bgbox_select.gif');fixed no-repeat left top;">
								<script>
								var strCombo = ""
								+ "<select name='family' style='width:128px; height:15px;' onchange='javascript:familyPop(document.all.family.value);'>"
								+ "<option value='' selected>FAMILY SITE</option>"
								+ "<option value='http://www.hyundaigroup.com'>현대그룹</option>"
								+ "<option value='http://www.hyundai-asan.com'>현대아산</option>"
								+ "<option value='http://www.unikorea.go.kr'>통일부</option>"
								+ "<option value='http://www.knto.or.kr'>한국관광공사</option>"
								+ "<option value='http://tour.goseong.org'>고성관광</option>"
								+ "</select>";
								SS_write(strCombo, 6, '', 'up');
								</script> 
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="61" colspan="2" valign="top"><img src="<%=imageServer%>/tour_img/footer_right.gif"></td></tr>
				</table>
			</td>
			<td valign="top" style="padding-top:40px;"><a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top.gif"></a></td>
		</tr>
		</table>

<!--로거삽입 시작-->
<script type="text/javascript" charset="euc-kr" src="http://log.inside.daum.net/dwi_log/js/dwi.js"></script>
<script type="text/javascript" >
	_dwiPID="d-P9Y-226";
	if(typeof(_dwiCatch) == "function") { _dwiCatch();}
</script>
<!--로거삽입 끝-->




<!-- 호텔엔조이 관련 시작 2009-09-21 심동현 -->
<script language="javascript">
function showHotel(){//팝업으로 수정
//	document.all.hotelLayer.style.display='';
	window.open("http://www.plztour.com/reservation/hotelLayer3.html","hnj","width=800,height=600,top=20,left=20,scrollbars=yes,resizable=yes, status=yes");	//새창 띄워라. ()
}
</script>
<!-- 호텔엔조이 관련 끝 2009-09-21 심동현 -->

	

