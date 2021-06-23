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
					<a href="/include/agreement.jsp"><img src="<%=imageServer%>/tour_img/footer_02.gif"></a>
					<a href="/include/privacy.jsp"><img src="<%=imageServer%>/tour_img/footer_03.gif"></a>
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