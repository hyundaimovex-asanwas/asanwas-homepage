<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.reservation.dao.RoomInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Room_bean"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String start_ymd = request.getParameter("start_ymd");				//출발일자
	String weekend_yn = request.getParameter("weekend_yn");			//주말여부

	//숙소조회를 위한 param bean 생성
	Room_bean param = new Room_bean();
	Room_bean[] result = null;

	//숙소조회를 위한 함수생성
	RoomInfo info = new RoomInfo();

	//파라메터 세팅
	param.setStart_ymd(start_ymd);		//선택된일자
	param.setSaup_sid(saup_sid);				//관광지
	param.setGoods_sid(goods_sid);			//관광품목

	try {
		//프로시져 호출
		result = info.getHotelList(param);
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>금강산 예약</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script src="<%=imageServer%>/tour_common/prototype.js">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
#btn {
	position:absolute;
	left:630;
	top:432;
	width:128;
	height:27;
	z-index:1;
}
-->
</style>
<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<script language="javascript">

	var room_info = new Array();

	//자바스크립트 TRIM()
	function trim(str) {
		re = /^\s+|\s+$/g;
		return str.replace(re,'');
	}

	//객실수를 선택할때마다 호출
	//1. 선택한 객실수가 0일경우 기존의 예약 방목록에서 제거
	//2. 선택한 객실수가 0보다 클경우 예약 방목록에 추가
	//3. 모두 선택한 객실수가 4보다 클경우 에러메시지와 동시에 해당예약실 0 초기화
	function chkRoomCnt(obj,room_sid,max_p,cnt) {
		var total_sel_room_cnt = 0;

		var room_info = document.getElementsByName("room");		//전체룸의 현재 선택된 객실정보 가져오기
		var sel_room_sid = $('sel_room_sid').value;							//선택한 룸SID객체에 변수저장
		var sel_room_list = new Array();											//룸SID 배열객체
		sel_room_list = sel_room_sid.split(",");
	
		//전체룸 계산
		for(var i=0 ; i<room_info.length ; i++) {
			total_sel_room_cnt += parseInt(room_info[i].value);
		}
		
		//선택한 객실수가 4이상일 경우
		if(total_sel_room_cnt > 4) {
			alert("1회 최대 4개 객실까지 선택가능합니다");
			obj.value = 0;
		} else {
			//객실을 선택하지 않았을 경우 (0을 선택했을 경우)
			if(cnt == 0) {
				sel_room_sid = "";
				var compare = "";

				for(var i=0 ; i<sel_room_list.length-1 ; i++) {
						compare = sel_room_list[i];
						if(compare != room_sid) {
							sel_room_sid += compare+",";						
						}
				}				
			} else if(cnt != 0) {
				var compare = "";
				var yn = 0;
				for(var i=0 ; i<sel_room_list.length ; i++) {
						compare = sel_room_list[i];
						if(compare == room_sid) {
							yn++;							
						}
				}
				if(yn == 0) {
					for(var i=0 ; i<cnt ; i++) {
						sel_room_sid = sel_room_sid + room_sid+",";					
					}
				}
			}
			alert(sel_room_sid);
			$('sel_room_sid').value = sel_room_sid;
			$('total_sel_room_cnt').value = total_sel_room_cnt;
		}
	}

	//호텔의 객실여부를 조회한다 Ajax
	function view_Detail(upjang_sid, upjang_nm) {
		var saup_sid = $('saup_sid').value;
		var goods_sid = $('goods_sid').value;
		var start_ymd = $('start_ymd').value;

		var param = "upjang_sid="+upjang_sid+"&saup_sid="+saup_sid+"&goods_sid="+goods_sid+"&start_ymd="+start_ymd;
    	$('sel_upjang_sid').value = upjang_sid;
		$('sel_upjang_nm').value = upjang_nm;

    	var ajax = new Ajax.Request(
    		"srch_room_info.jsp"
    			,{
    				method : "post"
    				,parameters : param				
    				,onSuccess : viewResult			
    				,onException: onException
    			}
    		);
		
		//location.href="srch_room_info.jsp?upjang_sid="+upjang_sid+"&saup_sid="+saup_sid+"&goods_sid="+goods_sid+"&start_ymd="+start_ymd;
	}

	//호텔 객실여부를 조회하여 디자인을 구성하는 함수
	function viewResult(xml) {
		var t = xml.responseXML;
		var result = t.getElementsByTagName("RESULT")[0];
		var cnt;
		var content = "";
		
		content += "<table cellpadding=0 cellspacing=0>\n";
		content += "	<tr>\n";
		content += "		<td width=105 align=center class=fs11><b class=res01>타입</b></td>\n";
		content += "		<td width=80 align=center class=res01>요금</td>\n";
		content += "		<td width=55 align=center class=res01>잔여</td>\n";
		content += "		<td width=59 align=center class=res01>신청</td>\n";
		content += "		<td width=60 align=center class=res02>소개</td>\n";
		content += "	</tr>\n";
		content += "	<tr>\n";
		content += "		<td colspan=5 height=1 bgcolor=#CCCCCC></td>\n";
		content += "	</tr>\n";
		content += "	<tr>\n";
		content += "		<td colspan=5 height=3></td>\n";
		content += "	</tr>";

		var sel_upjang_sid = $('sel_upjang_sid').value;

		//목록이 있으면
		if(result != null) {
			var lists = result.getElementsByTagName("LIST");
			cnt = lists.length;

			//방의 갯수가 0이면
			if(lists.length == 0) {
					content += "	<tr>";
					content += "		<td align=center height=18 bgcolor=#CECECE class=res03>조회된 객실이 없습니다</td>\n";
					content += "	</tr>";
			} else {
				for(var i=0 ; i<cnt ; i++) {
					var list = lists[i];
					var room_type_sid = list.getElementsByTagName("ROOM_SID")[0].firstChild.nodeValue+"";
					var room_type_nm = list.getElementsByTagName("ROOM_NM")[0].firstChild.nodeValue+"";
					var room_cnt = list.getElementsByTagName("CNT")[0].firstChild.nodeValue+"";
					var rsv_yn = list.getElementsByTagName("RSV_YN")[0].firstChild.nodeValue+"";
					var price = list.getElementsByTagName("PRICE")[0].firstChild.nodeValue+"";
					var max_p = list.getElementsByTagName("MAX_P")[0].firstChild.nodeValue+"";

					content += "	<tr onMouseOver=this.style.backgroundColor='#FFE9BB'; this.style.cursor='hand' onMouseOut=this.style.backgroundColor='#F8F8F8'>\n";
					content += "		<td height=18 class=res03 style='padding:0 0 0 5'>"+trim(room_type_nm)+"</td>\n";
					content += "		<td align=center  class=res03>"+trim(price)+"</td>\n";
					content += "		<td align=center  class=res03><span class=res05>"+trim(room_cnt)+"</span></td>\n";
					content += "		<td align=center>\n";
					content += "			<select name=room class=linemap_now style=\"width:33px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:돋움;\" onChange=chkRoomCnt(this,'"+trim(room_type_sid)+"','"+trim(max_p)+"',this.options[this.selectedIndex].value)>\n";
					
					var int_cnt = parseInt(room_cnt);
					if(int_cnt < 1) {
						content += "				<option value=0 selected>0</option>";
					}else if(int_cnt > 4) {
						content += "				<option value=0 selected>0</option>";
						content += "				<option value=1>1</option>\n";
						content += "				<option value=2>2</option>\n";
						content += "				<option value=3>3</option>\n";
						content += "				<option value=4>4</option>\n";
					} else {
						content += "				<option value=0 selected>0</option>";
						for(var j=1 ; j<(int_cnt+1) ; j++) {
							content += "				<option value="+j+">"+j+"</option>\n";
						}
					}

					content += "			</select>\n";
					content += "			<input type=hidden name='max_"+trim(room_type_sid)+"' value='"+trim(max_p)+"'>";
					content += "			<input type=hidden name='nm_"+trim(room_type_sid)+"' value='"+trim(room_type_nm)+"'>";
					content += "		</td>\n";
					content += "		<td align=center><img src=<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif onclick=javascript:open_info('"+sel_upjang_sid+"','"+trim(room_type_sid)+"') onMouseOver=this.style.cursor='hand'></td>\n";
					content += "	</tr>\n";
					content += "	<tr>\n";
					content += "		<td colspan=5 height=3></td>\n";
					content += "	</tr>\n";
				}
			}
		}	
	
		content += "</table>";
		//alert(content);
		document.getElementById("room_info").innerHTML = content;

		$('sel_room_sid').value = "";
		$('total_sel_room_cnt').value = 0;
	}

	//Ajax 로직에러시 처리함수
	function onException(err) {
		return;
	}

	//뒤로 가기
	function prevStep() {
		document.resv.action = "reservatio_step2.jsp";
		document.resv.submit();
	}

	//다음단계로 가기
	function nextStep() {
		var sel_room_sid = $('sel_room_sid').value;

		if(sel_room_sid == "") {
			alert("객실을 선택해주세요");
		} else {
			document.resv.action = "reservatio_step4.jsp";
			document.resv.submit();
		}
	}

	//호텔 및 객실정보보기
	function open_info(upjang_sid, room_sid) {
		window.open("reservatio_step3_pop.jsp?upjang_sid="+upjang_sid+"&room_sid="+room_sid ,"info", "width=540, height=330");
	}
</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="goods_sid" value="<%=goods_sid%>">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="start_ymd" value="<%=start_ymd%>">
	<input type="hidden" name="weekend_yn" value="<%=weekend_yn%>">
	<input type="hidden" name="sel_upjang_sid">
	<input type="hidden" name="sel_upjang_nm">
	<input type="hidden" name="sel_room_sid">
	<input type="hidden" name="sel_room_nm">
	<input type="hidden" name="sel_room_max_p">
	<input type="hidden" name="total_sel_room_cnt" value=0>
<table cellpadding="0" cellspacing="0" height="470">
	<tr>
		<td width="770" height="65" bgcolor="3F667D">
			<table cellpadding="0" cellspacing="0" height="47" width="100%">
				<tr>
					<td style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle1.gif"></td>
					<td align="right" valign="bottom" style="padding-right:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle2.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--컨텐츠 시작-->
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td width="328" height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_02.gif"></td>
											<td valign="bottom"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_03.gif"></td>
										</tr>
										<tr>
											<td height="5"></td>
											<td></td>
										</tr>
										<tr>
											<td style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="308" height="132" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="306" height="130" bgcolor="F8F8F8">
																<tr>
																	<td><div style="overflow-y:scroll; width:306; height:130; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="125" align="center" class="fs11"><b class="res01">숙소명</b></td>
																				<td width="80" align="center" class="res01">객실</td>
																				<td width="62" align="center" class="res02">소개</td>
																			</tr>
																			<tr>
																				<td colspan="3" height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
<%
																String rsv_yn = "";
																if(result != null) {
																	for(int i=0 ; i<result.length ; i++) {
																		rsv_yn = result[i].getRsv_yn();
%>
																			<tr onMouseOver="this.style.backgroundColor='#FFE9BB'; this.style.cursor='hand'" onMouseOut="this.style.backgroundColor='#F8F8F8'" onClick="javascript:view_Detail('<%=result[i].getUpjang_sid()%>','<%=result[i].getUpjang_nm()%>')">
																				<td height="18" class="res03" style="padding:0 0 0 5"><%=result[i].getUpjang_nm()%></td>
																				<td align="center" <%if(rsv_yn.equals("Y")) {%>class="res03"<%}else{%>class="res04"<%}%>><%if(rsv_yn.equals("Y")) {%>예약가능<%}else{%>예약마감<%}%></td>
																				<td align="center"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step3_viewbt.gif" onclick="javascript:open_info('<%=result[i].getUpjang_sid()%>','')"></td>
																			</tr>
																			<tr>
																				<td colspan="3" height="3"></td>
																			</tr>
<%
																	}
																}
%>
																		</table>
																	</div></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
										  </td>
											<td style="padding:5 0 0 0">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="398" height="132" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="396" height="130" bgcolor="F8F8F8">
																<tr>
																	<td><div id="room_info" style="overflow-y:scroll; width:396; height:130; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																	</div></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
										  </td>
										</tr>
										<tr>
											<td valign="top" style="padding:0 0 0 10">
											</td>
											<td valign="top">
												<table width="100%" cellpadding="0" cellspacing="0">
													<tr>
														<td align="right">
															<div id="btn"><a href="javascript:prevStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a> <a href="javascript:nextStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></div></td>
													</tr>
											  </table>
											</td>
										</tr>
										<tr>
											<td height="10"></td>
											<td></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<!--컨텐츠 끝-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</form>
</body>
</html>
