<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ page import="kr.co.imjk.reservation.dao.RoomInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Room_bean"%>

<%
	String upjang_sid = request.getParameter("upjang_sid");			//숙소ID
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String start_ymd = request.getParameter("start_ymd");				//출발일자

	//숙소조회를 위한 param bean 생성
	Room_bean param = new Room_bean();
	Room_bean[] result = null;

	//숙소조회를 위한 함수생성
	RoomInfo info = new RoomInfo();

	//파라메터 세팅
	param.setStart_ymd(start_ymd);		//선택된일자
	param.setSaup_sid(saup_sid);			//관광지
	param.setGoods_sid(goods_sid);			//관광품목
	param.setUpjang_sid(upjang_sid);		//숙소ID

	try {
		//프로시져 호출
		result = info.getRoomList(param);
		StringBuffer xml = new StringBuffer("");

		xml.append("<?xml version='1.0' encoding='EUC-KR'?>");
		xml.append("<RESULT>");
			
		if(result != null) {
			for(int i=0 ; i<result.length ; i++) {
				xml.append("<LIST>");
				xml.append("	 <ROOM_SID>");
				xml.append((result[i].getRoom_type_sid()).trim());
				xml.append("	 </ROOM_SID>");
				xml.append("	 <ROOM_NM>");
				xml.append((result[i].getRoom_type_nm()).trim());
				xml.append("	 </ROOM_NM>");
				xml.append("	 <CNT>");
				xml.append(result[i].getCnt());
				xml.append("	 </CNT>");
				xml.append("	 <RSV_YN>");
				xml.append(result[i].getRsv_yn());
				xml.append("	 </RSV_YN>");
				xml.append("	 <PRICE>");
				xml.append(result[i].getDouble_1());
				xml.append("	 </PRICE>");
				xml.append("	 <MAX_P>");
				xml.append(result[i].getMax_p());
				xml.append("	 </MAX_P>");
				xml.append("</LIST>");
			}
		}
		xml.append("</RESULT>");

		response.setContentType("text/xml; charset=euc-kr");
		response.getWriter().write(xml.toString());
		
		if(result != null) {
			for(int i=0;i<result.length;i++) {

			}
		}


	} catch(Exception e) {
		e.printStackTrace();
	}
%>



