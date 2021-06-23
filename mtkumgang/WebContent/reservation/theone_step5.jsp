<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="kr.co.imjk.reservation.dao.RoomInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Room_bean"%>

<%
	//����������---------------------------------------------
	String rname = request.getParameter("rname");	//�����ڸ�
	String rtel  = request.getParameter("rtel");	//�̸���
	String rmob  = request.getParameter("rmob");	//�ڵ���
	String rmail = request.getParameter("rmail");	//��ȭ��ȣ
	String rpass = request.getParameter("rpass");	//��й�ȣ

	String goods_sid = request.getParameter("goods_sid");					//������ǰ �ڵ�
	String saup_sid = request.getParameter("saup_sid");					//������ �ڵ�
	String start_ymd = request.getParameter("start_ymd");				//�������
	String weekend_yn = request.getParameter("weekend_yn");			//�ָ�����

	String sel_room_sid = "";															//����ID
	String sel_upjang_nm = "";															//ȣ�ڸ�
	String sel_upjang_sid = "";															//ȣ��ID

	String limit_ymd = "";																	//������縶������

	String[] arr_room_sid = null;
	String[] arr_room_nm = null;
	String[] arr_room_max = null;

	String room_nm = "";
	String max_person = "";
	String info_txt = "";


	//���ϰ����ϰ��
	if(goods_sid.equals("30") || goods_sid.equals("35") || goods_sid.equals("61")) {
		//������ȸ�� ���� param bean ����
		Room_bean param = new Room_bean();
		Room_bean[] result = null;

		//������ȸ�� ���� �Լ�����
		RoomInfo info = new RoomInfo();

		//�Ķ���� ����
		param.setStart_ymd(start_ymd);		//���õ�����
		param.setSaup_sid(saup_sid);				//������
		param.setGoods_sid(goods_sid);			//����ǰ��		

		try {
			//���ν��� ȣ��
			result = info.getHotelList(param);
		} catch(Exception e) {
			e.printStackTrace();
		}

		sel_upjang_sid = result[0].getUpjang_sid();
		sel_upjang_nm = result[0].getUpjang_nm();

		//������ȸ�� ���� param bean ����
		Room_bean room_param = new Room_bean();
		Room_bean[] room_result = null;

		//������ȸ�� ���� �Լ�����
		RoomInfo room_info = new RoomInfo();

		//�Ķ���� ����
		room_param.setStart_ymd(start_ymd);		//���õ�����
		room_param.setSaup_sid(saup_sid);			//������
		room_param.setGoods_sid(goods_sid);			//����ǰ��
		room_param.setUpjang_sid(sel_upjang_sid);		//����ID

		try {
			//���ν��� ȣ��
			room_result = room_info.getRoomList(room_param);
		} catch(Exception e) {
			e.printStackTrace();
		}

		arr_room_sid = new String[room_result.length];
		arr_room_nm = new String[room_result.length];
		arr_room_max = new String[room_result.length];

//		arr_room_sid[0] = room_result[0].getRoom_type_sid();
//		arr_room_nm[0] = room_result[0].getRoom_type_nm();
//		arr_room_max[0] = room_result[0].getMax_p();

		for(int i=0 ; i<arr_room_sid.length ; i++) {
			arr_room_sid[i] = room_result[i].getRoom_type_sid();
			arr_room_nm[i] = room_result[i].getRoom_type_nm();
			arr_room_max[i] = room_result[i].getMax_p();


			sel_room_sid += arr_room_sid[i]+",";
			room_nm += arr_room_nm[i]+",";
			max_person += arr_room_max[i]+",";
		}

	} else {
		sel_room_sid = request.getParameter("sel_room_sid");		//���õ� ��ID
		sel_upjang_nm = request.getParameter("sel_upjang_nm");	//���õ� ȣ�ڸ�
		sel_upjang_sid = request.getParameter("sel_upjang_sid");		//���õ� ȣ��ID

		arr_room_sid = sel_room_sid.split(",");
		arr_room_nm = new String[arr_room_sid.length];
		arr_room_max = new String[arr_room_sid.length];

		for(int i=0 ; i<arr_room_sid.length ; i++) {

			arr_room_nm[i] = request.getParameter("nm_"+arr_room_sid[i]);
			arr_room_max[i] = request.getParameter("max_"+arr_room_sid[i]);
			
			room_nm += arr_room_nm[i]+",";
			max_person += arr_room_max[i]+",";
		}
	}


	//��¥����� ���� �Լ�����
	DateUtils date = new DateUtils();

	Calendar cal = date.getCalenderYYYYMMDD(start_ymd);

	if(goods_sid.equals("61") || goods_sid.equals("62")) {	//plz �� 
		cal.add(Calendar.DATE,-3);
		limit_ymd = date.getYYYYMMDD(cal);
		info_txt="<span class=pagingon>"+limit_ymd.substring(0,4)+ "�� "+Integer.parseInt(limit_ymd.substring(4,6))+"�� "+Integer.parseInt(limit_ymd.substring(6,8))+"�ϱ���</span> ��������� �����ϼž� ������ Ȯ���˴ϴ�.";
	}else{
		limit_ymd = date.getYYYYMMDD(cal);
		cal.add(Calendar.DATE,-10);
		info_txt="<span class=pagingon>"+limit_ymd.substring(0,4)+ "�� "+Integer.parseInt(limit_ymd.substring(4,6))+"�� "+Integer.parseInt(limit_ymd.substring(6,8))+"�ϱ���</span> ������ ������ ��� �� ��������� �����ϼž� ������ Ȯ���˴ϴ�.";
	}


%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>����ƻ� �¶��� ���ࡡ����������������������������������������������������������������������������������������������������������</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
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
//-->
</script>

<script language="javascript">

	//�ֹε�Ϲ�ȣ ��ȿ�� �˻�
	function Validate(room_sid, idx_i, idx_j) {
		var jumin1 = eval("document.resv.jumin1_"+room_sid+"_"+idx_i+"_"+idx_j+".value");
		var jumin2 = eval("document.resv.jumin2_"+room_sid+"_"+idx_i+"_"+idx_j+".value");
		
		if(!JuminCheck(jumin1, jumin2)){
			alert("��Ȯ���� �ʴ� �ֹε�� ��ȣ�Դϴ�..");
			eval("document.resv.jumin1_"+room_sid+"_"+idx_i+"_"+idx_j+".focus()");
		} else {
			
		}
		
	}
	
	//�ֹε�Ϲ�ȣ üũ����
	function JuminCheck(jumin1, jumin2){
		check = false;
		total = 0;
		temp = new Array(13);

		for(i=1; i<=6; i++)
		temp[i] = jumin1.charAt(i-1);
		for(i=7; i<=13; i++)
		temp[i] = jumin2.charAt(i-7);
	 
		for(i=1; i<=12; i++){
			k = i + 1;
			if(k >= 10)
				k = k % 10 + 2;
			total = total + temp[i] * k;
		}
		mm = temp[3] + temp[4];
		dd = temp[5] + temp[6];

		totalmod = total % 11;
		chd = 11 - totalmod;
		if(chd == 11) {
			chd = 1;
		} else if(chd == 10) {
			chd = 0;
		}

		if(chd == temp[13] && mm < 13 && dd < 32 && (temp[7]==1||temp[7]==2||temp[7]==3||temp[7]==4))
			check=true;
		return check;
	}
	
	//�����ܰ�� ����
	function prevStep() {
		document.resv.action = "theone_step4.jsp";
		document.resv.submit();
	}

	//�����ܰ�� ����
	function nextStep() {
		var sel_room_sid = '<%=sel_room_sid%>';			//���õ� ���ǹ�ȣ
		var max_p = '<%=max_person%>';					//���� �ִ��ο�
		var arr_room_sid = sel_room_sid.split(",");
		var max_person = max_p.split(",");
//alert(sel_room_sid);
		var int_max = 0;
		var nm = "";						//�̸�
		var juminNo = "";				//�ֹε�Ϲ�ȣ
		var telNo = "";					//��ȭ��ȣ

		var total_person_info = "";						//�� ������
		var errorFlag = "true";						//����üũ Flag
		var reg_cnt = 0;					//�ش� ������ �� �����ο���

		for(var i=0 ; i<arr_room_sid.length ; i++) {
			int_max = parseInt(max_person[i]);
			reg_cnt = 0;
			
			for(var j=0 ; j<int_max; j++) {
				if(nm != "") {
					reg_cnt++;
				}
			}

			for(var j=0 ; j<int_max ; j++) {
				nm = eval("document.resv.nm_"+arr_room_sid[i]+"_"+i+"_"+j+".value");
				jumin = eval("document.resv.jumin1_"+arr_room_sid[i]+"_"+i+"_"+j+".value")+eval("document.resv.jumin2_"+arr_room_sid[i]+"_"+i+"_"+j+".value");
				tel_no = eval("document.resv.tel_first_"+arr_room_sid[i]+"_"+i+"_"+j+".value")+eval("document.resv.tel_second_"+arr_room_sid[i]+"_"+i+"_"+j+".value")+eval("document.resv.tel_third_"+arr_room_sid[i]+"_"+i+"_"+j+".value");

			
				//���̸��� ������ �Ķ���� ������ �������� �ʴ´�.
				if(nm != "") {
					if(jumin.length != 13) {
						alert("�ֹε�Ϲ�ȣ�� �߸� �ԷµǾ����ϴ�");
						eval("document.resv.jumin1_"+arr_room_sid[i]+"_"+i+"_"+j+".focus()");
						errorFlag = "false";
						break;	
					//��ȭ��ȣ ũ�Ⱑ �������
					} else if(tel_no.length <11) {
						alert("��ȭ��ȣ�� �߸� �ԷµǾ����ϴ�");
						eval("document.resv.tel_first_"+arr_room_sid[i]+"_"+i+"_"+j+".focus()");
						errorFlag = "false";
						break;						
					} else {
						total_person_info += "pinfo_"+arr_room_sid[i]+"_"+i+"_"+j+"_"+nm+"_"+jumin+"_"+tel_no+"_"+reg_cnt+",";
					}
				} 
			}
		}	
		
		if(errorFlag == "true") {
			document.resv.pinfo.value = total_person_info;
			document.resv.action = "theone_proc.jsp"; //"theone_step6.jsp";
			document.resv.submit();
		} else {
			
		}
	}

</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="rname" value="<%=rname%>">
	<input type="hidden" name="rtel" value="<%=rtel%>">
	<input type="hidden" name="rmob" value="<%=rmob%>">
	<input type="hidden" name="rmail" value="<%=rmail%>">
	<input type="hidden" name="rpass" value="<%=rpass%>">

	<input type="hidden" name="goods_sid" value="<%=goods_sid%>">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="start_ymd" value="<%=start_ymd%>">
	<input type="hidden" name="weekend_yn" value="<%=weekend_yn%>">
	<input type="hidden" name="sel_upjang_nm" value="<%=sel_upjang_nm%>">
	<input type="hidden" name="room_nm" value="<%=room_nm%>">
	<input type="hidden" name="sel_upjang_sid" value="<%=sel_upjang_sid%>">
	<input type="hidden" name="pinfo">
	<input type="hidden" name="foreigner_yn" value="N">
<table cellpadding="0" cellspacing="0" height="470">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/theone_l_title_1.gif" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--������ ����-->
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/reservation/img/theone_m_title_5.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td valign="top" style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step4_con.gif" align="absmiddle"> <%=info_txt%></td>
													</tr>
												</table>	
											</td>	
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td valign="top" style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="726" height="201" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="724" height="199" bgcolor="F8F8F8">
																<tr>
																	<td><div style="overflow-y:scroll; width:724; height:199; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td width="67" align="center" class="res01">�̸�</td>
																				<td width="219" align="center" class="res01">�ֹε�Ϲ�ȣ</td>
																				<td width="186" align="center" class="res01">����ó</td>
																				<td width="34"></td>
																				<td width="68" align="center" class="res01">����</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
<%
														try {
															int max_p = 0;
															for(int i=0 ; i<arr_room_sid.length ; i++) {
%>
																			<tr>
																				<td colspan="7">
																					<table width="100%" cellpadding="0" cellspacing="0">
																						<tr>
																							<td height="18" valign="middle" bgcolor="CECECE" class="res03" style="padding-left:10px;"><img src="<%=imageServer%>/tour_img/reservation/step4_icon2.gif" align="absmiddle"> <%=sel_upjang_nm%>  <%=arr_room_nm[i]%></td>
																						</tr>
																				  </table>
																				</td>
																			</tr>
																			<tr>
																				<td colspan="7" height="5"></td>
																			</tr>
<%
																max_p = Integer.parseInt(arr_room_max[i]);
																for(int j=0 ; j<max_p ; j++) {
%>
			
																			<tr>
																			  <td height="18" class="res03"><input name="nm_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" type="text" style="width:61px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
																				<td align="center" class="res03"><input name="jumin1_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" type="text" style="width:53px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" maxlength="6" size="6"> 
																				- <input name="jumin2_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" type="password" style="width:70px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" onBlur="javascript:Validate('<%=arr_room_sid[i]%>','<%=i%>','<%=j%>')" maxlength="7" size="7"></td>
																				<td align="center" class="res03"><select name="tel_first_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" class="linemap_now" style="width:50px; height:18; border:1px #EFB345 solid; color:#666666; font-size:11px; font-face:����;"  type="text">
                                                                                      <option value="010">010</option>
																					  <option value="011">011</option>
																					  <option value="016">016</option>
																					  <option value="017">017</option>
																					  <option value="018">018</option>
																					  <option value="019">019</option>
                                                                                  </select> - <input name="tel_second_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" maxlength=4> 
                                                                                  - <input name="tel_third_<%=arr_room_sid[i]%>_<%=i%>_<%=j%>" type="text" style="width:45px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;" maxlength=4></td>
																				<td width="74"></td>
																				<td align="center" class="res03"><div id=<%="price_gbn"+"_"+i+"_"+j%>></div></td>
																			</tr>
<%

																}
%>
																			<tr>
																				<td colspan="7" height="3"></td>
																			</tr>
<%
															}
														} catch (Exception e) {
															out.println(e);
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
										</tr>
										<tr>
											<td height="10"><div id="btn"><a href="javascript:prevStep()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a> <a href="javascript:nextStep()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></div></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<!--������ ��-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</form>
</body>
</html>
